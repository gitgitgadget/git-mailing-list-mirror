From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Prevent t6000 series from dropping useless sed.script in t/
Date: Thu, 07 Jul 2005 11:39:10 -0700
Message-ID: <7vd5pusbox.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 20:40:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqbHs-0007U6-0V
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 20:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVGGSjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 14:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVGGSjk
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 14:39:40 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39809 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261542AbVGGSjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 14:39:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707183912.IZGS22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 14:39:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The Makefile in the test suite directory considers any file
matching t[0-9][0-9][0-9][0-9]-*.sh as the top-level test script
to be executed.  Unfortunately this was not documented, and the
common test library, t6000-lib.sh was named to match that
pattern.  This caused t6000-lib.sh to be called from Makefile as
the top-level program, causing it to leave t/sed.script file
behind.  Rename it to t6000lib.sh to prevent this, and document
the naming convention a bit more clearly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/README                        |    8 +++
 t/t6000-lib.sh                  |  109 ---------------------------------------
 t/t6000lib.sh                   |  109 +++++++++++++++++++++++++++++++++++++++
 t/t6001-rev-list-merge-order.sh |    2 -
 t/t6002-rev-list-bisect.sh      |    2 -
 t/t6003-rev-list-topo-order.sh  |    2 -
 6 files changed, 120 insertions(+), 112 deletions(-)
 delete mode 100644 t/t6000-lib.sh
 create mode 100644 t/t6000lib.sh

02e754c481bc5656ccb9b6159c78001d6cf5f552
diff --git a/t/README b/t/README
--- a/t/README
+++ b/t/README
@@ -79,6 +79,14 @@ Second digit tells the particular comman
 Third digit (optionally) tells the particular switch or group of switches
 we are testing.
 
+If you create files under t/ directory (i.e. here) that is not
+the top-level test script, never name the file to match the above
+pattern.  The Makefile here considers all such files as the
+top-level test script and tries to run all of them.  A care is
+especially needed if you are creating a common test library
+file, similar to test-lib.sh, because such a library file may
+not be suitable for standalone execution.
+
 
 Writing Tests
 -------------
diff --git a/t/t6000-lib.sh b/t/t6000-lib.sh
deleted file mode 100644
--- a/t/t6000-lib.sh
+++ /dev/null
@@ -1,109 +0,0 @@
-[ -d .git/refs/tags ] || mkdir -p .git/refs/tags
-
-:> sed.script
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
-# a substitution script for the tag onto the front of sed.script
-save_tag()
-{
-	_tag=$1	
-	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
-	shift 1
-    	"$@" >.git/refs/tags/$_tag
-
-        echo "s/$(tag $_tag)/$_tag/g" > sed.script.tmp
-	cat sed.script >> sed.script.tmp
-	rm sed.script
-	mv sed.script.tmp sed.script
-}
-
-# Replace unhelpful sha1 hashses with their symbolic equivalents 
-entag()
-{
-	sed -f sed.script
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
diff --git a/t/t6000lib.sh b/t/t6000lib.sh
new file mode 100644
--- /dev/null
+++ b/t/t6000lib.sh
@@ -0,0 +1,109 @@
+[ -d .git/refs/tags ] || mkdir -p .git/refs/tags
+
+:> sed.script
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
+# a substitution script for the tag onto the front of sed.script
+save_tag()
+{
+	_tag=$1	
+	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
+	shift 1
+    	"$@" >.git/refs/tags/$_tag
+
+        echo "s/$(tag $_tag)/$_tag/g" > sed.script.tmp
+	cat sed.script >> sed.script.tmp
+	rm sed.script
+	mv sed.script.tmp sed.script
+}
+
+# Replace unhelpful sha1 hashses with their symbolic equivalents 
+entag()
+{
+	sed -f sed.script
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
@@ -6,7 +6,7 @@
 test_description='Tests git-rev-list --merge-order functionality'
 
 . ./test-lib.sh
-. ../t6000-lib.sh # t6xxx specific functions
+. ../t6000lib.sh # t6xxx specific functions
 
 # test-case specific test function
 check_adjacency()
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -5,7 +5,7 @@
 test_description='Tests git-rev-list --bisect functionality'
 
 . ./test-lib.sh
-. ../t6000-lib.sh
+. ../t6000lib.sh # t6xxx specific functions
 
 bc_expr()
 {
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -6,7 +6,7 @@
 test_description='Tests git-rev-list --topo-order functionality'
 
 . ./test-lib.sh
-. ../t6000-lib.sh # t6xxx specific functions
+. ../t6000lib.sh # t6xxx specific functions
 
 list_duplicates()
 {
------------
