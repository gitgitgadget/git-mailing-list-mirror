Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5491C1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 21:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506037AbfJRVB5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 18 Oct 2019 17:01:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51745 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfJRVB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 17:01:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so295001wme.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yzBfWVuv72l4gE4tKAidWIznwJ89s4/v5S0LNwZUOfI=;
        b=CCByk8m825touIod+vrpPDDII84ZY0U/MjwMOtjxy6Xbb80LMmxlK5oJIBxWXv29MV
         0jvPKi0nIoeAzOCoSV2HfKHNLaC9+ps7cniBRzbPal8mO9DNKhlvfOoeufbZyyaB0E9/
         vpbZg1qVfwC5Mb/htVMtG/MszRC1vx58F+c1a+hvJmoxWhnCA6o8GbLRtWYiVKqNTznl
         5/swbuzmtpF5KB9cM9IVUOuYKu0wtkaYzEu5MfV3z79qFG0jtC+vXpn0Mr4kDXmXthp2
         mv8SyIuxiRZwrDsjhTi1oTdbbf52kvwUMO+p25aajdl33XG4PtORW4ZprMhi+yK4koqe
         TtCw==
X-Gm-Message-State: APjAAAVSBrrIDt6Vy8TUMDiLrZgsrm5YhU4cMvj4s95geLD2KZA1rQqf
        F3cUvNkQKVtpq9ihUxoZnunU+HjzCQ+U2UkeqFY=
X-Google-Smtp-Source: APXvYqyn6Nm/pOsajnCEYQqwPoGRaO934bv1EtjxBxPZLg5V8yObfNSkStG9/TS6aRj8qEvh1iwY2T8y79YgEZkikU4=
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr9373483wml.95.1571432514679;
 Fri, 18 Oct 2019 14:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173501.3198-1-szeder.dev@gmail.com> <20191017173501.3198-4-szeder.dev@gmail.com>
 <CAPig+cTLCTPtUWHKVBQEaP9GkrmrnHPwfef8KnktOSqYQY-jPA@mail.gmail.com> <20191018143728.GC29845@szeder.dev>
In-Reply-To: <20191018143728.GC29845@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Oct 2019 17:01:42 -0400
Message-ID: <CAPig+cRSGfaRggDhauSvJyrO1Zu7ZFSG+gfF134z8UV1ovSuEw@mail.gmail.com>
Subject: Re: [PATCH 3/6] completion: return the index of found word from __git_find_on_cmdline()
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 10:37 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Thu, Oct 17, 2019 at 01:52:27PM -0400, Eric Sunshine wrote:
> > > +               case "$1" in
> > > +               --show-idx)     show_idx=y ;;
> > > +               *)              return 1 ;;
> >
> > Should this emit an error message to aid a person debugging a test
> > which fails on a call to __git_find_on_cmdline()? [...]
>
> And printing anything to standard error during completion is
> inherently bad: it disrupts the command line, can't be deleted [...]
> Remaining silent about the unrecognized option
> is in my opinion better, because then the completion script usually
> does nothing, and Bash falls back to filename completion.  Yeah,
> that's not ideal, but at least the user can easily correct it and
> finish entering the command.

I had tunnel-vision and was thinking about this only in the context of
the tests. However, while I agree that spewing errors during
completion is not ideal, aren't there two different classes of errors
to consider? Some errors can crop up via normal usage of Git commands
in Real World situations; those errors should be suppressed since they
are expected and can be tolerated. However, the second class of error
(such as passing a bogus option to this internal function) is an
outright programming mistake by a maintainer of the completion script
itself, and it would be helpful to let the programmer know as early as
possible about the mistake.

Or, are there backward-compatibility or other concerns which would
make emitting error messages undesirable even for outright programmer
mistakes?
