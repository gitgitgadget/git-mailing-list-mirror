Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC326E71F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404418; cv=none; b=Gfr+N4Q4FqYOwkxWUBWy0HQAMxHjWGXpZnyZ0vC5afzDbKQzbr2nUTaXwg5NGkL3C6TPVua38eodCpypa6BhW5OVU8+ok2ijkJiRn7tNLuj1l5+Y5+bzgsKr2k+k0ucGjY+4ARk4AVRfwHVIfD+0FuLdAgf2ArPxdpRRqPFmkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404418; c=relaxed/simple;
	bh=yGAnsorkfbUnHXokEGes1x3e0I3SusKTFFnWzPWPM90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBEVNnENOaSxevttqfbRKe1Y0e/L/QJd6mhkDsR5+8Ycfp64KENxiafiF5Gjr388PCjn34xEMVt4wEYexyC9aIXAPgHE6cow7OgFB6wZPLyFzo5wzzcyQ+U3uQOajt7M8izZFff4n7++lzXqlzQCD2ZaH9DuPp4LUZThk1fA0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ysqpSjNR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ysqpSjNR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768404411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYOiKmukzNzhW8iknVv3m04UJVd0343HkPaKXOj+fno=;
	b=ysqpSjNRXtnCMMUnePBrQnGttO4auvPlJNPP7IYkrawwylCoJHSXaAVA/w5O18wNTlFaPx
	6bFA4yoMoiqm3wbCKDjLiqCBhC+7iQ+NBpwNTM2EcMAoz2nezrRYg06trIQgImswFiVpHK
	gQHvQOHBWRwoxhveayk0S1UMWPmL/xo=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/5] builtin/repack: handle promisor packs with
 geometric repacking
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-5-c4660573437e@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
 <20260105-pks-geometric-repack-with-promisors-v1-5-c4660573437e@pks.im>
Date: Wed, 14 Jan 2026 16:26:42 +0100
Message-ID: <87ms2gjjv1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When performing a fetch with an object filter, we mark the resulting
> packfile as a promisor pack. An object part of such a pack may miss any
> of its referenced objects, and Git knows to handle this case by fetching
> any such missing objects from the promisor remote.
>
> The "promisor" property needs to be retained going forward. So every
> time we pack a promisor object, the resulting pack must be marked as a
> promisor pack. git-repack(1) does this already: when a repository has a
> promisor remote, it knows to pass "--exclude-promisor-objects" to the
> git-pack-objects(1) child process. Promisor packs are written separately
> when doing an all-into-one repack via `repack_promisor_objects()`.
>
> But we don't support promisor objects when doing a geometric repack yet.
> Promisor packs do not get any special treatment there, as we simply
> merge promisor and non-promisor packs. The resulting pack is not even
> marked as a promisor pack, which essentially corrupts the repository.
>
> This corruption couldn't happen in the real world though: we pass both
> "--exclude-promisor-objects" and "--stdin-packs" to git-pack-objects(1)
> if a repository has a promisor remote, but as those options are mutually
> exclusive we always end up dying. And while we made those flags
> compatible with one another in a preceding commit, we still end up dying
> in case git-pack-objects(1) is asked to repack a promisor pack.
>
> There's multiple ways to fix this:
>
>   - We can exclude promisor packs from the geometric progression
>     altogether. This would have the consequence that we never repack
>     promisor packs at all. But in a partial clone it is quite likely
>     that the user generates a bunch of promisor packs over time, as
>     every backfill fetch would create another one. So this doesn't
>     really feel like a sensible option.
>
>   - We can adapt git-pack-objects(1) to support repacking promisor packs
>     and include them in the normal geometric progression. But this would
>     mean that the set of promisor objects expands over time as the packs
>     are merged with normal packs.
>
>   - We can use a separate geometric progression to repack promisor
>     packs.
>
> The first two options both have significant downsides, so they aren't
> really feasible. But the third option fixes both of these downsides: we
> make sure that promisor packs get merged, and at the same time we never
> expand the set of promisor objects beyond the set of objects that are
> already marked as promisor objects.
>
> Implement this strategy so that geometric repacking works in partial
> clones.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/repack.c            |  3 +++
>  repack-geometry.c           | 28 ++++++++++++++++-----
>  repack-promisor.c           | 28 +++++++++++++++++++++
>  repack.h                    | 10 ++++++++
>  t/t7703-repack-geometric.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 124 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index d9012141f6..f6bb04bef7 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -332,6 +332,9 @@ int cmd_repack(int argc,
>  		    !(pack_everything & PACK_CRUFT))
>  			strvec_push(&cmd.args, "--pack-loose-unreachable");
>  	} else if (geometry.split_factor) {
> +		pack_geometry_repack_promisors(repo, &po_args, &geometry,
> +					       &names, packtmp);
> +
>  		if (midx_must_contain_cruft)
>  			strvec_push(&cmd.args, "--stdin-packs");
>  		else
> diff --git a/repack-geometry.c b/repack-geometry.c
> index 0daf545a81..7cebd0cb45 100644
> --- a/repack-geometry.c
> +++ b/repack-geometry.c
> @@ -66,15 +66,25 @@ void pack_geometry_init(struct pack_geometry *geometry,
>  		if (p->is_cruft)
>  			continue;
>  
> -		ALLOC_GROW(geometry->pack,
> -			   geometry->pack_nr + 1,
> -			   geometry->pack_alloc);
> -
> -		geometry->pack[geometry->pack_nr] = p;
> -		geometry->pack_nr++;
> +		if (p->pack_promisor) {
> +			ALLOC_GROW(geometry->promisor_pack,
> +				   geometry->promisor_pack_nr + 1,
> +				   geometry->promisor_pack_alloc);
> +
> +			geometry->promisor_pack[geometry->promisor_pack_nr] = p;
> +			geometry->promisor_pack_nr++;
> +		} else {
> +			ALLOC_GROW(geometry->pack,
> +				   geometry->pack_nr + 1,
> +				   geometry->pack_alloc);
> +
> +			geometry->pack[geometry->pack_nr] = p;
> +			geometry->pack_nr++;
> +		}
>  	}
>  
>  	QSORT(geometry->pack, geometry->pack_nr, pack_geometry_cmp);
> +	QSORT(geometry->promisor_pack, geometry->promisor_pack_nr, pack_geometry_cmp);
>  	strbuf_release(&buf);
>  }
>  
> @@ -160,6 +170,9 @@ void pack_geometry_split(struct pack_geometry *geometry)
>  {
>  	geometry->split = compute_pack_geometry_split(geometry->pack, geometry->pack_nr,
>  						      geometry->split_factor);
> +	geometry->promisor_split = compute_pack_geometry_split(geometry->promisor_pack,
> +							       geometry->promisor_pack_nr,
> +							       geometry->split_factor);
>  }
>  
>  struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
> @@ -234,6 +247,8 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
>  {
>  	remove_redundant_packs(geometry->pack, geometry->split,
>  			       names, existing, packdir);
> +	remove_redundant_packs(geometry->promisor_pack, geometry->promisor_split,
> +			       names, existing, packdir);
>  }
>  
>  void pack_geometry_release(struct pack_geometry *geometry)
> @@ -242,4 +257,5 @@ void pack_geometry_release(struct pack_geometry *geometry)
>  		return;
>  
>  	free(geometry->pack);
> +	free(geometry->promisor_pack);
>  }
> diff --git a/repack-promisor.c b/repack-promisor.c
> index 125038d92e..73af57bce3 100644
> --- a/repack-promisor.c
> +++ b/repack-promisor.c
> @@ -109,3 +109,31 @@ void repack_promisor_objects(struct repository *repo,
>  
>  	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
>  }
> +
> +void pack_geometry_repack_promisors(struct repository *repo,
> +				    const struct pack_objects_args *args,
> +				    const struct pack_geometry *geometry,
> +				    struct string_list *names,
> +				    const char *packtmp)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	FILE *in;
> +
> +	if (!geometry->promisor_split)
> +		return;
> +
> +	prepare_pack_objects(&cmd, args, packtmp);
> +	strvec_push(&cmd.args, "--stdin-packs");
> +	cmd.in = -1;
> +	if (start_command(&cmd))
> +		die(_("could not start pack-objects to repack promisor packs"));
> +
> +	in = xfdopen(cmd.in, "w");
> +	for (size_t i = 0; i < geometry->promisor_split; i++)
> +		fprintf(in, "%s\n", pack_basename(geometry->promisor_pack[i]));
> +	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++)
> +		fprintf(in, "^%s\n", pack_basename(geometry->promisor_pack[i]));
 
Okay, so in the situation of the added integration test: PROMISOR_A,
PROMISOR_B, and PROMISOR_C are below the split, and PROMISOR_D and
PROMISOR_E above. So using a caret, the latter two marked to be excluded
by git-pack-objects. Makes sense.

> +	fclose(in);
> +
> +	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
> +}
> diff --git a/repack.h b/repack.h
> index 3a688a12ee..bc9f2e1a5d 100644
> --- a/repack.h
> +++ b/repack.h
> @@ -103,9 +103,19 @@ struct pack_geometry {
>  	uint32_t pack_nr, pack_alloc;
>  	uint32_t split;
>  
> +	struct packed_git **promisor_pack;
> +	uint32_t promisor_pack_nr, promisor_pack_alloc;
> +	uint32_t promisor_split;
> +
>  	int split_factor;
>  };
>  
> +void pack_geometry_repack_promisors(struct repository *repo,
> +				    const struct pack_objects_args *args,
> +				    const struct pack_geometry *geometry,
> +				    struct string_list *names,
> +				    const char *packtmp);
> +
>  void pack_geometry_init(struct pack_geometry *geometry,
>  			struct existing_packs *existing,
>  			const struct pack_objects_args *args);
> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 98806cdb6f..04d5d8fc33 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -480,4 +480,65 @@ test_expect_success '--geometric -l disables writing bitmaps with non-local pack
>  	test_path_is_file member/.git/objects/pack/multi-pack-index-*.bitmap
>  '
>  
> +write_packfile () {
> +	NR="$1"
> +	PREFIX="$2"
> +
> +	printf "blob\ndata <<EOB\n$PREFIX %s\nEOB\n" $(test_seq $NR) |

This test_seq() is fancy trickery if you ask me, but it seems to work
very well. In case anyone is wondering when 'NR=3' and
'PREFIX=normal-a', you'll get:

    blob
    data <<EOB
    normal-a 1
    EOB
    blob
    data <<EOB
    normal-a 2
    EOB
    blob
    data <<EOB
    normal-a 3
    EOB

I didn't realize doing `printf %s` will print the format string for each
line passed in.

> +		git fast-import &&
> +	git pack-objects --pack-loose-unreachable .git/objects/pack/pack &&
> +	git prune-packed
> +}
> +
> +write_promisor_packfile () {
> +	PACKFILE=$(write_packfile "$@") &&
> +	touch .git/objects/pack/pack-$PACKFILE.promisor &&

Okay, understood. As mentioned in Documentation/git-repack.adoc, packs
having a .promisor file, will force them to be packed separately.

> +	echo "$PACKFILE"
> +}
> +
> +test_expect_success 'geometric repack works with promisor packs' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config set maintenance.auto false &&
> +		git remote add promisor garbage &&
> +		git config set remote.promisor.promisor true &&
> +
> +		# Packs A and B need to be merged.
> +		NORMAL_A=$(write_packfile 2 normal-a) &&
> +		NORMAL_B=$(write_packfile 2 normal-b) &&
> +		NORMAL_C=$(write_packfile 14 normal-c) &&

Okay, so pack C is more than twice as large as A and B combined, so
that's why that should be merged.

> +
> +		# Packs A, B and C need to be merged.
> +		PROMISOR_A=$(write_promisor_packfile 1 promisor-a) &&
> +		PROMISOR_B=$(write_promisor_packfile 3 promisor-b) &&
> +		PROMISOR_C=$(write_promisor_packfile 3 promisor-c) &&
> +		PROMISOR_D=$(write_promisor_packfile 20 promisor-d) &&
> +		PROMISOR_E=$(write_promisor_packfile 40 promisor-e) &&

Similar here, D and E are a geometric sequence, but all the previous
should be merged.

> +
> +		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects-expect &&
> +
> +		ls .git/objects/pack/*.pack >packs-before &&
> +		test_line_count = 8 packs-before &&
> +		git repack --geometric=2 -d &&
> +		ls .git/objects/pack/*.pack >packs-after &&
> +		test_line_count = 5 packs-after &&
> +		test_grep ! "$NORMAL_A" packs-after &&
> +		test_grep ! "$NORMAL_B" packs-after &&
> +		test_grep "$NORMAL_C" packs-after &&
> +		test_grep ! "$PROMISOR_A" packs-after &&
> +		test_grep ! "$PROMISOR_B" packs-after &&
> +		test_grep ! "$PROMISOR_C" packs-after &&
> +		test_grep "$PROMISOR_D" packs-after &&
> +		test_grep "$PROMISOR_E" packs-after &&
> +
> +		ls .git/objects/pack/*.promisor >promisors &&
> +		test_line_count = 3 promisors &&
> +
> +		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects-actual &&
> +		test_cmp objects-expect objects-actual
> +	)
> +'
> +
>  test_done
>
> -- 
> 2.52.0.508.g883dcfc63e.dirty
>
>

I like the solution you have chosen. It makes sense, and so does the
code, or at least to the best of my knowledge. Included test coverage
helps understanding the solution and demonstrate it works.

-- 
Cheers,
Toon
