Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977EEC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37ED2205F4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgKWVeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:34:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:39038 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgKWVeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 16:34:22 -0500
Received: (qmail 28893 invoked by uid 109); 23 Nov 2020 21:34:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Nov 2020 21:34:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7705 invoked by uid 111); 23 Nov 2020 21:34:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 16:34:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 16:34:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mktag: don't check SHA-1 object length under SHA-256
Message-ID: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <20190826014344.16008-11-sandals@crustytoothpaste.net>
 <20201123120111.13567-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123120111.13567-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 01:01:11PM +0100, Ævar Arnfjörð Bjarmason wrote:

> @@ -46,9 +48,17 @@ static int verify_tag(char *buffer, unsigned long size)
>  	struct object_id oid;
>  	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
>  	size_t len;
> -
> -	if (size < 84)
> -		return error("wanna fool me ? you obviously got the size wrong !");
> +	int minimum_size =
> +		/* Minimum possible input, see t/t3800-mktag.sh */
> +		strlen("object ") + the_hash_algo->hexsz + strlen("\n") +
> +		strlen("type tag\n") +
> +		strlen("tag x\n") +
> +		strlen("tagger . <> 0 +0000\n") +
> +		strlen("\n");

This is an obvious improvement, but I have to wonder whether this kind
of "minimum size" up-front check is really buying us much. We do a lot
of fixed-size memcmps in the rest of the function.

In the early bits, like:

  if (memcmp(type_line - 1, "\ntype ", 6))
          return error("char%d: could not find \"\\ntype \"", 47);

that is saving us from going off the edge of a too-small input (though
wow, that bare "47" is really horrific).

But later, we'll do this:

  if (memcmp(tagger_line, "tagger ", 7))
           return error("char%"PRIuMAX": could not find \"tagger \"",
                   (uintmax_t) (tagger_line - buffer));

We've already parsed "tag x" at this point, and "x" can be arbitrarily
long. Are we sure we have 7 bytes of the buffer left?

The buffer always has a trailing NUL in it, so it would never match but
memcmp() is allowed to look at the whole thing (e.g., it can start at
the end, or do quadword comparisons). And that usually wouldn't matter,
but may depending on how the strbuf grows, and whether our heap buffer
is near the end of the last allocate page. Try this:

  git init
  git commit --allow-empty -m foo
  {
    echo "object $(git rev-parse HEAD)"
    echo "type commit"
    perl -e 'print "tag "; print "a" x 4026; print "\n"'
  } | git mktag

which ASan will complain about, since the "tagger" memcmp reads past the
end of the buffer (I found 4026 by running that in a loop of 1..4096).

I think this whole thing would be better written to just parse
left-to-right within the buffer, using bits like skip_prefix() that rely
on us having a trailing NUL (which we always will, and there should not
be one inside the header section).

This is how fsck_tag() does it. In fact, it seems like we could just
reuse fsck_tag() here. It wants to pass an oid to report(), but it would
be OK to use null_oid here; ultimately it just ends up back in our
callback error_func().

-Peff
