Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468451F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbcHLQiN (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:38:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:54292 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752693AbcHLQiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:38:12 -0400
Received: (qmail 7450 invoked by uid 109); 12 Aug 2016 16:38:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 16:38:12 +0000
Received: (qmail 21159 invoked by uid 111); 12 Aug 2016 16:38:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 12:38:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Aug 2016 12:38:09 -0400
Date:	Fri, 12 Aug 2016 12:38:09 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
Message-ID: <20160812163809.3wdkuqegxfjam2yn@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-15-larsxschneider@gmail.com>
 <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 09:33:18AM -0700, Stefan Beller wrote:

> > If the result content is empty then the filter is expected to respond
> > with a success status and an empty list.
> > ------------------------
> > packet:          git< status=success\n
> > packet:          git< 0000
> > packet:          git< 0000  # empty content!
> > packet:          git< 0000  # empty list!
> > ------------------------
> 
> Why do we need the last flush packet? We'd expect as many successes
> as we send out contents? Do we plan on interleaving operation, i.e.
> Git sends out 10 files but the filter process is not as fast as Git sending
> out and the answers trickle in slowly?

There was prior discussion in the thread, but basically, it is there to
be able to signal an error that is encountered midway through sending
the file (i.e., to say "status=error"). If you do not have a final
flush, then you would send nothing, and the receiver would be left
wondering if you were successful, or if it simply did not get your error
report yet.

> > If the filter experiences an error during processing, then it can
> > send the status "error". Depending on the `filter.<driver>.required`
> > flag Git will interpret that as error but it will not stop or restart
> > the filter process.
> > ------------------------
> > packet:          git< status=success\n
> 
> So the first success is meaningless essentially?
> Would it make sense to move the sucess behind the content sending
> in all cases?

No, the first success says "good so far, here's the file content". The
second says "I succeeded in sending you the file content".

You _can_ drop the first one, but it may be more convenient for the
receiver to know up-front that there was a failure.

-Peff
