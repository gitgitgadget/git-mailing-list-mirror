Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB42206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 16:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbcLLQkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 11:40:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:55177 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbcLLQkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 11:40:24 -0500
Received: (qmail 21799 invoked by uid 109); 12 Dec 2016 16:40:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 16:40:24 +0000
Received: (qmail 7177 invoked by uid 111); 12 Dec 2016 16:41:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 11:41:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2016 11:40:20 -0500
Date:   Mon, 12 Dec 2016 11:40:20 -0500
From:   Jeff King <peff@peff.net>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v8 18/19] branch: use ref-filter printing APIs
Message-ID: <20161212164020.btrrg2f62haxt7sh@sigill.intra.peff.net>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
 <20161207153627.1468-19-Karthik.188@gmail.com>
 <20161209140345.76ybodldmg2lxgbn@sigill.intra.peff.net>
 <CAOLa=ZSPDLwziGEvyixebAkS2M1JMYidQNHfDbnmYarFCjn80A@mail.gmail.com>
 <20161212121548.aj2ptnmrqt67anlc@sigill.intra.peff.net>
 <CAOLa=ZT1KN_iw7JzB78hPb-LrY_yaDZk0D+TqY2W9hCOftzumA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT1KN_iw7JzB78hPb-LrY_yaDZk0D+TqY2W9hCOftzumA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 09:59:49PM +0530, Karthik Nayak wrote:

> >> > This caller never stores the return value, and it ends up leaking. So I
> >> > wonder if you wanted "static struct strbuf" in the first place (and that
> >> > would explain the strbuf_reset() in your function).
> >>
> >> Ah! Yes this should be 'static struct strbuf' indeed, I blindly copied Junio's
> >> suggestion.
> >>
> >> strbuf_detach() is also a better way to go.
> >
> > One of the other, though. If it's static, then you _don't_ want to
> > detach.
> >
> 
> Wait. Why not? since it gets added to the strbuf's within
> build_format() and that
> value is not needed again, why do we need to re-allocate? we can use the same
> variable again (i.e by keeping it as static).
> 
> I'm sorry, but I didn't get why these two should be mutually exclusive?

What is the memory ownership convention for the return value from the
function?

If the caller should own the memory, then you want to do this:

  char *foo(...)
  {
	struct strbuf buf = STRBUF_INIT;
	... fill up buf ...
	return strbuf_detach(&buf, NULL);
  }

The "detach" disconnects the memory from the strbuf (which is going out
of scope anyway), and the only pointer left to it is in the caller. It's
important to use "detach" here and not just return the pointer, because
that ensures that the returned value is always allocated memory (and
never strbuf_slopbuf).

If the caller should not own the memory, then the function retains
ownership. And you want something like this:

  char *foo(...)
  {
	static struct strbuf buf = STRBUF_INIT;
	strbuf_reset(&buf);
	... fill up buf ...
	return buf.buf;
  }

The same buffer is reused over and over. The "reset" call clears any
leftover bits from the last invocation, and you must _not_ call
strbuf_detach() in the return, as it disconnects the memory from the
strbuf (and so next time you'd end up allocating again, and each return
value becomes a memory leak).

Does that make sense?

-Peff
