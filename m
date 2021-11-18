Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF60C4332F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF846138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhKRQwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57606 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 776C11FD3C
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGwuiCS51dh/1BotnKaVyj381ZiDx17kLZxreKVQl0M=;
        b=F9ejmCO3oyihNCqgOtmLHRFweF5zm3pYzWNtmT8n24UFEOeN47Hz0F0HU+v+lVTUPOJ5Z4
        R9ca2aV9FPBoiZ3GGx97o3+tJlknyLr9xskQ/k4Skpn9yea43ZcSKIdTbit8FkbV1esyS6
        UULHpejaJGTEY0zrdHw81HblbULXwBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGwuiCS51dh/1BotnKaVyj381ZiDx17kLZxreKVQl0M=;
        b=hCV1jO4/sGCAvAu8Wzz9iTVhcDAQnzDYxJde4MEmjH2bQuK2ZpMoV9s9Q6UgV5CBrNUGjt
        QSWKovjRY1IShwDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 60378A3B8E;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8B8DF1F2CA6; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 08/27] bisect: Fixup bisect-porcelain/50
Date:   Thu, 18 Nov 2021 17:49:21 +0100
Message-Id: <20211118164940.8818-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 50 from t6030-bisect-porcelain.sh assumes that bisection algorithm
suggests BROKEN_HASH6 when BROKEN_HASH5 is an equivalent choice. Fix the
test to work in both cases.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 4ec7b5b5a72e..79f253f01b00 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -689,10 +689,23 @@ check_same()
 	test_cmp_rev "$1" "$2"
 }
 
+check_oneof()
+{
+	base="$1"
+	shift
+	echo "Checking $base is among $@" &&
+	for rev in "$@"; do
+		if test_cmp_rev "$base" "$rev"; then
+			return 0
+		fi
+	done
+	return 1
+}
+
 test_expect_success 'bisect: --no-checkout - start commit bad' '
 	git bisect reset &&
 	git bisect start BROKEN_HASH7 BROKEN_HASH4 --no-checkout &&
-	check_same BROKEN_HASH6 BISECT_HEAD &&
+	check_oneof BISECT_HEAD BROKEN_HASH5 BROKEN_HASH6 &&
 	git bisect reset
 '
 
-- 
2.26.2

