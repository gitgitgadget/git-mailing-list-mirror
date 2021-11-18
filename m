Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144A9C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA0961B39
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhKRQww (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57588 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 524C41FD39
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wlen4cf+aEJt/FgD27jOu/Drnv8TKfRrfQK+828Eh2c=;
        b=0bhV8VS63IlO6C0MY4/QHc8qIfvyGVgWZyCY0XqQKbY0+ey0LyWbLy+RYqei/BjdwDRZNL
        Pa8rabsLpm4rfogI3WRurqqCNI3aDqDzhEkH3CxwNPfnIeVzlXqILV5oh+0V9f9i5PMkeG
        mj5LFRZCqiPLT+gkiVlik1R5cEWUTBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wlen4cf+aEJt/FgD27jOu/Drnv8TKfRrfQK+828Eh2c=;
        b=fBeexZmBfGF+z8/0luaBiU3TdC/OqseIIDy7Wn8nLucqHXjazWT4MUWgy/O6+66fAkirXW
        te7FNYdnanwW+rDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2D6D2A3B8C;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 795541F2C9F; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 03/27] bisect: Fixup test bisect-porcelain/20
Date:   Thu, 18 Nov 2021 17:49:16 +0100
Message-Id: <20211118164940.8818-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 20 from t6030-bisect-porcelain.sh fails if the bisection algorithm
picks HASH2 instead of HASH3 as the first step although these are
equivalent. Fix the test to work in both cases.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index f8cfdd3c36d2..13f7deea4d81 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -240,8 +240,13 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
 test_expect_success 'bisect skip: cannot tell between 2 commits' '
 	test_when_finished git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
-	git bisect skip &&
-	test_expect_code 2 git bisect good >my_bisect_log.txt &&
+	if [ $(git rev-parse HEAD) == $HASH2 ]; then
+		results=('good' 'skip')
+	else
+		results=('skip' 'good')
+	fi &&
+	git bisect ${results[0]} &&
+	test_expect_code 2 git bisect ${results[1]} >my_bisect_log.txt &&
 	grep "first bad commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
 	! grep $HASH2 my_bisect_log.txt &&
-- 
2.26.2

