From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/6] archive: allow --exec and --remote without equal sign
Date: Fri, 25 Jul 2008 12:41:25 +0200
Message-ID: <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKsg-0001aq-Qb
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbYGYKth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbYGYKtg
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:49:36 -0400
Received: from india601.server4you.de ([85.25.151.105]:55537 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYGYKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:49:33 -0400
Received: by india601.server4you.de (Postfix, from userid 1000)
	id 61D252F81B3; Fri, 25 Jul 2008 12:41:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90029>

Allow "--remote repo" and "--exec cmd" in addition to "--remote=repo" and
"--exec=cmd" to make their usage consistent with parameters handled by
parse_options().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-archive.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 4dd2716..22445ac 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -15,7 +15,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	int fd[2], i, len, rv;
 	struct child_process *conn;
 	const char *exec = "git-upload-archive";
-	int exec_at = 0;
+	int exec_at = 0, exec_value_at = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -24,7 +24,14 @@ static int run_remote_archiver(const char *remote, int argc,
 				die("multiple --exec specified");
 			exec = arg + 7;
 			exec_at = i;
-			break;
+		} else if (!strcmp(arg, "--exec")) {
+			if (exec_at)
+				die("multiple --exec specified");
+			if (i + 1 >= argc)
+				die("option --exec requires a value");
+			exec = argv[i + 1];
+			exec_at = i;
+			exec_value_at = ++i;
 		}
 	}
 
@@ -32,7 +39,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	conn = git_connect(fd, url, exec, 0);
 
 	for (i = 1; i < argc; i++) {
-		if (i == exec_at)
+		if (i == exec_at || i == exec_value_at)
 			continue;
 		packet_write(fd[1], "argument %s\n", argv[i]);
 	}
@@ -78,6 +85,13 @@ static const char *extract_remote_arg(int *ac, const char **av)
 					die("Multiple --remote specified");
 				remote = arg + 9;
 				continue;
+			} else if (!strcmp(arg, "--remote")) {
+				if (remote)
+					die("Multiple --remote specified");
+				if (++ix >= cnt)
+					die("option --remote requires a value");
+				remote = av[ix];
+				continue;
 			}
 			if (arg[0] != '-')
 				no_more_options = 1;
-- 
1.6.0.rc0.42.g186458
