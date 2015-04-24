From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/2] connect: improve check for plink to reduce false positives
Date: Fri, 24 Apr 2015 22:28:25 +0000
Message-ID: <1429914505-325708-2-git-send-email-sandals@crustytoothpaste.net>
References: <20150423231403.GC274681@vauxhall.crustytoothpaste.net>
 <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 00:28:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylm5V-0006Cw-Na
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 00:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967146AbbDXW2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 18:28:40 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:46874 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967098AbbDXW2g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 18:28:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 82F16282A6;
	Fri, 24 Apr 2015 22:28:35 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267760>

The git_connect function has code to handle plink and tortoiseplink
specially, as they require different command line arguments from
OpenSSH.  However, the match was done by checking for "plink"
case-insensitively in the string, which led to false positives when
GIT_SSH contained "uplink".  Improve the check by looking for "plink" or
"tortoiseplink" (or those names suffixed with ".exe") in the final
component of the path.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 749a07b..c0144d8 100644
--- a/connect.c
+++ b/connect.c
@@ -724,7 +724,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
-			int putty;
+			int putty, tortoiseplink = 0;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			get_host_and_port(&ssh_host, &port);
@@ -750,14 +750,26 @@ struct child_process *git_connect(int fd[2], const char *url,
 				conn->use_shell = 1;
 				putty = 0;
 			} else {
+				const char *base;
+				char *ssh_dup;
+
 				ssh = getenv("GIT_SSH");
 				if (!ssh)
 					ssh = "ssh";
-				putty = !!strcasestr(ssh, "plink");
+
+				ssh_dup = xstrdup(ssh);
+				base = basename(ssh_dup);
+
+				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
+					!strcasecmp(base, "tortoiseplink.exe");
+				putty = !strcasecmp(base, "plink") ||
+					!strcasecmp(base, "plink.exe") || tortoiseplink;
+
+				free(ssh_dup);
 			}
 
 			argv_array_push(&conn->args, ssh);
-			if (putty && !strcasestr(ssh, "tortoiseplink"))
+			if (tortoiseplink)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
 				/* P is for PuTTY, p is for OpenSSH */
-- 
2.3.5
