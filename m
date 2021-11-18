Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5113AC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB7E61A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhKRQw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F966218D5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtoMAbsYeDByBMa/BABCjE5/QXzQy4aCbXxjaicEYnA=;
        b=LK3/X9mglyS6XJou1vpUbQmbMjI4RraQpo8U9mX+dJnf61x88psspNoA282u8y2UCku4Dp
        fYIuul1hYihmQ2XhvaZ5hXfBWF+5awqfUbML8P4gTB9iwjv4m7ibUqb+jogZUVH8Ypmx8v
        KcL3BLm7SgJCfeCZxtksQUjytzdp0EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtoMAbsYeDByBMa/BABCjE5/QXzQy4aCbXxjaicEYnA=;
        b=t+IB3ilG5gJdBxOFNO/JLIpYA6zcUlDBTqnIHReoHlXqOLt95eyXgDUlDw/nOkyiNMn0lQ
        HN94+jcfD3b/sCBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 63A2DA3B91;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 856EE1F2CA4; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 06/27] bisect: Fixup bisect-porcelain/40
Date:   Thu, 18 Nov 2021 17:49:19 +0100
Message-Id: <20211118164940.8818-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 40 from t6030-bisect-porcelain.sh assumes that bisection algorithm
suggests HASH6 after merge base when HASH5 is an equivalent choice. Fix
the test to work in both cases.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index ed81a6403b63..0f2a91996393 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -524,8 +524,9 @@ test_expect_success 'optimized merge base checks' '
 	grep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
-	test "$HASH6" = $(git rev-parse --verify HEAD) &&
-	git bisect bad &&
+	rev_hash=$(git rev-parse --verify HEAD) &&
+	test "$HASH5" = "$rev_hash" -o "$HASH6" = "$rev_hash" &&
+	git bisect bad "$HASH6" &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log4.txt &&
 	test_path_is_missing ".git/BISECT_ANCESTORS_OK"
-- 
2.26.2

