From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/6] t3300-*.sh: Fix a TAP parse error
Date: Sat, 01 Sep 2012 19:08:42 +0100
Message-ID: <50424F2A.3080809@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQa-0004DP-Ny
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448Ab2IAS2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:28:03 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44504 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754213Ab2IAS16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:27:58 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 5707B128078;
	Sat,  1 Sep 2012 19:27:57 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 3D08E128075;	Sat,  1 Sep 2012 19:27:56 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:27:55 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204641>


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
test prerequisite at the top level of the script, prior to the
first test, rather than as a parameter to test_expect_success.
This allows us to correctly use 'skip_all', thus:

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
 t/t3300-funny-names.sh | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 1f35e55..7480d6e 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -11,6 +11,16 @@ tree, index, and tree objects.
 
 . ./test-lib.sh
 
+HT='	'
+
+echo 2>/dev/null > "Name with an${HT}HT"
+if ! test -f "Name with an${HT}HT"
+then
+	# since FAT/NTFS does not allow tabs in filenames, skip this test
+	skip_all='Your filesystem does not allow tabs in filenames'
+	test_done
+fi
+
 p0='no-funny'
 p1='tabs	," (dq) and spaces'
 p2='just space'
@@ -23,21 +33,9 @@ test_expect_success 'setup' '
 	EOF
 
 	{ cat "$p0" >"$p1" || :; } &&
-	{ echo "Foo Bar Baz" >"$p2" || :; } &&
-
-	if test -f "$p1" && cmp "$p0" "$p1"
-	then
-		test_set_prereq TABS_IN_FILENAMES
-	fi
+	{ echo "Foo Bar Baz" >"$p2" || :; }
 '
 
-if ! test_have_prereq TABS_IN_FILENAMES
-then
-	# since FAT/NTFS does not allow tabs in filenames, skip this test
-	skip_all='Your filesystem does not allow tabs in filenames'
-	test_done
-fi
-
 test_expect_success 'setup: populate index and tree' '
 	git update-index --add "$p0" "$p2" &&
 	t0=$(git write-tree)
-- 
1.7.12
