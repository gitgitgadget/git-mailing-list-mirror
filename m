From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 44/44] builtin-am: remove redirection to git-am.sh
Date: Sun, 28 Jun 2015 22:06:06 +0800
Message-ID: <1435500366-31700-45-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DHN-0003TJ-H1
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbbF1OJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:49 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36838 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbbF1OJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:09:41 -0400
Received: by paceq1 with SMTP id eq1so91546789pac.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2tHUcALSfNSwxNZHsII/ShEXx/UOuyXuKvsag4hA7rM=;
        b=PW4vSnpXriD6TvMyr2krLQTNBoc6ceDHi+fRGQvVW79OUWUqRPFLTB48uUs7aGHMtR
         B9fmNBpNA3q8TLbyvT9zy9GxJX5I2J5YeqFIdWdHWJNorlFwv+Q1vEpcMhYWb/UDQkH2
         twAmQ1HZUdr9E+svP48Z4mcfbT3pNuNcU2+LpyA7gJ6zK6Y0br3+wyUaDVsX0JyNJ2bC
         kWUxB01i478e2gqIPZNVGURjJURW+28zbsTvQmmNw+5wi34h8lbN28ZyaIRJUkNIjh0Z
         kxmnw1O2tVsJrcgkJqqER3fJsnRMSZ0HbQZpROUBWPFcHj7SAmQ83OXG9M/t4DvFOGBz
         UK1g==
X-Received: by 10.69.26.170 with SMTP id iz10mr22119617pbd.81.1435500580616;
        Sun, 28 Jun 2015 07:09:40 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.09.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:09:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272920>

At the beginning of the rewrite of git-am.sh to C, in order to not break
existing test scripts that depended on a functional git-am, a
redirection to git-am.sh was introduced that would activate if the
environment variable _GIT_USE_BUILTIN_AM was not defined.

Now that all of git-am.sh's functionality has been re-implemented in
builtin/am.c, remove this redirection, and retire git-am.sh into
contrib/examples/.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile                                |  1 -
 builtin/am.c                            | 15 ---------------
 git-am.sh => contrib/examples/git-am.sh |  0
 git.c                                   |  7 +------
 4 files changed, 1 insertion(+), 22 deletions(-)
 rename git-am.sh => contrib/examples/git-am.sh (100%)

diff --git a/Makefile b/Makefile
index ff9bdc0..005d771 100644
--- a/Makefile
+++ b/Makefile
@@ -466,7 +466,6 @@ TEST_PROGRAMS_NEED_X =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
diff --git a/builtin/am.c b/builtin/am.c
index 1cb02c8..fb91145 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2243,21 +2243,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	/*
-	 * NEEDSWORK: Once all the features of git-am.sh have been
-	 * re-implemented in builtin/am.c, this preamble can be removed.
-	 */
-	if (!getenv("_GIT_USE_BUILTIN_AM")) {
-		const char *path = mkpath("%s/git-am", git_exec_path());
-
-		if (sane_execvp(path, (char **)argv) < 0)
-			die_errno("could not exec %s", path);
-	} else {
-		prefix = setup_git_directory();
-		trace_repo_setup(prefix);
-		setup_work_tree();
-	}
-
 	git_config(git_default_config, NULL);
 
 	am_state_init(&state, git_path("rebase-apply"));
diff --git a/git-am.sh b/contrib/examples/git-am.sh
similarity index 100%
rename from git-am.sh
rename to contrib/examples/git-am.sh
diff --git a/git.c b/git.c
index e84e1a1..8420e43 100644
--- a/git.c
+++ b/git.c
@@ -370,12 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	/*
-	 * NEEDSWORK: Once the redirection to git-am.sh in builtin/am.c has
-	 * been removed, this entry should be changed to
-	 * RUN_SETUP | NEED_WORK_TREE
-	 */
-	{ "am", cmd_am },
+	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive },
-- 
2.5.0.rc0.76.gb2c6e93
