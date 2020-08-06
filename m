Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480B8C43457
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3474922D05
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="xT4uH2y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHFGB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:01:58 -0400
Received: from out0.migadu.com ([94.23.1.103]:34854 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgHFGBz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 02:01:55 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596693713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+tmuT1szU3pxeSptWRo2Hv/j0RZfmkjx5br/wKhJnwk=;
        b=xT4uH2y9+O6EYDS+HiOdsSrenLGd/kxQS1zWFIjc+4aMjTjMKtKAM/vosstU37MRFHHNOk
        lqju4C7Kn3F/tO3sxtIqBEe4GVMGX3s0jsN2zHq/pDhoJkR55DB9XbNsrgp4+6Rl9nm7qD
        9KX6BQbIbPHUSik2sTi/tYKgfl2/gFs=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH v4 3/3] t4140: test apply with i-t-a paths
Date:   Thu,  6 Aug 2020 02:01:19 -0400
Message-Id: <20200806060119.74587-4-ray@ameretat.dev>
In-Reply-To: <20200806060119.74587-1-ray@ameretat.dev>
References: <C4ON23BIKMVK.2ZESQJ1FB5PVA@ziyou.local>
 <20200806060119.74587-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

apply --cached (as used by add -p) should accept creation and deletion
patches to intent-to-add paths in the index. apply --index, however,
should always fail because an intent-to-add path never matches the
worktree (by definition).

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 t/t4140-apply-ita.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 t/t4140-apply-ita.sh

diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
new file mode 100644
index 0000000000..c614eaf04c
--- /dev/null
+++ b/t/t4140-apply-ita.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='git apply of i-t-a file'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_write_lines 1 2 3 4 5 >blueprint &&
+
+	cat blueprint >test-file &&
+	git add -N test-file &&
+	git diff >creation-patch &&
+	grep "new file mode 100644" creation-patch &&
+
+	rm -f test-file &&
+	git diff >deletion-patch &&
+	grep "deleted file mode 100644" deletion-patch
+'
+
+test_expect_success 'apply creation patch to ita path (--cached)' '
+	git rm -f test-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+
+	git apply --cached creation-patch &&
+	git cat-file blob :test-file >actual &&
+	test_cmp blueprint actual
+'
+
+test_expect_success 'apply creation patch to ita path (--index)' '
+	git rm -f test-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+	rm -f test-file &&
+
+	test_must_fail git apply --index creation-patch
+'
+
+test_expect_success 'apply deletion patch to ita path (--cached)' '
+	git rm -f test-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+
+	git apply --cached deletion-patch &&
+	test_must_fail git ls-files --stage --error-unmatch test-file
+'
+
+test_expect_success 'apply deletion patch to ita path (--index)' '
+	cat blueprint >test-file &&
+	git add -N test-file &&
+
+	test_must_fail git apply --index deletion-patch &&
+	git ls-files --stage --error-unmatch test-file
+'
+
+test_done
-- 
2.28.0.2.g72bf77540a.dirty

