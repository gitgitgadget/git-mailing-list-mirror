From: Dustin Sallings <dustin@spy.net>
Subject: [PATCH] Allow local branching to set up rebase by default.
Date: Tue, 29 Apr 2008 13:49:42 -0700
Message-ID: <1209502182-39800-1-git-send-email-dustin@spy.net>
Cc: Dustin Sallings <dustin@spy.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 22:58:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqwtu-0003rh-40
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763391AbYD2U5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763295AbYD2U5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:57:16 -0400
Received: from basket.west.spy.net ([69.230.8.154]:62357 "EHLO
	mail.west.spy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762914AbYD2U5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:57:14 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2008 16:57:13 EDT
Received: from localhost.localdomain (dsl092-049-060.sfo4.dsl.speakeasy.net [66.92.49.60])
	by mail.west.spy.net (Postfix) with ESMTP id 519CF40;
	Tue, 29 Apr 2008 13:49:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.100.g65b98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80732>

Change cd67e4d4 introduced a new configuration parameter that told
pull to automatically perform a rebase instead of a merge.  I use this
feature quite a bit in topic branches and would like it to be the
default behavior for a topic branch.

If the parameter branch.autosetuprebase applies for a branch that's
being created, that branch will have branch.<name>.rebase set to true.

See the documentation for how this may be applied.

New model.
---
 Documentation/config.txt |   14 +++++++
 branch.c                 |   26 ++++++++++++-
 cache.h                  |    8 ++++
 config.c                 |   14 +++++++
 environment.c            |    1 +
 t/t3200-branch.sh        |   92 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7a24f6e..1994895 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -393,6 +393,20 @@ branch.autosetupmerge::
 	done when the starting point is either a local branch or remote
 	branch. This option defaults to true.
 
+branch.autosetuprebase::
+	When a new branch is created with `git-branch` or `git-checkout`
+	that tracks another branch, this parameter tells git to set
+	up pull to rebase instead of merge (see "branch.<name>.rebase")
+	below.
+	When `never`, rebase is never automatically set to true.
+	When `local`, rebase is set to true for tracked branches of
+	other local branches.
+	When `remote`, rebase is set to true for tracked branches of
+	remote branches.
+	When `always`, rebase will be set to true for all tracking
+	branches.
+	This option defaults to never.
+
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
 	If this option is not given, `git fetch` defaults to remote "origin".
diff --git a/branch.c b/branch.c
index daf862e..2a731e4 100644
--- a/branch.c
+++ b/branch.c
@@ -32,6 +32,25 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
+static int should_setup_rebase(struct tracking tracking) {
+	int rv=0;
+	switch(autorebase) {
+	case AUTOREBASE_NEVER:
+		rv = 0;
+		break;
+	case AUTOREBASE_LOCAL:
+		rv = tracking.matches == 0;
+		break;
+	case AUTOREBASE_REMOTE:
+		rv = tracking.matches > 0;
+		break;
+	case AUTOREBASE_ALWAYS:
+		rv = 1;
+		break;
+	}
+	return rv;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -69,9 +88,14 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	git_config_set(key, tracking.remote ?  tracking.remote : ".");
 	sprintf(key, "branch.%s.merge", new_ref);
 	git_config_set(key, tracking.src ? tracking.src : orig_ref);
-	free(tracking.src);
 	printf("Branch %s set up to track %s branch %s.\n", new_ref,
 		tracking.remote ? "remote" : "local", orig_ref);
+	if (should_setup_rebase(tracking)) {
+		sprintf(key, "branch.%s.rebase", new_ref);
+		git_config_set(key, "true");
+		printf("This branch will rebase on pull.\n");
+	}
+	free(tracking.src);
 
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 3fcc283..5c9aff8 100644
--- a/cache.h
+++ b/cache.h
@@ -433,7 +433,15 @@ enum branch_track {
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
index b0ada51..2959087 100644
--- a/config.c
+++ b/config.c
@@ -487,6 +487,20 @@ int git_default_config(const char *var, const char *value)
 		git_branch_track = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "branch.autosetuprebase")) {
+		if (!strcmp(value, "never"))
+			autorebase = AUTOREBASE_NEVER;
+		else if (!strcmp(value, "local"))
+			autorebase = AUTOREBASE_LOCAL;
+		else if (!strcmp(value, "remote"))
+			autorebase = AUTOREBASE_REMOTE;
+		else if (!strcmp(value, "always"))
+			autorebase = AUTOREBASE_ALWAYS;
+		else
+			die_bad_config(
+				"Invalid value for branch.autosetupmerge");
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index 6739a3f..6fb3b97 100644
--- a/environment.c
+++ b/environment.c
@@ -38,6 +38,7 @@ int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
+enum rebase_setup_type autorebase = 0;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cb5f7a4..10bb429 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -224,4 +224,96 @@ test_expect_success 'avoid ambiguous track' '
 	test -z "$(git config branch.all1.merge)"
 '
 
+test_expect_success 'autosetuprebase local on a tracked local branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase local &&
+	 (git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	 git branch mybase &&
+	 git branch --track myr1 mybase &&
+	 test "$(git config branch.myr1.remote)" = . &&
+	 test "$(git config branch.myr1.merge)" = refs/heads/mybase &&
+	 test "$(git config branch.myr1.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase always on a tracked local branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase always &&
+	 (git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	 git branch mybase2 &&
+	 git branch --track myr2 mybase &&
+	 test "$(git config branch.myr2.remote)" = . &&
+	 test "$(git config branch.myr2.merge)" = refs/heads/mybase &&
+	 test "$(git config branch.myr2.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase remote on a tracked local branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase remote &&
+	 (git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	 git branch mybase3 &&
+	 git branch --track myr3 mybase2 &&
+	 test "$(git config branch.myr3.remote)" = . &&
+	 test "$(git config branch.myr3.merge)" = refs/heads/mybase2 &&
+	 ! test "$(git config branch.myr3.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase never on a tracked local branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase never &&
+	 (git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	 git branch mybase4 &&
+	 git branch --track myr4 mybase2 &&
+	 test "$(git config branch.myr4.remote)" = . &&
+	 test "$(git config branch.myr4.merge)" = refs/heads/mybase2 &&
+	 ! test "$(git config branch.myr4.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase local on a tracked remote branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase local &&
+	 (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	 git branch --track myr5 local/master &&
+	 test "$(git config branch.myr5.remote)" = local &&
+	 test "$(git config branch.myr5.merge)" = refs/heads/master &&
+	 ! test "$(git config branch.myr5.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase never on a tracked remote branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase never &&
+	 (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	 git branch --track myr6 local/master &&
+	 test "$(git config branch.myr6.remote)" = local &&
+	 test "$(git config branch.myr6.merge)" = refs/heads/master &&
+	 ! test "$(git config branch.myr6.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase remote on a tracked remote branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase remote &&
+	 (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	 git branch --track myr7 local/master &&
+	 test "$(git config branch.myr7.remote)" = local &&
+	 test "$(git config branch.myr7.merge)" = refs/heads/master &&
+	 test "$(git config branch.myr7.rebase)" = true
+'
+
+test_expect_success 'autosetuprebase always on a tracked remote branch' \
+	'git config remote.local.url . &&
+	 git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	 git config branch.autosetuprebase remote &&
+	 (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	 git branch --track myr8 local/master &&
+	 test "$(git config branch.myr8.remote)" = local &&
+	 test "$(git config branch.myr8.merge)" = refs/heads/master &&
+	 test "$(git config branch.myr8.rebase)" = true
+'
+
 test_done
-- 
1.5.5.1.100.g65b98
