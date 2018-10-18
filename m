Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C831F453
	for <e@80x24.org>; Thu, 18 Oct 2018 12:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeJRUSz (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 16:18:55 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33455 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeJRUSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 16:18:55 -0400
Received: by mail-ot1-f47.google.com with SMTP id q50so29542530otd.0
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 05:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXgeujVD7xwkMHXMcqtshrtyahoxlGFUTPIL7jjhLKE=;
        b=cGg035/L+mfoYKOdSqYqZ0OIlfY1kvluOH2RazINreapnkAnGD3lXOJtc+IEK3ZB65
         0dGIHTDjum9f/BFTV1j7eZMOgugV0lxF6WWwAz9bzEtSSp9XUlUck6kiTiDhdQq6jdrS
         ZWk1uu0YnzqczK+Y1yW8apdURlNwE/n6ipaWfEw/3s8BtAjgO25u0khMsaMpLoc4cOXY
         VBQ1lSy1tv52xaUrXe/OKBNTXIXF47NtP9QmBrjG4TAgDFCqyYmYUimK2QP9FB8siOdW
         bsBRZFbQ0rDnmmchasGlQfWSkS9wTCEaGA1zgz1lvT8rgXwGmeHD7X3ncluy6zmaWGyP
         mexQ==
X-Gm-Message-State: ABuFfojeBdqdSqYeUFiTlWi4H/feWFBUpJEJVO4FNrz4l4CDa0l4GVVg
        Ny+iyvEsMWzwLV57zhW/2ZxtK7a0LRqqHZANeiqDMQ==
X-Google-Smtp-Source: ACcGV62B4Lb0/oc+GD6r9r+4NNxFONedvSIl6lQ2zvlXp2iBK12dKwvHovY4IWisRaOTFdEzFZynxBddr42YRXKXS/I=
X-Received: by 2002:a9d:3203:: with SMTP id t3mr18165307otc.187.1539865089306;
 Thu, 18 Oct 2018 05:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181016212438.30176-1-agruenba@redhat.com> <20181017091215.GA2052@sigill.intra.peff.net>
 <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
 <20181017181350.GB28326@sigill.intra.peff.net> <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
 <20181018064845.GB23537@sigill.intra.peff.net> <xmqqlg6vu4dw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg6vu4dw.fsf@gitster-ct.c.googlers.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Oct 2018 14:17:58 +0200
Message-ID: <CAHc6FU7m=ikPyvzh0ztyOgfQjGD0oKEfGVxeRPRBy1Lh0VD+Fg@mail.gmail.com>
Subject: Re: [RFC] revision: Add --sticky-default option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     peff@peff.net, git@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Oct 2018 at 08:59, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> > Just to play devil's advocate, how about this:
> >
> >   git log --branches=jk/* --not origin/master
> >
> > Right now that shows nothing if there are no matching branches. But I
> > think under the proposed behavior, it would start showing HEAD, which
> > seems counter-intuitive.
> >
> > Or are we going to count any positive selector as a positive ref, even
> > if it matches nothing?
>
> That sounds like an intuitive behaviour of the command, but I may
> change my mind when I look at other examples.
>
> When viewing that "--branches=jk/*" example in isolation, yes, these
> positive selectors that could produce positive revs should defeat
> the --default, especially when it is built-in (like "log").

I agree, that's the kind of behavior I had in mind. (And I think
that's also what the code implements.)

> When given by the user, I am not sure.  With something like this:
>
>         git rev-list --default=HEAD --branches=jk/* ^master
>
> clearly the user anticipates that jk/* may or may not produce any
> positive refs; otherwise there is no point specifying the default.

With positive selectors, it is meaningful if the selectors match
nothing. So in the above example, if jk/* matches nothing, I would
really expect no output, and the default should not be applied.
So we should just document that --default=<rev> only sets the default
in case the default is used.

> But anyway...
>
> > I could buy that, though it means that the
> > command above is subtly different from one or both of:
> >
> >   branches() {
> >     git for-each-ref --format='%(refname)' refs/heads/jk/*
> >   }
> >
> >   # is --stdin a selector, too?
> >   branches | git log --stdin --not origin/master

Yes, it's a positive selector (since --not doesn't apply to --stdin).

> >   # here we have no idea that the user did a query and must show HEAD
> >   git log $(branches) --not origin/master

In this case, 'git log' is more used like git rev-list which doesn't
default to HEAD. The 'git log --no-default' would neatly restore
sanity here.

> OK, scrap that---just as I predicted a few minutes ago, I now think
> that "do we have a positive selector that can produce zero or more
> result?" is an ill-defined question X-<.
>
> Thanks for a doze of sanity.

Andreas
