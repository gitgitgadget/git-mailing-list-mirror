Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383F71F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJHUAw (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 16:00:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:42990 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729436AbfJHUAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 16:00:52 -0400
Received: (qmail 14503 invoked by uid 109); 8 Oct 2019 20:00:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Oct 2019 20:00:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8288 invoked by uid 111); 8 Oct 2019 20:03:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Oct 2019 16:03:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Oct 2019 16:00:50 -0400
From:   Jeff King <peff@peff.net>
To:     Joey Hess <id@joeyh.name>
Cc:     git@vger.kernel.org
Subject: Re: git cat-file --batch surprising carriage return behavior
Message-ID: <20191008200050.GA26453@sigill.intra.peff.net>
References: <20191008192257.GA16870@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008192257.GA16870@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 03:22:57PM -0400, Joey Hess wrote:

> I'm surprised to find that git cat-file --batch, on a Linux system,
> strips the \r from an input like "HEAD:foo\r\n"
> 
> It's obvious, of course, that it will remove the newline, and so this
> interface cannot be used to query about a filename that, for some
> horrible reason[1], contains a newline. But very surprising that it
> cannot be used for filename that contains a carriage return, at least
> on a non-Windows system.

This is likely due to b42ca3dd0f (cat-file: read batch stream with
strbuf_getline(), 2015-10-28), and the matching c8aa9fdf5d (strbuf: make
strbuf_getline_crlf() global, 2015-10-28).

I agree it's a bit surprising (though OTOH, I imagine the old behavior
surprised some people in the opposite direction).

> The docs for cat-file --batch say the list of objects is separated by
> linefeeds. I don't know if updating the docs is the best fix.
> (I'd be happy to use a -z if it had one.)

Yeah, I agree that a -z option is the best path forward. For non-z
input, I'm tempted to say we could unquote entries that start with a
double-quote (the match to how we handle filenames in non-z diff
output). That would mean breaking compatibility for refnames that start
with a quote, though. If we just add a new "-z", that's less disruptive
_and_ easier to use.

I suspect it's not entirely sufficient for clean input, though. You're
not feeding filenames but rather full "object names". I wouldn't be
surprised if we mis-parse "$rev:$path" when $path has "@{}" or similar
in it.

So what you may actually want is some more robust input format that lets
you specify the filename as an independent NUL-terminated entity.

-Peff
