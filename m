Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638DCC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 01:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D1160F56
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 01:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhKBBp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:45:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:51228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhKBBp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 21:45:59 -0400
Received: (qmail 1265 invoked by uid 109); 2 Nov 2021 01:43:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Nov 2021 01:43:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29490 invoked by uid 111); 2 Nov 2021 01:43:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Nov 2021 21:43:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Nov 2021 21:43:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dongsheng Song <dongsheng.song@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: timezone related bug of git
Message-ID: <YYCXu/lpp0jtaIMk@coredump.intra.peff.net>
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
 <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
 <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
 <xmqqcznldobz.fsf@gitster.g>
 <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
 <xmqq1r3zd9k5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r3zd9k5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 01, 2021 at 11:18:02AM -0700, Junio C Hamano wrote:

> I have to wonder why gm_time_t() needs to use two separate codepaths
> for positive and negative tz_offset, while the new code here can get
> away without.  Does it have something to do with the direction of
> truncation during division and modulo operation?

Hmm. Unless I am missing something, this part of gm_time_t() is simply
over-complicating things:

  minutes = tz < 0 ? -tz : tz;
  minutes = (minutes / 100)*60 + (minutes % 100);
  minutes = tz < 0 ? -minutes : minutes;

We switch to doing the computation in absolute-value units, but then
restore the sign. But just:

  minutes = (tz / 100) * 60 + (tz % 100);

is equivalent and shorter. If tz is negative, then both terms will be
negative, which is what you want (they sum to a larger absolute-value
negative number). This comes from f80cd783c6 (date.c: add "show_date()"
function., 2005-05-06), so I don't see any sign that there was specific
thought given to some obscure handling. And indeed later fixes like
fbab835c03 ([PATCH] fix show_date() for positive timezones, 2005-05-18)
imply to me that the original was just confused.

Later we do:

  if (minutes > 0) {
          if (unsigned_add_overflows(time, minutes * 60))
                  die("Timestamp+tz too large: %"PRItime" +%04d",
                      time, tz);
  } else if (time < -minutes * 60)
          die("Timestamp before Unix epoch: %"PRItime" %04d", time, tz);

And that does need separate paths for the overflow check, since we're
checking different boundaries. I suspect for the strftime() code that we
wouldn't need similar checks, because the earlier ones would have caught
any problems (i.e., we would not get as far as having a "struct tm" that
represented something outside the range of our time_t).

-Peff
