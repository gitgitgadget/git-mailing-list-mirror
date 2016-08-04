Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273B420193
	for <e@80x24.org>; Thu,  4 Aug 2016 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759000AbcHDVWE (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 17:22:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:55010 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758993AbcHDVWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 17:22:03 -0400
Received: (qmail 15893 invoked by uid 102); 4 Aug 2016 21:22:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 17:22:01 -0400
Received: (qmail 16698 invoked by uid 107); 4 Aug 2016 21:22:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 17:22:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 17:21:57 -0400
Date:	Thu, 4 Aug 2016 17:21:57 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 3/7] trace: use warning() for printing trace errors
Message-ID: <20160804212157.cn7ecyxcbyf4okd7@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
 <20160803225826.hlr273h4cy2hcfyk@sigill.intra.peff.net>
 <xmqqk2fw1d41.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2fw1d41.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 01:41:02PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right now we just fprintf() straight to stderr, which can
> > make the output hard to distinguish. It would be helpful to
> > give it one of our usual prefixes like "error:", "warning:",
> > etc.
> >
> > It doesn't make sense to use error() here, as the trace code
> > is "optional" debugging code. If something goes wrong, we
> > should warn the user, but saying "error" implies the actual
> > git operation had a problem. So warning() is the only sane
> > choice.
> >
> > Note that this does end up calling warn_routine() to do the
> > formatting. So in theory, somebody who tries to trace from
> > their warn_routine() could cause a loop. But nobody does
> > this, and in fact nobody in the history of git has ever
> > replaced the default warn_builtin (there isn't even a
> > set_warn_routine function!).
> 
> I think the last bit is about to change; cf. 545f13c0 (usage: add
> set_warn_routine(), 2016-07-30) on cc/apply-am topic.

Thanks, I meant to check this series against "pu" to make sure there are
no new callers for write_or_whine_pipe(), but forgot to.

It looks like that same topic does add one new caller, and switches the
"fprintf" inside it to use warning().

IMHO the call added by 19a73ac (builtin/apply: make try_create_file()
return -1 on error, 2016-07-30) should just be a regular:

  if (write_in_full(...) < 0)
        error(...);

We don't care about the weird pipe handling there (we know we're writing
to a file we just created), and the way the error message is passed in
just makes things weird. Plus it seems more like an error() than a
warning (e.g., we call error() immediately below when close() fails!).
But 8fab3c6 (write_or_die: use warning() instead of fprintf(stderr,
...), 2016-07-30)  makes it an unconditional warning (that commit, btw,
has a bug in that it retains the trailing newline of the message, even
though warning() will add one itself).

So I'd suggest that series drop the call write_or_whine_pipe() and drop
8fab3c6 entirely.

I wondered if that would then let us drop set_warn_routine(), but it
looks like there are other warning() calls it cares about. So that would
invalidate the last paragraph here, though I still think converting the
trace errors to warning() is a reasonable thing to do.

-Peff
