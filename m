From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Mon, 18 Feb 2008 21:07:12 -0500
Message-ID: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 03:08:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRHto-0004tc-1P
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 03:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbYBSCHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 21:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbYBSCHX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 21:07:23 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:18094 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbYBSCHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 21:07:20 -0500
Received: by an-out-0708.google.com with SMTP id d31so448172and.103
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 18:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=01x1TogU9Em3I+58Ur8h7fUHtzymZCwRbW+JXnWThtk=;
        b=amsic5WyEFwl8M8wPhKLfjzuXV7u8RZDZlEF8iwG511HTfwvlWL9UUuz3+SClWT4qMtkDHPJUMAF6cbSYIsgAf404sfRXXLrtqP0TpZ/Urh+Ul1UM1d5ag5WGWL2wiJr7M/gvqvrM0rtOx6def7wv8njT/0EgVQpRnDqL3YvkN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=OOlBcUoYGpErpl1fHNhMEm0dM6RtOVJLCHKlALIzzd97eFjAosNlkDI4zLC4N1qyC5ug/jf/2NbsiVk1nN260suPr0pYmaapO++1wDiinSfnhaSSHSD5I5cH2chxPsmIJ6NLp3RM1OX/uGV26u9qfLllEiFL5PwDvldXbcz3Zck=
Received: by 10.100.42.4 with SMTP id p4mr2973527anp.73.1203386839235;
        Mon, 18 Feb 2008 18:07:19 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d38sm12635918and.17.2008.02.18.18.07.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 18:07:17 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.203.gf8d86
In-Reply-To: 1203342817-19653-1-git-send-email-jaysoffian@gmail.com
References: 1203342817-19653-1-git-send-email-jaysoffian@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74365>

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
Changes from last iteration:

- Reworked the documentation. I incorporated some of Junio's suggestions, but
  I made a lot of other clarifications (IMO...). Let me know what you think.

- Added a suggested test case to t7201-co and some of my own to t3200-branch.

- Renamed the enum values per Junio.

- Incorporated suggestions from Junio and Johannes re:setup_tracking().

- The code/doc/and test case changes are now all in this commit together (I
  don't think it's too much for review...?)

Thanks for the feedback so far.

 Documentation/config.txt       |   15 ++++++---
 Documentation/git-branch.txt   |   69 +++++++++++++++++-----------------------
 Documentation/git-checkout.txt |   61 ++++++++++++++++++-----------------
 branch.c                       |   20 +++++++----
 branch.h                       |    2 +-
 builtin-branch.c               |   14 +++-----
 builtin-checkout.c             |   13 ++-----
 cache.h                        |    8 +++++
 config.c                       |    8 +++++
 environment.c                  |    1 +
 t/t3200-branch.sh              |   32 ++++++++++++++++--
 t/t7201-co.sh                  |    8 +++++
 12 files changed, 147 insertions(+), 104 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb6dae0..fd4904f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -378,11 +378,16 @@ apply.whitespace::
 	as the '--whitespace' option. See linkgit:git-apply[1].
 
 branch.autosetupmerge::
-	Tells `git-branch` and `git-checkout` to setup new branches
-	so that linkgit:git-pull[1] will appropriately merge from that
-	remote branch.  Note that even if this option is not set,
-	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options.  This option defaults to true.
+	When setting up new branch <name> from existing branch
+	<starting-point>, tells linkgit:git-branch[1] and
+	linkgit:git-checkout[1] to configure branch.<name>.remote and
+	branch.<name>.merge for use with linkgit:git-fetch[1] and
+	linkgit:git-pull[1]. There are three valid settings: `false` -- no
+	automatic setup; `true` -- automatic setup when <starting-poiint> is
+	a remote branch; `always` -- automatic setup when <starting-point>
+	is either a local or remote branch. The `--track` and `--no-track`
+	options to linkgit:git-branch[1] and linkgit:git-checkout[1] always
+	override this setting. The default is `true`.
 
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 7e8874a..3ad9dc0 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,9 +11,9 @@ SYNOPSIS
 'git-branch' [--color | --no-color] [-r | -a]
 	   [-v [--abbrev=<length> | --no-abbrev]]
 	   [--contains <commit>]
-'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
-'git-branch' (-m | -M) [<oldbranch>] <newbranch>
-'git-branch' (-d | -D) [-r] <branchname>...
+'git-branch' [--track | --no-track] [-l] [-f] <newbranch> [<start-point>]
+'git-branch' (-m | -M) [<branch>] <newbranch>
+'git-branch' (-d | -D) [-r] <branch>...
 
 DESCRIPTION
 -----------
@@ -25,29 +25,25 @@ With `--contains <commit>`, shows only the branches that
 contains the named commit (in other words, the branches whose
 tip commits are descendant of the named commit).
 
-In its second form, a new branch named <branchname> will be created.
-It will start out with a head equal to the one given as <start-point>.
-If no <start-point> is given, the branch will be created with a head
-equal to that of the currently checked out branch.
+In its second form, a new branch named <newbranch> will be created.
+It will start out with a head equal to <start-point>. If no
+<start-point> is given, it is assumed to be the currently checked
+out branch. The new branch may optionally be configured for use with
+linkgit:git-pull[1] -- see `--track` and `--no-track` in the OPTIONS
+section below.
 
 Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
-new branch.
+new branch. (As a shortcut consider using "git checkout [--track | 
+--notrack ] -b <newbranch>" instead.)
 
-When a local branch is started off a remote branch, git sets up the
-branch so that linkgit:git-pull[1] will appropriately merge from that
-remote branch.  If this behavior is not desired, it is possible to
-disable it using the global `branch.autosetupmerge` configuration
-flag.  That setting can be overridden by using the `--track`
-and `--no-track` options.
-
-With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
-If <oldbranch> had a corresponding reflog, it is renamed to match
+With a '-m' or '-M' option, <branch> will be renamed to <newbranch>.
+If <branch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
 renaming. If <newbranch> exists, -M must be used to force the rename
 to happen.
 
-With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
+With a `-d` or `-D` option, `<branch>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
 
@@ -69,7 +65,7 @@ OPTIONS
 -l::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@\{yesterday}".
+	based sha1 expressions such as "<branch>@\{yesterday}".
 
 -f::
 	Force the creation of a new branch even if it means deleting
@@ -105,38 +101,31 @@ OPTIONS
 	Display the full sha1s in output listing rather than abbreviating them.
 
 --track::
-	Set up configuration so that git-pull will automatically
-	retrieve data from the remote branch.  Use this if you always
-	pull from the same remote branch into the new branch, or if you
-	don't want to use "git pull <repository> <refspec>" explicitly.
-	This behavior is the default.  Set the
-	branch.autosetupmerge configuration variable to false if you
-	want git-checkout and git-branch to always behave as if
-	'--no-track' were given.
+	Set up the new branch's configuration so that linkgit:git-pull[1]
+	will appropriately merge from the start point when run without
+	arguments while in the new branch. `--track` is the default behavior
+	when the start point is a remote branch. See the documentation for
+	the `branch.autosetupmerge` configuration variable in
+	linkgit:git-config[1] for how to modify the default.
 
 --no-track::
-	When a branch is created off a remote branch,
-	set up configuration so that git-pull will not retrieve data
-	from the remote branch, ignoring the branch.autosetupmerge
-	configuration variable.
+	Ignore the `branch.autosetupmerge` configuration variable. The new
+	branch will not be setup for automatic merging.
 
-<branchname>::
-	The name of the branch to create or delete.
+<newbranch>::
+	The name of the branch to create or rename to.
 	The new branch name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
 <start-point>::
 	The new branch will be created with a HEAD equal to this.  It may
-	be given as a branch name, a commit-id, or a tag.  If this option
-	is omitted, the current branch is assumed.
+	be given as a branch name, a commit-id, or a tag.  Defaults
+	to the current HEAD.
 
-<oldbranch>::
-	The name of an existing branch to rename.
+<branch>::
+	The name of an existing branch to rename or delete.
 
-<newbranch>::
-	The new name for an existing branch. The same restrictions as for
-	<branchname> applies.
 
 
 Examples
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b4cfa04..fd862b4 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,25 +8,27 @@ git-checkout - Checkout and switch to a branch
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-q] [-f] [[--track | --no-track] -b <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-q] [-f] [-m] <branch>
+'git-checkout' [-q] [-f] [-m] [-l] [--track | --no-track] -b <newbranch> [<start-point>]
 'git-checkout' [<tree-ish>] <paths>...
 
 DESCRIPTION
 -----------
 
-When <paths> are not given, this command switches branches by
-updating the index and working tree to reflect the specified
-branch, <branch>, and updating HEAD to be <branch> or, if
-specified, <new_branch>.  Using -b will cause <new_branch> to
-be created; in this case you can use the --track or --no-track
-options, which will be passed to `git branch`.
+It its first form this command switches branches by updating the
+index and working tree to reflect <branch> and updating HEAD to
+<branch>.
 
-When <paths> are given, this command does *not* switch
+In its second form this command optionally switches to <start-point>
+by updating the index and working tree to reflect <start-point>.
+<newbranch> is then created and HEAD is updated to it. The new
+branch may optionally be configured for use with linkgit:git-pull[1]
+-- see `--track` and `--no-track` in the OPTIONS section below.
+
+In its third form, this command does *not* switch
 branches.  It updates the named paths in the working tree from
 the index file (i.e. it runs `git-checkout-index -f -u`), or
-from a named commit.  In
-this case, the `-f` and `-b` options are meaningless and giving
-either of them results in an error.  <tree-ish> argument can be
+from a named commit. The optional <tree-ish> argument can be
 used to specify a specific tree-ish (i.e. commit, tag or tree)
 to update the index for the given paths before updating the
 working tree.
@@ -42,27 +44,23 @@ OPTIONS
 	from HEAD.  This is used to throw away local changes.
 
 -b::
-	Create a new branch named <new_branch> and start it at
-	<branch>.  The new branch name must pass all checks defined
-	by linkgit:git-check-ref-format[1].  Some of these checks
-	may restrict the characters allowed in a branch name.
+	Create a new branch named <newbranch> and start it at the optional
+	<start-point> (the currently checked out branch if not given). The
+	new branch name must pass all checks defined by
+	linkgit:git-check-ref-format[1]. Some of these checks may restrict
+	the characters allowed in a branch name.
 
 --track::
-	When -b is given and a branch is created off a remote branch,
-	set up configuration so that git-pull will automatically
-	retrieve data from the remote branch.  Use this if you always
-	pull from the same remote branch into the new branch, or if you
-	don't want to use "git pull <repository> <refspec>" explicitly.
-	This behavior is the default.  Set the
-	branch.autosetupmerge configuration variable to false if you
-	want git-checkout and git-branch to always behave as if
-	'--no-track' were given.
+	Set up the new branch's configuration so that linkgit:git-pull[1]
+	will appropriately merge from the start point when run without
+	arguments while in the new branch. `--track` is the default behavior
+	when the start point is a remote branch. See the documentation for
+	the `branch.autosetupmerge` configuration variable in
+	linkgit:git-config[1] for how to modify the default.
 
 --no-track::
-	When -b is given and a branch is created off a remote branch,
-	set up configuration so that git-pull will not retrieve data
-	from the remote branch, ignoring the branch.autosetupmerge
-	configuration variable.
+	Ignore the `branch.autosetupmerge` configuration variable. The new
+	branch will not be setup for automatic merging.
 
 -l::
 	Create the new branch's reflog.  This activates recording of
@@ -83,9 +81,14 @@ paths are left unmerged, and you need to resolve the conflicts
 and mark the resolved paths with `git add` (or `git rm` if the merge
 should result in deletion of the path).
 
-<new_branch>::
+<newbranch>::
 	Name for the new branch.
 
+<start-point>::
+	The new branch will be created with a HEAD equal to this.  It may
+	be given as a branch name, a commit-id, or a tag.  Defaults
+	to the current HEAD.
+
 <branch>::
 	Branch to checkout; may be any object ID that resolves to a
 	commit.  Defaults to HEAD.
diff --git a/branch.c b/branch.c
index 1fc8788..9d7585e 100644
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
@@ -48,10 +49,14 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking) ||
-			!tracking.matches)
+	if (for_each_remote(find_tracked_branch, &tracking))
 		return 1;
 
+	if (!tracking.matches && track == BRANCH_TRACK_ALWAYS) {
+		tracking.matches = 1;
+		tracking.src = xstrdup(orig_ref);
+	}
+
 	if (tracking.matches > 1)
 		return error("Not tracking: ambiguous information for ref %s",
 				orig_ref);
@@ -62,8 +67,9 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 		sprintf(key, "branch.%s.merge", new_ref);
 		git_config_set(key, tracking.src);
 		free(tracking.src);
-		printf("Branch %s set up to track remote branch %s.\n",
-			       new_ref, orig_ref);
+		printf("Branch %s set up to track %s branch %s.\n",
+			new_ref, tracking.remote ? "remote" : "local",
+			orig_ref);
 	}
 
 	return 0;
@@ -71,7 +77,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
-		   int force, int reflog, int track)
+		   int force, int reflog, enum branch_track track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
@@ -130,7 +136,7 @@ void create_branch(const char *head,
 	   automatically merges from there.  So far, this is only done for
 	   remotes registered via .git/config.  */
 	if (real_ref && track)
-		setup_tracking(name, real_ref);
+		setup_tracking(name, real_ref, track);
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
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
index 7e99103..bcc2354 100644
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
+			BRANCH_TRACK_ALWAYS),
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
index 0d19835..cf26e10 100644
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
 
@@ -542,7 +537,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
-		OPT_BOOLEAN( 0 , "track", &opts.track, "track"),
+		OPT_SET_INT( 0 , "track",  &opts.track, "track", BRANCH_TRACK_ALWAYS),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
 		OPT_END(),
@@ -553,7 +548,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	git_config(git_checkout_config);
 
-	opts.track = branch_track;
+	opts.track = git_branch_track;
 
 	argc = parse_options(argc, argv, options, checkout_usage, 0);
 	if (argc) {
@@ -582,7 +577,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
-	if (!opts.new_branch && (opts.track != branch_track))
+	if (!opts.new_branch && (opts.track != git_branch_track))
 		die("git checkout: --track and --no-track require -b");
 
 	if (opts.force && opts.merge)
diff --git a/cache.h b/cache.h
index 2b59c44..3c17e2c 100644
--- a/cache.h
+++ b/cache.h
@@ -393,6 +393,14 @@ enum safe_crlf {
 
 extern enum safe_crlf safe_crlf;
 
+enum branch_track {
+	BRANCH_TRACK_NEVER = 0,
+	BRANCH_TRACK_REMOTE,
+	BRANCH_TRACK_ALWAYS,
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
index d21081d..94e4dc6 100755
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
@@ -161,7 +164,7 @@ test_expect_success 'avoid ambiguous track' '
 '
 
 test_expect_success 'test overriding tracking setup via --no-track' \
-    'git config branch.autosetupmerge true &&
+    'git config branch.autosetupmerge always &&
      git config remote.local.url . &&
      git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
      (git show-ref -q refs/remotes/local/master || git-fetch local) &&
@@ -171,7 +174,9 @@ test_expect_success 'test overriding tracking setup via --no-track' \
      ! test "$(git config branch.my2.merge)" = refs/heads/master'
 
 test_expect_success 'no tracking without .fetch entries' \
-    'git branch --track my6 s &&
+    'git config branch.autosetupmerge true &&
+     git branch my6 s &&
+     git config branch.automsetupmerge false &&
      test -z "$(git config branch.my6.remote)" &&
      test -z "$(git config branch.my6.merge)"'
 
@@ -192,14 +197,33 @@ test_expect_success 'test deleting branch without config' \
     'git branch my7 s &&
      test "$(git branch -d my7 2>&1)" = "Deleted branch my7."'
 
-# Keep this test last, as it changes the current branch
+test_expect_success 'test tracking without .fetch entries w/--track given' \
+    'git branch --track my8 &&
+     test "$(git config branch.my8.remote)" &&
+     test "$(git config branch.my8.merge)"'
+
+test_expect_success \
+    'no tracking entries from non-branch HEAD even w/autosetupmerge=always)' \
+    'git config branch.autosetupmerge always &&
+     git branch my9 HEAD^ &&
+     git config branch.autosetupmerge false &&
+     test -z "$(git config branch.my9.remote)" &&
+     test -z "$(git config branch.my9.merge)"'
+
+test_expect_success \
+    'no tracking entries from non-branch HEAD even w/--track' \
+    'git branch --track my10 HEAD^ &&
+     test -z "$(git config branch.my10.remote)" &&
+     test -z "$(git config branch.my10.merge)"'
+
+# Keep this test last, as they change the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
 test_expect_success \
     'git checkout -b g/h/i -l should create a branch and a log' \
 	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git-checkout -b g/h/i -l master &&
+     git checkout -b g/h/i -l master &&
 	 test -f .git/refs/heads/g/h/i &&
 	 test -f .git/logs/refs/heads/g/h/i &&
 	 diff expect .git/logs/refs/heads/g/h/i'
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 06959d9..384e3be 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -279,4 +279,12 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 
 '
 
+test_expect_success \
+    'checkout w/--track sets up tracking w/autosetupmerge=false' '
+    git config branch.autosetupmerge false &&
+    git checkout -f master && git clean -f &&
+    git checkout --track -b track &&
+    test "$(git config branch.track.remote)" &&
+    test "$(git config branch.track.merge)"'
+
 test_done
-- 
1.5.4.2.203.gf8d86
