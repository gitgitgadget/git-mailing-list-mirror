Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2547C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA50A6138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhKRQw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6FE70218E0
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axs7WhdHHsiDyTEbW534DheU46cT8sLHfTiC7IkGEQQ=;
        b=EU5WoHg9wsiaXHCtzgEld6VPz2eNKNsYSyHuo9xYsfxD5PeNhLpzo8VroqV2ULWwr/lUer
        +7hblE2pQLznAh8QCzb/PkK68rVweO3UP2/WMZ2qE/65c/muwb7PNcqwIn6ia4vVB8qcC9
        AgraGdpRn7si/tBVRehVqAJ+8VFy4gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axs7WhdHHsiDyTEbW534DheU46cT8sLHfTiC7IkGEQQ=;
        b=paAx3ytsphJ0xIN7Cmk7rCyqPsbGTF42dKxdWE3oUnwIMThYjP0w+srNHyDBuH35ppQQdL
        Hq9q2FBJScEjfeBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 604B6A3B8F;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8E78A1F2CA8; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 09/27] bisect: Fixup bisect-porcelain/54
Date:   Thu, 18 Nov 2021 17:49:22 +0100
Message-Id: <20211118164940.8818-10-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 54 from t6030-bisect-porcelain.sh assumes that bisection algorithm
suggests BROKEN_HASH8 as the second bisection point when BROKEN_HASH7 is
an equivalent choice. Fix the test to work in both cases.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 79f253f01b00..46d67929e1e5 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -743,7 +743,11 @@ test_expect_success 'bisect: --no-checkout - target after breakage' '
 	git bisect start broken BROKEN_HASH4 --no-checkout &&
 	check_same BROKEN_HASH6 BISECT_HEAD &&
 	git bisect good BISECT_HEAD &&
-	check_same BROKEN_HASH8 BISECT_HEAD &&
+	check_oneof BISECT_HEAD BROKEN_HASH7 BROKEN_HASH8 &&
+	if check_same BROKEN_HASH7 BISECT_HEAD; then
+		git bisect good BISECT_HEAD &&
+		check_same BROKEN_HASH8 BISECT_HEAD
+	fi &&
 	test_must_fail git bisect good BISECT_HEAD &&
 	check_same BROKEN_HASH9 bisect/bad &&
 	git bisect reset
-- 
2.26.2

