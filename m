Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D87332EA2
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702870; cv=none; b=GE8i3oVz9U0SneEn04liP6B0ALTM4ouI/sHh86fQVqs3aEHMw7u4VVftAZjITKpvwSclmZsT+ulHfoCnFBU8OPg41nIoIRe+spCjQANu/JRokxmUOHssATPVknwbDNou6VKYlsAxv4LeZy7W+YOu0azYYtGC7Gr9r2c/mKY7WsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702870; c=relaxed/simple;
	bh=nAQiEpsOTp96srD1ttaqy6feD3of162oNzAqrIGcsXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DnW099k3KWf/NTDZXX9Golfo1tkR70orUCbDdKTEeMzVV20zZwkdox5kA9ZIGYcOC0dGJQQgXu5lXqB7K7iItDpsq/7g2xRTSGlmnLmVCy1ac0QpZhpTwcwDUlNb+Mqw8H7R+01NS50ML1RZj7h7rQoXZOfEqLh3dJEwsUfEC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=F32m1UjV; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="F32m1UjV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1760702862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVVOplVcIPohkDnIfQ2Ks12Y/jvY2Jxd7PA06hbAbtY=;
	b=F32m1UjVEYorU38Ec2Jv+nSiLJpPNeAP1kB14vGABvCMthFN3fP3+AX05spD7rNxpgVMJJ
	vyF6wp1UOGpozabvdvjpVflcre8slaQAWwHFWsLxFiEBB5SjgRJfYYFCIHBbIb5iE1wvmf
	JpBnsyJdp9I6e2nWix9/y010zlTkRLc=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
In-Reply-To: <aPGB/FJtjDmyNLvG@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local>
Date: Fri, 17 Oct 2025 14:07:18 +0200
Message-ID: <87jz0tu3yh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 16, 2025 at 10:39:25AM +0200, Toon Claes wrote:
>> [...]
>>
>> To avoid computing many first-parent diffs, add another trick on top of
>> this and check if all paths active in 'c' are DEFINITELY NOT in c's
>> Bloom filter. Since the commit-graph only stores first-parent diffs in
>> the Bloom filters, we can only apply this trick to first-parent diffs.
>
> OK, up to this point this is the same as the commit message that I wrote
> with Stolee back in 2020.
>
>> Comparing the performance of this new algorithm shows about a 2.6x
>> improvement on git.git:
>>
>>     Benchmark 1: master
>>       Time (mean =C2=B1 =CF=83):      3.077 s =C2=B1  0.055 s    [User: =
3.017 s, System: 0.051 s]
>>       Range (min =E2=80=A6 max):    2.947 s =E2=80=A6  3.127 s    10 runs
>>
>>     Benchmark 2: HEAD
>>       Time (mean =C2=B1 =CF=83):      1.181 s =C2=B1  0.010 s    [User: =
1.139 s, System: 0.038 s]
>>       Range (min =E2=80=A6 max):    1.169 s =E2=80=A6  1.194 s    10 runs
>>
>>     Summary
>>       HEAD ran
>>         2.60 =C2=B1 0.05 times faster than master
>>
>> But when comparing a more extreme example of
>> `git last-modified -- COPYING t`, the difference is a lot bigger:
>>
>>     Benchmark 1: master
>>       Time (mean =C2=B1 =CF=83):      4.372 s =C2=B1  0.057 s    [User: =
4.286 s, System: 0.062 s]
>>       Range (min =E2=80=A6 max):    4.308 s =E2=80=A6  4.509 s    10 runs
>>
>>     Benchmark 2: HEAD
>>       Time (mean =C2=B1 =CF=83):     826.3 ms =C2=B1  22.3 ms    [User: =
784.1 ms, System: 39.2 ms]
>>       Range (min =E2=80=A6 max):   810.6 ms =E2=80=A6 881.2 ms    10 runs
>>
>>     Summary
>>       HEAD ran
>>         5.29 =C2=B1 0.16 times faster than master
>
> These benchmarks are different than the ones that I provided, which is
> good, since we should be measuring modern Git, not dragging forward
> stale benchmarks ;-).
>
> I imagine that you are just doing a straight last-modified run here in
> both instances. In the original patch, I timed this both with and
> without changed-path Bloom filters, which helped illustrate their impact
> on the changes here.
>
> I'd suggest including those benchmarks as well, and potentially running
> them on linux.git, or another comparably larger open-source repository.
> git.git is large enough to show some interesting behavior, but I always
> have found it useful to compare the results against a larger repository
> as well.

Sure.

>> As an added benefit, this implementation gives more correct results. For
>> example implementation in 'master' gives:
>>
>>     $ git log --max-count=3D1 --format=3D%H -- pkt-line.h
>>     15df15fe07ef66b51302bb77e393f3c5502629de
>>
>>     $ git last-modified -- pkt-line.h
>>     15df15fe07ef66b51302bb77e393f3c5502629de	pkt-line.h
>>
>>     $ git last-modified | grep pkt-line.h
>>     5b49c1af03e600c286f63d9d9c9fb01403230b9f	pkt-line.h
>>
>> With the changes in this patch the results of git-last-modified(1)
>> always match those of `git log --max-count=3D1`.
>>
>> One thing to note though, the results might be outputted in a different
>> order than before. This is not considerd to be an issue because nowhere
>> is documented the order is guaranteed.
>>
>> Based-on-patches-by: Taylor Blau <me@ttaylorr.com>
>
> Stolee and I wrote these patches together many years ago, so he should
> be credited here as well. Since this patch appears to be substantially
> based on the original work, I think it is appropriate to include my
> S-o-b once the patch is ready.

I'm very grateful you (GitHub) have written and shared these patches, so
I'm happy to give proper attribution.

>> ---
>> This series revives those changes. I did more thorough deep dive through
>> the code and the algorithm and got the code working a lot faster. The
>> benchmark results can be found in the commit message.
>>
>> Some changes compared to GitHub's version include:
>>
>>  * Use of `struct bitmap` from "ewah/ewok.h", instead of self-defined
>>    `struct commit_active_paths`.
>>
>>  * Removed shortcut code that handled the case when commit and parent
>>    are fully treesame, and instead always checked 'active_c' whether the
>>    next parent is worth looking at.
>>
>>  * Modified comments and commit message to make the algorithm more
>>    clear (at least to me).
>>
>>  * Mentioned the use of PARENT1 and PARENT2 in object.h.
>>
>>  * Removed the use of any global variables.
>>
>>  * Less conditions are checked in mark_path() because the hashmap of
>>    'paths' is considered the single-source of truth.
>>
>>  * pass_to_parent() doesn't pass on when the path isn't in the 'paths'
>>    hashmap no more.
>
> Thanks for clearly showing what the changes on top are. When I applied
> this locally and ran it, it pretty quickly segfaulted for me:
>
>     expecting success of 8020.3 'last-modified non-recursive':
>       check_last_modified <<-\EOF
>       3 a
>       1 file
>       EOF
>
>     + check_last_modified
>     + local indir=3D
>     + test 0 !=3D 0
>     + cat
>     + git last-modified
>     Segmentation fault
>     error: last command exited with $?=3D139
>     not ok 3 - last-modified non-recursive
>     #
>     #		check_last_modified <<-\EOF
>     #		3 a
>     #		1 file
>     #		EOF
>     #
>     1..3
>
> Looking through the backtrace, it looks like someone is calling
> mark_path() with a NULL oid, like so:
>
>     (gdb) bt
>     #0  __memcmp_evex_movbe ()
>         at ../sysdeps/x86_64/multiarch/memcmp-evex-movbe.S:132
>     #1  0x00005555555f2c32 in oideq (oid1=3D0x0, oid2=3D0x555555a5eeb0)
>         at ./hash.h:408
>     #2  0x00005555555f3523 in mark_path (path=3D0x555555a5eee8 "a", oid=
=3D0x0,
>         data=3D0x7fffffffd650) at builtin/last-modified.c:179
>
> , which makes sense, since at the end of the main loop we call
> mark_path() on all remaining active paths to indicate that they were
> modified by whatever commit we just popped off the queue.
>
> Something like this on top (which matches the original patch that I sent
> from GitHub's fork) fixes the tests:
>
> --- 8< ---
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 40e520ba18..c8f66633a7 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -176,7 +176,7 @@ static void mark_path(const char *path, const struct =
object_id *oid,
>  	 * Is it arriving at a version of interest, or is it from a side branch
>  	 * which did not contribute to the final state?
>  	 */
> -	if (!oideq(oid, &ent->oid))
> +	if (oid && !oideq(oid, &ent->oid))
>  		return;
>
>  	last_modified_emit(data->lm, path, data->commit);
> --- >8 ---

Sorry for this oopsie. Right before I sent this patch, I had a version
that removed the oideq() condition. In the final diff I noticed and I
decided to undo that, but didn't check my tests again. Thanks for the
patch, because I know I had that at one point as well.

But this makes me wonder, is there even any value in keeping `oid` on
`struct last_modified_entry`? I'll have a deeper look into this.

>> +/* Remember to update object flag allocation in object.h */
>> +#define PARENT1 (1u<<16) /* used instead of SEEN */
>> +#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
>> +
>>  struct last_modified_entry {
>>  	struct hashmap_entry hashent;
>>  	struct object_id oid;
>>  	struct bloom_key key;
>> +	size_t diff_idx;
>>  	const char path[FLEX_ARRAY];
>>  };
>>
>> @@ -37,13 +43,35 @@ static int last_modified_entry_hashcmp(const void *u=
nused UNUSED,
>>  	return strcmp(ent1->path, path ? path : ent2->path);
>>  }
>>
>> +/*
>> + * Hold a bitmap for each commit we're working with. Each bit represent=
s a path
>> + * in `lm->all_paths`. Active bit means the path still needs to be deal=
t with.
>> + */
>> +define_commit_slab(commit_bitmaps, struct bitmap *);
>> +
>
> Nice, I am glad to see that we are using a bitmap here rather than the
> hacky 'char *' that we had originally written. I seem to remember that
> there was a tiny slow-down when using bitmaps, but can't find the
> discussion anymore. (It wasn't in the internal PR that I originally
> opened, and I no longer can read messages that far back in history.)
>
> It might be worth benchmarking here to see if using a 'char *' is
> faster. Of course, that's 8x worse in terms of memory usage, but not a
> huge deal given both the magnitude and typical number of directory
> elements (you'd need 1024^2 entries in a single tree to occupy even a
> single MiB of heap).

Okay, I can give it a try.

> Regardless of how you handle the above, I think that the commit slab
> name here is a little generic. I guess it's OK since this is only
> visible within this compilation unit, but perhaps something like
> "active_paths_bitmap" would be more descriptive.

I struggled a lot naming this thing, so I'm open to suggestions.

> Likewise, I wonder if we should have elemtype here be just 'struct
> bitmap'. Unfortunately I don't think the EWAH code has a function like:
>
>     void bitmap_init(struct bitmap *);
>
> and only has ones that allocate for us. So we may consider adding one,
> or creating a dummy bitmap and copying its contents, or otherwise.
>
>>  struct last_modified {
>>  	struct hashmap paths;
>>  	struct rev_info rev;
>>  	bool recursive;
>>  	bool show_trees;
>> +
>> +	const char **all_paths;
>> +	size_t all_paths_nr;
>
> I wonder if all_paths should be a strvec here? I think that this code
> was all written when the type was called argv_array (hilariously, that
> change took place towards the end of July, 2020, and the --go-faster
> code where this patch came from was written just a couple of weeks
> earlier.)

Ahha, that might be a good idea. This might allow us to get rid of the
hashmap, which stops us from storing the paths twice. Not sure what the
impact on the performance would be, because the hashmap now is valuable
for path_idx() lookups.

>> @@ -196,7 +226,36 @@ static void last_modified_diff(struct diff_queue_st=
ruct *q,
>>  	}
>>  }
>>
>> -static bool maybe_changed_path(struct last_modified *lm, struct commit =
*origin)
>> +static size_t path_idx(struct last_modified *lm, char *path)
>> +{
>> +	struct last_modified_entry *ent;
>> +	ent =3D hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
>> +					  struct last_modified_entry, hashent);
>> +
>> +	return ent ? ent->diff_idx : -1;
>> +}
>> +
>> +static void pass_to_parent(struct last_modified *lm,
>> +			   struct bitmap *c,
>> +			   struct bitmap *p,
>> +			   size_t pos)
>> +{
>> +	struct last_modified_entry *ent;
>> +	struct hashmap_iter iter;
>> +
>> +	bitmap_unset(c, pos);
>> +
>> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
>> +		if (ent->diff_idx =3D=3D pos) {
>> +			bitmap_set(p, pos);
>> +			break;
>> +		}
>> +	}
>> +}
>
> This one I'm not quite following. The original implementation does
> something like:
>
>     c->active[i] =3D 0;
>     c->nr--;
>     p->active[i] =3D 1;
>     p->nr++;
>
> , where 'i' is an index into the all_paths array. It looks like you are
> effectively doing the first part of that with the bitmap_unset() call,
> but I'm confused why you're iterating over paths here.
>
> The caller in process_parents() is iterating over all entries that are
> treesame to the parent, bit by bit. So I think you can just bitmap_set()
> in the parent directly here, but let me know if I am missing something.

It is an attempt from my side to optimize things further. I was thinking
a path could have been associated by another commit already. But now
you've brought this up, I don't think this no more.

A bit can only be set in two places:

* Initially when a commit is added from lm->rev.commits. We can only
  have one commit in there, because we count `num_interesting` in
  populate_paths_from_revs() and abort if it's more than 1.

* Here in pass_to_parent(). A commit only passes a bit to one parent.

So I'll remove the extra guard in the next version.

>> @@ -220,42 +282,197 @@ static bool maybe_changed_path(struct last_modifi=
ed *lm, struct commit *origin)
>>  	return false;
>>  }
>>
>> +static void process_parent(struct last_modified *lm,
>> +			   struct prio_queue *queue,
>> +			   struct commit *c, struct bitmap *active_c,
>> +			   struct commit *parent, int parent_i)
>> +{
>> +	size_t i;
>> +	struct bitmap *active_p;
>> +
>> +	repo_parse_commit(lm->rev.repo, parent);
>> +	active_p =3D get_bitmap(lm, parent);
>> +
>> +	/*
>> +	 * The first time entering this function for this commit (i.e. first p=
arent)
>> +	 * see if Bloom filters will tell us it's worth to do the diff.
>> +	 */
>> +	if (parent_i || maybe_changed_path(lm, c, active_c)) {
>> +		diff_tree_oid(&parent->object.oid,
>> +			      &c->object.oid, "", &lm->rev.diffopt);
>> +		diffcore_std(&lm->rev.diffopt);
>> +	}
>> +
>> +	/*
>> +	 * Otherwise, test each path for TREESAME-ness against the parent. If
>
> This "otherwise" is referencing a piece of the patch that doesn't appear
> to be here directly, which is how we handle the special case of having
> nothing in the diff queue, meaning we are treesame at the root.

True, I shall drop the "otherwise" and rephrase further if needed.

> In the GitHub version of this patch, we pass all active paths to the
> parent, assign the PARENT1 flag if it doesn't already have it, and put
> it in the queue as well.
>
> In your version, we'd skip past the next for-loop, and do the same
> pass-to-parent dance below, along with inserting the parent into the
> prio queue.

This is the "shortcut" I'm mentioning in my cover letter. In my testing
it seemed it didn't provide any performance gains to keep it. I consider
less code better code, so I left it out.

> So I think that this is all functionally equivalent, but I had to work
> through a little bit of the details here, mostly since I haven't looked
> at or thought about this code in many years ;-).
>
>>  static int last_modified_run(struct last_modified *lm)
>>  {
>> +	int max_count, queue_popped =3D 0;
>> +	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date =
};
>> +	struct prio_queue not_queue =3D { compare_commits_by_gen_then_commit_d=
ate };
>> +	struct commit_list *list;
>>  	struct last_modified_callback_data data =3D { .lm =3D lm };
>>
>>  	lm->rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
>>  	lm->rev.diffopt.format_callback =3D last_modified_diff;
>>  	lm->rev.diffopt.format_callback_data =3D &data;
>> +	lm->rev.no_walk =3D 1;
>
> This one is new relative to the original patch. Why set no_walk here?

This comes from
https://github.com/ttaylorr/git/commit/e8ea49705873d28f64b815bd00d14bdf6d48=
ca4d

Well, it basically squashes various commits together. There are various
commits doing different things here. I don't think it's valuable for
anyone to see the full history of the iterations at GitHub, that's why I
squashed it in.

Would you consider it better to not set `no_walk`?

>>  	prepare_revision_walk(&lm->rev);
>>
>> -	while (hashmap_get_size(&lm->paths)) {
>> -		data.commit =3D get_revision(&lm->rev);
>> -		if (!data.commit)
>> -			BUG("paths remaining beyond boundary in last-modified");
>> +	max_count =3D lm->rev.max_count;
>> +
>> +	init_commit_bitmaps(&lm->commit_bitmaps);
>> +	lm->scratch =3D bitmap_word_alloc(lm->all_paths_nr);
>> +
>> +	/*
>> +	 * lm->rev.commits holds the set of boundary commits for our walk.
>> +	 *
>> +	 * Loop through each such commit, and place it in the appropriate queu=
e.
>> +	 */
>> +	for (list =3D lm->rev.commits; list; list =3D list->next) {
>
> Hmm. In the original patch, we look at rev.pending, not rev.commits. The
> rest of the patch looks good to me and looks like a faithful
> representation of the original patch from GitHub's fork. Thanks for
> working on this and making the new last-modified builtin faster ;-).

Euh, interesting. I'll look into it.

Thanks for the support!

--=20
Cheers,
Toon
