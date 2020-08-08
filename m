Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C68EC433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9D20866
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="cDMfa3sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgHHH6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:58:50 -0400
Received: from out1.migadu.com ([91.121.223.63]:17710 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgHHH6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 03:58:49 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596873527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVWNx3fdBxUBeWUrFIgMhscwelvmKDW5JYcfTvmBoPY=;
        b=cDMfa3sCDTJVK+K7QsxsbrHSys9nXbPghhs7NXDl8TFc+ZNyBG99UIl61sYQ+N8S3xqm+J
        ajs16L5X6FM2/dxuP2u42OYQZJZTVCQJxxCCRZJPpBeIV10YXsr0XS00Nz1EdFJsvuleBy
        PM3L3XrYJN1TOiScFsfHh8VoEg3ZnKo=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [HYPOTHETICAL PATCH 2/2] t4140: test failure of diff from empty blob to i-t-a path
Date:   Sat,  8 Aug 2020 03:58:27 -0400
Message-Id: <20200808075827.36248-3-ray@ameretat.dev>
In-Reply-To: <20200808075827.36248-1-ray@ameretat.dev>
References: <20200806060119.74587-1-ray@ameretat.dev>
 <20200808075827.36248-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git apply" should only accept new file or deleted file patches to an
i-t-a index entry.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 t/t4140-apply-ita.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index c614eaf04c..898dd251b4 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -14,7 +14,13 @@ test_expect_success setup '
 
 	rm -f test-file &&
 	git diff >deletion-patch &&
-	grep "deleted file mode 100644" deletion-patch
+	grep "deleted file mode 100644" deletion-patch &&
+
+	git rm -f test-file &&
+	touch test-file &&
+	git add test-file &&
+	cat blueprint >test-file &&
+	git diff >incorrect-patch
 '
 
 test_expect_success 'apply creation patch to ita path (--cached)' '
@@ -27,6 +33,14 @@ test_expect_success 'apply creation patch to ita path (--cached)' '
 	test_cmp blueprint actual
 '
 
+test_expect_success 'apply diff from empty blob to ita path (--cached)' '
+	git rm -f test-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+
+	test_must_fail git apply --cached incorrect-patch
+'
+
 test_expect_success 'apply creation patch to ita path (--index)' '
 	git rm -f test-file &&
 	cat blueprint >test-file &&
-- 
2.28.0.5.gfc8e108108

