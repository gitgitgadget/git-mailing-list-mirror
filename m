From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 45/45] builtin-am: remove redirection to git-am.sh
Date: Tue,  4 Aug 2015 21:52:06 +0800
Message-ID: <1438696326-19590-46-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcga-0003Ak-96
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbbHDNzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:55:01 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36350 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbbHDNy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:59 -0400
Received: by pacgq8 with SMTP id gq8so9195748pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5r2E9SdyoR0hZJgJmzz+H/w9E/k37huH4vJ/93ADtkI=;
        b=Xd4tNbJrYbs38jJTrAgGuNrJk7g+deygDB0qAxtnbPuqw+C8Ooqb3VjqlDTz5z+OLf
         UlpY1P7WpA0q8/wK5pRpiTEFCcjfwd52f4ztMcORzUDuIOmaGbcn/HsUeJnVl7Ulxifi
         mTCAzoxgKtYD1Q+gHf0NFPdl7fZnnmXEFwXbBgZd8vBRh1NMAS7XWIp5/Mr7m7lwLEsX
         m99DFiOSufyGMcvyy3n1Np3QjuDpgg33NpDOm0OoCTue4vuf2aUaGrfSQ2tTUqqGXCLG
         Hd5a7fZOR+p9Qm9dopWMGSaUO0bcHwSCPpT6D0O8yTzDUO9+ipJo1Qvs7xLQvS143qep
         XHXw==
X-Received: by 10.66.65.162 with SMTP id y2mr8047319pas.101.1438696498882;
        Tue, 04 Aug 2015 06:54:58 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275309>

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
index da451f8..e39ca6c 100644
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
index 1ff74ac..84d57d4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2221,21 +2221,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
