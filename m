From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] connect: improve check for plink to reduce false positives
Date: Thu, 23 Apr 2015 00:06:35 +0000
Message-ID: <1429747595-298095-2-git-send-email-sandals@crustytoothpaste.net>
References: <20150422232306.GA32705@peff.net>
 <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 02:06:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl4fH-0005Il-RU
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 02:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965740AbbDWAGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 20:06:43 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44881 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965720AbbDWAGl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 20:06:41 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EDC0C282A6;
	Thu, 23 Apr 2015 00:06:39 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267671>

The git_connect function has code to handle plink and tortoiseplink
specially, as they require different command line arguments from
OpenSSH.  However, the match was done by checking for "plink"
case-insensitively in the string, which led to false positives when
GIT_SSH contained "uplink".  Improve the check by looking for "plink" or
"tortoiseplink" only at the beginning of the string or immediately after
a directory separator.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This is essentially just a deindentation.

 connect.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 749a07b..bae76a2 100644
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
@@ -750,14 +750,23 @@ struct child_process *git_connect(int fd[2], const char *url,
 				conn->use_shell = 1;
 				putty = 0;
 			} else {
+				char *plink, *tplink;
+
 				ssh = getenv("GIT_SSH");
 				if (!ssh)
 					ssh = "ssh";
-				putty = !!strcasestr(ssh, "plink");
+
+				plink = strcasestr(ssh, "plink");
+				tplink = strcasestr(ssh, "tortoiseplink");
+
+				tortoiseplink = tplink == ssh ||
+					(tplink && is_dir_sep(tplink[-1]));
+				putty = tortoiseplink || plink == ssh ||
+					(plink && is_dir_sep(plink[-1]));
 			}
 
 			argv_array_push(&conn->args, ssh);
-			if (putty && !strcasestr(ssh, "tortoiseplink"))
+			if (tortoiseplink)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
 				/* P is for PuTTY, p is for OpenSSH */
-- 
2.3.5
