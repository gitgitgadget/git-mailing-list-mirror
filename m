From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 45/45] builtin-am: remove redirection to git-am.sh
Date: Mon, 20 Jul 2015 00:10:37 +0800
Message-ID: <1437322237-29863-46-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCw-0006tQ-JD
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbbGSQMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:48 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33851 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbbGSQMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:41 -0400
Received: by pdbbh15 with SMTP id bh15so44250872pdb.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJJPhpZX0TgMTnOD7NrrvgmK0sSkz3xO8Shs83n4EPg=;
        b=x4iQcfdC+viIu9it7lic9iIg+LmgsGveLZtuGh7OXt2ot1qZx9h9VvVr9P8L0euv3b
         zeEvhw8W0VF6BQRpkZMVxCdWhQ5wTlz+KLhti8V2cL9RKJSGPxMtopSzar74mhMBYLbC
         KOcG0qg9Rt0gaS44uJgV94g9s0QuKgp2YwHTin4lRHiU6lo+zkRPWdOYBQcCT5t+1LJ1
         Wpv6z/vlN8JVgHSXfMa74jsKp+OmZUroKR4uiA14tDQKshY3xEZb3PNrDv5+NbqawEMS
         qF0EDLV726eNEdAgjxQc2AIXI5/4DakK9k1skd5aCybO4nTeAZDoBx8l7s6gLECAe042
         +beQ==
X-Received: by 10.68.69.5 with SMTP id a5mr50230462pbu.56.1437322361076;
        Sun, 19 Jul 2015 09:12:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274264>

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
index f88642a..ec51f03 100644
--- a/Makefile
+++ b/Makefile
@@ -467,7 +467,6 @@ TEST_PROGRAMS_NEED_X =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
diff --git a/builtin/am.c b/builtin/am.c
index 1fe2c65..1116304 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2222,21 +2222,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
index 38d9ad5..5feba41 100644
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
2.5.0.rc2.110.gb39b692
