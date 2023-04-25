Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4277EC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 05:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjDYF1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 01:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYF1l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 01:27:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B975FDD
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 22:27:40 -0700 (PDT)
Received: (qmail 21659 invoked by uid 109); 25 Apr 2023 05:27:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 05:27:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 528 invoked by uid 111); 25 Apr 2023 05:27:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 01:27:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 01:27:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230425052739.GB4007491@coredump.intra.peff.net>
References: <20230422135001.GA3942563@coredump.intra.peff.net>
 <xmqqy1mhdurt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1mhdurt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 11:01:26AM -0700, Junio C Hamano wrote:

> > +	/*
> > +	 * trim leading whitespace; parse_timestamp() will do this itself, but
> > +	 * it will walk past the newline at eol while doing so. So we insist
> > +	 * that there is at least one digit here.
> > +	 */
> 
> "one digit" -> "one non-whitespace".
> 
> > +	while (dateptr < eol && isspace(*dateptr))
> > +		dateptr++;
> 
> This is an expected change, but
> 
> > +	if (!strchr("0123456789", *dateptr))
> > +		return 0;
> 
> this is not.  Isn't the only problematic case that dateptr being at
> eol?  That is what the proposed log message argued.

Yes, that would be sufficient. I was moving things slightly closer to
what split_ident_line() does by actually checking for numbers. But that
led to the final paragraph in the commit message explaining how it all
ends up the same either way.

So I'll swap this out for:

  if (dateptr == eol)

which I think requires less explanation, as it leaves the function more
like it was originally (and the behavior is the same either way).

> >  	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
> 
> This comment is slightly stale.  dateptr < eol, *eol == '\n', and we
> know the string starting at dateptr is not a run of whitespace and
> that is what makes the parsing stop at eol.

Yeah, I hoped the extra context of the earlier comment would be enough. ;)
But it is probably better to spell it out by expanding this comment.
The code is certainly tricky enough.

-Peff
