Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C741FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbdDCSxm (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 14:53:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:36328 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbdDCSxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 14:53:41 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DF45B84648;
        Mon,  3 Apr 2017 14:53:24 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 3/4] t1450-fsck: test core.checksumindex
Date:   Mon,  3 Apr 2017 18:53:05 +0000
Message-Id: <20170403185306.36164-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170403185306.36164-1-git@jeffhostetler.com>
References: <20170403185306.36164-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add test for fsck to force verify the index checksum.
Add test to demonstrate that status does ignore the checksum
when reading the index.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t1450-fsck.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 33a51c9..a33d542 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -689,4 +689,31 @@ test_expect_success 'bogus head does not fallback to all heads' '
 	! grep $blob out
 '
 
+test_expect_success 'validate force_core_checksum_index=1' '
+	git fsck --cache
+'
+
+test_expect_success PERL 'detect index file corrupt in fsck' '
+	cp .git/index .git/index.backup &&
+	echo zzzzzzzz >zzzzzzzz &&
+	git add zzzzzzzz &&
+	perl -pi -e "s/zzzzzzzz/yyyyyyyy/" .git/index &&
+	test_must_fail git fsck --cache &&
+	rm .git/index &&
+	mv .git/index.backup .git/index &&
+	rm zzzzzzzz
+'
+
+test_expect_success PERL 'verify status ignores corrupt checksum' '
+	cp .git/index .git/index.backup &&
+	echo zzzzzzzz >zzzzzzzz &&
+	git add zzzzzzzz &&
+	perl -pi -e "s/zzzzzzzz/yyyyyyyy/" .git/index &&
+	git -c core.checksumindex=0 status &&
+	# Status may fix the checksum
+	rm .git/index &&
+	mv .git/index.backup .git/index &&
+	rm zzzzzzzz
+'
+
 test_done
-- 
2.9.3

