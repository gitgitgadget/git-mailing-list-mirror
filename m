Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD8C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354500AbhLBAfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:35:52 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:37509 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354486AbhLBAfs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:35:48 -0500
Received: by mail-pf1-f179.google.com with SMTP id 8so26280224pfo.4
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 16:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R79bdG02kgi+8zsJArVihOpVRR1Fjpdetl6OfTu7hUw=;
        b=kcMZbQgxghLvQgbPur/CVVuhLT6XJ+emOPhew2D4XIjtVkoFEogP+IEPRUi//gN1Zf
         Ei1BAKJ1es7c/DTvJ6uB+M1NFEHdp6dDNNyUNFi8wLVXCxOMJhCIlp4HXBbqVvvtK8wx
         w2nLkJtzDEWW9eayLke+5EqJc4urDqyktrvOFO4cnNXGd9COqS8UCjWrc+Vb+9a/PcqN
         LCy6Z447WM04v8bJSz1oMxq6FmI+NMMsQSCV3/H9p0AOuLF3+vlvv2jyaaA3jxtSgN/e
         +DDgBVmbU/FPiSodm66lYpJjn3Gj9VdMgOblPB+e3j1syjkhSc7V04AOj1ekv6PgD9UO
         ihFw==
X-Gm-Message-State: AOAM532nXu1irK1wqqUWfQC4yL/kUFoY28eBXp34Gfvv6p+eDIwfgIDq
        gFJF/I3AlKDQYWVtM70kfVmOEfGBlaPEjZsZJrk=
X-Google-Smtp-Source: ABdhPJykhMoBMW6x/fL4viMlEHx9yf5mTusHITqSAG3mhCkxKQc2Sl1LI1x8lUxq/3huJKGQy7IP4U8DDWWJhdKwpoA=
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id
 j9-20020a056a00234900b004a80d87e8admr9699584pfj.15.1638405146483; Wed, 01 Dec
 2021 16:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-5-andersk@mit.edu>
 <CAPig+cSNP-RBmsWWfT690-shFUCZ3J0X+FBiNjCqg=AkoBMBqQ@mail.gmail.com>
 <f8262c3b-2ca5-4920-1379-41ff29b37d9f@mit.edu> <CAPig+cRX94vMLkW=dAKncPTuuk0Opaj+8-Yqe-qFD1b7mrZ89A@mail.gmail.com>
In-Reply-To: <CAPig+cRX94vMLkW=dAKncPTuuk0Opaj+8-Yqe-qFD1b7mrZ89A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 19:32:15 -0500
Message-ID: <CAPig+cT3psyPhsssvJsQw4wzTMLOxf0rhP4H7V4s5g9Wd_kK1g@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] worktree: simplify find_shared_symref() memory
 ownership model
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 7:13 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> If we instead hoist ownership of `worktrees` up to execute_commands()
> -- which calls execute_commands_atomic() or
> execute_commands_non_atomic() -- then we can get by with retrieving
> the worktrees just once, and all those noise changes in update() can
> be dropped since it will no longer be responsible for allocating or
> freeing `worktrees`. For instance:
>
>     static void execute_commands(...)
>     {
>         struct worktree **worktrees;
>         ...
>         worktrees = get_worktrees();
>          if (use_atomic)
>             execute_commands_atomic(commands, si, worktrees);
>         else
>             execute_commands_non_atomic(commands, si, worktrees);
>         free_worktrees(worktrees);
>         ...
>     }
>
> and then execute_commands_atomic() and execute_commands_non_atomic()
> can pass `worktrees` along to update().

By the way, I wouldn't typically recommend this sort of change for
public API since it probably exposes too much implementation detail to
callers, but as these are all private (static) worker functions --
with very few callers, moreover -- I don't find it terribly worrying.
