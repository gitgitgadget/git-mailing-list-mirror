From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] branch: optionally setup branch.*.merge from upstream local branches
Date: Tue, 19 Feb 2008 11:24:37 -0500
Message-ID: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 17:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVHV-0008KA-VW
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbYBSQYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYBSQYq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:24:46 -0500
Received: from hs-out-0708.google.com ([64.233.178.246]:58673 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbYBSQYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:24:44 -0500
Received: by hs-out-0708.google.com with SMTP id 54so1886549hsz.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 08:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=unBvD96WKWSz7VAFCvd+aV7Fwaj5m6u7O/M+/QBEG+o=;
        b=A/1v6zyhIXSOMAjoT/VjOdBAMKgDDfxHzj+SbbD1CzNav63kXV0PX6GTJ08uxXBLoX+9+5hhP/TXLHyjUdIIoaQXivfAmeVJb8N1mppXx1UbsaqvuWe8l583J+aOtr5ytc51rQgx2xmcWzUZq6sDpDjZmYtzE6PLNU9CeIaV0UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WZbJKtpYQPaFBFtIEsWckC4OVHLn9E/5UBH/yJKNBV001Krh2pvfpkZ1HdmAxLQipazrn1lDIPek+dDa5R+HCYUr/kFhnag8u9Shh4tOifurxJ8oQm5FWwu82Jv72s2Qy8zOVz8t1f5VMKtEkMAYaBzIzEVg0K2wG6pD0uUFIkE=
Received: by 10.100.166.10 with SMTP id o10mr14565681ane.53.1203438283336;
        Tue, 19 Feb 2008 08:24:43 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d12sm13587534and.24.2008.02.19.08.24.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Feb 2008 08:24:42 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.203.g1b97.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74423>

git branch / git checkout -b now honor --track when the upstream branch
is local. Previously --track was silently ignored for local upstream
branches.

The configuration setting branch.autosetupmerge can now be set to
"always" which is equivalent to using --track. Setting
branch.autosetupmerge to boolean true will retains the former behavior
of only setting up branch.*.merge for remote upstream branches.

Includes test cases for the new functionality.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
- I broke out the documentation changes into a separate patch.

- Incorporated Johannes' suggested change to setup_tracking().

- Incorporated Junio's suggestion that explicit --track should cause a
  failure when the starting point is not a branch.

 branch.c           |   44 ++++++++++++++++++++++++--------------------
 branch.h           |    2 +-
 builtin-branch.c   |   14 +++++---------
 builtin-checkout.c |   14 +++++---------
 cache.h            |    9 +++++++++
 config.c           |    8 ++++++++
 environment.c      |    1 +
 t/t3200-branch.sh  |   22 +++++++++++++++++++++-
 t/t7201-co.sh      |   24 ++++++++++++++++++++++++
 9 files changed, 98 insertions(+), 40 deletions(-)

diff --git a/branch.c b/branch.c
index 1fc8788..daf862e 100644
--- a/branch.c
+++ b/branch.c
@@ -37,7 +37,8 @@ static int find_tracked_branch(struct remote *remote, void *priv)
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
  * config.
  */
-static int setup_tracking(const char *new_ref, const char *orig_ref)
+static int setup_tracking(const char *new_ref, const char *orig_ref,
+                          enum branch_track track)
 {
 	char key[1024];
 	struct tracking tracking;
@@ -48,30 +49,36 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking) ||
-			!tracking.matches)
+	if (for_each_remote(find_tracked_branch, &tracking))
 		return 1;
 
+	if (!tracking.matches)
+		switch (track) {
+		case BRANCH_TRACK_ALWAYS:
+		case BRANCH_TRACK_EXPLICIT:
+			break;
+		default:
+			return 1;
+		}
+
 	if (tracking.matches > 1)
 		return error("Not tracking: ambiguous information for ref %s",
 				orig_ref);
 
-	if (tracking.matches == 1) {
-		sprintf(key, "branch.%s.remote", new_ref);
-		git_config_set(key, tracking.remote ?  tracking.remote : ".");
-		sprintf(key, "branch.%s.merge", new_ref);
-		git_config_set(key, tracking.src);
-		free(tracking.src);
-		printf("Branch %s set up to track remote branch %s.\n",
-			       new_ref, orig_ref);
-	}
+	sprintf(key, "branch.%s.remote", new_ref);
+	git_config_set(key, tracking.remote ?  tracking.remote : ".");
+	sprintf(key, "branch.%s.merge", new_ref);
+	git_config_set(key, tracking.src ? tracking.src : orig_ref);
+	free(tracking.src);
+	printf("Branch %s set up to track %s branch %s.\n", new_ref,
+		tracking.remote ? "remote" : "local", orig_ref);
 
 	return 0;
 }
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
-		   int force, int reflog, int track)
+		   int force, int reflog, enum branch_track track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
@@ -98,7 +105,8 @@ void create_branch(const char *head,
 	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
 	case 0:
 		/* Not branching from any existing branch */
-		real_ref = NULL;
+		if (track == BRANCH_TRACK_EXPLICIT)
+			die("Cannot setup tracking information; starting point is not a branch.");
 		break;
 	case 1:
 		/* Unique completion -- good */
@@ -126,17 +134,13 @@ void create_branch(const char *head,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
-	/* When branching off a remote branch, set up so that git-pull
-	   automatically merges from there.  So far, this is only done for
-	   remotes registered via .git/config.  */
 	if (real_ref && track)
-		setup_tracking(name, real_ref);
+		setup_tracking(name, real_ref, track);
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
 
-	if (real_ref)
-		free(real_ref);
+	free(real_ref);
 }
 
 void remove_branch_state(void)
diff --git a/branch.h b/branch.h
index d30abe0..9f0c2a2 100644
--- a/branch.h
+++ b/branch.h
@@ -13,7 +13,7 @@
  * branch for (if any).
  */
 void create_branch(const char *head, const char *name, const char *start_name,
-		   int force, int reflog, int track);
+		   int force, int reflog, enum branch_track track);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin-branch.c b/builtin-branch.c
index 7e99103..a784445 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -30,8 +30,6 @@ static const char * const builtin_branch_usage[] = {
 static const char *head;
 static unsigned char head_sha1[20];
 
-static int branch_track = 1;
-
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -76,10 +74,6 @@ static int git_branch_config(const char *var, const char *value)
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
-	if (!strcmp(var, "branch.autosetupmerge")) {
-		branch_track = git_config_bool(var, value);
-		return 0;
-	}
 	return git_color_default_config(var, value);
 }
 
@@ -420,14 +414,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0, track;
+	int reflog = 0;
+	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose),
-		OPT_BOOLEAN( 0 , "track",  &track, "set up tracking mode (see git-pull(1))"),
+		OPT_SET_INT( 0 , "track",  &track, "set up tracking mode (see git-pull(1))",
+			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
@@ -458,7 +454,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (branch_use_color == -1)
 		branch_use_color = git_use_color_default;
 
-	track = branch_track;
+	track = git_branch_track;
 	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
 	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 0d19835..73df7f0 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -186,7 +186,7 @@ struct checkout_opts {
 
 	char *new_branch;
 	int new_branch_log;
-	int track;
+	enum branch_track track;
 };
 
 struct branch_info {
@@ -521,13 +521,8 @@ static int switch_branches(struct checkout_opts *opts,
 	return post_checkout_hook(old.commit, new->commit, 1);
 }
 
-static int branch_track = 0;
-
 static int git_checkout_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "branch.autosetupmerge"))
-		branch_track = git_config_bool(var, value);
-
 	return git_default_config(var, value);
 }
 
@@ -542,7 +537,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
-		OPT_BOOLEAN( 0 , "track", &opts.track, "track"),
+		OPT_SET_INT( 0 , "track",  &opts.track, "track",
+			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
 		OPT_END(),
@@ -553,7 +549,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	git_config(git_checkout_config);
 
-	opts.track = branch_track;
+	opts.track = git_branch_track;
 
 	argc = parse_options(argc, argv, options, checkout_usage, 0);
 	if (argc) {
@@ -582,7 +578,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
-	if (!opts.new_branch && (opts.track != branch_track))
+	if (!opts.new_branch && (opts.track != git_branch_track))
 		die("git checkout: --track and --no-track require -b");
 
 	if (opts.force && opts.merge)
diff --git a/cache.h b/cache.h
index 2b59c44..a5b9ffd 100644
--- a/cache.h
+++ b/cache.h
@@ -393,6 +393,15 @@ enum safe_crlf {
 
 extern enum safe_crlf safe_crlf;
 
+enum branch_track {
+	BRANCH_TRACK_NEVER = 0,
+	BRANCH_TRACK_REMOTE,
+	BRANCH_TRACK_ALWAYS,
+	BRANCH_TRACK_EXPLICIT,
+};
+
+extern enum branch_track git_branch_track;
+
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
 extern int check_repository_format(void);
diff --git a/config.c b/config.c
index 8064cae..556b2ec 100644
--- a/config.c
+++ b/config.c
@@ -464,6 +464,14 @@ int git_default_config(const char *var, const char *value)
 		whitespace_rule_cfg = parse_whitespace_rule(value);
 		return 0;
 	}
+	if (!strcmp(var, "branch.autosetupmerge")) {
+		if (value && !strcasecmp(value, "always")) {
+			git_branch_track = BRANCH_TRACK_ALWAYS;
+			return 0;
+		}
+		git_branch_track = git_config_bool(var, value);
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index 3527f16..6739a3f 100644
--- a/environment.c
+++ b/environment.c
@@ -37,6 +37,7 @@ const char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
+enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d21081d..38a90ad 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -15,6 +15,9 @@ test_expect_success \
     'echo Hello > A &&
      git update-index --add A &&
      git-commit -m "Initial commit." &&
+     echo World >> A &&
+     git update-index --add A &&
+     git-commit -m "Second commit." &&
      HEAD=$(git rev-parse --verify HEAD)'
 
 test_expect_success \
@@ -171,7 +174,9 @@ test_expect_success 'test overriding tracking setup via --no-track' \
      ! test "$(git config branch.my2.merge)" = refs/heads/master'
 
 test_expect_success 'no tracking without .fetch entries' \
-    'git branch --track my6 s &&
+    'git config branch.autosetupmerge true &&
+     git branch my6 s &&
+     git config branch.automsetupmerge false &&
      test -z "$(git config branch.my6.remote)" &&
      test -z "$(git config branch.my6.merge)"'
 
@@ -192,6 +197,21 @@ test_expect_success 'test deleting branch without config' \
     'git branch my7 s &&
      test "$(git branch -d my7 2>&1)" = "Deleted branch my7."'
 
+test_expect_success 'test --track without .fetch entries' \
+    'git branch --track my8 &&
+     test "$(git config branch.my8.remote)" &&
+     test "$(git config branch.my8.merge)"'
+
+test_expect_success \
+    'branch from non-branch HEAD w/autosetupmerge=always' \
+    'git config branch.autosetupmerge always &&
+     git branch my9 HEAD^ &&
+     git config branch.autosetupmerge false'
+
+test_expect_success \
+    'branch from non-branch HEAD w/--track causes failure' \
+    '!(git branch --track my10 HEAD^)'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 06959d9..0a6c6ed 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -279,4 +279,28 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 
 '
 
+test_expect_success \
+    'checkout w/--track sets up tracking' '
+    git config branch.autosetupmerge false &&
+    git checkout master &&
+    git checkout --track -b track1 &&
+    test "$(git config branch.track1.remote)" &&
+    test "$(git config branch.track1.merge)"'
+
+test_expect_success \
+    'checkout w/autosetupmerge=always sets up tracking' '
+    git config branch.autosetupmerge always &&
+    git checkout master &&
+    git checkout -b track2 &&
+    test "$(git config branch.track2.remote)" &&
+    test "$(git config branch.track2.merge)"
+    git config branch.autosetupmerge false'
+
+test_expect_success \
+    'checkout w/--track from non-branch HEAD fails' '
+    git checkout -b delete-me master &&
+    rm .git/refs/heads/delete-me &&
+    test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
+    !(git checkout --track -b track)'
+
 test_done
-- 
1.5.4.2.203.g1b97.dirty
