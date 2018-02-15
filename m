Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C4B1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 22:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163852AbeBOWRQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 17:17:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:54530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1163612AbeBOWRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 17:17:15 -0500
Received: (qmail 18736 invoked by uid 109); 15 Feb 2018 22:17:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 22:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14880 invoked by uid 111); 15 Feb 2018 22:18:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 17:18:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 17:17:13 -0500
Date:   Thu, 15 Feb 2018 17:17:13 -0500
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] grep: move grep_source_init outside critical section
Message-ID: <20180215221713.GB23970@sigill.intra.peff.net>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
 <20180215215615.21208-2-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180215215615.21208-2-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 10:56:13PM +0100, Rasmus Villemoes wrote:

> grep_source_init typically does three strdup()s, and in the threaded
> case, the call from add_work() happens while holding grep_mutex.
> 
> We can thus reduce the time we hold grep_mutex by moving the
> grep_source_init() call out of add_work(), and simply have add_work()
> copy the initialized structure to the available slot in the todo
> array.
> 
> This also simplifies the prototype of add_work(), since it no longer
> needs to duplicate all the parameters of grep_source_init(). In the
> callers of add_work(), we get to reduce the amount of code duplicated in
> the threaded and non-threaded cases slightly (avoiding repeating the
> "GREP_SOURCE_OID, pathbuf.buf, path, oid" argument list); a subsequent
> cleanup patch will make that even more so.

I think this makes sense. It does blur the memory ownership lines of the
grep_source, though. Can we make that more clear with a comment here:

> +	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
> +
>  #ifndef NO_PTHREADS
>  	if (num_threads) {
> -		add_work(opt, GREP_SOURCE_OID, pathbuf.buf, path, oid);
> +		add_work(opt, &gs);
>  		strbuf_release(&pathbuf);
>  		return 0;
>  	} else

like:

  /* leak grep_source, whose fields are now owned by add_work() */

or something? We could even memset() it back to all-zeroes to avoid an
accidental call to grep_source_clear(), but that's probably unnecessary
if we have a comment.

-Peff
