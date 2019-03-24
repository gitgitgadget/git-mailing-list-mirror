Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A16A20248
	for <e@80x24.org>; Sun, 24 Mar 2019 03:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCXDh2 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 23 Mar 2019 23:37:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXDh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 23:37:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so5671107wmf.2
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 20:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QkmUTsshutBr7jmk+qL06xbecTL2ifrkIDeqvBD+B7A=;
        b=nrQU/h7mP5GgsIX26DieOAAsvIkCIGYtZNb4Och98ssp3RSfZXQq2KriV2ueIHT8zk
         dUuzClrosSXXyipyArVhEM4uYDc+cLaZwYAw3dI1AOJxmV8LeD9fXB1A7XW0uIkAVN7L
         mZag6u3PBWNAifgnjploa3iy7pwIsUp3UmQgA6lBLhNutjeAIGiOdve1BN5c2UIkt4Lv
         sN9Msk9ENJCj8gV8sk2s7pBl0uf58dufHHZ7ZYAl9jzOnrJg8LfvI7F7HEd1stZdauko
         Ei3EWnV3l0FPuzgYEFKqvvPar+SkYMCgHx5l3vJA9suXekexq9yT40Qr6zC4PPNJf8wD
         Bkpg==
X-Gm-Message-State: APjAAAUy4c00uMOTxHSaYFDN32Xk1vP7p52pfk6AEvHiDpYWbgKcKPOM
        mms9+nJnRFzhDUugWKfsWYIwi8LQgyobtJyZqM36jg==
X-Google-Smtp-Source: APXvYqwLvhwUdi7iSNfADFt/yNrEgnzIfzCxB8u1dk0RTy6OKVJqgD00ofuCwRW0x5JBCfT50EsqVnZ6NOx3KMEIeNM=
X-Received: by 2002:a1c:d106:: with SMTP id i6mr6228956wmg.134.1553398646165;
 Sat, 23 Mar 2019 20:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com>
 <87d0mic9fm.fsf@evledraar.gmail.com>
In-Reply-To: <87d0mic9fm.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 23 Mar 2019 23:37:17 -0400
Message-ID: <CAPig+cT99t1y8kMdGLF_GU0cvaVm=GKMRJ+xRcgS80rRgdQZDQ@mail.gmail.com>
Subject: Re: [PATCH] Make stashing nothing exit 1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Keith Smiley <keithbsmiley@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 23, 2019 at 3:54 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Mar 23 2019, Keith Smiley wrote:
> > In the case there are no files to stash, but the user asked to stash, we
> > should exit 1 since the stashing failed.
> > ---
> > diff --git a/git-stash.sh b/git-stash.sh
> > @@ -318,7 +318,7 @@ push_stash () {
> >       if no_changes "$@"
> >       then
> >               say "$(gettext "No local changes to save")"
> > -             exit 0
> > +             exit 1
> >       fi
>
>  * Shouldn't we do this consistently across all the other sub-commands?
>    Trying some of them seems 'push' may be the odd one out, but maybe
>    I've missed some (and this would/should be covered by
>    tests). I.e. some single test that does a bunch of ops with no
>    entries / nothing to stash and asserts exit codes.

A bigger question is why is this change desirable? What is the
justification for turning this into an error and possibly breaking
existing automation scripts? Arguing that this case should be an
"error" is difficult considering that there are many other commands
(inside and outside of Git) which exit with 0 when they have nothing
to do. I can't find the message in the archive right now, but I recall
a few months ago Junio shooting down an analogous change to some other
command, so the justification needs to be a strong one.

Also, your Signed-off-by: is missing. See
Documentation/SubmittingPatches.  Thanks.
