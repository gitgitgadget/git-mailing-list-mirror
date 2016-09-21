Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D726E20985
	for <e@80x24.org>; Wed, 21 Sep 2016 22:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbcIUWDP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:03:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:46341 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754056AbcIUWDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:03:14 -0400
Received: (qmail 21117 invoked by uid 109); 21 Sep 2016 22:03:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 22:03:13 +0000
Received: (qmail 3523 invoked by uid 111); 21 Sep 2016 22:03:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 18:03:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Sep 2016 18:03:10 -0400
Date:   Wed, 21 Sep 2016 18:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 3/3] regex: use regexec_buf()
Message-ID: <20160921220310.5wk76qdsjyhvstk4@sigill.intra.peff.net>
References: <cover.1473321437.git.johannes.schindelin@gmx.de>
 <cover.1474482164.git.johannes.schindelin@gmx.de>
 <53f3609d99c865d59d7bfd8219a5334339e9e6bc.1474482164.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53f3609d99c865d59d7bfd8219a5334339e9e6bc.1474482164.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 08:24:14PM +0200, Johannes Schindelin wrote:

> The new regexec_buf() function operates on buffers with an explicitly
> specified length, rather than NUL-terminated strings.
> 
> We need to use this function whenever the buffer we want to pass to
> regexec() may have been mmap()ed (and is hence not NUL-terminated).
> 
> Note: the original motivation for this patch was to fix a bug where
> `git diff -G <regex>` would crash. This patch converts more callers,
> though, some of which explicitly allocated and constructed
> NUL-terminated strings (or worse: modified read-only buffers to insert
> NULs).

Nice. I probably would have split these into their own patch, but I
think it is OK here.

> @@ -228,18 +227,16 @@ static long ff_regexp(const char *line, long len,
>  			len--;
>  	}
>  
> -	line_buffer = xstrndup(line, len); /* make NUL terminated */
> -

Nice to see this one going away in particular, since it's called quite a
lot. According to perf, "git log -p" on git.git drops about 1.5 million
malloc calls (about 9% of the total). And here are best-of-five results
for that same command:

  [before]
  real    0m14.676s
  user    0m13.988s
  sys     0m0.676s

  [after]
  real    0m14.394s
  user    0m13.624s
  sys     0m0.760s

Not a _huge_ improvement, but more significant than the run-to-run
noise.

-Peff
