Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C4C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF4520786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0EcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:32:06 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45592 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgH0EcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:32:05 -0400
Received: by mail-ej1-f67.google.com with SMTP id si26so5790257ejb.12
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 21:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhFeTYa893ExITytSWBCcrBlamEzYR5OUWtUYLMEzfU=;
        b=pTbsInvQTPFeRatiHQZoqDJJ23y9lYOHbGG5mBFrjzn1zMtJoIH16IZqbIVsEQxJSZ
         Ig1cpopAm1+3i5Ov3dOkGnpzH9lW1+IhqeIFDE5/ME8Svi/1mJlVGpvtXGmeVKA0uExr
         4GsV/ESNaaoYDNahiz6aPWM6vZwXZRv9YTPZawFNblQnOsxRQ6V1ne6EVkJhAE0CHU/h
         rjq1iVBdepRA9oJwmLbKI2l+fCnP9DtceG7yRbfGJVl60SUslXmpkM4SV/hg+pOYM0iv
         ma1iJ4dcc2looOtMjft51Ud3Iz0vUFa932iV+nDFTbVoYAABSE6VeYd/dF3fiwRmfOfo
         RhyA==
X-Gm-Message-State: AOAM5307P8ITowGa4w6WfLxVRczc62QG5EkrZfCFICdDNfxbrknE3thh
        yRJLOBIFEKXeHPb9Jg+PFbDDv4HPZYe9uBTKWGw=
X-Google-Smtp-Source: ABdhPJyUB/DmgvJky9w3voEaQ9T8yku5IH4/WRRoPNbNxTp/cmxVmj9iV3Zv8AmuiZE/e8LvR2F6jIvFIu2RQpIN5g0=
X-Received: by 2002:a17:906:80da:: with SMTP id a26mr18444704ejx.311.1598502723721;
 Wed, 26 Aug 2020 21:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com> <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com> <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com> <20200827042157.GC3346457@coredump.intra.peff.net>
In-Reply-To: <20200827042157.GC3346457@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 00:31:52 -0400
Message-ID: <CAPig+cS1uMw6YDVjzb8FbBmC=iVjged-wHu0LF2+trmW-4ZfVw@mail.gmail.com>
Subject: Re: [PATCH] run_command: teach API users to use embedded 'args' more
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:22 AM Jeff King <peff@peff.net> wrote:
> I've actually considered dropping child_process.argv entirely. Having
> two separate ways to do the same thing gives the potential for
> confusion. [...]
>
> Likewise for child_process.env_array.

builtin/worktree.c:add_worktree() is a case in which an environment
strvec is built once and re-used for multiple run_command()
invocations by re-assigning it to child_process.env before each
run_command(). It uses child_process.env rather than
child_process.env_array because run_command() clears
child_process.env_array upon completion, which makes it difficult to
reuse a prepared environment strvec repeatedly.

Nevertheless, that isn't much of a reason to keep child_process.env.
Refactoring add_worktree() a bit to rebuild the environment strvec
on-demand wouldn't be very difficult.
