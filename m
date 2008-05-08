From: Dustin Sallings <dustin@spy.net>
Subject: [PATCH] Allow tracking branches to set up rebase by default.
Date: Thu,  8 May 2008 11:28:06 -0700
Message-ID: <1210271287-36719-1-git-send-email-dustin@spy.net>
References: <7vprrycce9.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, Dustin Sallings <dustin@spy.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 20:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuArh-0007Qc-4A
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbYEHS2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbYEHS2T
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:28:19 -0400
Received: from basket.west.spy.net ([69.230.8.154]:61132 "EHLO
	mail.west.spy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359AbYEHS2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 14:28:16 -0400
Received: from localhost.localdomain (dsl092-049-060.sfo4.dsl.speakeasy.net [66.92.49.60])
	by mail.west.spy.net (Postfix) with ESMTP id 8E35E4F;
	Thu,  8 May 2008 11:28:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.100.g65b98
In-Reply-To: <7vprrycce9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81550>

Change cd67e4d4 introduced a new configuration parameter that told
pull to automatically perform a rebase instead of a merge.  This
change provides a configuration option to enable this feature
automatically when creating a new branch.

If the variable branch.autosetuprebase applies for a branch that's
being created, that branch will have branch.<name>.rebase set to true.

Signed-off-by: Dustin Sallings <dustin@spy.net>
---
 Documentation/config.txt |   15 +++++++
 branch.c                 |   22 ++++++++++-
 cache.h                  |    8 ++++
 config.c                 |   13 ++++++
 environment.c            |    1 +
 t/t3200-branch.sh        |   92 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 150 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 00f089f..6413f70 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -399,6 +399,21 @@ branch.autosetupmerge::
 	done when the starting point is either a local branch or remote
 	branch. This option defaults to true.
 
+branch.autosetuprebase::
+	When a new branch is created with `git-branch` or `git-checkout`
+	that tracks another branch, this variable tells git to set
+	up pull to rebase instead of merge (see "branch.<name>.rebase").
+	When `never`, rebase is never automatically set to true.
+	When `local`, rebase is set to true for tracked branches of
+	other local branches.
+	When `remote`, rebase is set to true for tracked branches of
+	remote branches.
+	When `always`, rebase will be set to true for all tracking
+	branches.
+	See "branch.autosetupmerge" for details on how to set up a
+	branch to track another branch.
+	This option defaults to never.
+
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
 	If this option is not given, `git fetch` defaults to remote "origin".
diff --git a/branch.c b/branch.c
index daf862e..56e9492 100644
--- a/branch.c
+++ b/branch.c
@@ -32,6 +32,21 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
+static int should_setup_rebase(const struct tracking *tracking)
+{
+	switch (autorebase) {
+	case AUTOREBASE_NEVER:
+		return 0;
+	case AUTOREBASE_LOCAL:
+		return tracking->remote == NULL;
+	case AUTOREBASE_REMOTE:
+		return tracking->remote != NULL;
+	case AUTOREBASE_ALWAYS:
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -69,9 +84,14 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	git_config_set(key, tracking.remote ?  tracking.remote : ".");
 	sprintf(key, "branch.%s.merge", new_ref);
 	git_config_set(key, tracking.src ? tracking.src : orig_ref);
-	free(tracking.src);
 	printf("Branch %s set up to track %s branch %s.\n", new_ref,
 		tracking.remote ? "remote" : "local", orig_ref);
+	if (should_setup_rebase(&tracking)) {
+		sprintf(key, "branch.%s.rebase", new_ref);
+		git_config_set(key, "true");
+		printf("This branch will rebase on pull.\n");
+	}
+	free(tracking.src);
 
 	return 0;
 }
diff --git a/cache.h b/cache.h
index d5d5dad..19f2930 100644
--- a/cache.h
+++ b/cache.h
@@ -434,7 +434,15 @@ enum branch_track {
 	BRANCH_TRACK_EXPLICIT,
 };
 
+enum rebase_setup_type {
+	AUTOREBASE_NEVER = 0,
+	AUTOREBASE_LOCAL,
+	AUTOREBASE_REMOTE,
+	AUTOREBASE_ALWAYS,
+};
+
 extern enum branch_track git_branch_track;
+extern enum rebase_setup_type autorebase;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index b0ada51..7d76986 100644
--- a/config.c
+++ b/config.c
@@ -487,6 +487,19 @@ int git_default_config(const char *var, const char *value)
 		git_branch_track = git_config_bool(var, value);
 		return 0;
 	}
+	if (value && !strcmp(var, "branch.autosetuprebase")) {
+		if (!strcmp(value, "never"))
+			autorebase = AUTOREBASE_NEVER;
+		else if (!strcmp(value, "local"))
+			autorebase = AUTOREBASE_LOCAL;
+		else if (!strcmp(value, "remote"))
+			autorebase = AUTOREBASE_REMOTE;
+		else if (!strcmp(value, "always"))
+			autorebase = AUTOREBASE_ALWAYS;
+		else
+			die_bad_config("Invalid value for branch.autosetupmerge");
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index fcd1ee5..4892a30 100644
--- a/environment.c
+++ b/environment.c
@@ -38,6 +38,7 @@ int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
+enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cb5f7a4..d11dd41 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -224,4 +224,96 @@ test_expect_success 'avoid ambiguous track' '
 	test -z "$(git config branch.all1.merge)"
 '
 
+test_expect_success 'autosetuprebase local on a tracked local branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase local &&
+	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	git branch mybase &&
+	git branch --track myr1 mybase &&
+	test "$(git config branch.myr1.remote)" = . &&
+	test "$(git config branch.myr1.merge)" = refs/heads/mybase &&
+	test "$(git config branch.myr1.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase always on a tracked local branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase always &&
+	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	git branch mybase2 &&
+	git branch --track myr2 mybase &&
+	test "$(git config branch.myr2.remote)" = . &&
+	test "$(git config branch.myr2.merge)" = refs/heads/mybase &&
+	test "$(git config branch.myr2.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase remote on a tracked local branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase remote &&
+	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	git branch mybase3 &&
+	git branch --track myr3 mybase2 &&
+	test "$(git config branch.myr3.remote)" = . &&
+	test "$(git config branch.myr3.merge)" = refs/heads/mybase2 &&
+	! test "$(git config branch.myr3.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase never on a tracked local branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase never &&
+	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	git branch mybase4 &&
+	git branch --track myr4 mybase2 &&
+	test "$(git config branch.myr4.remote)" = . &&
+	test "$(git config branch.myr4.merge)" = refs/heads/mybase2 &&
+	! test "$(git config branch.myr4.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase local on a tracked remote branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase local &&
+	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	git branch --track myr5 local/master &&
+	test "$(git config branch.myr5.remote)" = local &&
+	test "$(git config branch.myr5.merge)" = refs/heads/master &&
+	! test "$(git config branch.myr5.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase never on a tracked remote branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase never &&
+	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	git branch --track myr6 local/master &&
+	test "$(git config branch.myr6.remote)" = local &&
+	test "$(git config branch.myr6.merge)" = refs/heads/master &&
+	! test "$(git config branch.myr6.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase remote on a tracked remote branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase remote &&
+	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	git branch --track myr7 local/master &&
+	test "$(git config branch.myr7.remote)" = local &&
+	test "$(git config branch.myr7.merge)" = refs/heads/master &&
+	test "$(git config branch.myr7.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase always on a tracked remote branch' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git config branch.autosetuprebase remote &&
+	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	git branch --track myr8 local/master &&
+	test "$(git config branch.myr8.remote)" = local &&
+	test "$(git config branch.myr8.merge)" = refs/heads/master &&
+	test "$(git config branch.myr8.rebase)" = true
+'
+
 test_done
-- 
1.5.5.1.100.g65b98
