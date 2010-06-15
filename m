From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 3/5] We use TAP so the Perl test can run without scaffolding
Date: Tue, 15 Jun 2010 22:32:56 +0000
Message-ID: <1276641178-32420-4-git-send-email-avarab@gmail.com>
References: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:34:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOeiC-0006Bf-Sq
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab0FOWeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 18:34:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60370 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab0FOWeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:34:14 -0400
Received: by wwb18 with SMTP id 18so5216483wwb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5ub/NHHL8NhgLw3pzXUMsO8yTx3ZkAANbz+Fn34n4Nw=;
        b=XiQcjA1SdSUjeqV8Vs83gDCRo5fOWEFb+W16xg5a1ErBjFmuQzDoMxRbKeGVf9Cc0a
         noPkm3lQ+Oqp3sgOl1M+LvkX7cbF0PP2jkM2uErBn7agNIL//NzLifHjNPA4z7aNHF1s
         WF7yhU3YudxA+QtIIhnIrhhc/CnRmwUZDTA5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rDv9TN+zK7GoF5Uc7hf4GaX102y+x1rajgn+y3VS6DZoWINXGWazwNGEwtLi/FsQDu
         +avZXxOXNcBRPU0Y6SOjvvUI2YN+wsuq7zesw4/hZkVKTCEkkmpPjhvcGXkxvNxaLGAP
         VOJmLNDjg/79qrEAF6ia50TvrsC8Cmb197/h4=
Received: by 10.227.128.129 with SMTP id k1mr7845594wbs.32.1276641252137;
        Tue, 15 Jun 2010 15:34:12 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id u36sm49368610wbv.6.2010.06.15.15.34.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 15:34:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149236>

Before TAP we ran the Perl test and assumed that it failed if nothing
was printed on STDERR. Now we pass control over to it and rely on its
exit code, which is only non-zero if a test fails.

Running the Perl test with --verbose now gives meaningful output.

This removes the test_external and test_external_without_stderr
functions added by Lea Wiemann in
fb32c410087e68d650b31f68e66b3d9cbcce4a56. Nothing else used them, and
now that we're using TAP they shouldn't be necessary.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9700-perl-git.sh |    8 ++----
 t/t9700/test.pl     |   11 +++++++++
 t/test-lib.sh       |   62 -------------------------------------------=
--------
 3 files changed, 14 insertions(+), 67 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 3999bf7..17252ab 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -46,8 +46,6 @@ test_expect_success \
      git config --add test.int 2k
      '
=20
-test_external_without_stderr \
-    'Perl API' \
-    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
-
-test_done
+"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl &&
+    # The Perl test finalizes the plan, so don't call test_done() here=
=2E
+    GIT_EXIT_OK=3Dt
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
index e97645c..37987d7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -453,68 +453,6 @@ test_expect_code () {
 	echo >&3 ""
 }
=20
-# test_external runs external test scripts that provide continuous
-# test output about their progress, and succeeds/fails on
-# zero/non-zero exit code.  It outputs the test output on stdout even
-# in non-verbose mode, and announces the external script with "* run
-# <n>: ..." before running it.  When providing relative paths, keep in
-# mind that all scripts run in "trash directory".
-# Usage: test_external description command arguments...
-# Example: test_external 'Perl API' perl ../path/to/test.pl
-test_external () {
-	test "$#" =3D 4 && { prereq=3D$1; shift; } || prereq=3D
-	test "$#" =3D 3 ||
-	error >&5 "bug in the test script: not 3 or 4 parameters to test_exte=
rnal"
-	descr=3D"$1"
-	shift
-	if ! test_skip "$descr" "$@"
-	then
-		# Announce the script to reduce confusion about the
-		# test output that follows.
-		say_color "" " run $test_count: $descr ($*)"
-		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
-		# to be able to use them in script
-		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
-		# Run command; redirect its stderr to &4 as in
-		# test_run_, but keep its stdout on our stdout even in
-		# non-verbose mode.
-		"$@" 2>&4
-		if [ "$?" =3D 0 ]
-		then
-			test_ok_ "$descr"
-		else
-			test_failure_ "$descr" "$@"
-		fi
-	fi
-}
-
-# Like test_external, but in addition tests that the command generated
-# no output on stderr.
-test_external_without_stderr () {
-	# The temporary file has no (and must have no) security
-	# implications.
-	tmp=3D"$TMPDIR"; if [ -z "$tmp" ]; then tmp=3D/tmp; fi
-	stderr=3D"$tmp/git-external-stderr.$$.tmp"
-	test_external "$@" 4> "$stderr"
-	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
-	descr=3D"no stderr: $1"
-	shift
-	say >&3 "expecting no stderr from previous command"
-	if [ ! -s "$stderr" ]; then
-		rm "$stderr"
-		test_ok_ "$descr"
-	else
-		if [ "$verbose" =3D t ]; then
-			output=3D`echo; echo Stderr is:; cat "$stderr"`
-		else
-			output=3D
-		fi
-		# rm first in case test_failure exits.
-		rm "$stderr"
-		test_failure_ "$descr" "$@" "$output"
-	fi
-}
-
 # This is not among top-level (test_expect_success | test_expect_failu=
re)
 # but is a prefix that can be used in the test script, like:
 #
--=20
1.7.1.251.g92a7
