Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A365EC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 23:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbjIGXnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIGXm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 19:42:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBA1BD2
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 16:42:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A214330EE;
        Thu,  7 Sep 2023 19:42:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=QeDISF9TvuL9VT9QGf6Jgukyh3CuRbwpwoegHW
        MGIiM=; b=TgBC/9NOnmQ9FaNGZ+E9OzsyM1tlDhg0MdhB+wioFcUWVsbEkPGZEf
        FMOpenDP7xizQI36pEAYbBX/yWu9diKJqCmMf2RfqLNozdgP0oWCd4WZvM+QpwJb
        q/Q5vbuK7blhJ0afssZst8S6xHTR1Dy9U3WYm2hXE5mv0FEnemVjo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 125B3330ED;
        Thu,  7 Sep 2023 19:42:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B04E330EC;
        Thu,  7 Sep 2023 19:42:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] builtin/repack.c: implement support for
 `--cruft-max-size`
In-Reply-To: <7e4e42e1aacf2111f04a933c0725a8c81769f8d6.1694123506.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 7 Sep 2023 17:52:04 -0400")
References: <cover.1694123506.git.me@ttaylorr.com>
        <7e4e42e1aacf2111f04a933c0725a8c81769f8d6.1694123506.git.me@ttaylorr.com>
Date:   Thu, 07 Sep 2023 16:42:48 -0700
Message-ID: <xmqqtts5wnwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4128B78C-4DD8-11EE-AB01-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This all works, but can be costly from an I/O-perspective when a
> repository has either (a) many unreachable objects, (b) prunes objects
> relatively infrequently/never, or (c) both.

I can certainly understand (a).  If we need to write a lot of
objects into the craft pack, among which many of them are already in
the previous generation of craft pack, we would be copying bits from
the old to the new craft pack, and having to do so for many objects
would involve expensive I/O.  But not (b).  Whether we prune objects
infrequently or we do so very often, as long as the number and
on-disk size of objects that has to go into craft packs are the
same, wouldn't the cost of I/O pretty much the same?  IOW, (b) does
not have much to do with how repacking is costly I/O wise, except
that it is a contributing factor to make (a) worse, which is the
real cause of the I/O cost.

> At the time, we decided against implementing more robust support for
> multiple cruft packs. This patch implements that support which we were
> lacking.
>
> Introduce a new option `--cruft-max-size` which allows repositories to
> accumulate cruft packs up to a given size, after which point a new
> generation of cruft packs can accumulate until it reaches the maximum
> size, and so on. To generate a new cruft pack, the process works like
> so:
>
>   - Sort a list of any existing cruft packs in ascending order of pack
>     size.
>
>   - Starting from the beginning of the list, group cruft packs together
>     while the accumulated size is smaller than the maximum specified
>     pack size.
>
>   - Combine the objects in these cruft packs together into a new cruft
>     pack, along with any other unreachable objects which have since
>     entered the repository.

The above three steps guarantees that, before the amount of the
accumulated cruft objects reaches the "max-size", we would be moving
bits from old to new cruft packs and incurring the same I/O cost as
in the current system.  I suspect (I haven't read what the new code
does) the untold fourth point is what improves the new system over
the current one, which would be "Do not touch the existing cruft
pack(s) that are already large enough, and send enumerated cruft
objects that do not appear in these existing cruft pack(s) to a new
cruft pack.  Do not rewrite these existing cruft pack(s), even if
there are some cruft objects that has aged enough, because rewriting
these huge cruft packs only to expunge a few objects from them is
costly in I/O" or something?  In any case, I do not think with only
the above three ...

> This limits the I/O churn up to a quadratic function of the value
> specified by the `--cruft-max-size` option, instead of behaving
> quadratically in the number of total unreachable objects.

... I do not quite see how you would limit the I/O churn.

> When pruning unreachable objects, we bypass the new paths which combine

"paths" here refers to...?  code paths, I guess?

> +gc.cruftMaxSize::
> +	Limit the size of new cruft packs when repacking. When
> +	specified in addition to `--cruft-max-size`, the command line
> +	option takes priority. See the `--cruft-max-size` option of
> +	linkgit:git-repack[1].

Hmph.

I am reasonably sure that I will mix the name up and call it
gc.maxCruftSize in my configuration file and scratch my head
wondering why it is not working.

> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 90806fd26a..8a90d684a7 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -59,6 +59,13 @@ be performed as well.
>  	cruft pack instead of storing them as loose objects. `--cruft`
>  	is on by default.
>  
> +--cruft-max-size=<n>::
> +	When packing unreachable objects into a cruft pack, limit the
> +	size of new cruft packs to be at most `<n>`. Overrides any
> +	value specified via the `gc.cruftMaxSize` configuration. See
> +	the `--cruft-max-size` option of linkgit:git-repack[1] for
> +	more.

At least this side giving --max-cruft-size=<n> (which I think is a
lot more natural word order) would cause parse-options to give an
error, so it won't risk mistakes go silently unnoticed.

> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 4017157949..23fd203d79 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -74,6 +74,15 @@ to the new separate pack will be written.
>  	immediately instead of waiting for the next `git gc` invocation.
>  	Only useful with `--cruft -d`.
>  
> +--cruft-max-size=<n>::
> +	Repack cruft objects into packs as large as `<n>` before
> +	creating new packs. As long as there are enough cruft packs
> +	smaller than `<n>`, repacking will cause a new cruft pack to
> +	be created containing objects from any combined cruft packs,
> +	along with any new unreachable objects. Cruft packs larger
> +	than `<n>` will not be modified. Only useful with `--cruft
> +	-d`.

Here, the missing fourth point I pointed out above is mentioned,
which is good.

Describe the unit for <n> (I am assuming that is counted in bytes,
honoring the human-friendly suffix, like 100M).

There may be some "interesting" behaviour around the size boundary,
no?  If you pack too many objects, your resulting size may slightly
bust <n> and you will get a complaint, but by fixing that "bug", you
will always stop short of filling the whole <n> bytes in the
produced packfiles, and they will not be excempt from rewriting
(becuase they are not "larger than <n>"), which defeats the point of
this patch.

Describe that <n> is a threshold that we stop soon after passing to
explicitly allow us to go beyond it would solve the above problem, I
would presume.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 1f53b66c7b..b6640abd35 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -52,6 +52,7 @@ static const char * const builtin_gc_usage[] = {
>  static int pack_refs = 1;
>  static int prune_reflogs = 1;
>  static int cruft_packs = 1;
> +static char *cruft_max_size;

I do not think this type is a good idea.

>  static int aggressive_depth = 50;
>  static int aggressive_window = 250;
>  static int gc_auto_threshold = 6700;
> @@ -163,6 +164,7 @@ static void gc_config(void)
>  	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_get_bool("gc.cruftpacks", &cruft_packs);
> +	git_config_get_string("gc.cruftmaxsize", &cruft_max_size);
>  	git_config_get_expiry("gc.pruneexpire", &prune_expire);
>  	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
>  	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
> @@ -347,6 +349,9 @@ static void add_repack_all_option(struct string_list *keep_pack)
>  		strvec_push(&repack, "--cruft");
>  		if (prune_expire)
>  			strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);
> +		if (cruft_max_size)
> +			strvec_pushf(&repack, "--cruft-max-size=%s",
> +				     cruft_max_size);

Even if you are going to pass it intact, as an opaque token, to
another program.  Rather, you should parse and make sure it is a
valid non-negative byte count before calling out the other program
(passing the original string down, after parsing it only for error
checking the value, and having "repack" do its own parsing, is
perfectly fine).

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 44cb261371..56e7f5f43d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -26,6 +26,9 @@
>  #define LOOSEN_UNREACHABLE 2
>  #define PACK_CRUFT 4
>  
> +#define DELETE_PACK ((void*)(uintptr_t)1)
> +#define RETAIN_PACK ((uintptr_t)(1<<1))

Shouldn't these look more similar?  That is

	((void *)(uintptr_t)(1<<0))
	((void *)(uintptr_t)(1<<1))

> +		if (pack_is_retained(item)) {
> +			item->util = NULL;
> +		} else if (!string_list_has_string(names, sha1)) {

Without the pack_marked_for_deletion(item) macro Patrick suggested,
the logic around here looks very uneven.

> +			/*
> +			 * Mark this pack for deletion, which ensures
> +			 * that this pack won't be included in a MIDX
> +			 * (if `--write-midx` was given) and that we
> +			 * will actually delete this pack (if `-d` was
> +			 * given).
> +			 */
> +			item->util = DELETE_PACK;
> +		}
>  	}
>  }
>  
> +static void retain_cruft_pack(struct existing_packs *existing,
> +			      struct packed_git *cruft)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +
> +	strbuf_addstr(&buf, pack_basename(cruft));
> +	strbuf_strip_suffix(&buf, ".pack");
> +
> +	item = string_list_lookup(&existing->cruft_packs, buf.buf);
> +	if (!item)
> +		BUG("could not find cruft pack '%s'", pack_basename(cruft));
> +
> +	item->util = (void*)RETAIN_PACK;
> +	strbuf_release(&buf);
> +}
> +
>  static void mark_packs_for_deletion(struct existing_packs *existing,
>  				    struct string_list *names)
>  
> @@ -217,6 +247,8 @@ static void collect_pack_filenames(struct existing_packs *existing,
>  	}
>  
>  	string_list_sort(&existing->kept_packs);
> +	string_list_sort(&existing->non_kept_packs);
> +	string_list_sort(&existing->cruft_packs);
>  	strbuf_release(&buf);
>  }
>  
> @@ -799,6 +831,72 @@ static void remove_redundant_bitmaps(struct string_list *include,
>  	strbuf_release(&path);
>  }
>  
> +static int existing_cruft_pack_cmp(const void *va, const void *vb)
> +{
> +	struct packed_git *a = *(struct packed_git **)va;
> +	struct packed_git *b = *(struct packed_git **)vb;
> +
> +	if (a->pack_size < b->pack_size)
> +		return -1;
> +	if (a->pack_size > b->pack_size)
> +		return 1;
> +	return 0;
> +}
> +
> +static void collapse_small_cruft_packs(FILE *in, unsigned long max_size,
> +				       struct existing_packs *existing)
> +{
> +	struct packed_git **existing_cruft, *p;
> +	struct strbuf buf = STRBUF_INIT;
> +	unsigned long total_size = 0;
> +	size_t existing_cruft_nr = 0;
> +	size_t i;
> +
> +	ALLOC_ARRAY(existing_cruft, existing->cruft_packs.nr);
> +
> +	for (p = get_all_packs(the_repository); p; p = p->next) {
> +		if (!(p->is_cruft && p->pack_local))
> +			continue;
> +
> +		strbuf_reset(&buf);
> +		strbuf_addstr(&buf, pack_basename(p));
> +		strbuf_strip_suffix(&buf, ".pack");
> +
> +		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
> +			continue;
> +
> +		if (existing_cruft_nr >= existing->cruft_packs.nr)
> +			BUG("too many cruft packs (found %"PRIuMAX", but knew "
> +			    "of %"PRIuMAX")",

Is that a BUG() that somehow miscounted the packs, or can it be a
runtime error that may happen when a "git push" is pushing new
objects into the repository, creating a new pack we did not know
about?  Something like the latter should not be marked a BUG(), but 

> +			    (uintmax_t)existing_cruft_nr + 1,
> +			    (uintmax_t)existing->cruft_packs.nr);
> +		existing_cruft[existing_cruft_nr++] = p;
> +	}
> +
> +	QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp);

We use the simplest "from smaller ones to larger ones, combine one
by one together until the result gets large enough", which would not
give us the best packing, but it is OK because it is not our goal to
solve knapsack problem here, I presume?

> +	for (i = 0; i < existing_cruft_nr; i++) {
> +		off_t proposed;
> +
> +		p = existing_cruft[i];
> +		proposed = st_add(total_size, p->pack_size);
> +
> +		if (proposed <= max_size) {
> +			total_size = proposed;
> +			fprintf(in, "-%s\n", pack_basename(p));
> +		} else {
> +			retain_cruft_pack(existing, p);
> +			fprintf(in, "%s\n", pack_basename(p));
> +		}
> +	}

This is exactly what I talked about the possibly funny behaviour
around the boundary earlier, but it may be even worse.  This time,
we may decide that a pack with size <n-epsilon> is to be retained,
only because the pack that came next in the existing list happened
to be larger than epsilon, but next time around, it may not be the
case (i.e. our pack may be smaller than epsilon, the next one in the
current round may be larger than epsilon, but before we repack the
next time, a new pack that is slightly smaller than epsilon that is
larger than our pack may have been created---now our pack will be
combined with it), so the algorithm to choose which ones are kept
does not depend on the pack itself alone but also depends on its
surroundings.

