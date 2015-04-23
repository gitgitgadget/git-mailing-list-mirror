From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] connect: simplify SSH connection code path
Date: Thu, 23 Apr 2015 00:06:34 +0000
Message-ID: <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
References: <20150422232306.GA32705@peff.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 02:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl4fH-0005Il-5z
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 02:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965730AbbDWAGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 20:06:42 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44880 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965600AbbDWAGl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 20:06:41 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7D7D92808D;
	Thu, 23 Apr 2015 00:06:39 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <20150422232306.GA32705@peff.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267670>

The code path used in git_connect pushed the majority of the SSH
connection code into an else block, even though the if block returns.
Simplify the code by eliminating the else block, as it is unneeded.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/connect.c b/connect.c
index 391d211..749a07b 100644
--- a/connect.c
+++ b/connect.c
@@ -743,28 +743,28 @@ struct child_process *git_connect(int fd[2], const char *url,
 				free(path);
 				free(conn);
 				return NULL;
-			} else {
-				ssh = getenv("GIT_SSH_COMMAND");
-				if (ssh) {
-					conn->use_shell = 1;
-					putty = 0;
-				} else {
-					ssh = getenv("GIT_SSH");
-					if (!ssh)
-						ssh = "ssh";
-					putty = !!strcasestr(ssh, "plink");
-				}
-
-				argv_array_push(&conn->args, ssh);
-				if (putty && !strcasestr(ssh, "tortoiseplink"))
-					argv_array_push(&conn->args, "-batch");
-				if (port) {
-					/* P is for PuTTY, p is for OpenSSH */
-					argv_array_push(&conn->args, putty ? "-P" : "-p");
-					argv_array_push(&conn->args, port);
-				}
-				argv_array_push(&conn->args, ssh_host);
 			}
+
+			ssh = getenv("GIT_SSH_COMMAND");
+			if (ssh) {
+				conn->use_shell = 1;
+				putty = 0;
+			} else {
+				ssh = getenv("GIT_SSH");
+				if (!ssh)
+					ssh = "ssh";
+				putty = !!strcasestr(ssh, "plink");
+			}
+
+			argv_array_push(&conn->args, ssh);
+			if (putty && !strcasestr(ssh, "tortoiseplink"))
+				argv_array_push(&conn->args, "-batch");
+			if (port) {
+				/* P is for PuTTY, p is for OpenSSH */
+				argv_array_push(&conn->args, putty ? "-P" : "-p");
+				argv_array_push(&conn->args, port);
+			}
+			argv_array_push(&conn->args, ssh_host);
 		} else {
 			/* remove repo-local variables from the environment */
 			conn->env = local_repo_env;
-- 
2.3.5
