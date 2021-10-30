Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860BFC433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518AC60F45
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhJ3Uy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJ3Uy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 16:54:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD86C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:51:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso7555434wmc.1
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljOXboz/WVEEHt+2bfCpJYca0Wco7wmLsEG0gRrStx0=;
        b=QNnyHgBLwYPY3eDvj2UudSwfSbqJg4zGCoi7cKLCQwGrj0HK4tN10iz0NbU3ZDOrAi
         fWaFwUzd/ibtWJjfsC8j8dB4t2Tn1r18Raru2oqMcr6ve49nUoxWDFCN2G8AvacqAKHm
         gLv18KLM22WqPmZm/Sk9c7z5Ue8fOUDu0iaE5h+bysiJFD8H+A8XjMamBD3LUsyR5rDQ
         h20fb3bGYOpWMvfyL4VBqdQFienfLEijbtbj6NWxvsj6b5UIScys26VCqysnRHP63QoQ
         13DDAUEb2kfHbLDa6Dzkwn+fgD2X/+aQP8mbIcVO27kKF1f4l6vhgVWUI3mnRa/z8V5U
         zR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljOXboz/WVEEHt+2bfCpJYca0Wco7wmLsEG0gRrStx0=;
        b=vXEiz9YV+hG7xCJd/78FRYKJtaJZo94HnqqYN9pZmIkplCsysuxgVEdN0r+fsg2EhR
         QsE+zAymM+fdlnpqwvWVuvwoOOqb8x3oHntcu1uIwulD/1jL9biyZhFO8MNiY/HcFVNN
         2s8olKnSQKOVqF5SYrrbPtezUI+R9/jS3yxQRpzef2JA6oFKZpJI9ErQ7DYlx6vK7udv
         7nOas/KaL1aPI1yjhnJgiEYvzCyKYqU0j2bjCMBO+bDoDwZRSWj99bi7elv/xr7LGspb
         fhhV8scLEHm62I46hlp5lbVOsDvjVKqgvEaL1ilJfRXn2CjFIWgKTl1oxNBw8b3KzadH
         byEQ==
X-Gm-Message-State: AOAM5319FYc6GNJLUvedCiQZ+2nNCH1ZROo1SAZ0ZinSbIO9ba1E2Mh3
        Onz58kE0vEZ9J0V2fY1UNE4JBB7G+oI=
X-Google-Smtp-Source: ABdhPJwyIY8flMrxz/allhR4xa49YRYcwU6c9UA3FebeXz0F2C5NqRz/TvbqFjzCdplAq9MUgbwmlg==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr20258482wme.186.1635627116176;
        Sat, 30 Oct 2021 13:51:56 -0700 (PDT)
Received: from lesale.home (62-47-13-59.adsl.highway.telekom.at. [62.47.13.59])
        by smtp.gmail.com with ESMTPSA id m12sm8942805wrq.69.2021.10.30.13.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 13:51:55 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     rhodges@cisco.com
Cc:     git@vger.kernel.org, rphodges@gmail.com,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH v2] apply: make --intent-to-add not stomp index
Date:   Sat, 30 Oct 2021 22:51:47 +0200
Message-Id: <20211030205147.2503327-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030204155.2500624-1-aclopte@gmail.com>
References: <20211030204155.2500624-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cff5dc09ed (apply: add --intent-to-add, 2018-05-26) introduced
"apply -N" plus a test to make sure it behaves exactly as "add -N"
when given equivalent changes.  However, the test only checks working
tree changes. Now "apply -N" forgot to read the index, so it left
all tracked files as deleted, except for the ones it touched.

Fix this by reading the index file, like we do for "apply --cached".
and test that we leave no content changes in the index.

Reported-by: Ryan Hodges <rhodges@cisco.com>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---

Sorry I used the wrong Reported-by: address in v1

 apply.c               | 2 +-
 t/t2203-add-intent.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 43a0aebf4e..4f740e373b 100644
--- a/apply.c
+++ b/apply.c
@@ -4771,7 +4771,7 @@ static int apply_patch(struct apply_state *state,
 					       LOCK_DIE_ON_ERROR);
 	}
 
-	if (state->check_index && read_apply_cache(state) < 0) {
+	if ((state->check_index || state->ita_only) && read_apply_cache(state) < 0) {
 		error(_("unable to read index file"));
 		res = -128;
 		goto end;
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index cf0175ad6e..035ce3a2b9 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -307,7 +307,7 @@ test_expect_success 'apply --intent-to-add' '
 	grep "new file" expected &&
 	git reset --hard &&
 	git apply --intent-to-add expected &&
-	git diff >actual &&
+	(git diff && git diff --cached) >actual &&
 	test_cmp expected actual
 '
 
-- 
2.33.1

