Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADCB1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 06:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbcIGGKp (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 02:10:45 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:57698 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbcIGGKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 02:10:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sTY42557cz5tlY;
        Wed,  7 Sep 2016 08:10:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 99F795148;
        Wed,  7 Sep 2016 08:10:41 +0200 (CEST)
Subject: [PATCH v2] t6026-merge-attr: clean up background process at end of
 test case
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
 <alpine.DEB.2.20.1609060909420.129229@virtualbox>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1953cc16-7577-16dd-fe7e-f557e7a74f58@kdbg.org>
Date:   Wed, 7 Sep 2016 08:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609060909420.129229@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The process spawned in the hook uses the test's trash directory as CWD.
As long as it is alive, the directory cannot be removed on Windows.
Although the test succeeds, the 'test_done' that follows produces an
error message and leaves the trash directory around. Kill the process
before the test case advances.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 06.09.2016 um 09:25 schrieb Johannes Schindelin:
> Maybe we should write a pid file in the sleep command instead, and kill it
> in the end? Something like this, maybe?

Yes, that is much better, thank you!

I did not extend the sleep time because it requires to change the file name
in the same patch.

I did experiment with 'while sleep 1; do :; done &' to spin indefinitely,
but the loop did not terminate in time in my tests on Windows for some
unknown reason (most likely because the killed process does not exit with
a non-zero code -- remember, Windows is not POSIX, particularly, when it
comes to signal handling).

t/t6026-merge-attr.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index dd8f88d..7a6e33e 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -185,7 +185,9 @@ test_expect_success 'custom merge does not lock index' '
 	git reset --hard anchor &&
 	write_script sleep-one-second.sh <<-\EOF &&
 		sleep 1 &
+		echo $! >sleep.pid
 	EOF
+	test_when_finished "kill \$(cat sleep.pid)" &&
 
 	test_write_lines >.gitattributes \
 		"* merge=ours" "text merge=sleep-one-second" &&
-- 
2.10.0.85.gea34e30

