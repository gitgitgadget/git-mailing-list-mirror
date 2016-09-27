Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA204209A6
	for <e@80x24.org>; Tue, 27 Sep 2016 07:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbcI0HTk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 03:19:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:48634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752695AbcI0HTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 03:19:39 -0400
Received: (qmail 24347 invoked by uid 109); 27 Sep 2016 07:19:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 07:19:38 +0000
Received: (qmail 13495 invoked by uid 111); 27 Sep 2016 07:19:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 03:19:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 03:19:36 -0400
Date:   Tue, 27 Sep 2016 03:19:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Gustavo Grieco <gustavo.grieco@imag.fr>, git@vger.kernel.org
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using git
 2.10.0
Message-ID: <20160927071936.5hneqhv22zw73asy@sigill.intra.peff.net>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
 <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
 <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr>
 <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com>
 <xmqqtwd2sf9t.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwd2sf9t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 11:10:54AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am inclined to say that it has no security implications.  You have
> > to be able to write a bogus loose object in an object store you
> > already have write access to in the first place, in order to cause
> > this ...
> 
> Note that you could social-engineer others to fetch from you and
> feed a small enough update that results in loose objects created in
> their repositories, without you having a direct write access to the
> repository.
> 
> The codepath under discussion in this thread however cannot be used
> as an attack vector via that route, because the "fetch from
> elsewhere" codepath runs verification of the incoming data stream
> before storing the results (either in loose object files, or in a
> packfile) on disk.

I don't think it could be used at all for anything that speaks the git
protocol, because the object header is not present at all in a packfile.
So even if you hit unpack-objects, it would be writing the (correct)
loose object header itself.

But when we grab loose objects _directly_ from a remote, as in dumb-http
fetch, I'd suspect that the code doing the verification calls
unpack_sha1_header() as part of it. So I didn't test, but I'd strongly
suspect that's a viable attack vector.

I'm not sure what the actual attack would look like, though, aside from
locally accessing memory in a read-only way.

-Peff
