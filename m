Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAFD1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 13:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeB1NZ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 08:25:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:40612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752604AbeB1NZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 08:25:54 -0500
Received: (qmail 665 invoked by uid 109); 28 Feb 2018 13:25:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Feb 2018 13:25:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1744 invoked by uid 111); 28 Feb 2018 13:26:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 08:26:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 08:25:50 -0500
Date:   Wed, 28 Feb 2018 08:25:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: ref-filter: how to improve the code
Message-ID: <20180228132550.GB32272@sigill.intra.peff.net>
References: <CAL21Bmnz=H96EE=yerdigujYQ6M7Y_U-RkDF7oR-UPDU+cZNFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21Bmnz=H96EE=yerdigujYQ6M7Y_U-RkDF7oR-UPDU+cZNFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 09:28:25PM +0300, Оля Тележная wrote:

> I am trying to remove cat-file formatting part and reuse same
> functionality from ref-filter.
> I have a problem that cat-file sometimes needs to continue running
> even if the request is broken, while in ref-filter we invoke die() in
> many places everywhere during formatting process. I write this email
> because I want to discuss how to implement the solution better.
> 
> ref-filter has 2 functions which could be interesting for us:
> format_ref_array_item() and show_ref_array_item(). I guess it's a good
> idea to print everything in show_ref_array_item(), including all
> errors. In that case all current users of ref-filter will invoke
> show_ref_array_item() (as they did it before), and cat-file could use
> format_ref_array_item() and work with the result in its own logic.

Yes, that arrangement makes sense to me.

> I tried to replace all die("...") with `return error("...")` and
> finally exit(), but actual problem is that we print "error:..."
> instead of "fatal:...", and it looks funny.

If you do that, then format_ref_array_item() is still going to print
things, even if it doesn't die(). But for "cat-file --batch", we usually
do not print errors at all, but instead just say "... missing" (although
it depends on the error; syntactic errors in the format string would
still cause us to write to stderr).

> One of the easiest solutions is to add strbuf parameter for errors to
> all functions that we use during formatting process, fill it in and
> print in show_ref_array_item() if necessary. What do you think about
> this idea?
> 
> Another way is to change the resulting error message, print current
> message with "error" prefix and then print something like "fatal:
> could not format the output". It is easier but I am not sure that it's
> a good idea to change the interface.

For reference, the first one is what we've been switching to in the refs
code. And I think it's been fairly successful there.

-Peff
