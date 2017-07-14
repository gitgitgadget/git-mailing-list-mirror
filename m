Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9542E20357
	for <e@80x24.org>; Fri, 14 Jul 2017 17:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754748AbdGNRhC (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 13:37:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:40924 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753604AbdGNRhB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 13:37:01 -0400
Received: (qmail 30595 invoked by uid 109); 14 Jul 2017 17:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 17:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12903 invoked by uid 111); 14 Jul 2017 17:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 13:37:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 13:36:58 -0400
Date:   Fri, 14 Jul 2017 13:36:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170714173658.2q24oxhatwh5qrqk@sigill.intra.peff.net>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
 <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
 <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
 <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 09:11:33AM -0700, Junio C Hamano wrote:

> As to other things that we currently not allow in our codebase that
> newer compilers can grok, here is what *I* think.  It is *not* meant
> to be an exhaustive "what's new in C99 that is not in C89? what is
> the final verdict on each of them?":
> 
>  - There were occasional cases where we wished if variable-length
>    arrays, flexible array members and variadic macros were available
>    in our codebase during the course of this project.  We would
>    probably want to add a similar test baloon patch for each of
>    them to this series that is currently two-patch long.

I think variable-length arrays are potentially dangerous. They're
allocated on the stack, which creates two issues:

  1. You can run out of stack space and segfault, whereas the same
     operation with a heap buffer would be fine. You can say "but this
     VLA will only be used for small things". But then, you can just as
     easily declare a small stack buffer.

  2. My understanding of the recent "Stack Clash" class of
     vulnerabilities[1] is that VLAs make the attacker's job much easier
     (since they can often just send a large input to get you to
     allocate a large stack).

I think variadic macros are a good candidate, though. There have been a
number of times where we've had to sacrifice functionality or
readability in our helper functions. E.g., the case mentioned in
368953912 (add helpers for allocating flex-array structs, 2016-02-22).

The weather-balloon patch for that should be easy, too: just drop the
fallback macros from BUG() or the trace code.

[1] https://www.qualys.com/2017/06/19/stack-clash/stack-clash.txt

>  - I prefer to keep decl-after-statement out of our codebase.  I
>    view it as a big plus in code-readability to be able to see a
>    complete list of variables that will be used in a block upfront
>    before starting to read the code that uses them.
> 
>  - Corollary to the above, I do not mind to have a variable
>    declaration in the initialization clause of a for() statement
>    (e.g. "for (int i = 0; i < 4; i++) { ... }"), as the scoping rule
>    is very sensible.  Some of our "for()" statements use the value
>    of the variable after iteration, for which this new construct
>    cannot be used, though.

I agree with both of those points. I think the decl-in-for is nice
exactly because it highlights those cases where the iteration variable's
value is relevant after the loop ends.

>  - This may be showing I am not just old fashioned but also am
>    ignorant, but I do not see much point in using the following in
>    our codebase (iow, I am not aware of places in the existing code
>    that they can be improved by employing these features):
> 
>    . // comments
>    . restricted pointers
>    . static and type qualifiers in parameter array declarators

Agreed, though I think the comment thing is a personal taste issue (just
not my taste).

> +static int clean_use_color = -1;
> +static char clean_colors[][COLOR_MAXLEN] = {
> +	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
> +	[CLEAN_COLOR_PLAIN] = GIT_COLOR_NORMAL,
> +	[CLEAN_COLOR_PROMPT] = GIT_COLOR_BOLD_BLUE,
> +	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
> +	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
> +	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
> +};

I think this is much nicer to read. I assume if we have a "hole" in our
numbering that the hole is initialized in the usual static way (a
COLOR_MAXLEN array full of NULs in this case, I guess)?

-Peff
