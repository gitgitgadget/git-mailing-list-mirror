From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 03/44] builtin-am: implement skeletal builtin am
Date: Tue,  7 Jul 2015 22:20:21 +0800
Message-ID: <1436278862-2638-4-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:21:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTkd-00043x-VA
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472AbbGGOVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:21:30 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36114 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422AbbGGOVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:25 -0400
Received: by pacgz10 with SMTP id gz10so40434086pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HmjYF/kxHHQqV2DJuDWODSDKzNpak/yItQDUrnF84do=;
        b=qo5bGqLHaCgoB3SbGxtQI9JE8b76bfspmH6VT7112iAdIfbwGCRoxyV/L2aGONxdns
         U7vlq041VxtuEXo8Ytl+AtZ86ir8vothEPLOcKJkv1XOg+0FKmB/AZPy3o4bfJQarEl7
         rvrb7L2pUAglcwQLy4gApNHxA02DJBZ0byak6TQLUUPANVdoW5MvdqFZ3SFXkFlNPtSj
         SAbtPAV6P/VwWSLGYzT5Fq8Rid5iU/XCmMaM1B1BiuNpB0YPT6kDwL/wT6yvjryTMjBG
         BheSovdUhQB2NG771YPYu0A1L30VW23PAQYDwLMkxsCrrwGa6qcT+ABseHSuHToJJawL
         vQpQ==
X-Received: by 10.68.243.9 with SMTP id wu9mr9571457pbc.28.1436278885360;
        Tue, 07 Jul 2015 07:21:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273522>

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
index 93e4fa2..ff9bdc0 100644
--- a/Makefile
+++ b/Makefile
@@ -811,6 +811,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
diff --git a/builtin.h b/builtin.h
index ea3c834..f30cf00 100644
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
index e7a7713..e84e1a1 100644
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
2.5.0.rc1.76.gf60a929
