Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F7CC4345E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DA42075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aIMx0pL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgG1Xfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730318AbgG1Xf2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3F51F60CF6;
        Tue, 28 Jul 2020 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979297;
        bh=6vdJnTtdikEyvh2eoGCAUKW9eW10Iio5RbuTQEHrp4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=aIMx0pL5tYtUC9gcFfAvio4Vk4QvK4X8zYJUb6SLZkp8YabFiwh8izQef/ltX88wI
         SdW8xJb8Z7kt6Mtc0+a8mRtOILSpQ9jcuR4MXbiVBR/PU9ADhS+PQxJ7bXlxORZC5z
         IWS+qsY4TCoNmDI/fWag9ECL39ijkRI0MyQ4f9GAuTd79KUIGtaviXjIL6a685wfLX
         /DLB/OjbWtDJ8jeKICWM0NyRD2f0UfD5otcBsJETmcVcgKMi6gpqa6W416XeXeGCqT
         OfjdHYyq0tPPec7+OD+d1hFcqtSw3ZyrtX/h++FUx3GZilOi/J3DGzjSbKJyiHUC6W
         lmNxNzX+eCCv90So58ltEd/dD7WQaYK9yYvvu0ZAN1Yn1jd54cwl3VqpBH8sbnHnc1
         1jtmAq7277eM25pYfR6MplnWdXxmSjR3dAGUYAbksbawBnb4tDOe+3ST8kWtJgdvs6
         OjM0h8LP3WSZfu0AwDGvA5FU3BioCQGNqsYS8DIafw+1yhNWv4x
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 05/39] t6100: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:12 +0000
Message-Id: <20200728233446.3066485-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a constant 40, split the output of rev-list by
field.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6100-rev-list-in-order.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
index b2bb0a7f61..e934bc239c 100755
--- a/t/t6100-rev-list-in-order.sh
+++ b/t/t6100-rev-list-in-order.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup a commit history with trees, blobs' '
 
 test_expect_success 'rev-list --in-commit-order' '
 	git rev-list --in-commit-order --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
@@ -49,7 +49,7 @@ test_expect_success 'rev-list --in-commit-order' '
 
 test_expect_success 'rev-list lists blobs and trees after commits' '
 	git rev-list --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
