Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1401203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 01:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941251AbcKOBTI (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 20:19:08 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35771 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941024AbcKOBTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 20:19:05 -0500
Received: by mail-pg0-f41.google.com with SMTP id p66so60114985pga.2
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+6nz7At9s2ftO7LQrFKflqSAlyNqbjBgVp/7XyNrkk=;
        b=a04ORYvRKP+t4MTxEb9PIXOUIkpz8kgDzJOUDS6q9tn6zhskE1Q4aiz+GqwK+jEVFs
         kDFvoJd1YmSqvR8r7MZhGeZMkBwaHau8/fYXGu1JP1pepYCAVknNEu/ZmKpAQBDd3SPB
         8lQEXHJaoMLcGcFhxtzfKRBL1jq0OBdnt4FslEMn6f+GfANGe1JPTlfpIcKCn8acnBC0
         dssGMSAxIfqFXIvBtZR9lhb2rVp4TmeweloaWUPI9L70/BpIF/BbUVe6tAQfjZz34ih3
         l09ZXp3Eh47pwNNidC9Qli5ItI9xEEwH8paUML6rjIPfAoRF71ZHWr2HSR0HTf75b2rg
         wp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x+6nz7At9s2ftO7LQrFKflqSAlyNqbjBgVp/7XyNrkk=;
        b=jRHK/fV8/r8llsPCMi+XhPnVCzN9Q1x70ERnBgE4sgEsy/2YAwS8HU2NZDTVyQzHoz
         kAVcb1HMGCOHZj/Rf+e0PwzNKH1UvrfLPpdATwcIiFpzPGvwWW1BPmqRMUNLWPbEaNiK
         tjS6LI0cY9u4ZlSGUIMZp9U8H7onkQmpSEt1cU3y74vzpok17FQ275+8Quzka/7/8MV0
         rhXDcKRszIa6OQ5KNpHxPpOxLvC1veCGxhUyGiTFaZFKdJD5PErU46B+9ZjlALDhavjY
         H0c9J1M5LK3LTGSvuR0vGkx3MpmOK2nLbdzOF+VzAN72FNrKvzeekQoKXyj6JnCkjLhB
         9VWA==
X-Gm-Message-State: ABUngvdanHzq5sCT3rp2lSnsbG/UPJGya/a1xy5WuinLnss1+T7mERo7xdO9gOG2yudQ2baq
X-Received: by 10.98.137.21 with SMTP id v21mr41921197pfd.48.1479172744096;
        Mon, 14 Nov 2016 17:19:04 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id t89sm35655377pfe.50.2016.11.14.17.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 17:19:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/2] push: --dry-run updates submodules when --recurse-submodules=on-demand
Date:   Mon, 14 Nov 2016 17:18:54 -0800
Message-Id: <1479172735-698-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479172735-698-1-git-send-email-bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a test to illustrate how push run with --dry-run doesn't
actually perform a dry-run when push is configured to push submodules
on-demand.  Instead all submodules which need to be pushed are actually
pushed to their remotes while any updates for the superproject are
performed as a dry-run.  This is a bug and not the intended behaviour of
a dry-run.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t5531-deep-submodule-push.sh | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 198ce84..e6ccc30 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -427,7 +427,31 @@ test_expect_success 'push unpushable submodule recursively fails' '
 		cd submodule.git &&
 		git rev-parse master >../actual
 	) &&
-	test_cmp expected actual
+	test_cmp expected actual &&
+	git -C work reset --hard master^
+'
+
+test_expect_failure 'push --dry-run does not recursively update submodules' '
+	(
+		cd work &&
+		(
+			cd gar/bage &&
+			git checkout master &&
+			git rev-parse master >../../../expected_submodule &&
+			> junk9 &&
+			git add junk9 &&
+			git commit -m "Ninth junk"
+		) &&
+		git checkout master &&
+		git rev-parse master >../expected_pub
+		git add gar/bage &&
+		git commit -m "Ninth commit for gar/bage" &&
+		git push --dry-run --recurse-submodules=on-demand ../pub.git master
+	) &&
+	git -C submodule.git rev-parse master >actual_submodule &&
+	git -C pub.git rev-parse master >actual_pub &&
+	test_cmp expected_pub actual_pub &&
+	test_cmp expected_submodule actual_submodule
 '
 
 test_done
-- 
2.8.0.rc3.226.g39d4020

