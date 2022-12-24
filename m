Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A193C4332F
	for <git@archiver.kernel.org>; Sat, 24 Dec 2022 23:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLXXJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 18:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXXJM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 18:09:12 -0500
X-Greylist: delayed 1006 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Dec 2022 15:09:09 PST
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BFE64CE
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 15:09:09 -0800 (PST)
Received: from c.a.1.d.d.f.6.c.f.8.d.f.b.e.b.6.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:de15:20ad:6beb:fd8f:c6fd:d1ac] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@lucy.dinwoodie.org>)
        id 1p9DNM-0002it-HQ; Sat, 24 Dec 2022 22:52:20 +0000
Received: from adam by lucy.dinwoodie.org with local (Exim 4.96)
        (envelope-from <adam@lucy.dinwoodie.org>)
        id 1p9DNL-004JQt-1g;
        Sat, 24 Dec 2022 22:52:19 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH] test-lib: allow storing counts with test harnesses
Date:   Sat, 24 Dec 2022 22:52:00 +0000
Message-Id: <20221224225200.1027806-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The key reason I'm submitting this as an RFC is that last paragraph:
I've tested the below patch, and it achieves what I'm after (letting me
both use prove and audit missing prerequisites), but it further embeds
the use of the "count" files for recording missing prerequisites, where
it might be preferable to do something a bit more complex that treats
the prerequisite reporting as a separate function, rather than a bolt-on
to the pass/fail/etc. counts.

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
 
-- 
2.39.0

