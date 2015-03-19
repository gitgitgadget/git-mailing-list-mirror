From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Thu, 19 Mar 2015 01:26:20 -0400
Message-ID: <20150319052620.GA30645@peff.net>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 19 06:26:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYSyU-0003Cb-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 06:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbbCSF0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 01:26:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:35039 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750891AbbCSF0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 01:26:23 -0400
Received: (qmail 3544 invoked by uid 102); 19 Mar 2015 05:26:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 00:26:23 -0500
Received: (qmail 10159 invoked by uid 107); 19 Mar 2015 05:26:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 01:26:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 01:26:20 -0400
Content-Disposition: inline
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265785>

On Tue, Mar 17, 2015 at 05:00:02PM +0100, Michael Haggerty wrote:

> My main questions:
> 
> * Do people like the API? My main goal was to make these functions as
>   painless as possible to use correctly, because there are so many
>   call sites.
> 
> * Is it too gimmicky to encode the base together with other options in
>   `flags`? (I think it is worth it to avoid the need for another
>   parameter, which callers could easily put in the wrong order.)

I definitely like the overall direction of this. My first thought was
that it does seem like there are a lot of possible options to the
functions (and OR-ing the flags with the base does seem weird, though I
can't think of a plausible case where it would actually cause errors).
Many of those options don't seem used in the example conversions (I'm
not clear who would want NUM_SATURATE, for example).

I wondered if we could do away with the radix entirely. Wouldn't we be
asking for base 10 most of the time? Of course, your first few patches
show octal parsing, but I wonder if we should actually have a separate
parse_mode() for that, since that seems to be the general reason for
doing octal parsing. 100000644 does not overflow an int, but it is
hardly a reasonable mode.

I also wondered if we could get rid of NUM_SIGN in favor of just having
the type imply it (e.g., convert_l would always allow negative numbers,
whereas convert_ul would not). But I suppose there are times when we end
up using an "int" to store an unsigned value for a good reason (e.g.,
"-1" is a sentinel value, but we expect only positive values from the
user). So that might be a bad idea.

I notice that you go up to "unsigned long" here for sizes. If we want to
use this everywhere, we'll need something larger for parsing off_t
values on 32-bit machines (though I would not at all be surprised with
the current code if 32-bit machines have a hard time configuring a
pack.packSizeLimit above 4G).

I wonder how much of the boilerplate in the parse_* functions could be
factored out to use a uintmax_t, with the caller just providing the
range. That would make it easier to add new types like off_t, and
possibly even constrained types (e.g., an integer from 0 to 100). On the
other hand, you mentioned to me elsewhere that there may be some bugs in
the range-checks of config.c's integer parsing. I suspect they are
related to exactly this kind of refactoring, so perhaps writing things
out is best.

> * Am I making callers too strict? In many cases where a positive
>   integer is expected (e.g., "--abbrev=<num>"), I have been replacing
>   code like
> [...]

IMHO most of the tightening happening here is a good thing, and means we
are more likely to notice mistakes rather than silently doing something
stupid.

For sites that currently allow it, I could imagine people using hex
notation for some values, though, depending on the context. It looks
there aren't many of them ((it is just when the radix is "0", right?).
Some of them look to be accidental (does anybody really ask for
--threads=0x10?), but others might not be (the pack index-version
contains an offset field that might be quite big).


Feel free to ignore any or all of that. It is not so much criticism as
a dump of thoughts I had while reading the patches. Perhaps you can pick
something useful out of that, and perhaps not. :)

-Peff
