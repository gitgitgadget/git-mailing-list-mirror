Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA96E1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbcHZUF3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:05:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:33778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751135AbcHZUF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:05:28 -0400
Received: (qmail 1485 invoked by uid 109); 26 Aug 2016 20:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Aug 2016 20:04:30 +0000
Received: (qmail 28097 invoked by uid 111); 26 Aug 2016 20:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Aug 2016 16:04:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Aug 2016 16:04:26 -0400
Date:   Fri, 26 Aug 2016 16:04:26 -0400
From:   Jeff King <peff@peff.net>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     "sbeller@google.com" <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "j6t@kdbg.org" <j6t@kdbg.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "stefanbeller@gmail.com" <stefanbeller@gmail.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH v11 0/8] submodule inline diff format
Message-ID: <20160826200426.l3eu2mojgmjdz2ec@sigill.intra.peff.net>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
 <CAGZ79kao12f8VTT3uxRvAUBhvbfSLjsYRjidTau3M-Kf81uXDQ@mail.gmail.com>
 <1472241486.28343.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1472241486.28343.10.camel@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 07:58:07PM +0000, Keller, Jacob E wrote:

> > >  char *git_pathdup_submodule(const char *path, const char *fmt,
> > > ...)
> > >  {
> > > +       int err;
> > >         va_list args;
> > >         struct strbuf buf = STRBUF_INIT;
> > >         va_start(args, fmt);
> > > -       do_submodule_path(&buf, path, fmt, args);
> > > +       err = do_submodule_path(&buf, path, fmt, args);
> > >         va_end(args);
> > > +       if (err)
> > 
> > Here we need a strbuf_release(&buf) to avoid a memory leak?
> 
> No, cause we "strbuf_detach" after this to return the buffer? Or is
> that not safe?

That code path is OK. I think the question is whether you need to
release the buffer in the "err" case where you return NULL and don't hit
the strbuf_detach.

IOW, does do_submodule_path() promise that when it returns an error,
"buf" has been left uninitialized? Some of our strbuf functions do, but
I do not know offhand about do_submodule_path().

-Peff
