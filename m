From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/3] connect: simplify SSH connection code path
Date: Sun, 26 Apr 2015 20:30:10 +0000
Message-ID: <1430080212-396370-2-git-send-email-sandals@crustytoothpaste.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 22:30:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmTCC-000729-Mn
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 22:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbbDZUaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 16:30:25 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48877 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750746AbbDZUaV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 16:30:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7795C282A6;
	Sun, 26 Apr 2015 20:30:20 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267838>

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
