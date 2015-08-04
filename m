From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 03/45] builtin-am: implement skeletal builtin am
Date: Tue,  4 Aug 2015 21:51:24 +0800
Message-ID: <1438696326-19590-4-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:59:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMckR-0005BG-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934212AbbHDNxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:10 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34522 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933627AbbHDNxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:06 -0400
Received: by pawu10 with SMTP id u10so9231979paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42AFurpkT5Nt1G1RV1dQ9ZF3HoOCjtGw41cWu1ofP2o=;
        b=weDUJySMkHm+dqPAyx86xL4qAXJ5F6lv6mJ3U0UZSa5SbMtQPwyKGakkloK/DZ5NYl
         xjWsvHest29iAjTNpxT4OErlXy/VEbr3WObnXp7g8minAkQj87UY0IDH4jaULQT5596/
         zFmxhAsGm8Iw5vji0lhRku5XmHbZSCKrDDTtUrmKGaTRO2NmYD4zTGkRym73WnUpLgt2
         If3RH1MnGIVyGDvEDxEc8mGoZ1fpCl10VVUfJIQMFbmMDWvRNR4ozk18qAt3NZ9cn69n
         MCExOQJsddbmHwLHAlq8rx1XTg440bo1dIm8+y3QssWxpaH6atQooyk74alyK42+jdjX
         WpIA==
X-Received: by 10.66.231.69 with SMTP id te5mr8036566pac.98.1438696386378;
        Tue, 04 Aug 2015 06:53:06 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275319>

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
index 7efedbe..da451f8 100644
--- a/Makefile
+++ b/Makefile
@@ -813,6 +813,7 @@ LIB_OBJS += xdiff-interface.o
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
2.5.0.280.gd88bd6e
