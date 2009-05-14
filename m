From: Dan Loewenherz <daniel.loewenherz@yale.edu>
Subject: [PATCH] Eliminate redirection to stdout and stderr when quiet option 
	is available
Date: Thu, 14 May 2009 03:13:02 -0400
Message-ID: <6f5a4e780905140013g75d85558tfaa3c85430f8a8a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 09:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4V8F-0007Qe-P0
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbZENHNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZENHNX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:13:23 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:35240 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZENHNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 03:13:22 -0400
Received: by ewy24 with SMTP id 24so1379278ewy.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=UXwGTFwA4P0o4W82LvMQ1p1gDbQNtXCyRyaRhuuVeNA=;
        b=G9s9pXqTP0ECPy8FLzu6CltQQuqAKA/VBD+FX4QAW2HsKzp3d64NVHzQKa7tR6Aban
         /CZ6rf4x48KukBZhn+qmywBTQhgS0P0ZopDLP5D+Hx/bC3QOT4ag96mJvWd4Mae8YIfG
         MTZ0CqiGpK5+60BGeDRBJzuGP1mS+0YuRmsSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=Ef4bvCsLwi2N4tDkBjyg6qwJ8kpZpxG9wPP493G+DTzRtyceUrwgE4+I1Nogxk2PfK
         2DS6CXELPT+fO8dsTpEGNJdaCspwF6D/kraDUILo7K1viaLwERSqXXftXwSHpIh3+z50
         IwDTvWLxAYuRc8qFbm6frOgTsN7m+07S0qW38=
Received: by 10.210.51.18 with SMTP id y18mr2287251eby.82.1242285202135; Thu, 
	14 May 2009 00:13:22 -0700 (PDT)
X-Google-Sender-Auth: c20fa23328950bff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119157>

This follows an earlier commit (7bd93c1) that eliminates the usage of
`>dev/null 2>&1` and friends when a `--quiet` option is available.

Signed-off-by: Dan Loewenherz <daniel.loewenherz@yale.edu>
---
 git-add--interactive.perl          |    2 +-
 git-am.sh                          |    2 +-
 git-cvsexportcommit.perl           |    2 +-
 git-cvsimport.perl                 |    2 +-
 git-lost-found.sh                  |    2 +-
 git-rebase--interactive.sh         |    8 ++++----
 git-rebase.sh                      |    2 +-
 git-stash.sh                       |   12 ++++++------
 git-submodule.sh                   |    6 +++---
 templates/hooks--pre-commit.sample |    2 +-
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f6e536e..e1106c9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -158,7 +158,7 @@ my $status_head = sprintf($status_fmt, 'staged',
'unstaged', 'path');
 {
 	my $initial;
 	sub is_initial_commit {
-		$initial = system('git rev-parse HEAD -- >/dev/null 2>&1') != 0
+		$initial = system('git rev-parse -q HEAD -- ') != 0
 			unless defined $initial;
 		return $initial;
 	}
diff --git a/git-am.sh b/git-am.sh
index 6d1848b..8a86d05 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -36,7 +36,7 @@ cd_to_toplevel
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"

-if git rev-parse --verify -q HEAD >/dev/null
+if git rev-parse --verify -q HEAD
 then
 	HAS_HEAD=yes
 else
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6d9f0ef..a10303a 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -127,7 +127,7 @@ my $go_back_to = 0;

 if ($opt_W) {
     $opt_v && print "Resetting to $parent\n";
-    $go_back_to = `git symbolic-ref HEAD 2> /dev/null ||
+    $go_back_to = `git symbolic-ref -q HEAD ||
 	git rev-parse HEAD` || die "Could not determine current branch";
     system("git checkout -q $parent^0") && die "Could not check out $parent^0";
 }
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e439202..81b808e 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -535,7 +535,7 @@ sub is_sha1 {

 sub get_headref ($) {
 	my $name = shift;
-	my $r = `git rev-parse --verify '$name' 2>/dev/null`;
+	my $r = `git rev-parse -q --verify '$name' `;
 	return undef unless $? == 0;
 	chomp $r;
 	return $r;
diff --git a/git-lost-found.sh b/git-lost-found.sh
index 0b3e8c7..c64a308 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -20,7 +20,7 @@ while read dangling type sha1
 do
 	case "$dangling" in
 	dangling)
-		if git rev-parse -q --verify "$sha1^0" >/dev/null
+		if git rev-parse -q --verify "$sha1^0"
 		then
 			dir="$laf/commit"
 			git show-branch "$sha1"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 314cd36..118508e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -83,7 +83,7 @@ run_pre_rebase_hook () {

 require_clean_work_tree () {
 	# test if working tree is dirty
-	git rev-parse --verify HEAD > /dev/null &&
+	git rev-parse -q --verify HEAD &&
 	git update-index --ignore-submodules --refresh &&
 	git diff-files --quiet --ignore-submodules &&
 	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
@@ -258,7 +258,7 @@ pick_one_preserving_merges () {
 		if [ "$1" != "-n" ]
 		then
 			# detach HEAD to current parent
-			output git checkout $first_parent 2> /dev/null ||
+			output git checkout -q $first_parent ||
 				die "Cannot move HEAD to $first_parent"
 		fi

@@ -498,7 +498,7 @@ do
 		test -d "$DOTEST" || die "No interactive rebase running"

 		# Sanity check
-		git rev-parse --verify HEAD >/dev/null ||
+		git rev-parse -q --verify HEAD ||
 			die "Cannot read HEAD"
 		git update-index --ignore-submodules --refresh &&
 			git diff-files --quiet --ignore-submodules ||
@@ -632,7 +632,7 @@ first and then run 'git rebase --continue' again."
 		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"

 		: > "$DOTEST"/interactive || die "Could not mark as interactive"
-		git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
+		git symbolic-ref -q HEAD > "$DOTEST"/head-name ||
 			echo "detached HEAD" > "$DOTEST"/head-name

 		echo $HEAD > "$DOTEST"/head
diff --git a/git-rebase.sh b/git-rebase.sh
index b83fd3f..da575d9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -91,7 +91,7 @@ call_merge () {
 	cmt="$(cat "$dotest/cmt.$1")"
 	echo "$cmt" > "$dotest/current"
 	hd=$(git rev-parse --verify HEAD)
-	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
+	cmt_name=$(git symbolic-ref -q HEAD || echo HEAD)
 	msgnum=$(cat "$dotest/msgnum")
 	end=$(cat "$dotest/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
diff --git a/git-stash.sh b/git-stash.sh
index b9ace99..7661862 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -30,7 +30,7 @@ clear_stash () {
 	then
 		die "git stash clear with parameters is unimplemented"
 	fi
-	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
+	if current=$(git rev-parse -q --verify $ref_stash)
 	then
 		git update-ref -d $ref_stash $current
 	fi
@@ -129,7 +129,7 @@ save_stash () {
 }

 have_stash () {
-	git rev-parse --verify $ref_stash >/dev/null 2>&1
+	git rev-parse -q --verify $ref_stash
 }

 list_stash () {
@@ -229,16 +229,16 @@ drop_stash () {
 	fi
 	# Verify supplied argument looks like a stash entry
 	s=$(git rev-parse --verify "$@") &&
-	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
+	git rev-parse -q --verify "$s:" &&
+	git rev-parse -q --verify "$s^1:" &&
+	git rev-parse -q --verify "$s^2:" ||
 		die "$*: not a valid stashed state"

 	git reflog delete --updateref --rewrite "$@" &&
 		echo "Dropped $* ($s)" || die "$*: Could not drop stash entry"

 	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
+	git rev-parse -q --verify "$ref_stash@{0}" || clear_stash
 }

 apply_to_branch () {
diff --git a/git-submodule.sh b/git-submodule.sh
index 8e234a4..5ef605d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -459,7 +459,7 @@ cmd_summary() {
 			# Always show modules deleted or type-changed (blob<->module)
 			test $status = D -o $status = T && echo "$name" && continue
 			# Also show added or modified modules which are checked out
-			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			GIT_DIR="$name/.git" git-rev-parse -q --git-dir &&
 			echo "$name"
 		done
 	)
@@ -493,11 +493,11 @@ cmd_summary() {
 		missing_dst=

 		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
+		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 &&
 		missing_src=t

 		test $mod_dst = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
+		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 &&
 		missing_dst=t

 		total_commits=
diff --git a/templates/hooks--pre-commit.sample
b/templates/hooks--pre-commit.sample
index 0e49279..8ef822b 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,7 +7,7 @@
 #
 # To enable this hook, rename this file to "pre-commit".

-if git-rev-parse --verify HEAD 2>/dev/null
+if git-rev-parse -q --verify HEAD
 then
 	against=HEAD
 else
-- 
1.6.3.1.10.gf494c2.dirty
