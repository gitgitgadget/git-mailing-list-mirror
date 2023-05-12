Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D8CC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjELVZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjELVZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:25:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E0AEA
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:24:58 -0700 (PDT)
Received: (qmail 14444 invoked by uid 109); 12 May 2023 21:24:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 May 2023 21:24:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26128 invoked by uid 111); 12 May 2023 21:24:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 17:24:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 17:24:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <20230512212456.GA2495860@coredump.intra.peff.net>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 07:20:37PM -0400, Taylor Blau wrote:

> This patch introduces a new multi-valued configuration option,
> `pack.recentObjectsHook` as a means to mark certain objects as recent,
> regardless of their age.
> 
> Depending on whether or not we are generating a cruft pack, this allows
> the caller to do one of two things:
> 
>   - If generating a cruft pack, the caller is able to retain additional
>     objects via the cruft pack, even if they would have otherwise been
>     pruned due to their age.
> 
>   - If not generating a cruft pack, the caller is likewise able to
>     retain additional objects as loose.

I think this description suffers a bit from being adapted from the
original patch which was targeting cruft packs. It's not clear to me
what "the caller" means here. And really, I think this is getting into
the details before giving an overview and motivation.

I'd expect something the rationale to be something like:

  1. Git considers the recent-ness of objects when deciding how to handle
     unreachable objects (discarding those that are too old, and keeping
     new-enough ones)

  2. you might want to consider more objects as "recent" because you know
     something Git doesn't (that certain objects are more interesting
     than others; specific examples may help here)

  3. so this patch gives you a way to override the recent-ness check for
     certain objects

And then get into the details of the implementation, why other solutions
don't work, etc.

> There is currently no option to be able to keep around certain objects
> that have otherwise aged out of the grace period. The only way to retain
> those objects is:
> 
>   - to point a reference at them, which may be undesirable or
>     infeasible,
> 
>   - to track them via the reflog, which may be undesirable since the
>     reflog's lifetime is limited to that of the reference it's tracking
>     (and callers may want to keep those unreachable objects around for
>     longer)
> 
>   - to extend the grace period, which may keep around other objects that
>     the caller *does* want to discard,
> 
>   - or, to force the caller to construct the pack of objects they want
>     to keep themselves, and then mark the pack as kept by adding a
>     ".keep" file.

One option I don't see here is: update the mtime on the objects you want
to salvage.

Why would we want this patch instead of just having the caller update
the mtimes of objects (or in a cruft-pack world, call a command that
rewrites the .mtimes file with new values)?

I can think of some possible arguments against it (you might want to
retain the old mtimes, or you might find it a hassle to have to
continually update them before gc kills them). But I think the commit
message should probably make those arguments.

Likewise, I think you'd want to argue why the ".keep" approach isn't as
good (and I guess it is "having extra packs is awkward especially as you
roll forward your cruft packs").

> This patch introduces a new configuration, `pack.recentObjectsHook`
> which allows the caller to specify a program (or set of programs) whose
> output is treated as a set of objects to treat as recent, regardless of
> their true age.

I was going to complain about putting this in the "pack" section,
because I thought by touching reachable.c, we'd also affect git-prune.
But I don't think we do, because it does its own direct mtime check on
the loose objects.

But I'm not sure that's the right behavior.

It feels like even before your patch, this is a huge gap in our
object-retention strategy.  During repacking, we try to avoid dropping
objects which are reachable from recent-but-unreachable things we're
keeping (since otherwise it effectively corrupts those recent objects,
making them less valuable to keep). But git-prune will happily drop them
anyway!

And I think the same thing would apply to your hook. If the hook says
"object XYZ is precious even if unreachable, keep it", then git-prune
ignoring that seems like it would be a source of errors.

I suspect both could be fixed by having git-prune trigger the same
add_unseen_recent_objects_to_traversal() call either as part of
the perform_reachability_traversal() walk, or maybe in its own walk (I
think maybe it has to be its own because the second walk should avoid
complaining about missing objects).

> We then add those as tips to another reachability traversal (along with
> any recent objects, if pruning), marking every object along the way
> (either adding it to the cruft pack, or writing it out as a loose
> object).

I didn't understand this "if pruning" comment. If we are not pruning at
all, wouldn't we skip the extra traversal entirely, since we know we are
saving everything?

> A potential alternative here is to introduce a new mode to alter the
> contents of the reachable pack instead of the cruft one. One could
> imagine a new option to `pack-objects`, say `--extra-reachable-tips`
> that does the same thing as above, adding the visited set of objects
> along the traversal to the pack.
> 
> But this has the unfortunate side-effect of altering the reachability
> closure of that pack. If parts of the unreachable object graph mentioned
> by one or more of the "extra reachable tips" programs is not closed,
> then the resulting pack won't be either. This makes it impossible in the
> general case to write out reachability bitmaps for that pack, since
> closure is a requirement there.

Makes sense.

> +	while (strbuf_getline(&buf, out) != EOF) {
> +		struct object_id oid;
> +		const char *rest;
> +
> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> +			goto done;
> +		}
> +
> +		oidset_insert(set, &oid);
> +	}
> +
> +	ret = finish_command(&cmd);
> +
> +done:

I mentioned the "goto done" issue in another email.

>  static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
>  			 struct recent_data *data)
>  {
> -	return mtime > data->timestamp;
> +	if (mtime > data->timestamp)
> +		return 1;
> +
> +	if (!data->extra_recent_oids_loaded)
> +		load_pack_recent_objects(data);
> +	return oidset_contains(&data->extra_recent_oids, oid);
>  }

OK, so this is where we override the timestamp check. Makes sense.

> @@ -126,8 +198,14 @@ static int want_recent_object(struct recent_data *data,
>  			      const struct object_id *oid)
>  {
>  	if (data->ignore_in_core_kept_packs &&
> -	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
> +	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS)) {
> +		if (!data->extra_recent_oids_loaded)
> +			load_pack_recent_objects(data);
> +		if (oidset_contains(&data->extra_recent_oids, oid))
> +			return 1;
> +
>  		return 0;
> +	}
>  	return 1;
>  }

This hunk I'm less sure about. The purpose of this function is that the
caller has told us about some packs which are "special", and we avoid
adding their objects to the traversal.

This kicks in for cruft packs, when the git-repack caller says "I just
made pack xyz.pack; do not bother saving anything in it to the cruft
pack, since xyz.pack is here to stay". So if a hook says "you should
keep object X", why would we want to override that check? It is already
a reachable object that has been packed into xyz.pack, so we know there
is no point in even considering its recency.

> @@ -199,16 +277,24 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
>  	data.cb = cb;
>  	data.ignore_in_core_kept_packs = ignore_in_core_kept_packs;
>  
> +	oidset_init(&data.extra_recent_oids, 0);
> +	data.extra_recent_oids_loaded = 0;
> +
>  	r = for_each_loose_object(add_recent_loose, &data,
>  				  FOR_EACH_OBJECT_LOCAL_ONLY);
>  	if (r)
> -		return r;
> +		goto done;
>  
>  	flags = FOR_EACH_OBJECT_LOCAL_ONLY | FOR_EACH_OBJECT_PACK_ORDER;
>  	if (ignore_in_core_kept_packs)
>  		flags |= FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
>  
> -	return for_each_packed_object(add_recent_packed, &data, flags);
> +	r = for_each_packed_object(add_recent_packed, &data, flags);
> +
> +done:
> +	oidset_clear(&data.extra_recent_oids);
> +
> +	return r;
>  }

This handles the cleanup that I was too lazy to do in my earlier patch.
Good. :)

> --- a/t/t5329-pack-objects-cruft.sh
> +++ b/t/t5329-pack-objects-cruft.sh
> @@ -739,4 +739,175 @@ test_expect_success 'cruft objects are freshend via loose' '
>  	)
>  '
>  
> +test_expect_success 'additional cruft tips may be specified via pack.extraCruftTips' '

This title (and others below) seems out of date. :)

> diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
> index ebb267855f..d2eea6e754 100755
> --- a/t/t7701-repack-unpack-unreachable.sh
> +++ b/t/t7701-repack-unpack-unreachable.sh
> @@ -113,6 +113,28 @@ test_expect_success 'do not bother loosening old objects' '
>  	test_must_fail git cat-file -p $obj2
>  '
>  
> +test_expect_success 'extra recent tips are kept regardless of age' '
> +	obj1=$(echo one | git hash-object -w --stdin) &&
> +	obj2=$(echo two | git hash-object -w --stdin) &&
> +	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
> +	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
> +	git prune-packed &&
> +
> +	git cat-file -p $obj1 &&
> +	git cat-file -p $obj2 &&
> +
> +	write_script extra-tips <<-EOF &&
> +	echo $obj2
> +	EOF
> +	git config pack.recentObjectsHook ./extra-tips &&
> +
> +	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
> +	git repack -A -d --unpack-unreachable=1.hour.ago &&
> +
> +	git cat-file -p $obj1 &&
> +	git cat-file -p $obj2
> +'

And this is the new test in this iteration covering the "repack -A"
case.

It is checking that $obj2, which our hook mentions, is saved. It also
checks that $obj1 is saved because it is still recent. But there are two
other possibly interesting cases:

  - an object that is too old and is _not_ saved. It seems useful to
    confirm that the new patch does not simply break the ability to drop
    objects. ;)

  - an object that is reachable from $obj2 is also saved. From a
    white-box perspective this is less interesting, because we should
    already test elsewhere that this works for recent objects, and we
    know the new feature is implemented by faking recency. But it might
    be worth it for completeness, and because it's easy to do (making
    $obj2 a tag pointing to a blob should work).

-Peff
