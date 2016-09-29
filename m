Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA870207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934432AbcI2SCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:02:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:49997 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933876AbcI2SCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:02:51 -0400
Received: (qmail 10118 invoked by uid 109); 29 Sep 2016 18:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 18:02:50 +0000
Received: (qmail 3127 invoked by uid 111); 29 Sep 2016 18:03:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 14:03:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 14:02:48 -0400
Date:   Thu, 29 Sep 2016 14:02:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
Message-ID: <20160929180247.d4owhzwyawtanw3r@sigill.intra.peff.net>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
 <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 09:57:57AM -0700, Junio C Hamano wrote:

> > +wait_for_filter_termination () {
> > +	while ! grep "STOP"  LOGFILENAME >/dev/null
> > +	do
> > +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
> > +		sleep 1
> > +	done
> > +}
> 
> Running "ps" and grepping for a command is not suitable for script
> to reliably tell things, so it is out of question.  Compared to
> that, your version looks slightly better, but what if the machinery
> that being tested, i.e. the part that drives the filter process, is
> buggy or becomes buggy and causes the filter process that writes
> "STOP" to die before it actually writes that string?

I'm of the opinion that any busy-waiting is a good sign that something
is suboptimal. The right solution here seems like it should be signaling
the test script via a descriptor.

I don't necessarily agree, though, that the timing of filter-process
cleanup needs to be part of the public interface. So in your list:

>     3) Git waits until the filter process finishes.

That seems simple and elegant, but I can think of reasons we might not
want to wait (e.g., if the filter has to do some maintenance task and
does not the user to have to wait).

OTOH, we already face this in git, and we solve it by explicitly
backgrounding the maintenance task (i.e., auto-gc). So one could argue
that it is the responsibility of the filter process to manage its own
processes. It certainly makes the interaction with git simpler.

-Peff
