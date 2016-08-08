Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49532018E
	for <e@80x24.org>; Mon,  8 Aug 2016 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbcHHQ0q (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 12:26:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:51250 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752054AbcHHQ0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 12:26:46 -0400
Received: (qmail 15155 invoked by uid 109); 8 Aug 2016 16:26:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 16:26:45 +0000
Received: (qmail 6424 invoked by uid 111); 8 Aug 2016 16:26:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 12:26:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 12:26:43 -0400
Date:	Mon, 8 Aug 2016 12:26:43 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
Message-ID: <20160808162642.x4k7yjb5fxs2jp25@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-12-larsxschneider@gmail.com>
 <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
 <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
 <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net>
 <87D4BF17-67BB-4AFA-9B27-40DBB44C0456@gmail.com>
 <20160806121421.bs7n4lhed7phdshb@sigill.intra.peff.net>
 <A07BE78B-5A5D-41F1-A51B-5C71F3E86CCF@gmail.com>
 <20160808150255.2otm3z5fluimpiqw@sigill.intra.peff.net>
 <6D2101A9-2D01-47E8-9DFF-6C85DED4269D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6D2101A9-2D01-47E8-9DFF-6C85DED4269D@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 06:21:18PM +0200, Lars Schneider wrote:

> >> Happy answer with no content:
> >> ------------------------
> >> packet:          git< status=success\n
> >> ------------------------
> > 
> > This can just be spelled:
> > 
> >  git< status=success
> >  git< 0000
> >  git< 0000   # empty content!
> >  git< 0000   # empty list!
> 
> Is the first flush packet one too many?
> If there is nothing then I think we shouldn't
> send any packets?!
> 
> I agree with the remaining two flush packets.

There isn't nothing, there is a "status" field (though I think that
should probably be required, so I guess you could imagine it as a
stand-alone pkt, separate from the list terminated by the flush). But
regardless, you need the first flush to say "I am done telling you
up-front keys, now I am starting the content".

Otherwise, what would:

  git< status=success
  git< foo=bar
  git< 0000

be parsed as? Is "foo=bar" the first line of content, or the rest of the
pre-content header? (You could guess if you could see the total
conversation, but you can't; you have to parse it as it comes).

> There is one more thing: I introduced a return value "status=error-all".
> Using this the filter can signal Git that it does not want to process
> any other file using the particular command.
> 
> Jakub came up with this idea here:
> 
> "Another response, which I think should be standarized, or at
> least described in the documentation, is filter driver refusing
> to filter further (e.g. git-LFS and network is down), to be not
> restarted by Git."
> 
> http://public-inbox.org/git/607c07fe-5b6f-fd67-13e1-705020c267ee%40gmail.com/
> 
> I think it is a good idea. Do you see arguments against it?

No, that seems reasonable (I would have just implemented that by hanging
up the connection, but explicitly communicating is more robust).

-Peff
