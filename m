Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A541F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeH3M1n (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:27:43 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40112 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeH3M1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:27:43 -0400
Received: by mail-qk0-f196.google.com with SMTP id c126-v6so5197471qkd.7
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 01:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prQy2eLzWNlEMpGGsOgOWPn+MfdQKOsi4j5Y/bZJRqU=;
        b=GUElHPcR8rX/SDnT2qaTVfwGUeAwgcZ0O5ZVjNaqzxrA/cJYYigI87/yzAKmlnSP9k
         JNuH4mmtR+ibLdn8uxgXgrYi+dPWUdl6UcJRDOSNUZXH3s05KqvSKjCQhOXlF1p0IZg/
         SqGfwDkgDe8buG0tgJGYNTHYKfFCXVavSM+P1Jr1RWa2+kkAAhSRcOJWRro+9i50zuxO
         syHk5HyRiyoiMwU7utl23UWylSE7X9cPxk10ePXqhsCYlKJrBsF8wKtCAkcIMV7hvhZG
         Q5ABiYO/pwfpoBuR0d6DH7OdWTkH0PB6pbOkCtJa5rU2KJp/ce9UfgG65p4eQSvTH4Z2
         yFpw==
X-Gm-Message-State: APzg51CY/Zenw8DkimxmiVwTBEeIBJW2U+sgDZD/3no/sEohCvivO5Vw
        IU1pgspE7I33H69zCTXVxdYI18TcuoGh+LkMNOTmVw==
X-Google-Smtp-Source: ANB0VdbJ/JgBKZOUwH4iSAIzklobnohXV/yM9uCMEL1mcdnpXVBlU08SPQRUO0EOCuwxjuxT616+6zHGgijMkYp9mWc=
X-Received: by 2002:a37:d78e:: with SMTP id t14-v6mr9801644qkt.220.1535617603511;
 Thu, 30 Aug 2018 01:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-7-sunshine@sunshineco.com> <20180830073642.GC11944@sigill.intra.peff.net>
In-Reply-To: <20180830073642.GC11944@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 04:26:31 -0400
Message-ID: <CAPig+cSSd4kgdfCsgmJ7omTTEn9Qve1DfDUtmJ7qkL5o0JS-hA@mail.gmail.com>
Subject: Re: [PATCH 6/9] worktree: teach 'add' to respect --force for
 registered but missing path
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 3:36 AM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 28, 2018 at 05:20:23PM -0400, Eric Sunshine wrote:
> > +     if ((!locked && opts->force) || (locked && opts->force > 1)) {
> > +             if (delete_git_dir(wt->id))
> > +                 die(_("unable to re-add worktree '%s'"), path);
> > +             goto done;
> > +     }
>
> This "unable to re-add" seemed funny to me at first, since the failure
> is in deletion. I guess we're relying on delete_git_dir() to already
> have said "I had trouble deleting $GIT_DIR/worktrees/foo", and this is
> just the follow-up to tell that the whole operation is cancelled. So
> that makes sense.

Correct, delete_git_dir() has already used error() to explain that it
couldn't delete .git/worktrees/<id>, so this finalizing die() doesn't
need to repeat that.

> I wonder if we should volunteer the information that we're overwriting
> an existing worktree. I guess the user would generally know that
> already, though, since they just specified "-f", so it's probably just
> being overly chatty to do so.

That's my conclusion, as well. An explicit use of --force shouldn't
need such chattiness.
