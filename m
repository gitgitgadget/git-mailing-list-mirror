From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Sat, 21 Jul 2012 18:46:57 +0100
Message-ID: <500AEB11.4050006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 20:00:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssdy9-0007K4-0c
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 19:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab2GUR7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 13:59:49 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:55123 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751401Ab2GUR7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 13:59:48 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Jul 2012 13:59:48 EDT
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id E17BB6F80AB
	for <git@vger.kernel.org>; Sat, 21 Jul 2012 18:52:34 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 73E1EA0C080;
	Sat, 21 Jul 2012 18:51:53 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 312B1A0C07F;	Sat, 21 Jul 2012 18:51:52 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sat, 21 Jul 2012 18:51:50 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201828>


At present, running the t3300-*.sh test on cygwin looks like:

    $ cd t
    $ ./t3300-funny-names.sh
    ok 1 - setup
    # passed all 1 test(s)
    1..1 # SKIP Your filesystem does not allow tabs in filenames
    $

Unfortunately, this is not valid TAP output, which prove notes
as follows:

    $ prove --exec sh t3300-funny-names.sh
    t3300-funny-names.sh .. All 1 subtests passed

    Test Summary Report
    -------------------
    t3300-funny-names.sh (Wstat: 0 Tests: 1 Failed: 0)
      Parse errors: No plan found in TAP output
    Files=1, Tests=1,  2 wallclock secs ( 0.05 usr  0.00 sys +  \
        0.90 cusr  0.49 csys =  1.43 CPU)
    Result: FAIL
    $

This is due to the 'trailing_plan' having a 'skip_directive'
attached to it. This is not allowed by the TAP grammar, which
only allows a 'leading_plan' to be followed by an optional
'skip_directive'. (see perldoc TAP::Parser::Grammar).

A trailing_plan is one that appears in the TAP output after one or
more test status lines (that start 'not '? 'ok ' ...), whereas a
leading_plan must appear before all test status lines (if any).

In practice, this means that the test script cannot contain a use
of the 'skip all' facility:

    skip_all='Some reason to skip *all* tests in this file'
    test_done

after having already executed one or more tests with (for example)
'test_expect_success'. Unfortunately, this is exactly what this
test script is doing. The first 'setup' test is actually used to
determine if the test prerequisite is satisfied by the filesystem
(ie does it allow tabs in filenames?).

In order to fix the parse errors, place the code to determine the
test prerequisite at the top level of the script, rather than as
a parameter to test_expect_success. This allows us to correctly
use 'skip_all', thus:

    $ ./t3300-funny-names.sh
    # passed all 0 test(s)
    1..0 # SKIP Your filesystem does not allow tabs in filenames
    $

    $ prove --exec sh t3300-funny-names.sh
    t3300-funny-names.sh .. skipped: Your filesystem does not \
        allow tabs in filenames
    Files=1, Tests=0,  2 wallclock secs ( 0.02 usr  0.03 sys +  \
        0.84 cusr  0.41 csys =  1.29 CPU)
    Result: NOTESTS
    $

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jonathan,

This is an RFC because I suspect some people may prefer the much
simpler patch:

    diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
    index 1f35e55..2a64385 100755
    --- a/t/t3300-funny-names.sh
    +++ b/t/t3300-funny-names.sh
    @@ -34,7 +34,7 @@ test_expect_success 'setup' '
     if ! test_have_prereq TABS_IN_FILENAMES
     then
     	# since FAT/NTFS does not allow tabs in filenames, skip this test
    -	skip_all='Your filesystem does not allow tabs in filenames'
    +	say '# SKIP Your filesystem does not allow tabs in filenames'
     	test_done
     fi
     
... the output of which looks like:

    $ cd t
    $ ./t3300-funny-names.sh
    ok 1 - setup
    # SKIP Your filesystem does not allow tabs in filenames
    # passed all 1 test(s)
    1..1
    $

    $ prove --exec sh t3300-funny-names.sh
    t3300-funny-names.sh .. ok
    All tests successful.
    Files=1, Tests=1,  1 wallclock secs ( 0.03 usr  0.01 sys +  \
        0.85 cusr  0.34 csys =  1.24 CPU)
    Result: PASS
    $

Needless to say, I much prefer the patch below. :-D

ATB,
Ramsay Jones

 t/t3300-funny-names.sh | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 1f35e55..c51674a 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -15,28 +15,20 @@ p0='no-funny'
 p1='tabs	," (dq) and spaces'
 p2='just space'
 
-test_expect_success 'setup' '
-	cat >"$p0" <<-\EOF &&
-	1. A quick brown fox jumps over the lazy cat, oops dog.
-	2. A quick brown fox jumps over the lazy cat, oops dog.
-	3. A quick brown fox jumps over the lazy cat, oops dog.
-	EOF
-
-	{ cat "$p0" >"$p1" || :; } &&
-	{ echo "Foo Bar Baz" >"$p2" || :; } &&
+cat >"$p0" <<\EOF
+1. A quick brown fox jumps over the lazy cat, oops dog.
+2. A quick brown fox jumps over the lazy cat, oops dog.
+3. A quick brown fox jumps over the lazy cat, oops dog.
+EOF
 
-	if test -f "$p1" && cmp "$p0" "$p1"
-	then
-		test_set_prereq TABS_IN_FILENAMES
-	fi
-'
+cat 2>/dev/null >"$p1" "$p0"
+echo 'Foo Bar Baz' >"$p2"
 
-if ! test_have_prereq TABS_IN_FILENAMES
-then
+test -f "$p1" && cmp "$p0" "$p1" || {
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
 	skip_all='Your filesystem does not allow tabs in filenames'
 	test_done
-fi
+}
 
 test_expect_success 'setup: populate index and tree' '
 	git update-index --add "$p0" "$p2" &&
-- 
1.7.11.2
