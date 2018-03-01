Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D151F404
	for <e@80x24.org>; Thu,  1 Mar 2018 15:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031645AbeCAPEz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 10:04:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:42954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1031554AbeCAPEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 10:04:54 -0500
Received: (qmail 5171 invoked by uid 109); 1 Mar 2018 15:04:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 15:04:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17696 invoked by uid 111); 1 Mar 2018 15:05:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 10:05:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 10:04:52 -0500
Date:   Thu, 1 Mar 2018 10:04:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: ref-filter: how to improve the code
Message-ID: <20180301150451.GC24907@sigill.intra.peff.net>
References: <CAL21Bmnz=H96EE=yerdigujYQ6M7Y_U-RkDF7oR-UPDU+cZNFA@mail.gmail.com>
 <20180228132550.GB32272@sigill.intra.peff.net>
 <CAL21BmkVq4j=hgupPvZqigSGQ-=rgwKVvzTD_X-_Z__8qmeKJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21BmkVq4j=hgupPvZqigSGQ-=rgwKVvzTD_X-_Z__8qmeKJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 01, 2018 at 02:17:09PM +0300, Оля Тележная wrote:

> >> I tried to replace all die("...") with `return error("...")` and
> >> finally exit(), but actual problem is that we print "error:..."
> >> instead of "fatal:...", and it looks funny.
> >
> > If you do that, then format_ref_array_item() is still going to print
> > things, even if it doesn't die(). But for "cat-file --batch", we usually
> > do not print errors at all, but instead just say "... missing" (although
> > it depends on the error; syntactic errors in the format string would
> > still cause us to write to stderr).
> 
> Not sure if you catch my idea. format_ref_array_item() will not print
> anything, it will just return an error code. And if there was an error
> - we will print it in show_ref_array_item() (or go back to cat-file
> and print what we want).

OK, I think I misunderstood. It seems like there are three possible
strategies on the table:

  - low-level functions call error() and return -1, that gets passed up
    through mid-level functions like format_ref_array_item(), and then
    higher-level functions like show_ref_array_item() act on the error
    code and call die(). The user sees something like:

      error: unable to parse object 1234abcd
      fatal: unable to format object

  - low-level functions return a numeric error code, which is then
    formatted by higher-level functions like show_ref_array_item() to
    produce a specific message

  - low-level functions stuff an error code into a strbuf and return -1,
    and then higher-level functions like show_ref_array_item() will feed
    that message to die("%s", err.buf).

I think the first one, besides changing the output, is going to produce
error() messages even for cases where we're calling
format_ref_array_item() directly, because error() writes its output
immediately.

The second is a pain in practice, because it doubles the work: you have
to come up with a list of error codes, and then translate it them into
strings. And there's no room to mention variable strings (like the name
of the object).

So I think the third is really the only viable option.

-Peff
