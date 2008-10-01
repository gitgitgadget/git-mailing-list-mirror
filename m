From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] Add branch.autosetuppreservemerges and
 branch.<name>.preservemerges.
Date: Wed, 1 Oct 2008 15:27:07 -0500
Organization: Exigence
Message-ID: <20081001152707.2225137f.stephen@exigencecorp.com>
References: <48D95836.6040200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:28:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8JG-0001rG-Ok
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 22:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbYJAU1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 16:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbYJAU1O
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:27:14 -0400
Received: from smtp202.sat.emailsrvr.com ([66.216.121.202]:32805 "EHLO
	smtp202.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbYJAU1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 16:27:12 -0400
Received: from relay10.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 2274611B1A80;
	Wed,  1 Oct 2008 16:27:11 -0400 (EDT)
Received: by relay10.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 6EF3F11B16C7;
	Wed,  1 Oct 2008 16:27:10 -0400 (EDT)
In-Reply-To: <48D95836.6040200@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97263>

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---

This builds on top of Andreas's work on `git rebase -p`. I
basically copy/pasted how autosetuprebase works so that, if
appropriately configured, `git pull` will do the "right thing"
for our environment, i.e. rebasing and preserving merges.

I'm not sure how to handle patches on patches, so apologies
if I did this wrong. Let me know if there are things I should
be doing differently.

Thanks.

 Documentation/config.txt          |   20 ++++++++
 branch.c                          |   20 ++++++++
 cache.h                           |    9 ++++
 config.c                          |   15 ++++++
 environment.c                     |    1 +
 git-pull.sh                       |   10 +++-
 t/t3200-branch.sh                 |   89 ++++++++++++++++++++++++++++--------
 t/t3409-rebase-preserve-merges.sh |   65 ++++++++++++++++----------
 8 files changed, 182 insertions(+), 47 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bea867d..0abf1b8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -438,6 +438,21 @@ branch.autosetuprebase::
 	branch to track another branch.
 	This option defaults to never.
 
+branch.autosetuppreservemerges::
+	When a new branch is created with 'git-branch' or 'git-checkout'
+	that tracks another branch, this variable tells git to set
+	up pull to rebase with preserve merges (see "branch.<name>.rebase").
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
 	When in branch <name>, it tells 'git-fetch' which remote to fetch.
 	If this option is not given, 'git-fetch' defaults to remote "origin".
@@ -471,6 +486,11 @@ branch.<name>.rebase::
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
 
+branch.<name>.preservemerges::
+	When true, and branch.<name>.rebase is true, preserve merges when
+	rebasing the branch <name> on top of the fetched branch when
+	"git pull" is run.
+
 browser.<tool>.cmd::
 	Specify the command to invoke the specified browser. The
 	specified command is evaluated in shell with the URLs passed
diff --git a/branch.c b/branch.c
index b1e59f2..a5e62c8 100644
--- a/branch.c
+++ b/branch.c
@@ -47,6 +47,21 @@ static int should_setup_rebase(const struct tracking *tracking)
 	return 0;
 }
 
+static int should_setup_preservemerges(const struct tracking *tracking)
+{
+	switch (autopreservemerges) {
+	case AUTOPRESERVEMERGES_NEVER:
+		return 0;
+	case AUTOPRESERVEMERGES_LOCAL:
+		return tracking->remote == NULL;
+	case AUTOPRESERVEMERGES_REMOTE:
+		return tracking->remote != NULL;
+	case AUTOPRESERVEMERGES_ALWAYS:
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -91,6 +106,11 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		git_config_set(key, "true");
 		printf("This branch will rebase on pull.\n");
 	}
+	if (should_setup_preservemerges(&tracking)) {
+		sprintf(key, "branch.%s.preservemerges", new_ref);
+		git_config_set(key, "true");
+		printf("This branch will preserve merges on pull.\n");
+	}
 	free(tracking.src);
 
 	return 0;
diff --git a/cache.h b/cache.h
index de8c2b6..97be98c 100644
--- a/cache.h
+++ b/cache.h
@@ -467,8 +467,17 @@ enum rebase_setup_type {
 	AUTOREBASE_ALWAYS,
 };
 
+enum preservemerges_setup_type {
+	AUTOPRESERVEMERGES_NEVER = 0,
+	AUTOPRESERVEMERGES_LOCAL,
+	AUTOPRESERVEMERGES_REMOTE,
+	AUTOPRESERVEMERGES_ALWAYS,
+};
+
+
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
+extern enum preservemerges_setup_type autopreservemerges;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 53f04a0..6302f5a 100644
--- a/config.c
+++ b/config.c
@@ -536,6 +536,21 @@ static int git_default_branch_config(const char *var, const char *value)
 			return error("Malformed value for %s", var);
 		return 0;
 	}
+	if (!strcmp(var, "branch.autosetuppreservemerges")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "never"))
+			autopreservemerges = AUTOPRESERVEMERGES_NEVER;
+		else if (!strcmp(value, "local"))
+			autopreservemerges = AUTOPRESERVEMERGES_LOCAL;
+		else if (!strcmp(value, "remote"))
+			autopreservemerges = AUTOPRESERVEMERGES_REMOTE;
+		else if (!strcmp(value, "always"))
+			autopreservemerges = AUTOPRESERVEMERGES_ALWAYS;
+		else
+			return error("Malformed value for %s", var);
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index 0c6d11f..72e735c 100644
--- a/environment.c
+++ b/environment.c
@@ -42,6 +42,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+enum preservemerges_setup_type autopreservemerges = AUTOPRESERVEMERGES_NEVER;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/git-pull.sh b/git-pull.sh
index 270a50d..03b7da0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -20,6 +20,7 @@ strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
+preservemerges=$(git config --bool branch.$curr_branch_short.preservemerges)
 while :
 do
 	case "$1" in
@@ -59,7 +60,7 @@ do
 		rebase=true
 		;;
 	--preserve-merges) # no short option for this
-		preserve_merges="--preserve-merges"
+		preservemerges=true
 		rebase=true
 		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
@@ -181,9 +182,14 @@ then
 	exit
 fi
 
+if test true = "$preservemerges"
+then
+	preservemerges_flag="--preserve-merges"
+fi
+
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
-	exec git-rebase $preserve_merges $strategy_args --onto $merge_head \
+	exec git-rebase $preservemerges_flag $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
 exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 2147eac..f10b8ac 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -228,103 +228,121 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase local &&
+	git config branch.autosetuppreservemerges local &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase &&
 	git branch --track myr1 mybase &&
 	test "$(git config branch.myr1.remote)" = . &&
 	test "$(git config branch.myr1.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr1.rebase)" = true
+	test "$(git config branch.myr1.rebase)" = true &&
+	test "$(git config branch.myr1.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase always on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase always &&
+	git config branch.autosetuppreservemerges always &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase2 &&
 	git branch --track myr2 mybase &&
 	test "$(git config branch.myr2.remote)" = . &&
 	test "$(git config branch.myr2.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr2.rebase)" = true
+	test "$(git config branch.myr2.rebase)" = true &&
+	test "$(git config branch.myr2.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase remote on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
+	git config branch.autosetuppreservemerges remote &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase3 &&
 	git branch --track myr3 mybase2 &&
 	test "$(git config branch.myr3.remote)" = . &&
 	test "$(git config branch.myr3.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr3.rebase)" = true
+	! test "$(git config branch.myr3.rebase)" = true &&
+	! test "$(git config branch.myr3.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase never on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase never &&
+	git config branch.autosetuppreservemerges never &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase4 &&
 	git branch --track myr4 mybase2 &&
 	test "$(git config branch.myr4.remote)" = . &&
 	test "$(git config branch.myr4.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr4.rebase)" = true
+	! test "$(git config branch.myr4.rebase)" = true &&
+	! test "$(git config branch.myr4.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase local &&
+	git config branch.autosetuppreservemerges local &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr5 local/master &&
 	test "$(git config branch.myr5.remote)" = local &&
 	test "$(git config branch.myr5.merge)" = refs/heads/master &&
-	! test "$(git config branch.myr5.rebase)" = true
+	! test "$(git config branch.myr5.rebase)" = true &&
+	! test "$(git config branch.myr5.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase never &&
+	git config branch.autosetuppreservemerges never &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr6 local/master &&
 	test "$(git config branch.myr6.remote)" = local &&
 	test "$(git config branch.myr6.merge)" = refs/heads/master &&
-	! test "$(git config branch.myr6.rebase)" = true
+	! test "$(git config branch.myr6.rebase)" = true &&
+	! test "$(git config branch.myr6.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
+	git config branch.autosetuppreservemerges remote &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr7 local/master &&
 	test "$(git config branch.myr7.remote)" = local &&
 	test "$(git config branch.myr7.merge)" = refs/heads/master &&
-	test "$(git config branch.myr7.rebase)" = true
+	test "$(git config branch.myr7.rebase)" = true &&
+	test "$(git config branch.myr7.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
+	git config branch.autosetuppreservemerges remote &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr8 local/master &&
 	test "$(git config branch.myr8.remote)" = local &&
 	test "$(git config branch.myr8.merge)" = refs/heads/master &&
-	test "$(git config branch.myr8.rebase)" = true
+	test "$(git config branch.myr8.rebase)" = true &&
+	test "$(git config branch.myr8.preservemerges)" = true
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 	git config --unset branch.autosetuprebase &&
+	git config --unset branch.autosetuppreservemerges &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr9 local/master &&
 	test "$(git config branch.myr9.remote)" = local &&
 	test "$(git config branch.myr9.merge)" = refs/heads/master &&
-	test "z$(git config branch.myr9.rebase)" = z
+	test "z$(git config branch.myr9.rebase)" = z &&
+	test "z$(git config branch.myr9.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
@@ -335,7 +353,8 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 	git branch --track myr10 mybase2 &&
 	test "$(git config branch.myr10.remote)" = . &&
 	test "$(git config branch.myr10.merge)" = refs/heads/mybase2 &&
-	test "z$(git config branch.myr10.rebase)" = z
+	test "z$(git config branch.myr10.rebase)" = z &&
+	test "z$(git config branch.myr10.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
@@ -345,7 +364,8 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git branch --no-track myr11 mybase2 &&
 	test "z$(git config branch.myr11.remote)" = z &&
 	test "z$(git config branch.myr11.merge)" = z &&
-	test "z$(git config branch.myr11.rebase)" = z
+	test "z$(git config branch.myr11.rebase)" = z &&
+	test "z$(git config branch.myr11.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
@@ -355,95 +375,112 @@ test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 	git branch --no-track myr12 local/master &&
 	test "z$(git config branch.myr12.remote)" = z &&
 	test "z$(git config branch.myr12.merge)" = z &&
-	test "z$(git config branch.myr12.rebase)" = z
+	test "z$(git config branch.myr12.rebase)" = z &&
+	test "z$(git config branch.myr12.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git config branch.autosetuprebase never &&
+	git config branch.autosetuppreservemerges never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr13 mybase2 &&
 	test "z$(git config branch.myr13.remote)" = z &&
 	test "z$(git config branch.myr13.merge)" = z &&
-	test "z$(git config branch.myr13.rebase)" = z
+	test "z$(git config branch.myr13.rebase)" = z &&
+	test "z$(git config branch.myr13.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git config branch.autosetuprebase local &&
+	git config branch.autosetuppreservemerges local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr14 mybase2 &&
 	test "z$(git config branch.myr14.remote)" = z &&
 	test "z$(git config branch.myr14.merge)" = z &&
-	test "z$(git config branch.myr14.rebase)" = z
+	test "z$(git config branch.myr14.rebase)" = z &&
+	test "z$(git config branch.myr14.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git config branch.autosetuprebase remote &&
+	git config branch.autosetuppreservemerges remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr15 mybase2 &&
 	test "z$(git config branch.myr15.remote)" = z &&
 	test "z$(git config branch.myr15.merge)" = z &&
-	test "z$(git config branch.myr15.rebase)" = z
+	test "z$(git config branch.myr15.rebase)" = z &&
+	test "z$(git config branch.myr15.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git config branch.autosetuprebase always &&
+	git config branch.autosetuppreservemerges always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr16 mybase2 &&
 	test "z$(git config branch.myr16.remote)" = z &&
 	test "z$(git config branch.myr16.merge)" = z &&
-	test "z$(git config branch.myr16.rebase)" = z
+	test "z$(git config branch.myr16.rebase)" = z &&
+	test "z$(git config branch.myr16.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase never on an untracked remote branch' '
 	git config branch.autosetuprebase never &&
+	git config branch.autosetuppreservemerges never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr17 local/master &&
 	test "z$(git config branch.myr17.remote)" = z &&
 	test "z$(git config branch.myr17.merge)" = z &&
-	test "z$(git config branch.myr17.rebase)" = z
+	test "z$(git config branch.myr17.rebase)" = z &&
+	test "z$(git config branch.myr17.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase local on an untracked remote branch' '
 	git config branch.autosetuprebase local &&
+	git config branch.autosetuppreservemerges local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr18 local/master &&
 	test "z$(git config branch.myr18.remote)" = z &&
 	test "z$(git config branch.myr18.merge)" = z &&
-	test "z$(git config branch.myr18.rebase)" = z
+	test "z$(git config branch.myr18.rebase)" = z &&
+	test "z$(git config branch.myr18.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 	git config branch.autosetuprebase remote &&
+	git config branch.autosetuppreservemerges remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr19 local/master &&
 	test "z$(git config branch.myr19.remote)" = z &&
 	test "z$(git config branch.myr19.merge)" = z &&
-	test "z$(git config branch.myr19.rebase)" = z
+	test "z$(git config branch.myr19.rebase)" = z &&
+	test "z$(git config branch.myr19.preservemerges)" = z
 '
 
 test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	git config branch.autosetuprebase always &&
+	git config branch.autosetuppreservemerges always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr20 local/master &&
 	test "z$(git config branch.myr20.remote)" = z &&
 	test "z$(git config branch.myr20.merge)" = z &&
-	test "z$(git config branch.myr20.rebase)" = z
+	test "z$(git config branch.myr20.rebase)" = z &&
+	test "z$(git config branch.myr20.preservemerges)" = z
 '
 
 test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
@@ -451,6 +488,11 @@ test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
 	test_must_fail git branch
 '
 
+test_expect_success 'detect misconfigured autosetuppreservemerges (bad value)' '
+	git config branch.autosetuppreservemerges garbage &&
+	test_must_fail git branch
+'
+
 test_expect_success 'detect misconfigured autosetuprebase (no value)' '
 	git config --unset branch.autosetuprebase &&
 	echo "[branch] autosetuprebase" >> .git/config &&
@@ -458,4 +500,11 @@ test_expect_success 'detect misconfigured autosetuprebase (no value)' '
 	git config --unset branch.autosetuprebase
 '
 
+test_expect_success 'detect misconfigured autosetuppreservemerges (no value)' '
+	git config --unset branch.autosetuppreservemerges &&
+	echo "[branch] autosetuppreservemerges" >> .git/config &&
+	test_must_fail git branch &&
+	git config --unset branch.autosetuppreservemerges
+'
+
 test_done
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 9a376ef..5f4ce56 100644
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -25,44 +25,59 @@ export GIT_AUTHOR_EMAIL
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
 	git add A &&
-	git-commit -m "Add A1" &&
+	git-commit -m A1 &&
 	git checkout -b topic &&
 	echo Second > B &&
 	git add B &&
-	git-commit -m "Add B1" &&
+	git-commit -m B1 &&
+	git tag B1 &&
+	echo Third >> B &&
+	git commit -a -m B2
 	git checkout -f master &&
-	echo Third >> A &&
-	git-commit -a -m "Modify A2" &&
+	echo Fourth >> A &&
+	git-commit -a -m A2 &&
+	git clone . clone
+'
 
-	git clone ./. clone1 &&
-	cd clone1 &&
+test_expect_success 'git pull --rebase -p on moved topic' '
+	cd clone &&
 	git checkout -b topic origin/topic &&
+	git reset --hard B1 &&
 	git merge origin/master &&
+	git pull --rebase --preserve-merges &&
+	test $(git rev-list --all --pretty=oneline | grep A2 | wc -l) = 1 &&
+	git checkout origin/topic &&
+	git branch -D topic &&
 	cd ..
+'
 
-	git clone ./. clone2
-	cd clone2 &&
+test_expect_success 'rebase -p merge on moved topic' '
+	cd clone &&
 	git checkout -b topic origin/topic &&
+	git reset --hard B1 &&
 	git merge origin/master &&
-	cd .. &&
-
-	git checkout topic &&
-	echo Fourth >> B &&
-	git commit -a -m "Modify B2"
-'
-
-test_expect_success 'git pull --rebase -p on moved topic' '
-	cd clone1 &&
-	git pull --rebase --preserve-merges &&
-	test $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) = 1
+	git rebase -p origin/topic &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep A2 | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l) &&
+	git checkout origin/topic &&
+	git branch -D topic &&
+	cd ..
 '
 
-test_expect_success 'rebase -p merge on moved topic' '
-	cd ../clone2 &&
-	git fetch &&
-	git rebase -p origin/topic &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l)
+test_expect_success 'git pull on moved topic' '
+	cd clone &&
+	git config branch.autosetuppreservemerges always &&
+	git checkout -b topic origin/topic &&
+	test true = $(git config branch.topic.preservemerges) &&
+	git reset --hard B1 &&
+	git merge origin/master &&
+	git pull &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep A2 | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l) &&
+	git checkout origin/topic &&
+	git branch -D topic &&
+	cd ..
 '
 
 test_done
+
-- 
1.6.0.2
