From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/7] Additional --merge-order tests and general cleanup of t/t6001-rev-list-merge-order.sh
Date: Tue, 14 Jun 2005 12:04:34 +1000
Message-ID: <20050614020434.23254.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 04:00:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0it-0006gh-MV
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFNCE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFNCE7
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:04:59 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:32641 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261298AbVFNCEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:04:37 -0400
Received: (qmail 23264 invoked by uid 500); 14 Jun 2005 02:04:34 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

---

This series of patches is intended to apply on top of:

[PATCH 1/2] Changes to non-epoch.c code required for author-oriented 
	    git-rev-list changes
[PATCH 2/2] Add support for author-oriented git-rev-list switches [rev 11]

This series of 7 patches ultimately splits epoch.c into two and 
re-renders the --merge-order sort support into a generalized 
facility for performing incremental topological sorts on git
commit graphs. This facility can be used by any tool that needs
a topological sort simply by customizing the traversal methods 
in the epoch_methods structure [ which is later renamed to
traversal ].

As part of this refactorisation, this change also achieves
a better separation of concerns between the epoch.c and rev-list.c.
In particular, all knowledge of the --show-breaks and output limiting
is now in rev-list.c, close to where the tool is configured, leaving
the traversal algorithms themselves relatively pure.

Assuming these patches are accepted into the mainline, I intend to use
these new facilities to build algorithms that:
   - list a unique path between two commits (useful for undo/redo logic)
   - list the segments in the graph (useful for building visualisations)
---

 t/t6001-rev-list-merge-order.sh |  240 +++++++++++++++++++++++++--------------
 1 files changed, 156 insertions(+), 84 deletions(-)

diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
old mode 100644
new mode 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -3,77 +3,74 @@
 # Copyright (c) 2005 Jon Seymour
 #
 
-test_description='Test rev-list --merge-order
-'
+test_description='Tests git-rev-list --merge-order functionality'
+
 . ./test-lib.sh
+
+#
+# TODO: move the following block (upto --- end ...) into testlib.sh
+#
 [ -d .git/refs/tags ] || mkdir -p .git/refs/tags
 
 sed_script="";
 
+# Answer the sha1 has associated with the tag. The tag must exist in .git or .git/refs/tags
 function tag
 {
-	local _tag=$1
+	_tag=$1
 	[ -f .git/refs/tags/$_tag ] || error "tag: \"$_tag\" does not exist"
 	cat .git/refs/tags/$_tag
 }
 
-function commit
+# Generate a commit using the text specified to make it unique and the tree
+# named by the tag specified.
+function unique_commit
 {
-	local _tag=$1
-        local _tree=$2
+	_text=$1
+        _tree=$2
 	shift 2
-    	echo $_tag | git-commit-tree $(tag $_tree) "$@"
+    	echo $_text | git-commit-tree $(tag $_tree) "$@"
 }
 
+# Save the output of a command into the tag specified. Prepend
+# a substitution script for the tag onto the front of $sed_script
 function save_tag
 {
-	local _tag=$1	
-	[ -n "$_tag" ] || error "usage: do_commit tag commit-args ..."
+	_tag=$1	
+	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
 	shift 1
     	"$@" >.git/refs/tags/$_tag
     	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
 }
 
+# Replace unhelpful sha1 hashses with their symbolic equivalents 
 function entag
 {
 	sed "$sed_script"
 }
 
+# Execute a command after first saving, then setting the GIT_AUTHOR_EMAIL
+# tag to a specified value. Restore the original value on return.
 function as_author
 {
-	local _author=$1
+	_author=$1
 	shift 1
-        local _save=$GIT_AUTHOR_EMAIL
+        _save=$GIT_AUTHOR_EMAIL
 
 	export GIT_AUTHOR_EMAIL="$_author"
 	"$@"
         export GIT_AUTHOR_EMAIL="$_save"
 }
 
+# Execute a command and suppress any error output.
 function hide_error
 {
 	"$@" 2>/dev/null
 }
 
-function check_adjacency
-{
-    read previous
-    echo "= $previous"
-    while read next
-    do
-        if ! (git-cat-file commit $previous | grep "^parent $next" >/dev/null)
-        then
-            echo "^ $next"
-        else
-            echo "| $next"
-        fi
-        previous=$next
-    done
-}
-
 function check_output
 {
-	local _name=$1
+	_name=$1
 	shift 1
 	if "$@" | entag > $_name.actual
 	then
@@ -84,64 +81,99 @@ function check_output
 	
 }
 
+# Turn a reasonable test description into a reasonable test name.
+# All alphanums translated into -'s which are then compressed and stripped
+# from front and back.
 function name_from_description
 {
-        tr "'" '.' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/?-' '.' | tr -s '.' | tr ' ' '-' | tr '[A-Z]' '[a-z]' | sed "s/^\.*//"
+        tr "'" '-' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' '-' | tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
 }
 
-#
-# stdin contains expected result
-#
+
+# Execute the test described by the first argument, by eval'ing
+# command line specified in the 2nd argument. Check the status code
+# is zero and that the output matches the stream read from 
+# stdin.
 function test_output_expect_success
 {	
-	local _description=$1
-	shift 1
-        local _name=$(echo $_description | name_from_description)
+	_description=$1
+        _test=$2
+        [ $# -eq 2 ] || error "usage: test_output_expect_success description test <<EOF ... EOF"
+        _name=$(echo $_description | name_from_description)
 	cat > $_name.expected
-	test_expect_success "$_description" "check_output $_name $*" 
+	test_expect_success "$_description" "check_output $_name $_test" 
+}
+
+# --- end of stuff to move ---
+
+# test-case specific test function
+function check_adjacency
+{
+    read previous
+    echo "= $previous"
+    while read next
+    do
+        if ! (git-cat-file commit $previous | grep "^parent $next" >/dev/null)
+        then
+            echo "^ $next"
+        else
+            echo "| $next"
+        fi
+        previous=$next
+    done
 }
 
+
 date >path0
 git-update-cache --add path0
 save_tag tree git-write-tree
-hide_error save_tag root commit root tree
-save_tag l0 commit l0 tree -p root
-save_tag l1 commit l1 tree -p l0
-save_tag l2 commit l2 tree -p l1
-save_tag a0 commit a0 tree -p l2
-save_tag a1 commit a1 tree -p a0
-save_tag b1 commit b1 tree -p a0
-save_tag c1 commit c1 tree -p b1
-as_author foobar@example.com save_tag b2 commit b2 tree -p b1
-save_tag b3 commit b2 tree -p b2
-save_tag c2 commit c2 tree -p c1 -p b2
-save_tag c3 commit c3 tree -p c2
-save_tag a2 commit a2 tree -p a1
-save_tag a3 commit a3 tree -p a2
-save_tag b4 commit b4 tree -p b3 -p a3
-save_tag a4 commit a4 tree -p a3 -p b4 -p c3
-save_tag l3 commit l3 tree -p a4
-save_tag l4 commit l4 tree -p l3
-save_tag l5 commit l5 tree -p l4
-hide_error save_tag e1 as_author e@example.com commit e1 tree
-save_tag e2 as_author e@example.com commit e2 tree -p e1
-save_tag f1 as_author f@example.com commit f1 tree -p e1
-save_tag e3 as_author e@example.com commit e3 tree -p e2
-save_tag f2 as_author f@example.com commit f2 tree -p f1
-save_tag e4 as_author e@example.com commit e4 tree -p e3 -p f2
-save_tag e5 as_author e@example.com commit e5 tree -p e4
-save_tag f3 as_author f@example.com commit f3 tree -p f2
-save_tag f4 as_author f@example.com commit f4 tree -p f3
-save_tag e6 as_author e@example.com commit e6 tree -p e5 -p f4
-save_tag f5 as_author f@example.com commit f5 tree -p f4
-save_tag f6 as_author f@example.com commit f6 tree -p f5 -p e6
-save_tag e7 as_author e@example.com commit e7 tree -p e6
-save_tag e8 as_author e@example.com commit e8 tree -p e7
-save_tag e9 as_author e@example.com commit e9 tree -p e8
-save_tag f7 as_author f@example.com commit f7 tree -p f6
-save_tag f8 as_author f@example.com commit f8 tree -p f7
-save_tag f9 as_author f@example.com commit f9 tree -p f8
-save_tag e10 as_author e@example.com commit e1 tree -p e9 -p f8
+hide_error save_tag root unique_commit root tree
+save_tag l0 unique_commit l0 tree -p root
+save_tag l1 unique_commit l1 tree -p l0
+save_tag l2 unique_commit l2 tree -p l1
+save_tag a0 unique_commit a0 tree -p l2
+save_tag a1 unique_commit a1 tree -p a0
+save_tag b1 unique_commit b1 tree -p a0
+save_tag c1 unique_commit c1 tree -p b1
+as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
+save_tag b3 unique_commit b2 tree -p b2
+save_tag c2 unique_commit c2 tree -p c1 -p b2
+save_tag c3 unique_commit c3 tree -p c2
+save_tag a2 unique_commit a2 tree -p a1
+save_tag a3 unique_commit a3 tree -p a2
+save_tag b4 unique_commit b4 tree -p b3 -p a3
+save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+save_tag l3 unique_commit l3 tree -p a4
+save_tag l4 unique_commit l4 tree -p l3
+save_tag l5 unique_commit l5 tree -p l4
+hide_error save_tag e1 as_author e@example.com unique_commit e1 tree
+save_tag e2 as_author e@example.com unique_commit e2 tree -p e1
+save_tag f1 as_author f@example.com unique_commit f1 tree -p e1
+save_tag e3 as_author e@example.com unique_commit e3 tree -p e2
+save_tag f2 as_author f@example.com unique_commit f2 tree -p f1
+save_tag e4 as_author e@example.com unique_commit e4 tree -p e3 -p f2
+save_tag e5 as_author e@example.com unique_commit e5 tree -p e4
+save_tag f3 as_author f@example.com unique_commit f3 tree -p f2
+save_tag f4 as_author f@example.com unique_commit f4 tree -p f3
+save_tag e6 as_author e@example.com unique_commit e6 tree -p e5 -p f4
+save_tag f5 as_author f@example.com unique_commit f5 tree -p f4
+save_tag f6 as_author f@example.com unique_commit f6 tree -p f5 -p e6
+save_tag e7 as_author e@example.com unique_commit e7 tree -p e6
+save_tag e8 as_author e@example.com unique_commit e8 tree -p e7
+save_tag e9 as_author e@example.com unique_commit e9 tree -p e8
+save_tag f7 as_author f@example.com unique_commit f7 tree -p f6
+save_tag f8 as_author f@example.com unique_commit f8 tree -p f7
+save_tag f9 as_author f@example.com unique_commit f9 tree -p f8
+save_tag e10 as_author e@example.com unique_commit e1 tree -p e9 -p f8
+
+hide_error save_tag g0 unique_commit g0 tree
+save_tag g1 unique_commit g1 tree -p g0
+save_tag h1 unique_commit g2 tree -p g0
+save_tag g2 unique_commit g3 tree -p g1 -p h1
+save_tag h2 unique_commit g4 tree -p g2
+save_tag g3 unique_commit g5 tree -p g2
+save_tag g4 unique_commit g6 tree -p g3 -p h2
+
 tag l5 > .git/HEAD
 
 #
@@ -153,15 +185,15 @@ tag l5 > .git/HEAD
 #
 echo $sed_script > sed.script
 
-test_expect_success 'Testing that the rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
+test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
 19
 EOF
 
 normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
 merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
-test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+test_expect_success '--merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
 
-test_output_expect_success 'Simple Merge Order Test' 'git-rev-list --merge-order --show-breaks HEAD' <<EOF
+test_output_expect_success 'simple merge order' 'git-rev-list --merge-order --show-breaks HEAD' <<EOF
 = l5
 | l4
 | l3
@@ -183,7 +215,17 @@ test_output_expect_success 'Simple Merge
 = root
 EOF
 
-test_output_expect_success 'Multiple heads' 'git-rev-list --merge-order a3 b3 c3' <<EOF
+test_output_expect_success 'two diamonds merge order (g6)' 'git-rev-list --merge-order --show-breaks g4' <<EOF
+= g4
+| h2
+^ g3
+= g2
+| h1
+^ g1
+= g0
+EOF
+
+test_output_expect_success 'multiple heads' 'git-rev-list --merge-order a3 b3 c3' <<EOF
 c3
 c2
 c1
@@ -200,7 +242,7 @@ l0
 root
 EOF
 
-test_output_expect_success 'Prune at a1' 'git-rev-list --merge-order a3 b3 c3 ^a1' <<EOF
+test_output_expect_success 'multiple heads, prune at a1' 'git-rev-list --merge-order a3 b3 c3 ^a1' <<EOF
 c3
 c2
 c1
@@ -211,7 +253,7 @@ a3
 a2
 EOF
 
-test_output_expect_success 'Prune at l1' 'git-rev-list --merge-order a3 b3 c3 ^l1' <<EOF
+test_output_expect_success 'multiple heads, prune at l1' 'git-rev-list --merge-order a3 b3 c3 ^l1' <<EOF
 c3
 c2
 c1
@@ -225,7 +267,7 @@ a0
 l2
 EOF
 
-test_output_expect_success 'Head at l5, Prune at l1' 'git-rev-list --merge-order l5 ^l1' <<EOF
+test_output_expect_success 'cross-epoch, head at l5, prune at l1' 'git-rev-list --merge-order l5 ^l1' <<EOF
 l5
 l4
 l3
@@ -244,7 +286,7 @@ a0
 l2
 EOF
 
-test_output_expect_success 'Duplicated head arguments' 'git-rev-list --merge-order l5 l5 ^l1' <<EOF
+test_output_expect_success 'duplicated head arguments' 'git-rev-list --merge-order l5 l5 ^l1' <<EOF
 l5
 l4
 l3
@@ -263,7 +305,7 @@ a0
 l2
 EOF
 
-test_output_expect_success 'Prune near merge' 'git-rev-list --merge-order a4 ^c3' <<EOF
+test_output_expect_success 'prune near merge' 'git-rev-list --merge-order a4 ^c3' <<EOF
 a4
 b4
 b3
@@ -294,7 +336,7 @@ test_output_expect_success '--wrt-author
 = root
 EOF
 
-test_output_expect_success "Prune at foobar@example.com" 'git-rev-list --show-breaks --wrt-author --author=foobar@example.com --prune-at-author HEAD' <<EOF
+test_output_expect_success "prune at foobar@example.com" 'git-rev-list --show-breaks --wrt-author --author=foobar@example.com --prune-at-author HEAD' <<EOF
 = l5
 | l4
 | l3
@@ -392,6 +434,36 @@ test_output_expect_success "three nodes 
 = root
 EOF
 
+test_output_expect_success "linear prune l2 ^root" 'git-rev-list --show-breaks l2 ^root' <<EOF
+= l2
+| l1
+| l0
+EOF
+
+test_output_expect_success "linear prune l2 ^l0" 'git-rev-list --show-breaks l2 ^l0' <<EOF
+= l2
+| l1
+EOF
+
+test_output_expect_success "linear prune l2 ^l1" 'git-rev-list --show-breaks l2 ^l1' <<EOF
+= l2
+EOF
+
+test_output_expect_success "linear prune l5 ^a4" 'git-rev-list --show-breaks l5 ^a4' <<EOF
+= l5
+| l4
+| l3
+EOF
+
+test_output_expect_success "linear prune l5 ^l3" 'git-rev-list --show-breaks l5 ^l3' <<EOF
+= l5
+| l4
+EOF
+
+test_output_expect_success "linear prune l5 ^l4" 'git-rev-list --show-breaks l5 ^l4' <<EOF
+= l5
+EOF
+
 test_expect_failure "all heads uninteresting" 'git-rev-list --show-breaks a3 ^a3'
 #
 #
------------
