Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700F5C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 14:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBYOWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 09:22:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F6E193DD
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:22:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p8so1925417wrt.12
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677334935;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egpw6IbPtsqdvKDFaTTWbrJWu7ZWoJQFKvDraKDVG/o=;
        b=n6XYZJdmkNub2KGZRHgYmCrAeG7heC+VVVMjVxhsjjVKdSr0CLtEn7R1o+Gd3tNveS
         e4WrbThlSvxowW6OAQ6ots5qO45pdkGWlmVDJHl7dicfM4TICPclZK+lUi8CoB27gVAH
         Ga6CYFfekfsF/DSsp75uys/Q9fYuIHv0Gv3EbkWJVkYWbKI8++pSkFOySMxAx23ReHm/
         aSzg5MPblszHWKisWa58yrao73P5IzkxfQLlckPIktChcnqIXyuGMmBLd/vrRd5+M5Vg
         4iWHjNI6SJ9R67EHiwpZ6F3VTHSoD9LXk4S8QgWVHIOEC0r5RzYW6vdzGY15rt2uITsX
         VPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677334935;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egpw6IbPtsqdvKDFaTTWbrJWu7ZWoJQFKvDraKDVG/o=;
        b=pvmJjn6m/vGjzj2eiHavOY2rNWdSqtxm7DnbGUmVPYKlwqYjr34xo0gg1TS5hKDUOw
         EGV80FsP4OzR+e92nhbGi7jK9LIrNmuQo/+OPc2dy2HzrtGRlXH4qZB/LGPmrSo1/tny
         z58JETrl9Y0HTajfytuMwZXGueiQhm8RFRrZmIekdNvUlNyzDG/b/Dy6c5ikn/9qHbHY
         P+yRQx6kPm+VAo0TRL3pjyGpAjFIXvM0Xh/MGia4HU8MW9wl9DZXQeiWJWohvSTJ1wv8
         8owCu1/oWQAG56+vDB958LTJyjPqVg6sUOPUw2IRLZxjICl2xNRN1pMNpVNAvImRguUU
         nkUQ==
X-Gm-Message-State: AO0yUKXyapNCRfQL1pfzIEyYYv5L4B7WoKkcODxRo/glF6TAvyH9a6ep
        HBifo730QETWxSCB+QDohNM=
X-Google-Smtp-Source: AK7set9yCEjo9+LVXDDTzh0tIMVhK5m/Fs8t+im+oCajY0wmHiHB6Y7L5Kb2Zs+RK3p0MRyj3P1xiQ==
X-Received: by 2002:a05:6000:108c:b0:2c7:1d55:a56b with SMTP id y12-20020a056000108c00b002c71d55a56bmr4504418wrw.70.1677334935725;
        Sat, 25 Feb 2023 06:22:15 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id a2-20020adfdd02000000b002c3f03d8851sm1936383wrm.16.2023.02.25.06.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 06:22:15 -0800 (PST)
Subject: [PATCH v4 3/4] rebase: refuse to switch to a branch already checked
 out elsewhere (test)
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Message-ID: <6ff38da4-4465-5ffb-36ec-d73a09f3c900@gmail.com>
Date:   Sat, 25 Feb 2023 15:22:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b5cabb4a9 (rebase: refuse to switch to branch already checked out
elsewhere, 2020-02-23) we add a condition to prevent a rebase operation
involving a switch to a branch that is already checked out in another
worktree.

A bug has recently been fixed that caused this to not work as expected.

Let's add a test to notice if this changes in the future.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3400-rebase.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index d5a8ee39fc..3ce918fdb8 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -388,6 +388,20 @@ test_expect_success 'switch to branch checked out here' '
 	git rebase main main
 '
 
+test_expect_success 'switch to branch checked out elsewhere fails' '
+	test_when_finished "
+		git worktree remove wt1 &&
+		git worktree remove wt2 &&
+		git branch -d shared
+	" &&
+	git worktree add wt1 -b shared &&
+	git worktree add wt2 -f shared &&
+	# we test in both worktrees to ensure that works
+	# as expected with "first" and "next" worktrees
+	test_must_fail git -C wt1 rebase shared shared &&
+	test_must_fail git -C wt2 rebase shared shared
+'
+
 test_expect_success 'switch to branch not checked out' '
 	git checkout main &&
 	git branch other &&
-- 
2.39.2
