From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Tue, 05 Feb 2013 21:36:14 +0100
Message-ID: <51116D3E.3070409@web.de>
References: <201301120650.46479.tboegi@web.de> <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de> <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org> <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org> <51037E5F.8090506@web.de> <20130127093121.GA4228@elie.Belkin> <5105280A.80002@web.de> <7v4ni2y1fm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:37:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2pGL-0003wW-NA
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab3BEUgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 15:36:39 -0500
Received: from mout.web.de ([212.227.17.12]:57102 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755556Ab3BEUgi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 15:36:38 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MMVpO-1U2HYk13Gw-008ena; Tue, 05 Feb 2013 21:36:17
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v4ni2y1fm.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:RCtuFzNXsbRyg+O0qlbvyoD2GuXd9rut1gvGvzItDie
 Oi1tPkLljKpLLGF4PCismTCspWu3kN1RTl5QjPettADMQkxhML
 /e6ZyemEkIFQRGaYplxkBA+yUz2wdY0OqVXdO/6afcr6zMvxIv
 cVNt80oLiIjzBRnJNTHgAnWO0EE9CFD9vM0EF6EAgxWeS+pai0
 noaG/paG1Nvc2LSZloN5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215535>

On 27.01.13 18:34, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Back to the which:
>> ...
>> and running "make test" gives the following, at least in my system:
>> ...
> I think everybody involved in this discussion already knows that;
> the point is that it can easily give false negative, without the
> scripts working very hard to do so.
>
> If we did not care about incurring runtime performance cost, we
> could arrange:
>
>  - the test framework to define a variable $TEST_ABORT that has a
>    full path to a file that is in somewhere test authors cannot
>    touch unless they really try hard to (i.e. preferrably outside
>    $TRASH_DIRECTORY, as it is not uncommon for to tests to do "rm *"
>    there). This location should be per $(basename "$0" .sh) to allow
>    running multiple tests in paralell;
>
>  - the test framework to "rm -f $TEST_ABORT" at the beginning of
>    test_expect_success/failure;
>
>  - test_expect_success/failure to check $TEST_ABORT and if it
>    exists, abort the execution, showing the contents of the file as
>    an error message.
>
> Then you can wrap commands whose use we want to limit, perhaps like
> this, in the test framework:
>
> 	which () {
> 		cat >"$TEST_ABORT" <<-\EOF
> 		Do not use unportable 'which' in the test script.
>                 "if type $cmd" is a good way to see if $cmd exists.
> 		EOF
> 	}
>
> 	sed () {
> 		saw_wantarg=3D must_abort=3D
>                 for arg
>                 do
> 			if test -n "$saw_wantarg"
>                         then
> 				saw_wantarg=3D
>                                 continue
> 			fi
> 			case "$arg" in
> 			--)	break ;; # end of options
> 			-i)	echo >"$TEST_ABORT" "Do not use 'sed -i'"
> 				must_abort=3Dyes
> 				break ;;
>                         -e)	saw_wantarg=3Dyes ;; # skip next arg
> 			-*)	continue ;; # options without arg
> 			*)	break ;; # filename
> 			esac
> 		done
> 		if test -z "$must_abort"
> 			sed "$@"
> 		fi
> 	}
>
> Then you can check that TEST_ABORT does not appear in test scripts
> (ensuring that they do not attempt to circumvent the mechanis) and
> catch use of unwanted commands or unwanted extended features of
> commands at runtime.
>
> But this will incur runtime performace hit, so I am not sure it
> would be worth it.
Thanks for the detailed suggestion.
Instead of using a file for putting out non portable syntax,
can we can use a similar logic as test_failure ?

I did some benchmarking, the test suite on a Laptop is 37..38 minutes,
including make clean && make both on next, pu, master or with the patch=
 below.
I couldn't find a measurable impact on the execution time.
What do we think about a patch like this
(Not sure if this cut-and-paste data applies, it's for review)


[PATCH] test-lib: which, echo -n and sed -i are not portable

The posix version of sed command supports options -n -e -f
The gnu extension -i to edit a file in place is not
available on all systems.
To catch the usage of non-posix options with sed a
wrapper function is added in test-lib.sh.
The wrapper checks that only -n -e -f are used.
The short form "-ne" for "-n -e" is allowed as well.

echo -n is not portable and not available on all systems,
printf can be used instead.
Add a wrapper to catch echo -n

which is not portable, the output differs between different
implementations, and the return code may not be reliable.

Add a function test_bad_syntax_ in test-lib.sh, which increments
the variable test_bad_syntax and works similar to test_failure_

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/test-lib.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1a6c4ab..248ed34 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -266,6 +266,7 @@ else
     exec 4>/dev/null 3>/dev/null
 fi
=20
+test_bad_syntax=3D0
 test_failure=3D0
 test_count=3D0
 test_fixed=3D0
@@ -300,6 +301,12 @@ test_ok_ () {
     say_color "" "ok $test_count - $@"
 }
=20
+test_bad_syntax_ () {
+    test_bad_syntax=3D$(($test_bad_syntax + 1))
+    say_color error "$@"
+    test "$immediate" =3D "" || { GIT_EXIT_OK=3Dt; exit 1; }
+}
+
 test_failure_ () {
     test_failure=3D$(($test_failure + 1))
     say_color error "not ok $test_count - $1"
@@ -402,10 +409,15 @@ test_done () {
         fixed $test_fixed
         broken $test_broken
         failed $test_failure
+        bad_syntax $test_bad_syntax
=20
         EOF
     fi
=20
+    if test "$test_bad_syntax" !=3D 0
+    then
+        say_color error "# $test_bad_syntax non portable shell syntax"
+    fi
     if test "$test_fixed" !=3D 0
     then
         say_color error "# $test_fixed known breakage(s) vanished; ple=
ase update test(s)"
@@ -645,6 +657,40 @@ yes () {
     done
 }
=20
+
+# which is not portable
+which () {
+    test_bad_syntax_ "Do not use unportable 'which' in the test script=
=2E" \
+            "'if type $1' is a good way to see if '$1' exists."
+    return 1
+}
+
+# catch non-portable usage of sed
+sed () {
+    for arg
+    do
+        case "$arg" in
+    -[efn]) continue ;; # allowed posix options
+    -ne) continue ;; # tolerated
+        -*)test_bad_syntax_ "Do not use 'sed "$arg"'. Valid options fo=
r 'sed' are -n -e -f"
+            return 1
+            ;;
+        *) continue ;;
+        esac
+    done
+    command sed "$@"
+}
+
+# catch non portable echo -n
+echo () {
+    if test "$1" =3D -n
+    then
+        test_bad_syntax_ "Do not use 'echo -n'. Use printf instead"
+    else
+        command echo "$@"
+    fi
+}
+
 # Fix some commands on Windows
 case $(uname -s) in
 *MINGW*)
--=20
1.8.1.1
