From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] test: skip test with COLUMNS=1 under mksh
Date: Fri, 27 Apr 2012 11:25:25 +0200
Message-ID: <1335518725-19728-1-git-send-email-zbyszek@in.waw.pl>
References: <20120426223422.GC22261@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucian Poston <lucian.poston@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 27 11:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNhVb-0001Ke-1r
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 11:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952Ab2D0JaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Apr 2012 05:30:19 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35601 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757043Ab2D0JaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 05:30:17 -0400
Received: from zopt1.fuw.edu.pl ([193.0.81.24] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SNhVH-00025K-T6; Fri, 27 Apr 2012 11:30:16 +0200
X-Mailer: git-send-email 1.7.10.433.g48a19
In-Reply-To: <20120426223422.GC22261@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196459>

mksh does not allow $COLUMNS to be set below 12. Quoting mksh(1)
$COLUMNS is "always set, defaults to 80, unless the value as reported
by stty(1) is non-zero and sane enough". This applies also to setting
it directly for one command:

$ COLUMNS=3D30 python -c 'import os; print os.environ["COLUMNS"]'
30
$ COLUMNS=3D20 python -c 'import os; print os.environ["COLUMNS"]'
20
$ COLUMNS=3D10 python -c 'import os; print os.environ["COLUMNS"]'
98

Let's test if we can set COLUMNS=3D1, and if not, skip the tests that
want to use that. A prereq is added, which is set if $COLUMNS can be
set.

In t9002-column.sh, file with expected output was shared between two
test cases, but set in the first one. Since the first test case can
now be skipped, setting up the expected output is moved outside of the
test case.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---

This fixes problems under /bin/sh=3Dmksh in two newly added test files:
t4052 and t9002. I think that doing it with a prereq is fairly
minimalistic, and the output looks nice.

 t/t4052-stat-output.sh |    6 ++++--
 t/t9002-column.sh      |    5 +++--
 t/test-lib.sh          |    1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index ced32db..ddd9497 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -292,7 +292,8 @@ cat >expect1-graph <<'EOF'
 EOF
 while read verb expect cmd args
 do
-	test_expect_success "$cmd $verb prefix greater than COLUMNS (big chan=
ge)" '
+	test_expect_success COLUMNS_CAN_BE_1 \
+		"$cmd $verb prefix greater than COLUMNS (big change)" '
 		COLUMNS=3D1 git $cmd $args >output
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
@@ -300,7 +301,8 @@ do
=20
 	test "$cmd" !=3D diff || continue
=20
-	test_expect_success "$cmd --graph $verb prefix greater than COLUMNS (=
big change)" '
+	test_expect_success COLUMNS_CAN_BE_1 \
+		"$cmd --graph $verb prefix greater than COLUMNS (big change)" '
 		COLUMNS=3D1 git $cmd $args --graph >output
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index c7d7a65..8998352 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -50,8 +50,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'COLUMNS =3D 1' '
-	cat >expected <<\EOF &&
+cat >expected <<\EOF
 one
 two
 three
@@ -64,6 +63,8 @@ nine
 ten
 eleven
 EOF
+
+test_expect_success COLUMNS_CAN_BE_1 'COLUMNS =3D 1' '
 	COLUMNS=3D1 git column --mode=3Dcolumn <lista >actual &&
 	test_cmp expected actual
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b7d7100..9e2b711 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -615,6 +615,7 @@ case $(uname -s) in
 	;;
 esac
=20
+( COLUMNS=3D1 && test $COLUMNS =3D 1 ) && test_set_prereq COLUMNS_CAN_=
BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
--=20
1.7.10.433.g48a19
