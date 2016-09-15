Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40CA2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbcIOTov (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:44:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43909 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753910AbcIOTou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:44:50 -0400
Received: (qmail 25161 invoked by uid 109); 15 Sep 2016 19:44:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 19:44:50 +0000
Received: (qmail 12027 invoked by uid 111); 15 Sep 2016 19:45:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 15:45:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 12:44:45 -0700
Date:   Thu, 15 Sep 2016 12:44:45 -0700
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
Message-ID: <20160915194443.x7zvkkryvworqcxt@sigill.intra.peff.net>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-5-larsxschneider@gmail.com>
 <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com>
 <B138B703-08A6-45C4-9D54-80F87C75356B@gmail.com>
 <xmqq37l3v2rk.fsf@gitster.mtv.corp.google.com>
 <385016D3-8298-4273-81E7-876CB25B2789@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <385016D3-8298-4273-81E7-876CB25B2789@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 05:42:58PM +0100, Lars Schneider wrote:

> >>>> +int packet_flush_gently(int fd)
> >>>> +{
> >>>> +	packet_trace("0000", 4, 1);
> >>>> +	if (write_in_full(fd, "0000", 4) == 4)
> >>>> +		return 0;
> >>>> +	error("flush packet write failed");
> >>>> +	return -1;
> [...]
> >>> I suspect that it is a strong sign that the caller wants to be in
> >>> control of when and what error message is produced; otherwise it
> >>> wouldn't be calling the _gently() variant, no?
> >> 
> >> Agreed!
> > 
> > I am also OK with the current form, too.  Those who need to enhance
> > it to packet_flush_gently(int fd, int quiet) can come later.
> 
> "caller wants to be in control [...] otherwise it wouldn't be calling 
> the _gently() variant" convinced me. I would like to change it like
> this:
> 
> 	trace_printf_key(&trace_packet, "flush packet write failed");
> 	return -1;
> 
> Objections?

I'm not sure that a trace makes sense, because it means that 99% of the
time we are silent. AFAICT, the question is not "sometimes the user
needs to see an error and sometimes not, and they should decide before
starting the program". It is "sometimes the caller will report the error
to the user as appropriate, and sometimes we need to do so". And only
the calling code knows which is which.

So the "right" pattern is either:

  1. Return -1 and the caller is responsible for telling the user.

or

  2. Return -1 and stuff the error into an error strbuf, so it can be
     passed up the call chain easily (and callers do not have to come up
     with their own wording).

But if all current callers would just call error() themselves anyway,
then it's OK to punt on this and let somebody else handle it later if
they add a new caller who wants different behavior (and that is what
Junio was saying above, I think).

-Peff
