From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 03/45] builtin-am: implement skeletal builtin am
Date: Mon, 20 Jul 2015 00:09:55 +0800
Message-ID: <1437322237-29863-4-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrB4-0005wJ-Nu
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbbGSQKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:10:55 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34041 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbbGSQKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:10:54 -0400
Received: by pacan13 with SMTP id an13so89899109pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZeqDeQkt7oLy/JVUPsPd3xSjVEI8IzkMfFgvNr7sv20=;
        b=CZ1QRu/HqY2pUEemM4anc2ErtM2Cx/N0ds42OTIZbnNEDhnfgrrlD2PwPw7gzRc44H
         4moRgjcf1RDTxokElivykmOQEW6uj+0RI4rBOrINT6ExKigkcMpjDcZHRMWyOwGTm0qj
         Qxkn6whdRC/SSXmVbAJhoMeuq78LihBK2BicvBzU6sFlJKv/L3FoPlvTKOucwDt9g4Rj
         yDK2y1xIkEOODU6NCs7pBskXxm+g3DH/lzdhRqSKfodrVj3UR22/0tIne92RqvA7OrDz
         lSMc2curxcmz0SIYA4DufG80106zY9dELzpKgsxporumjLW2pHnbE4UkscDiCDprggP5
         9eqw==
X-Received: by 10.66.97.39 with SMTP id dx7mr49773042pab.1.1437322253894;
        Sun, 19 Jul 2015 09:10:53 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.10.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:10:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274227>

For the purpose of rewriting git-am.sh into a C builtin, implement a
skeletal builtin/am.c that redirects to $GIT_EXEC_PATH/git-am if the
environment variable _GIT_USE_BUILTIN_AM is not defined. Since in the
Makefile git-am.sh takes precedence over builtin/am.c,
$GIT_EXEC_PATH/git-am will contain the shell script git-am.sh, and thus
this allows us to fall back on the functional git-am.sh when running the
test suite for tests that depend on a working git-am implementation.

Since git-am.sh cannot handle any environment modifications by
setup_git_directory(), "am" is declared with no setup flags in git.c. On
the other hand, to re-implement git-am.sh in builtin/am.c, we need to
run all the git dir and work tree setup logic that git.c typically does
for us. As such, we work around this temporarily by copying the logic in
git.c's run_builtin(), which is roughly:

	prefix = setup_git_directory();
	trace_repo_setup(prefix);
	setup_work_tree();

This redirection should be removed when all the features of git-am.sh
have been re-implemented in builtin/am.c.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile     |  1 +
 builtin.h    |  1 +
 builtin/am.c | 29 +++++++++++++++++++++++++++++
 git.c        |  6 ++++++
 4 files changed, 37 insertions(+)
 create mode 100644 builtin/am.c

diff --git a/Makefile b/Makefile
index c6c28bc..f88642a 100644
--- a/Makefile
+++ b/Makefile
@@ -812,6 +812,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
diff --git a/builtin.h b/builtin.h
index 839483d..79aaf0a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -30,6 +30,7 @@ extern int textconv_object(const char *path, unsigned mode, const unsigned char
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
diff --git a/builtin/am.c b/builtin/am.c
new file mode 100644
index 0000000..fd32caf
--- /dev/null
+++ b/builtin/am.c
@@ -0,0 +1,29 @@
+/*
+ * Builtin "git am"
+ *
+ * Based on git-am.sh by Junio C Hamano.
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "exec_cmd.h"
+
+int cmd_am(int argc, const char **argv, const char *prefix)
+{
+
+	/*
+	 * NEEDSWORK: Once all the features of git-am.sh have been
+	 * re-implemented in builtin/am.c, this preamble can be removed.
+	 */
+	if (!getenv("_GIT_USE_BUILTIN_AM")) {
+		const char *path = mkpath("%s/git-am", git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno("could not exec %s", path);
+	} else {
+		prefix = setup_git_directory();
+		trace_repo_setup(prefix);
+		setup_work_tree();
+	}
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 55c327c..38d9ad5 100644
--- a/git.c
+++ b/git.c
@@ -370,6 +370,12 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	/*
+	 * NEEDSWORK: Once the redirection to git-am.sh in builtin/am.c has
+	 * been removed, this entry should be changed to
+	 * RUN_SETUP | NEED_WORK_TREE
+	 */
+	{ "am", cmd_am },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive },
-- 
2.5.0.rc2.110.gb39b692
