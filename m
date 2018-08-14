Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C715A1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeHNWno (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:43:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:55206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727982AbeHNWnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:43:43 -0400
Received: (qmail 3115 invoked by uid 109); 14 Aug 2018 19:54:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 19:54:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25598 invoked by uid 111); 14 Aug 2018 19:55:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 15:55:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 15:54:56 -0400
Date:   Tue, 14 Aug 2018 15:54:56 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
Message-ID: <20180814195456.GE28452@sigill.intra.peff.net>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
 <20180813192526.GC10013@sigill.intra.peff.net>
 <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com>
 <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
 <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
 <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
 <CACsJy8CTNeR8Bchj37yNL+mWp1Y5rhD6QV2Gf06CPLHVXd8TDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CTNeR8Bchj37yNL+mWp1Y5rhD6QV2Gf06CPLHVXd8TDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 08:51:41PM +0200, Duy Nguyen wrote:

> > But AFAICT these series are all about putting the sampling points into the
> > code base, so formatting would be orthogonal to it?
> 
> It's not just sampling points. There's things like index id being
> shown in the message for example. I prefer to keep free style format
> to help me read. There's also things like indentation I do here to
> help me read. Granted you could do all that with scripts and stuff,
> but will we pass around in mail  dumps of json messages to be decoded
> locally?

I think you could have both forms using the same entry points sprinkled
through the code.

At GitHub we have a similar telemetry-ish thing, where we collect some
data points and then the resulting JSON is stored for every operation
(for a few weeks for read ops, and indefinitely attached to every ref
write).

And I've found that the storage and the trace-style "just show a
human-readable message to stderr" interface complement each other in
both directions:

 - you can output a human readable message that is sent immediately to
   the trace mechanism but _also_ becomes part of the telemetry. E.g.,
   imagine that one item in the json blob is "this is the last message
   from GIT_TRACE_FOO". Now you can push tracing messages into whatever
   plan you're using to store SLOG. We do this less with TRACE, and much
   more with error() and die() messages.

 - when a structured telemetry item is updated, we can still output a
   human-readable trace message with just that item. E.g., with:

     trace_performance(n, "foo");

   we could either store a json key (perf.foo=n) or output a nicely
   formatted string like we do now, depending on what the user has
   configured (or even both, of course).

It helps if the sampling points give enough information to cover both
cases (as in the trace_performance example), but you can generally
shoe-horn unstructured data into the structured log, and pretty-print
structured data.

-Peff
