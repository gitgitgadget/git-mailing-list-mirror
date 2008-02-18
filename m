From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Mon, 18 Feb 2008 08:53:37 -0500
Message-ID: <1203342817-19653-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 14:54:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6S4-0005ki-50
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbYBRNxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbYBRNxp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:53:45 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:53921 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYBRNxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:53:42 -0500
Received: by an-out-0708.google.com with SMTP id d31so387754and.103
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=uahLSiYmtXxViOY2LVG4yNnziOyjdTpXpPfy4IY2pfw=;
        b=GWWFAABs8RrxuohJcF3s37+PZ/ySXrQFrQUdrhpsVqnQI0VP7UUPJih8ceZyXMJ4fFm+QaYDi7Ucdli2Pq1gsJ6EgnXFnh9nA8wJITo17kEiEPkb/nnZ1rTtTYRQwnU07MA6zsdbl/HemQzfR3/09MsB9Gk+PUtLuj/M9uZo4TU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=F+JFFzGjJOSaKsAYyBN47I5dCiyOFyB9DrXrE4Z1K//nFmEZSZR0+0Gqco3uiVeErQhDbj03EFkEUyqDn0fOAUTDmg3FhP6hdTRY329xQDADSah5nQfkRqi1nKHqRB4DMjJmceVxoQ5IqmesdZ88MLwgnRDwcvKWnEsNSpes1EY=
Received: by 10.100.210.9 with SMTP id i9mr11459992ang.40.1203342821660;
        Mon, 18 Feb 2008 05:53:41 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d34sm13460893and.8.2008.02.18.05.53.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 05:53:40 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.203.gf8d86
In-Reply-To: alpine.LSU.1.00.0802181328380.30505@racer.site
References: alpine.LSU.1.00.0802181328380.30505@racer.site
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74289>

git branch / git checkout -b now honor --track when the upstream branch
is local. Previously --track was silently ignored for local upstream
branches.

The configuration setting branch.autosetupmerge can now be set to
"always" which is equivalent to using --track. Setting
branch.autosetupmerge to boolean true will retains the former behavior
of only setting up branch.*.merge for remote upstream branches.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Incorporated Johannes' second round of feedback. This should be all for awhile.

 Documentation/config.txt       |   13 ++++++++-----
 Documentation/git-branch.txt   |   24 ++++++++++++------------
 Documentation/git-checkout.txt |   25 ++++++++++++-------------
 branch.c                       |   19 ++++++++++++-------
 branch.h                       |    2 +-
 builtin-branch.c               |   13 ++++---------
 builtin-checkout.c             |   13 ++++---------
 cache.h                        |    8 ++++++++
 config.c                       |    8 ++++++++
 environment.c                  |    1 +
 10 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb6dae0..f15fe0a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -378,11 +378,14 @@ apply.whitespace::
 	as the '--whitespace' option. See linkgit:git-apply[1].
 
 branch.autosetupmerge::
-	Tells `git-branch` and `git-checkout` to setup new branches
-	so that linkgit:git-pull[1] will appropriately merge from that
-	remote branch.  Note that even if this option is not set,
-	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options.  This option defaults to true.
+	Tells `git-branch` and `git-checkout` to setup `branch.*.remote`
+	and `branch.*.merge` for new branches so that linkgit:git-pull[1]
+	will appropriately merge from that upstream branch. Note that even
+	if this option is not set, this behavior can be chosen per-branch
+	using the `--track`	and `--no-track` options. This option defaults
+	to true, which will setup tracking for remote branches. Set it to
+	`always` to automatically setup the aforementioned options for local
+	upstream branches as well.
 
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 7e8874a..ce2fc64 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -105,20 +105,20 @@ OPTIONS
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
+	Set up configuration so that git-pull will
+	automatically retrieve data from the upstream branch.  Use this if
+	you always pull from the same upstream branch into the new branch,
+	or if you don't want to use "git pull <repository> <refspec>"
+	explicitly. This behavior is the default for remote branches.
+	Set the branch.autosetupmerge configuration variable to false if you
+	want git-checkout and git-branch to always behave as if '--no-track'
+	were given. Set it to 'always' if you want git-checkout and git-branch
+	to always behave as if '--track' were given.
 
 --no-track::
-	When a branch is created off a remote branch,
-	set up configuration so that git-pull will not retrieve data
-	from the remote branch, ignoring the branch.autosetupmerge
-	configuration variable.
+	Ignore the branch.autosetupmerge configuration variable. When
+	using git pull with the new branch, a <refspec> will have to be
+	given explicitly.
 
 <branchname>::
 	The name of the branch to create or delete.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b4cfa04..ad2ab51 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -48,21 +48,20 @@ OPTIONS
 	may restrict the characters allowed in a branch name.
 
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
+	When -b is given set up configuration so that git-pull will
+	automatically retrieve data from the upstream branch.  Use this if
+	you always pull from the same upstream branch into the new branch,
+	or if you don't want to use "git pull <repository> <refspec>"
+	explicitly. This behavior is the default for remote branches.
+	Set the branch.autosetupmerge configuration variable to false if you
+	want git-checkout and git-branch to always behave as if '--no-track'
+	were given. Set it to 'always' if you want git-checkout and git-branch
+	to always behave as if '--track' were given.
 
 --no-track::
-	When -b is given and a branch is created off a remote branch,
-	set up configuration so that git-pull will not retrieve data
-	from the remote branch, ignoring the branch.autosetupmerge
-	configuration variable.
+	Ignore the branch.autosetupmerge configuration variable. When
+	using git pull with the new branch, a <refspec> will have to be
+	given explicitly.
 
 -l::
 	Create the new branch's reflog.  This activates recording of
diff --git a/branch.c b/branch.c
index 1fc8788..64f0a4a 100644
--- a/branch.c
+++ b/branch.c
@@ -37,7 +37,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
  * config.
  */
-static int setup_tracking(const char *new_ref, const char *orig_ref)
+static int setup_tracking(const char *new_ref, const char *orig_ref, int always)
 {
 	char key[1024];
 	struct tracking tracking;
@@ -49,8 +49,12 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (for_each_remote(find_tracked_branch, &tracking) ||
-			!tracking.matches)
-		return 1;
+			!tracking.matches) {
+		if (!always)
+			return 1;
+		tracking.matches = 1;
+		tracking.src = xstrdup(orig_ref);
+	}
 
 	if (tracking.matches > 1)
 		return error("Not tracking: ambiguous information for ref %s",
@@ -62,8 +66,9 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
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
@@ -71,7 +76,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
-		   int force, int reflog, int track)
+		   int force, int reflog, enum branch_track track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
@@ -130,7 +135,7 @@ void create_branch(const char *head,
 	   automatically merges from there.  So far, this is only done for
 	   remotes registered via .git/config.  */
 	if (real_ref && track)
-		setup_tracking(name, real_ref);
+		setup_tracking(name, real_ref, (track == BRANCH_TRACK_ALWAYS));
 
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
index 7e99103..3b53bb7 100644
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
 
@@ -420,14 +414,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
+		OPT_SET_INT( 0 , "track",  &track, "set up tracking mode (see git-pull(1))", BRANCH_TRACK_ALWAYS),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
@@ -458,7 +453,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
index 2b59c44..90b3a9e 100644
--- a/cache.h
+++ b/cache.h
@@ -393,6 +393,14 @@ enum safe_crlf {
 
 extern enum safe_crlf safe_crlf;
 
+enum branch_track {
+	BRANCH_TRACK_REMOTES_FALSE = 0,
+	BRANCH_TRACK_REMOTES_TRUE,
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
index 3527f16..24334a2 100644
--- a/environment.c
+++ b/environment.c
@@ -37,6 +37,7 @@ const char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
+enum branch_track git_branch_track = BRANCH_TRACK_REMOTES_TRUE;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
-- 
1.5.4.2.203.gf8d86
