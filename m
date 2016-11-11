Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE48C203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 06:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbcKKGuS (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 01:50:18 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:14657 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934023AbcKKGuS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 01:50:18 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFVsg3lrRz5tlJ;
        Fri, 11 Nov 2016 07:50:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BD2BB36B;
        Fri, 11 Nov 2016 07:50:14 +0100 (CET)
Subject: Re: [PATCH] t6026: ensure that long-running script really is
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
 <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas Schwab <schwab@suse.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
Date:   Fri, 11 Nov 2016 07:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.2016 um 00:53 schrieb Junio C Hamano:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> When making sure that background tasks are cleaned up in 5babb5b
>> (t6026-merge-attr: clean up background process at end of test case,
>> 2016-09-07), we considered to let the background task sleep longer, just
>> to be certain that it will still be running when we want to kill it
>> after the test.
>>
>> Sadly, the assumption appears not to hold true that the test case passes
>> quickly enough to kill the background task within a second.
>>
>> Simply increase it to an hour. No system can be possibly slow enough to
>> make above-mentioned assumption incorrect.
>>
>> Reported by Andreas Schwab.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> Published-As: https://github.com/dscho/git/releases/tag/t6026-sleep-v1
>> Fetch-It-Via: git fetch https://github.com/dscho/git t6026-sleep-v1
> 
> OK, I think this is a much better option.  Assuming 3600 is long
> enough for everybody (and if not, we have a bigger problem ;-),
> it will ensure that the stray process will be around when we run the
> 'git merge' test, and by not adding "|| :" after the kill, we check
> that the stray process is still there, i.e. we tested what we wanted
> to test.
> 
> Will revert the two patches that were queued previously and then
> queue this one.

Shouldn't we then move the 'kill' out of test_when_finished and make
it a proper condition of the test? Like this?

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 348d78b205..6ad8bd098a 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -187,13 +187,19 @@ test_expect_success 'custom merge does not lock index' '
 		sleep 3600 &
 		echo $! >sleep.pid
 	EOF
-	test_when_finished "kill \$(cat sleep.pid)" &&
 
 	test_write_lines >.gitattributes \
 		"* merge=ours" "text merge=sleep-an-hour" &&
 	test_config merge.ours.driver true &&
 	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
-	git merge master
+	git merge master &&
+
+	# We are testing that the custom merge driver does not block
+	# index.lock on Windows due to an inherited file handle.
+	# To ensure that this test checks this condition, the process
+	# must still be running at this point (and must have started
+	# in the first place), hence, this kill must not fail:
+	kill "$(cat sleep.pid)"
 '
 
 test_done

