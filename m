Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9794B1F78F
	for <e@80x24.org>; Mon,  1 May 2017 21:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbdEAViZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 17:38:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:43394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752999AbdEAViX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 17:38:23 -0400
Received: (qmail 27571 invoked by uid 109); 1 May 2017 21:38:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 21:38:23 +0000
Received: (qmail 6256 invoked by uid 111); 1 May 2017 21:38:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 17:38:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 17:38:20 -0400
Date:   Mon, 1 May 2017 17:38:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     David CARLIER <devnexen@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] small memory leak fix
Message-ID: <20170501213820.4miu5qizzifmavrb@sigill.intra.peff.net>
References: <C3A43A45-9120-4755-AE42-FD33F68F3FCB@gmail.com>
 <CAGZ79kYfoBOc+hVhm7XEg1TvYQ8myF4f=0wSwDs-agYxaArsWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYfoBOc+hVhm7XEg1TvYQ8myF4f=0wSwDs-agYxaArsWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 01:50:57PM -0700, Stefan Beller wrote:

> > diff --git a/remote.c b/remote.c
> > index 9f83fe2c4..2f8cb35a3 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -742,6 +742,8 @@ int for_each_remote(each_remote_fn fn, void *priv)
> >  r->push = parse_push_refspec(r->push_refspec_nr,
> >      r->push_refspec);
> >  result = fn(r, priv);
> > + free_refspecs(r->push, r->push_refspec_nr);
> > + free_refspecs(r->fetch, r->fetch_refspec_nr);
> 
> After freeing the refspec, r->push/fetch still points to
> the (now free'd) memory. We'd want to reset it to NULL as well,
> such that e.g. in this function
> 
>     if (!r->fetch)
>         ...
> 
> still works.
> 
> After reading this, I think we'd rather want to keep the fetch/push refspec
> around for the next access of the struct remote, and only free the memory
> when the remote itself is freed?
> 
> That however is a problem as we never free them, they are globals :(

Yeah, I think the point is that the whole "remotes" array is a
program-length global that never goes away (and must not, because after
read_config() sets the "loaded" flag, we would never reload it).

The "fetch" and "push" bits are lazily parsed from the refspec strings,
but are intended to have the same lifetime. Unlike the rest of it, we
_could_ drop them after use and then lazy-parse them again.

But note that we call an arbitrary callback in this function. What
expectations does it have for the lifetimes? Do any of the callbacks
record pointers to the refspecs? Or for that mater, the patch as shown
frees the refspecs even if we didn't just lazily allocate them in this
function (e.g., if we did so in remote_get_1()).

So I don't think freeing them is safe unless we do a complete audit of
access to those refspecs. And it's probably not worth the trouble; these
should just follow the same global-until-exit allocation scheme as the
rest of "struct remote".

-Peff
