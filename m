From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 03/44] builtin-am: implement skeletal builtin am
Date: Sun, 28 Jun 2015 22:05:25 +0800
Message-ID: <1435500366-31700-4-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DEl-0001em-GC
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbF1OHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:07 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35958 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbbF1OHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:02 -0400
Received: by pdcu2 with SMTP id u2so101475554pdc.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9taW2frhdh5ogHwsGFLvMOslxorGIqM4gw/NKNQ9oI=;
        b=kT1nrrk5EQxY3OKg73MbB/j6kh3sGPaWMTb4czJWzwqteTUE8DPyHujvA1WVTbZ0dD
         LZYhkijE7Dc/XOjg2K0O6yHbLArlM5rcPy6/3kBXfVE0TlaFrmRc3zKSXlOPEFBzwiE9
         q1Nr2DvSTjBCGUjOG69H/tjhGDhwHoh/B+HetXvM55MkdMJDKawht7mb17vwUxaRN/5t
         Us3/nW/08bJJLkF8AEAH1/jjE4gzLw+r8MLRpsH9tMgHhMdmZCm5n4Ta1draXVBgUm+l
         FrHnf5gYlB4lDFBnULdKhJRyUiBBqVYweYMKziJP3FsQl+oyzKPSCHwVM0ZMS8gIgLT/
         4bOg==
X-Received: by 10.70.109.199 with SMTP id hu7mr22620968pdb.71.1435500421842;
        Sun, 28 Jun 2015 07:07:01 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.06.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272879>

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

Notes:
    v4
    
    * Don't use NO_SETUP
    
    * Comment wording changes

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
2.5.0.rc0.76.gb2c6e93
