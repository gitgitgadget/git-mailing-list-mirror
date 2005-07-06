From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/3] Factor out useful test case infrastructure from t/t6001... into t/t6000-lib.sh
Date: Wed, 06 Jul 2005 20:11:24 +1000
Message-ID: <20050706101124.29944.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 12:38:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq7HP-000704-3i
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 12:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVGFKem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 06:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVGFKaJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 06:30:09 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:30081 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262277AbVGFKLf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 06:11:35 -0400
Received: (qmail 29954 invoked by uid 500); 6 Jul 2005 10:11:24 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Functions that are useful to other t6xxx testcases are moved into t6000-lib.sh

To use these functions in a test case, use a test-case pre-amble like:

. ./test-lib.sh
. ../t6000-lib.sh # t6xxx specific functions

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
This patch series introduces tests for the git-rev-list --bisect functionality 
and includes Mark Allen's sed separator patch.

The patches included are:

[PATCH 1/3] Factor out useful test case infrastructure from t/t6001... into t/t6000-lib.sh
[PATCH 2/3] Introduce unit tests for git-rev-list --bisect
[PATCH 3/3] Change the sed seperator in t/t6000-lib.sh.
---

 t/t6000-lib.sh                  |  105 +++++++++++++++++++++++++++++++++++++
 t/t6001-rev-list-merge-order.sh |  112 ---------------------------------------
 2 files changed, 106 insertions(+), 111 deletions(-)
 create mode 100644 t/t6000-lib.sh

a6686d8335905d55ef6cf996af1d3eb229ad955c
diff --git a/t/t6000-lib.sh b/t/t6000-lib.sh
new file mode 100644
--- /dev/null
+++ b/t/t6000-lib.sh
@@ -0,0 +1,105 @@
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
+{
+	"$@" 2>/dev/null
+}
+
+check_output()
+{
+	_name=$1
+	shift 1
+	if eval "$*" | entag > $_name.actual
+	then
+		diff $_name.expected $_name.actual
+	else
+		return 1;
+	fi
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
+	test_expect_success "$_description" "check_output $_name \"$_test\"" 
+}
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -6,117 +6,7 @@
 test_description='Tests git-rev-list --merge-order functionality'
 
 . ./test-lib.sh
-
-#
-# TODO: move the following block (upto --- end ...) into testlib.sh
-#
-[ -d .git/refs/tags ] || mkdir -p .git/refs/tags
-
-sed_script="";
-
-# Answer the sha1 has associated with the tag. The tag must exist in .git or .git/refs/tags
-tag()
-{
-	_tag=$1
-	[ -f .git/refs/tags/$_tag ] || error "tag: \"$_tag\" does not exist"
-	cat .git/refs/tags/$_tag
-}
-
-# Generate a commit using the text specified to make it unique and the tree
-# named by the tag specified.
-unique_commit()
-{
-	_text=$1
-        _tree=$2
-	shift 2
-    	echo $_text | git-commit-tree $(tag $_tree) "$@"
-}
-
-# Save the output of a command into the tag specified. Prepend
-# a substitution script for the tag onto the front of $sed_script
-save_tag()
-{
-	_tag=$1	
-	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
-	shift 1
-    	"$@" >.git/refs/tags/$_tag
-    	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
-}
-
-# Replace unhelpful sha1 hashses with their symbolic equivalents 
-entag()
-{
-	sed "$sed_script"
-}
-
-# Execute a command after first saving, then setting the GIT_AUTHOR_EMAIL
-# tag to a specified value. Restore the original value on return.
-as_author()
-{
-	_author=$1
-	shift 1
-        _save=$GIT_AUTHOR_EMAIL
-
-	export GIT_AUTHOR_EMAIL="$_author"
-	"$@"
-        export GIT_AUTHOR_EMAIL="$_save"
-}
-
-commit_date()
-{
-        _commit=$1
-	git-cat-file commit $_commit | sed -n "s/^committer .*> \([0-9]*\) .*/\1/p" 
-}
-
-on_committer_date()
-{
-    _date=$1
-    shift 1
-    GIT_COMMITTER_DATE=$_date "$@"
-}
-
-# Execute a command and suppress any error output.
-hide_error()
-{
-	"$@" 2>/dev/null
-}
-
-check_output()
-{
-	_name=$1
-	shift 1
-	if eval "$*" | entag > $_name.actual
-	then
-		diff $_name.expected $_name.actual
-	else
-		return 1;
-	fi
-}
-
-# Turn a reasonable test description into a reasonable test name.
-# All alphanums translated into -'s which are then compressed and stripped
-# from front and back.
-name_from_description()
-{
-        tr "'" '-' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' '-' | tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
-}
-
-
-# Execute the test described by the first argument, by eval'ing
-# command line specified in the 2nd argument. Check the status code
-# is zero and that the output matches the stream read from 
-# stdin.
-test_output_expect_success()
-{	
-	_description=$1
-        _test=$2
-        [ $# -eq 2 ] || error "usage: test_output_expect_success description test <<EOF ... EOF"
-        _name=$(echo $_description | name_from_description)
-	cat > $_name.expected
-	test_expect_success "$_description" "check_output $_name \"$_test\"" 
-}
-
-# --- end of stuff to move ---
+. ../t6000-lib.sh # t6xxx specific functions
 
 # test-case specific test function
 check_adjacency()
------------
