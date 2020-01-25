Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A271C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F362077C
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="obQEVYEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAYXAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46844 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbgAYXAu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:50 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EEC9461471;
        Sat, 25 Jan 2020 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993249;
        bh=Y7kJpbQwjoMAfH3zbNksxZJsfsrGPg2xO3iFh85F+GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=obQEVYEQjra/SeiKtG5ydRB/px0IK6Z/JRjXOT+s6r8YDjfpxoJHdt4xW8Hh57oqY
         QgvFGmuse7vj4p5EffMKjzzDyZzzdBTUztSV7ulO0tK8WSagTA0CLZ+2AkN4zFlt/s
         qsE51EHuLsTv3LPsldtWpRGmJ7jDcRsZXPuGc148xJH+7y2aTHBYam9J6jjN+ki6w0
         9I9ZVQFedoi/Lwmy/1kr1BDdkJUaLmVJnoMvk0ZlBt1PoNfQ26VOOx5nPxNMzYdEOL
         eDDNoI+jrbUWKRXahdaVPO02/yYQv2xJ+/n9SahhDJ9ba104zaOVKeQZw+VQWF0vfT
         V562o8xJkvAenfAG1B/hP+M9RvoqF9jNra33EUXdRS6t8SJyTvrU0q8w3POBFYEpPe
         /twW4Hki/k1lrds9xkhYvM9Ygpaab79OV+wGU4l0MwQGhmbV4FOEYsmNGd8bXIVPAJ
         WJiyGJRU+bNsGOX19gemBK/zwcISCQkxKKSOolDGDY+R6vQmeqV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 17/23] t5616: use correct filter syntax
Date:   Sat, 25 Jan 2020 23:00:24 +0000
Message-Id: <20200125230035.136348-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the setup steps for the promisor remote tests, we clone a repository
and filter out all trees with depth greater than or equal to zero, which
also filters out all blobs.

With SHA-1, this test passes because the object we happen to request
from the server is the blob that the promisor remote has.  However, due
to a different ordering with SHA-256, we request the tree containing
that blob, which the promisor remote does not have.  As a consequence,
we fail with a "not our ref" error.

Since what we want to test is that the blob is transferred, let's adjust
the filter to just filter out blobs, not trees.  That means that we'll
transfer the previously problematic tree as part of the normal clone,
and we can then test that the blob is fetched from the promisor remote
as expected.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5616-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index fea56cda6d..9fd6e780f9 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -317,7 +317,7 @@ setup_triangle () {
 	cp big-blob.txt server &&
 	git -C server add big-blob.txt &&
 	git -C server commit -m "initial" &&
-	git clone --bare --filter=tree:0 "file://$(pwd)/server" client &&
+	git clone --bare --filter=blob:none "file://$(pwd)/server" client &&
 	echo another line >>server/big-blob.txt &&
 	git -C server commit -am "append line to big blob" &&
 
