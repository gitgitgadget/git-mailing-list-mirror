Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9841F4B6
	for <e@80x24.org>; Wed, 15 May 2019 01:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEOBqY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:46:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726174AbfEOBqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:46:24 -0400
Received: (qmail 14115 invoked by uid 109); 15 May 2019 01:46:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 May 2019 01:46:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18511 invoked by uid 111); 15 May 2019 01:47:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 21:47:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 21:46:22 -0400
Date:   Tue, 14 May 2019 21:46:22 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Antonio Ospite <ao2@ao2.it>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] get_oid: handle NULL repo->index
Message-ID: <20190515014622.GB13255@sigill.intra.peff.net>
References: <20190511205711.tdclwrdixaau75zv@dcvr>
 <20190511223120.GA25224@sigill.intra.peff.net>
 <20190511230204.GA18474@sigill.intra.peff.net>
 <20190514135455.GA17927@sigill.intra.peff.net>
 <CACsJy8AvsyOz2G1zjRjpKYVZ0DLKj02-v=hXJHS0BRHnxoeWAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AvsyOz2G1zjRjpKYVZ0DLKj02-v=hXJHS0BRHnxoeWAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 08:24:34AM +0700, Duy Nguyen wrote:

> On Tue, May 14, 2019 at 8:54 PM Jeff King <peff@peff.net> wrote:
> > diff --git a/sha1-name.c b/sha1-name.c
> > index 775a73d8ad..455e9fb1ea 100644
> > --- a/sha1-name.c
> > +++ b/sha1-name.c
> > @@ -1837,7 +1837,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
> >                 if (flags & GET_OID_RECORD_PATH)
> >                         oc->path = xstrdup(cp);
> >
> > -               if (!repo->index->cache)
> > +               if (!repo->index || !repo->index->cache)
> >                         repo_read_index(repo);
> 
> We could even drop the "if" and call repo_read_index()
> unconditionally. If the index is already read, it will be no-op
> (forcing a reread has always been discard_index(); read_index();)

I think you missed my bit after the "---":

  Arguably this code should just unconditionally call repo_read_index(),
  which should be a noop if the index is already loaded. But I wanted to
  do the minimal fix here, without getting into any subtle differences
  between what checking index->cache versus index->initialized might
  mean.  Anybody who wants to dig into that is welcome to make a patch
  on top. :)

> Thanks for catching this by the way. I'll need to go through all
> the_index conversion to see if I left similar traps like this.

Yeah. I could not find any others, but it would not hurt to have a
second set of eyes.

Also from my earlier message, if you missed it:

  I also wondered if we should simply allocate an empty index whenever
  we have a non-toplevel "struct repository", which might be less
  surprising to other callers. I don't have a strong opinion either way.
  I did grep around for other callers which might have similar problems,
  but couldn't find any.

-Peff
