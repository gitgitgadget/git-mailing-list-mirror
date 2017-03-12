Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01C6202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 13:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755755AbdCLNpJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 09:45:09 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:49522 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755742AbdCLNpI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 09:45:08 -0400
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v2CDivAq015795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2017 13:44:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v2CDiuWj020478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2017 13:44:56 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v2CDit2B021196;
        Sun, 12 Mar 2017 13:44:55 GMT
Received: from [10.175.254.140] (/10.175.254.140)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Mar 2017 06:44:55 -0700
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
 <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
 <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <8fb54c74-a5a5-eb55-8734-61a3753c05e1@oracle.com>
Date:   Sun, 12 Mar 2017 14:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net>
Content-Type: multipart/mixed;
 boundary="------------F8267D6937767EA4CFFA6045"
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------F8267D6937767EA4CFFA6045
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2017 13:32, Jeff King wrote:
> If people really _do_ care about coverage, arguably the AFL tests are a
> pollution of that concept. Because they are running the code, but doing
> a very perfunctory job of testing it. IOW, our coverage of "code that
> doesn't segfault or trigger ASAN" is improved, but our coverage of "code
> that has been tested to be correct" is not (and since the tests are
> lumped together, it's hard to get anything but one number).

It wouldn't be hard to separate out the testcases found by fuzzing
I've attached a patch that does just that -- none of the new testcases
are run unless you pass -f/--fuzzing in GIT_TEST_OPTS.

$ make -C t GIT_TEST_OPTS="--run=34" t5300-pack-object.sh
make: Entering directory '/home/vegard/git/git/t'
*** t5300-pack-object.sh ***
[...]
ok 34 # skip index-pack edge coverage (missing FUZZING)
[...]

$ make -C t GIT_TEST_OPTS="--run=34 -f" t5300-pack-object.sh
make: Entering directory '/home/vegard/git/git/t'
*** t5300-pack-object.sh ***
[...]
ok 34 - index-pack edge coverage
[...]

I assume automatic testing like e.g. Travis would want to enable this.

Would that help at all?


Vegard

--------------F8267D6937767EA4CFFA6045
Content-Type: text/x-patch;
 name="0001-test-lib-add-fuzzing-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-test-lib-add-fuzzing-option.patch"

From 04446ce562eee129588f2c92c4eef2c82ed4bb4f Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Sun, 12 Mar 2017 14:35:25 +0100
Subject: [PATCH] test-lib: add --fuzzing option

From t/README:

	This causes additional testcases found by fuzzing to be run,
	for more exhaustive testing. Please note that these testcases
	have not been vetted for correctness, but they may uncover
	bugs introduced in code paths which are not otherwise run
	in other tests.

The -f/--fuzzing/FUZZING name is up for discussion, I just couldn't think
of anything more descriptive.
---
 t/README               | 8 ++++++++
 t/t5300-pack-object.sh | 2 +-
 t/test-lib.sh          | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 4982d1c52..2c56567b1 100644
--- a/t/README
+++ b/t/README
@@ -110,6 +110,14 @@ appropriately before running "make".
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
+-f::
+--fuzzing::
+	This causes additional testcases found by fuzzing to be run,
+	for more exhaustive testing. Please note that these testcases
+	have not been vetted for correctness, but they may uncover
+	bugs introduced in code paths which are not otherwise run
+	in other tests.
+
 -r::
 --run=<test-selector>::
 	Run only the subset of tests indicated by
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 19e02ffc2..f58d0d4bf 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -422,7 +422,7 @@ test_expect_success 'index-pack <pack> works in non-repo' '
 '
 
 # These pack files were generated using AFL
-test_expect_success 'index-pack edge coverage' '
+test_expect_success FUZZING 'index-pack edge coverage' '
 	for pack in "$TEST_DIRECTORY"/t5300/*.pack
 	do
 		rm -rf "${pack%.pack}.idx" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 86d77c16d..35df2bd6c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -209,6 +209,8 @@ do
 		immediate=t; shift ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
 		GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
+	-f|--f|--fuzzing)
+		GIT_TEST_FUZZING=t; export GIT_TEST_FUZZING; shift ;;
 	-r)
 		shift; test "$#" -ne 0 || {
 			echo 'error: -r requires an argument' >&2;
@@ -1098,6 +1100,10 @@ test_lazy_prereq EXPENSIVE '
 	test -n "$GIT_TEST_LONG"
 '
 
+test_lazy_prereq FUZZING '
+	test -n "$GIT_TEST_FUZZING"
+'
+
 test_lazy_prereq USR_BIN_TIME '
 	test -x /usr/bin/time
 '
-- 
2.12.0.rc0


--------------F8267D6937767EA4CFFA6045--
