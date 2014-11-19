From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 15:17:21 -0500
Message-ID: <20141119201721.GC10361@peff.net>
References: <6997784.RuzRO1AFsK@al>
 <20141119190800.GB9908@peff.net>
 <1456931.yaNzKr1t0X@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:17:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrBgt-0000VL-DC
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbaKSURX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:17:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:42442 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932166AbaKSURW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:17:22 -0500
Received: (qmail 28750 invoked by uid 102); 19 Nov 2014 20:17:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 14:17:22 -0600
Received: (qmail 7090 invoked by uid 107); 19 Nov 2014 20:17:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 15:17:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 15:17:21 -0500
Content-Disposition: inline
In-Reply-To: <1456931.yaNzKr1t0X@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 08:42:19PM +0100, Peter Wu wrote:

> >   git remote set-url --push gh $(git config remote.gh.url)
> >   git remote set-url gh new-fetch-url
> 
> Indeed, and not having a push URL is not uncommon (that is, always the
> case when a new remote is added or just cloned). Compare the above
> against this one:
> 
>     git remote set-url --fetch new-fetch-url
> 
> This is less verbose and is much more intuitive.

I agree your suggestion is a nicer way to do this. I'm just not sure
that this swapping is all that common an operation. If there were no
cost, I wouldn't mind. But I'm mostly concerned about the funny,
non-intuitive behavior of "git remote set-url foo" that is created by
this.

> > would replace both the "url" _and_ "pushurl" values in the third step,
> > since we did not specify --fetch.  But it is in fact identical whether
> > you run it with "--fetch" or not.  That is, it creates a weirdly
> > non-orthogonal interface.
> 
> Step three currently only replaces the fetch URL as an explicit push URL
> (remote.gh.pushurl) is set in step two (and therefore remote.gh.url does
> not become the implicit push URL).
> 
> This might be a bug, but since it has been so long this way I was
> worried that people actually rely on this behavior.

I don't think this is a bug. I think that "git fetch set-url" without
"--push" is a de-facto "--fetch" already. Which makes sense, as there
isn't a "--fetch" now (and the "--push" variant and "pushurl" grew after
the fact, so the "url" option serves double-duty as both the single url
and the "fetch" half).

And that's what makes the proposed interface funny. Omitting "--fetch"
is already a de-facto "--fetch", and sometimes the two behave the same,
and sometimes differently. Calling the option "--keep-push" would be a
more accurate description, but that is rather clunky.

> The patch is not tiny, but also not overly large either even if it has
> similar pieces of code duplicated. Care has been taken of to keep
> backwards compatibility which has also increased the size.

Yeah, sorry, I shouldn't have even mentioned patch size. I appreciate
your attention to backwards-compatibility, and the patch should be as
large as it needs to safely implement the desired behavior. It's really
the resulting interface that I'm a bit negative on (which can be related
to code size, in the sense that a simple interface can often be
implemented simply, but here we have to deal with historical corner
cases).

So I dunno. I do not think what you are proposing is the end of the
world, but it would be nice to resolve the inconsistency I mentioned.
Perhaps we can see what others think.

> By the way, in the old code there was a memleak as strbuf was not
> released at the end of the function, isn't it?

Yes. We are often quite lazy about such leaks in functions that are
known to return straight to the program exit, but it does not hurt to
clean up here.

-Peff
