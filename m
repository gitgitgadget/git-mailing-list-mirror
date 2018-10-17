Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4C71F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQVtm (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 17:49:42 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36192 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQVtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 17:49:42 -0400
Received: by mail-ot1-f46.google.com with SMTP id x4so24823497otg.3
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 06:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kX3W81HOUI/t3T9OznE2q2bSiHo44LRqSHtz3AqwCrY=;
        b=szbNBwWkyfWdwJAiidVUJcPRrRyOs1KsEDDxGQv0DIw/ExAyoQGh7NIStXXbkU5kXG
         qY/NZbN4Hknkeo/JxZwbr1pwOVoIXnR6iY/cVXjVgtZofWkoNiYYoXmcjOaXJbXIZPM5
         P3zs18EW0IuM9vAZdDi/8wURUSgYOgpTLPkPpM2kMXng4QOO8aeoaDLDSmdS8CYLLdMJ
         ppMKYaDDfbzbRGrK59sht2UuVIfqLifz2h6KEJL9vC8BifirHStqtpfKyO52o430S9rX
         1+CxMgF7klX86pnfsCC8UUTljDZmhUCdVc9G0Iq3afE52jlTGSd2ed1imFieSxfu7KS3
         voOA==
X-Gm-Message-State: ABuFfoiPfGv6Y11I0+GDLYrlSr4O32j3NBi0gzKpRfyR901MIz/2Of8V
        caN2geJzfX6lJEjzarYI7/tZF0C5sTOKL2K8p3eL6g==
X-Google-Smtp-Source: ACcGV61wjoVeKEYpJ+ivuYTJCSYzchb+DBNGW2z3CULOS4HBBjk70au2d2x6CD8IkIS4mWVzJigsRpA7V548u4ySVts=
X-Received: by 2002:a9d:3203:: with SMTP id t3mr15838538otc.187.1539784433071;
 Wed, 17 Oct 2018 06:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181016212438.30176-1-agruenba@redhat.com> <20181017091215.GA2052@sigill.intra.peff.net>
In-Reply-To: <20181017091215.GA2052@sigill.intra.peff.net>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 17 Oct 2018 15:53:41 +0200
Message-ID: <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
Subject: Re: [RFC] revision: Add --sticky-default option
To:     peff@peff.net
Cc:     git@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 17 Oct 2018 at 11:12, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 16, 2018 at 11:24:38PM +0200, Andreas Gruenbacher wrote:
> > here's a long-overdue update of my proposal from August 29:
> >
> >   [RFC] revision: Don't let ^<rev> cancel out the default <rev>
> >
> > Does this look more acceptable that my first shot?
>
> I think it's going in the right direction.
>
> The name "--sticky-default" did not immediately make clear to me what it
> does. Is there some name that would be more obvious?

It's the best I could think of. Better ideas, anyone?

> > Some commands like 'log' default to HEAD if no other revisions are
> > specified on the command line or otherwise.  Currently, excludes
> > (^<rev>) cancel out that default, so when a command only excludes
> > revisions (e.g., 'git log ^origin/master'), it will produce no output.
> >
> > With the --sticky-default option, the default becomes more "sticky" and
> > is no longer canceled out by excludes.
> >
> > This is useful in wrappers that exclude certain revisions: for example,
> > a simple alias l='git log --sticky-default ^origin/master' will show the
> > revisions between origin/master and HEAD when invoked without arguments,
> > and 'l foo' will show the revisions between origin/master and foo.
>
> Your explanation makes sense.
>
> > ---
> >  revision.c     | 31 +++++++++++++++++++++++++++----
> >  revision.h     |  1 +
> >  t/t4202-log.sh |  6 ++++++
>
> We'd probably want an update to Documentation/rev-list-options.txt (I
> notice that "--default" is not covered there; that might be worth
> fixing, too)>

Ok.

> > +static int has_revisions(struct rev_info *revs)
> > +{
> > +     struct rev_cmdline_info *info = &revs->cmdline;
> > +
> > +     return info->nr != 0;
> > +}
>
> So this function is going to replace this flag:
>
> > @@ -2401,8 +2423,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
> >                       argv_array_pushv(&prune_data, argv + i);
> >                       break;
> >               }
> > -             else
> > -                     got_rev_arg = 1;
> >       }
>
> Are we sure that every that hits that "else" is going to trigger
> info->nr (and vice versa)?
>
> If I say "--tags", I think we may end up with entries in revs->cmdline,
> but would not have set got_rev_arg. That's captured separately in
> revs->rev_input_given. But your cancel_default logic:
>
> > @@ -2431,7 +2451,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
> >               opt->tweak(revs, opt);
> >       if (revs->show_merge)
> >               prepare_show_merge(revs);
> > -     if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
> > +     cancel_default = revs->sticky_default ?
> > +                      has_interesting_revisions(revs) :
> > +                      has_revisions(revs);
> > +     if (revs->def && !revs->rev_input_given && !cancel_default) {
>
> doesn't handle that. So if I do:
>
>   git rev-list --count --sticky-default --default HEAD --not --tags
>
> I should see everything in HEAD that's not tagged. But we don't even
> look at cancel_default, because !revs->rev_input_given is not true.
>
> I think you could solve that by making the logic more like:
>
>   if (revs->sticky_default)
>         cancel_default = has_interesting_revisions();
>   else
>         cancel_default = !revs->rev_input_given && !got_rev_arg;
>
> which leaves the non-sticky case exactly as it is today.

Right, I've reworked that.

> > diff --git a/revision.h b/revision.h
> > index 2b30ac270..570fa1a6d 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -92,6 +92,7 @@ struct rev_info {
> >
> >       unsigned int early_output;
> >
> > +     unsigned int    sticky_default:1;
> >       unsigned int    ignore_missing:1,
> >                       ignore_missing_links:1;
>
> Maybe it would make sense to put this next to "const char *def"?
>
> The bitfield would not be as efficient, but I don't think we care about
> packing rev_info tightly.

Ok.

> > diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> > index 153a50615..9517a65da 100755
> > --- a/t/t4202-log.sh
> > +++ b/t/t4202-log.sh
> > @@ -213,6 +213,12 @@ test_expect_success 'git show <commits> leaves list of commits as given' '
> >       test_cmp expect actual
> >  '
> >
> > +printf "sixth\nfifth\n" > expect
> > +test_expect_success '--sticky-default ^<rev>' '
> > +     git log --pretty="tformat:%s" --sticky-default ^HEAD~2 > actual &&
> > +     test_cmp expect actual
> > +'
>
> Yuck, t4202 is a mix of older and newer styles. I'm OK with this as-is
> because you've matched the surrounding code, but these days I'd probably
> write:
>
>   test_expect_success '--sticky-default ^<rev>' '
>         {
>                 echo sixth
>                 echo fifth
>         } >expect &&
>         git log --format=%s --sticky-default ^HEAD~2 >actual &&
>         test_cmp expect actual
>   '

I don't really want to get hung up on such details. test_write_lines
doesn't seem bad, either.

Thanks,
Andreas
