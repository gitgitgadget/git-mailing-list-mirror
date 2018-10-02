Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FA61F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJCDQe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:16:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:39054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726769AbeJCDQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:16:34 -0400
Received: (qmail 14749 invoked by uid 109); 2 Oct 2018 20:31:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 20:31:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6131 invoked by uid 111); 2 Oct 2018 20:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 16:30:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 16:31:24 -0400
Date:   Tue, 2 Oct 2018 16:31:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] coccicheck: process every source file at once
Message-ID: <20181002203124.GC2014@sigill.intra.peff.net>
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net>
 <CA+P7+xrjpEe_3_mAwZ73O2JP2Pd518OFnSf+gfmbTJW7A3Q=Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrjpEe_3_mAwZ73O2JP2Pd518OFnSf+gfmbTJW7A3Q=Nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 01:00:21PM -0700, Jacob Keller wrote:

> > > This is nearly a 4x decrease in the time required to run make
> > > coccicheck. This is due to the overhead of restarting spatch for every
> > > file. By processing all files at once, we can amortize this startup cost
> > > across the total number of files, rather than paying it once per file.
> >
> > One minor side effect is that we lose the opportunity to parallelize
> > quite as much. However, I think the reduction in total CPU makes it well
> > worth that (and we still have 8 cocci files and growing, which should
> > keep at least 8 cores busy).
> >
> 
> I don't think we do any less than previously, because we are doing
> each file in a for-loop, so those would all be serial anyways.

Yeah, sorry to be unclear. This is a strict improvement on what was
there before. We had floated some patches to do the full NxM
parallelization, but I think this path is better because of the
reduction in actual CPU used (and if more recent versions of spatch can
parallelize internally, we'll eventually get the best of both worlds).

> > > diff --git a/Makefile b/Makefile
> > > index df1df9db78da..b9947f3f51ec 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2715,10 +2715,8 @@ endif
> > >  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> > >       @echo '    ' SPATCH $<; \
> > >       ret=0; \
> > > -     for f in $(COCCI_SOURCES); do \
> > > -             $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> > > -                     { ret=$$?; break; }; \
> > > -     done >$@+ 2>$@.log; \
> > > +     ( $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) || \
> > > +             { ret=$$?; }; ) >$@+ 2>$@.log; \
> >
> > This looks pretty straight-forward. I wondered if we could get rid of
> > the "ret" handling, since we don't need to pass the error back out of
> > the loop. But it's also used for the "show the log only on error" logic
> > below:
> >
> 
> We could probably get rid of it by doing the spatch without an ||, and
> then just save $?.

Actually, I guess we do not need to save $? at all, since we have only a
single process to care about. So even simpler:

  spatch ... 2>$@+ 2>$@.log ||
  {
	cat $@.log
	exit 1
  }
  # if we get here, we were successful
  mv $@+ $@ ;# etc

would work. That's missing all the Makefile=required backslashes and
semicolons, of course. ;)

-Peff
