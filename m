Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22BC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112CB61A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhKRQwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52772 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4376C218B0
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R24rzMp4bXbzycTMsB26icFWttDt9+TzzbC2PvKxCN0=;
        b=KJMH9o9zei+xF4S+uJosoQJC5TwpQxIc9dIbEYvHG0CRyM5ABE9tJ+qMWi7DlQpNQOQ76m
        4oo5Nqc+ekYAzq6k5Pevqc+Lsr29J3MngGct6C2TFpKT4ZeEieLFnpJyCM7m+1ZHoRYQHc
        YXLO1SV/Q53QO4LQvzfygtPkTE4Zd5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R24rzMp4bXbzycTMsB26icFWttDt9+TzzbC2PvKxCN0=;
        b=27JRLk4IvJizX/u9FmkIqihmZ7SYgTpIzm9tklbgOoVqUbIrCLCPWH1n7wqq6M4PB5oy5C
        vl5UeU0T6bp6ltBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1E6D5A3B89;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 762501F2C9D; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 02/27] bisect: Fixup bisect-porcelain/17
Date:   Thu, 18 Nov 2021 17:49:15 +0100
Message-Id: <20211118164940.8818-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 17 from t6030-bisect-porcelain.sh assumes that bisection algorithm
suggests first HASH3 where HASH2 and HASH3 are equivalent choices. Make
sure test correctly handles both choices, add test variant to properly
test commit skipping in the second case.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1be85d064e76..f8cfdd3c36d2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -197,11 +197,27 @@ test_expect_success 'bisect skip: successful result' '
 	test_when_finished git bisect reset &&
 	git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
-	git bisect skip &&
+	if [ $(git rev-parse HEAD) == $HASH3 ]; then
+		git bisect skip
+	fi &&
 	git bisect bad > my_bisect_log.txt &&
 	grep "$HASH2 is the first bad commit" my_bisect_log.txt
 '
 
+# $HASH1 is good, $HASH4 is bad, we skip $HASH2
+# but $HASH3 is good,
+# so we should find $HASH4 as the first bad commit
+test_expect_success 'bisect skip: successful result' '
+	test_when_finished git bisect reset &&
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 &&
+	if [ $(git rev-parse HEAD) == $HASH2 ]; then
+		git bisect skip
+	fi &&
+	git bisect good > my_bisect_log.txt &&
+	grep "$HASH4 is the first bad commit" my_bisect_log.txt
+'
+
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3 and $HASH2
 # so we should not be able to tell the first bad commit
 # among $HASH2, $HASH3 and $HASH4
-- 
2.26.2

