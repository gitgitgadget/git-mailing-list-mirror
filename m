Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF586CDB46E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjJKXGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjJKXGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:06:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C65A4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:06:42 -0700 (PDT)
Received: (qmail 20466 invoked by uid 109); 11 Oct 2023 23:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:06:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11192 invoked by uid 111); 11 Oct 2023 23:06:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:06:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:06:41 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/20] midx: check size of pack names chunk
Message-ID: <20231011230641.GI518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210514.GG3282181@coredump.intra.peff.net>
 <ZSa2nbVDTXvFZvSx@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSa2nbVDTXvFZvSx@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 10:52:13AM -0400, Taylor Blau wrote:

> On Mon, Oct 09, 2023 at 05:05:14PM -0400, Jeff King wrote:
> > @@ -176,9 +176,16 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
> >
> >  	cur_pack_name = (const char *)m->chunk_pack_names;
> >  	for (i = 0; i < m->num_packs; i++) {
> > +		const char *end;
> > +		size_t avail = m->chunk_pack_names_len -
> > +				(cur_pack_name - (const char *)m->chunk_pack_names);
> > +
> 
> This patch all looks good to me, but reading this hunk gave me a little
> bit of pause. I was wondering what might happen if chunk_pack_names_len
> was zero, and subtracting some other non-zero size_t from it might cause
> us to wrap around.
> 
> But I think that's a non-issue here, since we'd set cur_pack_name to the
> beginning of the chunk, and compute avail as 0 - (m->chunk_pack_names -
> m->chunk_pack_names), and get 0 back, causing our memchr() lookup below
> to fail, and for us to report this chunk is garbage.

Right. If it is 0, then we should have 0 avail here in the first loop.

I was more worried while writing this that:

  cur_pack_name = end + 1;

later in the loop could get us an off-by-one. But we know we are always
pointing to one past an available NUL there, so at most our subtraction
will equal m->chunk_pack_names_len.

> And since cur_pack_name monotonically increases, I think that there is
> an inductive argument to be made that this subtraction is always safe to
> do. But it couldn't hurt to do something like:
> 
>     size_t read = cur_pack_name - (const char *)m->chunk_pack_names;
>     size_t avail = m->chunk_pack_names_len;
> 
>     if (read > avail)
>         die("...");
>     avail -= read;
> 
> to make absolutely sure that we would never underflow here.

You end up with two die() calls, then. One for "hey, we somehow read too
far", and one for "hey, I ran out of data while reading the entry". And
the first one cannot be triggered.

IOW, I think your die() here is a BUG().

-Peff
