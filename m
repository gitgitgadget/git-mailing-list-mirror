Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAFB1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934111AbcIETDv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:03:51 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:26806 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933391AbcIETDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 15:03:51 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sSfK05ftVz5tlD;
        Mon,  5 Sep 2016 21:03:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 64635523B;
        Mon,  5 Sep 2016 21:03:48 +0200 (CEST)
Cc:     Git Mailing List <git@vger.kernel.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t6026-merge-attr: wait for process to release trash directory
Message-ID: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
Date:   Mon, 5 Sep 2016 21:03:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The process spawned in the hook uses the test's trash directory as CWD.
As long as it is alive, the directory cannot be removed on Windows.
Although the test succeeds, the 'test_done' that follows produces an
error message and leaves the trash directory around. Insert a delay to
give the hook time to go away.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t6026-merge-attr.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index dd8f88d..2c5b138 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -191,7 +191,10 @@ test_expect_success 'custom merge does not lock index' '
 		"* merge=ours" "text merge=sleep-one-second" &&
 	test_config merge.ours.driver true &&
 	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
-	git merge master
+	git merge master &&
+	# the trash directory cannot be removed on Windows until the hook
+	# does not occupy it for its CWD anymore; wait for it to quit:
+	sleep 1
 '
 
 test_done
-- 
2.10.0.85.gea34e30

