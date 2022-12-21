Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B0DC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 11:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiLULrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLULrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 06:47:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186F1D33B
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 03:47:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so1986184pjp.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 03:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeMqx/+KCByXjOH+htAc4kgXMDgg7wleuatgoxYfJHg=;
        b=ENWk/nCD/lxpBS+bAvEtd0l3q9LfTJoJThdrWzeNa6UG4vDRAaQgs5b+s8/s4UQ8oF
         9Im5i7vUvAa2QPyS2YRphAr/kdhRRMXxqGL4W5jaqXipEqoS6PVLrdM8m3FhsyS94uCB
         5nbloLKkd752yXXYCY9OpicGvr/wpBdCkPV8rLctjnx3G6wgy7TTTdscVoPKiASvv942
         3MLBo4O03RY2qn7mxLqwz7t84O3I4N19R59NjjMwLMsONioMpX8oKiq24lr1Sh0jOgwq
         XC0X91GIaiweZD+XWFgOTvVfok8wVNFYQvcvmG+3HM1mWiIOPzc+j+lt24Vg4j1eQPHy
         hcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeMqx/+KCByXjOH+htAc4kgXMDgg7wleuatgoxYfJHg=;
        b=wjTC5WHehzN1Z9qXG/mLDAcPsxGJE9e4ncbv7FGBBi39xioX+RugfNqyuHhat7NsYO
         peFMjmQ80uctyyTbIm2G3d7FpD71uMgtvPhwak6LoV6DAkQEcbTSJEqzVaSxJFdo7TFJ
         hFktu38KmoIhXS/TatJVOm6ylipAyDwDep2UY/K9DTrDGn/oArtB0/3TfwhSCgFgD2PV
         915Ep2ifQEbM7O4BR9+O2wwz4UPWhE/+sC0KsuphexCPDseSCHAM9/4UaCUDsrJfyFQT
         W2Vg0vRGjEElvIGEoMPjGaO+Qny4MRVK/j+dW81HpWJXGSE1xwB4x1513Yt4EIZifycZ
         TDzw==
X-Gm-Message-State: AFqh2kp3jHdtcwSqvLdhZaFTYwq4EIfWVAXTcW11aWd+xSLInHLxrv8v
        dxzR06bqtp1ubtJDFmfgCQpZ+vwCR8XXz33R
X-Google-Smtp-Source: AMrXdXt7WVU+5YWi8YJ972Y4B7gJNDYbs7p9Do/PddTUDWmHDKhIddWaxjd02U5NU2iDZaOp3EpdFw==
X-Received: by 2002:a17:90a:a516:b0:219:3dba:be16 with SMTP id a22-20020a17090aa51600b002193dbabe16mr1776700pjq.38.1671623264090;
        Wed, 21 Dec 2022 03:47:44 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.55])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090a670600b00212735c8898sm1219082pjj.30.2022.12.21.03.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2022 03:47:43 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, me@ttaylorr.com
Subject: [RFC PATCH 1/4] ls-tree: don't use "show_tree_data" for "fast" callbacks
Date:   Wed, 21 Dec 2022 19:47:37 +0800
Message-Id: <20221221114737.51375-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.96.gf7c8a0386a7
In-Reply-To: <RFC-patch-1.4-2d8bcfe2cab-20221117T134528Z-avarab@gmail.com>
References: <RFC-patch-1.4-2d8bcfe2cab-20221117T134528Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> As noted in [1] the code that made it in as part of
> 9c4d58ff2c3 (ls-tree: split up "fast path" callbacks, 2022-03-23) was
> a "maybe a good idea, maybe not" RFC-quality patch. I hadn't looked
> very carefully at the resulting patterns.
>
> The implementation shared the "struct show_tree_data data", which was
> introduced in e81517155e0 (ls-tree: introduce struct "show_tree_data",
> 2022-03-23) both for use in 455923e0a15 (ls-tree: introduce "--format"
> option, 2022-03-23), and because the "fat" callback hadn't been split
> up as 9c4d58ff2c3 did.
>
> Now that that's been done we can see that most of what
> show_tree_common() was doing could be done lazily by the callbacks
> themselves, who in the pre-image were often using an odd mis-match of
> their own arguments and those same arguments stuck into the "data"
> structure. Let's also have the callers initialize the "type", rather
> than grabbing it from the "data" structure afterwards.
>
> 1. https://lore.kernel.org/git/cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com/

Because in "show_tree_common(&data, &recurse, oid, base, pathname, mode)", the
"data" and the other args exist redundant, we could just not to pass  "data",
because it's enough, do I understand right?

Thanks.
