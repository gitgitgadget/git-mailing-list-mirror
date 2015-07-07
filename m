From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 44/44] builtin-am: remove redirection to git-am.sh
Date: Tue,  7 Jul 2015 22:21:02 +0800
Message-ID: <1436278862-2638-45-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:26:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTox-0006cx-9v
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbbGGOZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:25:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36055 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802AbbGGOXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:23:20 -0400
Received: by pacgz10 with SMTP id gz10so40457072pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yC2+K/Q1NIOSPO1My2r4yUS0kvD9ciY0yu7wKPjwMrQ=;
        b=F5bzYMWFLWgsRdtu7UkXe7j70Ia3VzMNv6G8v3RY8Qmi+xZKNKMZcWYCyujwrC6+Iq
         lpgOAEquQbkDkA4yOnKiXAlA3TIga1pBb5dGkCULVN8f0hq3ENDKWXiUEdDqMeTKazdL
         9fabfJnwhc0MuYDzlaqfrjkn9qT2GTm4ccfA+xowN8ggcpxmhip2aI7lRfE2c4SG1cAh
         fuVba///t2jbR5bjNcodYTrOh7HWWQvaSyxux552XV996LpPHaRehuK1+Yysg4SLkVyY
         swI2FAcY6CEtFTvcSUPuy4JgwsZJ5Q3nn3sdyinL3hrYFHt/tWkGzjeqOXi/VeZDvldg
         rkpw==
X-Received: by 10.68.142.232 with SMTP id rz8mr9322108pbb.117.1436278999398;
        Tue, 07 Jul 2015 07:23:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.23.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:23:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273565>

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
index a0982d9..c548129 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2239,21 +2239,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc1.76.gf60a929
