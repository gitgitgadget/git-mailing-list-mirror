Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44F6C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF81420760
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgGAPUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:20:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:47312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbgGAPUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 11:20:41 -0400
Received: (qmail 24515 invoked by uid 109); 1 Jul 2020 15:20:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2020 15:20:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5927 invoked by uid 111); 1 Jul 2020 15:20:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2020 11:20:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Jul 2020 11:20:40 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] ref-filter: add support for %(contents:size)
Message-ID: <20200701152040.GB6726@coredump.intra.peff.net>
References: <20200701132308.16691-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701132308.16691-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 03:23:08PM +0200, Christian Couder wrote:

> It's useful and efficient to be able to get the size of the
> contents directly without having to pipe through `wc -c`.
> 
> Also the result of the following:
> 
> `git for-each-ref --format='%(contents)' | wc -c`
> 
> is off by one as `git for-each-ref` appends a newline character
> after the contents, which can be seen by comparing its ouput
> with the output from `git cat-file`.

It could also be accessed much more quickly, since we don't actually
need to load the object contents into memory to know the size.  cat-file
does these kind of optimizations (by building on oid_object_info()), and
its %(objectsize) will do the minimum amount of work needed.

I was going to suggest that instead of adding %(contents:size), you just
add %(objectsize). That would match cat-file's existing option, and we
hope to unify the formatters eventually. But it already exists (and I
think is even optimized courtesy of Olga's work).

> -The complete message in a commit and tag object is `contents`.
> -Its first line is `contents:subject`, where subject is the concatenation
> -of all lines of the commit message up to the first blank line.  The next
> -line is `contents:body`, where body is all of the lines after the first
> -blank line.  The optional GPG signature is `contents:signature`.  The
> -first `N` lines of the message is obtained using `contents:lines=N`.
> -Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
> -are obtained as `trailers` (or by using the historical alias
> -`contents:trailers`).  Non-trailer lines from the trailer block can be omitted
> -with `trailers:only`. Whitespace-continuations can be removed from trailers so
> -that each trailer appears on a line by itself with its full content with
> -`trailers:unfold`. Both can be used together as `trailers:unfold,only`.
> +The complete message in a commit and tag object is `contents`.  Its
> +size in bytes is `contents:size`.  Its first line is
> +`contents:subject`, where subject is the concatenation of all lines of
> +the commit message up to the first blank line.  The next line is
> +`contents:body`, where body is all of the lines after the first blank
> +line.  The optional GPG signature is `contents:signature`.  The first
> +`N` lines of the message is obtained using `contents:lines=N`.
> +Additionally, the trailers as interpreted by
> +linkgit:git-interpret-trailers[1] are obtained as `trailers` (or by
> +using the historical alias `contents:trailers`).  Non-trailer lines
> +from the trailer block can be omitted with
> +`trailers:only`. Whitespace-continuations can be removed from trailers
> +so that each trailer appears on a line by itself with its full content
> +with `trailers:unfold`. Both can be used together as
> +`trailers:unfold,only`.

Definitely not a new problem, but boy is that a dense paragraph. I
suspect an unordered list might be a nicer way of presenting the list of
format specifiers.

-Peff
