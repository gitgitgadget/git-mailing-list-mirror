Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EB7C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D90364E7D
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBPXro (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:47:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:35178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhBPXrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 18:47:42 -0500
Received: (qmail 15467 invoked by uid 109); 16 Feb 2021 23:47:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 23:47:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30755 invoked by uid 111); 16 Feb 2021 23:47:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 18:47:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 18:46:59 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 3/8] builtin/pack-objects.c: add '--stdin-packs' option
Message-ID: <YCxZcz5JGtxObOF3@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <c96b1bf99582beefb96c3774b13a4f5a12fc61cc.1612411124.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c96b1bf99582beefb96c3774b13a4f5a12fc61cc.1612411124.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:59:03PM -0500, Taylor Blau wrote:

> In an upcoming commit, 'git repack' will want to create a pack comprised
> of all of the objects in some packs (the included packs) excluding any
> objects in some other packs (the excluded packs).
> 
> This caller could iterate those packs themselves and feed the objects it
> finds to 'git pack-objects' directly over stdin, but this approach has a
> few downsides:
> 
>   - It requires every caller that wants to drive 'git pack-objects' in
>     this way to implement pack iteration themselves. This forces the
>     caller to think about details like what order objects are fed to
>     pack-objects, which callers would likely rather not do.
> 
>   - If the set of objects in included packs is large, it requires
>     sending a lot of data over a pipe, which is inefficient.
> 
>   - The caller is forced to keep track of the excluded objects, too, and
>     make sure that it doesn't send any objects that appear in both
>     included and excluded packs.
> 
> But the biggest downside is the lack of a reachability traversal.
> Because the caller passes in a list of objects directly, those objects
> don't get a namehash assigned to them, which can have a negative impact
> on the delta selection process, causing 'git pack-objects' to fail to
> find good deltas even when they exist.
>
> The caller could formulate a reachability traversal themselves, but the
> only way to drive 'git pack-objects' in this way is to do a full
> traversal, and then remove objects in the excluded packs after the
> traversal is complete. This can be detrimental to callers who care
> about performance, especially in repositories with many objects.

Yep, I think this is a good summary of the problem space, and why this
complexity should be pushed into pack-objects and not the caller.

> To address the delta selection problem, 'git pack-objects --stdin-packs'
> works as follows. First, it assembles a list of objects that it is going
> to pack, as above. Then, a reachability traversal is started, whose tips
> are any commits mentioned in included packs. Upon visiting an object, we
> find its corresponding object_entry in the to_pack list, and set its
> namehash parameter appropriately.
> 
> To avoid the traversal visiting more objects than it needs to, the
> traversal is halted upon encountering an object which can be found in an
> excluded pack (by marking the excluded packs as kept in-core, and
> passing --no-kept-objects=in-core to the revision machinery).
> 
> This can cause the traversal to halt early, for example if an object in
> an included pack is an ancestor of ones in excluded packs. But stopping
> early is OK, since filling in the namehash fields of objects in the
> to_pack list is only additive (i.e., having it helps the delta selection
> process, but leaving it blank doesn't impact the correctness of the
> resulting pack).

OK, good. Definitely worth calling out this subtle distinction of
correctness versus the heuristic.

Do we use this partial traversal to impact the write order at all? That
would be a nice-to-have, but I suspect that just concatenating the packs
(presumably by descending mtime) ends up with a similar result.

> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -85,6 +85,16 @@ base-name::
>  	reference was included in the resulting packfile.  This
>  	can be useful to send new tags to native Git clients.
>  
> +--stdin-packs::
> +	Read the basenames of packfiles from the standard input, instead
> +	of object names or revision arguments. The resulting pack
> +	contains all objects listed in the included packs (those not
> +	beginning with `^`), excluding any objects listed in the
> +	excluded packs (beginning with `^`).
> ++
> +Incompatible with `--revs`, or options that imply `--revs` (such as
> +`--all`), with the exception of `--unpacked`, which is compatible.

I know you say "basename" here, but I wonder if it is worth giving an
example (`pack-1234abcd.pack`) to make it clear in what form we expect
it. Or possibly something in the `EXAMPLES` section.

> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2979,6 +2979,164 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  	return git_default_config(k, v, cb);
>  }
>  
> +static int stdin_packs_found_nr;
> +static int stdin_packs_hints_nr;

I scratched my head at these until I looked further in the code. They're
the counters for the trace output. Might be worth a brief comment above
them. (I do approve of adding this kind of trace debugging info; I'm
pretty accustomed to using gdb or adding one-off debug statements, but
we really could do a better job in general of making these kinds of
internals visible to mere mortal admins).

> +static int add_object_entry_from_pack(const struct object_id *oid,
> +				      struct packed_git *p,
> +				      uint32_t pos,
> +				      void *_data)
> +{
> +	struct rev_info *revs = _data;
> +	struct object_info oi = OBJECT_INFO_INIT;
> +	off_t ofs;
> +	enum object_type type;
> +
> +	display_progress(progress_state, ++nr_seen);
> +
> +	ofs = nth_packed_object_offset(p, pos);
> +
> +	oi.typep = &type;
> +	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
> +		die(_("could not get type of object %s in pack %s"),
> +		    oid_to_hex(oid), p->pack_name);

Calling out for other reviewers: the oi.typep field will be filled in
the with _real_ type of the object, even if it's a delta. This is as
opposed to the return value of packed_object_info(), which may be
OFS_DELTA or REF_DELTA.

And that real type is what we want here:

> +	else if (type == OBJ_COMMIT) {
> +		/*
> +		 * commits in included packs are used as starting points for the
> +		 * subsequent revision walk
> +		 */
> +		add_pending_oid(revs, NULL, oid, 0);
> +	}

And later when we call create_object_entry().

I wondered whether it would be worth adding other objects we might find,
like trees, in order to increase our traversal. But that doesn't make
any sense. The whole point is to find the paths, which come from
traversing from the root trees. And we can only find the root trees by
starting at commits. Adding any random tree we found would defeat the
purpose (most of them are sub-trees and would give us a useless partial
path).

Should we avoid adding the commit as a tip for walking if it won't end
up in the resulting pack? I.e., should we check these:

> +	if (have_duplicate_entry(oid, 0))
> +		return 0;
> +
> +	if (!want_object_in_pack(oid, 0, &p, &ofs))
> +		return 0;

...first? I guess it probably doesn't matter too much since we'd
truncate the traversal as soon as we saw it was in a kept pack anyway.

> +static void show_commit_pack_hint(struct commit *commit, void *_data)
> +{
> +}

Nothing to do here, since commits don't have a name field. Makes sense.

> +static void show_object_pack_hint(struct object *object, const char *name,
> +				  void *_data)
> +{
> +	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
> +	if (!oe)
> +		return;
> +
> +	/*
> +	 * Our 'to_pack' list was constructed by iterating all objects packed in
> +	 * included packs, and so doesn't have a non-zero hash field that you
> +	 * would typically pick up during a reachability traversal.
> +	 *
> +	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
> +	 * here using a now in order to perhaps improve the delta selection
> +	 * process.
> +	 */
> +	oe->hash = pack_name_hash(name);
> +	oe->no_try_delta = name && no_try_delta(name);
> +
> +	stdin_packs_hints_nr++;
> +}

But for actual objects, we do fill in the hash. I wonder if it's
possible for oe->hash to have been already filled. I don't think it
really matters, though. Any value we get is equally valid, so
overwriting is OK in that case.

> +	string_list_sort(&include_packs);
> +	string_list_sort(&exclude_packs);
> +
> +	for (p = get_all_packs(the_repository); p; p = p->next) {
> +		const char *pack_name = pack_basename(p);
> +
> +		item = string_list_lookup(&include_packs, pack_name);
> +		if (!item)
> +			item = string_list_lookup(&exclude_packs, pack_name);
> +
> +		if (item)
> +			item->util = p;
> +	}

OK, here we're just filling in the util field with each found pack. So
we wouldn't notice a pack that we didn't find, but we will in the
subsequent loops. Makes sense.

I think you could do without string lists at all by using the recent-ish
pack-hash to efficiently look up the names, but I'm perfectly content to
see it all handled within this function.

> +	/*
> +	 * First handle all of the excluded packs, marking them as kept in-core
> +	 * so that later calls to add_object_entry() discards any objects that
> +	 * are also found in excluded packs.
> +	 */
> +	for_each_string_list_item(item, &exclude_packs) {
> +		struct packed_git *p = item->util;
> +		if (!p)
> +			die(_("could not find pack '%s'"), item->string);
> +		p->pack_keep_in_core = 1;
> +	}
> +	for_each_string_list_item(item, &include_packs) {
> +		struct packed_git *p = item->util;
> +		if (!p)
> +			die(_("could not find pack '%s'"), item->string);
> +		for_each_object_in_pack(p,
> +					add_object_entry_from_pack,
> +					&revs,
> +					FOR_EACH_OBJECT_PACK_ORDER);
> +	}

Yeah, this ordering makes sense.

> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));
> +	traverse_commit_list(&revs,
> +			     show_commit_pack_hint,
> +			     show_object_pack_hint,
> +			     NULL);

And this traversal is pretty straight-forward. Looks good.

> +	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
> +			   stdin_packs_found_nr);

I wonder if it makes sense to report the actual set of packs via trace
(obviously not as an int, but as a list). That's less helpful for
debugging pack-objects, if you just fed it the input anyway, but if you
were debugging "git repack --geometric" it might be useful to see which
packs it thought were which (though arguably that would be a useful
trace in builtin/repack.c instead).

> @@ -3636,7 +3797,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		use_internal_rev_list = 1;
>  		strvec_push(&rp, "--indexed-objects");
>  	}
> -	if (rev_list_unpacked) {
> +	if (rev_list_unpacked && !stdin_packs) {
>  		use_internal_rev_list = 1;
>  		strvec_push(&rp, "--unpacked");
>  	}

OK, this is necessary to avoid triggering the internal rev-list, because
we handle --unpacked ourselves specially later here...

> @@ -3741,7 +3907,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  
>  	if (progress)
>  		progress_state = start_progress(_("Enumerating objects"), 0);
> -	if (!use_internal_rev_list)
> +	if (stdin_packs) {
> +		/* avoids adding objects in excluded packs */
> +		ignore_packed_keep_in_core = 1;
> +		read_packs_list_from_stdin();
> +		if (rev_list_unpacked)
> +			add_unreachable_loose_objects();

Which isn't quite behaving like normal --unpacked (in that we are adding
all loose objects, not just reachable ones). I think we actually could
just add --unpacked as part of our heuristic traversal. It's not
perfect, but unlike the packed objects, it's OK for us to miss some
corner cases (they just end up not getting packed; they don't get
deleted).

I'm OK to consider that an implementation detail for now, though. We can
change it later without impacting the interface.

> +		if (rev_list_unpacked)
> +			add_unreachable_loose_objects();

Despite the name, that function is adding both reachable and unreachable
ones. So it is doing what you want. It might be worth renaming, but it's
not too big a deal since it's local to this file.

-Peff
