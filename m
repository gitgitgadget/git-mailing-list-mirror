Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCADC636CC
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 04:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBKEQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 23:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKEQu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 23:16:50 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEF84EFE
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 20:16:47 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id g12-20020a170902868c00b00199148d00f2so3945688plo.17
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 20:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzY0sZY4/wtdd44G1l6IiWuKB7sS8YiGMT4o8voQMBI=;
        b=XsEL1Ep15dcaZlNsy9C2Pus9DxtNiZJhVYKZiGhQn4KwTbg8KgyURX32rjH8bXs4jP
         7RSeL5EGE93eJYwFZdQxoLCjjDbWaBGTUUq0906N74wrmwaay9fpYIL6pUQRQSUwjvk+
         OjUYvoD/zWWaJwb5kwKgdFUjjxE801B44VIp+DScNDB0juHuD1Fs0LtDujJrxhcIJldU
         zAiLNMle0IKARzW/0LebJIUTPUXLQXlhqi8Rxr7C9mIlyOKc3tETTEsiu2Fap/0C5aAa
         M62RKtF14x0CQyUffbRRefuSXyPgZileT0N14XS1kUe40AR4vJ+C6qCh0VhxFNgGQEf6
         +vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzY0sZY4/wtdd44G1l6IiWuKB7sS8YiGMT4o8voQMBI=;
        b=BvDrZmpLeFrBb0+0+mwR3Fr09UzhefRRDz07TimI3g4e6DeQQQhyTLUAVRPoU6LlJE
         uM90hn5uVVDNWOLxFsKzduUFcLj2xRKPYz/VJGqKLlxhjCagq19i0vqdFhEyhuhCdjOI
         P/eovjHc4IgoTyuvOgaUoS3ZDNJfx7sxMt/ARxTtGR4LOeGVzkDhohE9pOpRvuc57Cyp
         CmawBnYaDkNaaCF7D1GngkOLyU6OBVyQOBK8BHmfkt4JXExOfvNztktpMV0q7QdUNhG8
         NAUXPvJWu73KKt3RdDKvIkuPrUhkxF76EWusiQLHaLLMdwSz2QaM+rOc5eaXldlI6OtK
         zgTg==
X-Gm-Message-State: AO0yUKXaQ0C2SX4mekuFTt32Df9hQRx/Wm1ZKRPgpLxpfCySNNlNRn9f
        j5GVML79DDQYbvDKzTbWONSHIIibnzz0dl5H3YUT
X-Google-Smtp-Source: AK7set+xJwBnVmNymwv/wdN6pgXO0rJK73uqvXLH0aqGzMNQFDrEjB+XqGdK+bnMSPqbK3sWn4HgS87Ge5233sYZ6j8B
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:ae04:0:b0:4de:7028:d2fb with
 SMTP id q4-20020a63ae04000000b004de7028d2fbmr3328523pgf.111.1676089006988;
 Fri, 10 Feb 2023 20:16:46 -0800 (PST)
Date:   Fri, 10 Feb 2023 20:16:44 -0800
In-Reply-To: <f284e163-5476-0c38-106c-094080340f71@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230211041644.1848341-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/3] branch: avoid unnecessary worktrees traversals
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?Rub=C3=A9n=20Justo?=" <rjusto@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:
> "reject_rebase_or_bisect_branch()" was introduced [1] to prevent a
> branch under bisect or rebase from being renamed or copied.  It
> traverses all worktrees in the repository and dies if the specified
> branch is being rebased or bisected in any of them.
>=20
> "replace_each_worktree_head_symref()" was introduced [2] to adjust the
> HEAD in all worktrees after a branch rename succeeded.  It traverses all
> worktrees in the repository and if any of them have their HEAD pointing
> to the renamed ref, it adjusts it.

Thanks for the references to why these were introduced!

> If we could know in advance if the renamed branch is not HEAD in any
> worktree we could avoid calling "replace_each_worktree_head_symref()",
> and so avoid that unnecessary second traversing.

When I first read this paragraph, I thought that the traversing involved
was just a loop through an in-memory data structure, which is not that
costly. It turns out that a travesal involves not only constructing
said data structure but also reading from disk to get the necessary
information, which indeed is very costly. I would include that in the
commit message, but won't insist on that (perhaps it's clear to others
what is meant by traversal).

> Let's rename "reject_rebase_or_bisect_branch()" to a more meaningful
> name "die_if_branch_is_being_rebased_or_bisected()" and make it return,
> if it does not die(), if the specified branch is HEAD in any worktree.
> Use this new information to avoid unnecessary calls to
> "replace_each_worktree_head_symref()".

In later patches, I see that the return value can also indicate that a
branch is an orphan, and that for the sake of code clarity, the calling
function had to have a variable assignment of the form oldref_is_orphan
=3D (oldref_is_head > 1). If this is so, it is probably better to have
this function return something with names. So something like

  #define IS_HEAD 4
  #define IS_ORPHAN 8
  int get_branch_usage_in_worktrees(...) {...}

and then the caller can use these constants whenever it needs to know
what kind of branch this is.

I also see in patch 2 that we're changing what the user sees under
certain inputs. That can be avoided if we move the dying to the caller,
and have this function merely return when the branch is being rebased
or bisected.

  #define IS_BISECTED 1
  #define IS_REBASED 2

or something like that. I would prefer if user-visible behavior didn't
change unnecessarily, and this does not seem like a necessary case.

Other than that, everything looks good.
