Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED12C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBYOWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjBYOWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 09:22:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B326D1ABE9
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:22:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so4228366wms.2
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677334945;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDotPcpW2EKBQ6i1l/eY6VaNFaS2+Vw4/ImQtg8gDnA=;
        b=bflD9EilmAXdr92yQsjINkd8WJa1I7ERaHHDsJv6vXkNRQbIn8+Ul8yidpgeq6fOEG
         yhm/TRh+lhXZZSSes98s7oHF7SQsAH8uVTKZ+lp0XAj5stbLfvG3xwUvj8nKH3IAfhLX
         Q0oS1fRs0+kFrS1xn4nbiHfxO2v65m6Xc9WGj3KZnkb6xToyS7kCY3CghdaoyuB4BW5A
         rqUDXqzSzWfStOFotBeJcZEp7CVsWziR/wVLSRyQ5Zu/yufOtLaYtqWP2uhhZtdIDCif
         1HQ4HXAnnbbwGUBLJT9fXvvr4UXs6HaReMLKidSxM8RGIKAllU4DD2LBtY4yaq6mcoj+
         GfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677334945;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDotPcpW2EKBQ6i1l/eY6VaNFaS2+Vw4/ImQtg8gDnA=;
        b=7pVITSLbZ4ooT17rytgo4H/jMVTnUd8kQH7oSH9q2qx+9YRo2JAXmfK1rEMKWx9sZ1
         91+5ntIYYony9M8LnK02UmgNKRmdKaTxSdTJ7ez0IO3SGoZwF4idvLFSk9t+lEbnqlsE
         5qCTHpDZLTqJLfdYZZoIeU2gXaMaVAknjhLQ26Osy5zFroArUY1LgVJryld8KbUG0f8T
         o9fKWnAX068zf1nKowf3xIpP/JtO65vFODwLaearaTbiKhR0v8S4qwtZO6Fad/TU3tR/
         xXeKKY4/k0J35iFBPlQQdZLXoZRFWyZ+J5SoUm0JmPPYxnRz7mXszAa76htZ8OEl19XX
         Jrqg==
X-Gm-Message-State: AO0yUKXZErBtZGu06AGWs6j4nALRowb4vic+gdn1qjnfH4w6pVGXX6kv
        NW0qux07qqs/AloVMCliwE8=
X-Google-Smtp-Source: AK7set+zUxfiE8By7RLaRPwDMB+ZqzfUadWaJlJtloAJBKOQ8oNdFQqtmnAoJR0X4VLcGYPB78kB/A==
X-Received: by 2002:a05:600c:348f:b0:3ea:f132:63d8 with SMTP id a15-20020a05600c348f00b003eaf13263d8mr5189420wmq.5.1677334945141;
        Sat, 25 Feb 2023 06:22:25 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bca59000000b003db0bb81b6asm2778462wml.1.2023.02.25.06.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 06:22:24 -0800 (PST)
Subject: [PATCH v4 4/4] switch: reject if the branch is already checked out
 elsewhere (test)
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Message-ID: <8f335d0e-144d-2795-06b5-004f6752b632@gmail.com>
Date:   Sat, 25 Feb 2023 15:22:23 +0100
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
index 5a7caf958c..e247a4735b 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -146,4 +146,33 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
+	test_when_finished "
+		git worktree remove wt1 ||:
+		git worktree remove wt2 ||:
+		git checkout - ||:
+		git branch -D shared ||:
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
2.39.2
