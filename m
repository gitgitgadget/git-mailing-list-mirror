From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] An alternative implementation of --bisect
Date: Sun, 19 Jun 2005 14:08:36 +1000
Message-ID: <20050619040836.9842.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com, jaharkes@cs.cmu.edu
X-From: git-owner@vger.kernel.org Sun Jun 19 06:04:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djr2Y-0008Ju-6a
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 06:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVFSEJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 00:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVFSEJY
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 00:09:24 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:32899 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261824AbVFSEIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 00:08:39 -0400
Received: (qmail 9852 invoked by uid 500); 19 Jun 2005 04:08:36 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch contains a suggested alternative implementation of the
git-rev-list --bisect flag.

This patch outputs the literal middle element of the list that would
have been output if the --bisect flag had not been present.

It does so by maintaining a list with the following invariant -
for every two elements added to the tail of the list, one is 
removed from the head. The head of the remaining list when the 
traversal stops in the bisection point.

This patch includes a demonstration of Linus' binary bug blatting
idea in t/t6001-rev-list-merge-order.sh which also includes
some additional rev-list tests

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Note: I included the additional tests from another patch I have
submitted already because the test framework included in that
patch is much easier to use. So, for writing new tests, I wanted
to use the newer framework.

Linus: please let me know if/when you want a new series of patches
which contain my generalisation of epoch.c into a commit graph
traversal facility.
---

 rev-list.c                      |   71 +++----
 t/t6001-rev-list-merge-order.sh |  392 +++++++++++++++++++++++++++++++++------
 2 files changed, 357 insertions(+), 106 deletions(-)

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -26,6 +26,9 @@ static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
+static struct commit_list * bisected = NULL;
+static struct commit_list ** bisected_tail = &bisected;
+static int added_since_removed=0;
 
 static void show_commit(struct commit *commit)
 {
@@ -79,12 +82,29 @@ static int process_commit(struct commit 
 		return CONTINUE;
 	}
 
-	show_commit(commit);
+	if (!bisect_list) {
+		show_commit(commit);
+	} else {
+		bisected_tail = &commit_list_insert(commit, bisected_tail)->next;
+		added_since_removed++;
+		if (added_since_removed == 2) {
+			pop_commit(&bisected); /* one remove for every two adds */
+			added_since_removed = 0;
+                }
+	}
 
 	return CONTINUE;
 }
 
-static void show_commit_list(struct commit_list *list)
+static void show_bisection()
+{
+	if (bisected) {
+		show_commit(pop_commit(&bisected));
+		free_commit_list(bisected);
+	}
+}
+
+static void process_commit_list(struct commit_list *list)
 {
 	while (list) {
 		struct commit *commit = pop_most_recent_commit(&list, SEEN);
@@ -149,46 +169,6 @@ static int count_distance(struct commit_
 	return nr;
 }
 
-static int clear_distance(struct commit_list *list)
-{
-	while (list) {
-		struct commit *commit = list->item;
-		commit->object.flags &= ~COUNTED;
-		list = list->next;
-	}
-}
-
-static struct commit_list *find_bisection(struct commit_list *list)
-{
-	int nr, closest;
-	struct commit_list *p, *best;
-
-	nr = 0;
-	p = list;
-	while (p) {
-		nr++;
-		p = p->next;
-	}
-	closest = 0;
-	best = list;
-
-	p = list;
-	while (p) {
-		int distance = count_distance(p);
-		clear_distance(list);
-		if (nr - distance < distance)
-			distance = nr - distance;
-		if (distance > closest) {
-			best = p;
-			closest = distance;
-		}
-		p = p->next;
-	}
-	if (best)
-		best->next = NULL;
-	return best;
-}
-
 struct commit_list *limit_list(struct commit_list *list)
 {
 	struct commit_list *newlist = NULL;
@@ -205,8 +185,6 @@ struct commit_list *limit_list(struct co
 		}
 		p = &commit_list_insert(commit, p)->next;
 	} while (list);
-	if (bisect_list)
-		newlist = find_bisection(newlist);
 	return newlist;
 }
 
@@ -296,12 +274,15 @@ int main(int argc, char **argv)
 	if (!merge_order) {		
 	        if (limited)
 			list = limit_list(list);
-		show_commit_list(list);
+		process_commit_list(list);
 	} else {
 		if (sort_list_in_merge_order(list, &process_commit)) {
 			  die("merge order sort failed\n");
 		}
 	}
+	if (bisect_list) {
+		show_bisection();
+	}
 
 	return 0;
 }
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
old mode 100644
new mode 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -3,15 +3,110 @@
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
+function tag
+{
+	_tag=$1
+	[ -f .git/refs/tags/$_tag ] || error "tag: \"$_tag\" does not exist"
+	cat .git/refs/tags/$_tag
+}
+
+# Generate a commit using the text specified to make it unique and the tree
+# named by the tag specified.
+function unique_commit
+{
+	_text=$1
+        _tree=$2
+	shift 2
+    	echo $_text | git-commit-tree $(tag $_tree) "$@"
+}
+
+# Save the output of a command into the tag specified. Prepend
+# a substitution script for the tag onto the front of $sed_script
+function save_tag
+{
+	_tag=$1	
+	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
+	shift 1
+    	"$@" >.git/refs/tags/$_tag
+    	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
+}
+
+# Replace unhelpful sha1 hashses with their symbolic equivalents 
+function entag
+{
+	sed "$sed_script"
+}
+
+# Execute a command after first saving, then setting the GIT_AUTHOR_EMAIL
+# tag to a specified value. Restore the original value on return.
+function as_author
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
+# Execute a command and suppress any error output.
+function hide_error
 {
-    git-commit-tree "$@" </dev/null
+	"$@" 2>/dev/null
 }
 
+function check_output
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
+function name_from_description
+{
+        tr "'" '-' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' '-' | tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
+}
+
+
+# Execute the test described by the first argument, by eval'ing
+# command line specified in the 2nd argument. Check the status code
+# is zero and that the output matches the stream read from 
+# stdin.
+function test_output_expect_success
+{	
+	_description=$1
+        _test=$2
+        [ $# -eq 2 ] || error "usage: test_output_expect_success description test <<EOF ... EOF"
+        _name=$(echo $_description | name_from_description)
+	cat > $_name.expected
+	test_expect_success "$_description" "check_output $_name $_test" 
+}
+
+# --- end of stuff to move ---
+
+# test-case specific test function
 function check_adjacency
 {
     read previous
@@ -28,43 +123,77 @@ function check_adjacency
     done
 }
 
-function sed_script
-{
-   for c in root a0 a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 l0 l1 l2 l3 l4 l5
-   do
-       echo -n "s/${!c}/$c/;"
-   done
-}
 
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
+
+test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
+19
+EOF
 
-git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
-cat > expected-merge-order <<EOF
+normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+test_expect_success '--merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+
+test_output_expect_success 'simple merge order' 'git-rev-list --merge-order --show-breaks HEAD' <<EOF
 = l5
 | l4
 | l3
@@ -86,15 +215,17 @@ cat > expected-merge-order <<EOF
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
@@ -111,10 +242,7 @@ l0
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
@@ -125,10 +253,7 @@ a3
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
@@ -142,10 +267,26 @@ a0
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
@@ -164,12 +305,141 @@ a0
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
+#
+# note this test fails - has been fixed in a later version of Jon Seymour's HEAD
+#
+#test_output_expect_success "head has no parent" 'git-rev-list --merge-order --show-breaks root' <<EOF
+#= root
+#EOF
+
+test_output_expect_success "two nodes - one head, one base" 'git-rev-list --merge-order --show-breaks l0' <<EOF
+= l0
+= root
+EOF
+
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
+#
+# the following illustrate's Linus' binary bug blatt idea. 
+#
+# assume the bug is actually at l3, but you don't know that - all you know is that l3 is broken
+# and it wasn't broken before
+#
+# keep bisecting the list, advancing the "bad" head and accumulating "good" heads until
+# the bisection point is the head - this is the bad point.
+#
+
+test_output_expect_success "--bisect l5" 'git-rev-list --bisect l5' <<EOF
+a2
+EOF
+
+test_output_expect_success "--bisect l5 ^a2" 'git-rev-list --bisect l5 ^a2' <<EOF
+a3
+EOF
 
-git-rev-list --merge-order $l5 $l5 ^$l1 2>/dev/null | sed "$(sed_script)" > actual-merge-order-5
-test_expect_success 'Testing duplicated start arguments' 'diff expected-merge-order-4 actual-merge-order-5'
+test_output_expect_success "--bisect l5 ^a2 ^a3" 'git-rev-list --bisect l5 ^a2 ^a3' <<EOF
+b4
+EOF
 
-test_expect_success 'Testing exclusion near merge' 'git-rev-list --merge-order $a4 ^$c3 2>/dev/null'
+test_output_expect_success "--bisect l5 ^a2 ^a3 ^b4" 'git-rev-list --bisect l5 ^a2 ^a3 ^b4' <<EOF
+a4
+EOF
 
+test_output_expect_success "--bisect l5 ^a2 ^a3 ^b4 ^a4" 'git-rev-list --bisect l5 ^a2 ^a3 ^a4' <<EOF
+l4
+EOF
+
+#
+# if l3 is bad, then l4 is bad too - so advance the bad pointer by making b4 the known bad head
+#
+
+test_output_expect_success "--bisect l4 ^a2 ^a3 ^b ^a4" 'git-rev-list --bisect l4 ^a2 ^a3 ^a4' <<EOF
+l3
+EOF
+
+test_output_expect_success "--bisect l3 ^a2 ^a3 ^b ^a4" 'git-rev-list --bisect l3 ^a2 ^a3 ^a4' <<EOF
+l3
+EOF
+
+# found!
+
+#
+# as another example, let's consider a4 to be the bad head, in which case
+#
+
+test_output_expect_success "--bisect a4 ^a2 ^a3 ^b4" 'git-rev-list --bisect a4 ^a2 ^a3 ^b4' <<EOF
+c2
+EOF
+
+test_output_expect_success "--bisect a4 ^a2 ^a3 ^b4 ^c2" 'git-rev-list --bisect a4 ^a2 ^a3 ^b4 ^c2' <<EOF
+c3
+EOF
+
+test_output_expect_success "--bisect a4 ^a2 ^a3 ^b4 ^c2 ^c3" 'git-rev-list --bisect a4 ^a2 ^a3 ^b4 ^c2 ^c3' <<EOF
+a4
+EOF
+
+# found!
+
+#
+# or consider c3 to be the bad head
+#
+
+test_output_expect_success "--bisect a4 ^a2 ^a3 ^b4" 'git-rev-list --bisect a4 ^a2 ^a3 ^b4' <<EOF
+c2
+EOF
+
+test_output_expect_success "--bisect c3 ^a2 ^a3 ^b4 ^c2" 'git-rev-list --bisect c3 ^a2 ^a3 ^b4 ^c2' <<EOF
+c3
+EOF
+
+# found!
+
+
+test_expect_failure "all heads uninteresting" 'git-rev-list --merge-order --show-breaks a3 ^a3'
+#
+#
 test_done
------------
