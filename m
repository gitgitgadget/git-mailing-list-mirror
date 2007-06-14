From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] guilt(1): Obvious bashisms fixed.
Date: Thu, 14 Jun 2007 14:50:57 +0200
Message-ID: <1181825462590-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyonT-0003Jt-Gu
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbXFNMvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXFNMvO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:14 -0400
Received: from pan.madism.org ([88.191.52.104]:60898 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbXFNMvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:05 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 49E23DA66;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 67C559294E; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50193>

  + function foo { } -> foo() { }
  + add wrapper for echo -e
  + couple of '[' bashisms
  + get rid of easy local variables to remove
  + avoid cd - (using subshells)

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt |  185 ++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 91 insertions(+), 94 deletions(-)

diff --git a/guilt b/guilt
index 2ae76f8..80f3faf 100755
--- a/guilt
+++ b/guilt
@@ -20,7 +20,29 @@ SUBDIRECTORY_OK=1
 
 . git-sh-setup
 
-function guilt_commands
+#
+# Shell library
+#
+
+# echo -e is a bashism, fallback to /bin/echo if the builtin does not supports it
+echo()
+{
+	/bin/echo "$@"
+}
+
+noerr()
+{
+    "$@" 2>/dev/null
+}
+
+silent()
+{
+    "$@" >/dev/null 2>/dev/null
+}
+
+########
+
+guilt_commands()
 {
 	local command
 	for command in $0-*
@@ -32,7 +54,7 @@ function guilt_commands
 	done
 }
 
-if [ `basename $0` = "guilt" ]; then
+if [ "`basename $0`" = "guilt" ]; then
 	# being run as standalone
 
 	# by default, we shouldn't fail
@@ -58,7 +80,7 @@ if [ `basename $0` = "guilt" ]; then
 				esac
 			done
 		fi
-		if [ $cmd ]; then
+		if [ -n "$cmd" ]; then
 			shift
 			exec "$dir/guilt-$cmd" "$@"
 
@@ -96,68 +118,55 @@ fi
 #
 
 # usage: valid_patchname <patchname>
-function valid_patchname
+valid_patchname()
 {
-	[ `echo "$1" | grep -e '^/' | wc -l` -gt 0 ] && return 1
-	[ `echo "$1" | grep -e '^\./' | wc -l` -gt 0 ] && return 1
-	[ `echo "$1" | grep -e '^\.\./' | wc -l` -gt 0 ] && return 1
-	[ `echo "$1" | grep -e '/\./' | wc -l` -gt 0 ] && return 1
-	[ `echo "$1" | grep -e '/\.\./' | wc -l` -gt 0 ] && return 1
-	[ `echo "$1" | grep -e '/\.$' | wc -l` -gt 0 ] && return 1
-	[ `echo "$1" | grep -e '/\.\.$' | wc -l` -gt 0 ] && return 1
-	[ `echo "$1" | grep -e '/$' | wc -l` -gt 0 ] && return 1
-	return 0
+	case "$1" in
+		/*|./*|../*|*/./*|*/../*|*/.|*/..|*/)
+			return 1;;
+		*)
+			return 0;;
+	esac
 }
 
-function get_branch
+get_branch()
 {
 	git-symbolic-ref HEAD | sed -e 's,^refs/heads/,,'
 }
 
-function verify_branch
+verify_branch()
 {
-	local b=$branch
-
 	[ ! -d "$GIT_DIR/patches" ] &&
 		echo "Patches directory doesn't exist, try guilt-init" >&2 &&
 		return 1
-	[ ! -d "$GIT_DIR/patches/$b" ] &&
-		echo "Branch $b is not initialized, try guilt-init" >&2 &&
+	[ ! -d "$GIT_DIR/patches/$branch" ] &&
+		echo "Branch $branch is not initialized, try guilt-init" >&2 &&
 		return 1
-	[ ! -f "$GIT_DIR/patches/$b/series" ] &&
-		echo "Branch $b does not have a series file" >&2 &&
+	[ ! -f "$GIT_DIR/patches/$branch/series" ] &&
+		echo "Branch $branch does not have a series file" >&2 &&
 		return 1
-	[ ! -f "$GIT_DIR/patches/$b/status" ] &&
-		echo "Branch $b does not have a status file" >&2 &&
+	[ ! -f "$GIT_DIR/patches/$branch/status" ] &&
+		echo "Branch $branch does not have a status file" >&2 &&
 		return 1
-	[ -f "$GIT_DIR/patches/$b/applied" ] &&
-		echo "Warning: Branch $b has 'applied' file - guilt is not compatible with stgit" >&2 &&
+	[ -f "$GIT_DIR/patches/$branch/applied" ] &&
+		echo "Warning: Branch $branch has 'applied' file - guilt is not compatible with stgit" >&2 &&
 		return 1
 
 	return 0
 }
 
-function get_top
+get_top()
 {
 	tail -1 "$GUILT_DIR/$branch/status" | cut -d: -f 2-
 }
 
-function get_prev
+get_prev()
 {
-	local n=`wc -l < "$GUILT_DIR/$branch/status"`
-	local n=`expr $n - 1`
-
-	local idx=0
-	cat "$GUILT_DIR/$branch/status" | while read p; do
-		idx=`expr $idx + 1`
-		[ $idx -lt $n ] && continue
-		[ $idx -gt $n ] && break
-
-		echo "$p"
-	done
+	if [ `wc -l < "$GUILT_DIR/$branch/status"` -gt 1 ]; then
+		tail -n 2 "$GUILT_DIR/$branch/status" | head -n 1
+	fi
 }
 
-function get_series
+get_series()
 {
 	# ignore all lines matching:
 	#	- empty lines
@@ -168,7 +177,7 @@ function get_series
 }
 
 # usage: do_make_header <hash>
-function do_make_header
+do_make_header()
 {
 	# which revision do we want to work with?
 	local rev="$1"
@@ -195,7 +204,7 @@ BEGIN{ok=0}
 }
 
 # usage: do_get_header patchfile
-function do_get_header
+do_get_header()
 {
 	# The complexity arises from the fact that we want to ignore the
 	# From line and the empty line after it if it exists
@@ -212,7 +221,7 @@ END{}
 }
 
 # usage: do_get_full_header patchfile
-function do_get_full_header
+do_get_full_header()
 {
 	# 2nd line checks for the begining of a patch
 	# 3rd line outputs the line if it didn't get pruned by the above rules
@@ -225,37 +234,31 @@ END{}
 }
 
 # usage: assert_head_check
-function assert_head_check
+assert_head_check()
 {
-	local eh=`tail -1 < "$applied" | cut -d: -f 1`
-
-	if ! head_check "$eh"; then
+	if ! head_check "`tail -1 < "$applied" | cut -d: -f 1`"; then
 		die "aborting..."
 	fi
-
-	return 0
 }
 
 # usage: head_check <expected hash>
-function head_check
+head_check()
 {
 	# make sure we're not doing funky things to commits that don't
 	# belong to us
-	local ch=`cat "$GIT_DIR/refs/heads/$branch"`
-
 	# if the expected hash is empty, just return
 	[ -z "$1" ] && return 0
 
-	if [ "$ch" != "$1" ]; then
+	if [ "`cat "$GIT_DIR/refs/heads/$branch"`" != "$1" ]; then
 		echo "Expected HEAD commit $1" >&2
-		echo "                 got $ch" >&2
+		echo "                 got `cat "$GIT_DIR/refs/heads/$branch"`" >&2
 		return 1
 	fi
 	return 0
 }
 
 # usage: series_insert_patch <patchname>
-function series_insert_patch
+series_insert_patch()
 {
 	local top=`get_top | sed -e 's,/,\\\\/,g'`
 	local new=`echo "$1" | sed -e 's,/,\\\\/,g'` 
@@ -271,14 +274,14 @@ function series_insert_patch
 }
 
 # usage: series_remove_patch <patchname>
-function series_remove_patch
+series_remove_patch()
 {
 	grep -v "^$1\$" < "$series" > "$series.tmp"
 	mv "$series.tmp" "$series"
 }
 
 # usage: series_rename_patch <oldname> <newname>
-function series_rename_patch
+series_rename_patch()
 {
 	local old=`echo "$1" | sed -e 's,/,\\\\/,g'`
 	local new=`echo "$2" | sed -e 's,/,\\\\/,g'` 
@@ -290,7 +293,7 @@ function series_rename_patch
 # file directly
 #
 # usage: applied_rename_patch <oldname> <newname>
-function applied_rename_patch
+applied_rename_patch()
 {
 	local old=`echo "$1" | sed -e 's,/,\\\\/,g'`
 	local new=`echo "$2" | sed -e 's,/,\\\\/,g'` 
@@ -299,33 +302,32 @@ function applied_rename_patch
 }
 
 # usage: pop_many_patches <commitish> <number of patches>
-function pop_many_patches
+pop_many_patches()
 {
 	assert_head_check
 
+	(
 	cd "$TOP_DIR"
 
 	git-reset --hard "$1" > /dev/null
 	head -n "-$2" < "$applied" > "$applied.tmp"
 	mv "$applied.tmp" "$applied"
-
-	cd - 2>&1 >/dev/null
+	)
 
 	# update references to top, bottom, and base
 	update_stack_tags
 }
 
 # usage: pop_all_patches
-function pop_all_patches
+pop_all_patches()
 {
-	local x=`head -1 "$applied" | cut -d: -f1`
-	local n=`wc -l < "$applied"`
-
-	pop_many_patches $x^ $n
+	pop_many_patches \
+		`head -1 "$applied" | cut -d: -f1`^ \
+		`wc -l < "$applied"`
 }
 
 # usage: update_stack_tags
-function update_stack_tags
+update_stack_tags()
 {
 	# bail if autotagging is not enabled
 	if [ $autotag -eq 0 ]; then
@@ -336,13 +338,9 @@ function update_stack_tags
 		# there are patches applied, therefore we must get the top,
 		# bottom and base hashes, and update the tags
 
-		local top_hash=`git-rev-parse HEAD`
-		local bottom_hash=`head -1 < $applied | cut -d: -f1`
-		local base_hash=`git-rev-parse $bottom_hash^`
-
-		echo $top_hash > "$GIT_DIR/refs/tags/${branch}_top"
-		echo $bottom_hash > "$GIT_DIR/refs/tags/${branch}_bottom"
-		echo $base_hash > "$GIT_DIR/refs/tags/${branch}_base"
+                git-rev-parse HEAD > "$GIT_DIR/refs/tags/${branch}_top"
+                head -1 < $applied | cut -d: -f1 > "$GIT_DIR/refs/tags/${branch}_bottom"
+		git-rev-parse $(head -1 < $applied | cut -d: -f1)^ > "$GIT_DIR/refs/tags/${branch}_base"
 	else
 		# there are no patches applied, therefore we must remove the
 		# tags to old top, bottom, and base
@@ -354,7 +352,7 @@ function update_stack_tags
 }
 
 # usage: push_patch patchname [bail_action]
-function push_patch
+push_patch()
 {
 	local p="$GUILT_DIR/$branch/$1"
 	local pname="$1"
@@ -459,54 +457,53 @@ function push_patch
 }
 
 # usage: must_commit_first
-function must_commit_first
+must_commit_first()
 {
 	[ `git-diff-files | wc -l` -eq 0 ]
 	return $?
 }
 
 # usage: fold_patch patchname
-function fold_patch
+fold_patch()
 {
-	local top_patch=`get_top`
+	set -- "$1" "`get_top`"
 
 	assert_head_check
 
 	push_patch "$1"
 
-	__refresh_patch "$top_patch" HEAD^^ 2
+	__refresh_patch "$2" HEAD^^ 2
 
 	series_remove_patch "$1"
 }
 
 # usage: refresh_patch patchname
-function refresh_patch
+refresh_patch()
 {
 	__refresh_patch "$1" HEAD^ 1
 }
 
 # usage: __refresh_patch patchname commitish number_of_commits
-function __refresh_patch
+__refresh_patch()
 {
-	local p="$GUILT_DIR/$branch/$1"
-
 	assert_head_check
 
-	cd "$TOP_DIR"
-
-	git-diff-files --name-only | (while read n; do git-update-index "$n" ; done)
+	(
+		cd "$TOP_DIR"
+			p="$GUILT_DIR/$branch/$1"
 
-	# get the patch header
-	do_get_full_header "$p" > /tmp/guilt.diff.$$
+		git-diff-files --name-only | (while read n; do git-update-index "$n" ; done)
 
-	# get the new patch
-	git-diff "$2" >> /tmp/guilt.diff.$$
+		# get the patch header
+		do_get_full_header "$p" > /tmp/guilt.diff.$$
 
-	# move the new patch in
-	mv "$p" "$p~"
-	mv /tmp/guilt.diff.$$ $p
+		# get the new patch
+		git-diff "$2" >> /tmp/guilt.diff.$$
 
-	cd - 2>&1 >/dev/null
+		# move the new patch in
+		mv "$p" "$p~"
+		mv /tmp/guilt.diff.$$ $p
+	)
 
 	# drop the currently applied patch, pop_many_patches does it's own
 	# cd $TOP_DIR
@@ -525,7 +522,7 @@ function __refresh_patch
 #	<hash1>..<hash2>	- from hash to hash (inclusive)
 #
 # The output of this function is suitable to be passed to git-rev-list
-function munge_hash_range
+munge_hash_range()
 {
 	[ -z "$1" ] && return 1
 
-- 
1.5.2.1
