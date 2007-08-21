From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Replace git --paginate by git --pager[=PAGER_CMD].
Date: Tue, 21 Aug 2007 10:37:08 +0200
Message-ID: <11876854283229-git-send-email-Matthieu.Moy@imag.fr>
References: <fadhkv$amj$2@sea.gmane.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 10:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INPEt-0001MR-BR
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 10:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXHUIhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 04:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbXHUIhX
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 04:37:23 -0400
Received: from imag.imag.fr ([129.88.30.1]:48146 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbXHUIhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 04:37:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7L8b9xT016674
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Aug 2007 10:37:09 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1INPEa-0005Mn-Rd; Tue, 21 Aug 2007 10:37:08 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1INPEa-0006l9-Os; Tue, 21 Aug 2007 10:37:08 +0200
X-Mailer: git-send-email 1.5.3.rc5.17.g1cd0d-dirty
In-Reply-To: <fadhkv$amj$2@sea.gmane.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 21 Aug 2007 10:37:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56284>

The previous one was -p|--paginate, but doesn't accept a natural
negation. This patch changes it to -p|--pager|--pager=PAGER_CMD, which
makes the negation --no-pager more natural, and provides a simple way to
override the pager command (git --pager=CMD is equivalent to
GIT_PAGER=CMD git with most shells).

--paginate is kept as a backward-compatibility, deprecated option.

Suggested-by: David Kastrup <dak@gnu.org>
Idea-acked-by: Jakub Narebski <jnareb@gmail.com>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git.txt |    8 +++++---
 git.c                 |   16 ++++++++++++++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3b0d530..444823d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]]
-    [-p|--paginate|--no-pager]
+    [-p|--pager[=PAGER_CMD]|--no-pager]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]
 
@@ -101,8 +101,10 @@ OPTIONS
 	environment variable. If no path is given 'git' will print
 	the current setting and then exit.
 
--p|--paginate::
-	Pipe all output into 'less' (or if set, $PAGER).
+-p|--pager[=PAGER_CMD]::
+	Pipe all output into 'less' (or if set, PAGER_CMD,
+	`$GIT_PAGER`, or `$PAGER`, in this order of preference).
+	--paginate is provided as a deprecated alias for -p.
 
 --no-pager::
 	Do not pipe git output into a pager.
diff --git a/git.c b/git.c
index c46691e..4c626b5 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,9 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]]\n"
+        "	[-p|--pager[=PAGER_CMD]|--no-pager] [--bare]\n"
+        "	[--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -56,8 +58,18 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 				puts(git_exec_path());
 				exit(0);
 			}
-		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
+		} else if (!strcmp(cmd, "-p") || 
+                           /* 
+                            * Deprecated, but kept for backward
+                            * compatibility
+                            */
+                           !strcmp(cmd, "--paginate")) {
 			setup_pager();
+                } else if (!prefixcmp(cmd, "--pager")) {
+			cmd += 7;
+			if (*cmd == '=')
+				setenv("GIT_PAGER", cmd+1, 1);
+                        setup_pager();
 		} else if (!strcmp(cmd, "--no-pager")) {
 			setenv("GIT_PAGER", "cat", 1);
 			if (envchanged)
-- 
1.5.3.rc5.17.g1cd0d-dirty
