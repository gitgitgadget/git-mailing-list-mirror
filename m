Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC114C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 05:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjDYFYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 01:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYFYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 01:24:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D524C0F
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 22:24:00 -0700 (PDT)
Received: (qmail 21584 invoked by uid 109); 25 Apr 2023 05:24:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 05:24:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 466 invoked by uid 111); 25 Apr 2023 05:23:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 01:23:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 01:23:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse_commit(): parse timestamp from end of line
Message-ID: <20230425052359.GA4007491@coredump.intra.peff.net>
References: <20230422134150.GA3516940@coredump.intra.peff.net>
 <20230422134703.GB3942326@coredump.intra.peff.net>
 <xmqqcz3tfbx5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz3tfbx5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 10:05:42AM -0700, Junio C Hamano wrote:

> > +	/*
> > +	 * parse to end-of-line and then walk backwards, which
> > +	 * handles some malformed cases.
> > +	 */
> 
> I would say "parse to" -> "jump to", but technically moving forward
> looking for a LF byte is still "parsing".  "some" malformed cases
> being "most plausible" ones (due to how ident.c::fmt_ident() is what
> writes '>' after the string end-user gave as e-mail) may be worth
> mentioning.

I'll expand this to:

  /*
   * Jump to end-of-line so that we can walk backwards to find the
   * end-of-email ">". This is more forgiving of malformed cases
   * because unexpected characters tend to be in the name and email
   * fields.
   */

> > -	dateptr = buf;
> > -	while (buf < tail && *buf++ != '\n')
> > +	for (dateptr = eol; dateptr > buf && dateptr[-1] != '>'; dateptr--)
> >  		/* nada */;
> 
> OK.  Just a style thing, but I found that "; /* nada */" is easier
> to spot that there is an empty statement there.

I found it ugly, too, but it's from earlier. Since the point is to
advance "dateptr", it may be better to turn it into a while loop anyway,
which side-steps the empty statement altogether:

  dateptr = eol;
  while (dateptr > buf && dateptr[-1] != '>')
	dateptr--;

> > -	if (buf >= tail)
> > +	if (dateptr == buf || dateptr == eol)
> >  		return 0;
> 
> Curious when dateptr that wanted to scan back from eol is still at
> eol after the loop.  It is when the ident line ends with ">" without
> any timestamp/tz info.   And the reason why we need to check that
> here is ...

Yeah, though as you saw in the next patch, it is not really sufficient. :)

I think it may be redundant, though.

In the original we already bailed earlier if we didn't find a ">"
(because "buf >= tail" after we advanced it looking for ">"). Here
"dateptr == buf" is checking the same thing (because we walked
backwards).

In the original we'd bail if we failed to find a newline as part of this
loop (because "buf >= tail" after looking for a newline). But that can't
happen here; we've already bailed after memchr() failed to find a
newline). So "dateptr == eol" only triggers if there were no characters
in "buf" to look at.

So I added it only to keep this comment trivially true:

> > -	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
> > +
> > +	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
> >  	return parse_timestamp(dateptr, NULL, 10);
> 
> ... because parse_timestamp() is merely strtoumax() and would
> happily skip over arbitrary number of leading "whitespace" without
> stopping if (dateptr == eol && *eol == '\n').  OK, sad but correct.

But it could also read "dateptr <= eol" and still be true (which is to
say it is mostly accurate, but not quite because of the "soaking up
whitespace" problem fixed by the next patch.

I'll leave the extra condition in this patch, since it's orthogonal to
what this patch is fixing. But in the next one I'll remove it and expand
the comment to explain a bit more.

-Peff
