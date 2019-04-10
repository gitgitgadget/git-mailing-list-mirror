Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FF020248
	for <e@80x24.org>; Wed, 10 Apr 2019 16:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfDJQUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 12:20:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:53742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727892AbfDJQUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 12:20:33 -0400
Received: (qmail 27691 invoked by uid 109); 10 Apr 2019 16:20:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Apr 2019 16:20:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16789 invoked by uid 111); 10 Apr 2019 16:20:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Apr 2019 12:20:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2019 12:20:29 -0400
Date:   Wed, 10 Apr 2019 12:20:29 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] untracked cache: fix off-by-one
Message-ID: <20190410162029.GA30818@sigill.intra.peff.net>
References: <pull.178.git.gitgitgadget@gmail.com>
 <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 05:56:48AM -0700, Johannes Schindelin via GitGitGadget wrote:

> Probably in the endeavor to avoid the `calloc()` implied by
> `FLEX_ALLOC_STR()` (it is hard to know why exactly, the commit message
> of that commit is a bit parsimonious with information), it calls
> `malloc()` manually and then `memcpy()`s the bits and pieces into place.

You have a talent for understatement. :)

> It allocates the size of `struct untracked_cache_dir` plus the string
> length of the untracked file name, then copies the information in two
> steps: first the fixed-size metadata, then the name. And here lies the
> rub: it includes the trailing NUL byte in the name.
> 
> If `FLEX_ARRAY` is defined as 0, this results in a buffer overrun.
> 
> To fix this, let's just add 1, for the trailing NUL byte. Technically,
> this overallocates on platforms where `FLEX_ARRAY` is 1, but it should
> not matter much in reality, as `malloc()` usually overallocates anyway,
> unless the size to allocate aligns exactly with some internal chunk size
> (see below for more on that).

Yeah, every struct on a platform where FLEX_ARRAY is 1 ends up
over-allocated by 1 byte. We could account for that in all of our flex
allocations, but I don't it affects enough platforms to be worth the
bother.

> The real strange thing is that neither valgrind nor DrMemory catches
> this bug. In this developer's tests, a `memcpy()` (but not a
> `memset()`!) could write up to 4 bytes after the allocated memory range
> before valgrind would start reporting an issue.

I couldn't get it to trigger with ASan, either.  I assume it's due to
alignment (i.e., those tools are stuck poisoning at the end of a page,
but the start of the struct needs to be page-aligned). But that would
imply that we could trigger it with different path lengths, which I
wasn't able to do. So I dunno.

> However, when running Git built with nedmalloc as allocator, under rare
> conditions (and inconsistently at that), this bug triggered an `abort()`
> because nedmalloc rounds up the size to be `malloc()`ed to a multiple of
> a certain chunk size, then adds a few bytes to be used for storing some
> internal state. If there is no rounding up to do (because the size is
> already a multiple of that chunk size), and if the buffer is overrun as
> in the code patched in this commit, the internal state is corrupted.
>
> The scenario that triggered this here bug fix entailed a git.git
> checkout with an extra copy of the source code in an untracked
> subdirectory, meaning that there was an untracked subdirectory called
> "thunderbird-patch-inline" whose name's length is exactly 24 bytes,
> which, added to the size of above-mentioned `struct untracked_cache_dir`
> that weighs in with 104 bytes on a 64-bit system, amounts to 128,
> aligning perfectly with nedmalloc's chunk size.

Right, that makes sense that the length would impact it there.

> As there is no obvious way to trigger this bug reliably, on all
> platforms supported by Git, and as the bug is obvious enough, this patch
> comes without a regression test.

Makes sense. This code path should be well-covered by the existing tests
anyway, so even if we could get those tools to trigger, I don't think
there would be much point in adding a new test.

> diff --git a/dir.c b/dir.c
> index b2cabadf25..f5293a6536 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2760,7 +2760,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
>  	next = data + len + 1;
>  	if (next > rd->end)
>  		return -1;
> -	*untracked_ = untracked = xmalloc(st_add(sizeof(*untracked), len));
> +	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), len, 1));
>  	memcpy(untracked, &ud, sizeof(ud));
>  	memcpy(untracked->name, data, len + 1);

This is obviously correct, even just from the context.

IMHO it is worth it in cases like this to just use FLEX_ALLOC for
simplicity; calloc() is not too expensive. However, there's an
interesting subtlety there. Our length comes from this line just above
your hunk:

  len = strlen((const char *)data);

how do we know that data actually contains a NUL? It's ultimately
pointing to our mmap of the index file. So I think a malformed index
would potentially cause us to go off the end of the array and read
arbitrary memory.

The right thing is probably something like:

  eos = memchr(data, '\0', end - data);
  if (!eos)
	return error("malformed untracked cache extension");
  len = eos - data;

I wouldn't be at all surprised if other bits of the index code have the
same issue, though. And at any rate, thinking about that should
definitely not hold up your fix.

-Peff
