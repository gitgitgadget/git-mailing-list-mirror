Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B951F1F461
	for <e@80x24.org>; Sun, 30 Jun 2019 18:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF3S51 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 14:57:27 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:5745 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfF3S51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 14:57:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45cKW811ymz5tl9;
        Sun, 30 Jun 2019 20:57:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B072237B;
        Sun, 30 Jun 2019 20:57:23 +0200 (CEST)
Subject: [PATCH] t5319: don't trip over a user name with whitespace
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
To:     Derrick Stolee <stolee@gmail.com>
Message-ID: <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
Date:   Sun, 30 Jun 2019 20:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On my Windows system where the POSIX commands are provided by MSYS2,
I observe this output:

$ ls -l Makefile
-rw-r--r-- 1 Johannes Sixt 197121 101780 Jun 30 09:33 Makefile

Notice the blank in the user name. Obviously, extracting the size
of a file by counting columns won't work. But two tests in t5319
do that. Use the stat command to print just the file size.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Notice further that the group ID is presented numerically. The
actual output used in the tests is:

-r--r--r-- 1 Johannes Sixt 197121 2239 Jan  1 01:03 .git/objects/pack/pack-A-40289997979ee9f2d7198a5b4ac9fe14e27cbe4b.pack
-r--r--r-- 1 Johannes Sixt 197121 1385 Jan  1 01:02 .git/objects/pack/pack-B-926e20b0e641003b2f6bcddd6ccf53e7741c8642.pack
-r--r--r-- 1 Johannes Sixt 197121  838 Jan  1 01:01 .git/objects/pack/pack-C-b33c048d7202659249bb0cea7bbc997ce448c75d.pack
-r--r--r-- 1 Johannes Sixt 197121  560 Jan  1 01:00 .git/objects/pack/pack-D-49ca36507a52bbba6d1768e28666eb0f4e5f7d95.pack
-r--r--r-- 1 Johannes Sixt 197121 4587 Jun 30 16:17 .git/objects/pack/pack-E-31ea0966bb15206fbfd1b4c2f5be4b24a03050f5.pack

In both tests, this group ID was passed as --batch-size, but actually
the first of the two tests does not fail.

Now I have to wonder: Why that? The test carefully attempts to extract
the smallest pack size to pass as --batch-size argument. But when it
passes some large number, the test still passes. Is this the intent?

That is, both a small and a large --batch-size satisfy 'does not alter
existing packs', but some medium sized --batch-size satisfy the next
test 'repack creates a new pack'. That is very curious.

Disclaimer: I've no clue about this multi-pack-index thing.

 t/t5319-multi-pack-index.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 79bfaeafa9..4b4d06a1c8 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
 		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
 		ls .git/objects/pack >expect &&
-		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
+		MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&
 		git multi-pack-index repack --batch-size=$MINSIZE &&
 		ls .git/objects/pack >actual &&
 		test_cmp expect actual
@@ -455,7 +455,7 @@ test_expect_success 'repack creates a new pack' '
 		cd dup &&
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 5 idx-list &&
-		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
+		THIRD_SMALLEST_SIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
 		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&
-- 
2.21.0.285.gc38d92e052

