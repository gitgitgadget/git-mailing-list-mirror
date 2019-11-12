Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36BE1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfKLK6A (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:58:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:45176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725887AbfKLK6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:58:00 -0500
Received: (qmail 31287 invoked by uid 109); 12 Nov 2019 10:58:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Nov 2019 10:58:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13596 invoked by uid 111); 12 Nov 2019 11:01:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2019 06:01:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Nov 2019 05:57:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] hex: drop sha1_to_hex()
Message-ID: <20191112105759.GA9714@sigill.intra.peff.net>
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <20191111090418.GB12545@sigill.intra.peff.net>
 <20191111141805.GK4348@szeder.dev>
 <20191111142904.GB1934@sigill.intra.peff.net>
 <xmqqa791hgu1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa791hgu1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 01:13:58PM +0900, Junio C Hamano wrote:

> >> We can't use oid_to_hex() because we don't have a 'struct object_id'
> >> in the first place, as sha1dc only ever deals with 20 unsigned chars.
> >
> > Ah, you're right. I admit I am still getting up to speed on all of the
> > new hash-agnostic versions of the various functions.
> 
> Thanks.  I've amended this one and the range diff since the pushout
> yesterday looks like this.

Thanks. This first hunk is what I would have done:

> 1:  8a030f1796 ! 1:  02d21d4117 hex: drop sha1_to_hex()
>     @@ Commit message
>          hex: drop sha1_to_hex()
>      
>          There's only a single caller left of sha1_to_hex(), since everybody now
>     -    uses oid_to_hex() instead. This case is in the sha1dc wrapper, where we
>     +    uses hash_to_hex() instead. This case is in the sha1dc wrapper, where we
>          print a hex sha1 when we find a collision. This one will always be sha1,
>     -    regardless of the current hash algorithm, so we can't use oid_to_hex()
>     +    regardless of the current hash algorithm, so we can't use hash_to_hex()
>          here. In practice we'd probably not be running sha1 at all if it isn't
>          the current algorithm, but it's possible we might still occasionally
>          need to compute a sha1 in a post-sha256 world.

This second one is OK, but not entirely necessary:

>     @@ cache.h: int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
>        * buffers, making it safe to make multiple calls for a single statement, like:
>        *
>      - *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
>     -+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
>     ++ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
>        */
>       char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
>       char *oid_to_hex_r(char *out, const struct object_id *oid);

This one-liner leaves the types of "one" and "two" unspecified. :) So
it's not wrong to use hash_to_hex(), but maybe it's better to be pushing
people towards oid_to_hex() as their first choice? It probably doesn't
matter too much either way.

-Peff
