Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A7EC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7154061A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhKRQwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57582 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 49B7D1FD38
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1a/czSZhfUnhLXVMqptQNShNNknPs7qQBVC0h/JUvM=;
        b=keOsc7lVsvjwfYzD/A+smoaeFSJr3tGa99njXvOpXJ8SmoYqYbJOvSrpqasuiYM4A6sNqK
        Z725sYcJAFjc4dos5NneKyJkrgdFKk4uI+vBHiSpUh0lc2miMnbAYxZb0lpdgdF4U37j+v
        Y3apxVcb6eJjSR2XIepVIzH+FF5sX5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1a/czSZhfUnhLXVMqptQNShNNknPs7qQBVC0h/JUvM=;
        b=7inL6WwR+6We7hnMh3U0k3oIt8FWZ4oL7l05zw/kpYsosdafvoQNAbHPQmr19Jvg1TunOE
        7SmSml1CdgUInqCA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2A724A3B8B;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7D40A1F2CA2; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 04/27] bisect: Fixup bisect-porcelain/32
Date:   Thu, 18 Nov 2021 17:49:17 +0100
Message-Id: <20211118164940.8818-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 32 from t6030-bisect-porcelain.sh assumes that bisection algorithm
suggests HASH6 after HASH4 when HASH5 is an equivalent choice. Fix the
test to work in both cases.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 13f7deea4d81..d693c0002098 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -395,9 +395,13 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	test "$rev_hash4" = "$HASH4" &&
 	git branch -D bisect &&
 	git bisect good &&
+	rev_hash=$(git rev-parse --verify HEAD) &&
+	if [ $rev_hash == "$HASH5" ]; then
+		git bisect good &&
+		rev_hash=$(git rev-parse --verify HEAD)
+	fi &&
 	git branch bisect &&
-	rev_hash6=$(git rev-parse --verify HEAD) &&
-	test "$rev_hash6" = "$HASH6" &&
+	test "$rev_hash" = "$HASH6" &&
 	git bisect good > my_bisect_log.txt &&
 	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
 	git bisect reset &&
-- 
2.26.2

