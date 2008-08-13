From: aneesh.kumar@gmail.com
Subject: (unknown)
Date: Wed, 13 Aug 2008 20:24:28 +0530
Message-ID: <1218639268-12267-1-git-send-email-aneesh.kumar@gmail.com>
Cc: git@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Aug 13 16:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHlB-0004h1-HJ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYHMOye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYHMOye
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:54:34 -0400
Received: from e28smtp01.in.ibm.com ([59.145.155.1]:41198 "EHLO
	e28esmtp01.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751702AbYHMOyd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:54:33 -0400
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id m7DEsVl5024260
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 20:24:31 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7DEsVVg1720362
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 20:24:31 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m7DEsUV0015952
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 20:24:31 +0530
Received: from localhost.localdomain ([9.77.121.107])
	by d28av01.in.ibm.com (8.13.1/8.12.11) with ESMTP id m7DEsTfn015918;
	Wed, 13 Aug 2008 20:24:29 +0530
Subject: 
X-Mailer: git-send-email 1.6.0.rc0.42.g186458.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92223>

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

topgit: Implement tg-import

This can be used to import a set of commits
between range specified by range1..range2
This should help us to convert an already
existing quilt, stgit branches to topgit
managed one

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---
 Makefile     |    2 +-
 README       |    7 ++++++
 tg-create.sh |   22 ++++++++----------
 tg-export.sh |    2 +-
 tg-import.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 6eade1e..95624ac 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ sharedir = $(PREFIX)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
-commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
+commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh tg-import.sh
 hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
diff --git a/README b/README
index b58a1b4..8b8f4d7 100644
--- a/README
+++ b/README
@@ -330,6 +330,13 @@ tg export
 	TODO: Make stripping of [PATCH] and other prefixes configurable
 	TODO: --mbox option for other mode of operation
 
+tg import
+~~~~~~~~
+	Import the commits between the given revision range into
+	a topgit managed branch
+
+	Usage: tg import rev1..rev2
+
 tg update
 ~~~~~~~~~
 	Update the current topic branch wrt. changes in the branches
diff --git a/tg-create.sh b/tg-create.sh
index 939af33..6cce7ed 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -31,17 +31,18 @@ done
 
 deps="${deps# }"
 if [ -z "$deps" ]; then
-	if [ -z "$name" -a -s "$git_dir/top-name" -a -s "$git_dir/top-deps" -a -s "$git_dir/top-merge" ]; then
-		# We are setting up the base branch now; resume merge!
-		name="$(cat "$git_dir/top-name")"
+	head="$(git symbolic-ref HEAD)"
+	bname="${head#refs/top-bases/}"
+	if [ "$bname" != "$head" -a -s "$git_dir/top-deps" -a -s "$git_dir/top-merge" ]; then
+		# We are on a base branch now; resume merge!
 		deps="$(cat "$git_dir/top-deps")"
 		merge="$(cat "$git_dir/top-merge")"
+		name="$bname"
 		restarted=1
 		info "Resuming $name setup..."
 	else
 		# The common case
 		[ -z "$name" ] && die "no branch name given"
-		head="$(git symbolic-ref HEAD)"
 		deps="${head#refs/heads/}"
 		[ "$deps" != "$head" ] || die "refusing to auto-depend on non-head ref ($head)"
 		info "Automatically marking dependency on $deps"
@@ -58,7 +59,7 @@ done
 	die "branch '$name' already exists"
 
 # Clean up any stale stuff
-rm -f "$git_dir/top-name" "$git_dir/top-deps" "$git_dir/top-merge"
+rm -f "$git_dir/top-deps" "$git_dir/top-merge"
 
 
 ## Create base
@@ -68,8 +69,7 @@ if [ -n "$merge" ]; then
 	branch="${merge%% *}"
 	merge="${merge#* }"
 	info "Creating $name base from $branch..."
-	# We create a detached head so that we can abort this operation
-	git checkout -q "$(git rev-parse "$branch")"
+	switch_to_base "$name" "$branch"
 fi
 
 
@@ -83,10 +83,9 @@ while [ -n "$merge" ]; do
 
 	if ! git merge "$branch"; then
 		info "Please commit merge resolution and call: tg create"
-		info "It is also safe to abort this operation using:"
-		info "git reset --hard some_branch"
-		info "(You are on a detached HEAD now.)"
-		echo "$name" >"$git_dir/top-name"
+		info "It is also safe to abort this operation using \`git reset --hard\`"
+		info "but please remember you are on the base branch now;"
+		info "you will want to switch to a different branch."
 		echo "$deps" >"$git_dir/top-deps"
 		echo "$merge" >"$git_dir/top-merge"
 		exit 2
@@ -96,7 +95,6 @@ done
 
 ## Set up the topic branch
 
-git update-ref "refs/top-bases/$name" "HEAD" ""
 git checkout -b "$name"
 
 echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
diff --git a/tg-export.sh b/tg-export.sh
index 62361dd..73ad2ef 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -190,7 +190,7 @@ recurse_deps driver "$name"
 
 
 if [ "$driver" = "collapse" ]; then
-	git update-ref "refs/heads/$output" "$(cat "$playground/$name")" ""
+	git update-ref "refs/heads/$output" "$(cat "$playground/$name")"
 
 	depcount="$(cat "$playground/^ticker" | wc -l)"
 	echo "Exported topic branch $name (total $depcount topics) to branch $output"
diff --git a/tg-import.sh b/tg-import.sh
new file mode 100644
index 0000000..6c991c5
--- /dev/null
+++ b/tg-import.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# GPLv2
+
+
+tg_get_commit_msg()
+{
+	commit="$1"
+	git log -1 --pretty=format:"From: %an <%ae>%n%n%s%n%n%b" "$commit"
+}
+
+tg_get_branch_name()
+{
+	# nice sed script from git-format-patch.sh
+	commit="$1"
+	titleScript='
+	s/[^-a-z.A-Z_0-9]/-/g
+        s/\.\.\.*/\./g
+	s/\.*$//
+	s/--*/-/g
+	s/^-//
+	s/-$//
+	q
+'
+	git log -1 --pretty=format:"%s" "$commit" | sed -e "$titleScript"
+}
+
+tg_process_commit()
+{
+	commit="$1"
+	branch_name=$(tg_get_branch_name "$commit")
+	echo "Importing $commit to $branch_name"
+	tg create tp/"$branch_name"
+	git read-tree "$commit"
+	tg_get_commit_msg "$commit" > .topmsg
+	git add -f .topmsg .topdeps
+	git commit -C "$commit"
+}
+
+# nice arg verification stolen from git-format-patch.sh
+for revpair
+do
+	case "$revpair" in
+	?*..?*)
+		rev1=`expr "z$revpair" : 'z\(.*\)\.\.'`
+		rev2=`expr "z$revpair" : 'z.*\.\.\(.*\)'`
+		;;
+	*)
+		die "Unknow range spec $revpair"
+		;;
+	esac
+	git rev-parse --verify "$rev1^0" >/dev/null 2>&1 ||
+		die "Not a valid rev $rev1 ($revpair)"
+	git rev-parse --verify "$rev2^0" >/dev/null 2>&1 ||
+		die "Not a valid rev $rev2 ($revpair)"
+	git cherry -v "$rev1" "$rev2" |
+	while read sign rev comment
+	do
+		case "$sign" in
+		'-')
+			info "Merged already: $comment"
+			;;
+		*)
+			tg_process_commit "$rev"
+			;;
+		esac
+	done
+done
-- 
tg: (f27e693..) tp/topgit-Implement-tg-import (depends on: master)
