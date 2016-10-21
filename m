Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2376620229
	for <e@80x24.org>; Fri, 21 Oct 2016 21:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935534AbcJUVq2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 17:46:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:60894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933454AbcJUVqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 17:46:25 -0400
Received: (qmail 21358 invoked by uid 109); 21 Oct 2016 21:46:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 21:46:25 +0000
Received: (qmail 6987 invoked by uid 111); 21 Oct 2016 21:46:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 17:46:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 17:46:23 -0400
Date:   Fri, 21 Oct 2016 17:46:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] test-lib: add --verbose-log option
Message-ID: <20161021214622.csroal7hws3cnszg@sigill.intra.peff.net>
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
 <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net>
 <xmqq7f91d3tb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f91d3tb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 10:12:16AM -0700, Junio C Hamano wrote:

> > -if test "$verbose" = "t"
> > +if test "$verbose_log" = "t"
> > +then
> > +	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
> > +elif test "$verbose" = "t"
> >  then
> >  	exec 4>&2 3>&1
> >  else
> 
> OK, unlike "verbose" case where we give 3 (saved stdout) to 1 and 4
> (saved stderr) to 2, we send 3 to the output file and 4 to the same.

Your comment made me double-check whether we ought to be separating the
two in any way. Because my statement earlier in the thread that the
--verbose output goes to stdout is not _entirely_ true. It goes to
stdout and stderr, as written by the various programs in the tests.

So:

  ./t0000-whatever.sh -v | less

isn't quite sufficient. You really do want "2>&1" in there to catch
everything.

But for the case of "--tee", we already do so, in order to make sure it
all goes to the logfile. And since this option always implies "--tee",
it is correct here to send "3" and "4" to the same place.

So the patch is correct. But when I said earlier that people might be
annoyed if we just sent --verbose output to stderr, that probably isn't
true. We could perhaps make:

  prove t0000-whatever.sh :: -v

"just work" by sending all of the verbose output to stderr. I don't
think it really matters, though. Nobody is doing that, because it's
pointless without "--tee".

-Peff
