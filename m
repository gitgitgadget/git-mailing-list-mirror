Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DCF20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbdLFVnq (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 16:43:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:50244 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752134AbdLFVnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:43:46 -0500
Received: (qmail 21232 invoked by uid 109); 6 Dec 2017 21:43:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Dec 2017 21:43:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15229 invoked by uid 111); 6 Dec 2017 21:44:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 06 Dec 2017 16:44:06 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Dec 2017 16:43:44 -0500
Date:   Wed, 6 Dec 2017 16:43:44 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] 'unsigned long' to 'size_t' conversion
Message-ID: <20171206214343.GA19469@sigill.intra.peff.net>
References: <a660460d-b294-5113-bfaf-d98bcf99bad5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a660460d-b294-5113-bfaf-d98bcf99bad5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 06, 2017 at 10:08:23AM -0500, Derrick Stolee wrote:

> There are several places in Git where we refer to the size of an object by
> an 'unsigned long' instead of a 'size_t'. In 64-bit Linux, 'unsigned long'
> is 8 bytes, but in 64-bit Windows it is 4 bytes.
> 
> The main issue with this conversion is that large objects fail to load (they
> seem to hash and store just fine). For example, the following 'blob8gb' is
> an 8 GB file where the ith byte is equal to i % 256:

Yeah, I think there's widespread agreement that this needs fixing. It's
just big enough that nobody has tackled it. If you're willing, that
sounds great to me. ;)

> In my opinion, the correct thing to do would be to replace all 'unsigned
> long's that refer to an object size and replace them with 'size_t'. However,
> a simple "git grep 'unsigned long size'" reveals 194 results, and there are
> other permutations of names and pointer types all over.

Yep. I think it's actually even trickier than that, though. Something
like off_t is probably the right type for the abstract concept of an
object size, since objects can be larger than the address space (in
which case we'd generally hit streaming code paths when possible).

But then of course we'd want to use size_t for objects that we've
actually placed into a buffers. At first glance it might be OK to just
use a larger type everywhere, but I think that runs into some funny
situations. For instance, you would not want to pass an off_t to
xmalloc(), as it is truncated (which may lead to a too-small buffer and
then a heap-smashing overflow).

So in an ideal world it is something like:

  - abstract object types are always off_t

  - lower-level code that takes an object in a buffer always uses size_t

  - at the conversion point, we must always use xsize_t() to catch
    conversion problems.

  - Any time that xsize_t() might die is a place where the caller should
    probably figure out if it can use a streaming code path for large
    objects.

> This conversion would be a significant patch, so I wanted to get the
> community's thoughts on this conversion.
> 
> If there are small, isolated chunks that can be done safely, then this may
> be a good target for a first patch.

Yes, I agree this probably has to be done incrementally. The threads
Thomas linked might be good starting points. But do be careful with
incremental changes that you don't introduce any spots where we might
get a value mismatch that used to be consistently truncated. E.g., this
code is wrong but not a security problem:

  size_t full_len = strlen(src); /* ok */
  unsigned long len = full_len; /* possible truncation! */
  char *dst = xmalloc(len); /* buffer possibly smaller than full_len */
  memcpy(dst, src, len); /* copies truncated value */

But this has a vulnerability:

  memcpy(dst, src, full_len); /* whoops, buffer is too small! */

Obviously this is a stupid toy example, but in the real world things
like that "unsigned long" assignment happen via implicit conversion in
function parameters. Or we never have "full_len" in the first place, and
instead build it up over a series of operations that write into the
buffer. Etc.

I made a pass over the whole code-base a while back to fix any existing
problems and introduce helpers to make it harder to get this wrong
(e.g., by making sure a consistent value is used for allocating and
populating a buffer). So I _hope_ that it should be hard to accidentally
regress any code by switching out types. But it's something to be aware
of.

-Peff
