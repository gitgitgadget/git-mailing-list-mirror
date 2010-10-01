From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] test-lib: make test_expect_code a test command
Date: Fri,  1 Oct 2010 17:42:20 +0000
Message-ID: <1285954940-4247-1-git-send-email-avarab@gmail.com>
References: <1285953391-29840-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 19:42:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1jcx-0006om-S7
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 19:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab0JARmb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 13:42:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54666 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab0JARma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 13:42:30 -0400
Received: by wyb28 with SMTP id 28so3169352wyb.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EmTRH2yz0KczTbM6YHcGjwIX51bq4rocYlfe4rrfWek=;
        b=dp6eCIAsarMwvMOwo1gO/ysI4zmXkFzyR8OJJUHInSJH9ajuvYU7Whaa8yOpb1+Isk
         SD7/GnwuDKAOECOBCeUimpkdzBSjB7cDWJUCLehjDArfpTTLgyVGWjU6LCjo3YYkpb8K
         Uvmm6hopRjGUgpzcNfEB3rHMs2EfYgVE81lJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EcbqpVgWNID+xPnGE6i8p6lDMgHZfGdYoZWt6rzDeBk9dvZfNeHFjpIf8FEWzGbjhv
         3U7goF2IEYT9PtCPllcj7Jju0EqVupPKZYU+6ksC6rDSPMrLqkTkhLLY9Tqv4gbrzbjv
         YP6DJYtdTKkymbeh4NZ4Pfn/HB12FQ4DBuyM4=
Received: by 10.216.17.135 with SMTP id j7mr4730175wej.97.1285954948646;
        Fri, 01 Oct 2010 10:42:28 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id n17sm955997weq.6.2010.10.01.10.42.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 10:42:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285953391-29840-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157765>

Change test_expect_code to be a normal test command instead of a
top-level command.

As a top-level command it would fail in cases like:

    test_expect_code 1 'phoney' '
        foo && bar && (exit 1)
    '

Here the test might incorrectly succeed if "foo" or "bar" happened to
fail with exit status 1. Instead we now do:

    test_expect_success 'phoney' '
        foo && bar && test_expect_code 1 "(exit 1)"
    '

Which will only succeed if "foo" and "bar" return status 0, and "(exit
1)" returns status 1.

Some test code in t0000-basic.sh relied on the old semantics of
test_expect_code to test the test_when_finished command. I've
converted that code to use an external test similar to the TODO test I
added in v1.7.3-rc0~2^2~3.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

=46ixed s/no the/to the/ typo in the commit message spotted by Sverre
Rabbelier.

 t/README                |   16 +++++++------
 t/t0000-basic.sh        |   55 ++++++++++++++++++++++++++++++++++++++-=
-------
 t/t1504-ceiling-dirs.sh |    5 ++-
 t/t6020-merge-df.sh     |    4 ++-
 t/test-lib.sh           |   40 ++++++++++++++++++---------------
 5 files changed, 82 insertions(+), 38 deletions(-)

diff --git a/t/README b/t/README
index a1eb7c8..c216e8c 100644
--- a/t/README
+++ b/t/README
@@ -395,13 +395,6 @@ library for your script to use.
    Like test_expect_success this function can optionally use a three
    argument invocation with a prerequisite as the first argument.
=20
- - test_expect_code [<prereq>] <code> <message> <script>
-
-   Analogous to test_expect_success, but pass the test if it exits
-   with a given exit <code>
-
- test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" =
B master'
-
  - test_debug <script>
=20
    This takes a single argument, <script>, and evaluates it only
@@ -482,6 +475,15 @@ library for your script to use.
 	    'Perl API' \
 	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
=20
+ - test_expect_code <exit-code> <git-command>
+
+   Run a git command and ensure that it exits with the given exit
+   code. For example:
+
+	test_expect_success 'Merge with d/f conflicts' '
+		test_expect_code 1 git merge "merge msg" B master
+	'
+
  - test_must_fail <git-command>
=20
    Run a git command and ensure it fails in a controlled way.  Use
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f688bd3..c2f5f8d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -130,22 +130,57 @@ test_expect_success 'tests clean up after themsel=
ves' '
     test_when_finished clean=3Dyes
 '
=20
-cleaner=3Dno
-test_expect_code 1 'tests clean up even after a failure' '
-    test_when_finished cleaner=3Dyes &&
-    (exit 1)
-'
-
-if test $clean$cleaner !=3D yesyes
+if test $clean !=3D yes
 then
-	say "bug in test framework: cleanup commands do not work reliably"
+	say "bug in test framework: basic cleanup command does not work relia=
bly"
 	exit 1
 fi
=20
-test_expect_code 2 'failure to clean up causes the test to fail' '
-    test_when_finished "(exit 2)"
+test_expect_success 'tests clean up even on failures' "
+    mkdir failing-cleanup &&
+    (cd failing-cleanup &&
+    cat >failing-cleanup.sh <<EOF &&
+#!$SHELL_PATH
+
+test_description=3D'Failing tests with cleanup commands'
+
+# Point to the t/test-lib.sh, which isn't in ../ as usual
+TEST_DIRECTORY=3D\"$TEST_DIRECTORY\"
+. \"\$TEST_DIRECTORY\"/test-lib.sh
+
+test_expect_success 'tests clean up even after a failure' '
+    touch clean-after-failure &&
+    test_when_finished rm clean-after-failure &&
+    (exit 1)
 '
=20
+test_expect_success 'failure to clean up causes the test to fail' '
+    test_when_finished \"(exit 2)\"
+'
+
+test_done
+EOF
+    chmod +x failing-cleanup.sh &&
+    test_must_fail ./failing-cleanup.sh >out 2>err &&
+    ! test -s err &&
+    ! test -f \"trash directory.failing-cleanup/clean-after-failure\" =
&&
+cat >expect <<EOF &&
+not ok - 1 tests clean up even after a failure
+#=09
+#	    touch clean-after-failure &&
+#	    test_when_finished rm clean-after-failure &&
+#	    (exit 1)
+#=09
+not ok - 2 failure to clean up causes the test to fail
+#=09
+#	    test_when_finished \"(exit 2)\"
+#=09
+# failed 2 among 2 test(s)
+1..2
+EOF
+    test_cmp expect out)
+"
+
 ################################################################
 # Basics of the basics
=20
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index df5ad8c..cce87a5 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -9,8 +9,9 @@ test_prefix() {
 }
=20
 test_fail() {
-	test_expect_code 128 "$1: prefix" \
-	"git rev-parse --show-prefix"
+	test_expect_success "$1: prefix" '
+		test_expect_code 128 git rev-parse --show-prefix
+	'
 }
=20
 TRASH_ROOT=3D"$PWD"
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 490d397..5d91d05 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -20,7 +20,9 @@ echo "file dir" > dir &&
 git add dir &&
 git commit -m "File: dir"'
=20
-test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B=
 master'
+test_expect_success 'Merge with d/f conflicts' '
+	test_expect_code 1 git merge "merge msg" B master
+'
=20
 test_expect_success 'F/D conflict' '
 	git reset --hard &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 830e5e7..d86edcd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -473,24 +473,6 @@ test_expect_success () {
 	echo >&3 ""
 }
=20
-test_expect_code () {
-	test "$#" =3D 4 && { prereq=3D$1; shift; } || prereq=3D
-	test "$#" =3D 3 ||
-	error "bug in the test script: not 3 or 4 parameters to test-expect-c=
ode"
-	if ! test_skip "$@"
-	then
-		say >&3 "expecting exit code $1: $3"
-		test_run_ "$3"
-		if [ "$?" =3D 0 -a "$eval_ret" =3D "$1" ]
-		then
-			test_ok_ "$2"
-		else
-			test_failure_ "$@"
-		fi
-	fi
-	echo >&3 ""
-}
-
 # test_external runs external test scripts that provide continuous
 # test output about their progress, and succeeds/fails on
 # zero/non-zero exit code.  It outputs the test output on stdout even
@@ -658,6 +640,28 @@ test_might_fail () {
 	return 0
 }
=20
+# Similar to test_must_fail and test_might_fail, but check that a
+# given command exited with a given exit code. Meant to be used as:
+#
+#	test_expect_success 'Merge with d/f conflicts' '
+#		test_expect_code 1 git merge "merge msg" B master
+#	'
+
+test_expect_code () {
+	want_code=3D$1
+	shift
+	"$@"
+	exit_code=3D$?
+	if test $exit_code =3D $want_code
+	then
+		echo >&2 "test_expect_code: command exited with $exit_code: $*"
+		return 0
+	else
+		echo >&2 "test_expect_code: command exited with $exit_code, we wante=
d $want_code $*"
+		return 1
+	fi
+}
+
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
 #
--=20
1.7.3.159.g610493
