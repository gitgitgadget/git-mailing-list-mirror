From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/6 v2] Make test-lib.sh emit valid TAP format
Date: Fri,  7 May 2010 20:59:10 +0000
Message-ID: <1273265950-9981-1-git-send-email-avarab@gmail.com>
References: <AANLkTinitdHqD2-viSB2jnS6jONWQQZznp1V0JW934CN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 22:59:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUe0-0002hh-Kw
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab0EGU7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:59:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:23666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab0EGU73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 16:59:29 -0400
Received: by fg-out-1718.google.com with SMTP id d23so894110fga.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2ByZ7KoiqP3NNZSh6NB7FvzlpRKrv407Ty2P4+uBEYE=;
        b=Xy2sHCe20kXrmGgUAZH9Wc1MTx9IEVkBfQ60JxJRsWhK/1jO0bQHScTAwxqDJ6YZ/M
         0tdqJTGR4OdGn3KbM9nW+KkcNYnHmFw6lQOXzmjUXk0QLCNgCgknuVJFdWm7bkxfNh6+
         cNKvsuux9aeYZt9Kesz1x/gI1buakc2Ps++XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rYONrkkfEhm4nd+wwvPyz7hRQ5uYX0qNLqAurVhaWK+FXozVBeHQy+iIKiLJEAaRDz
         tILsx3YXEfh8jrfiDHq62tp2L3zCoLo+lXNGwK4TC8c+uLLmNgihp64xCOP2mb8hctUo
         xt2M7W/7dQEAgiEZAoD26yHLk+E/5KqEFiqTk=
Received: by 10.223.5.89 with SMTP id 25mr616991fau.87.1273265967249;
        Fri, 07 May 2010 13:59:27 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 2sm8274427fav.1.2010.05.07.13.59.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:59:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <AANLkTinitdHqD2-viSB2jnS6jONWQQZznp1V0JW934CN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146596>

TAP, the the Test Anything Protocol, is a simple text-based interface
between testing modules in a test harness. test-lib.sh's output was
already very close to being valid TAP. This change brings it all the
way there. Before:

   $ ./t0005-signals.sh
   *   ok 1: sigchain works
   * passed all 1 test(s)

And after:

   $ ./t0005-signals.sh
   ok 1 - sigchain works
   # passed all 1 test(s)
   1..1

The advantage of using TAP is that any program that reads the format
(a "test harness") can run the tests. The most popular of these is the
prove(1) utility that comes with Perl. It can run tests in parallel,
display colored output, format the output to console, file, HTML etc.,
and much more. An example:

   $ prove ./t0005-signals.sh
   ./t0005-signals.sh .. ok
   All tests successful.
   Files=3D1, Tests=3D1,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.01=
 cusr  0.02 csys =3D  0.06 CPU)
   Result: PASS

prove(1) gives you human readable output without being too
verbose. Running the test suite in parallel with `make test -j15`
produces a flood of text. Running them with `prove -j 15 ./t[0-9]*.sh`
makes it easy to follow what's going on.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Fri, May 7, 2010 at 20:25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> I'll submit an improved patch that doesn't have a confusing commit me=
ssage

Here's that patch. It now also has examples of the test output
before/after and a demonstration of prove(1) running on a test.

 t/README      |   49 +++++++++++++++++++++++++++++++++----------------
 t/test-lib.sh |   30 ++++++++++++++++++------------
 2 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/t/README b/t/README
index dcd3ebb..fc4bb04 100644
--- a/t/README
+++ b/t/README
@@ -18,25 +18,42 @@ The easiest way to run tests is to say "make".  Thi=
s runs all
 the tests.
=20
     *** t0000-basic.sh ***
-    *   ok 1: .git/objects should be empty after git-init in an empty =
repo.
-    *   ok 2: .git/objects should have 256 subdirectories.
-    *   ok 3: git-update-index without --add should fail adding.
+    ok 1 - .git/objects should be empty after git init in an empty rep=
o.
+    ok 2 - .git/objects should have 3 subdirectories.
+    ok 3 - success is reported like this
     ...
-    *   ok 23: no diff after checkout and git-update-index --refresh.
-    * passed all 23 test(s)
-    *** t0100-environment-names.sh ***
-    *   ok 1: using old names should issue warnings.
-    *   ok 2: using old names but having new names should not issue wa=
rnings.
-    ...
-
-Or you can run each test individually from command line, like
-this:
-
-    $ sh ./t3001-ls-files-killed.sh
-    *   ok 1: git-update-index --add to add various paths.
-    *   ok 2: git-ls-files -k to show killed files.
-    *   ok 3: validate git-ls-files -k output.
-    * passed all 3 test(s)
+    ok 43 - very long name in the index handled sanely
+    # fixed 1 known breakage(s)
+    # still have 1 known breakage(s)
+    # passed all remaining 42 test(s)
+    1..43
+    *** t0001-init.sh ***
+    ok 1 - plain
+    ok 2 - plain with GIT_WORK_TREE
+    ok 3 - plain bare
+
+Since the tests all output TAP (see http://testanything.org) they can
+be run with any TAP harness. Here's an example of paralell testing
+powered by a recent version of prove(1):
+       =20
+    $ prove --timer --jobs 15 ./t[0-9]*.sh
+    [19:17:33] ./t0005-signals.sh ................................... =
ok       36 ms
+    [19:17:33] ./t0022-crlf-rename.sh ............................... =
ok       69 ms
+    [19:17:33] ./t0024-crlf-archive.sh .............................. =
ok      154 ms
+    [19:17:33] ./t0004-unwritable.sh ................................ =
ok      289 ms
+    [19:17:33] ./t0002-gitfile.sh ................................... =
ok      480 ms
+    =3D=3D=3D(     102;0  25/?  6/?  5/?  16/?  1/?  4/?  2/?  1/?  3/=
?  1... )=3D=3D=3D
+   =20
+You can also run each test individually from command line, like this:
+
+    $ sh ./t3010-ls-files-killed-modified.sh
+    ok 1 - git update-index --add to add various paths.
+    ok 2 - git ls-files -k to show killed files.
+    ok 3 - validate git ls-files -k output.
+    ok 4 - git ls-files -m to show modified files.
+    ok 5 - validate git ls-files -m output.
+    # passed all 5 test(s)
+    1..5
=20
 You can pass --verbose (or -v), --debug (or -d), and --immediate
 (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
diff --git a/t/test-lib.sh b/t/test-lib.sh
index acce3d0..282314c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -161,7 +161,7 @@ if test -n "$color"; then
 			*) test -n "$quiet" && return;;
 		esac
 		shift
-		printf "* %s" "$*"
+		printf "%s" "$*"
 		tput sgr0
 		echo
 		)
@@ -170,7 +170,7 @@ else
 	say_color() {
 		test -z "$1" && test -n "$quiet" && return
 		shift
-		echo "* $*"
+		echo "$*"
 	}
 fi
=20
@@ -340,25 +340,25 @@ test_have_prereq () {
=20
 test_ok_ () {
 	test_success=3D$(($test_success + 1))
-	say_color "" "  ok $test_count: $@"
+	say_color "" "ok $test_count - $@"
 }
=20
 test_failure_ () {
 	test_failure=3D$(($test_failure + 1))
-	say_color error "FAIL $test_count: $1"
+	say_color error "not ok - $test_count $1"
 	shift
-	echo "$@" | sed -e 's/^/	/'
+	echo "$@" | sed -e 's/^/#	/'
 	test "$immediate" =3D "" || { GIT_EXIT_OK=3Dt; exit 1; }
 }
=20
 test_known_broken_ok_ () {
 	test_fixed=3D$(($test_fixed+1))
-	say_color "" "  FIXED $test_count: $@"
+	say_color "" "ok $test_count - $@ # TODO known breakage"
 }
=20
 test_known_broken_failure_ () {
 	test_broken=3D$(($test_broken+1))
-	say_color skip "  still broken $test_count: $@"
+	say_color skip "not ok $test_count - $@ # TODO known breakage"
 }
=20
 test_debug () {
@@ -390,7 +390,7 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "skip $test_count: $1"
+		say_color skip "ok $test_count: # skip $1"
 		: true
 		;;
 	*)
@@ -601,18 +601,22 @@ test_done () {
=20
 	if test "$test_fixed" !=3D 0
 	then
-		say_color pass "fixed $test_fixed known breakage(s)"
+		say_color pass "# fixed $test_fixed known breakage(s)"
 	fi
 	if test "$test_broken" !=3D 0
 	then
-		say_color error "still have $test_broken known breakage(s)"
+		say_color error "# still have $test_broken known breakage(s)"
 		msg=3D"remaining $(($test_count-$test_broken)) test(s)"
 	else
 		msg=3D"$test_count test(s)"
 	fi
 	case "$test_failure" in
 	0)
-		say_color pass "passed all $msg"
+		# Maybe print SKIP message
+		[ -z "$skip_all" ] || skip_all=3D" # SKIP $skip_all"
+
+		say_color pass "# passed all $msg"
+		say "1..$test_count$skip_all"
=20
 		test -d "$remove_trash" &&
 		cd "$(dirname "$remove_trash")" &&
@@ -621,7 +625,9 @@ test_done () {
 		exit 0 ;;
=20
 	*)
-		say_color error "failed $test_failure among $msg"
+		say_color error "# failed $test_failure among $msg"
+		say "1..$test_count"
+
 		exit 1 ;;
=20
 	esac
--=20
1.7.1.dirty
