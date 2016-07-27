Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCBA203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbcG0RjT (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:39:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:49923 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756658AbcG0RjS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:39:18 -0400
Received: (qmail 31921 invoked by uid 102); 27 Jul 2016 17:39:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 13:39:18 -0400
Received: (qmail 18651 invoked by uid 107); 27 Jul 2016 17:39:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 13:39:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 13:39:15 -0400
Date:	Wed, 27 Jul 2016 13:39:15 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Phil Pennock <phil@pennock-tech.com>,
	Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727173915.GA32219@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
 <20160727135820.GC14928@sigill.intra.peff.net>
 <xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 10:18:11AM -0700, Junio C Hamano wrote:

> > Hrm. Since Ted was not cc'd, it is not clear to me whether this is
> > coincidental or in response to the thread over in
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/299201
> >
> > To summarize, I think the conclusion there was that we would go with at
> > least the 't' and 'r' formatters in the short term. The 'i/I' ones were
> > not something Ted cared about that much, I think, but they do make
> > things orthogonal with the other ident dates.
> 
> I forgot about that thread after it stalled without drawing
> conclusion, after Ted asked if anybody has a strong opinion
> and saw only one response to it at
> 
>   https://public-inbox.org/git/20160711164317.GB3890%40thunk.org/
> 
> So, what is the next step?  Apply
> 
>   https://public-inbox.org/git/20160710055402.32684-1-tytso%40mit.edu/
> 
> but exclude %g[iI] bits out of that patch while doing so?

After having thought about it, I'm inclined to leave in the "%gi".
There's no real rationale for doing "%gr" and "%gt" and not "%gi" except
"well, Ted didn't need it". And it does make it match the author and
committer date-formatting (except for the 'd' formats, of course).

I do think with the new "unix" format in jk/reflog-date, the interface
to the reflog code could be simplified; we don't need a function to pull
out just the timestamp any more. Something like the diff below.

However, I see a few remaining issues with Ted's original:

  - the refactored get_reflog_message() tries to return NULL, but the
    return type of the function is void. Presumably this should just be
    "return"?

  - ditto, the new get_reflog_time_t returns NULL, but wants an unsigned
    long (though this function goes away with my squash below)

  - show_reflog_date can return NULL, but we blindly feed its return
    value to strbuf_addstr(). I'm not sure under what conditions it
    _would_ return NULL, but that would cause a segfault

  - there should probably be tests in t6006 for the new formats

  - my squash below cuts out the use of gm_time_t(). But I don't think
    it should be necessary, as the reflog timestamp should already be in
    GMT, I would think. But maybe I am missing something.

I actually think Phil's patch from today is a little cleaner for most of
these, as it returns the values via out-parameters, and uses the return
value for "did we get anything?".

-Peff
