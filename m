Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB22C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 23:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBDX01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 18:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBDX00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 18:26:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63422026
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 15:26:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8414351wmb.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOdibKdMGHDB1zNbm5hBI+eesv7GEKskhjDC1YrlgfY=;
        b=Y/iLk5jhG/dIxufB/HA1Yo1pPXvgLnd0li02JbYKLN9R46ODWF2kB5DVlirHj5br8Q
         X99+4lpn0p1AgG0LJQbTc1iwDALGvagIZrRr5xDqJFnzq2xjKWgNgtsVQzLYNsJUL6PB
         owZIzT3GYOdao4unWCBEzJxcsBPk91cv34+0TH1KkXdkJkyLHbKjfGggMjNieVb8gy7R
         ZOeP89/zgBJbFJ3lt/NXQtiEfnIFs9adlP0/4M2xM28nsWlin9cGRaimZ3HbU8eD7nrJ
         ukuIhvOfFHUZ3zwZlOBZR5yy3L9zozx7L4rZXxYEXDev2Ch36yPiKF5ndBZ1h8hrjkoZ
         EzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOdibKdMGHDB1zNbm5hBI+eesv7GEKskhjDC1YrlgfY=;
        b=ksgu9cSRsWza5peJav+1zzcMgxUq7kUR++ipCiL3Wsn87k4n5ixHHrZ6ciLmNZl2jx
         EmzTi8dXmuXDLBgn+9LGAY/QwM9lPfpEBs8SA4KZoN+QKfjmJka6N6MuvlPWH0VeOneA
         wqLwb/cAXTwPAppFF8TUnHVDDvCLEcOwzj1Qjl8r3JBpHuAyuIOhuEr1734FFgVKpB6Y
         uINRDJG8fay6UVbv/gCguifla415bsKxqXmQdlaogfiDWysW1EfCYLOaHxDiyf3Pwc3j
         /q4gVQocG8aXtt78DTl3artUhIDtEECxJ5WGU4BY6JxXiC4S4djFLixK0rlrPkNUFaWs
         exiQ==
X-Gm-Message-State: AO0yUKXcsb78pTqoXVGXC62iZw1tPHp80YzJdEil8WpuJPtmhS2RhjYe
        prQrcXx5GthUVvIZXBov1As=
X-Google-Smtp-Source: AK7set+H3kbJmTCsM92WO5ZyCd5n8cagN/hS/s6Z/zzC9VfqGVCxh7cng9ShKflM4wLeqhuBGxwnXA==
X-Received: by 2002:a05:600c:a07:b0:3df:db2f:66a with SMTP id z7-20020a05600c0a0700b003dfdb2f066amr10483821wmp.31.1675553182455;
        Sat, 04 Feb 2023 15:26:22 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b003d9aa76dc6asm12715341wms.0.2023.02.04.15.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 15:26:22 -0800 (PST)
Subject: [PATCH v3 4/4] switch: reject if the branch is already checked out
 elsewhere (test)
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
Message-ID: <b18a5710-2791-f892-8460-dda7ea41d88a@gmail.com>
Date:   Sun, 5 Feb 2023 00:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
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
