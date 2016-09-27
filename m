Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576571F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 09:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbcI0JAh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 05:00:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:48706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752586AbcI0JAf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 05:00:35 -0400
Received: (qmail 30464 invoked by uid 109); 27 Sep 2016 09:00:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 09:00:33 +0000
Received: (qmail 14039 invoked by uid 111); 27 Sep 2016 09:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 05:00:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 05:00:32 -0400
Date:   Tue, 27 Sep 2016 05:00:32 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 07/11] pkt-line: add functions to read/write flush
 terminated packet streams
Message-ID: <20160927090031.jjb3dmhspbbnizja@sigill.intra.peff.net>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-8-larsxschneider@gmail.com>
 <507a29a1-99ff-c13e-cf1f-76631345a822@gmail.com>
 <77315FC2-47F3-433A-8D70-5497FB04CBBE@gmail.com>
 <6D8B988C-8E54-4AA6-980C-A6BA40983D88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6D8B988C-8E54-4AA6-980C-A6BA40983D88@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 10:14:16AM +0200, Lars Schneider wrote:

> >>> +		strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
> >>> +		paket_len = packet_read(fd_in, NULL, NULL,
> >>> +			sb_out->buf + sb_out->len, PKTLINE_DATA_MAXLEN+1, options);
> [...]
> After looking at it with fresh eyes I think the existing code is probably correct,
> but maybe a bit confusing.
> 
> packet_read() adds a '\0' at the end of the destination buffer:
> https://github.com/git/git/blob/21f862b498925194f8f1ebe8203b7a7df756555b/pkt-line.c#L206
> 
> That is why the destination buffer needs to be one byte larger than the expected content.
> 
> However, in this particular case that wouldn't be necessary because the destination
> buffer is a 'strbuf' that allocates an extra byte for '\0' at the end. But we are not
> supposed to write to this extra byte:
> https://github.com/git/git/blob/21f862b498925194f8f1ebe8203b7a7df756555b/strbuf.h#L25-L31

Right. The allocation happens as part of strbuf_grow(), but whatever
fills the buffer is expected to write the actual NUL (either manually,
or by calling strbuf_setlen().

I see the bit you quoted warns not to touch the extra byte yourself,
though I wonder if that is a bit heavy-handed (I guess it would matter
if we moved the extra 1-byte growth into strbuf_setlen(), but I find
that a rather unlikely change).

That being said, why don't you just use LARGE_PACKET_MAX here? It is
already the accepted size for feeding to packet_read(), and we know it
has enough space to hold a NUL terminator. Yes, we may over-allocate by
4 bytes, but that isn't really relevant. Strbufs over-allocate anyway.
So just:

  for (;;) {
        strbuf_grow(sb_out, LARGE_PACKET_MAX);
        packet_len = packet_read(fd_in, NULL, NULL,
	                         sb_out->buf + sb_out->len, LARGE_PACKET_MAX,
				 options);
        if (packet_len <= 0)
                break;
        /*
         * no need for strbuf_setlen() here; packet_read always adds a
         * NUL terminator.
         */
        sb_out->len += packet_len;
  }

You _could_ make the final line of the loop use strbuf_setlen(); it
would just overwrite something we already know is a NUL (and we know
that no extra allocation is necessary).

Also, using LARGE_PACKET_MAX fixes the fact that this patch is using
PKTLINE_DATA_MAXLEN before it is actually defined. :)

You might want to occasionally run:

  git rebase -x make

to make sure all of your incremental steps are valid (or even "make
test" if you are extremely patient; I often do that once after a big
round of complex interactive-rebase reordering).

> I see two options:
> 
> 
> (1) I leave the +1 as is and add a comment why the extra byte is necessary.
> 
>     Pro: No change in existing code necessary
>     Con: The destination buffer has two '\0' at the end.
> 
> 
> (2) I add an option PACKET_READ_DISABLE_NUL_TERMINATION. If the option is
>     set then no '\0' byte is added to the end.
> 
>     Pro: Correct solution, no byte wasted.
>     Con: Change in existing code required.
> 
> 
> Any preference?

Of the two, I prefer (1), though I like what I suggested above even more
(big surprise, I know).

-Peff
