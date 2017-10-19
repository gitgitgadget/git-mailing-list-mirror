Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA591FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 05:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbdJSFFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 01:05:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:57244 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750842AbdJSFFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 01:05:01 -0400
Received: (qmail 1154 invoked by uid 109); 19 Oct 2017 05:05:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 05:05:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6143 invoked by uid 111); 19 Oct 2017 05:05:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 01:05:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 01:04:59 -0400
Date:   Thu, 19 Oct 2017 01:04:59 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, orgads@gmail.com
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
Message-ID: <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com>
 <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 08:20:57PM -0400, Jeff King wrote:

> On Thu, Oct 12, 2017 at 08:18:37PM -0400, Jeff King wrote:
> 
> > Fix this by entering the conditional only when we actually
> > see whitespace. We can apply this also to the
> > IGNORE_WHITESPACE change. That code path isn't buggy
> > (because it falls through to returning the next
> > non-whitespace byte), but it makes the logic more clear if
> > we only bother to look at whitespace flags after seeing that
> > the next byte is whitespace.
> 
> I think there actually _is_ a bug in that code path, but it's unrelated
> to this one. If you have whitespace at the end of the buffer, then we'd
> advance *cp until it matches *endp, and then return whatever is at *endp
> (which is nonsense, or probably a NUL) rather than returning "-1".
> 
> I'm out of time for tonight and not familiar enough with the color-moved
> code to come up with a reasonable test case quickly, but maybe you can
> see if that can trigger bad behavior?

I found a few moments to follow up on this. I'm not sure if it's a bug
or intentional behavior. It's definitely easy to trigger next_byte()
reading *endp (even without ignoring whitespace, we always dereference
it).

This function is always operating on the buffer from an
emitted_diff_symbol, which is NUL-terminated. So *endp is always NUL. So
we'll return "0" at the end of the string.

There are two callers. The first is get_string_hash(), which does:

  while ((c = next_byte(&ap, &ae, o)) > 0)

so we'll break out on the NUL byte. But it also sometimes shrinks the
end-pointer "ae" to skip trailing whitespace.  Or at least it tries to.
It does:

   const char *ap = es->line, *ae = es->line + es->len;
   ...
   while (ae > ap && isspace(*ae))
           ae--;

but AFAICT that loop will never trigger, since *ae will always point to
NUL to begin with. But it points to the expectation that our end-pointer
does not follow the usual one-past-the-end convention, but rather is
meant to point to the actual last character in the string.

The same problem is repeated in the other caller, moved_entry_cmp(),
which tries to eat trailing whitespace for IGNORE_WHITESPACE_AT_EOL. But
it uses the same loop that starts on NUL and will never trigger.

It then goes on to call next_byte(). The extra NUL there should not
cause any problem, because we are just checking for equality between the
two strings (so if they both return NUL at the same time, good; if not,
then we know they are different).

So. That leaves me with:

  - I'm unclear on whether next_byte() is meant to return that trailing
    NUL or not. I don't think it causes any bugs, but it certainly
    confused me for a function to take a cp/endp pair of pointers, and
    then dereference endp. It might be worth either fixing or clarifying
    with a comment.

  - Those loops to eat trailing whitespace are doing nothing. I'm not
    sure if that all works out because next_byte() eats whitespaces or
    not (I think not, because it doesn't eat whitespace for the
    IGNORE_WHITESPACE_AT_EOL case). But I'm not quite sure what a test
    would look like.

-Peff
