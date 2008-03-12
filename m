From: Jeff King <peff@peff.net>
Subject: [PATCH 04/16] grep portability fix: don't use "-e" or "-q"
Date: Wed, 12 Mar 2008 17:32:17 -0400
Message-ID: <20080312213217.GE26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:33:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYZK-0007FY-AN
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbYCLVcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbYCLVcW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:32:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4856 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbYCLVcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:32:20 -0400
Received: (qmail 2829 invoked by uid 111); 12 Mar 2008 21:32:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:32:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:32:17 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76994>

System V versions of grep (such as Solaris /usr/bin/grep)
don't understand either of these options. git's usage of
"grep -e pattern" fell into one of two categories:

 1. equivalent to "grep pattern". -e is only useful here if
    the pattern begins with a "-", but all of the patterns
    are hardcoded and do not begin with a dash.

 2. stripping comments and blank lines with

      grep -v -e "^$" -e "^#"

    We can fortunately do this in the affirmative as

      grep '^[^#]'

Uses of "-q" can be replaced with redirection to /dev/null.
In many tests, however, "grep -q" is used as "if this string
is in the expected output, we are OK". In this case, it is
fine to just remove the "-q" entirely; it simply makes the
"verbose" mode of the test slightly more verbose.

Signed-off-by: Jeff King <peff@peff.net>
---
One might disagree with my "grep without -q actually shows useful
verbose output in tests" statement. In that case, we can >/dev/null all
of those instances.

 git-rebase--interactive.sh      |    6 +++---
 git-submodule.sh                |    6 +++---
 t/t0030-stripspace.sh           |   34 +++++++++++++++++-----------------
 t/t3404-rebase-interactive.sh   |    3 +--
 t/t3800-mktag.sh                |    2 +-
 t/t5400-send-pack.sh            |    2 +-
 t/t7502-status.sh               |    2 +-
 t/t7600-merge.sh                |    4 ++--
 t/t9400-git-cvsserver-server.sh |   26 +++++++++++++-------------
 9 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c2bedd6..4c3280a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -78,8 +78,8 @@ mark_action_done () {
 	sed -e 1q < "$TODO" >> "$DONE"
 	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
-	count=$(($(grep -ve '^$' -e '^#' < "$DONE" | wc -l)))
-	total=$(($count+$(grep -ve '^$' -e '^#' < "$TODO" | wc -l)))
+	count=$(grep -c '^[^#]' < "$DONE")
+	total=$(($count+$(grep -c '^[^#]' < "$TODO")))
 	if test "$last_count" != "$count"
 	then
 		last_count=$count
@@ -110,7 +110,7 @@ die_abort () {
 }
 
 has_action () {
-	grep -vqe '^$' -e '^#' "$1"
+	grep '^[^#]' "$1" >/dev/null
 }
 
 pick_one () {
diff --git a/git-submodule.sh b/git-submodule.sh
index 7171cb6..ceb2295 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -230,7 +230,7 @@ cmd_init()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	git ls-files --stage -- "$@" | grep '^160000 ' |
 	while read mode sha1 stage path
 	do
 		# Skip already registered paths
@@ -284,7 +284,7 @@ cmd_update()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	git ls-files --stage -- "$@" | grep '^160000 ' |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit
@@ -367,7 +367,7 @@ cmd_status()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	git ls-files --stage -- "$@" | grep '^160000 ' |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 818c862..3ecdd66 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -245,12 +245,12 @@ test_expect_success \
 
 test_expect_success \
     'text plus spaces without newline at end should not show spaces' '
-    ! (printf "$ttt$sss" | git stripspace | grep -q "  ") &&
-    ! (printf "$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
-    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
-    ! (printf "$ttt$sss$sss" | git stripspace | grep -q "  ") &&
-    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep -q "  ") &&
-    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep -q "  ")
+    ! (printf "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (printf "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (printf "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
 '
 
 test_expect_success \
@@ -282,12 +282,12 @@ test_expect_success \
 
 test_expect_success \
     'text plus spaces at end should not show spaces' '
-    ! (echo "$ttt$sss" | git stripspace | grep -q "  ") &&
-    ! (echo "$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
-    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
-    ! (echo "$ttt$sss$sss" | git stripspace | grep -q "  ") &&
-    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep -q "  ") &&
-    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep -q "  ")
+    ! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
 '
 
 test_expect_success \
@@ -341,11 +341,11 @@ test_expect_success \
 
 test_expect_success \
     'spaces without newline at end should not show spaces' '
-    ! (printf "" | git stripspace | grep -q " ") &&
-    ! (printf "$sss" | git stripspace | grep -q " ") &&
-    ! (printf "$sss$sss" | git stripspace | grep -q " ") &&
-    ! (printf "$sss$sss$sss" | git stripspace | grep -q " ") &&
-    ! (printf "$sss$sss$sss$sss" | git stripspace | grep -q " ")
+    ! (printf "" | git stripspace | grep " " >/dev/null) &&
+    ! (printf "$sss" | git stripspace | grep " " >/dev/null) &&
+    ! (printf "$sss$sss" | git stripspace | grep " " >/dev/null) &&
+    ! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
+    ! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
 '
 
 test_expect_success \
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 049aa37..f098231 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -149,8 +149,7 @@ test_expect_success 'stop on conflicting pick' '
 	diff -u expect .git/.dotest-merge/patch &&
 	diff -u expect2 file1 &&
 	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
-	test 0 = $(grep -ve "^#" -e "^$" < .git/.dotest-merge/git-rebase-todo |
-		wc -l)
+	test 0 = $(grep -c "^[^#]" < .git/.dotest-merge/git-rebase-todo)
 '
 
 test_expect_success 'abort' '
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index f280320..2780758 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -15,7 +15,7 @@ check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
 		( ! git-mktag <tag.sig 2>message ) &&
-		grep -q "$expect" message
+		grep "$expect" message
 	'
 }
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 2d0c07f..2b6b6e3 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -120,7 +120,7 @@ test_expect_success \
 	cd .. &&
 	git-clone parent child && cd child && git-push --all &&
 	cd ../parent &&
-	git-branch -a >branches && ! grep -q origin/master branches
+	git-branch -a >branches && ! grep origin/master branches
 '
 
 rewound_push_setup() {
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index e006074..70b802b 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -33,7 +33,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'status (1)' '
 
-	grep -e "use \"git rm --cached <file>\.\.\.\" to unstage" output
+	grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
 
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5d16628..590505b 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -371,7 +371,7 @@ test_expect_success 'override config option -n' '
 	git merge --summary c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
-	if ! grep -e "^ file |  *2 +-$" diffstat.txt
+	if ! grep "^ file |  *2 +-$" diffstat.txt
 	then
 		echo "[OOPS] diffstat was not generated"
 	fi
@@ -386,7 +386,7 @@ test_expect_success 'override config option --summary' '
 	git merge -n c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
-	if grep -e "^ file |  *2 +-$" diffstat.txt
+	if grep "^ file |  *2 +-$" diffstat.txt
 	then
 		echo "[OOPS] diffstat was generated"
 		false
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 0a20971..e82b365 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -94,7 +94,7 @@ EOF
 
 test_expect_success 'pserver authentication' \
   'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
-   tail -n1 log | grep -q "^I LOVE YOU$"'
+   tail -n1 log | grep "^I LOVE YOU$"'
 
 test_expect_success 'pserver authentication failure (non-anonymous user)' \
   'if cat request-git | git-cvsserver pserver >log 2>&1
@@ -103,11 +103,11 @@ test_expect_success 'pserver authentication failure (non-anonymous user)' \
    else
        true
    fi &&
-   tail -n1 log | grep -q "^I HATE YOU$"'
+   tail -n1 log | grep "^I HATE YOU$"'
 
 test_expect_success 'pserver authentication (login)' \
   'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
-   tail -n1 log | grep -q "^I LOVE YOU$"'
+   tail -n1 log | grep "^I LOVE YOU$"'
 
 test_expect_success 'pserver authentication failure (login/non-anonymous user)' \
   'if cat login-git | git-cvsserver pserver >log 2>&1
@@ -116,7 +116,7 @@ test_expect_success 'pserver authentication failure (login/non-anonymous user)'
    else
        true
    fi &&
-   tail -n1 log | grep -q "^I HATE YOU$"'
+   tail -n1 log | grep "^I HATE YOU$"'
 
 
 # misuse pserver authentication for testing of req_Root
@@ -146,15 +146,15 @@ test_expect_success 'req_Root failure (relative pathname)' \
    else
        true
    fi &&
-   tail log | grep -q "^error 1 Root must be an absolute pathname$"'
+   tail log | grep "^error 1 Root must be an absolute pathname$"'
 
 test_expect_success 'req_Root failure (conflicting roots)' \
   'cat request-conflict | git-cvsserver pserver >log 2>&1 &&
-   tail log | grep -q "^error 1 Conflicting roots specified$"'
+   tail log | grep "^error 1 Conflicting roots specified$"'
 
 test_expect_success 'req_Root (strict paths)' \
   'cat request-anonymous | git-cvsserver --strict-paths pserver $SERVERDIR >log 2>&1 &&
-   tail -n1 log | grep -q "^I LOVE YOU$"'
+   tail -n1 log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (strict-paths)' '
     ! cat request-anonymous |
@@ -163,7 +163,7 @@ test_expect_success 'req_Root failure (strict-paths)' '
 
 test_expect_success 'req_Root (w/o strict-paths)' \
   'cat request-anonymous | git-cvsserver pserver $WORKDIR/ >log 2>&1 &&
-   tail -n1 log | grep -q "^I LOVE YOU$"'
+   tail -n1 log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (w/o strict-paths)' '
     ! cat request-anonymous |
@@ -181,7 +181,7 @@ EOF
 
 test_expect_success 'req_Root (base-path)' \
   'cat request-base | git-cvsserver --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
-   tail -n1 log | grep -q "^I LOVE YOU$"'
+   tail -n1 log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (base-path)' '
     ! cat request-anonymous |
@@ -192,14 +192,14 @@ GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
 test_expect_success 'req_Root (export-all)' \
   'cat request-anonymous | git-cvsserver --export-all pserver $WORKDIR >log 2>&1 &&
-   tail -n1 log | grep -q "^I LOVE YOU$"'
+   tail -n1 log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (export-all w/o whitelist)' \
   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
   'cat request-base | git-cvsserver --export-all --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
-   tail -n1 log | grep -q "^I LOVE YOU$"'
+   tail -n1 log | grep "^I LOVE YOU$"'
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
 
@@ -216,7 +216,7 @@ test_expect_success 'gitcvs.enabled = false' \
    else
      true
    fi &&
-   cat cvs.log | grep -q "GITCVS emulation disabled" &&
+   grep "GITCVS emulation disabled" cvs.log &&
    test ! -d cvswork2'
 
 rm -fr cvswork2
@@ -237,7 +237,7 @@ test_expect_success 'gitcvs.ext.enabled = false' \
    else
      true
    fi &&
-   cat cvs.log | grep -q "GITCVS emulation disabled" &&
+   grep "GITCVS emulation disabled" cvs.log &&
    test ! -d cvswork2'
 
 rm -fr cvswork2
-- 
1.5.4.4.543.g30fdd.dirty
