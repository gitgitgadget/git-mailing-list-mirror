From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] test-lib-functions: fix logic error in test_must_fail
Date: Tue, 24 Nov 2015 15:59:24 +0000
Message-ID: <5654895C.2000909@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 17:00:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1G0w-0007ji-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 17:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbbKXQAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 11:00:14 -0500
Received: from avasout07.plus.net ([84.93.230.235]:44896 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbKXQAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 11:00:12 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout07 with smtp
	id lTzS1r0075UqX4q01TzUei; Tue, 24 Nov 2015 15:59:28 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=JVBTpVxb2uFS86Mj1F4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281618>


After commit 710eb805 ("implement test_might_fail using a refactored
test_must_fail", 19-11-2015) several tests now unexpectedly pass:

  $ tail -21 ptest-out
  [17:25:53]
  All tests successful.

  Test Summary Report
  -------------------
  t1060-object-corruption.sh                       (Wstat: 0 Tests: 13 Failed: 0)
    TODO passed:   13
  t3510-cherry-pick-sequence.sh                    (Wstat: 0 Tests: 39 Failed: 0)
    TODO passed:   31
  t5707-clone-detached.sh                          (Wstat: 0 Tests: 13 Failed: 0)
    TODO passed:   4
  t6042-merge-rename-corner-cases.sh               (Wstat: 0 Tests: 26 Failed: 0)
    TODO passed:   8
  Files=727, Tests=13139, 407 wallclock secs ( 3.66 usr  0.54 sys + 85.10 cusr 258.06 csys = 347.36 CPU)
  Result: PASS
  make clean-except-prove-cache
  make[2]: Entering directory `/home/ramsay/git/t'
  rm -f -r 'trash directory'.* 'test-results'
  rm -f -r valgrind/bin
  make[2]: Leaving directory `/home/ramsay/git/t'
  make[1]: Leaving directory `/home/ramsay/git/t'
  $

Fix the logic bug in the refactored test_must_fail. Also, use the
integer comparison operator -eq when comparing the exit code, rather
than the string = operator.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Lars,

This patch is on top of the pu branch, but it relates to the two
patches on your 'ls/test-must-fail-sigpipe' branch. Could you
please squash the relevant parts of this patch into your patches.

So, in addition to the logic error in commit 710eb805, I modified
the test introduced by commit 653a48e56 ("add "ok=sigpipe" to
test_must_fail and use it to fix flaky tests", 19-11-2015).

Since I cannot test this second change (t5516 and t5504 don't
fail for me), I don't know if this change is correct - please
test and confirm. (No, it's not clear to me exactly what this
commit is supposed to do! :-D ).

[I didn't have time to go look what value would be returned by
a case statement where there is no 'default' limb - I suspect
that it is undefined behaviour. Even if it is defined, do all
shells behave properly? In any event, it is much simpler to
compare the strings directly!]

I have to say, I'm not keen on either of these commits, but Jeff
and Junio seem OK with it, so ... (the tests being flaky implies
that the git client is flaky - we should fix that).

Thanks.

ATB,
Ramsay Jones

 t/test-lib-functions.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1fdc58c..9061742 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -593,24 +593,22 @@ test_must_fail () {
 	esac
 	"$@"
 	exit_code=$?
-	if ! case ",$_test_ok," in *,success,*) false;; esac &&
-		test $exit_code = 0
+	if test $exit_code -eq 0 && test x$_test_ok != xsuccess
 	then
 		echo >&2 "test_must_fail: command succeeded: $*"
-		return 0
-	elif ! case ",$_test_ok," in *,sigpipe,*) false;; esac &&
-		test $exit_code = 141
+		return 1
+	elif test $exit_code -eq 141 && test x$_test_ok = xsigpipe
 	then
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
 	then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
-	elif test $exit_code = 127
+	elif test $exit_code -eq 127
 	then
 		echo >&2 "test_must_fail: command not found: $*"
 		return 1
-	elif test $exit_code = 126
+	elif test $exit_code -eq 126
 	then
 		echo >&2 "test_must_fail: valgrind error: $*"
 		return 1
-- 
2.6.0
