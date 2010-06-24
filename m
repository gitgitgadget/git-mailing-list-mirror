From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 2/5] test-lib: Make the test_external_* functions TAP-aware
Date: Thu, 24 Jun 2010 17:44:46 +0000
Message-ID: <1277401489-27885-3-git-send-email-avarab@gmail.com>
References: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 19:45:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORqUh-0005K1-Et
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154Ab0FXRpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 13:45:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42245 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab0FXRph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:45:37 -0400
Received: by wyi11 with SMTP id 11so1893480wyi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qNyIlcXYQvtGCrXpJV6PN/j+APgObLqcSKX9rcuZRBc=;
        b=PWWB81aA/boKW7f5I/iF5nI54Mk462JPCZDpkInyt78nthcV5Y8RrUzt5Owv4r/m//
         8H1NVUyiQzYlzHnSQDWTJZbBEtsJ9Y0wiemU0uqnxBO+TVwyWMife/ekU/b3J0Sf7IU0
         yxwm80b4gF0T9ikfm6WxWlIG3Twk9rHk58HKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sMgHwEq22rckSU15DJh95m2YWicefLupuFg33bAPEDCEwAQMkt+ZXI8Z6eHCWIg9/m
         YlpEDRbzKNC+cX8XENrCw3JEfCtJ1HVZGE47KyaIvG51V8OsaLx7zsoUeQ3CBNnqlMlk
         07O/0hHBfrQ/oXgQEvj3XQF09c9iQfz/tc4xE=
Received: by 10.216.87.5 with SMTP id x5mr7659764wee.90.1277401535730;
        Thu, 24 Jun 2010 10:45:35 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id h1sm1043062wee.31.2010.06.24.10.45.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 10:45:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149610>

Before TAP we just ran the Perl test and assumed that it failed if
nothing was printed on STDERR. Continue doing that, but introduce a
`test_external_has_tap' variable which tests can set to indicate that
they're outputting TAP.

If it's set we won't output a test plan, but trust the external test
to do so. That way we can make external tests work with a TAP harness,
but still maintain compatibility with test-lib's own way of tracking
tests through the test-results directory.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9700-perl-git.sh |    3 +++
 t/t9700/test.pl     |   11 +++++++++++
 t/test-lib.sh       |   51 +++++++++++++++++++++++++++++++++++++++----=
--------
 3 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 8686086..0b92726 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -46,6 +46,9 @@ test_expect_success \
      git config --add test.int 2k
      '
=20
+# The external test will outputs its own plan
+test_external_has_tap=3D1
+
 test_external_without_stderr \
     'Perl API' \
     "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 666722d..e5d4b03 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -7,6 +7,13 @@ use strict;
=20
 use Test::More qw(no_plan);
=20
+BEGIN {
+	# t9700-perl-git.sh kicks off our testing, so we have to go from
+	# there.
+	$Test::Builder::Test->{Curr_Test} =3D 1;
+	$Test::Builder::Test->{No_Ending} =3D 1;
+}
+
 use Cwd;
 use File::Basename;
=20
@@ -105,3 +112,7 @@ my $last_commit =3D $r2->command_oneline(qw(rev-par=
se --verify HEAD));
 like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-parse returned hash');
 my $dir_commit =3D $r2->command_oneline('log', '-n1', '--pretty=3Dform=
at:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
+
+printf "1..%d\n", $Test::Builder::Test->{Curr_Test};
+
+exit($Test::Builder::Test->{Is_Passing} ? 0 : 1);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e97645c..7077210 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -206,6 +206,8 @@ test_fixed=3D0
 test_broken=3D0
 test_success=3D0
=20
+test_external_has_tap=3D0
+
 die () {
 	code=3D$?
 	if test -n "$GIT_EXIT_OK"
@@ -456,7 +458,7 @@ test_expect_code () {
 # test_external runs external test scripts that provide continuous
 # test output about their progress, and succeeds/fails on
 # zero/non-zero exit code.  It outputs the test output on stdout even
-# in non-verbose mode, and announces the external script with "* run
+# in non-verbose mode, and announces the external script with "# run
 # <n>: ..." before running it.  When providing relative paths, keep in
 # mind that all scripts run in "trash directory".
 # Usage: test_external description command arguments...
@@ -471,7 +473,7 @@ test_external () {
 	then
 		# Announce the script to reduce confusion about the
 		# test output that follows.
-		say_color "" " run $test_count: $descr ($*)"
+		say_color "" "# run $test_count: $descr ($*)"
 		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
 		# to be able to use them in script
 		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
@@ -481,9 +483,19 @@ test_external () {
 		"$@" 2>&4
 		if [ "$?" =3D 0 ]
 		then
-			test_ok_ "$descr"
+			if test $test_external_has_tap -eq 0; then
+				test_ok_ "$descr"
+			else
+				say_color "" "# test_external test $descr was ok"
+				test_success=3D$(($test_success + 1))
+			fi
 		else
-			test_failure_ "$descr" "$@"
+			if test $test_external_has_tap -eq 0; then
+				test_failure_ "$descr" "$@"
+			else
+				say_color error "# test_external test $descr failed: $@"
+				test_failure=3D$(($test_failure + 1))
+			fi
 		fi
 	fi
 }
@@ -499,19 +511,30 @@ test_external_without_stderr () {
 	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
 	descr=3D"no stderr: $1"
 	shift
-	say >&3 "expecting no stderr from previous command"
+	say >&3 "# expecting no stderr from previous command"
 	if [ ! -s "$stderr" ]; then
 		rm "$stderr"
-		test_ok_ "$descr"
+
+		if test $test_external_has_tap -eq 0; then
+			test_ok_ "$descr"
+		else
+			say_color "" "# test_external_without_stderr test $descr was ok"
+			test_success=3D$(($test_success + 1))
+		fi
 	else
 		if [ "$verbose" =3D t ]; then
-			output=3D`echo; echo Stderr is:; cat "$stderr"`
+			output=3D`echo; echo "# Stderr is:"; cat "$stderr"`
 		else
 			output=3D
 		fi
 		# rm first in case test_failure exits.
 		rm "$stderr"
-		test_failure_ "$descr" "$@" "$output"
+		if test $test_external_has_tap -eq 0; then
+			test_failure_ "$descr" "$@" "$output"
+		else
+			say_color error "# test_external_without_stderr test $descr failed:=
 $@: $output"
+			test_failure=3D$(($test_failure + 1))
+		fi
 	fi
 }
=20
@@ -634,8 +657,10 @@ test_done () {
 		# Maybe print SKIP message
 		[ -z "$skip_all" ] || skip_all=3D" # SKIP $skip_all"
=20
-		say_color pass "# passed all $msg"
-		say "1..$test_count$skip_all"
+		if test $test_external_has_tap -eq 0; then
+			say_color pass "# passed all $msg"
+			say "1..$test_count$skip_all"
+		fi
=20
 		test -d "$remove_trash" &&
 		cd "$(dirname "$remove_trash")" &&
@@ -644,8 +669,10 @@ test_done () {
 		exit 0 ;;
=20
 	*)
-		say_color error "# failed $test_failure among $msg"
-		say "1..$test_count"
+		if test $test_external_has_tap -eq 0; then
+			say_color error "# failed $test_failure among $msg"
+			say "1..$test_count"
+		fi
=20
 		exit 1 ;;
=20
--=20
1.7.1.251.g92a7
