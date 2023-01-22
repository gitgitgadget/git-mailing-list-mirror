Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D989C54EAA
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 01:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAVB2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 20:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVB2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 20:28:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98E19698
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:28:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8311499wmb.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOdibKdMGHDB1zNbm5hBI+eesv7GEKskhjDC1YrlgfY=;
        b=HjM1W/dnzaTgHlWdIK1BwhvsAxa/OmqV9+STGOhV1cqOI5abgq57FxsJyf5sQFIeaM
         czeoyINUuC7nhOt9zb2az1O5IculxOWlBNcqk4zUwTDewWuDXe5fgIaw3X7VD/qFwM7e
         qgxqRce++X15HpXL+GPmNXrFD7G8BS6IdSNg+bFURoNEor00t36oyDtYgbGfNWyTjB2Z
         iJSqrBI1fQrtaawxKhP96AgN0dXRAl58sG2GgrmL0MiKzafP1FJxtXDHmcUsQS45hWYY
         lj2dAJvtbT/eSb5s+/lc2zTgVHuCgOyQS37ScvzD9yJzRNRX8NaK+h/wc/P9LR0C+lAu
         R+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOdibKdMGHDB1zNbm5hBI+eesv7GEKskhjDC1YrlgfY=;
        b=o9xSdX7TNuNCi1l94UgiNr6tX8XGiARH4PnrOp3TzctIaqkiH/Nt2V69SMv+A/ZQkr
         NbpgCFQ9iWJapXjIlfzddTXF22cCSAZXuPVbGFm+Tj6RkGDG4mO3Dm+aQcKhNGmHIwPK
         OBd4dxQ4gabpwGCw9vt4HUqBsAr0CuG37KYYTPCkaRcYwbNoYR6EPZTxRuV/aGsN9aCh
         u8tJ20PXXhvv59NqyoJuqy+P1yUvm8wmG4BPZbrzlLnD1NrCc7ScVPdvUuEUfw6l69g4
         H9FhUq+yuYlbY2db2yh/xFnb66MvoDxYSlJmuo/8LxzndHFFx+xgpBbaDPJxZI2OJ4dc
         4XDw==
X-Gm-Message-State: AFqh2krReGDjuez9bvZKLJDrozHsn7u2q2OSXy/1C2GGHWQO0kjsKnZq
        mgN6htaMIoIQVxUI4HSKTmk=
X-Google-Smtp-Source: AMrXdXsBCyJFcZpTfoz1f9GwoKAX5007BGTuCnKCmwhSS5B134HIRCmvgHwqwQiJM3oiG7hbUaqGng==
X-Received: by 2002:a05:600c:3b83:b0:3d9:f758:e280 with SMTP id n3-20020a05600c3b8300b003d9f758e280mr19993456wms.24.1674350901084;
        Sat, 21 Jan 2023 17:28:21 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003dafa04ecc4sm6534869wmi.6.2023.01.21.17.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 17:28:20 -0800 (PST)
Subject: [PATCH v2 3/3] switch: reject if the branch is already checked out
 elsewhere (test)
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Message-ID: <1c98cbe8-8bca-e202-ef52-ce100307c7f3@gmail.com>
Date:   Sun, 22 Jan 2023 02:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 5883034 (checkout: reject if the branch is already checked out
elsewhere) in normal use, we do not allow multiple worktrees having the
same checked out branch.

A bug has recently been fixed that caused this to not work as expected.

Let's add a test to notice if this changes in the future.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t2060-switch.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 5a7caf958c..7bea95dba2 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -146,4 +146,33 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
+	test_when_finished "
+		git worktree remove wt1 &&
+		git worktree remove wt2 &&
+		git branch -d shared
+		git checkout -
+	" &&
+	git checkout -b shared &&
+	test_commit shared-first &&
+	HASH1=$(git rev-parse --verify HEAD) &&
+	test_commit shared-second &&
+	test_commit shared-third &&
+	HASH2=$(git rev-parse --verify HEAD) &&
+	git worktree add wt1 -f shared &&
+	git -C wt1 bisect start &&
+	git -C wt1 bisect good $HASH1 &&
+	git -C wt1 bisect bad $HASH2 &&
+	git worktree add wt2 -f shared &&
+	git -C wt2 bisect start &&
+	git -C wt2 bisect good $HASH1 &&
+	git -C wt2 bisect bad $HASH2 &&
+	# we test in both worktrees to ensure that works
+	# as expected with "first" and "next" worktrees
+	test_must_fail git -C wt1 switch shared &&
+	git -C wt1 switch --ignore-other-worktrees shared &&
+	test_must_fail git -C wt2 switch shared &&
+	git -C wt2 switch --ignore-other-worktrees shared
+'
+
 test_done
-- 
2.39.0
