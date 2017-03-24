Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10CAC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754973AbdCXS3X (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:29:23 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34722 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965606AbdCXS3O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:29:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id p189so4350839pfp.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l10PhiJ4HJjKGpxihTbNYLZp87ZhT2cFU1qOQeSovJ8=;
        b=tIWW66fR5dq+hRseNGGmkcq96E2jsoGsNMejJ21JQNBv81WEl1Xwp/ib++/guPd0o+
         jXU3b96+L5TLE55LXz5aQv77km2LyiaG0M9Hk+83xvu/HjpNPS3nxOkx3BWxHfsuWg/E
         uX41rlnWmDqIzAE0zJt7nS2m4yVHMAV4gLQZfS2y0IQ6DJHB+RaJX8Qy6lr2f1cU7qAN
         JvUnO0ajZsPSBJGtl6wmqK1LG0ePzhcZr75JUXZ6EK+PwagXNXpojkNdOZ0WjDZQdSIT
         JIc9VQ63CnFhkEvOo8HWa8O+HsFuht22mtrU7GqYi6ZReD1KL5ZRj1myl+znnPSeYhzv
         zVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l10PhiJ4HJjKGpxihTbNYLZp87ZhT2cFU1qOQeSovJ8=;
        b=UMl3b0rlzEEIVD75Jx2MeNRWTFcC6o+YGVG31elHIvdZv1IRa72sabE3YLCtsNaqFx
         HK0RPnmb+xKeJcqPWVFqx3APCioqxrwzjuTP5ahojfSrB93vXKLXkVccCZjkTk8PfIb4
         NLkgs84z5NSZg3038/ZWTUgPQkN/ByqfMNsjAqOgHdaWh6YNc7JvNltYONFIWUVwfbU5
         a2WCDntXb5a7/nCq1Ovr16vb2maW628+pjXqs2r+pcAOHRWTS0mn6qa/lIvmhcf6z7Ba
         dtntXSa8EAbUBIodut5nRuWH07Hq9pFJbbUzv7/KS3+g3hO/uceK44ac7SPKRspMQq4S
         VyrA==
X-Gm-Message-State: AFeK/H2g1/uvT5Wp6oqsd4Pnmb8Za4RBVlojBLLZqfTZGvjkGXa/gBis5eru6diSunhyXLF5
X-Received: by 10.99.101.199 with SMTP id z190mr10522872pgb.219.1490380153028;
        Fri, 24 Mar 2017 11:29:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id o24sm6033781pfj.126.2017.03.24.11.29.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:29:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] submodule.c: correctly handle nested submodules in is_submodule_modified
Date:   Fri, 24 Mar 2017 11:29:02 -0700
Message-Id: <20170324182902.19280-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.437.g2b7623d507
In-Reply-To: <20170324182902.19280-1-sbeller@google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a nested submodule has untracked files, it would be reported as
"modified submodule" in the superproject, because submodules are not
parsed correctly in is_submodule_modified as they are bucketed into
the modified pile as "they are not an untracked file".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 | 16 ++++++++++++++--
 t/t3600-rm.sh               |  2 +-
 t/t7506-status-submodule.sh |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 467f1de763..ec7e9b1b06 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1078,8 +1078,20 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		/* regular untracked files */
 		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-		else
-			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+
+		/* regular unmerged and renamed files */
+		if (buf.buf[0] == 'u' ||
+		    buf.buf[0] == '1' ||
+		    buf.buf[0] == '2') {
+			if (buf.buf[5] == 'S') {
+				/* nested submodule handling */
+				if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
+					dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+				if (buf.buf[8] == 'U')
+					dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+			} else
+				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+		}
 
 		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
 		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked)) {
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index a6e5c5bd56..b58793448b 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -659,7 +659,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified_inside actual &&
+	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index ad46384064..e3cdcede72 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -324,7 +324,7 @@ test_expect_success 'status with untracked file in nested submodule (porcelain)'
 test_expect_success 'status with untracked file in nested submodule (short)' '
 	git -C super status --short >output &&
 	diff output - <<-\EOF
-	 m sub1
+	 ? sub1
 	EOF
 '
 
-- 
2.12.1.437.g2b7623d507

