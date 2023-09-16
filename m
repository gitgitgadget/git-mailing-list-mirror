Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC63CD37B2
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 05:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbjIPFcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 01:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjIPFcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 01:32:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7083189
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 22:32:02 -0700 (PDT)
Received: (qmail 919 invoked by uid 109); 16 Sep 2023 05:32:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 05:32:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8934 invoked by uid 111); 16 Sep 2023 05:32:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 01:32:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 01:32:01 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: update curl http/2 info matching for curl 8.3.0
Message-ID: <20230916053201.GB13092@coredump.intra.peff.net>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
 <20230915113443.GB3531587@coredump.intra.peff.net>
 <ZQSkjiyrOac4DK8q@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQSkjiyrOac4DK8q@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 02:38:06PM -0400, Taylor Blau wrote:

> This looks good, too, though I do have one question. The HTTP/2
> specification in 5.1 says (among other things):
> 
>     Streams are identified with an unsigned 31-bit integer. Streams
>     initiated by a client MUST use odd-numbered stream identifiers; those
>     initiated by the server MUST use even-numbered stream identifiers. A
>     stream identifier of zero (0x0) is used for connection control messages;
>     the stream identifier of zero cannot be used to establish a new stream.
> 
> So the parsing you wrote here makes sense in that we consume digits
> between the pair of square brackets enclosing the stream identifier.

Yes, though I'm less concerned with what the standard says than with
what curl's code does (and it uses %d).

> But I think we would happily eat a line like:
> 
>     [HTTP/2] [] [Secret: xyz]
> 
> even lacking a stream identifier. I think that's reasonably OK in
> practice, because we're being over-eager in redacting instead of the
> other way around. And we're unlikely to see such a line from curl
> anyway, so I don't think that it matters.

Yes, you're correct that we'd allow an empty stream identifier. I'm
content to leave it in the name of simplicity.

> If you feel otherwise, though, I think something as simple as:
> 
>     if (skip_iprefix(line, "[HTTP/2] [", &p)) {
>       if (!*p)
>         return 0;
>       while (isdigit(*p))
>         p++;
>       if (skip_prefix(p, "] [", out))
>         return 1;
>     }

Yes, that would work, but...

> would do the trick. I *think* that this would also work:
> 
>     if (skip_iprefix(line, "[HTTP/2] [", &p)) {
>       do {
>         p++;
>       } while (isdigit(*p))
>       if (skip_prefix(p, "] [", out))
>         return 1;
>     }
>
> since we know that p is non-NULL, and if it's the end of the line, *p
> will be NUL and isdigit(*p) will return 0. But it's arguably less
> direct, and requires some extra reasoning, so I have a vague preference
> for the former.

Your do-while is too eager, I think. It advances the first "p" before
we've looked at it, so:

  - we'd match "[HTTP/2] [x1] [foo]", allowing one byte of non-digit
    cruft

  - if the string is "[HTTP/2] [", then "p" is at the NUL after the
    skip_iprefix call, and p++ walks us off the end of the array.

> But this may all be moot anyway, I don't feel strongly one way or the
> other.

My inclination is to leave it. I was actually tempted to just allow
_anything_ in the brackets if only because it makes the code even
simpler, but the "skip past digits" seemed like a reasonable middle
ground.

-Peff
