From: Junio C Hamano <junkio@cox.net>
Subject: Re: t9200-git-cvsexportcommit.sh failed on CYGWIN
Date: Thu, 28 Dec 2006 17:58:00 -0800
Message-ID: <7vpsa3sbtj.fsf@assigned-by-dhcp.cox.net>
References: <459338AA.8000407@gmail.com> <en0b47$bjm$3@sea.gmane.org>
	<4594565B.3090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 29 02:58:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H070i-0005Mr-A3
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 02:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbWL2B6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 28 Dec 2006 20:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbWL2B6E
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 20:58:04 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56369 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbWL2B6D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Dec 2006 20:58:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229015801.OLCV25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 20:58:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4RyF1W0091kojtg0000000; Thu, 28 Dec 2006 20:58:15 -0500
To: SungHyun Nam <goweol@gmail.com>
In-Reply-To: <4594565B.3090804@gmail.com> (SungHyun Nam's message of "Fri, 29
	Dec 2006 08:42:19 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35573>

SungHyun Nam <goweol@gmail.com> writes:

> Jakub Narebski wrote:
> ...
>> What filesystem? Some filesystems are just broken...
>
> NTFS (no FAT32 here).
> ...
> $ mkdir -p =C5/goo
> mkdir: cannot create directory `=C5/goo': No such file or directory

SungHyun Nam <goweol@gmail.com> writes:

> Jakub Narebski wrote:
>> SungHyun Nam wrote:
>>=20
>>> Below is the test messages.
>>>
>>> BTW, I hope I can define 'NO_CVS_TESTS' to skip this test.
>> ...
>> What filesystem? Some filesystems are just broken...
>
> NTFS (no FAT32 here).
>
> Anyway, I test it step by step manually, and then...
>
> $ cd tmp; mkdir t; cd t
> $ ls -l
> total 0
> $ mkdir -p =C5/goo
> mkdir: cannot create directory `=C5/goo': No such file or directory

Some filesystems cannot use arbitrary sequence of non NUL bytes
as pathnames.

It would be handy to have a way to skip tests that the user
knows would not pass on his particular system.

I do not think that such a request should be named NO_CVS_TESTS,
though.  It is not like NO_SVN_TESTS where your system does not
have svn installed.  I think even on hanglized NTFS, CVS
operations on pathnames that use only portable pathname
characters should work.

I am considering doing this instead...

-- >8 --
GIT_SKIP_TESTS: allow users to omit tests that are know to break

In some environments, certain tests have no way of succeeding
due to platform limitation, such as lack of 'unzip' program, or
filesystem that do not allow arbitrary sequence of non-NUL bytes
as pathnames.

You should be able to say something like

	$ cd t
	$ GIT_SKIP_TESTS=3Dt9200.8 t9200-git-cvsexport-commit.sh

and even:

	$ GIT_SKIP_TESTS=3D't[0-4]??? t91?? t9200.8' make test

to omit such tests.  The value of the environment variable is a
SP separated list of patterns that tells which tests to skip,
and either can match the "t[0-9]{4}" part to skip the whole
test, or t[0-9]{4} followed by ".$number" to say which
particular test to skip.

Note that some tests in the existing test suite rely on previous
test item, so you cannot arbitrarily disable one and expect the
remainder of test to check what the test originally was intended
to check.

---
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ad2b6f6..98f69d8 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -125,16 +125,43 @@ test_run_ () {
 	return 0
 }
=20
+test_skip () {
+	this_test=3D$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
+	this_test=3D"$this_test.$(expr "$test_count" + 1)"
+	to_skip=3D
+	for skp in $GIT_SKIP_TESTS
+	do
+		case "$this_test" in
+		$skp)
+			to_skip=3Dt
+		esac
+	done
+	case "$to_skip" in
+	t)
+		say >&3 "skipping test: $@"
+		test_count=3D$(expr "$test_count" + 1)
+		say "skip $test_count: $1"
+		: true
+		;;
+	*)
+		false
+		;;
+	esac
+}
+
 test_expect_failure () {
 	test "$#" =3D 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-failur=
e"
-	say >&3 "expecting failure: $2"
-	test_run_ "$2"
-	if [ "$?" =3D 0 -a "$eval_ret" !=3D 0 -a "$eval_ret" -lt 129 ]
+	if ! test_skip "$@"
 	then
-		test_ok_ "$1"
-	else
-		test_failure_ "$@"
+		say >&3 "expecting failure: $2"
+		test_run_ "$2"
+		if [ "$?" =3D 0 -a "$eval_ret" !=3D 0 -a "$eval_ret" -lt 129 ]
+		then
+			test_ok_ "$1"
+		else
+			test_failure_ "$@"
+		fi
 	fi
 	echo >&3 ""
 }
@@ -142,13 +169,16 @@ test_expect_failure () {
 test_expect_success () {
 	test "$#" =3D 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-succes=
s"
-	say >&3 "expecting success: $2"
-	test_run_ "$2"
-	if [ "$?" =3D 0 -a "$eval_ret" =3D 0 ]
+	if ! test_skip "$@"
 	then
-		test_ok_ "$1"
-	else
-		test_failure_ "$@"
+		say >&3 "expecting success: $2"
+		test_run_ "$2"
+		if [ "$?" =3D 0 -a "$eval_ret" =3D 0 ]
+		then
+			test_ok_ "$1"
+		else
+			test_failure_ "$@"
+		fi
 	fi
 	echo >&3 ""
 }
@@ -156,13 +186,16 @@ test_expect_success () {
 test_expect_code () {
 	test "$#" =3D 3 ||
 	error "bug in the test script: not 3 parameters to test-expect-code"
-	say >&3 "expecting exit code $1: $3"
-	test_run_ "$3"
-	if [ "$?" =3D 0 -a "$eval_ret" =3D "$1" ]
+	if ! test_skip "$@"
 	then
-		test_ok_ "$2"
-	else
-		test_failure_ "$@"
+		say >&3 "expecting exit code $1: $3"
+		test_run_ "$3"
+		if [ "$?" =3D 0 -a "$eval_ret" =3D "$1" ]
+		then
+			test_ok_ "$2"
+		else
+			test_failure_ "$@"
+		fi
 	fi
 	echo >&3 ""
 }
@@ -223,3 +256,22 @@ test=3Dtrash
 rm -fr "$test"
 test_create_repo $test
 cd "$test"
+
+this_test=3D$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
+for skp in $GIT_SKIP_TESTS
+do
+	to_skip=3D
+	for skp in $GIT_SKIP_TESTS
+	do
+		case "$this_test" in
+		$skp)
+			to_skip=3Dt
+		esac
+	done
+	case "$to_skip" in
+	t)
+		say >&3 "skipping test $this_test altogether"
+		say "skip all tests in $this_test"
+		test_done
+	esac
+done
