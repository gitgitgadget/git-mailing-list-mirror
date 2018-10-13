Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC54C1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 02:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeJMKVr (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 06:21:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:39586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725954AbeJMKVr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 06:21:47 -0400
Received: (qmail 20507 invoked by uid 109); 13 Oct 2018 02:46:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Oct 2018 02:46:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16765 invoked by uid 111); 13 Oct 2018 02:45:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Oct 2018 22:45:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2018 22:46:24 -0400
Date:   Fri, 12 Oct 2018 22:46:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] zlib.c: use size_t for size
Message-ID: <20181013024624.GB15595@sigill.intra.peff.net>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181013023845.GA15595@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181013023845.GA15595@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 10:38:45PM -0400, Jeff King wrote:

> So right now let's imagine that off_t is 64-bit, and "unsigned long" is
> 32-bit (e.g., 32-bit system, or an IL32P64 model like Windows). We'll
> repeatedly ask use_pack() for a window, and it will tell us how many
> bytes we have in "avail". So even as a 32-bit value, that just means
> we'll process chunks smaller than 4GB, and this is correct (or at least
> this part of it -- hold on). But we can still process the whole "len"
> given by the off_t eventually.

So this "hold on" was because I thought I had found another bug in
use_pack(), but I actually think it's OK.

In use_pack(), we do this:

          if (left)
                  *left = win->len - xsize_t(offset);

where win->len is a size_t. Before this patch, "left" is a pointer to
unsigned long. So that has the usual broken-on-Windows mismatch. This
patch makes it a size_t, which is good.

But what's up with that xsize_t(offset)? We'll complain about truncation
_before_ we do any offset subtraction. So at first glance, I thought
this meant we were broken for larger-than-4GB packs on 32-bit systems
when trying to read past the 4GB mark.

But no, right before that we have this line:

          offset -= win->offset;

So offset is in fact no longer its original meaning of "offset into the
packfile", but is now an offset of the specific request into the window
we found.

So I think it's correct, but it sure confused me. I wonder if another
variable might help, like:

  size_t offset_in_window;
  ...

  /*
   * We know this difference will fit in a size_t, because our mmap
   * window by * definition can be no larger than a size_t.
   */
  offset_in_window = xsize_t(offset - win->offset);
  if (left)
	*left = win->len - offset_in_window;
  return win->base + offset_in_window;

I dunno. Maybe it is overkill.

-Peff
