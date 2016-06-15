From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/7] Additional git-rev-list unit tests to demonstrate problems that require fixes
Date: Mon, 20 Jun 2005 12:29:26 +1000
Message-ID: <20050620022926.28536.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:25:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkByK-0006nG-H6
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFTCau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFTCau
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:30:50 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:51586 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261393AbVFTC3a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 22:29:30 -0400
Received: (qmail 28546 invoked by uid 500); 20 Jun 2005 02:29:26 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


1. --merge-order doesn't deal properly with a specified head that has no parent

   * FAIL 11: head has no parent 

2. --merge-order doesn't deal properly with arguments of the form 
     head ^head

   * FAIL 30: head ^head --merge-order git-rev-list --merge-order 
     --show-breaks a3 ^a3

3. if one of the specified heads is reachable from the other, the 
   head gets printed twice and this causes problems for upcoming 
   versions of gitk. This is true for both --merge-order and non 
   --merge-order style of invocations.
    * FAIL 24: one specified head reachable from another a4, c3, --merge-order 
    * FAIL 26: one specified head reachable from another a4, c3, no --merge-order 
    * FAIL 27: one specified head reachable from another c3, a4, no --merge-order 

4. --merge-order aborts with commits that list the same parent twice...it should handle it more gracefully.
    * no longer unit testable 

5. broken interaction between --merge-order and --max-age
   previously posted as:

    "[PATCH 1/2] Test case that demonstrates problem with --merge-order, --max-age interaction"
    * FAIL 23: --max-age=c3, --merge-order 

Later patches in this patch set fix these problems.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

This patch series contains:

[PATCH 1/7] Additional git-rev-list unit tests to demonstrate problems that require fixes
[PATCH 2/7] Tweaked --merge-order --show-breaks output in case specified head has no parent
[PATCH 3/7] Fixes problem with --merge-order head ^head
[PATCH 4/7] Relaxes error checking in epoch.c to allow duplicate parents
[PATCH 5/7] Prevent git-rev-list --merge-order producing duplicates in the output
[PATCH 6/7] Prevent git-rev-list without --merge-order producing duplicates in output
[PATCH 7/7] Fix for --merge-order, --max-age interaction issue

It is a complete superset of this series:

[PATCH 2/2] Fix for --merge-order, --max-age interaction issue
[PATCH 1/2] Test case that demonstrates problem with --merge-order, --max-age interaction

Patches apply cleanly to Linus HEAD - 31b6d200d6c5ed019f62d88ef0926faeb0150aac.

Some unit tests fail until all patches have been applied and built at which point
they pass.

 t/t6001-rev-list-merge-order.sh |  434 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 374 insertions(+), 60 deletions(-)

diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -3,16 +3,124 @@
 # Copyright (c) 2005 Jon Seymour
 #
 
-test_description='Test rev-list --merge-order
-'
+test_description='Tests git-rev-list --merge-order functionality'
+
 . ./test-lib.sh
 
-function do_commit
+#
+# TODO: move the following block (upto --- end ...) into testlib.sh
+#
+[ -d .git/refs/tags ] || mkdir -p .git/refs/tags
+
+sed_script="";
+
+# Answer the sha1 has associated with the tag. The tag must exist in .git or .git/refs/tags
+tag()
+{
+	_tag=$1
+	[ -f .git/refs/tags/$_tag ] || error "tag: \"$_tag\" does not exist"
+	cat .git/refs/tags/$_tag
+}
+
+# Generate a commit using the text specified to make it unique and the tree
+# named by the tag specified.
+unique_commit()
+{
+	_text=$1
+        _tree=$2
+	shift 2
+    	echo $_text | git-commit-tree $(tag $_tree) "$@"
+}
+
+# Save the output of a command into the tag specified. Prepend
+# a substitution script for the tag onto the front of $sed_script
+save_tag()
+{
+	_tag=$1	
+	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
+	shift 1
+    	"$@" >.git/refs/tags/$_tag
+    	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
+}
+
+# Replace unhelpful sha1 hashses with their symbolic equivalents 
+entag()
+{
+	sed "$sed_script"
+}
+
+# Execute a command after first saving, then setting the GIT_AUTHOR_EMAIL
+# tag to a specified value. Restore the original value on return.
+as_author()
+{
+	_author=$1
+	shift 1
+        _save=$GIT_AUTHOR_EMAIL
+
+	export GIT_AUTHOR_EMAIL="$_author"
+	"$@"
+        export GIT_AUTHOR_EMAIL="$_save"
+}
+
+commit_date()
+{
+        _commit=$1
+	git-cat-file commit $_commit | sed -n "s/^committer .*> \([0-9]*\) .*/\1/p" 
+}
+
+on_committer_date()
+{
+    _date=$1
+    shift 1
+    GIT_COMMITTER_DATE=$_date "$@"
+}
+
+# Execute a command and suppress any error output.
+hide_error()
 {
-    git-commit-tree "$@" </dev/null
+	"$@" 2>/dev/null
+}
+
+check_output()
+{
+	_name=$1
+	shift 1
+	if "$@" | entag > $_name.actual
+	then
+		diff $_name.expected $_name.actual
+	else
+		return 1;
+	fi
+	
+}
+
+# Turn a reasonable test description into a reasonable test name.
+# All alphanums translated into -'s which are then compressed and stripped
+# from front and back.
+name_from_description()
+{
+        tr "'" '-' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' '-' | tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
+}
+
+
+# Execute the test described by the first argument, by eval'ing
+# command line specified in the 2nd argument. Check the status code
+# is zero and that the output matches the stream read from 
+# stdin.
+test_output_expect_success()
+{	
+	_description=$1
+        _test=$2
+        [ $# -eq 2 ] || error "usage: test_output_expect_success description test <<EOF ... EOF"
+        _name=$(echo $_description | name_from_description)
+	cat > $_name.expected
+	test_expect_success "$_description" "check_output $_name $_test" 
 }
 
-function check_adjacency
+# --- end of stuff to move ---
+
+# test-case specific test function
+check_adjacency()
 {
     read previous
     echo "= $previous"
@@ -28,43 +136,94 @@ function check_adjacency
     done
 }
 
-function sed_script
+list_duplicates()
+{
+    "$@" | sort | uniq -d
+}
+
+grep_stderr()
 {
-   for c in root a0 a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 l0 l1 l2 l3 l4 l5
-   do
-       echo -n "s/${!c}/$c/;"
-   done
+    args=$1
+    shift 1
+    "$@" 2>&1 | grep "$args"
 }
 
 date >path0
 git-update-cache --add path0
-tree=$(git-write-tree)
-root=$(do_commit $tree 2>/dev/null)
-export GIT_COMMITTER_NAME=foobar  # to guarantee that the commit is different
-l0=$(do_commit $tree -p $root)
-l1=$(do_commit $tree -p $l0)
-l2=$(do_commit $tree -p $l1)
-a0=$(do_commit $tree -p $l2)
-a1=$(do_commit $tree -p $a0)
-export GIT_COMMITTER_NAME=foobar2 # to guarantee that the commit is different
-b1=$(do_commit $tree -p $a0)
-c1=$(do_commit $tree -p $b1)
-export GIT_COMMITTER_NAME=foobar3 # to guarantee that the commit is different
-b2=$(do_commit $tree -p $b1)
-b3=$(do_commit $tree -p $b2)
-c2=$(do_commit $tree -p $c1 -p $b2)
-c3=$(do_commit $tree -p $c2)
-a2=$(do_commit $tree -p $a1)
-a3=$(do_commit $tree -p $a2)
-b4=$(do_commit $tree -p $b3 -p $a3)
-a4=$(do_commit $tree -p $a3 -p $b4 -p $c3)
-l3=$(do_commit $tree -p $a4)
-l4=$(do_commit $tree -p $l3)
-l5=$(do_commit $tree -p $l4)
-echo $l5 > .git/HEAD
+save_tag tree git-write-tree
+on_committer_date "1971-08-16 00:00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "1971-08-16 00:00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "1971-08-16 00:00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "1971-08-16 00:00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "1971-08-16 00:00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "1971-08-16 00:00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "1971-08-16 00:00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "1971-08-16 00:00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "1971-08-16 00:00:08" as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
+on_committer_date "1971-08-16 00:00:09" save_tag b3 unique_commit b2 tree -p b2
+on_committer_date "1971-08-16 00:00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_committer_date "1971-08-16 00:00:11" save_tag c3 unique_commit c3 tree -p c2
+on_committer_date "1971-08-16 00:00:12" save_tag a2 unique_commit a2 tree -p a1
+on_committer_date "1971-08-16 00:00:13" save_tag a3 unique_commit a3 tree -p a2
+on_committer_date "1971-08-16 00:00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_committer_date "1971-08-16 00:00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_committer_date "1971-08-16 00:00:16" save_tag l3 unique_commit l3 tree -p a4
+on_committer_date "1971-08-16 00:00:17" save_tag l4 unique_commit l4 tree -p l3
+on_committer_date "1971-08-16 00:00:18" save_tag l5 unique_commit l5 tree -p l4
+on_committer_date "1971-08-16 00:00:19" save_tag m1 unique_commit m1 tree -p a4 -p c3
+on_committer_date "1971-08-16 00:00:20" save_tag m2 unique_commit m2 tree -p c3 -p a4
+#
+# note: as of 20/6, it isn't possible to create duplicate parents, so this
+# can't be tested.
+#
+#on_committer_date "1971-08-16 00:00:20" save_tag m3 unique_commit m3 tree -p c3 -p a4 -p c3
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
+tag l5 > .git/HEAD
+
+#
+# cd to t/trash and use 
+#
+#    git-rev-list ... 2>&1 | sed "$(cat sed.script)" 
+#
+# if you ever want to manually debug the operation of git-rev-list
+#
+echo $sed_script > sed.script
 
-git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
-cat > expected-merge-order <<EOF
+test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
+19
+EOF
+
+normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+test_expect_success '--merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+test_output_expect_success 'simple merge order' 'git-rev-list --merge-order --show-breaks HEAD' <<EOF
 = l5
 | l4
 | l3
@@ -86,15 +245,17 @@ cat > expected-merge-order <<EOF
 = root
 EOF
 
-git-rev-list HEAD | check_adjacency | sed "$(sed_script)" > actual-default-order
-normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
-merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
-
-test_expect_success 'Testing that the rev-list has correct number of entries' '[ $(git-rev-list HEAD | wc -l) -eq 19 ]'
-test_expect_success 'Testing that --merge-order produces the correct result' 'diff expected-merge-order actual-merge-order'
-test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+test_output_expect_success 'two diamonds merge order (g6)' 'git-rev-list --merge-order --show-breaks g4' <<EOF
+= g4
+| h2
+^ g3
+= g2
+| h1
+^ g1
+= g0
+EOF
 
-cat > expected-merge-order-1 <<EOF
+test_output_expect_success 'multiple heads' 'git-rev-list --merge-order a3 b3 c3' <<EOF
 c3
 c2
 c1
@@ -111,10 +272,7 @@ l0
 root
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 | sed "$(sed_script)" > actual-merge-order-1
-test_expect_success 'Testing multiple heads' 'diff expected-merge-order-1 actual-merge-order-1'
-
-cat > expected-merge-order-2 <<EOF
+test_output_expect_success 'multiple heads, prune at a1' 'git-rev-list --merge-order a3 b3 c3 ^a1' <<EOF
 c3
 c2
 c1
@@ -125,10 +283,7 @@ a3
 a2
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 ^$a1 | sed "$(sed_script)" > actual-merge-order-2
-test_expect_success 'Testing stop' 'diff expected-merge-order-2 actual-merge-order-2'
-
-cat > expected-merge-order-3 <<EOF
+test_output_expect_success 'multiple heads, prune at l1' 'git-rev-list --merge-order a3 b3 c3 ^l1' <<EOF
 c3
 c2
 c1
@@ -142,10 +297,26 @@ a0
 l2
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 ^$l1 | sed "$(sed_script)" > actual-merge-order-3
-test_expect_success 'Testing stop in linear epoch' 'diff expected-merge-order-3 actual-merge-order-3'
+test_output_expect_success 'cross-epoch, head at l5, prune at l1' 'git-rev-list --merge-order l5 ^l1' <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
 
-cat > expected-merge-order-4 <<EOF
+test_output_expect_success 'duplicated head arguments' 'git-rev-list --merge-order l5 l5 ^l1' <<EOF
 l5
 l4
 l3
@@ -164,12 +335,155 @@ a0
 l2
 EOF
 
-git-rev-list --merge-order $l5 ^$l1 | sed "$(sed_script)" > actual-merge-order-4
-test_expect_success 'Testing start in linear epoch, stop after non-linear epoch' 'diff expected-merge-order-4 actual-merge-order-4'
+test_output_expect_success 'prune near merge' 'git-rev-list --merge-order a4 ^c3' <<EOF
+a4
+b4
+b3
+a3
+a2
+a1
+EOF
+
+test_output_expect_success "head has no parent" 'git-rev-list --merge-order --show-breaks root' <<EOF
+= root
+EOF
 
-git-rev-list --merge-order $l5 $l5 ^$l1 2>/dev/null | sed "$(sed_script)" > actual-merge-order-5
-test_expect_success 'Testing duplicated start arguments' 'diff expected-merge-order-4 actual-merge-order-5'
+test_output_expect_success "two nodes - one head, one base" 'git-rev-list --merge-order --show-breaks l0' <<EOF
+= l0
+= root
+EOF
 
-test_expect_success 'Testing exclusion near merge' 'git-rev-list --merge-order $a4 ^$c3 2>/dev/null'
+test_output_expect_success "three nodes one head, one internal, one base" 'git-rev-list --merge-order --show-breaks l1' <<EOF
+= l1
+| l0
+= root
+EOF
+
+test_output_expect_success "linear prune l2 ^root" 'git-rev-list --merge-order --show-breaks l2 ^root' <<EOF
+= l2
+| l1
+| l0
+EOF
+
+test_output_expect_success "linear prune l2 ^l0" 'git-rev-list --merge-order --show-breaks l2 ^l0' <<EOF
+= l2
+| l1
+EOF
+
+test_output_expect_success "linear prune l2 ^l1" 'git-rev-list --merge-order --show-breaks l2 ^l1' <<EOF
+= l2
+EOF
+
+test_output_expect_success "linear prune l5 ^a4" 'git-rev-list --merge-order --show-breaks l5 ^a4' <<EOF
+= l5
+| l4
+| l3
+EOF
+
+test_output_expect_success "linear prune l5 ^l3" 'git-rev-list --merge-order --show-breaks l5 ^l3' <<EOF
+= l5
+| l4
+EOF
+
+test_output_expect_success "linear prune l5 ^l4" 'git-rev-list --merge-order --show-breaks l5 ^l4' <<EOF
+= l5
+EOF
+
+test_output_expect_success "max-count 10 - merge order" 'git-rev-list --merge-order --show-breaks --max-count=10 l5' <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| b3
+| b2
+EOF
+
+test_output_expect_success "max-count 10 - non merge order" 'git-rev-list --max-count=10 l5 | sort' <<EOF
+a4
+b2
+b3
+b4
+c1
+c2
+c3
+l3
+l4
+l5
+EOF
+
+test_output_expect_success '--max-age=c3, no --merge-order' "git-rev-list --max-age=$(commit_date c3) l5" <<EOF
+l5
+l4
+l3
+a4
+b4
+a3
+a2
+c3
+EOF
+
+test_output_expect_success '--max-age=c3, --merge-order' "git-rev-list --merge-order --max-age=$(commit_date c3) l5" <<EOF
+l5
+l4
+l3
+a4
+c3
+b4
+a3
+a2
+EOF
+
+test_output_expect_success 'one specified head reachable from another a4, c3, --merge-order' "list_duplicates git-rev-list --merge-order a4 c3" <<EOF
+EOF
+
+test_output_expect_success 'one specified head reachable from another c3, a4, --merge-order' "list_duplicates git-rev-list --merge-order c3 a4" <<EOF
+EOF
+
+test_output_expect_success 'one specified head reachable from another a4, c3, no --merge-order' "list_duplicates git-rev-list a4 c3" <<EOF
+EOF
+
+test_output_expect_success 'one specified head reachable from another c3, a4, no --merge-order' "list_duplicates git-rev-list c3 a4" <<EOF
+EOF
+
+test_output_expect_success 'graph with c3 and a4 parents of head' "list_duplicates git-rev-list m1" <<EOF
+EOF
+
+test_output_expect_success 'graph with a4 and c3 parents of head' "list_duplicates git-rev-list m2" <<EOF
+EOF
+
+test_expect_success "head ^head --merge-order" 'git-rev-list --merge-order --show-breaks a3 ^a3' <<EOF
+EOF
+
+#
+# can't test this now - duplicate parents can't be created
+#
+#test_output_expect_success 'duplicate parents' 'git-rev-list --parents --merge-order --show-breaks m3' <<EOF
+#= m3 c3 a4 c3
+#| a4 c3 b4 a3
+#| b4 a3 b3
+#| b3 b2
+#^ a3 a2
+#| a2 a1
+#| a1 a0
+#^ c3 c2
+#| c2 b2 c1
+#| b2 b1
+#^ c1 b1
+#| b1 a0
+#= a0 l2
+#| l2 l1
+#| l1 l0
+#| l0 root
+#= root
+#EOF
+
+test_expect_success "head ^head no --merge-order" 'git-rev-list a3 ^a3' <<EOF
+EOF
+#
+#
 
 test_done
------------
