Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A6B211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 07:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfAFHCB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 6 Jan 2019 02:02:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35992 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfAFHCB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 02:02:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so44672602qtn.3
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 23:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TNGEsVmxStaZD6sRNNtZsljG7hujhNU1p+FA5o53e08=;
        b=lBZF2hO2A9GcymLZFoZoK0ysvc65D4GWe1p5kt9k7AiBJWo+kAOTdZPJBHnPV/rQ3n
         z8en/E8lSle4zyzD7gq+ryUNwzZvqR4sQfQGTRcYMssBaHsGY1+RBet53HZP4w+19LxU
         pYn3JXMr3FvHjt6OE1vzvb7UcXgGVmSzqIuIWFoqfShMCdWgtxeCqYK3j3sjhFbrgXcp
         bFY7xFOe4C3FX6T3rENvNt+IuZ/42e1PLtEDC7SiaF99UW7usljFZck6eVkNtt3037oE
         cgIbe/gSx7nSKI1dQT3M9DH/XIGQr4L+35vK5HlKdGHYVCqseRQffvVvT5Feu2c/3bBN
         0Kkw==
X-Gm-Message-State: AA+aEWYRlHuXkx54ltd65fcK2UUDGTM5pEtMXJIoWE81tSr1iRAI3srT
        7KFXg198iZcaZvIxEnKOpPnJRl9nqGbOp2KL+rA=
X-Google-Smtp-Source: AFSGD/Uwp02dLIMzdHIE+ZPVjGjTDhVxv1kClDIYtq5hO0+u8S4NfLZ7gE/iHkL98NsJaMexO15NTbFzK3T86zRYH20=
X-Received: by 2002:ac8:2a81:: with SMTP id b1mr56474450qta.110.1546758120763;
 Sat, 05 Jan 2019 23:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20181216121239.10017-1-pclouds@gmail.com> <20181216144657.31181-1-pclouds@gmail.com>
 <xmqqftu8avfu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftu8avfu.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Jan 2019 02:01:51 -0500
Message-ID: <CAPig+cTt3JZKjE0Kq+ZaHfYvqvXOvtADGfb6kbRKiUTX2NDdQQ@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: allow to (re)move worktrees with
 uninitialized submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 4, 2019 at 5:51 PM Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> > Uninitialized submodules have nothing valueable for us to be worried
> > about. They are just SHA-1. Let "worktree remove" and "worktree move"
> > continue in this case so that people can still use multiple worktrees
> > on repos with optional submodules that are never populated, like
> > sha1collisiondetection in git.git when checked out by doc-diff script.
>
> Is this a fair description for this 1-patch topic?
>
>         "git worktree remove" and "git worktree move" failed to work
>         when there is an uninitialized submodule, which has been fixed.

Saying "failed to work" makes it sound as if those two subcommands are
broken or buggy, which is not the case. Instead, they are overly
cautious and refuse to allow the operation if _any_ submodule
(initialized or not) is detected. This patch just loosens that check
to allow the operations to succeed for uninitialized submodules, thus
avoiding this (existing) annoying behavior, using git.git as an
example:

    % cd git
    % git worktree add --detach ../foo
    % git worktree remove ../foo
    fatal: working trees containing submodules cannot be moved or removed

Perhaps the change could instead be summarized as:

    "git worktree remove" and "git worktree move" were overly
    cautious, refusing to operate if any submodule was detected, even
    an uninitialized one. This safeguard has been refined to take only
    initialized submodules into account since worktrees with
    uninitialized ones can be safely removed and moved.
