From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/1] git-bug-blatt-script - a script to automate bug finding using Linus' bug blatt algorithm.
Date: Sun, 19 Jun 2005 19:22:28 +1000
Message-ID: <20050619092228.18175.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sun Jun 19 11:17:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djvvd-0001P3-PI
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 11:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVFSJWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 05:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVFSJWy
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 05:22:54 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:36992 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262218AbVFSJWc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 05:22:32 -0400
Received: (qmail 18185 invoked by uid 500); 19 Jun 2005 09:22:28 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This script uses Linus' bug-blatt algorithm to locate a commit which introduced a bug.

To use this script you need to have the following:

    - a script that will seek, build and install a specified commit
    - a script that will test a build and determine whether it contains a bug

An example test script is included which will simulate an injected bug at a given
commit.

To run this test, use:

    count=$(git-rev-list HEAD | wc -l)
    root=$(git-rev-list HEAD | tail -1)
    # choose an example, 1/3 of the way through the list.
    bug=$(git-rev-list HEAD | head -$(echo $count 3 / | dc) | tail -1)
    # use "" in second argument to specify a null build
    git bug-blatt "" "t/simulate-bug-at $bug" HEAD $root 2>/dev/null

A test case for git-bug-blatt-script has been included in t/t6002-bug-blatt.sh

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 git-bug-blatt-script            |   91 +++++++++++++
 t/simulate-bug-at               |   11 ++
 t/t6002-git-bug-blatt-script.sh |  280 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+), 0 deletions(-)

diff --git a/git-bug-blatt-script b/git-bug-blatt-script
new file mode 100755
--- /dev/null
+++ b/git-bug-blatt-script
@@ -0,0 +1,91 @@
+#!/bin/sh
+#
+# (C) Linus Torvalds, Jon Seymour 2005
+#
+# Based on an algorithm posted to the git-list by Linus
+# Torvalds.
+#
+
+die()
+{
+	echo "$*" 1>&2
+	exit 1
+}
+
+info()
+{
+    echo "$@" 1>&2
+}
+
+build_commit()
+{
+	_commit=$1
+	info -n "build @ $_commit..."
+	[ -n "$build" ] || build="echo"
+	if eval "$build $_commit" >/dev/null 2>&1 
+	then
+	    info "ok"
+        else
+	    info "bad"
+	    die "git-bug-blatt-script: build failed @ $_commit"
+        fi
+}
+
+test_commit()
+{
+        _commit=$1
+	info -n "test @ $_commit..."
+	eval "$test $_commit" >/dev/null 2>&1
+	if [ $? -eq 0 ]
+	then
+		info "ok"
+		return 0
+	else
+		info "failed"
+		return 1
+	fi				
+}
+
+build=$1
+test=$2
+known_bad=$3
+shift 3
+known_goods="$*"
+
+[ -n "$known_goods" ] || die "usage: git-bug-blatt-script build-cmd test-cmd known-bad known-good ...";
+
+(
+build_commit $known_bad 
+test_commit $known_bad  && die "$known_bad doesn't actually look bad - please check the test"	
+
+good_args=""
+for g in $known_goods
+do
+	build_commit $g
+	test_commit $g || die "$g isn't actually good - please check the test"
+	good_args=${good_args}${good_args+ }^$g
+done
+
+start_size=$(git-rev-list $known_bad $good_args | wc -l)
+iterations=0
+while true
+do
+	iterations=`expr $iterations + 1`
+	bisection=$(git-rev-list --bisect $known_bad $good_args)
+	if [ "$bisection" == "$known_bad" ] 	
+	then
+		info "bug found @ $bisection in $iterations iterations" 
+		echo $bisection
+		exit 0
+	fi
+	build_commit $bisection
+	if test_commit $bisection
+	then
+		good_args=${good_args}${good_args+ }"^$bisection"
+	else
+		known_bad=${bisection}		
+	fi
+done
+)
+rc=$?
+exit $rc
diff --git a/t/simulate-bug-at b/t/simulate-bug-at
new file mode 100755
--- /dev/null
+++ b/t/simulate-bug-at
@@ -0,0 +1,11 @@
+#!/bin/sh
+bug=$1
+commit=$2
+if git-rev-list $commit | grep "$bug"
+then
+	echo "simulated test failed at $commit"
+	exit 1;
+else
+        echo "simulated test ok at $commit"
+	exit 0;
+fi
diff --git a/t/t6002-git-bug-blatt-script.sh b/t/t6002-git-bug-blatt-script.sh
new file mode 100755
--- /dev/null
+++ b/t/t6002-git-bug-blatt-script.sh
@@ -0,0 +1,280 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Jon Seymour
+#
+
+test_description='Tests git-bug-blatt and --bisect functionality'
+
+. ./test-lib.sh
+
+
+on_committer_date()
+{
+    _date=$1
+    shift 1
+    GIT_COMMITTER_DATE=$_date "$@"
+}
+
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
+# Execute a command and suppress any error output.
+hide_error()
+{
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
+}
+
+# --- end of stuff to move ---
+
+date >path0
+git-update-cache --add path0
+save_tag tree git-write-tree
+on_committer_date "1971-08-16 00:00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "1971-08-16 00:00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "1971-08-16 00:00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "1971-08-16 00:00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "1971-08-16 00:00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "1971-08-16 00:00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "1971-08-16 00:00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "1971-08-16 00:00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "1971-08-16 00:00:08" save_tag b2 unique_commit b2 tree -p b1
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
+tag l5 > .git/HEAD
+
+
+#     E
+#    / \
+#   e1  |
+#   |   |
+#   e2  |
+#   |   |
+#   e3  |
+#   |   |
+#   e4  |
+#   |   |
+#   |   f1
+#   |   |
+#   |   f2
+#   |   |
+#   |   f3
+#   |   |
+#   |   f4
+#   |   |
+#   e5  |
+#   |   |
+#   e6  |
+#   |   |
+#   e7  |
+#   |   |
+#   e8  |
+#    \ /
+#     F
+
+
+on_committer_date "1971-08-16 00:00:00" hide_error save_tag F unique_commit F tree
+on_committer_date "1971-08-16 00:00:01" save_tag e8 unique_commit e8 tree -p F
+on_committer_date "1971-08-16 00:00:02" save_tag e7 unique_commit e7 tree -p e8
+on_committer_date "1971-08-16 00:00:03" save_tag e6 unique_commit e6 tree -p e7
+on_committer_date "1971-08-16 00:00:04" save_tag e5 unique_commit e5 tree -p e6
+on_committer_date "1971-08-16 00:00:05" save_tag f4 unique_commit f4 tree -p F
+on_committer_date "1971-08-16 00:00:06" save_tag f3 unique_commit f3 tree -p f4
+on_committer_date "1971-08-16 00:00:07" save_tag f2 unique_commit f2 tree -p f3
+on_committer_date "1971-08-16 00:00:08" save_tag f1 unique_commit f1 tree -p f2
+on_committer_date "1971-08-16 00:00:09" save_tag e4 unique_commit e4 tree -p e5
+on_committer_date "1971-08-16 00:00:10" save_tag e3 unique_commit e3 tree -p e4
+on_committer_date "1971-08-16 00:00:11" save_tag e2 unique_commit e2 tree -p e3
+on_committer_date "1971-08-16 00:00:12" save_tag e1 unique_commit e1 tree -p e2
+on_committer_date "1971-08-16 00:00:13" save_tag E unique_commit E tree -p e1 -p f1
+
+
+test_bug_blatt()
+{
+     _bug=$1
+     shift 1
+     git bug-blatt '' "../simulate-bug-at $_bug" "$@" 2>/dev/null
+}
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
+test_output_expect_success "--bisect l5 ^root" 'git-rev-list --bisect l5 ^root' <<EOF
+c3
+EOF
+
+test_output_expect_success "--bisect l5 ^root ^c3" 'git-rev-list --bisect l5 ^root ^c3' <<EOF
+b4
+EOF
+
+test_output_expect_success "--bisect l5 ^root ^c3 ^b4" 'git-rev-list --bisect l5 ^c3 ^b4' <<EOF
+l3
+EOF
+
+test_output_expect_success "--bisect l3 ^root ^c3 ^b4" 'git-rev-list --bisect l3 ^root ^c3 ^b4' <<EOF
+a4
+EOF
+
+test_output_expect_success "--bisect l5 ^b3 ^a3 ^b4 ^a4" 'git-rev-list --bisect l3 ^b3 ^a3 ^a4' <<EOF
+l3
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
+test_output_expect_success "bug-blatt l5 @ l3" "test_bug_blatt $(tag l3) $(tag l5) root" <<EOF
+l3
+EOF
+
+test_output_expect_success "bug-blatt l5 @ a4" "test_bug_blatt $(tag a4) $(tag l5) root" <<EOF
+a4
+EOF
+
+test_output_expect_success "bug-blatt l5 @ c3" "test_bug_blatt $(tag c3) $(tag l5) root" <<EOF
+c3
+EOF
+
+#
+#
+test_done
------------
