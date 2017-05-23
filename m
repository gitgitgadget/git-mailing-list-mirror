Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C677620281
	for <e@80x24.org>; Tue, 23 May 2017 19:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966487AbdEWTpX (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:45:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:56939 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760218AbdEWTpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:45:22 -0400
Received: (qmail 8250 invoked by uid 109); 23 May 2017 19:45:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 19:45:22 +0000
Received: (qmail 3455 invoked by uid 111); 23 May 2017 19:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 15:45:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 15:45:20 -0400
Date:   Tue, 23 May 2017 15:45:20 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 25/25] cache_ref_iterator_begin(): avoid priming
 unneeded directories
Message-ID: <20170523194519.luhuej3rerzb57t7@sigill.intra.peff.net>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
 <0d6a608a62026352c1496239bab02122f123f2e1.1495460199.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d6a608a62026352c1496239bab02122f123f2e1.1495460199.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 04:17:55PM +0200, Michael Haggerty wrote:

> So:
> 
> * Move the responsibility for doing the prefix check directly to
>   `cache_ref_iterator`. This means that `cache_ref_iterator_begin()`
>   never has to wrap its return value in a `prefix_ref_iterator`.
> 
> * Teach `cache_ref_iterator_begin()` (and `prime_ref_dir()`) to be
>   stricter about what they iterate over and what directories they
>   prime.
> 
> * Teach `cache_ref_iterator` to keep track of whether the current
>   `cache_ref_iterator_level` is fully within the prefix. If so, skip
>   the prefix checks entirely.

As promised, I came back to this one with a more careful eye. These
changes all make sense to me, and the implementation matches.

My only question is:

> @@ -511,9 +582,12 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
>  	level->index = -1;
>  	level->dir = dir;
>  
> -	if (prefix && *prefix)
> -		ref_iterator = prefix_ref_iterator_begin(ref_iterator,
> -							 prefix, 0);
> +	if (prefix && *prefix) {
> +		iter->prefix = xstrdup(prefix);
> +		level->prefix_state = PREFIX_WITHIN_DIR;
> +	} else {
> +		level->prefix_state = PREFIX_CONTAINS_DIR;
> +	}

Who frees the prefix? Does this need:

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index fda3942db..a3efc5c51 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -542,6 +542,7 @@ static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
 	struct cache_ref_iterator *iter =
 		(struct cache_ref_iterator *)ref_iterator;
 
+	free(iter->prefix);
 	free(iter->levels);
 	base_ref_iterator_free(ref_iterator);
 	return ITER_DONE;

-Peff
