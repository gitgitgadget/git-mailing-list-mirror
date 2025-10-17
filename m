Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC03126DE
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697548; cv=none; b=APzDRRsJhxB+LojqYgTTsgcMkXiwHmBfH40PpXfsrRBeQu74mUTR6rN1eEQMiTUR3eIPBFXNApmemgbC5elPhoc9NRIXydwqD+bgIUx8TyzRijEjspcQZ7oW1YYhKeSkVJblv5zXDR1UyF9KrTLfz491UcqKPwUDompMzSSX6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697548; c=relaxed/simple;
	bh=7xMfhO5xzM0XPaWqq6Aj3kCewc3ykNqWQ2+UbRz37WQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jWh8HeEwZsoOF+EnGgyy0wwtzgvcq/4/BXIbUIgRFzNAN4N1slqkMH56m94cMQWAw4sssqRacLrVH6EsYvaqAUT4XfNgri/CkRqG0XMpl/IVYS2KmQP9ykRC+VLc1T5fRTIIIHySHPovwYjHaPtFMJJh/jKhIgC7FUKlJbKPCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=uZoIpFnu; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="uZoIpFnu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1760697541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhe9iK7ZMGUX+wB7J1TW1cqEdHvIZO66xrIv9dm/zrE=;
	b=uZoIpFnuvuDp6eFl9KsjhN0vG9K6rYBgxMQkn8/w4lkxrYRlnd6w+5GZtopaOpg/3vZir7
	W55pfIov2bedfpRM8aMw8IVolygFplfbmwq4zoLkJ/T1zvn2S9Q11AhvJlZofRHXwTChcD
	uYgpO1mEauaTTtWR6UIr2Xzgitvdlyc=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
In-Reply-To: <kkcpsorsmyfdxlxnlzliuggsaehhrfvfphdse7aslvwsrbm64b@ylgl65mzot2z>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <kkcpsorsmyfdxlxnlzliuggsaehhrfvfphdse7aslvwsrbm64b@ylgl65mzot2z>
Date: Fri, 17 Oct 2025 12:38:49 +0200
Message-ID: <87sefhu81y.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> Ok so if I understand correctly, the optimization here is that as we
> perform the revision walk, the set of paths we look for at each commit
> monotonically decreases as changed paths are identified. Prior to this,
> we were always checking all paths for each commit even though a path may
> have already found the commit that last modified it.

Not only that, we only pass on paths to one parent. So either a path is
treesame to a parent, that means it was not changed in the current
commit, and then we only pass that path to that parent. If the commit
had multiple parents, the merge ignored versions from other parents.

If the path isn't treesame to any of the parents, we know the current
commit modified the path, and we associate that commit with that path.


> [snip]
>> As an added benefit, this implementation gives more correct results. For
>> example implementation in 'master' gives:
>
> s/implementation/the implementation/

Fair enough, but I also need to rephrase the "more correct" as pointed
out by Ben[1].

[1]: https://lore.kernel.org/git/CALnO6CBwuAdBFjESZSYZkChNdU9R17OXDc+CY=Z96QoACPgrpQ@mail.gmail.com/

>> +/* Remember to update object flag allocation in object.h */
>
> At first I was wondering if this is a leftover note, but it looks like
> it is just a reminder if the allocations change here.

Yeah, it seems to be the common pattern to do it like this. Didn't
question it further.

>> +#define PARENT1 (1u<<16) /* used instead of SEEN */
>> +#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
>
> Naive question: why do we use these object flags instead of the ones
> mentioned?

We set these bits in `struct object::flags`, because other systems might
be using other bits for their internal workings we want to avoid
colliding bit ranges. That's why users define the bits they use in
object.h, to have a general overview over who is using what and which
systems might get in trouble with eachother.

Bit 16 and 17 seems to be safe to use. We could have named these defines
SEEN and BOUNDARY, but in revision.h they have different bit positions,
so we name that PARENT1 and PARENT2, similar to what these bits are
named in other files.

>> +
>>  struct last_modified_entry {
>>  	struct hashmap_entry hashent;
>>  	struct object_id oid;
>>  	struct bloom_key key;
>> +	size_t diff_idx;
>>  	const char path[FLEX_ARRAY];
>>  };
>>  
>> @@ -37,13 +43,35 @@ static int last_modified_entry_hashcmp(const void *unused UNUSED,
>>  	return strcmp(ent1->path, path ? path : ent2->path);
>>  }
>>  
>> +/*
>> + * Hold a bitmap for each commit we're working with. Each bit represents a path
>> + * in `lm->all_paths`. Active bit means the path still needs to be dealt with.
>> + */
>> +define_commit_slab(commit_bitmaps, struct bitmap *);
>
> Why do we need a path bitmap for each commit? My understanding is that
> we check commits in a certain order as dictated by the priority queue.
> As soon as the commit that last-modified a path has been identified,
> wouldn't we always want the remaining commits processed to only check
> the outstanding paths?

Because we want to pass paths to parents that are treesame. Imagine a
tree with:

    bar-a.txt
    bar-b.txt
    baz-a.txt
    foo-a.txt
    foo-a.txt

When we're looking at a commit and it has the 'active_c' bitmap
`11111`. This commit has two parents, and we see bar-a.txt and bar-b.txt
are treesame on parent-0, we pass bitmap `11000` to that parent. If
foo-a.txt and foo-b.txt are treesame on the parent-1, we pass bitmap
`00011` to that parent. This leaves bitmap `00100` behind on the current
commit, and we associate baz-a.txt with that commit.

So a bit for a path would only be passed on to a single parent (or
none).

>>  struct last_modified {
>>  	struct hashmap paths;
>>  	struct rev_info rev;
>>  	bool recursive;
>>  	bool show_trees;
>> +
>> +	const char **all_paths;
>> +	size_t all_paths_nr;
>
> It is not immediately obvious to me why we have both `paths` and
> `all_paths`. From my understanding, `all_paths` is defining the path
> order for the bitmap. If this is the case, maybe it would be worth
> explaining in a comment?

Yeah, I'm not extremely happy about storing the information twice, but
I kept it for two reasons:

 * The hashmap is filled by populate_paths_from_revs() and it grows with
   every call of add_path_from_diff(). Afterwards we malloc() the
   all_paths buffer to the correct size. Re-allocing all_paths on every
   call of add_path_from_diff() would be clunky.

 * Reverse lookups: When we have a path, we can lookup the index in
   all_paths using path_idx(), which uses the hashmap to locate the
   hashmap entry (which has the `diff_idx`).

> [snip]
>>  static int last_modified_run(struct last_modified *lm)
>>  {
>> +	int max_count, queue_popped = 0;
>> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>> +	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
>> +	struct commit_list *list;
>>  	struct last_modified_callback_data data = { .lm = lm };
>>  
>>  	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>>  	lm->rev.diffopt.format_callback = last_modified_diff;
>>  	lm->rev.diffopt.format_callback_data = &data;
>> +	lm->rev.no_walk = 1;
>>  
>>  	prepare_revision_walk(&lm->rev);
>>  
>> -	while (hashmap_get_size(&lm->paths)) {
>> -		data.commit = get_revision(&lm->rev);
>> -		if (!data.commit)
>> -			BUG("paths remaining beyond boundary in last-modified");
>> +	max_count = lm->rev.max_count;
>> +
>> +	init_commit_bitmaps(&lm->commit_bitmaps);
>> +	lm->scratch = bitmap_word_alloc(lm->all_paths_nr);
>
> It looks like we initialize and release both `commit_bitmaps` and
> `scratch` here in `last_modified_run()`. Any reason we wouldn't want to
> move this to `last_modified_{init,release}()`?

For lm->commit_bitmaps, at the `cleanup:` label we call bitmap_free() on
`active_c`, but `lm->commit_bitmaps` still has a pointer to those
bitmaps. It feels a bit cleaner to me to not exit this function with
having any in `lm` pointing to invalid data.
(Also note: we don't call deep_clear_commit_bitmaps() because
the bitmaps are already freed, the commit_slab of bitmaps isn't)

`lm->scratch` we could move to `last_modified_{init,release}()` but I
decided to keep the bitmaps together.

>> +
>> +	/*
>> +	 * lm->rev.commits holds the set of boundary commits for our walk.
>
> Naive question: would it be more correct ...

Don't use "more correct", I've been told :-P

> ... to say that `rev.commits` is
> the list of starting commits? Boundary commits sounds like commits on
> the boundary of what we consider interesting/uninteresting which, from
> my understanding, is not the case here.

Why aren't these boundaries? Users can pass uninteresting commits to
this command with `--not aaaaaa` or `aaaaaa..bbbbbb`. So in this context
boundaries are used on both ends, and `queue` and `not_queue` are used
to store those.


>> +	 *
>> +	 * Loop through each such commit, and place it in the appropriate queue.
>> +	 */
>> +	for (list = lm->rev.commits; list; list = list->next) {
>> +		struct commit *c = list->item;
>> +
>> +		if (c->object.flags & BOTTOM) {
>> +			prio_queue_put(&not_queue, c);
>
> Ok so commits with the BOTTOM flag are at the boundary of the
> "interesting" commit graph. Thus they are not included in the search and
> added to the "not_queue".
>
>> +			c->object.flags |= PARENT2;
>
> What is the meaning behind the name PARENT2 in this context? From my
> understanding we are using this flag to denote a commit we are not
> interested in.

Yes, that's correct. It's used to avoid us adding it to the not_queue
more than once.

>
>> +		} else if (!(c->object.flags & PARENT1)) {
>
> Same question about PARENT1. It seems to be used to just denote commits
> that we have already encountered. The names confuse me a bit though.

Naming isn't great, but see my earlier comment.

>> +			/*
>> +			 * If the commit is a starting point (and hasn't been
>> +			 * seen yet), then initialize the set of interesting
>> +			 * paths, too.
>> +			 */
>> +			struct bitmap *active;
>> +
>> +			prio_queue_put(&queue, c);
>> +			c->object.flags |= PARENT1;
>
> We queue the commit and mark it as seen. Makes sense.
>
>> -		if (data.commit->object.flags & BOUNDARY) {
>> +			active = get_bitmap(lm, c);
>> +			for (size_t i = 0; i < lm->all_paths_nr; i++)
>> +				bitmap_set(active, i);
>
> Here we set up the path bitmap for the commit. At this point, all paths
> are still "active" and thus set accordingly. I'm still not entirely sure
> though if we really need a path bitmap per commit.

After my explanation above, let me know if you still have questions. I
must admit it took me a while to have it click in my brain too.

>> +		}
>> +	}
>> +
>> +	while (queue.nr) {
>> +		int parent_i;
>> +		struct commit_list *p;
>> +		struct commit *c = prio_queue_get(&queue);
>> +		struct bitmap *active_c = get_bitmap(lm, c);
>> +
>> +		if ((0 <= max_count && max_count < ++queue_popped) ||
>> +		    (c->object.flags & PARENT2)) {
>> +			/*
>> +			 * Either a boundary commit, or we have already seen too
>> +			 * many others. Either way, stop here.
>> +			 */
>> +			c->object.flags |= PARENT2 | BOUNDARY;
>> +			data.commit = c;
>>  			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
>> -				      &data.commit->object.oid, "",
>> -				      &lm->rev.diffopt);
>> +				      &c->object.oid,
>> +				      "", &lm->rev.diffopt);
>>  			diff_flush(&lm->rev.diffopt);
>> +			goto cleanup;
>> +		}
>>  
>> -			break;
>> +		/*
>> +		 * Otherwise, make sure that 'c' isn't reachable from anything
>> +		 * in the '--not' queue.
>> +		 */
>> +		repo_parse_commit(lm->rev.repo, c);
>> +
>> +		while (not_queue.nr) {
>> +			struct commit_list *np;
>> +			struct commit *n = prio_queue_get(&not_queue);
>> +
>> +			repo_parse_commit(lm->rev.repo, n);
>> +
>> +			for (np = n->parents; np; np = np->next) {
>> +				if (!(np->item->object.flags & PARENT2)) {
>> +					prio_queue_put(&not_queue, np->item);
>> +					np->item->object.flags |= PARENT2;
>> +				}
>> +			}
>> +
>> +			if (commit_graph_generation(n) < commit_graph_generation(c))
>> +				break;
>
> If the generation number of 'c' is higher than 'n' we know 'c' cannot be
> an ancestor of 'n' and thus we continue on. Makes sense.

<3

>>  		}
>>  
>> -		if (!maybe_changed_path(lm, data.commit))
>> -			continue;
>> +		/*
>> +		 * Look at each parent and pass on each path that's TREESAME
>> +		 * with that parent. Stop early when no active paths remain.
>> +		 */
>> +		for (p = c->parents, parent_i = 0; p; p = p->next, parent_i++) {
>> +			process_parent(lm, &queue,
>> +				       c, active_c,
>> +				       p->item, parent_i);
>> +
>> +			if (bitmap_is_empty(active_c))
>> +				break;
>> +		}
>>  
>> -		log_tree_commit(&lm->rev, data.commit);
>> +		/*
>> +		 * Paths that remain active, or not TREESAME with any parent,
>> +		 * were changed by 'c'.
>> +		 */
>> +		if (!bitmap_is_empty(active_c))  {
>> +			data.commit = c;
>> +			for (size_t i = 0; i < lm->all_paths_nr; i++) {
>> +				if (bitmap_get(active_c, i))
>> +					mark_path(lm->all_paths[i], NULL, &data);
>> +			}
>> +		}
>> +
>> +cleanup:
>> +		bitmap_free(active_c);
>>  	}
>>  
>> +	if (hashmap_get_size(&lm->paths))
>> +		BUG("paths remaining beyond boundary in last-modified");
>> +
>> +	clear_prio_queue(&not_queue);
>> +	clear_prio_queue(&queue);
>> +	clear_commit_bitmaps(&lm->commit_bitmaps);
>> +	bitmap_free(lm->scratch);
>> +
>>  	return 0;
>>  }
> [snip]
>
> I've taken an initial look a this patch and have mostly questions so
> far. Just FYI, after applying this patch locally, the last-modified
> tests seem to be failing. The command seems to be segfaulting, but I
> haven't looked into it further.

Yeah, sorry about that. Taylor also noticed. In my final review I revived
some code I had removed at some point. I brought it back, but didn't do
a final test afterward. He provided a path to fix it[2] (which I also
had in my code at some point, but reverted).

[2]: https://lore.kernel.org/git/aPGB%2FFJtjDmyNLvG@nand.local/

-- 
Cheers,
Toon
