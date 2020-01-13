Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E58C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E879E20678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eIB2kMRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgAMMky (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37692 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728712AbgAMMkn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:43 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02A4160803;
        Mon, 13 Jan 2020 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919241;
        bh=Y7kJpbQwjoMAfH3zbNksxZJsfsrGPg2xO3iFh85F+GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=eIB2kMRMt4+s4AJyqkj/ERt+lUnoKHrWkND1uXa9DbdPYzzboMbFu78+Qmm4pVoSp
         iZmz1maWr1jSO40hOzMHV4+RC9V4uuWomZXDYgOFmhR8fKRH3nM7YDWmUp6ZgeFBO0
         WWmxwTZweMTrOfQPfWOZzavkUe0okMjP3x7jefQb046j6xmC9VUePkjgVxa3f58Bqg
         OPe/pySpFE/D9k1XmMyYnOBHPX3IbjWOiLBv2hOZ/dHwO5ElEVra4LZ2+M+3D2ML1v
         Rev2GRToFZioaU8sa/ERfho8zWZuxwUG9AqZoZ3c0YWU4t1fjaLvJRDWQVriAEHpeF
         7tKaAnPQYOrT4zigM2afKJJRbvkm/emoRmh4XMkS5Z5vHAJtaHWK0V+lZyfmmG8Wlm
         lLmxHugjAZuusiH6CWg0Fs7Lw2KH6gBwd3QkMxvRw0fg4dPM8AItx7+NbzL1a8LHSC
         FkNNe2SslHsgrohowYbB+BAsh/3M6UsNiE0f69A/rixsgdNeidn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 18/24] t5616: use correct filter syntax
Date:   Mon, 13 Jan 2020 12:38:51 +0000
Message-Id: <20200113123857.3684632-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
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
 
