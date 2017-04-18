Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62AA1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 16:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757507AbdDRQRl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 12:17:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:35377 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdDRQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 12:17:38 -0400
Received: (qmail 24110 invoked by uid 109); 18 Apr 2017 16:17:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 16:17:36 +0000
Received: (qmail 13413 invoked by uid 111); 18 Apr 2017 16:17:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 12:17:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 12:17:34 -0400
Date:   Tue, 18 Apr 2017 12:17:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        jrnieder@gmail.com, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] xgethostname: handle long hostnames
Message-ID: <20170418161734.pa665rqwdtbnsj7f@sigill.intra.peff.net>
References: <20170417161748.31231-1-dturner@twosigma.com>
 <xmqq1ssqikc5.fsf@gitster.mtv.corp.google.com>
 <xmqqwpaih4q2.fsf@gitster.mtv.corp.google.com>
 <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 06:07:43PM +0200, René Scharfe wrote:

> > -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
> > +			fscanf(fp, scan_fmt, &pid, locking_host) == 2 &&
> >   			/* be gentle to concurrent "gc" on remote hosts */
> >   			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
> >   		if (fp != NULL)
> > 
> 
> How important is it to scan the whole file in one call?  We could split
> it up like this and use a strbuf to handle host names of any length.  We
> need to be permissive here to allow machines with different values for
> HOST_NAME_MAX to work with the same file on a network file system, so
> this would have to be the first patch, right?

I doubt that doing it in one call matters. It's not like stdio promises
us any atomicity in the first place.

> -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
> +			fscanf(fp, "%"SCNuMAX" ", &pid) == 1 &&
> +			!strbuf_getwholeline(&locking_host, fp, '\0') &&

I don't think there is anything wrong with using fscanf here, but it has
enough pitfalls in general that I don't really like its use as a parser
(and the general lack of it in Git's code base seems to agree).

I wonder if this should just read a line (or the whole file) into a
strbuf and parse it there. That would better match our usual style, I
think.

I can live with it either way.

> NB: That && cascade has enough meat for a whole function.

Yeah.

-Peff
