From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Wed, 25 Jul 2012 20:07:05 +0100
Message-ID: <501043D9.70604@ramsay1.demon.co.uk>
References: <500AEB11.4050006@ramsay1.demon.co.uk> <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk> <7veho1exu6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 21:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su7Zv-0005sH-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 21:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab2GYTsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 15:48:55 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:43396 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752403Ab2GYTsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 15:48:53 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 940EBA0C081;
	Wed, 25 Jul 2012 20:48:52 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 4AB52A0C07F;	Wed, 25 Jul 2012 20:48:51 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Wed, 25 Jul 2012 20:48:50 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7veho1exu6.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202189>

Junio C Hamano wrote:
[...]
> As I am more worried about longer-term health of the codebase, what
> the part you moved outside test_expect_* with this patch happens to
> do _right now_ is of secondary importance, at least from my point of
> view.  The next patch that updates this scirpt may want to run more
> involved commands that can fail in different ways.
> 
> Being able to rely on the protection test_expect_* gives us in the
> set-up phase of the test has been very valuable (in addition to
> making the result more readable) to us.  Can we keep that property
> in some way while also keeping the ability to skip the remainder of
> the test script?
> 
> Observing that all well-written test scripts we have begin with this
> boilerplate line:
> 
> 	test_expect_success setup '
> 
> I wouldn't mind introducing a new helper function test_setup that
> behaves like test_expect_success but is meant to be used in the
> first "set-up" phase of the tests in a test script. Perhaps we can
> give its failure a meaning different than failures in other normal
> tests (e.g. "even set-up fails, and the remainder of the test is N/A
> here, hence abort the whole thing"), and do not count "test_setup"
> as part of the test (i.e. do not increment $test_count and friends).

Heh, I did exactly this (except mine was called test_fixture) as part
of my first (abandoned) attempt to address this problem. :-D

I've attached the patch below, just for discussion.

I didn't test it very much, but it seems to work with a superficial
workout:

    $ cd t
    $ ./t3300-funny-names.sh
    # passed all 0 test(s)
    1..0 # SKIP Your filesystem does not allow tabs in filenames
    $

    $ ./t3300-funny-names.sh -v
    Initialized empty Git repository in /home/ramsay/git/t/trash directory.t3300-fun
    ny-names/.git/
    test fixture:
            cat >"$p0" <<-\EOF &&
            1. A quick brown fox jumps over the lazy cat, oops dog.
            2. A quick brown fox jumps over the lazy cat, oops dog.
            3. A quick brown fox jumps over the lazy cat, oops dog.
            EOF

            { cat "$p0" >"$p1" || :; } &&
            { echo "Foo Bar Baz" >"$p2" || :; } &&

            if test -f "$p1" && cmp "$p0" "$p1"
            then
                    test_set_prereq TABS_IN_FILENAMES
            fi

    ./test-lib.sh: line 274: tabs   ," (dq) and spaces: No such file or directory

    # passed all 0 test(s)
    1..0 # SKIP Your filesystem does not allow tabs in filenames
    $

    $ prove --exec sh t3300-funny-names.sh
    t3300-funny-names.sh .. skipped: Your filesystem does not allow tabs in filename
    s
    Files=1, Tests=0,  1 wallclock secs ( 0.03 usr  0.05 sys +  0.87 cusr  0.41 csys
     =  1.36 CPU)
    Result: NOTESTS
    $

So why did I abandon this patch? Well, I didn't really; I just decided
that I needed *much* more time to polish[1] 'test_fixture'. I wanted to
fix the "TAP parse error" problem before v1.7.12-rc0! :(

HTH

ATB,
Ramsay Jones

[1] For example, what should/will happen if someone uses test_must_fail,
test_might_fail, etc., within the test_fixture script? Should they simply
be banned within a text_fixture?

--- >8 ---
Subject: [PATCH] test-lib-functions.sh: Add a test_fixture function


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t3300-funny-names.sh  |  2 +-
 t/test-lib-functions.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 1f35e55..59331a0 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -15,7 +15,7 @@ p0='no-funny'
 p1='tabs	," (dq) and spaces'
 p2='just space'
 
-test_expect_success 'setup' '
+test_fixture '
 	cat >"$p0" <<-\EOF &&
 	1. A quick brown fox jumps over the lazy cat, oops dog.
 	2. A quick brown fox jumps over the lazy cat, oops dog.
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80daaca..b70c963 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -302,6 +302,17 @@ test_expect_success () {
 	echo >&3 ""
 }
 
+test_fixture () {
+	test "$#" = 1 ||
+	error "bug in test script: must be single argument to test_fixture"
+	say >&3 "test fixture: $1"
+	if ! test_run_ "$1"
+	then
+		error "failure in test_fixture code"
+	fi
+	echo >&3 ""
+}
+
 # test_external runs external test scripts that provide continuous
 # test output about their progress, and succeeds/fails on
 # zero/non-zero exit code.  It outputs the test output on stdout even
-- 
1.7.11.2
