From: Dave Olszewski <cxreg@pobox.com>
Subject: [RFC/PATCH] branch: new option --will-track
Date: Wed, 16 Dec 2009 01:39:59 -0800
Message-ID: <1260956399-13802-1-git-send-email-cxreg@pobox.com>
Cc: Dave Olszewski <cxreg@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 10:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKqSP-0007Pz-4g
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 10:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbZLPJp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 04:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZLPJp6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 04:45:58 -0500
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:45180 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752671AbZLPJp4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 04:45:56 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2009 04:45:56 EST
X-Envelope-From: count@genericorp.net
Received: from bokonon.genericorp.net (c-76-104-180-27.hsd1.wa.comcast.net [76.104.180.27])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id nBG9e6n8031974
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Wed, 16 Dec 2009 03:40:17 -0600
Received: from count by bokonon.genericorp.net with local (Exim 4.69)
	(envelope-from <count@bokonon.genericorp.net>)
	id 1NKqMT-0003bE-15; Wed, 16 Dec 2009 01:40:01 -0800
X-Mailer: git-send-email 1.6.6.rc2.8.g5599df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135325>

A common question from users creating branches in an environment where
they intend to push the branch to a shared bare repository, and then
later pull commits from upstream into the branch that they initially
created, is how do they create the branch with this tracking info
already set up.

This feature allows them to pre-specify the tracking info in their
config, so that after the branch has been pushed, no futher action is
needed to pull future commits.

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
 Documentation/git-branch.txt   |    7 +++++++
 Documentation/git-checkout.txt |    4 ++++
 branch.c                       |    7 +++++--
 branch.h                       |    2 +-
 builtin-branch.c               |   18 +++++++++++++++++-
 builtin-checkout.c             |   19 +++++++++++++++++--
 cache.h                        |    1 +
 t/t3200-branch.sh              |    8 ++++++++
 t/t7201-co.sh                  |   10 ++++++++++
 9 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0e83680..ca7b120 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -129,6 +129,13 @@ start-point is either a local or remote branch.
 	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
 
+--will-track <remote ref>::
+	Instead of tracking the starting point, a user might wish to set
+	up tracking info for a future location of the branch once it's
+	been pushed to a remote.  Specifying this allows you to
+	configure the branch in such a way before the branch actually
+	exists on the remote.
+
 --contains <commit>::
 	Only list branches which contain the specified commit.
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..c18852a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -86,6 +86,10 @@ explicitly give a name with '-b' in such a case.
 	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
 
+--will-track <remote ref>::
+	Configure "upstream" as a yet-nonexistent remote branch.  See
+	"--will-track" in linkgit:git-branch[1] for details.
+
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
diff --git a/branch.c b/branch.c
index 05ef3f5..c3f6bbe 100644
--- a/branch.c
+++ b/branch.c
@@ -126,7 +126,8 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
-		   int force, int reflog, enum branch_track track)
+		   int force, int reflog, enum branch_track track,
+		   const char *will_track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
@@ -184,7 +185,9 @@ void create_branch(const char *head,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
-	if (real_ref && track)
+	if (will_track)
+		setup_tracking(name, will_track, track);
+	else if (real_ref && track)
 		setup_tracking(name, real_ref, track);
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
diff --git a/branch.h b/branch.h
index eed817a..30fd5c7 100644
--- a/branch.h
+++ b/branch.h
@@ -13,7 +13,7 @@
  * branch for (if any).
  */
 void create_branch(const char *head, const char *name, const char *start_name,
-		   int force, int reflog, enum branch_track track);
+		   int force, int reflog, enum branch_track track, const char *will_track);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin-branch.c b/builtin-branch.c
index 05e876e..b29e6cf 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -556,12 +556,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
+	char *will_track = NULL;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose),
 		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pull(1))",
 			BRANCH_TRACK_EXPLICIT),
+		OPT_STRING(0, "will-track", &will_track, "future remote branch",
+			"set up branch to track future remote branch"),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
@@ -628,6 +631,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (will_track) {
+		will_track = xstrdup(will_track);
+		if (strncmp(will_track, "refs/remotes/", 13)) {
+			will_track = xrealloc(will_track, sizeof(char) * (strlen(will_track) + 14));
+			memmove(will_track + 13, will_track, strlen(will_track) + 1);
+			memcpy(will_track, "refs/remotes/", 13);
+		}
+		track = BRANCH_TRACK_FUTURE;
+	}
+
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
@@ -638,9 +651,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		rename_branch(argv[0], argv[1], rename > 1);
 	else if (argc <= 2)
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
-			      force_create, reflog, track);
+			      force_create, reflog, track, will_track);
 	else
 		usage_with_options(builtin_branch_usage, options);
 
+	if (will_track)
+		free(will_track);
+
 	return 0;
 }
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..f69be79 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -34,6 +34,7 @@ struct checkout_opts {
 	const char *new_branch;
 	int new_branch_log;
 	enum branch_track track;
+	char *will_track;
 };
 
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -484,7 +485,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	const char *old_desc;
 	if (opts->new_branch) {
 		create_branch(old->name, opts->new_branch, new->name, 0,
-			      opts->new_branch_log, opts->track);
+			      opts->new_branch_log, opts->track, opts->will_track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
 	}
@@ -621,6 +622,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_STRING(0, "will-track", &opts.will_track, "future remote branch", "nonexistent branch on remote that will be tracked"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -650,7 +652,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	if (patch_mode && (opts.track > 0 || opts.new_branch
+	if (patch_mode && (opts.track > 0 || opts.new_branch || opts.will_track
 			   || opts.new_branch_log || opts.merge || opts.force))
 		die ("--patch is incompatible with all other options");
 
@@ -810,6 +812,19 @@ no_reference:
 		if (!get_sha1(buf.buf, rev))
 			die("git checkout: branch %s already exists", opts.new_branch);
 		strbuf_release(&buf);
+
+		if (opts.will_track) {
+			opts.will_track = xstrdup(opts.will_track);
+			if (strncmp(opts.will_track, "refs/remotes/", 13)) {
+				opts.will_track = xrealloc(opts.will_track,
+					sizeof(char) * (strlen(opts.will_track) + 14));
+				memmove(opts.will_track + 13, opts.will_track,
+					strlen(opts.will_track) + 1);
+				memcpy(opts.will_track, "refs/remotes/", 13);
+			}
+
+			opts.track = BRANCH_TRACK_FUTURE;
+		}
 	}
 
 	if (new.name && !new.commit) {
diff --git a/cache.h b/cache.h
index bf468e5..1dd7762 100644
--- a/cache.h
+++ b/cache.h
@@ -544,6 +544,7 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
+	BRANCH_TRACK_FUTURE,
 };
 
 enum rebase_setup_type {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d59a9b4..67e769a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -137,6 +137,14 @@ test_expect_success 'test tracking setup via --track' \
      test $(git config branch.my1.remote) = local &&
      test $(git config branch.my1.merge) = refs/heads/master'
 
+test_expect_success 'test tracking setup via --will-track' \
+    'git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
+     git branch --will-track local/my11 my11 local/master &&
+     test $(git config branch.my11.remote) = local &&
+     test $(git config branch.my11.merge) = refs/heads/my11'
+
 test_expect_success 'test tracking setup (non-wildcard, matching)' \
     'git config remote.local.url . &&
      git config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index ebfd34d..803bcad 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -330,6 +330,16 @@ test_expect_success \
     test "$(git config branch.track2.merge)"
     git config branch.autosetupmerge false'
 
+test_expect_success \
+    'checkout w/--will-track sets up tracking' '
+    git config branch.autosetupmerge false &&
+    git config remote.local.url . &&
+    git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+    git checkout master &&
+    git checkout --will-track local/track3 -b track3 &&
+    test "$(git config branch.track3.remote)" &&
+    test "$(git config branch.track3.merge)"'
+
 test_expect_success 'checkout w/--track from non-branch HEAD fails' '
     git checkout master^0 &&
     test_must_fail git symbolic-ref HEAD &&
-- 
1.6.6.rc2.8.g5599df
