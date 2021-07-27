Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B261C4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F8960FEB
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhG0RL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:11:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:58778 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0RL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:11:26 -0400
Received: (qmail 30895 invoked by uid 109); 27 Jul 2021 17:11:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 17:11:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 631 invoked by uid 111); 27 Jul 2021 17:11:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 13:11:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 13:11:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YQA+PaWb7tweEKuk@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
 <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
 <YP77DiffrCrxunvg@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP77DiffrCrxunvg@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 02:12:30PM -0400, Taylor Blau wrote:

> > This "> -1" struck me as a little bit funny. Perhaps ">= 0" would be a
> > more obvious way of saying "we found it"?
> 
> Sure. (I looked for other uses of oid_pos() to see what is more
> common, but there really are vanishingly few uses.) Easier to read might
> even be:
> 
>     int pos = oid_pos(...);
>     if (pos < 0)
>       return;
>     ALLOC_GROW(...);
> 
> which is what I ended up going for.

Sure, that's better still.

> [topo-sorting commits fed to bitmap writer]
>
> This comes from an investigation into why bitmap coverage had worsened
> for some repositories using MIDX bitmaps at GitHub. The real reason was
> resolved and unrelated to this, but trying to match the behavior of MIDX
> bitmaps to our existing pack bitmap setup (which uses delta-islands) was
> one strategy we tried while debugging.
>
> I actually suspect that it doesn't really matter what order we feed this
> list to bitmap_writer_select_commits() in, because the first thing that
> it does is QSORT() the incoming list of commits in date order.

Hmm, yes, I agree that it shouldn't matter for that reason (though
arguably topo order would still be better than a strict date order, it
does nothing now).

I remember looking into reasons why a single-pack bitmap versus a
midx-of-a-single-pack bitmap might not be identical, but the interesting
things turned out to be elsewhere. Did this actually change anything at
all? If so, then perhaps the "it doesn't matter" is not as true as we
are thinking. I could believe that it has a tiny impact when breaking
times between identical committer dates, though.

> But it does mirror the behavior of our previous bitmap generation
> settings, which has been running for years.
> 
> So... we could probably drop this hunk? I'd probably rather err on the
> safe side and leave this alone since it matches a system that we know to
> work well in practice.

I'd rather drop it, if we think it's doing nothing. While I do value
history in production as a sign of stability, upstream review is a good
time to make sure we understand all of the "why", and to clean things up
(e.g., another example is the questionable close_midx() stuff discussed
elsewhere).

And if we do suspect it is doing something, then IMHO the right thing is
probably still to drop it, and to introduce the feature identically to
both the midx and pack bitmap generation code paths. But that should be
a separate topic (and may actually involve fixing the QSORT to put
things in topo order rather than just date order).

> > > @@ -930,9 +1100,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> > >  		for (i = 0; i < ctx.m->num_packs; i++) {
> > >  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> > >
> > > +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> > > +				error(_("could not load pack %s"),
> > > +				      ctx.m->pack_names[i]);
> > > +				result = 1;
> > > +				goto cleanup;
> > > +			}
> >
> > It might be worth a comment here. I can easily believe that there is
> > some later part of the bitmap generation code that assumes the packs are
> > loaded. But somebody reading this is not likely to understand why it's
> > here.
> >
> > Should this be done conditionally only if we're writing a bitmap? (That
> > might also make it obvious why we are doing it).
> 
> Ah. Actually, I don't think this was necessary before, but we *do* need
> it now because we want to compare the pack mtime's for inferring a
> preferred pack when one wasn't given. And we also need to open the pack
> indexes, too, because we care about the object counts (to make sure that
> we don't infer a preferred pack which has no objects).
> 
> Luckily, any new packs will be loaded (and likewise have their indexes
> open, too), via the the add_pack_to_midx() callback that we pass as an
> argument to for_each_file_in_pack_dir().

Hmm, OK. Your second paragraph makes it sound like we _don't_ need to do
this. But the key is "new packs". In add_pack_to_midx() we skip any
packs that are already in the existing midx, assuming they've already
been added. And we probably must do that, otherwise we end up with
duplicate structs that are not actually shared by ctx->m.

> But we could do something like this instead:
> 
> --- 8< ---
> 
> diff --git a/midx.c b/midx.c
> index 8426e1a0b1..a70a6bca81 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1111,16 +1111,29 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  		for (i = 0; i < ctx.m->num_packs; i++) {
>  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> 
> -			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> -				error(_("could not load pack"));
> -				result = 1;
> -				goto cleanup;
> -			}
> -
>  			ctx.info[ctx.nr].orig_pack_int_id = i;
>  			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
> -			ctx.info[ctx.nr].p = ctx.m->packs[i];
> +			ctx.info[ctx.nr].p = NULL;
>  			ctx.info[ctx.nr].expired = 0;
> +
> +			if (flags & MIDX_WRITE_REV_INDEX) {
> +				/*
> +				 * If generating a reverse index, need to have
> +				 * packed_git's loaded to compare their
> +				 * mtimes and object count.
> +				 */
> +				if (prepare_midx_pack(the_repository, ctx.m, i)) {
> +					error(_("could not load pack"));
> +					result = 1;
> +					goto cleanup;
> +				}
> +
> +				if (open_pack_index(ctx.m->packs[i]))
> +					die(_("could not open index for %s"),
> +					    ctx.m->packs[i]->pack_name);
> +				ctx.info[ctx.nr].p = ctx.m->packs[i];
> +			}
> +

Yeah, was what I was suggesting: make it conditional on bitmaps (well, a
.rev index, which is more precise), and put in comments. :)

It's interesting that your earlier iteration didn't call
open_pack_index(). Is it necessary, or not? From your description, it
seems like it should be. But maybe some later step lazy-loads it? Even
if so, I can see how prepare_midx_pack() would still be required
(because we want to make sure we are using the same struct).

> [closing the midx]
> 
> The reason is kind of annoying. If we're building a MIDX bitmap
> in-process (e.g., `git multi-pack-index write --bitmap`) then we'll call
> prepare_packed_git() to build our pseudo-packing list which we pass to
> the bitmap generation machinery.
> 
> But prepare_packed_git() calls prepare_packed_git_one() ->
> for_each_file_in_pack_dir() with the prepare_pack() callback -> which
> the wants to see if the MIDX we have open already knows about a given
> pack so we avoid opening it twice.
> 
> But even though the MIDX would have gone away by this point (with the
> previous close_midx() call that is removed above), we still hold onto
> a pointer to it via the object_store's `multi_pack_index` pointer. And
> then all the way down in packfile.c:prepare_pack() we try to pass a
> now-defunct pointer as the first argument to midx_contains_pack(), and
> crash.
> 
> And clearing out that `multi_pack_index` pointer is tricky, because the
> MIDX would have to compare the odb's `object_dir` with its own (which is
> brittle in its own right), but also would have to see if that object
> store is pointing at *it*, and not some other MIDX.
> 
> So we do have to keep it open there. Which makes me wonder how this
> could possibly work on Windows, because holding the MIDX open will make
> the commit_lock_file() definitely fail. But it seems OK in the
> Windows-based CI runs?

Forgetting Windows for a moment, it seems like the same "the pointer is
bogus and we crash" is now just pushed down to the end of the function,
rather than the middle. I.e., it is safe to close the midx we got from
load_multi_pack_index(), but not one we got from
prepare_multi_pack_index_one(). So it's hard to reason about this at all
until that problem from patch 08 is resolved.

-Peff
