Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3DC1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 01:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHABAY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 21:00:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726079AbfHABAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 21:00:24 -0400
Received: (qmail 22474 invoked by uid 109); 1 Aug 2019 01:00:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Aug 2019 01:00:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23663 invoked by uid 111); 1 Aug 2019 01:02:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 21:02:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 21:00:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190801010022.GA6553@sigill.intra.peff.net>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
 <20190801002125.GA176307@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801002125.GA176307@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 05:21:25PM -0700, Jonathan Nieder wrote:

> Although as Dscho mentions, it's particularly irritating because it is
> not part of the paginated output.
> 
> I wonder if the ideal might not be to trigger it more selectively, when
> the output actually changed due to a reflog entry.  I mean something
> like
> 
> 	commit 393a9dd0f9762c69f753a8fa0bc89c203c6b4e9e (HEAD, origin/foo, other/pu)
> 	Merge: 18598e40e6 1eba6eb1c2
> 	Author: A U Thor <author@example.com> (see "git help mailmap")
> 	Date:   Tue Jul 30 15:05:41 2019 -0700
> 
> 	    Merge branch 'jt/fetch-cdn-offload' into foo

I actually kind of like that, because it tells you exactly when it is
impacting things (not just that the mailmap was used, but that this
_particular_ name was mapped, which is going to be the most actionable
thing). But I do think the syntax above might end up breaking somebody
who's trying to parse it (people aren't supposed to be parsing log
output, but...).

Something like:

  Author: A U Thor <author@example.com>
  Original-Author: I M Mailmapped <orig@example.com>

gives even more information while leaving the "Author:" line untouched.
But in introducing a new line, it may also be breaking somebody.

I think all of these are riskier than just quietly engaging the mailmap.
That's syntactically identical, so no risk of parsing regressions That's
almost always going to be what people _actually_ want if there's a
mailmap in the repo. The only exception is if they're somehow trying to
do analysis on original versus mapped names. At which point they really
ought to be using a parseable format like --pretty=raw, or "%an <%ae>".

> is *particularly* unactionable in the current state where we're not
> rewriting authors.  I think we should bite the bullet and just flip
> the default to "true", with the config as an escape hatch to allow
> going back to the old behavior.
> 
> Is it too late in the release cycle to do that?  If not, we can do

IMHO no, it is not too late. This is a new feature in this release, and
we're at -rc0. The point of the rc period is to find problems in the new
code. So certainly I think it is not too late to change our minds about
this feature. I could see an argument that instead of changing it now,
we should revert for v2.23 and work on it with less urgency during the
next cycle. But personally I'd see what a day or two of discussion turns
up; if everybody agrees on the path forward and the implementation isn't
complicated, it may be easiest to just proceed now.

> -- >8 --
> Subject: log: use mailmap by default in interactive use

This seems OK to me, though I kind of wonder if anybody really wants
"auto". Unlike log.decorate, which changes the syntax, there is no real
reason to avoid mailmap when somebody else is parsing the output. And I
could imagine it is especially confusing if:

  git log --author=whoever

and

  git log | grep whoever | wc -l

do not agree.

-Peff
