From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH for post 1.5.4] Sane use of test_expect_failure
Date: Fri, 01 Feb 2008 01:50:53 -0800
Message-ID: <7vwspp9f9e.fsf_-_@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<7v7ihtqfm8.fsf@gitster.siamese.dyndns.org>
	<7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
	<200802010534.55925.robin.rosenberg.lists@dewire.com>
	<7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 10:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKsZl-0004mN-HA
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 10:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbYBAJv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 04:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757359AbYBAJv0
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 04:51:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757470AbYBAJvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 04:51:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E819F38C6;
	Fri,  1 Feb 2008 04:51:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F48C38C3;
	Fri,  1 Feb 2008 04:50:56 -0500 (EST)
In-Reply-To: <7vabmlb0y0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 31 Jan 2008 23:17:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72161>

Originally, test_expect_failure was designed to be the opposite
of test_expect_success, but this was a bad decision.  Most tests
run a series of commands that leads to the single command that
needs to be tested, like this:

    test_expect_{success,failure} 'test title' '
	setup1 &&
        setup2 &&
        setup3 &&
        what is to be tested
    '

And expecting a failure exit from the whole sequence misses the
point of writing tests.  Your setup$N that are supposed to
succeed may have failed without even reaching what you are
trying to test.  The only valid use of test_expect_failure is to
check a trivial single command that is expected to fail, which
is a minority in tests of Porcelain-ish commands.

This large-ish patch rewrites all uses of test_expect_failure to
use test_expect_success and rewrites the condition of what is
tested, like this:

    test_expect_success 'test title' '
	setup1 &&
        setup2 &&
        setup3 &&
        ! this command should fail
    '

test_expect_failure is redefined to serve as a reminder that
that test *should* succeed but due to a known breakage in git it
currently does not pass.  So if git-foo command should create a
file 'bar' but you discovered a bug that it doesn't, you can
write a test like this:

    test_expect_failure 'git-foo should create bar' '
        rm -f bar &&
        git foo &&
        test -f bar
    '

This construct acts similar to test_expect_success, but instead
of reporting "ok/FAIL" like test_expect_success does, the
outcome is reported as "FIXED/still broken".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Junio C Hamano <gitster@pobox.com> writes:

 > I'd like to make the _first_ patch after 1.5.4 to be a fix-up
 > for tests that misuse test_expect_failure.  After that, we can
 > use test_expect_failure to mark tests that ought to pass but
 > don't because of bugs in the commands.  That way, people who are
 > absolutely bored can grep for test_expect_failure to see what
 > existing issues to tackle ;-).

 This turned out to be a huge patch.  I tried to be careful by
 keeping the conversion mostly mechanical, but I am not sure
 about some of the git-svn and git-cvsserver tests, some of which
 may already have been using test_expect_failure to mark a known
 breakage.

 Eyeballing by area experts are very much appreciated.

 t/README                                  |   14 +--
 t/t0000-basic.sh                          |   30 ++++--
 t/t0030-stripspace.sh                     |   40 ++++----
 t/t0040-parse-options.sh                  |    4 +-
 t/t1000-read-tree-m-3way.sh               |  161 ++++++++++++++++-------------
 t/t1200-tutorial.sh                       |    8 +-
 t/t1300-repo-config.sh                    |   39 ++++---
 t/t1302-repo-version.sh                   |    5 +-
 t/t1400-update-ref.sh                     |   24 ++--
 t/t2000-checkout-cache-clash.sh           |    4 +-
 t/t2002-checkout-cache-u.sh               |    4 +-
 t/t2008-checkout-subdir.sh                |   16 ++--
 t/t2100-update-cache-badpath.sh           |    4 +-
 t/t3020-ls-files-error-unmatch.sh         |    4 +-
 t/t3200-branch.sh                         |   36 ++++---
 t/t3210-pack-refs.sh                      |   26 +++---
 t/t3400-rebase.sh                         |    4 +-
 t/t3403-rebase-skip.sh                    |    6 +-
 t/t3600-rm.sh                             |   17 ++--
 t/t4103-apply-binary.sh                   |   68 +++++++------
 t/t4113-apply-ending.sh                   |    8 +-
 t/t5300-pack-object.sh                    |    4 +-
 t/t5302-pack-index.sh                     |   32 +++---
 t/t5401-update-hooks.sh                   |    8 +-
 t/t5402-post-merge-hook.sh                |    4 +-
 t/t5500-fetch-pack.sh                     |    4 +-
 t/t5510-fetch.sh                          |   12 +-
 t/t5530-upload-pack-error.sh              |   14 +--
 t/t5600-clone-fail-cleanup.sh             |   12 +-
 t/t5710-info-alternate.sh                 |   14 ++-
 t/t6023-merge-file.sh                     |   12 +-
 t/t6024-recursive-merge.sh                |    2 +-
 t/t6025-merge-symlinks.sh                 |   21 ++--
 t/t6101-rev-parse-parents.sh              |    2 +-
 t/t6300-for-each-ref.sh                   |    8 +-
 t/t7001-mv.sh                             |    4 +-
 t/t7002-grep.sh                           |    4 +-
 t/t7004-tag.sh                            |   36 +++---
 t/t7101-reset.sh                          |   24 ++--
 t/t7501-commit.sh                         |   40 ++++----
 t/t7503-pre-commit-hook.sh                |    4 +-
 t/t7504-commit-msg-hook.sh                |    8 +-
 t/t9100-git-svn-basic.sh                  |   28 +++---
 t/t9106-git-svn-commit-diff-clobber.sh    |   18 ++--
 t/t9106-git-svn-dcommit-clobber-series.sh |    4 +-
 t/t9300-fast-import.sh                    |   24 ++--
 t/t9400-git-cvsserver-server.sh           |   30 +++--
 t/test-lib.sh                             |   30 +++++-
 48 files changed, 498 insertions(+), 427 deletions(-)

diff --git a/t/README b/t/README
index 36f2517..73ed11b 100644
--- a/t/README
+++ b/t/README
@@ -160,14 +160,12 @@ library for your script to use.
 
  - test_expect_failure <message> <script>
 
-   This is the opposite of test_expect_success.  If <script>
-   yields success, test is considered a failure.
-
-   Example:
-
-	test_expect_failure \
-	    'git-update-index without --add should fail adding.' \
-	    'git-update-index should-be-empty'
+   This is NOT the opposite of test_expect_success, but is used
+   to mark a test that demonstrates a known breakage.  Unlike
+   the usual test_expect_success tests, which say "ok" on
+   success and "FAIL" on failure, this will say "FIXED" on
+   success and "still broken" on failure.  Failures from these
+   tests won't cause -i (immediate) to stop.
 
  - test_debug <script>
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4e49d59..cd0de50 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -47,12 +47,24 @@ test_expect_success \
     'test $(wc -l < full-of-directories) = 3'
 
 ################################################################
+# Test harness
+test_expect_success 'success is reported like this' '
+    :
+'
+test_expect_failure 'pretend we have a known breakage' '
+    false
+'
+test_expect_failure 'pretend we have fixed a known breakage' '
+    :
+'
+
+################################################################
 # Basics of the basics
 
 # updating a new file without --add should fail.
-test_expect_failure \
-    'git update-index without --add should fail adding.' \
-    'git update-index should-be-empty'
+test_expect_success 'git update-index without --add should fail adding.' '
+    ! git update-index should-be-empty
+'
 
 # and with --add it should succeed, even if it is empty (it used to fail).
 test_expect_success \
@@ -70,9 +82,9 @@ test_expect_success \
 
 # Removing paths.
 rm -f should-be-empty full-of-directories
-test_expect_failure \
-    'git update-index without --remove should fail removing.' \
-    'git update-index should-be-empty'
+test_expect_success 'git update-index without --remove should fail removing.' '
+    ! git update-index should-be-empty
+'
 
 test_expect_success \
     'git update-index with --remove should be able to remove.' \
@@ -204,9 +216,9 @@ test_expect_success \
     'put invalid objects into the index.' \
     'git update-index --index-info < badobjects'
 
-test_expect_failure \
-    'writing this tree without --missing-ok.' \
-    'git write-tree'
+test_expect_success 'writing this tree without --missing-ok.' '
+    ! git write-tree
+'
 
 test_expect_success \
     'writing this tree with --missing-ok.' \
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index cad95f3..818c862 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -243,14 +243,14 @@ test_expect_success \
     test `printf "$ttt$sss$sss$sss" | git stripspace | wc -l` -gt 0
 '
 
-test_expect_failure \
+test_expect_success \
     'text plus spaces without newline at end should not show spaces' '
-    printf "$ttt$sss" | git stripspace | grep -q "  " ||
-    printf "$ttt$ttt$sss" | git stripspace | grep -q "  " ||
-    printf "$ttt$ttt$ttt$sss" | git stripspace | grep -q "  " ||
-    printf "$ttt$sss$sss" | git stripspace | grep -q "  " ||
-    printf "$ttt$ttt$sss$sss" | git stripspace | grep -q "  " ||
-    printf "$ttt$sss$sss$sss" | git stripspace | grep -q "  "
+    ! (printf "$ttt$sss" | git stripspace | grep -q "  ") &&
+    ! (printf "$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
+    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
+    ! (printf "$ttt$sss$sss" | git stripspace | grep -q "  ") &&
+    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep -q "  ") &&
+    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep -q "  ")
 '
 
 test_expect_success \
@@ -280,14 +280,14 @@ test_expect_success \
     git diff expect actual
 '
 
-test_expect_failure \
+test_expect_success \
     'text plus spaces at end should not show spaces' '
-    echo "$ttt$sss" | git stripspace | grep -q "  " ||
-    echo "$ttt$ttt$sss" | git stripspace | grep -q "  " ||
-    echo "$ttt$ttt$ttt$sss" | git stripspace | grep -q "  " ||
-    echo "$ttt$sss$sss" | git stripspace | grep -q "  " ||
-    echo "$ttt$ttt$sss$sss" | git stripspace | grep -q "  " ||
-    echo "$ttt$sss$sss$sss" | git stripspace | grep -q "  "
+    ! (echo "$ttt$sss" | git stripspace | grep -q "  ") &&
+    ! (echo "$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
+    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep -q "  ") &&
+    ! (echo "$ttt$sss$sss" | git stripspace | grep -q "  ") &&
+    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep -q "  ") &&
+    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep -q "  ")
 '
 
 test_expect_success \
@@ -339,13 +339,13 @@ test_expect_success \
     git diff expect actual
 '
 
-test_expect_failure \
+test_expect_success \
     'spaces without newline at end should not show spaces' '
-    printf "" | git stripspace | grep -q " " ||
-    printf "$sss" | git stripspace | grep -q " " ||
-    printf "$sss$sss" | git stripspace | grep -q " " ||
-    printf "$sss$sss$sss" | git stripspace | grep -q " " ||
-    printf "$sss$sss$sss$sss" | git stripspace | grep -q " "
+    ! (printf "" | git stripspace | grep -q " ") &&
+    ! (printf "$sss" | git stripspace | grep -q " ") &&
+    ! (printf "$sss$sss" | git stripspace | grep -q " ") &&
+    ! (printf "$sss$sss$sss" | git stripspace | grep -q " ") &&
+    ! (printf "$sss$sss$sss$sss" | git stripspace | grep -q " ")
 '
 
 test_expect_success \
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 0a3b55d..2ecc283 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -87,9 +87,9 @@ test_expect_success 'unambiguously abbreviated option with "="' '
 	git diff expect output
 '
 
-test_expect_failure 'ambiguously abbreviated option' '
+test_expect_success 'ambiguously abbreviated option' '
 	test-parse-options --strin 123;
-        test $? != 129
+        test $? = 129
 '
 
 cat > expect << EOF
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 37add1b..6c065bf 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -210,12 +210,12 @@ DF (file) when tree B require DF to be a directory by having DF/DF
 
 END_OF_CASE_TABLE
 
-test_expect_failure \
-    '1 - must not have an entry not in A.' \
-    "rm -f .git/index XX &&
+test_expect_success '1 - must not have an entry not in A.' "
+     rm -f .git/index XX &&
      echo XX >XX &&
      git update-index --add XX &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '2 - must match B in !O && !A && B case.' \
@@ -248,13 +248,14 @@ test_expect_success \
      echo extra >>AN &&
      git read-tree -m $tree_O $tree_A $tree_B"
 
-test_expect_failure \
-    '3 (fail) - must match A in !O && A && !B case.' \
-    "rm -f .git/index AN &&
+test_expect_success \
+    '3 (fail) - must match A in !O && A && !B case.' "
+     rm -f .git/index AN &&
      cp .orig-A/AN AN &&
      echo extra >>AN &&
      git update-index --add AN &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '4 - must match and be up-to-date in !O && A && B && A!=B case.' \
@@ -264,21 +265,23 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' \
-    "rm -f .git/index AA &&
+test_expect_success \
+    '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' "
+     rm -f .git/index AA &&
      cp .orig-A/AA AA &&
      git update-index --add AA &&
      echo extra >>AA &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' \
-    "rm -f .git/index AA &&
+test_expect_success \
+    '4 (fail) - must match and be up-to-date in !O && A && B && A!=B case.' "
+     rm -f .git/index AA &&
      cp .orig-A/AA AA &&
      echo extra >>AA &&
      git update-index --add AA &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '5 - must match in !O && A && B && A==B case.' \
@@ -297,34 +300,38 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '5 (fail) - must match A in !O && A && B && A==B case.' \
-    "rm -f .git/index LL &&
+test_expect_success \
+    '5 (fail) - must match A in !O && A && B && A==B case.' "
+     rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      echo extra >>LL &&
      git update-index --add LL &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '6 - must not exist in O && !A && !B case' \
-    "rm -f .git/index DD &&
+test_expect_success \
+    '6 - must not exist in O && !A && !B case' "
+     rm -f .git/index DD &&
      echo DD >DD
      git update-index --add DD &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '7 - must not exist in O && !A && B && O!=B case' \
-    "rm -f .git/index DM &&
+test_expect_success \
+    '7 - must not exist in O && !A && B && O!=B case' "
+     rm -f .git/index DM &&
      cp .orig-B/DM DM &&
      git update-index --add DM &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '8 - must not exist in O && !A && B && O==B case' \
-    "rm -f .git/index DN &&
+test_expect_success \
+    '8 - must not exist in O && !A && B && O==B case' "
+     rm -f .git/index DN &&
      cp .orig-B/DN DN &&
      git update-index --add DN &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '9 - must match and be up-to-date in O && A && !B && O!=A case' \
@@ -334,21 +341,23 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' \
-    "rm -f .git/index MD &&
+test_expect_success \
+    '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' "
+     rm -f .git/index MD &&
      cp .orig-A/MD MD &&
      git update-index --add MD &&
      echo extra >>MD &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' \
-    "rm -f .git/index MD &&
+test_expect_success \
+    '9 (fail) - must match and be up-to-date in O && A && !B && O!=A case' "
+     rm -f .git/index MD &&
      cp .orig-A/MD MD &&
      echo extra >>MD &&
      git update-index --add MD &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '10 - must match and be up-to-date in O && A && !B && O==A case' \
@@ -358,21 +367,23 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' \
-    "rm -f .git/index ND &&
+test_expect_success \
+    '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' "
+     rm -f .git/index ND &&
      cp .orig-A/ND ND &&
      git update-index --add ND &&
      echo extra >>ND &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' \
-    "rm -f .git/index ND &&
+test_expect_success \
+    '10 (fail) - must match and be up-to-date in O && A && !B && O==A case' "
+     rm -f .git/index ND &&
      cp .orig-A/ND ND &&
      echo extra >>ND &&
      git update-index --add ND &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '11 - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' \
@@ -382,21 +393,23 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' \
-    "rm -f .git/index MM &&
+test_expect_success \
+    '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' "
+     rm -f .git/index MM &&
      cp .orig-A/MM MM &&
      git update-index --add MM &&
      echo extra >>MM &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' \
-    "rm -f .git/index MM &&
+test_expect_success \
+    '11 (fail) - must match and be up-to-date in O && A && B && O!=A && O!=B && A!=B case' "
+     rm -f .git/index MM &&
      cp .orig-A/MM MM &&
      echo extra >>MM &&
      git update-index --add MM &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '12 - must match A in O && A && B && O!=A && A==B case' \
@@ -415,13 +428,14 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '12 (fail) - must match A in O && A && B && O!=A && A==B case' \
-    "rm -f .git/index SS &&
+test_expect_success \
+    '12 (fail) - must match A in O && A && B && O!=A && A==B case' "
+     rm -f .git/index SS &&
      cp .orig-A/SS SS &&
      echo extra >>SS &&
      git update-index --add SS &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '13 - must match A in O && A && B && O!=A && O==B case' \
@@ -457,21 +471,23 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' \
-    "rm -f .git/index NM &&
+test_expect_success \
+    '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' "
+     rm -f .git/index NM &&
      cp .orig-A/NM NM &&
      git update-index --add NM &&
      echo extra >>NM &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
-test_expect_failure \
-    '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' \
-    "rm -f .git/index NM &&
+test_expect_success \
+    '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' "
+     rm -f .git/index NM &&
      cp .orig-A/NM NM &&
      echo extra >>NM &&
      git update-index --add NM &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 test_expect_success \
     '15 - must match A in O && A && B && O==A && O==B case' \
@@ -490,13 +506,14 @@ test_expect_success \
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '15 (fail) - must match A in O && A && B && O==A && O==B case' \
-    "rm -f .git/index NN &&
+test_expect_success \
+    '15 (fail) - must match A in O && A && B && O==A && O==B case' "
+     rm -f .git/index NN &&
      cp .orig-A/NN NN &&
      echo extra >>NN &&
      git update-index --add NN &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     ! git read-tree -m $tree_O $tree_A $tree_B
+"
 
 # #16
 test_expect_success \
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 991d3c5..dcb3108 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -101,8 +101,8 @@ echo "Play, play, play" >>hello
 echo "Lots of fun" >>example
 git commit -m 'Some fun.' -i hello example
 
-test_expect_failure 'git resolve now fails' '
-	git merge -m "Merge work in mybranch" mybranch
+test_expect_success 'git resolve now fails' '
+	! git merge -m "Merge work in mybranch" mybranch
 '
 
 cat > hello << EOF
@@ -156,6 +156,8 @@ test_expect_success 'git show-branch' 'cmp show-branch2.expect show-branch2.outp
 
 test_expect_success 'git repack' 'git repack'
 test_expect_success 'git prune-packed' 'git prune-packed'
-test_expect_failure '-> only packed objects' 'find -type f .git/objects/[0-9a-f][0-9a-f]'
+test_expect_success '-> only packed objects' '
+	! find -type f .git/objects/[0-9a-f][0-9a-f]
+'
 
 test_done
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 42eac2a..a786c5c 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -181,8 +181,9 @@ test_expect_success 'non-match' \
 test_expect_success 'non-match value' \
 	'test wow = $(git config --get nextsection.nonewline !for)'
 
-test_expect_failure 'ambiguous get' \
-	'git config --get nextsection.nonewline'
+test_expect_success 'ambiguous get' '
+	! git config --get nextsection.nonewline
+'
 
 test_expect_success 'get multivar' \
 	'git config --get-all nextsection.nonewline'
@@ -202,13 +203,17 @@ EOF
 
 test_expect_success 'multivar replace' 'cmp .git/config expect'
 
-test_expect_failure 'ambiguous value' 'git config nextsection.nonewline'
+test_expect_success 'ambiguous value' '
+	! git config nextsection.nonewline
+'
 
-test_expect_failure 'ambiguous unset' \
-	'git config --unset nextsection.nonewline'
+test_expect_success 'ambiguous unset' '
+	! git config --unset nextsection.nonewline
+'
 
-test_expect_failure 'invalid unset' \
-	'git config --unset somesection.nonewline'
+test_expect_success 'invalid unset' '
+	! git config --unset somesection.nonewline
+'
 
 git config --unset nextsection.nonewline "wow3$"
 
@@ -224,7 +229,7 @@ EOF
 
 test_expect_success 'multivar unset' 'cmp .git/config expect'
 
-test_expect_failure 'invalid key' 'git config inval.2key blabla'
+test_expect_success 'invalid key' '! git config inval.2key blabla'
 
 test_expect_success 'correct key' 'git config 123456.a123 987'
 
@@ -382,8 +387,9 @@ EOF
 
 test_expect_success "rename succeeded" "git diff expect .git/config"
 
-test_expect_failure "rename non-existing section" \
-	'git config --rename-section branch."world domination" branch.drei'
+test_expect_success "rename non-existing section" '
+	! git config --rename-section branch."world domination" branch.drei
+'
 
 test_expect_success "rename succeeded" "git diff expect .git/config"
 
@@ -494,14 +500,14 @@ test_expect_success bool '
         done &&
 	cmp expect result'
 
-test_expect_failure 'invalid bool (--get)' '
+test_expect_success 'invalid bool (--get)' '
 
 	git config bool.nobool foobar &&
-	git config --bool --get bool.nobool'
+	! git config --bool --get bool.nobool'
 
-test_expect_failure 'invalid bool (set)' '
+test_expect_success 'invalid bool (set)' '
 
-	git config --bool bool.nobool foobar'
+	! git config --bool bool.nobool foobar'
 
 rm .git/config
 
@@ -562,8 +568,9 @@ EOF
 
 test_expect_success 'quoting' 'cmp .git/config expect'
 
-test_expect_failure 'key with newline' 'git config key.with\\\
-newline 123'
+test_expect_success 'key with newline' '
+	! git config "key.with
+newline" 123'
 
 test_expect_success 'value with newline' 'git config key.sub value.with\\\
 newline'
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 37fc1c8..9be0770 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -40,7 +40,8 @@ test_expect_success 'gitdir required mode on normal repos' '
 	(git apply --check --index test.patch &&
 	cd test && git apply --check --index ../test.patch)'
 
-test_expect_failure 'gitdir required mode on unsupported repo' '
-	(cd test2 && git apply --check --index ../test.patch)'
+test_expect_success 'gitdir required mode on unsupported repo' '
+	(cd test2 && ! git apply --check --index ../test.patch)
+'
 
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 71ab2dd..78cd412 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -51,23 +51,23 @@ test_expect_success \
 	 test $B"' = $(cat .git/'"$m"')'
 rm -f .git/$m
 
-test_expect_failure \
-	'(not) create HEAD with old sha1' \
-	"git update-ref HEAD $A $B"
-test_expect_failure \
-	"(not) prior created .git/$m" \
-	"test -f .git/$m"
+test_expect_success '(not) create HEAD with old sha1' "
+	! git update-ref HEAD $A $B
+"
+test_expect_success "(not) prior created .git/$m" "
+	! test -f .git/$m
+"
 rm -f .git/$m
 
 test_expect_success \
 	"create HEAD" \
 	"git update-ref HEAD $A"
-test_expect_failure \
-	'(not) change HEAD with wrong SHA1' \
-	"git update-ref HEAD $B $Z"
-test_expect_failure \
-	"(not) changed .git/$m" \
-	"test $B"' = $(cat .git/'"$m"')'
+test_expect_success '(not) change HEAD with wrong SHA1' "
+	! git update-ref HEAD $B $Z
+"
+test_expect_success "(not) changed .git/$m" "
+	! test $B"' = $(cat .git/'"$m"')
+'
 rm -f .git/$m
 
 : a repository with working tree always has reflog these days...
diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
index ac84335..5141fab 100755
--- a/t/t2000-checkout-cache-clash.sh
+++ b/t/t2000-checkout-cache-clash.sh
@@ -36,9 +36,9 @@ mkdir path0
 date >path0/file0
 date >path1
 
-test_expect_failure \
+test_expect_success \
     'git checkout-index without -f should fail on conflicting work tree.' \
-    'git checkout-index -a'
+    '! git checkout-index -a'
 
 test_expect_success \
     'git checkout-index with -f should succeed.' \
diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
index f7a0055..0f441bc 100755
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -16,12 +16,12 @@ echo frotz >path0 &&
 git update-index --add path0 &&
 t=$(git write-tree)'
 
-test_expect_failure \
+test_expect_success \
 'without -u, git checkout-index smudges stat information.' '
 rm -f path0 &&
 git read-tree $t &&
 git checkout-index -f -a &&
-git diff-files | diff - /dev/null'
+! git diff-files | diff - /dev/null'
 
 test_expect_success \
 'with -u, git checkout-index picks up stat information from new files.' '
diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index f78945e..4a723dc 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -67,16 +67,16 @@ test_expect_success 'checkout with simple prefix' '
 
 '
 
-test_expect_failure 'relative path outside tree should fail' \
-	'git checkout HEAD -- ../../Makefile'
+test_expect_success 'relative path outside tree should fail' \
+	'! git checkout HEAD -- ../../Makefile'
 
-test_expect_failure 'incorrect relative path to file should fail (1)' \
-	'git checkout HEAD -- ../file0'
+test_expect_success 'incorrect relative path to file should fail (1)' \
+	'! git checkout HEAD -- ../file0'
 
-test_expect_failure 'incorrect relative path should fail (2)' \
-	'( cd dir1 && git checkout HEAD -- ./file0 )'
+test_expect_success 'incorrect relative path should fail (2)' \
+	'( cd dir1 && ! git checkout HEAD -- ./file0 )'
 
-test_expect_failure 'incorrect relative path should fail (3)' \
-	'( cd dir1 && git checkout HEAD -- ../../file0 )'
+test_expect_success 'incorrect relative path should fail (3)' \
+	'( cd dir1 && ! git checkout HEAD -- ../../file0 )'
 
 test_done
diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index 04a1ed1..9beaecd 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -44,8 +44,8 @@ date >path1/file1
 
 for p in path0/file0 path1/file1 path2 path3
 do
-	test_expect_failure \
+	test_expect_success \
 	    "git update-index to add conflicting path $p should fail." \
-	    "git update-index --add -- $p"
+	    "! git update-index --add -- $p"
 done
 test_done
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index c83f820..f4da869 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -15,9 +15,9 @@ touch foo bar
 git update-index --add foo bar
 git-commit -m "add foo bar"
 
-test_expect_failure \
+test_expect_success \
     'git ls-files --error-unmatch should fail with unmatched path.' \
-    'git ls-files --error-unmatch foo bar-does-not-match'
+    '! git ls-files --error-unmatch foo bar-does-not-match'
 
 test_expect_success \
     'git ls-files --error-unmatch should succeed eith matched paths.' \
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ef1eeb7..fe353ff 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -17,10 +17,11 @@ test_expect_success \
      git-commit -m "Initial commit." &&
      HEAD=$(git rev-parse --verify HEAD)'
 
-test_expect_failure \
-    'git branch --help should not have created a bogus branch' \
-    'git branch --help </dev/null >/dev/null 2>/dev/null || :
-     test -f .git/refs/heads/--help'
+test_expect_success \
+    'git branch --help should not have created a bogus branch' '
+     git branch --help </dev/null >/dev/null 2>/dev/null;
+     ! test -f .git/refs/heads/--help
+'
 
 test_expect_success \
     'git branch abc should create a branch' \
@@ -71,17 +72,17 @@ test_expect_success \
         git branch -m n/n n
         test -f .git/logs/refs/heads/n'
 
-test_expect_failure \
-    'git branch -m o/o o should fail when o/p exists' \
-       'git branch o/o &&
+test_expect_success 'git branch -m o/o o should fail when o/p exists' '
+        git branch o/o &&
         git branch o/p &&
-        git branch -m o/o o'
+        ! git branch -m o/o o
+'
 
-test_expect_failure \
-    'git branch -m q r/q should fail when r exists' \
-       'git branch q &&
-         git branch r &&
-         git branch -m q r/q'
+test_expect_success 'git branch -m q r/q should fail when r exists' '
+        git branch q &&
+        git branch r &&
+        ! git branch -m q r/q
+'
 
 mv .git/config .git/config-saved
 
@@ -108,12 +109,13 @@ test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
 	 ! git config branch.s/s/dummy"
 
-test_expect_failure \
-    'git branch -m u v should fail when the reflog for u is a symlink' \
-    'git branch -l u &&
+test_expect_success \
+    'git branch -m u v should fail when the reflog for u is a symlink' '
+     git branch -l u &&
      mv .git/logs/refs/heads/u real-u &&
      ln -s real-u .git/logs/refs/heads/u &&
-     git branch -m u v'
+     ! git branch -m u v
+'
 
 test_expect_success 'test tracking setup via --track' \
     'git config remote.local.url . &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 4ddc634..b64ccfb 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -39,12 +39,12 @@ test_expect_success \
      git show-ref b >result &&
      diff expect result'
 
-test_expect_failure \
-    'git branch c/d should barf if branch c exists' \
-    'git branch c &&
+test_expect_success 'git branch c/d should barf if branch c exists' '
+     git branch c &&
      git pack-refs --all &&
-     rm .git/refs/heads/c &&
-     git branch c/d'
+     rm -f .git/refs/heads/c &&
+     ! git branch c/d
+'
 
 test_expect_success \
     'see if a branch still exists after git pack-refs --prune' \
@@ -54,11 +54,11 @@ test_expect_success \
      git show-ref e >result &&
      diff expect result'
 
-test_expect_failure \
-    'see if git pack-refs --prune remove ref files' \
-    'git branch f &&
+test_expect_success 'see if git pack-refs --prune remove ref files' '
+     git branch f &&
      git pack-refs --all --prune &&
-     ls .git/refs/heads/f'
+     ! test -f .git/refs/heads/f
+'
 
 test_expect_success \
     'git branch g should work when git branch g/h has been deleted' \
@@ -69,11 +69,11 @@ test_expect_success \
      git pack-refs --all &&
      git branch -d g'
 
-test_expect_failure \
-    'git branch i/j/k should barf if branch i exists' \
-    'git branch i &&
+test_expect_success 'git branch i/j/k should barf if branch i exists' '
+     git branch i &&
      git pack-refs --all --prune &&
-     git branch i/j/k'
+     ! git branch i/j/k
+'
 
 test_expect_success \
     'test git branch k after branch k/l/m and k/lm have been deleted' \
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 95e33b5..496f4ec 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -42,9 +42,9 @@ test_expect_success \
 test_expect_success 'rebase against master' '
      git rebase master'
 
-test_expect_failure \
+test_expect_success \
     'the rebase operation should not have destroyed author information' \
-    'git log | grep "Author:" | grep "<>"'
+    '! git log | grep "Author:" | grep "<>"'
 
 test_expect_success 'rebase after merge master' '
      git reset --hard topic &&
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 657f681..0a26099 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -31,8 +31,8 @@ test_expect_success setup '
 	git branch skip-merge skip-reference
 	'
 
-test_expect_failure 'rebase with git am -3 (default)' '
-	git rebase master
+test_expect_success 'rebase with git am -3 (default)' '
+	! git rebase master
 '
 
 test_expect_success 'rebase --skip with am -3' '
@@ -53,7 +53,7 @@ test_expect_success 'rebase moves back to skip-reference' '
 
 test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
 
-test_expect_failure 'rebase with --merge' 'git rebase --merge master'
+test_expect_success 'rebase with --merge' '! git rebase --merge master'
 
 test_expect_success 'rebase --skip with --merge' '
 	git rebase --skip
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b1ee622..f542f0a 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -59,15 +59,16 @@ test_expect_success \
      echo "other content" > foo
      git rm --cached foo'
 
-test_expect_failure \
-    'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' \
-    'echo content > foo
+test_expect_success \
+    'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
+     echo content > foo
      git add foo
      git commit -m foo
      echo "other content" > foo
      git add foo
      echo "yet another content" > foo
-     git rm --cached foo'
+     ! git rm --cached foo
+'
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
@@ -106,9 +107,9 @@ embedded'"
 
 if test "$test_failed_remove" = y; then
 chmod a-w .
-test_expect_failure \
+test_expect_success \
     'Test that "git rm -f" fails if its rm fails' \
-    'git rm -f baz'
+    '! git rm -f baz'
 chmod 775 .
 else
     test_expect_success 'skipping removal failure (perhaps running as root?)' :
@@ -212,8 +213,8 @@ test_expect_success 'Recursive with -r -f' '
 	! test -d frotz
 '
 
-test_expect_failure 'Remove nonexistent file returns nonzero exit status' '
-	git rm nonexistent
+test_expect_success 'Remove nonexistent file returns nonzero exit status' '
+	! git rm nonexistent
 '
 
 test_done
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 74f06ec..7c25634 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -46,21 +46,25 @@ test_expect_success 'stat binary diff (copy) -- should not fail.' \
 	'git-checkout master
 	 git apply --stat --summary C.diff'
 
-test_expect_failure 'check binary diff -- should fail.' \
-	'git-checkout master
-	 git apply --check B.diff'
-
-test_expect_failure 'check binary diff (copy) -- should fail.' \
-	'git-checkout master
-	 git apply --check C.diff'
-
-test_expect_failure 'check incomplete binary diff with replacement -- should fail.' \
-	'git-checkout master
-	 git apply --check --allow-binary-replacement B.diff'
+test_expect_success 'check binary diff -- should fail.' \
+	'git-checkout master &&
+	 ! git apply --check B.diff'
+
+test_expect_success 'check binary diff (copy) -- should fail.' \
+	'git-checkout master &&
+	 ! git apply --check C.diff'
+
+test_expect_success \
+	'check incomplete binary diff with replacement -- should fail.' '
+	git-checkout master &&
+	! git apply --check --allow-binary-replacement B.diff
+'
 
-test_expect_failure 'check incomplete binary diff with replacement (copy) -- should fail.' \
-	'git-checkout master
-	 git apply --check --allow-binary-replacement C.diff'
+test_expect_success \
+    'check incomplete binary diff with replacement (copy) -- should fail.' '
+	 git-checkout master &&
+	 ! git apply --check --allow-binary-replacement C.diff
+'
 
 test_expect_success 'check binary diff with replacement.' \
 	'git-checkout master
@@ -73,42 +77,42 @@ test_expect_success 'check binary diff with replacement (copy).' \
 # Now we start applying them.
 
 do_reset () {
-	rm -f file?
-	git-reset --hard
+	rm -f file? &&
+	git-reset --hard &&
 	git-checkout -f master
 }
 
-test_expect_failure 'apply binary diff -- should fail.' \
-	'do_reset
-	 git apply B.diff'
+test_expect_success 'apply binary diff -- should fail.' \
+	'do_reset &&
+	 ! git apply B.diff'
 
-test_expect_failure 'apply binary diff -- should fail.' \
-	'do_reset
-	 git apply --index B.diff'
+test_expect_success 'apply binary diff -- should fail.' \
+	'do_reset &&
+	 ! git apply --index B.diff'
 
-test_expect_failure 'apply binary diff (copy) -- should fail.' \
-	'do_reset
-	 git apply C.diff'
+test_expect_success 'apply binary diff (copy) -- should fail.' \
+	'do_reset &&
+	 ! git apply C.diff'
 
-test_expect_failure 'apply binary diff (copy) -- should fail.' \
-	'do_reset
-	 git apply --index C.diff'
+test_expect_success 'apply binary diff (copy) -- should fail.' \
+	'do_reset &&
+	 ! git apply --index C.diff'
 
 test_expect_success 'apply binary diff without replacement.' \
-	'do_reset
+	'do_reset &&
 	 git apply BF.diff'
 
 test_expect_success 'apply binary diff without replacement (copy).' \
-	'do_reset
+	'do_reset &&
 	 git apply CF.diff'
 
 test_expect_success 'apply binary diff.' \
-	'do_reset
+	'do_reset &&
 	 git apply --allow-binary-replacement --index BF.diff &&
 	 test -z "$(git diff --name-status binary)"'
 
 test_expect_success 'apply binary diff (copy).' \
-	'do_reset
+	'do_reset &&
 	 git apply --allow-binary-replacement --index CF.diff &&
 	 test -z "$(git diff --name-status binary)"'
 
diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 1c6bec0..d741039 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -29,8 +29,8 @@ test_expect_success setup \
 
 # test
 
-test_expect_failure 'apply at the end' \
-    'git apply --index test-patch'
+test_expect_success 'apply at the end' \
+    '! git apply --index test-patch'
 
 cat >test-patch <<\EOF
 diff a/file b/file
@@ -47,7 +47,7 @@ b
 c'
 git update-index file
 
-test_expect_failure 'apply at the beginning' \
-	'git apply --index test-patch'
+test_expect_success 'apply at the beginning' \
+	'! git apply --index test-patch'
 
 test_done
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 6e594bf..4f350dd 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -264,8 +264,8 @@ test_expect_success \
      cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
 		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
 
-test_expect_failure \
+test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
-    'git-index-pack -o bad.idx test-3.pack'
+    '! git-index-pack -o bad.idx test-3.pack'
 
 test_done
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 2a2878b..67b9a7b 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -42,9 +42,9 @@ test_expect_success \
     'both packs should be identical' \
     'cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"'
 
-test_expect_failure \
+test_expect_success \
     'index v1 and index v2 should be different' \
-    'cmp "test-1-${pack1}.idx" "test-2-${pack2}.idx"'
+    '! cmp "test-1-${pack1}.idx" "test-2-${pack2}.idx"'
 
 test_expect_success \
     'index-pack with index version 1' \
@@ -78,9 +78,9 @@ test_expect_success \
     'git verify-pack -v "test-3-${pack3}.pack"'
 
 test "$have_64bits" &&
-test_expect_failure \
+test_expect_success \
     '64-bit offsets: should be different from previous index v2 results' \
-    'cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"'
+    '! cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"'
 
 test "$have_64bits" &&
 test_expect_success \
@@ -112,22 +112,22 @@ test_expect_success \
 	  bs=1 count=20 conv=notrunc &&
        git cat-file blob "$delta_sha1" > blob_2 )'
 
-test_expect_failure \
+test_expect_success \
     '[index v1] 3) corrupted delta happily returned wrong data' \
-    'cmp blob_1 blob_2'
+    '! cmp blob_1 blob_2'
 
-test_expect_failure \
+test_expect_success \
     '[index v1] 4) confirm that the pack is actually corrupted' \
-    'git fsck --full $commit'
+    '! git fsck --full $commit'
 
 test_expect_success \
     '[index v1] 5) pack-objects happily reuses corrupted data' \
     'pack4=$(git pack-objects test-4 <obj-list) &&
      test -f "test-4-${pack1}.pack"'
 
-test_expect_failure \
+test_expect_success \
     '[index v1] 6) newly created pack is BAD !' \
-    'git verify-pack -v "test-4-${pack1}.pack"'
+    '! git verify-pack -v "test-4-${pack1}.pack"'
 
 test_expect_success \
     '[index v2] 1) stream pack to repository' \
@@ -150,16 +150,16 @@ test_expect_success \
 	  bs=1 count=20 conv=notrunc &&
        git cat-file blob "$delta_sha1" > blob_4 )'
 
-test_expect_failure \
+test_expect_success \
     '[index v2] 3) corrupted delta happily returned wrong data' \
-    'cmp blob_3 blob_4'
+    '! cmp blob_3 blob_4'
 
-test_expect_failure \
+test_expect_success \
     '[index v2] 4) confirm that the pack is actually corrupted' \
-    'git fsck --full $commit'
+    '! git fsck --full $commit'
 
-test_expect_failure \
+test_expect_success \
     '[index v2] 5) pack-objects refuses to reuse corrupted data' \
-    'git pack-objects test-5 <obj-list'
+    '! git pack-objects test-5 <obj-list'
 
 test_done
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 9734fc5..9a12024 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -60,8 +60,8 @@ echo STDERR post-update >&2
 EOF
 chmod u+x victim/.git/hooks/post-update
 
-test_expect_failure push '
-	git-send-pack --force ./victim/.git master tofail >send.out 2>send.err
+test_expect_success push '
+    ! git-send-pack --force ./victim/.git master tofail >send.out 2>send.err
 '
 
 test_expect_success 'updated as expected' '
@@ -112,8 +112,8 @@ test_expect_success 'all *-receive hook args are empty' '
 	! test -s victim/.git/post-receive.args
 '
 
-test_expect_failure 'send-pack produced no output' '
-	test -s send.out
+test_expect_success 'send-pack produced no output' '
+	! test -s send.out
 '
 
 cat <<EOF >expect
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 1c4b0b3..1394047 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -30,9 +30,9 @@ EOF
     chmod u+x clone${clone}/.git/hooks/post-merge
 done
 
-test_expect_failure 'post-merge does not run for up-to-date ' '
+test_expect_success 'post-merge does not run for up-to-date ' '
         GIT_DIR=clone1/.git git merge $commit0 &&
-	test -e clone1/.git/post-merge.args
+	! test -f clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge runs as expected ' '
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7b6798d..788b4a5 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -176,7 +176,7 @@ test_expect_success "deepening fetch in shallow repo" \
 test_expect_success "clone shallow object count" \
 	"test \"count: 18\" = \"$(grep count count.shallow)\""
 
-test_expect_failure "pull in shallow repo with missing merge base" \
-	"(cd shallow; git pull --depth 4 .. A)"
+test_expect_success "pull in shallow repo with missing merge base" \
+	"(cd shallow && ! git pull --depth 4 .. A)"
 
 test_done
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 02882c1..9b948c1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -95,7 +95,7 @@ test_expect_success 'fetch following tags' '
 
 '
 
-test_expect_failure 'fetch must not resolve short tag name' '
+test_expect_success 'fetch must not resolve short tag name' '
 
 	cd "$D" &&
 
@@ -103,11 +103,11 @@ test_expect_failure 'fetch must not resolve short tag name' '
 	cd five &&
 	git init &&
 
-	git fetch .. anno:five
+	! git fetch .. anno:five
 
 '
 
-test_expect_failure 'fetch must not resolve short remote name' '
+test_expect_success 'fetch must not resolve short remote name' '
 
 	cd "$D" &&
 	git-update-ref refs/remotes/six/HEAD HEAD
@@ -116,7 +116,7 @@ test_expect_failure 'fetch must not resolve short remote name' '
 	cd six &&
 	git init &&
 
-	git fetch .. six:six
+	! git fetch .. six:six
 
 '
 
@@ -139,10 +139,10 @@ test_expect_success 'create bundle 2' '
 	git bundle create bundle2 master~2..master
 '
 
-test_expect_failure 'unbundle 1' '
+test_expect_success 'unbundle 1' '
 	cd "$D/bundle" &&
 	git checkout -b some-branch &&
-	git fetch "$D/bundle1" master:master
+	! git fetch "$D/bundle1" master:master
 '
 
 test_expect_success 'bundle 1 has only 3 files ' '
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index cc8949e..8b05091 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -26,9 +26,8 @@ test_expect_success 'setup and corrupt repository' '
 
 '
 
-test_expect_failure 'fsck fails' '
-
-	git fsck
+test_expect_success 'fsck fails' '
+	! git fsck
 '
 
 test_expect_success 'upload-pack fails due to error in pack-objects' '
@@ -46,9 +45,8 @@ test_expect_success 'corrupt repo differently' '
 
 '
 
-test_expect_failure 'fsck fails' '
-
-	git fsck
+test_expect_success 'fsck fails' '
+	! git fsck
 '
 test_expect_success 'upload-pack fails due to error in rev-list' '
 
@@ -66,9 +64,9 @@ test_expect_success 'create empty repository' '
 
 '
 
-test_expect_failure 'fetch fails' '
+test_expect_success 'fetch fails' '
 
-	git fetch .. master
+	! git fetch .. master
 
 '
 
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 1776b37..acf34ce 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -11,13 +11,13 @@ remove the directory before attempting a clone again.'
 
 . ./test-lib.sh
 
-test_expect_failure \
+test_expect_success \
     'clone of non-existent source should fail' \
-    'git-clone foo bar'
+    '! git-clone foo bar'
 
-test_expect_failure \
+test_expect_success \
     'failed clone should not leave a directory' \
-    'cd bar'
+    '! test -d bar'
 
 # Need a repo to clone
 test_create_repo foo
@@ -27,9 +27,9 @@ test_create_repo foo
 
 # source repository given to git-clone should be relative to the
 # current path not to the target dir
-test_expect_failure \
+test_expect_success \
     'clone of non-existent (relative to $PWD) source should fail' \
-    'git-clone ../foo baz'
+    '! git-clone ../foo baz'
 
 test_expect_success \
     'clone should work now that source exists' \
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 1908dc8..910ccb4 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -87,10 +87,10 @@ test_valid_repo"
 
 cd "$base_dir"
 
-test_expect_failure 'that info/alternates is necessary' \
+test_expect_success 'that info/alternates is necessary' \
 'cd C &&
-rm .git/objects/info/alternates &&
-test_valid_repo'
+rm -f .git/objects/info/alternates &&
+! (test_valid_repo)'
 
 cd "$base_dir"
 
@@ -101,9 +101,11 @@ test_valid_repo'
 
 cd "$base_dir"
 
-test_expect_failure 'that relative alternate is only possible for current dir' \
-'cd D &&
-test_valid_repo'
+test_expect_success \
+    'that relative alternate is only possible for current dir' '
+    cd D &&
+    ! (test_valid_repo)
+'
 
 cd "$base_dir"
 
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index ae3b6f2..8641996 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -66,8 +66,8 @@ test_expect_success "merge result added missing LF" \
 	"git diff test.txt test2.txt"
 
 cp test.txt backup.txt
-test_expect_failure "merge with conflicts" \
-	"git merge-file test.txt orig.txt new3.txt"
+test_expect_success "merge with conflicts" \
+	"! git merge-file test.txt orig.txt new3.txt"
 
 cat > expect.txt << EOF
 <<<<<<< test.txt
@@ -89,8 +89,8 @@ EOF
 test_expect_success "expected conflict markers" "git diff test.txt expect.txt"
 
 cp backup.txt test.txt
-test_expect_failure "merge with conflicts, using -L" \
-	"git merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
+test_expect_success "merge with conflicts, using -L" \
+	"! git merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
 
 cat > expect.txt << EOF
 <<<<<<< 1
@@ -113,8 +113,8 @@ test_expect_success "expected conflict markers, with -L" \
 	"git diff test.txt expect.txt"
 
 sed "s/ tu / TU /" < new1.txt > new5.txt
-test_expect_failure "conflict in removed tail" \
-	"git merge-file -p orig.txt new1.txt new5.txt > out"
+test_expect_success "conflict in removed tail" \
+	"! git merge-file -p orig.txt new1.txt new5.txt > out"
 
 cat > expect << EOF
 Dominus regit me,
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index c154f03..149ea85 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -60,7 +60,7 @@ git update-index a1 &&
 GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
 '
 
-test_expect_failure "combined merge conflicts" "git merge -m final G"
+test_expect_success "combined merge conflicts" "! git merge -m final G"
 
 cat > expect << EOF
 <<<<<<< HEAD:a1
diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 950c2e9..6004deb 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -30,30 +30,29 @@ echo plain-file > symlink &&
 git add symlink &&
 git-commit -m b-file'
 
-test_expect_failure \
+test_expect_success \
 'merge master into b-symlink, which has a different symbolic link' '
-! git-checkout b-symlink ||
-git-merge master'
+git-checkout b-symlink &&
+! git-merge master'
 
 test_expect_success \
 'the merge result must be a file' '
 test -f symlink'
 
-test_expect_failure \
+test_expect_success \
 'merge master into b-file, which has a file instead of a symbolic link' '
-! (git-reset --hard &&
-git-checkout b-file) ||
-git-merge master'
+git-reset --hard && git-checkout b-file &&
+! git-merge master'
 
 test_expect_success \
 'the merge result must be a file' '
 test -f symlink'
 
-test_expect_failure \
+test_expect_success \
 'merge b-file, which has a file instead of a symbolic link, into master' '
-! (git-reset --hard &&
-git-checkout master) ||
-git-merge b-file'
+git-reset --hard &&
+git-checkout master &&
+! git-merge b-file'
 
 test_expect_success \
 'the merge result must be a file' '
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 0724864..2328b69 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -26,7 +26,7 @@ test_expect_success 'final^1^1^1 = final^^^' "test $(git rev-parse final^1^1^1)
 test_expect_success 'final^1^2' "test $(git rev-parse start2) = $(git rev-parse final^1^2)"
 test_expect_success 'final^1^2 != final^1^1' "test $(git rev-parse final^1^2) != $(git rev-parse final^1^1)"
 test_expect_success 'final^1^3 not valid' "if git rev-parse --verify final^1^3; then false; else :; fi"
-test_expect_failure '--verify start2^1' 'git rev-parse --verify start2^1'
+test_expect_success '--verify start2^1' '! git rev-parse --verify start2^1'
 test_expect_success '--verify start2^0' 'git rev-parse --verify start2^0'
 
 test_expect_success 'repack for next test' 'git repack -a -d'
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8a23aaf..f46ec93 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -43,8 +43,8 @@ test_expect_success 'Check atom names are valid' '
 	test -z "$bad"
 '
 
-test_expect_failure 'Check invalid atoms names are errors' '
-	git-for-each-ref --format="%(INVALID)" refs/heads
+test_expect_success 'Check invalid atoms names are errors' '
+	! git-for-each-ref --format="%(INVALID)" refs/heads
 '
 
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
@@ -63,8 +63,8 @@ test_expect_success 'Check valid format specifiers for date fields' '
 	git-for-each-ref --format="%(authordate:rfc2822)" refs/heads
 '
 
-test_expect_failure 'Check invalid format specifiers are errors' '
-	git-for-each-ref --format="%(authordate:INVALID)" refs/heads
+test_expect_success 'Check invalid format specifiers are errors' '
+	! git-for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
 
 cat >expected <<\EOF
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b730c90..b1243b4 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -78,9 +78,9 @@ test_expect_success \
      git diff-tree -r -M --name-status  HEAD^ HEAD | \
      grep "^R100..*path2/README..*path1/path2/README"'
 
-test_expect_failure \
+test_expect_success \
     'do not move directory over existing directory' \
-    'mkdir path0 && mkdir path0/path2 && git mv path2 path0'
+    'mkdir path0 && mkdir path0/path2 && ! git mv path2 path0'
 
 test_expect_success \
     'move into "."' \
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 68b2b92..8d3a8eb 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -107,8 +107,8 @@ do
 		diff expected actual
 	'
 
-        test_expect_failure "grep -c $L (no /dev/null)" '
-		git grep -c test $H | grep -q "/dev/null"
+        test_expect_success "grep -c $L (no /dev/null)" '
+		! git grep -c test $H | grep -q /dev/null
         '
 
 done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index df496a9..75cd33b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -26,8 +26,8 @@ test_expect_success 'listing all tags in an empty tree should output nothing' '
 	test `git-tag | wc -l` -eq 0
 '
 
-test_expect_failure 'looking for a tag in an empty tree should fail' \
-	'tag_exists mytag'
+test_expect_success 'looking for a tag in an empty tree should fail' \
+	'! (tag_exists mytag)'
 
 test_expect_success 'creating a tag in an empty tree should fail' '
 	! git-tag mynotag &&
@@ -83,9 +83,9 @@ test_expect_success \
 
 # special cases for creating tags:
 
-test_expect_failure \
+test_expect_success \
 	'trying to create a tag with the name of one existing should fail' \
-	'git tag mytag'
+	'! git tag mytag'
 
 test_expect_success \
 	'trying to create a tag with a non-valid name should fail' '
@@ -146,8 +146,8 @@ test_expect_success \
 	! tag_exists myhead
 '
 
-test_expect_failure 'trying to delete an already deleted tag should fail' \
-	'git-tag -d mytag'
+test_expect_success 'trying to delete an already deleted tag should fail' \
+	'! git-tag -d mytag'
 
 # listing various tags with pattern matching:
 
@@ -265,16 +265,16 @@ test_expect_success \
 	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
 '
 
-test_expect_failure 'trying to verify an unknown tag should fail' \
-	'git-tag -v unknown-tag'
+test_expect_success 'trying to verify an unknown tag should fail' \
+	'! git-tag -v unknown-tag'
 
-test_expect_failure \
+test_expect_success \
 	'trying to verify a non-annotated and non-signed tag should fail' \
-	'git-tag -v non-annotated-tag'
+	'! git-tag -v non-annotated-tag'
 
-test_expect_failure \
+test_expect_success \
 	'trying to verify many non-annotated or unknown tags, should fail' \
-	'git-tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+	'! git-tag -v unknown-tag1 non-annotated-tag unknown-tag2'
 
 # creating annotated tags:
 
@@ -1027,21 +1027,21 @@ test_expect_success \
 
 # try to sign with bad user.signingkey
 git config user.signingkey BobTheMouse
-test_expect_failure \
+test_expect_success \
 	'git-tag -s fails if gpg is misconfigured' \
-	'git tag -s -m tail tag-gpg-failure'
+	'! git tag -s -m tail tag-gpg-failure'
 git config --unset user.signingkey
 
 # try to verify without gpg:
 
 rm -rf gpghome
-test_expect_failure \
+test_expect_success \
 	'verify signed tag fails when public key is not present' \
-	'git-tag -v signed-tag'
+	'! git-tag -v signed-tag'
 
-test_expect_failure \
+test_expect_success \
 	'git-tag -a fails if tag annotation is empty' '
-	GIT_EDITOR=cat git tag -a initial-comment
+	! (GIT_EDITOR=cat git tag -a initial-comment)
 '
 
 test_expect_success \
diff --git a/t/t7101-reset.sh b/t/t7101-reset.sh
index 66d4043..0d9874b 100755
--- a/t/t7101-reset.sh
+++ b/t/t7101-reset.sh
@@ -36,28 +36,28 @@ test_expect_success \
     'test -d path0 &&
      test -f path0/COPYING'
 
-test_expect_failure \
+test_expect_success \
     'checking lack of path1/path2/COPYING' \
-    'test -f path1/path2/COPYING'
+    '! test -f path1/path2/COPYING'
 
-test_expect_failure \
+test_expect_success \
     'checking lack of path1/COPYING' \
-    'test -f path1/COPYING'
+    '! test -f path1/COPYING'
 
-test_expect_failure \
+test_expect_success \
     'checking lack of COPYING' \
-    'test -f COPYING'
+    '! test -f COPYING'
 
-test_expect_failure \
+test_expect_success \
     'checking checking lack of path1/COPYING-TOO' \
-    'test -f path0/COPYING-TOO'
+    '! test -f path0/COPYING-TOO'
 
-test_expect_failure \
+test_expect_success \
     'checking lack of path1/path2' \
-    'test -d path1/path2'
+    '! test -d path1/path2'
 
-test_expect_failure \
+test_expect_success \
     'checking lack of path1' \
-    'test -d path1'
+    '! test -d path1'
 
 test_done
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d1a415a..21dcf55 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -17,49 +17,49 @@ test_expect_success \
 	 git-add file && \
 	 git-status | grep 'Initial commit'"
 
-test_expect_failure \
+test_expect_success \
 	"fail initial amend" \
-	"git-commit --amend"
+	"! git-commit --amend"
 
 test_expect_success \
 	"initial commit" \
 	"git-commit -m initial"
 
-test_expect_failure \
+test_expect_success \
 	"invalid options 1" \
-	"git-commit -m foo -m bar -F file"
+	"! git-commit -m foo -m bar -F file"
 
-test_expect_failure \
+test_expect_success \
 	"invalid options 2" \
-	"git-commit -C HEAD -m illegal"
+	"! git-commit -C HEAD -m illegal"
 
-test_expect_failure \
+test_expect_success \
 	"using paths with -a" \
 	"echo King of the bongo >file &&
-	git-commit -m foo -a file"
+	! git-commit -m foo -a file"
 
-test_expect_failure \
+test_expect_success \
 	"using paths with --interactive" \
 	"echo bong-o-bong >file &&
-	echo 7 | git-commit -m foo --interactive file"
+	! echo 7 | git-commit -m foo --interactive file"
 
-test_expect_failure \
+test_expect_success \
 	"using invalid commit with -C" \
-	"git-commit -C bogus"
+	"! git-commit -C bogus"
 
-test_expect_failure \
+test_expect_success \
 	"testing nothing to commit" \
-	"git-commit -m initial"
+	"! git-commit -m initial"
 
 test_expect_success \
 	"next commit" \
 	"echo 'bongo bongo bongo' >file \
 	 git-commit -m next -a"
 
-test_expect_failure \
+test_expect_success \
 	"commit message from non-existing file" \
 	"echo 'more bongo: bongo bongo bongo bongo' >file && \
-	 git-commit -F gah -a"
+	 ! git-commit -F gah -a"
 
 # Empty except stray tabs and spaces on a few lines.
 sed -e 's/@$//' >msg <<EOF
@@ -68,9 +68,9 @@ sed -e 's/@$//' >msg <<EOF
   @
 Signed-off-by: hula
 EOF
-test_expect_failure \
+test_expect_success \
 	"empty commit message" \
-	"git-commit -F msg -a"
+	"! git-commit -F msg -a"
 
 test_expect_success \
 	"commit message from file" \
@@ -88,10 +88,10 @@ test_expect_success \
 	"amend commit" \
 	"VISUAL=./editor git-commit --amend"
 
-test_expect_failure \
+test_expect_success \
 	"passing -m and -F" \
 	"echo 'enough with the bongos' >file && \
-	 git-commit -F msg -m amending ."
+	 ! git-commit -F msg -m amending ."
 
 test_expect_success \
 	"using message from other commit" \
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index d787cac..2dd5a5e 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -52,11 +52,11 @@ cat > "$HOOK" <<EOF
 exit 1
 EOF
 
-test_expect_failure 'with failing hook' '
+test_expect_success 'with failing hook' '
 
 	echo "another" >> file &&
 	git add file &&
-	git commit -m "another"
+	! git commit -m "another"
 
 '
 
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 751b113..eff36aa 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -98,20 +98,20 @@ cat > "$HOOK" <<EOF
 exit 1
 EOF
 
-test_expect_failure 'with failing hook' '
+test_expect_success 'with failing hook' '
 
 	echo "another" >> file &&
 	git add file &&
-	git commit -m "another"
+	! git commit -m "another"
 
 '
 
-test_expect_failure 'with failing hook (editor)' '
+test_expect_success 'with failing hook (editor)' '
 
 	echo "more another" >> file &&
 	git add file &&
 	echo "more another" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit
+	! (GIT_EDITOR="$FAKE_EDITOR" git commit)
 
 '
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 614cf50..1078f87 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -56,19 +56,19 @@ test_expect_success "$name" "
 
 
 name='detect node change from file to directory #1'
-test_expect_failure "$name" "
+test_expect_success "$name" "
 	mkdir dir/new_file &&
 	mv dir/file dir/new_file/file &&
 	mv dir/new_file dir/file &&
 	git update-index --remove dir/file &&
 	git update-index --add dir/file/file &&
-	git commit -m '$name'  &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	git commit -m '$name' &&
+	! git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch" || true
 
 
 name='detect node change from directory to file #1'
-test_expect_failure "$name" "
+test_expect_success "$name" "
 	rm -rf dir '$GIT_DIR'/index &&
 	git checkout -f -b mybranch2 remotes/git-svn &&
 	mv bar/zzz zzz &&
@@ -77,12 +77,12 @@ test_expect_failure "$name" "
 	git update-index --remove -- bar/zzz &&
 	git update-index --add -- bar &&
 	git commit -m '$name' &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	! git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch2" || true
 
 
 name='detect node change from file to directory #2'
-test_expect_failure "$name" "
+test_expect_success "$name" "
 	rm -f '$GIT_DIR'/index &&
 	git checkout -f -b mybranch3 remotes/git-svn &&
 	rm bar/zzz &&
@@ -91,12 +91,12 @@ test_expect_failure "$name" "
 	echo yyy > bar/zzz/yyy &&
 	git update-index --add bar/zzz/yyy &&
 	git commit -m '$name' &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	! git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch3" || true
 
 
 name='detect node change from directory to file #2'
-test_expect_failure "$name" "
+test_expect_success "$name" "
 	rm -f '$GIT_DIR'/index &&
 	git checkout -f -b mybranch4 remotes/git-svn &&
 	rm -rf dir &&
@@ -105,7 +105,7 @@ test_expect_failure "$name" "
 	echo asdf > dir &&
 	git update-index --add -- dir &&
 	git commit -m '$name' &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	! git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch4" || true
 
 
@@ -213,18 +213,18 @@ EOF
 
 test_expect_success "$name" "git diff a expected"
 
-test_expect_failure 'exit if remote refs are ambigious' "
+test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
                               bar:refs/remotes/git-svn &&
-        git-svn migrate
-        "
+        ! git-svn migrate
+"
 
-test_expect_failure 'exit if init-ing a would clobber a URL' "
+test_expect_success 'exit if init-ing a would clobber a URL' "
         svnadmin create ${PWD}/svnrepo2 &&
         svn mkdir -m 'mkdir bar' ${svnrepo}2/bar &&
         git config --unset svn-remote.svn.fetch \
                                 '^bar:refs/remotes/git-svn$' &&
-        git-svn init ${svnrepo}2/bar
+        ! git-svn init ${svnrepo}2/bar
         "
 
 test_expect_success \
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 79b7968..f74ab12 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -24,11 +24,11 @@ test_expect_success 'commit change from svn side' "
 	rm -rf t.svn
 	"
 
-test_expect_failure 'commit conflicting change from git' "
+test_expect_success 'commit conflicting change from git' "
 	echo second line from git >> file &&
 	git commit -a -m 'second line from git' &&
-	git-svn commit-diff -r1 HEAD~1 HEAD $svnrepo
-	" || true
+	! git-svn commit-diff -r1 HEAD~1 HEAD $svnrepo
+"
 
 test_expect_success 'commit complementing change from git' "
 	git reset --hard HEAD~1 &&
@@ -39,7 +39,7 @@ test_expect_success 'commit complementing change from git' "
 	git-svn commit-diff -r2 HEAD~1 HEAD $svnrepo
 	"
 
-test_expect_failure 'dcommit fails to commit because of conflict' "
+test_expect_success 'dcommit fails to commit because of conflict' "
 	git-svn init $svnrepo &&
 	git-svn fetch &&
 	git reset --hard refs/remotes/git-svn &&
@@ -52,8 +52,8 @@ test_expect_failure 'dcommit fails to commit because of conflict' "
 	rm -rf t.svn &&
 	echo 'fourth line from git' >> file &&
 	git commit -a -m 'fourth line from git' &&
-	git-svn dcommit
-	" || true
+	! git-svn dcommit
+	"
 
 test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	git reset --hard refs/remotes/git-svn &&
@@ -76,15 +76,15 @@ test_expect_success 'commit another change from svn side' "
 	rm -rf t.svn
 	"
 
-test_expect_failure 'multiple dcommit from git-svn will not clobber svn' "
+test_expect_success 'multiple dcommit from git-svn will not clobber svn' "
 	git reset --hard refs/remotes/git-svn &&
 	echo new file >> new-file &&
 	git update-index --add new-file &&
 	git commit -a -m 'new file' &&
 	echo clobber > file &&
 	git commit -a -m 'clobber' &&
-	git svn dcommit
-	" || true
+	! git svn dcommit
+	"
 
 
 test_expect_success 'check that rebase really failed' 'test -d .dotest'
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index 7452546..ca8a00e 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -54,10 +54,10 @@ test_expect_success 'change file but in unrelated area' "
 		test x\"\`sed -n -e 61p < file\`\" = x6611
 	"
 
-test_expect_failure 'attempt to dcommit with a dirty index' '
+test_expect_success 'attempt to dcommit with a dirty index' '
 	echo foo >>file &&
 	git add file &&
-	git svn dcommit
+	! git svn dcommit
 '
 
 test_done
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0595041..cceedbb 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -165,9 +165,9 @@ from refs/heads/master
 M 755 0000000000000000000000000000000000000001 zero1
 
 INPUT_END
-test_expect_failure \
-    'B: fail on invalid blob sha1' \
-    'git-fast-import <input'
+test_expect_success 'B: fail on invalid blob sha1' '
+    ! git-fast-import <input
+'
 rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
@@ -180,9 +180,9 @@ COMMIT
 from refs/heads/master
 
 INPUT_END
-test_expect_failure \
-    'B: fail on invalid branch name ".badbranchname"' \
-    'git-fast-import <input'
+test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
+    ! git-fast-import <input
+'
 rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
@@ -195,9 +195,9 @@ COMMIT
 from refs/heads/master
 
 INPUT_END
-test_expect_failure \
-    'B: fail on invalid branch name "bad[branch]name"' \
-    'git-fast-import <input'
+test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
+    ! git-fast-import <input
+'
 rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
@@ -339,9 +339,9 @@ COMMIT
 from refs/heads/branch^0
 
 INPUT_END
-test_expect_failure \
-    'E: rfc2822 date, --date-format=raw' \
-    'git-fast-import --date-format=raw <input'
+test_expect_success 'E: rfc2822 date, --date-format=raw' '
+    ! git-fast-import --date-format=raw <input
+'
 test_expect_success \
     'E: rfc2822 date, --date-format=rfc2822' \
     'git-fast-import --date-format=rfc2822 <input'
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 75d1ce4..0a20971 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -156,15 +156,19 @@ test_expect_success 'req_Root (strict paths)' \
   'cat request-anonymous | git-cvsserver --strict-paths pserver $SERVERDIR >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"'
 
-test_expect_failure 'req_Root failure (strict-paths)' \
-  'cat request-anonymous | git-cvsserver --strict-paths pserver $WORKDIR >log 2>&1'
+test_expect_success 'req_Root failure (strict-paths)' '
+    ! cat request-anonymous |
+    git-cvsserver --strict-paths pserver $WORKDIR >log 2>&1
+'
 
 test_expect_success 'req_Root (w/o strict-paths)' \
   'cat request-anonymous | git-cvsserver pserver $WORKDIR/ >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"'
 
-test_expect_failure 'req_Root failure (w/o strict-paths)' \
-  'cat request-anonymous | git-cvsserver pserver $WORKDIR/gitcvs >log 2>&1'
+test_expect_success 'req_Root failure (w/o strict-paths)' '
+    ! cat request-anonymous |
+    git-cvsserver pserver $WORKDIR/gitcvs >log 2>&1
+'
 
 cat >request-base  <<EOF
 BEGIN AUTH REQUEST
@@ -179,8 +183,10 @@ test_expect_success 'req_Root (base-path)' \
   'cat request-base | git-cvsserver --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"'
 
-test_expect_failure 'req_Root failure (base-path)' \
-  'cat request-anonymous | git-cvsserver --strict-paths --base-path $WORKDIR pserver $SERVERDIR >log 2>&1'
+test_expect_success 'req_Root failure (base-path)' '
+    ! cat request-anonymous |
+    git-cvsserver --strict-paths --base-path $WORKDIR pserver $SERVERDIR >log 2>&1
+'
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
@@ -188,9 +194,8 @@ test_expect_success 'req_Root (export-all)' \
   'cat request-anonymous | git-cvsserver --export-all pserver $WORKDIR >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"'
 
-test_expect_failure 'req_Root failure (export-all w/o whitelist)' \
-  'cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 ||
-   false'
+test_expect_success 'req_Root failure (export-all w/o whitelist)' \
+  '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
   'cat request-base | git-cvsserver --export-all --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
@@ -290,15 +295,16 @@ test_expect_success 'cvs update (update existing file)' \
 
 cd "$WORKDIR"
 #TODO: cvsserver doesn't support update w/o -d
-test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" \
-  'mkdir test &&
+test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" '
+   mkdir test &&
    echo >test/empty &&
    git add test &&
    git commit -q -m "Single Subdirectory" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
-   test ! -d test'
+   test ! -d test
+'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (subdirectories)' \
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 142540e..9a3c0b4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -139,6 +139,8 @@ fi
 
 test_failure=0
 test_count=0
+test_fixed=0
+test_broken=0
 
 trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
 
@@ -171,6 +173,17 @@ test_failure_ () {
 	test "$immediate" = "" || { trap - exit; exit 1; }
 }
 
+test_known_broken_ok_ () {
+	test_count=$(expr "$test_count" + 1)
+	test_fixed=$(($test_fixed+1))
+	say_color "" "  FIXED $test_count: $@"
+}
+
+test_known_broken_failure_ () {
+	test_count=$(expr "$test_count" + 1)
+	test_broken=$(($test_broken+1))
+	say_color skip "  still broken $test_count: $@"
+}
 
 test_debug () {
 	test "$debug" = "" || eval "$1"
@@ -211,13 +224,13 @@ test_expect_failure () {
 	error "bug in the test script: not 2 parameters to test-expect-failure"
 	if ! test_skip "$@"
 	then
-		say >&3 "expecting failure: $2"
+		say >&3 "checking known breakage: $2"
 		test_run_ "$2"
-		if [ "$?" = 0 -a "$eval_ret" != 0 -a "$eval_ret" -lt 129 ]
+		if [ "$?" = 0 -a "$eval_ret" = 0 ]
 		then
-			test_ok_ "$1"
+			test_known_broken_ok_ "$1"
 		else
-			test_failure_ "$@"
+		    test_known_broken_failure_ "$1"
 		fi
 	fi
 	echo >&3 ""
@@ -274,6 +287,15 @@ test_create_repo () {
 
 test_done () {
 	trap - exit
+
+	if test "$test_fixed" != 0
+	then
+		say_color pass "fixed $test_fixed known breakage(s)"
+	fi
+	if test "$test_broken" != 0
+	then
+		say_color error "still have $test_broken known breakage(s)"
+	fi
 	case "$test_failure" in
 	0)
 		# We could:
