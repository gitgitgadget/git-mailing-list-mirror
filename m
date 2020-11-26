Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645DCC64E7B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1896320872
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbgKZIRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:17:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:43532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbgKZIRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 03:17:06 -0500
Received: (qmail 15731 invoked by uid 109); 26 Nov 2020 08:17:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 08:17:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14647 invoked by uid 111); 26 Nov 2020 08:17:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Nov 2020 03:17:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Nov 2020 03:17:04 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 08/12] mktag: use fsck instead of custom verify_tag()
Message-ID: <X79kgLjz4U9ubIKB@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
 <20201126012854.399-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201126012854.399-9-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 02:28:50AM +0100, Ævar Arnfjörð Bjarmason wrote:

> There was other "mktag" validation logic that I think makes sense to
> just remove. Namely:
> 
>  A. fsck only cares that the timezone matches [-+][0-9]{4}. The mktag
>     code disallowed values larger than 1400.
> 
>     Yes there's currently no timezone with a greater offset[2], but
>     since we allow any number of non-offical timezones (e.g. +1234)
>     passing this through seems fine. Git also won't break in the
>     future if e.g. French Polynesia decides it needs to outdo the Line
>     Islands when it comes to timezone extravagance.

Yeah, I think this is a good choice to loosen.

>  B. fsck allows missing author names such as "tagger <email>", mktag
>     wouldn't, but would allow e.g. "tagger <email>" (but not "tagger
>     <email>"). Now we allow all of these.

Likewise, though I am confused. Should the second "tagger <email>" in
that paragraph have something else in it?

>  C. Like B, but "mktag" disallowed spaces in the <email> part, fsck
>     allows it.

Possibly something we'd want to tighten in fsck, but I think keeping
them in alignment is a good idea for now.

> We didn't only lose obscure validation logic, we also gained some:
> 
>  D. fsck disallows zero-padded dates, but mktag didn't care. So
>     e.g. the timestamp "0000000000 +0000" produces an error now. A
>     test in "t1006-cat-file.sh" relied on this, it's been changed to
>     use "hash-object" (without fsck) instead.

Seems reasonable.

> +	/* verify_tag() will be removed in the next commit */
> +	verify_tag("", 0);
> +
> +	/*
> +	 * Fake up an object for fsck_object()
> +	 */
> +	obj.parsed = 1;
> +	obj.type = OBJ_TAG;

I don't love this "fake object struct on the stack" thing. I can't think
of anything that would break outright, but it may be the only place
where that struct isn't coming from the usual pool, and representing the
common part of a larger object. Two definite gotchas, though:

  - if the type is OBJ_TAG, then it may get cast to a "struct tag" by
    other code, which could look past the end of the struct. I think
    that fsck_object() doesn't do this, but it could (and it definitely
    used to)

  - you don't initialize the other fields. We'll definitely pass
    &obj->oid in the fsck code, and even back to our report() callback,
    even though it's full of garbage. In practice this is OK because our
    custom report() won't look at them, but it seems awfully fragile.

I recently genericized the type-specific fsck_* functions so that they
just need an oid, and not an object struct. I think I didn't do
fsck_object() just because it didn't have any callers where it mattered.
So I think it would make sense here to either:

  - make fsck_tag() specifically available outside of fsck.c, so could
    call it directly

  - convert fsck_object() to take an oid rather than an object struct.
    It only uses the object itself to check for NULL-ness. Looking at
    the callers, they all have non-NULL objects already. So I think that
    check can't be triggered.

>  check_verify_failure 'Tag object length check' \
> -	'^error: .*size wrong.*$'
> +	'^error: missingObject:'

We may want to enhance the "error:" here to make it clear we're talking
about a format error in the tag input. Maybe:

  error: tag input does not pass fsck: missingObject: ...

or something.

-Peff
