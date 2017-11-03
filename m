Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500A120450
	for <e@80x24.org>; Fri,  3 Nov 2017 18:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756104AbdKCS3Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 14:29:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:45712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752259AbdKCS3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 14:29:13 -0400
Received: (qmail 32091 invoked by uid 109); 3 Nov 2017 18:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 18:29:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3497 invoked by uid 111); 3 Nov 2017 18:29:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 14:29:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov 2017 14:29:10 -0400
Date:   Fri, 3 Nov 2017 14:29:10 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Andrew Baumann <Andrew.Baumann@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git tries to stat //HEAD when searching for a repo, leading to
 huge delays on Cygwin
Message-ID: <20171103182910.x7fbwodoegusyc37@sigill.intra.peff.net>
References: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com>
 <20171103010300.3jwme4d6nbxnj6od@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711031324110.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711031324110.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 03, 2017 at 01:32:26PM +0100, Johannes Schindelin wrote:

> > diff --git a/setup.c b/setup.c
> > index 27a31de33f..5d0b6a88e3 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -283,7 +283,9 @@ int is_git_directory(const char *suspect)
> >  	size_t len;
> >  
> >  	/* Check worktree-related signatures */
> > -	strbuf_addf(&path, "%s/HEAD", suspect);
> > +	strbuf_addstr(&path, suspect);
> > +	strbuf_complete(&path, '/');
> > +	strbuf_addstr(&path, "HEAD");
> >  	if (validate_headref(path.buf))
> >  		goto done;
> 
> Yes, that would work around the issue. TBH I expected `/` to not be a
> valid bare repository path (and therefore I thought that `suspect` could
> never be just a single slash), but people do all kinds of crazy stuff, right?

Heh. People _do_ do crazy stuff, but I think here it is just the tool
double-checking if people are doing crazy stuff (which they mostly
aren't) by walking up to the root.

> I note also that there are tons of `strbuf_addstr(...);
> strbuf_complete(..., '/');` patterns in our code, as well as
> `strbuf("%s/blub", dir)`, which probably should all be condensed into
> single function calls both for semantic clarity as well as to avoid double
> slashes in the middle of paths.

Yeah, I had the same thought. This _seems_ like the kind of thing
mkpathdup() would handle, but it doesn't (and as far as I can tell never
did).

Grepping around for calls to strbuf_complete() with '/' shows that most
callers wouldn't benefit. Many do trickier things like setting up a path
ending in slash, and then appending the final element repeatedly while
iterating over a list. Some have a strbuf already and just want to
append the final element to it.

On the other hand, I suspect these are only the cases that are already
conscientious about avoiding double-slashes. There are probably a ton of
xstrfmt("%s/%s", dir, file) equivalents that just aren't careful.

> In the short run, though, let's take your patch. Maybe with a commit
> message like this?

Agreed. There are enough pitfalls to a general path-constructing helper
that I don't think we should hold up a fix while on it.

> -- snipsnap --
> setup: avoid double slashes when looking for HEAD

I see you posted this separately, so I'll review there.

Thanks for finishing it off (I had intended to circle back to it this
morning myself).

-Peff
