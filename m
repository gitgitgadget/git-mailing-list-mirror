From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GUILT] [PATCH 6/7] Change git branch when patches are applied.
Date: Tue, 15 Jan 2013 18:30:36 -0800
Message-ID: <20130116023036.GO12524@google.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:31:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvImN-0004Su-5x
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab3APCam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:30:42 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:49251 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756839Ab3APCal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:30:41 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so425204pbc.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=o01rNUzGliJCb/GcfmX0YZdZPWwWohsZUw9SipbuHoI=;
        b=mqfzZV/wgpVPfhqx/81btZQ9fmMT6uCThcogRRW852yJNgRj0PG5pifpo6nS0qRg1o
         Hs9C9WCB9O+S8pjwGQOPxu5A4AZ+ruOiuWeNSVx09TWHc0eOdUnEdmnbDCmnYODxNyuY
         SRmyk610Huu3I5nOZaBi/M8mmjYaVx059j7uzV/8pYK91xfWxsOmy/KRJD+Wcbn9dTXl
         NoQ0+cdzr1QTP2XUHnlf0jKua7Ta8/sH2kr8R2r5n2qnuI5qwZRqqmsDZtrqa/cVTgVR
         kbYRbRXCTxNRjzefwSZkN43QJonCgV4AndMgTvkz/6TLGfb6zbJpU3E87SSHfis7wS9W
         uPWg==
X-Received: by 10.68.191.5 with SMTP id gu5mr271103724pbc.145.1358303440573;
        Tue, 15 Jan 2013 18:30:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id e6sm11960120paw.16.2013.01.15.18.30.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:30:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213714>

From: Per Cederqvist <cederp@opera.com>
Date: Mon, 30 Apr 2012 12:24:06 +0200

Apply patches on a separate branch. The separate branch is
automatically created when Guilt pushes something, and removed when no
patches are applied. The name is formed by prepending "guilt/" to the
original branch.

This breaks the "upstream" relationship, so a mistaken "git push"
while patches are applied will no longer mess up your upstream
repository.

Update the testsuite and documentation.

Thanks to Junio C Hamano for suggesting this solution to my problem.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This one was a bit experimental if I remember correctly, so you may
want to skip it or make the feature optional.

 Documentation/guilt.7 |   4 +
 guilt                 |  52 +++++-
 guilt-branch          |  12 +-
 guilt-commit          |   7 +
 guilt-import-commit   |   4 +-
 guilt-repair          |   7 +-
 regression/scaffold   |   3 +-
 regression/t-052.out  |  24 +--
 regression/t-052.sh   |   7 +-
 regression/t-061.out  | 468 ++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-061.sh   | 148 ++++++++++++++++
 11 files changed, 713 insertions(+), 23 deletions(-)
 create mode 100644 regression/t-061.out
 create mode 100755 regression/t-061.sh

diff --git a/Documentation/guilt.7 b/Documentation/guilt.7
index 860e6d6..c3fdb3d 100644
--- a/Documentation/guilt.7
+++ b/Documentation/guilt.7
@@ -43,6 +43,10 @@ guards: This file contains any guards that should be applied to the series when
 series: This file contains a list of all the patch filenames relative to the per\-branch patch directory\&. Empty and commented out lines are ignored\&.
 
 status: This file contains the state of the stack\&. What patches are applied\&.
+.SH "BRANCH USAGE"
+When you have pushed a patch, Guilt automatically changes to a freshly created Git branch\&. The name of the new branch is formed by prepending \fBguilt/\fR to the name of the original branch\&. This is done so that you do not accidentally push a set of Guilt patches to a remote Git repository\&. Once you pop all patches Guilt automatically changes back to the original branch\&.
+
+This is mostly transparent\&. The only thing you need to remember is that if you use \fBgit checkout\fR to switch to a branch while you have Guilt patches applied, you should use \fBgit checkout guilt/BRANCH\fR instead of \fBgit checkout BRANCH\fR when you want to change back later.
 .SH "HOOKS"
 Any guilt operation may execute zero or more hook scripts which can be used to run any housekeeping commands or even abort the execution of the command\&.
 .SH "HOOKS DIRECTORY"
diff --git a/guilt b/guilt
index 5bcc498..66a671a 100755
--- a/guilt
+++ b/guilt
@@ -408,9 +408,9 @@ head_check()
 			return 0 ;;
 	esac
 
-	if [ "`git rev-parse refs/heads/$branch`" != "`git rev-parse $1`" ]; then
+	if [ "`git rev-parse refs/heads/\`git_branch\``" != "`git rev-parse $1`" ]; then
 		disp "Expected HEAD commit $1" >&2
-		disp "                 got `git rev-parse refs/heads/$branch`" >&2
+		disp "                 got `git rev-parse refs/heads/\`git_branch\``" >&2
 		return 1
 	fi
 	return 0
@@ -500,6 +500,11 @@ pop_many_patches()
 		n=`expr $n - $2`
 		head_n "$n" < "$applied" > "$applied.tmp"
 		mv "$applied.tmp" "$applied"
+		if [ -z "`get_top 2>/dev/null`" ] && [ "`git symbolic-ref HEAD`" = "refs/heads/$GUILT_PREFIX$branch" ] && ! $old_style_prefix
+		then
+			git symbolic-ref HEAD refs/heads/$branch
+			git update-ref -d refs/heads/$GUILT_PREFIX$branch
+		fi
 	)
 }
 
@@ -585,7 +590,13 @@ commit()
 		# commit
 		treeish=`git write-tree`
 		commitish=`git commit-tree $treeish -p $2 < "$TMP_MSG"`
-		git update-ref HEAD $commitish
+		if $old_style_prefix || git rev-parse --verify --quiet refs/heads/$GUILT_PREFIX$branch >/dev/null
+		then
+			git update-ref HEAD $commitish
+		else
+			git branch $GUILT_PREFIX$branch $commitish
+			git symbolic-ref HEAD refs/heads/$GUILT_PREFIX$branch
+		fi
 
 		# mark patch as applied
 		git update-ref "refs/patches/$branch/$pname" HEAD
@@ -825,6 +836,9 @@ guilt_push_diff_context=1
 # default diffstat value: true or false
 DIFFSTAT_DEFAULT="false"
 
+# Prefix for guilt branches.
+GUILT_PREFIX=guilt/
+
 #
 # Parse any part of .git/config that belongs to us
 #
@@ -839,7 +853,28 @@ diffstat=`git config --bool guilt.diffstat`
 
 GUILT_DIR="$GIT_DIR/patches"
 
-branch=`get_branch`
+# To make it harder to accidentally do "git push" with a guilt patch
+# applied, "guilt push" changes branch from e.g. "master" to
+# "guilt/master".  Set $git_branch to the full branch name, and
+# $branch to the abbreviated name that the user sees most of the time.
+# Note: old versions of guilt did not add the "guilt/" prefix.  This
+# code handles that case as well.  The prefix will be added when you
+# have no patches applied and do a "guilt push".
+raw_git_branch=`get_branch`
+branch=`echo "$raw_git_branch" | sed -e 's,^'$GUILT_PREFIX',,'`
+
+git_branch()
+{
+	if $old_style_prefix
+	then
+		echo $branch
+	elif [ -z "`get_top 2>/dev/null`" ]
+	then
+		echo $branch
+	else
+		echo $GUILT_PREFIX$branch
+	fi
+}
 
 # most of the time we want to verify that the repo's branch has been
 # initialized, but every once in a blue moon (e.g., we want to run guilt init),
@@ -876,4 +911,13 @@ else
 	die "Unsupported operating system: $UNAME_S"
 fi
 
+if [ "$branch" = "$raw_git_branch" ] && [ -n "`get_top 2>/dev/null`" ]
+then
+    # This is for compat with old repositories that still have a
+    # pushed patch without the new-style branch prefix.
+    old_style_prefix=true
+else
+    old_style_prefix=false
+fi
+
 _main "$@"
diff --git a/guilt-branch b/guilt-branch
index 909f740..4a1f53e 100755
--- a/guilt-branch
+++ b/guilt-branch
@@ -35,8 +35,16 @@ cat "$applied" | while read n; do
 		`git rev-parse "refs/patches/$branch/$n"` ""
 done
 
-git branch "$newbranch"
-git checkout "$newbranch"
+if $old_style_prefix || [ -z "`get_top 2>/dev/null`" ]
+then
+	newgitbranch="$newbranch"
+else
+	git update-ref "refs/heads/$newbranch" "refs/heads/$branch" ""
+	newgitbranch="$GUILT_PREFIX$newbranch"
+fi
+
+git branch "$newgitbranch"
+git checkout "$newgitbranch"
 
 mkdir -p "$GUILT_DIR/`dirname $newbranch`"
 
diff --git a/guilt-commit b/guilt-commit
index 4228be6..e425399 100755
--- a/guilt-commit
+++ b/guilt-commit
@@ -43,4 +43,11 @@ done
 sed -n -e "${pat_keep}" "$applied" > "$applied.tmp"
 mv "$applied.tmp" "$applied"
 
+# if we removed the last patch, switch back to the base branch
+if [ `wc -l < "$applied"` -eq 0 ] && [ "`git symbolic-ref HEAD`" = "refs/heads/$GUILT_PREFIX$branch" ] && ! $old_style_prefix
+then
+	git update-ref refs/heads/$branch refs/heads/$GUILT_PREFIX$branch
+	git symbolic-ref HEAD refs/heads/$branch
+	git update-ref -d refs/heads/$GUILT_PREFIX$branch
+fi
 }
diff --git a/guilt-import-commit b/guilt-import-commit
index 3045a5f..54c1de0 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -23,7 +23,7 @@ if ! must_commit_first; then
 fi
 
 disp "About to begin conversion..." >&2
-disp "Current head: `cat $GIT_DIR/refs/heads/$branch`" >&2
+disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
 
 for rev in `git rev-list $rhash`; do
 	s=`git log --pretty=oneline -1 $rev | cut -c 42-`
@@ -68,6 +68,6 @@ for rev in `git rev-list $rhash`; do
 done
 
 disp "Done." >&2
-disp "Current head: `cat $GIT_DIR/refs/heads/$branch`" >&2
+disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
 
 }
diff --git a/guilt-repair b/guilt-repair
index 77ad223..c0bf3ed 100755
--- a/guilt-repair
+++ b/guilt-repair
@@ -84,6 +84,11 @@ repair_pushed()
 
 	# blow away any commits
 	git reset --hard "$newrev" > /dev/null
+	if [ "`git symbolic-ref HEAD`" = "refs/heads/$GUILT_PREFIX$branch" ] && ! $old_style_prefix
+	then
+		git symbolic-ref HEAD refs/heads/$branch
+		git update-ref -d refs/heads/$GUILT_PREFIX$branch
+	fi
 
 	# blow away the applied stack
 	remove_patch_refs < "$applied"
@@ -112,7 +117,7 @@ case "$1" in
 		;;
 esac
 
-oldrev=`git show-ref -s "refs/heads/$branch"`
+oldrev=`git show-ref -s "refs/heads/\`git_branch\`"`
 
 case "$repair" in
 	full)
diff --git a/regression/scaffold b/regression/scaffold
index 9db79a9..546d8c6 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -38,7 +38,8 @@ function replace_path
 	    -e "s,^Usage: guilt-,Usage: guilt ,g" \
 	    -e "s,\.\.\. initial, initial,g" \
 	    -e "s,^Already on\( branch\)\? [\"']\([^\"']*\)[\"']$,Already on \"\2\",g" \
-	    -e "s,^Switched to branch [\"']\([^\"']*\)[\"'],Switched to branch \"\1\",g"
+	    -e "s,^Switched to branch [\"']\([^\"']*\)[\"'],Switched to branch \"\1\",g" \
+	    -e "\\,^Deleted branch guilt/.* (was .*).$,d"
 }
 
 function filter_dd
diff --git a/regression/t-052.out b/regression/t-052.out
index 3b4a629..8205f35 100644
--- a/regression/t-052.out
+++ b/regression/t-052.out
@@ -47,7 +47,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
 Applying patch..modify
 Patch applied.
 % guilt branch br-modify
-Switched to branch "br-modify"
+Switched to branch "guilt/br-modify"
 % list_files
 d .git/patches
 d .git/patches/br-
@@ -76,8 +76,8 @@ f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/br-/status
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/br-modify/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
-% git checkout master
-Switched to branch "master"
+% git checkout guilt/master
+Switched to branch "guilt/master"
 % list_files
 d .git/patches
 d .git/patches/br-
@@ -109,7 +109,7 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
 Applying patch..add
 Patch applied.
 % guilt branch br-add
-Switched to branch "br-add"
+Switched to branch "guilt/br-add"
 % list_files
 d .git/patches
 d .git/patches/br-
@@ -149,8 +149,8 @@ r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/br-modify/modify
 r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/br-add/add
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
-% git checkout master
-Switched to branch "master"
+% git checkout guilt/master
+Switched to branch "guilt/master"
 % list_files
 d .git/patches
 d .git/patches/br-
@@ -193,7 +193,7 @@ r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
 Applying patch..remove
 Patch applied.
 % guilt branch br-remove
-Switched to branch "br-remove"
+Switched to branch "guilt/br-remove"
 % list_files
 d .git/patches
 d .git/patches/br-
@@ -245,8 +245,8 @@ r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/br-remove/add
 r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/br-remove/remove
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
-% git checkout master
-Switched to branch "master"
+% git checkout guilt/master
+Switched to branch "guilt/master"
 % list_files
 d .git/patches
 d .git/patches/br-
@@ -301,7 +301,7 @@ r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
 Applying patch..mode
 Patch applied.
 % guilt branch br-mode
-Switched to branch "br-mode"
+Switched to branch "guilt/br-mode"
 % list_files
 d .git/patches
 d .git/patches/br-
@@ -366,5 +366,5 @@ r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/mode
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/br-mode/remove
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/br-remove/remove
 r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
-% git checkout master
-Switched to branch "master"
+% git checkout guilt/master
+Switched to branch "guilt/master"
diff --git a/regression/t-052.sh b/regression/t-052.sh
index e9c1a59..05bc55b 100755
--- a/regression/t-052.sh
+++ b/regression/t-052.sh
@@ -12,5 +12,10 @@ for x in "" modify add remove mode ; do
 	[ "$x" != "" ] && guilt push "$x"
 	cmd guilt branch br-$x
 	cmd list_files
-	cmd git checkout master
+	if [ "$x" != "" ]
+	then
+	    cmd git checkout guilt/master
+	else
+	    cmd git checkout master
+	fi
 done
diff --git a/regression/t-061.out b/regression/t-061.out
new file mode 100644
index 0000000..8365236
--- /dev/null
+++ b/regression/t-061.out
@@ -0,0 +1,468 @@
+% setup_repo
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/mode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/guilt/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% git update-ref refs/heads/master refs/heads/guilt/master
+% git symbolic-ref HEAD refs/heads/master
+% git update-ref -d refs/heads/guilt/master
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/mode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
+% guilt pop
+Now at remove.
+% git for-each-ref
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt push
+Applying patch..mode
+Patch applied.
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop
+Now at remove.
+% git for-each-ref
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop
+Now at add.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt push
+Applying patch..remove
+Patch applied.
+% git for-each-ref
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop
+Now at add.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+Now at modify.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt push
+Applying patch..add
+Patch applied.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+Now at modify.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push
+Applying patch..modify
+Patch applied.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/guilt/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt pop
+No patches applied.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push
+Applying patch..modify
+Patch applied.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/guilt/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% guilt pop
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% git update-ref refs/heads/master refs/heads/guilt/master
+% git symbolic-ref HEAD refs/heads/master
+% git update-ref -d refs/heads/guilt/master
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop -a
+All patches popped.
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% guilt push add
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/guilt/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+% git update-ref refs/heads/master refs/heads/guilt/master
+% git symbolic-ref HEAD refs/heads/master
+% git update-ref -d refs/heads/guilt/master
+% guilt branch topic
+Switched to branch "topic"
+% git for-each-ref
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/topic/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+% guilt pop -a
+All patches popped.
+% guilt push
+Applying patch..modify
+Patch applied.
+% git for-each-ref
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/heads/guilt/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/heads/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+% guilt pop -a
+All patches popped.
+% git checkout master
+Switched to branch "master"
+% guilt pop -a
+All patches popped.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% git update-ref refs/heads/master refs/heads/guilt/master
+% git symbolic-ref HEAD refs/heads/master
+% git update-ref -d refs/heads/guilt/master
+% guilt branch topic
+Switched to branch "topic"
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/master
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/topic/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/topic/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/topic/remove
+% guilt pop -a
+All patches popped.
+% git checkout master
+Switched to branch "master"
+% guilt pop -a
+All patches popped.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt branch topic
+Switched to branch "topic"
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/topic
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/topic
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/topic/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/topic/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/topic/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/topic/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/topic/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/topic/status
+% guilt pop -a
+No patches applied.
+% git checkout master
+Switched to branch "master"
+% guilt pop -a
+No patches applied.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% guilt branch topic
+Switched to branch "guilt/topic"
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/guilt/master
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/guilt/topic
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/topic/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/topic/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/topic/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/topic/remove
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/topic
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/topic/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/topic/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/topic/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/topic/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/topic/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/topic/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/topic/modify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/add
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/topic/add
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/mode
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/topic/mode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/remove
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/topic/remove
+% guilt pop -a
+All patches popped.
+% git for-each-ref
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/heads/guilt/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/topic
+37d588cc39848368810e88332bd03b083f2ce3ac commit	refs/patches/master/add
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
+33633e7a1aa31972f125878baf7807be57b1672d commit	refs/patches/master/modify
+ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
+% guilt pop -a
+No patches applied.
+ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
+% git checkout guilt/master
+Switched to branch "guilt/master"
+% guilt pop -a
+All patches popped.
+% git branch -d topic
+Deleted branch topic (was d485041).
+% rm -r .git/patches/topic
+% git for-each-ref
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/topic
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt new newpatch
+% git for-each-ref --format=%(refname)
+refs/heads/guilt/master
+refs/heads/master
+refs/patches/master/newpatch
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..newpatch
+Patch applied.
+% git for-each-ref
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/heads/guilt/master
+d4850419ccc1146c7169f500725ce504b9774ed0 commit	refs/heads/master
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/patches/master/newpatch
+% git branch
+* guilt/master
+  master
+% guilt applied
+newpatch
+% guilt commit -a
+% git for-each-ref
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/heads/master
+% git branch
+* master
+% guilt push -a
+Applying patch..modify
+Patch applied.
+Applying patch..add
+Patch applied.
+Applying patch..remove
+Patch applied.
+Applying patch..mode
+Patch applied.
+% guilt applied
+modify
+add
+remove
+mode
+% git branch
+* guilt/master
+  master
+% git for-each-ref
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/heads/guilt/master
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/heads/master
+5effcbeb303e8433935151d8c69f3bf63db1e8ef commit	refs/patches/master/add
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/patches/master/mode
+9509f22e2e627756d87b42432931c45955b74234 commit	refs/patches/master/modify
+9cbe2fc643b1a9e2179a8738f80424a1c2aa202d commit	refs/patches/master/remove
+% guilt commit -n 2
+% git for-each-ref
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/heads/guilt/master
+25465dc1687f3833ecbd4e8bca437e522d7026db commit	refs/heads/master
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/patches/master/mode
+9cbe2fc643b1a9e2179a8738f80424a1c2aa202d commit	refs/patches/master/remove
+% git branch
+* guilt/master
+  master
+% guilt commit -n 2
+% git for-each-ref
+fefbdcef61022d473838926619f31e030dd04fdc commit	refs/heads/master
+% git branch
+* master
+% guilt series
diff --git a/regression/t-061.sh b/regression/t-061.sh
new file mode 100755
index 0000000..1411baa
--- /dev/null
+++ b/regression/t-061.sh
@@ -0,0 +1,148 @@
+#!/bin/bash
+#
+# Test the branch-switching upgrade code
+#
+
+source $REG_DIR/scaffold
+
+old_style_branch() {
+	# Modify the refs so that it looks as if the patch series was applied
+	# by an old version of guilt.
+	cmd git update-ref refs/heads/$1 refs/heads/guilt/$1
+	cmd git symbolic-ref HEAD refs/heads/$1
+	cmd git update-ref -d refs/heads/guilt/$1
+}
+
+remove_topic() {
+	cmd guilt pop -a
+	if git rev-parse --verify --quiet guilt/master
+	then
+		cmd git checkout guilt/master
+	else
+		cmd git checkout master
+	fi
+	cmd guilt pop -a
+	cmd git branch -d $1
+	cmd rm -r .git/patches/$1
+	cmd git for-each-ref
+	cmd list_files
+}
+
+function fixup_time_info
+{
+	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
+}
+
+cmd setup_repo
+
+cmd guilt push -a
+cmd list_files
+cmd git for-each-ref
+
+# Pop and push patches.  Check that the repo is converted to new-style
+# refs when no patches are applied and a patch is pushed.
+old_style_branch master
+cmd git for-each-ref
+
+cmd list_files
+
+for i in `seq 5`
+do
+	cmd guilt pop
+	cmd git for-each-ref
+	cmd guilt push
+	cmd git for-each-ref
+	cmd guilt pop
+	cmd git for-each-ref
+done
+
+# Check that "pop -a" does the right thing.
+cmd guilt push -a
+
+old_style_branch master
+
+cmd git for-each-ref
+
+cmd guilt pop -a
+
+cmd git for-each-ref
+
+# Check that pushing two patches converts the repo to now-style (since
+# it currently has no patches applied).
+cmd guilt push add
+cmd git for-each-ref
+
+# Check guilt branch with a few patches applied.
+old_style_branch master
+cmd guilt branch topic
+cmd git for-each-ref
+
+# Check that the topic branch is converted to new-style.
+cmd guilt pop -a
+cmd guilt push
+cmd git for-each-ref
+
+remove_topic topic
+
+# Check guilt branch with the full patch series applied.
+cmd guilt push -a
+old_style_branch master
+cmd guilt branch topic
+cmd git for-each-ref
+
+remove_topic topic
+
+# Check guilt branch with no patches applied.
+# This gives us a new-style checkout.
+cmd guilt branch topic
+cmd git for-each-ref
+cmd list_files
+
+remove_topic topic
+
+# Check guilt branch in a new-style directory with all patches
+# applied.  (Strictly speaking, this test should probably move to a
+# file devoted to testing "guilt branch".)
+cmd guilt push -a
+cmd guilt branch topic
+cmd git for-each-ref
+cmd list_files
+cmd guilt pop -a
+cmd git for-each-ref
+
+remove_topic topic
+
+# Check that "guilt new" does the right thing when no patches are
+# applied.  (Strictly speaking, this test should maybe move to
+# t-025.sh).
+
+cmd guilt new newpatch
+cmd git for-each-ref '--format=%(refname)'
+cmd guilt pop
+fixup_time_info newpatch
+cmd guilt push
+cmd git for-each-ref
+
+# Check that "guilt commit" does the right thing when committing all
+# applied patches.  (Strictly speaking, this test should maybe move to
+# t-030.sh).
+cmd git branch
+cmd guilt applied
+cmd guilt commit -a
+cmd git for-each-ref
+cmd git branch
+
+# Check that "guilt commit" does the right thing when committing only
+# a few of the applied patches.  (Strictly speaking, this test should
+# maybe move to t-030.sh).
+cmd guilt push -a
+cmd guilt applied
+cmd git branch
+cmd git for-each-ref
+cmd guilt commit -n 2
+cmd git for-each-ref
+cmd git branch
+cmd guilt commit -n 2
+cmd git for-each-ref
+cmd git branch
+cmd guilt series
-- 
1.8.1
