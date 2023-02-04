Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA08C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 23:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjBDX0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBDX0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 18:26:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836B22026
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 15:26:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so4852094wms.0
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 15:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjHBNeqLSs/pYqIMWgX8unSi3QbAzvP0xO/zdCMIkHo=;
        b=BFyCVwiY+is7U6njp4BztrSXblbmy7v9/bgKbPkvQzs7yWkJYPQ8lUMImKC4GEeiKX
         UCTBEzLTJFyKvyRfTG1b8pJqRL3vqFKaXZECwPip6BnwpC4NEg79FFF0bvsfKPa4mWL1
         PDVzLG0MKHwcrKh5KWUWnQnuSGFdun/AMTrIvZsAu5fqcfEXbYlMLnO9ocAj/mjCTrDH
         wmybEH77A/IZ+Pkr05UbxQPX6Lg6atPQ17knDrinqNRWcodtGSgQ7MvVDLZx3zNikjEI
         9tIHf9LlD5kOsS/wxV3mnfn62HPc9qyH8ybpiUh3Iu+Le8nLBftkwRnorCNcsOl0Tt4Y
         ueBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjHBNeqLSs/pYqIMWgX8unSi3QbAzvP0xO/zdCMIkHo=;
        b=8Ks2SYE43OTYNpImxn7rKediQIj2iKFTEFNA0FwFBhw7CEGvUuAUp9jRPLbwd4WQx6
         8KdW06UnGG2rWd6s3bHb1CVoRLwDU05IpDCUHo9n2GxUSHI4Gii2/7VhZgEFHYgKlzaC
         klcOm3JP0RUag85oJNon0UzOIP+OOc9uqA5n+CavxRBDZLTtd9cE2OCLXjJ7GohlskcC
         ZaEPAE0F0VIqbGwjfsENpjyoyyRNWu8gV/AUqO3psSm4c72KPwLiJBxlFzasx6DRbW/N
         czBArZjJq8eYjkYEHoKYnxAWkW34WWQRI4jCK+NUVvAeKpDBcsIBEHGNf+OvvN4rA97D
         pYCw==
X-Gm-Message-State: AO0yUKUxofcoAQ/qoT8YtNcK3scLnW1y62mIQ9e0arLsvzmxeYlePIXN
        FTkiClHz7+d3Rzz9LbYYPVFTo3NhImc=
X-Google-Smtp-Source: AK7set+ilTtdUFnpv6DE82aZsaaqPSW0hzj4TG0Za8lo6d5ClVEYLr+Q8nLjlU5hPGtngWEJK3FPQA==
X-Received: by 2002:a05:600c:1e19:b0:3dc:52fc:7f06 with SMTP id ay25-20020a05600c1e1900b003dc52fc7f06mr13651146wmb.41.1675553170397;
        Sat, 04 Feb 2023 15:26:10 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b003a84375d0d1sm12636080wmo.44.2023.02.04.15.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 15:26:10 -0800 (PST)
Subject: [PATCH v3 3/4] rebase: refuse to switch to a branch already checked
 out elsewhere (test)
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
Message-ID: <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
Date:   Sun, 5 Feb 2023 00:26:06 +0100
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
2.39.0
