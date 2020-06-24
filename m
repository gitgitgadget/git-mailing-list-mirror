Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99718C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E04E20781
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404312AbgFXPyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:54:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:41958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403931AbgFXPyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:54:22 -0400
Received: (qmail 21345 invoked by uid 109); 24 Jun 2020 15:54:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jun 2020 15:54:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30558 invoked by uid 111); 24 Jun 2020 15:54:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jun 2020 11:54:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Jun 2020 11:54:20 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] fast-export: store anonymized oids as hex strings
Message-ID: <20200624155420.GC2088459@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152451.GC1435482@coredump.intra.peff.net>
 <20200624114313.GJ2898@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624114313.GJ2898@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 01:43:13PM +0200, SZEDER Gábor wrote:

> >  	static uint32_t counter = 1; /* avoid null oid */
> >  	const unsigned hashsz = the_hash_algo->rawsz;
> > -	unsigned char *out = xcalloc(hashsz, 1);
> > -	put_be32(out + hashsz - 4, counter++);
> > -	return out;
> > +	struct object_id oid;
> > +	char *hex = xmallocz(GIT_MAX_HEXSZ);
> > +
> > +	oidclr(&oid);
> > +	put_be32(oid.hash + hashsz - 4, counter++);
> > +	return oid_to_hex_r(hex, &oid);
> >  }
> 
> GCC 4.8 complains about this change in our CI job:
> 
>   $ make CC=gcc-4.8 builtin/fast-export.o
>       CC builtin/fast-export.o
>   builtin/fast-export.c: In function ‘generate_fake_oid’:
>   builtin/fast-export.c:394:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
>     put_be32(oid.hash + hashsz - 4, counter++);
>     ^
>   cc1: all warnings being treated as errors

Interesting. The only change on this line is swapping out the local
"unsigned char *" for an object_id, which also stores an "unsigned
char" (though as an array). And while put_be32() takes a void pointer,
it's inlined and treats it the argument an "unsigned char *" internally.
So I'm not sure I see that any type punning is going on at all.

I'll see if I can appease the compiler, though.

-Peff
