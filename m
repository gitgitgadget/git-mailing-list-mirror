Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0228E1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeH2BO7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:59470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbeH2BO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:59 -0400
Received: (qmail 29653 invoked by uid 109); 28 Aug 2018 21:21:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 21:21:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5747 invoked by uid 111); 28 Aug 2018 21:21:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 17:21:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 17:21:27 -0400
Date:   Tue, 28 Aug 2018 17:21:27 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/9] introducing oideq()
Message-ID: <20180828212126.GA7039@sigill.intra.peff.net>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180826205620.GC873448@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180826205620.GC873448@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 26, 2018 at 08:56:21PM +0000, brian m. carlson wrote:

> > Due to the simplicity of the current code and our inlining, the compiler
> > can usually figure this out for now. So I wouldn't expect this patch to
> > actually improve performance right away. But as that discussion shows,
> > we are likely to take a performance hit as we move to more runtime
> > determination of the_hash_algo parameters. Having these callers use the
> > more strict form will potentially help us recover that.
> > 
> > So in that sense we _could_ simply punt on this series until then (and
> > it's certainly post-v2.19 material). But I think it's worth doing now,
> > simply from a readability/annotation standpoint. IMHO the resulting code
> > is more clear (though I've long since taught myself to read !foocmp() as
> > equality).
> 
> I would quite like to see this series picked up for v2.20.  If we want
> to minimize performance regressions with the SHA-256 work, I think it's
> important.

Thanks. One of the things I was worried about was causing unnecessary
conflicts with existing topics, including your work. But if everybody is
on board, I'd be happy to see this go in early in the next release cycle
(the longer we wait, the more annoying conflicts Junio has to resolve).

> Applying the following patch on top of this series causes gcc to inline
> both branches, which is pretty much the best we can expect.  I haven't
> benchmarked it, though, so I can't say what the actual performance
> consequence is.
> [...]
> diff --git a/cache.h b/cache.h
> index 3bb88ac6d0..1c182c6ef6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1033,7 +1033,10 @@ static inline int oidcmp(const struct object_id *oid1, const struct object_id *o
>  
>  static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -	return !hashcmp(sha1, sha2);
> +	if (the_hash_algo->rawsz == 32) {
> +		return !memcmp(sha1, sha2, 32);
> +	}
> +	return !memcmp(sha1, sha2, 20);
>  }

Yeah, I can reproduce that, too.  I'm actually surprised that's enough
to convince the compiler to inline, based on my earlier tests. I wonder
if it is because it is more able to see the boolean nature of the
memcmp() (i.e., in the earlier versions it was not willing to carry that
information across the conditional boundary for some reason). Or perhaps
it is that this is written slightly differently from my earlier case,
where the fallback did not say "32" explicitly, but rather:

  return memcmp(sha1, sha2, the_hash_algo->rawsz);

For your form, we'd probably want to add a third case arm with a BUG(),
just in case.

> As for this series itself, other than the typos people have pointed out,
> it looks good to me.

Thanks. Here it is again with those typos fixed, but no changes to the
patches themselves.

 1:  7bcf611959 =  1:  7bcf611959 coccinelle: use <...> for function exclusion
 2:  6025ebe5d1 !  2:  0e90944f5a introduce hasheq() and oideq()
    @@ -5,11 +5,10 @@
         The main comparison functions we provide for comparing
         object ids are hashcmp() and oidcmp(). These are more
         flexible than a strict equality check, since they also
    -    express ordering. That makes them them useful for sorting
    -    and binary searching. However, it also makes them
    -    potentially slower than a strict equality check. Consider
    -    this C code, which is traditionally what our hashcmp has
    -    looked like:
    +    express ordering. That makes them useful for sorting and
    +    binary searching. However, it also makes them potentially
    +    slower than a strict equality check. Consider this C code,
    +    which is traditionally what our hashcmp has looked like:
     
           #include <string.h>
           int hashcmp(const unsigned char *a, const unsigned char *b)
    @@ -51,7 +50,7 @@
         though the vast majority don't.
     
         We can solve that by introducing a hasheq() function (and
    -    matching oideq() wrapper), which callers can use to make
    +    matching oideq() wrapper), which callers can use to make it
         clear that they only care about equality. For now, the
         implementation will literally be "!hashcmp()", but it frees
         us up later to introduce code optimized specifically for the
 3:  35a05a7e5c =  3:  4f1ea17e79 convert "oidcmp() == 0" to oideq()
 4:  b18fc3994d =  4:  6614cc71e4 convert "hashcmp() == 0" to hasheq()
 5:  0fbcfcf7cc =  5:  c3dd2b2c80 convert "oidcmp() != 0" to "!oideq()"
 6:  32e169b886 =  6:  c94914f1ef convert "hashcmp() != 0" to "!hasheq()"
 7:  b90051c38b =  7:  c773fa9ca4 convert hashmap comparison functions to oideq()
 8:  b1e6ad80f0 =  8:  ada5809fab read-cache: use oideq() in ce_compare functions
 9:  18be86e078 !  9:  62f24d63a4 show_dirstat: simplify same-content check
    @@ -2,7 +2,7 @@
     
         show_dirstat: simplify same-content check
     
    -    We two nested conditionals to store a content_changed
    +    We use two nested conditionals to store a content_changed
         variable, but only bother to look at the result once,
         directly after we set it. We can drop the variable entirely
         and just use a single "if".
