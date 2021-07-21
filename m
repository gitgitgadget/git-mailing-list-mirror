Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C163EC636CE
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A24561263
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhGUL2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:28:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:53204 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233692AbhGUL2n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 07:28:43 -0400
Received: (qmail 2454 invoked by uid 109); 21 Jul 2021 12:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 12:09:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4117 invoked by uid 111); 21 Jul 2021 12:09:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 08:09:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 08:09:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:34PM -0400, Taylor Blau wrote:

> +static int add_ref_to_pending(const char *refname,
> +			      const struct object_id *oid,
> +			      int flag, void *cb_data)
> +{
> +	struct rev_info *revs = (struct rev_info*)cb_data;
> +	struct object *object;
> +
> +	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
> +		warning("symbolic ref is dangling: %s", refname);
> +		return 0;
> +	}
> +
> +	object = parse_object_or_die(oid, refname);
> +	if (object->type != OBJ_COMMIT)
> +		return 0;
> +
> +	add_pending_object(revs, object, "");
> +	if (bitmap_is_preferred_refname(revs->repo, refname))
> +		object->flags |= NEEDS_BITMAP;
> +	return 0;
> +}

OK, so we'll look at each ref to get the set of commits that we want to
traverse to put into the bitmap. Which is roughly the same as what the
pack bitmap does. We only generate bitmaps for all-into-one repacks, so
it is traversing all of the reachable objects. It is a little different
in that the pack version is probably hitting reflogs, but IMHO we are
better off to ignore reflogs for the purposes of bitmaps (I would
suggest to do so in the pack-bitmap case, too, except that it is
combined with the "what to pack" traversal there, and by the time we see
each commit we don't know how we got there).

> +struct bitmap_commit_cb {
> +	struct commit **commits;
> +	size_t commits_nr, commits_alloc;
> +
> +	struct write_midx_context *ctx;
> +};
> +
> +static const struct object_id *bitmap_oid_access(size_t index,
> +						 const void *_entries)
> +{
> +	const struct pack_midx_entry *entries = _entries;
> +	return &entries[index].oid;
> +}
> +
> +static void bitmap_show_commit(struct commit *commit, void *_data)
> +{
> +	struct bitmap_commit_cb *data = _data;
> +	if (oid_pos(&commit->object.oid, data->ctx->entries,
> +		    data->ctx->entries_nr,
> +		    bitmap_oid_access) > -1) {

This "> -1" struck me as a little bit funny. Perhaps ">= 0" would be a
more obvious way of saying "we found it"?

> +	/*
> +	 * Skipping promisor objects here is intentional, since it only excludes
> +	 * them from the list of reachable commits that we want to select from
> +	 * when computing the selection of MIDX'd commits to receive bitmaps.
> +	 *
> +	 * Reachability bitmaps do require that their objects be closed under
> +	 * reachability, but fetching any objects missing from promisors at this
> +	 * point is too late. But, if one of those objects can be reached from
> +	 * an another object that is included in the bitmap, then we will
> +	 * complain later that we don't have reachability closure (and fail
> +	 * appropriately).
> +	 */
> +	fetch_if_missing = 0;
> +	revs.exclude_promisor_objects = 1;

Makes sense.

> +	/*
> +	 * Pass selected commits in topo order to match the behavior of
> +	 * pack-bitmaps when configured with delta islands.
> +	 */
> +	revs.topo_order = 1;
> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;

Hmm. Why do we want to match this side effect of delta islands here?

The only impact this has is on the order of commits we feed for bitmap
selection (and during the actual generation phase, it may impact
visitation order).

Now I'm of the opinion that topo order is probably the best thing for
bitmap generation (since the bitmaps themselves are connected to the
graph structure). But if it is the best thing, shouldn't we perhaps be
turning on topo-order for single-pack bitmaps, too?

And if it isn't the best thing, then why would we want it here?

> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));

We call init_revisions(), and then go straight to
prepare_revision_walk() with no call to setup_revisions() between. It
doesn't seem to be clearly documented, but I think you're supposed to,
as it finalizes some bits like diff_setup_done().

I suspect it works OK in practice, and I did find a few other spots that
do not call it (e.g., builtin/am.c:write_commit_patch). But most spots
do at least an empty setup_revisions(0, NULL, &rev, NULL).

> +	/*
> +	 * Build the MIDX-order index based on pdata.objects (which is already
> +	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
> +	 * this order).
> +	 */
> +	ALLOC_ARRAY(index, pdata.nr_objects);
> +	for (i = 0; i < pdata.nr_objects; i++)
> +		index[i] = (struct pack_idx_entry *)&pdata.objects[i];

This cast is correct because the pack_idx_entry is at the start of each
object_entry. But maybe:

  index[i] = &pdata.objects[i].idx;

would be less scary looking?

> +	/*
> +	 * bitmap_writer_finish expects objects in lex order, but pack_order
> +	 * gives us exactly that. use it directly instead of re-sorting the
> +	 * array.
> +	 *
> +	 * This changes the order of objects in 'index' between
> +	 * bitmap_writer_build_type_index and bitmap_writer_finish.
> +	 *
> +	 * The same re-ordering takes place in the single-pack bitmap code via
> +	 * write_idx_file(), which is called by finish_tmp_packfile(), which
> +	 * happens between bitmap_writer_build_type_index() and
> +	 * bitmap_writer_finish().
> +	 */
> +	for (i = 0; i < pdata.nr_objects; i++)
> +		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];

Ditto here.

> +	bitmap_writer_select_commits(commits, commits_nr, -1);

Not related to your patch, but I had to refresh my memory on what this
"-1" was for. It's "max_bitmaps", and is ignored if it's negative. But
the only callers pass "-1"! So we could get rid of it entirely.

It probably makes sense to leave that cleanup out of this
already-complicated series. But maybe worth doing later on top.

> @@ -930,9 +1100,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  		for (i = 0; i < ctx.m->num_packs; i++) {
>  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
>  
> +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> +				error(_("could not load pack %s"),
> +				      ctx.m->pack_names[i]);
> +				result = 1;
> +				goto cleanup;
> +			}

It might be worth a comment here. I can easily believe that there is
some later part of the bitmap generation code that assumes the packs are
loaded. But somebody reading this is not likely to understand why it's
here.

Should this be done conditionally only if we're writing a bitmap? (That
might also make it obvious why we are doing it).

> @@ -947,8 +1124,26 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
>  	stop_progress(&ctx.progress);
>  
> -	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
> -		goto cleanup;
> +	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop) {
> +		struct bitmap_index *bitmap_git;
> +		int bitmap_exists;
> +		int want_bitmap = flags & MIDX_WRITE_BITMAP;
> +
> +		bitmap_git = prepare_bitmap_git(the_repository);
> +		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
> +		free_bitmap_index(bitmap_git);
> +
> +		if (bitmap_exists || !want_bitmap) {
> +			/*
> +			 * The correct MIDX already exists, and so does a
> +			 * corresponding bitmap (or one wasn't requested).
> +			 */
> +			if (!want_bitmap)
> +				clear_midx_files_ext(the_repository, ".bitmap",
> +						     NULL);
> +			goto cleanup;
> +		}
> +	}

So this makes "git multi-pack-index write --write-bitmap" actually write
a bitmap, even if the midx itself didn't need updating? Sounds good.
Likewise, we'll delete a bitmap if one exists but we were not requested
to write one. Makes sense.

I do think nice-to-have bits like this could have come in a separate
patch with their own explanation and tests. It may not be worth trying
to extract it at this point, though.

> @@ -1075,9 +1271,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>  	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
>  
> -	if (ctx.m)
> -		close_midx(ctx.m);
> -
>  	if (ctx.nr - dropped_packs == 0) {
>  		error(_("no pack files to index."));
>  		result = 1;

I'm not sure what this hunk is doing. We do pick up the close_midx()
call at the end of the function, amidst the other cleanup.

I expect the answer is something like "we need it open when we generate
the bitmaps". But it makes me wonder if we could hit any cases where we
try to overwrite it while it's still open, which would cause problems on
Windows.

-Peff
