Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B1C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE58720734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 08:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="smGsUxTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHJIye (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 04:54:34 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8EC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 01:54:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597049668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jluLYTLzPpU4xHKfNDi1aIMqi+u/8Iwo4KynkBdiqAM=;
        b=smGsUxTOhTZDgznVn5lgiLZlZ4m/8DbUcg6w/bpC28mTsnXn4vtyyOCHdrXZ4Srp7g/eS+
        VbBdU3DgR+z7sGwv0rDCj48O3a6uaC9v307n7FLSDBc0Jv2dm/8LsR9c2c7NB0KwJcTkdI
        Lu7SiRC1F3bzgml4pICg8FntDeMek6o=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH] t4069: test diff behavior with i-t-a paths
Date:   Mon, 10 Aug 2020 04:53:43 -0400
Message-Id: <20200810085343.43717-1-ray@ameretat.dev>
In-Reply-To: <20200808075323.36041-1-ray@ameretat.dev>
References: <20200808075323.36041-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a small test suite to test the behavior of diff with intent-to-add
paths. Specifically, the diff between an i-t-a entry and a file in the
worktree should be a "new file" diff, and the diff between an i-t-a
entry and no file in the worktree should be a "deleted file" diff.
However, if --ita-visible-in-index is passed, the former should instead
be a diff from the empty blob.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 t/t4069-diff-intent-to-add.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 t/t4069-diff-intent-to-add.sh

diff --git a/t/t4069-diff-intent-to-add.sh b/t/t4069-diff-intent-to-add.sh
new file mode 100644
index 0000000000..85c1a35ca7
--- /dev/null
+++ b/t/t4069-diff-intent-to-add.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='behavior of diff with intent-to-add entries'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_write_lines 1 2 3 4 5 >blueprint
+'
+
+test_expect_success 'diff between i-t-a and file should be new file' '
+	cat blueprint >test-file &&
+	git add -N test-file &&
+	git diff >output &&
+	grep "new file mode 100644" output
+'
+
+test_expect_success 'diff between i-t-a and no file should be deletion' '
+	rm -f test-file &&
+	git diff >output &&
+	grep "deleted file mode 100644" output
+'
+
+test_expect_success '--ita-visible-in-index diff should be from empty blob' '
+	cat blueprint >test-file &&
+	git diff --ita-visible-in-index >output &&
+	grep "index e69de29" output
+'
+
+test_done
-- 
2.28.0.3.gc4aba908ca

