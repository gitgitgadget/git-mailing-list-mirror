Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B9720A40
	for <e@80x24.org>; Sun,  3 Dec 2017 02:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbdLCCuB (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 21:50:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:46520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751878AbdLCCuA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 21:50:00 -0500
Received: (qmail 8638 invoked by uid 109); 3 Dec 2017 02:50:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Dec 2017 02:50:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15041 invoked by uid 111); 3 Dec 2017 02:50:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 02 Dec 2017 21:50:20 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Dec 2017 21:49:58 -0500
Date:   Sat, 2 Dec 2017 21:49:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20171203024958.GA31493@sigill.intra.peff.net>
References: <20171126193813.12531-1-max@max630.net>
 <20171126193813.12531-2-max@max630.net>
 <20171129032214.GB32345@sigill.intra.peff.net>
 <xmqqr2sclj2q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2sclj2q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 02, 2017 at 05:02:37PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   3. For large inputs (like incoming packfiles), we connect the
> >      descriptor directly to index-pack or unpack-objects, and they try
> >      to read to EOF.
> >
> >      For a well-formed pack, I _think_ this would work OK. We'd see the
> >      end of the pack and quit (there's a check for garbage at the end of
> >      the pack, but it triggers only for the non-pipe case).
> >
> >      For a truncated input, we'd hang forever rather than report an
> >      error.
> 
> Hmm.  index-pack and/or unpack-objects would be fed directly from
> the incoming pipe, they are not told how many bytes to expect (by
> design), so they try to read to EOF, which may come after the end of
> the pack-stream data, and they write the remaining junk to their
> standard output IIRC.
> 
> For a well-formed pack, the above is what should heppen.

Yeah, there should be zero bytes of "remaining junk" in the normal
well-formed case. And as long as the webserver does not mind us asking
to read() a few extra bytes, we are fine (it tells us there are no more
bytes available right now). The original problem report with IIS was
that it would hang trying to read() that any final EOF, and I don't
think that would happen here.

I wouldn't be surprised if there are webservers or situations where that
extra read() behaves badly (e.g., because it is connected directly to
the client socket and the client is trying to pipeline requests or
something).

> I am having trouble trying to come up with a case where the input
> stream is mangled and we cannot detect where the end of the
> pack-stream is without reading more than we will be fed through the
> pipe, and yet we do not trigger an "we tried to read because the data
> we received so far is incomplete, and got an EOF" error.
> 
> Wouldn't "early EOF" trigger in the fill() helper that these two
> programs have (but not share X-<)?

I think the original problem was the opposite of "early EOF": the other
side of the pipe never gives us EOF at all. So imagine the pack is
mangled so that the zlib stream of an object never ends, and just keeps
asking for more data. Eventually our fill() will block trying to get
data that is not there. On an Apache server, the webserver would know
there is nothing left to send us and close() the pipe, and we'd get EOF.
But on IIS, I think the pipe remains open and we'd just block
indefinitely trying to read().

I don't have such a setup to test on, and it's possible I'm
mis-interpreting or mis-remembering the discussion around the original
patch.

-Peff
