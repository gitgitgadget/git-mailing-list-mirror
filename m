Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBA4C678D5
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 22:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCDWAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 17:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDWAq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 17:00:46 -0500
X-Greylist: delayed 2299 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Mar 2023 14:00:42 PST
Received: from lucy.dinwoodie.org (lucy.dinwoodie.org [IPv6:2001:8b0:de15:20ad:6beb:fd8f:c6fd:d1ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD7EFB4
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 14:00:42 -0800 (PST)
Received: from adam by lucy.dinwoodie.org with local (Exim 4.96)
        (envelope-from <adam@dinwoodie.org>)
        id 1pYZKe-000QHZ-2b;
        Sat, 04 Mar 2023 21:22:20 +0000
Date:   Sat, 4 Mar 2023 21:22:20 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] test-lib: allow storing counts with test harnesses
Message-ID: <20230304212220.qkzc2joco5xj7d4s@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224225200.1027806-1-adam@dinwoodie.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, test result files are only stored in test-results/*.counts if
$HARNESS_ACTIVE is not set.  This dates from 8ef1abe550 (test-lib: Don't
write test-results when HARNESS_ACTIVE, 2010-08-11), where the
assumption was that if someone were using a test harness like prove,
that would track results and the count files wouldn't be required.
However, as of 49da404070 (test-lib: show missing prereq summary,
2021-11-20), those files also store the list of git test prerequisites
that were missing during the test run, which isn't something that a
generic test harness like prove can provide.

To allow folk using test harnesses to access the lists of missing
prerequisites, add a --counts argument to test-lib that will keep these
counts files even if a test harness is in use.  This means that a
subsequent call of, say, `make -C t aggregate-results` will report
useful information.

It might be preferable to do make a wider-ranging change, including
storing the missing prerequisites separately from the count files, so
the results can be reported regardless of whether the success/failure
counts are wanted, but that would be more disruptive and more work for
relatively little gain.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

I submitted this as an RFC back in December, and received no comments,
so I'm submitting this as an actual patch now.  My key concern was the
final paragraph above -- embedding using the "count" files for something
other than counts -- but I've mostly convinced myself that refactoring
this code to separate that out is unlikely to actually cause significant
pain.

 t/test-lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6db377f68b..bbd9ee0e34 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -157,6 +157,8 @@ parse_option () {
 	local opt="$1"
 
 	case "$opt" in
+	-c|--c|--co|--cou|--coun|--count|--counts)
+		record_counts=t ;;
 	-d|--d|--de|--deb|--debu|--debug)
 		debug=t ;;
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
@@ -1282,7 +1284,7 @@ test_done () {
 
 	finalize_test_output
 
-	if test -z "$HARNESS_ACTIVE"
+	if test -z "$HARNESS_ACTIVE" || test -n "$record_counts"
 	then
 		mkdir -p "$TEST_RESULTS_DIR"
 
