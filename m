Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789B4203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935330AbcKKUdt (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:33:49 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:54036 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934523AbcKKUds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:33:48 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.105])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3tFrxV3KZlz5twh
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 21:24:46 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFrxT2CY7z5tlB;
        Fri, 11 Nov 2016 21:24:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 51DCB145;
        Fri, 11 Nov 2016 21:24:44 +0100 (CET)
Subject: [PATCH v2] t6026: ensure that long-running script really is
To:     Jeff King <peff@peff.net>
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
 <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
 <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
 <20161111084148.tgtsijn74z2pdylq@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Andreas Schwab <schwab@suse.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6a421222-a138-5647-4965-8ede24d904b2@kdbg.org>
Date:   Fri, 11 Nov 2016 21:24:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161111084148.tgtsijn74z2pdylq@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When making sure that background tasks are cleaned up in 5babb5b
(t6026-merge-attr: clean up background process at end of test case,
2016-09-07), we considered to let the background task sleep longer, just
to be certain that it will still be running when we want to kill it
after the test.

Sadly, the assumption appears not to hold true that the test case passes
quickly enough to kill the background task within a second.

Simply increase it to an hour. No system can be possibly slow enough to
make above-mentioned assumption incorrect.

Reported by Andreas Schwab.  In-code comments by J6t.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 11.11.2016 um 09:41 schrieb Jeff King:
> But the other thing the "kill" is doing is make sure we clean up after
> ourselves, even if another part of the test fails.

Good point. Here is an updated version.

If the pid file is not created, the kill command receives no
arguments. Here on Linux, it reports failure in this case.
This is good. I could have said

   test_when_finished "kill \"\$(cat sleep.pid)\""

but that is a bit too much quoting for my taste when it is
not strictly necessary.

 t/t6026-merge-attr.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 7a6e33e673..8f9b48a493 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -183,16 +183,24 @@ test_expect_success 'up-to-date merge without common ancestor' '
 
 test_expect_success 'custom merge does not lock index' '
 	git reset --hard anchor &&
-	write_script sleep-one-second.sh <<-\EOF &&
-		sleep 1 &
+	write_script sleep-an-hour.sh <<-\EOF &&
+		sleep 3600 &
 		echo $! >sleep.pid
 	EOF
-	test_when_finished "kill \$(cat sleep.pid)" &&
 
 	test_write_lines >.gitattributes \
-		"* merge=ours" "text merge=sleep-one-second" &&
+		"* merge=ours" "text merge=sleep-an-hour" &&
 	test_config merge.ours.driver true &&
-	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
+	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
+
+	# We are testing that the custom merge driver does not block
+	# index.lock on Windows due to an inherited file handle.
+	# To ensure that the backgrounded process ran sufficiently
+	# long (and has been started in the first place), we do not
+	# ignore the result of the kill command.
+	# By packaging the command in test_when_finished, we get both
+	# the correctness check and the clean-up.
+	test_when_finished "kill \$(cat sleep.pid)" &&
 	git merge master
 '
 
-- 
2.11.0.rc0.55.gd967357

