Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC478C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DE564F03
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhBXXUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 18:20:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63565 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhBXXUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 18:20:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4431E9765F;
        Wed, 24 Feb 2021 18:19:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0wOtnGPdkXFNgjKmmpDnZq/Mxv0=; b=l6wSTY
        eknA0PagPG2hTFg6QVGBz4CO3YejaCKYOpwZQH22mFX8b/E3yFjrKo/jogfVQcS7
        fwdJUcakQ1iGxtnKzKoLwerUtFsf6bY0cVTcoPbljkoMMFLQ6Pe1znOAckNtRmdO
        BMJdLHSXdFzY6Rm4rcNo4oLcE8npSFsvQB7Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DA5o36ZhzvQ5K8QNONE/Z85lTBP3qcpj
        HhvsLiOiEKxXAlYdcLuWU682kbCjNDrgQQ9RgcKZJnUgvrhPIKINmXawvegdZbCF
        4eMi/ZJOHstw/QgL32aHlOKINs7rYia1oI74er8X2rPUV4+82V58FLFp/mTkkhPR
        0JGdfb2+cLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AF1C9765E;
        Wed, 24 Feb 2021 18:19:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7EC29765B;
        Wed, 24 Feb 2021 18:19:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v4 8/8] builtin/repack.c: add '--geometric' option
References: <cover.1611098616.git.me@ttaylorr.com>
        <cover.1614047097.git.me@ttaylorr.com>
        <51f57d5da23244ebde27ad6c14cbf4b63da3317d.1614047097.git.me@ttaylorr.com>
Date:   Wed, 24 Feb 2021 15:19:30 -0800
In-Reply-To: <51f57d5da23244ebde27ad6c14cbf4b63da3317d.1614047097.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 22 Feb 2021 21:25:27 -0500")
Message-ID: <xmqqv9ahxddp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF414D48-76F6-11EB-8197-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Concretely, say that a repository has 'n' packfiles, labeled P1, P2,
> ..., up to Pn. Each packfile has an object count equal to 'objects(Pn)'.
> With a geometric factor of 'r', it should be that:
>
>   objects(Pi) > r*objects(P(i-1))
>
> for all i in [1, n], where the packs are sorted by
>
>   objects(P1) <= objects(P2) <= ... <= objects(Pn).
>
> Since finding a true optimal repacking is NP-hard, we approximate it
> along two directions:
>
>   1. We assume that there is a cutoff of packs _before starting the
>      repack_ where everything to the right of that cut-off already forms
>      a geometric progression (or no cutoff exists and everything must be
>      repacked).

When you order existing packs like how you explained the next
"direction" below, do we assume loose ones would sit before
(i.e. "newer and smaller" than) all of the packs?

>   2. We assume that everything smaller than the cutoff count must be
>      repacked. This forms our base assumption, but it can also cause
>      even the "heavy" packs to get repacked, for e.g., if we have 6
>      packs containing the following number of objects:
>
>        1, 1, 1, 2, 4, 32
>
>      then we would place the cutoff between '1, 1' and '1, 2, 4, 32',
>      rolling up the first two packs into a pack with 2 objects. That
>      breaks our progression and leaves us:
>
>        2, 1, 2, 4, 32
>          ^
>
>      (where the '^' indicates the position of our split). To restore a
>      progression, we move the split forward (towards larger packs)
>      joining each pack into our new pack until a geometric progression
>      is restored. Here, that looks like:
>
>        2, 1, 2, 4, 32  ~>  3, 2, 4, 32  ~>  5, 4, 32  ~> ... ~> 9, 32
>          ^                   ^                ^                   ^

This explanation is very intuitive and easy to understand (I assume
we aren't actually repacking 1+1 into 2 and then 2+1 into 3 and then
choosing to repack 3+2 to create 5, but we scan before doing any
repacking and decide to repack 2+1+2+4 into a single 9).

What is not so clear is how this picture changes depending on the
value of 'r'.

> ... Another wrinkle
> is that we assume that loose, indexed, and reflog'd objects are
> insignificant, and lump them into any new pack that we create.

In the example of 2 above, these are treated as insignificant
compared to the first '1' in the 1+1+1+2+4+32, so the choice of
repacked packs are made by computing 1+1+1+2+4 and noticing that is
where we should stop, but we pack these insignificant ones together
with these repacked packs into the new pack that is supposed to
contain "9" objects?

> This can
> lead to non-idempotent results.

Let me try to follow aloud to see if I got this right.

If we start from 1+1+1+2+4+32+... (similarly to the example given to
explain 2 above, but with more larger packs---but the assumption
here is that everything larger than 32 is already in good
progression), depending on how many loose objects we have, the
result of packing 1+1+1+2+4+loose might not necessarily be 9 but 100
(collecting too many loose objects), and the set of packs would be
32+... (from before the "repack -g") plus a 100-object pack, not
9+32+... as the above explanation for 2 suggested.  Starting from
that state, re-running "repack -g" again would then have to repack
the packs existed before the first repack (i.e. 32+...) into one.
In other words, the second "git repack -g" in back-to-back "git
repack -g && git repack -g" may necessarily be a no-op.

Is that what you meant by non-idempotent?

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 01440de2d5..bcf280b10d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -297,6 +297,124 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  #define ALL_INTO_ONE 1
>  #define LOOSEN_UNREACHABLE 2
>  
> +struct pack_geometry {
> +	struct packed_git **pack;
> +	uint32_t pack_nr, pack_alloc;
> +	uint32_t split;
> +};
> +
> +static uint32_t geometry_pack_weight(struct packed_git *p)
> +{
> +	if (open_pack_index(p))
> +		die(_("cannot open index for %s"), p->pack_name);
> +	return p->num_objects;
> +}
> +
> +static int geometry_cmp(const void *va, const void *vb)
> +{
> +	uint32_t aw = geometry_pack_weight(*(struct packed_git **)va),
> +		 bw = geometry_pack_weight(*(struct packed_git **)vb);
> +
> +	if (aw < bw)
> +		return -1;
> +	if (aw > bw)
> +		return 1;
> +	return 0;
> +}
> +
> +static void init_pack_geometry(struct pack_geometry **geometry_p)
> +{
> +	struct packed_git *p;
> +	struct pack_geometry *geometry;
> +
> +	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
> +	geometry = *geometry_p;
> +
> +	for (p = get_all_packs(the_repository); p; p = p->next) {
> +		if (!pack_kept_objects && p->pack_keep)
> +			continue;
> +
> +		ALLOC_GROW(geometry->pack,
> +			   geometry->pack_nr + 1,
> +			   geometry->pack_alloc);
> +
> +		geometry->pack[geometry->pack_nr] = p;
> +		geometry->pack_nr++;
> +	}
> +
> +	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
> +}

After calling this helper, we get geometry->pack[] that is sorted by
the number of objects in each pack, packs with fewer objects sort
before the ones with more objects.  OK.

> +static void split_pack_geometry(struct pack_geometry *geometry, int factor)
> +{
> +	uint32_t i;
> +	uint32_t split;
> +	off_t total_size = 0;
> +
> +	if (geometry->pack_nr <= 1) {
> +		geometry->split = geometry->pack_nr;
> +		return;
> +	}

When there is a single pack (or no pack), we place the split to 1
(let's keep reading with the need to find out what split means in
mind; it is not yet clear if it points at the pack that will be part
of the kept set, or at the pack that is the last one among the
repacked set, at this point in the code).

> +	split = geometry->pack_nr - 1;
> +
> +	/*
> +	 * First, count the number of packs (in descending order of size) which
> +	 * already form a geometric progression.
> +	 */
> +	for (i = geometry->pack_nr - 1; i > 0; i--) {
> +		struct packed_git *ours = geometry->pack[i];
> +		struct packed_git *prev = geometry->pack[i - 1];
> +		if (geometry_pack_weight(ours) >= factor * geometry_pack_weight(prev))
> +			split--;
> +		else
> +			break;
> +	}

Instead of rolling up from smaller ones like explained in the log
message, we scan from the larger end and see where the existing
progression is broken.  When the loop breaks in the middle, the pack
at position 'i-1' (prev) is too big.

Why do we need to initialize 'split' before the loop and decrement
it?  Wouldn't it be equivalent to assign 'i' after the loop breaks
to 'split'?

In any case, after the loop breaks, the packs starting at position
'i+1' (one after ours when the loop broke) thru to the end of the
geometry->pack[] array are in good progression.  We have 'i' in
'split' at this point, so ...

> +	if (split) {
> +		/*
> +		 * Move the split one to the right, since the top element in the
> +		 * last-compared pair can't be in the progression. Only do this
> +		 * when we split in the middle of the array (otherwise if we got
> +		 * to the end, then the split is in the right place).
> +		 */
> +		split++;
> +	}

... we increment it.  It means geometry->pack[split] is small enough
relative to geometry->pack[split+1] and so on thru to the end of the
array.

What if split==0 when we exited the loop?  That would mean that the
everything in the array was in good progression, which is in line
with the "in the middle" case.  Either way, the pack at 'split' and
later are in good progression.

> +	/*
> +	 * Then, anything to the left of 'split' must be in a new pack. But,
> +	 * creating that new pack may cause packs in the heavy half to no longer
> +	 * form a geometric progression.
> +	 *
> +	 * Compute an expected size of the new pack, and then determine how many
> +	 * packs in the heavy half need to be joined into it (if any) to restore
> +	 * the geometric progression.
> +	 */
> +	for (i = 0; i < split; i++)
> +		total_size += geometry_pack_weight(geometry->pack[i]);

We guestimate the number of objects in the rolled-up pack to be
created.  Some objects may appear in multiple packs, but the number
of them ought to be insignificant.  OK.

> +	for (i = split; i < geometry->pack_nr; i++) {
> +		struct packed_git *ours = geometry->pack[i];
> +		if (geometry_pack_weight(ours) < factor * total_size) {

If the pack at the bottom end of the range we previously thought to
keep turns out to be too small, we'd also roll that one in, by
shifting the split point to the right.  And of course we update the
expected size of the new pack.  OK.

> +			split++;
> +			total_size += geometry_pack_weight(ours);
> +		} else
> +			break;
> +	}
> +
> +	geometry->split = split;

The code makes me wonder if we can compute all of the above in a
single pass, but that is purely an intellectual curiosity.  The
logic in the code is crystal clear (the "what if everything was
already in a good progression" case was the only part that made me
stop and think about the correctness of the logic) and the
implementation looks good, except for a few small nits:

 - why initialize 'split' so early before the first loop, which I
   already mentioned.

 - we know many numbers are in uint32_t because that is how
   packfiles limit their contents, but is it safe to perform the
   multiplication with factor and comparison in that type?

>  int cmd_repack(int argc, const char **argv, const char *prefix)
>  {
>  	struct child_process cmd = CHILD_PROCESS_INIT;
> @@ -304,6 +422,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct string_list names = STRING_LIST_INIT_DUP;
>  	struct string_list rollback = STRING_LIST_INIT_NODUP;
>  	struct string_list existing_packs = STRING_LIST_INIT_DUP;
> +	struct pack_geometry *geometry = NULL;
>  	struct strbuf line = STRBUF_INIT;
>  	int i, ext, ret;
>  	FILE *out;
> @@ -316,6 +435,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
>  	int no_update_server_info = 0;
>  	struct pack_objects_args po_args = {NULL};
> +	int geometric_factor = 0;
>  
>  	struct option builtin_repack_options[] = {
>  		OPT_BIT('a', NULL, &pack_everything,
> @@ -356,6 +476,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				N_("repack objects in packs marked with .keep")),
>  		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
>  				N_("do not repack this pack")),
> +		OPT_INTEGER('g', "geometric", &geometric_factor,
> +			    N_("find a geometric progression with factor <N>")),
>  		OPT_END()
>  	};
>  
> @@ -382,6 +504,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
>  		die(_(incremental_bitmap_conflict_error));
>  
> +	if (geometric_factor) {
> +		if (pack_everything)
> +			die(_("--geometric is incompatible with -A, -a"));
> +		init_pack_geometry(&geometry);
> +		split_pack_geometry(geometry, geometric_factor);
> +	}
> +
>  	packdir = mkpathdup("%s/pack", get_object_directory());
>  	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
>  
> @@ -396,9 +525,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		strvec_pushf(&cmd.args, "--keep-pack=%s",
>  			     keep_pack_list.items[i].string);
>  	strvec_push(&cmd.args, "--non-empty");
> -	strvec_push(&cmd.args, "--all");
> -	strvec_push(&cmd.args, "--reflog");
> -	strvec_push(&cmd.args, "--indexed-objects");
> +	if (!geometry) {
> +		/*
> +		 * 'git pack-objects' will up all objects loose or packed

"git pack-objects --stdin-packs" will?
What verb is missing in "will VERB up all objects"?

> +		 * (either rolling them up or leaving them alone), so don't pass
> +		 * these options.
> +		 *
> +		 * The implementation of 'git pack-objects --stdin-packs'
> +		 * makes them redundant (and the two are incompatible).

I am not sure if that is true.

More importantly, if you read this comment after you are done with
the series and no longer feel that geometric repacking is the most
important thing in the world, you'd realize that an important piece
of information is missing to help readers.  It talks about what
"geometric" code does (i.e. uses --stdin-packs hence no need to pass
these options) in a block that is for !geometric.

	We need to grab all reachable objects, including those that
	are reachable from reflogs and the index.

	When repacking into a geometric progression of packs,
	however, we ask 'git pack-objects --stdin-packs', and it is
	not about packing objects based on reachability but about
	repacking all the objects in specified packs and loose ones
	(indeed, --stdin-packs is incompatible with these options).

or something?  I suspect that --stdin-packs does not make --all and
others "redundant".  The operation is about creating a new pack out
of the objects contained in these packs, regardless of the objects'
reachability from the usual "refs, index and reflogs" anchor points,
no?

> +		 */
> +		strvec_push(&cmd.args, "--all");
> +		strvec_push(&cmd.args, "--reflog");
> +		strvec_push(&cmd.args, "--indexed-objects");
> +	}
>  	if (has_promisor_remote())
>  		strvec_push(&cmd.args, "--exclude-promisor-objects");
>  	if (write_bitmaps > 0)
> @@ -429,17 +568,37 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
>  			}
>  		}
> +	} else if (geometry) {
> +		strvec_push(&cmd.args, "--stdin-packs");
> +		strvec_push(&cmd.args, "--unpacked");
>  	} else {
>  		strvec_push(&cmd.args, "--unpacked");
>  		strvec_push(&cmd.args, "--incremental");
>  	}
>  
> -	cmd.no_stdin = 1;
> +	if (geometry)
> +		cmd.in = -1;
> +	else
> +		cmd.no_stdin = 1;

It is a bit sad that we need to do this before start_command() in
that the code structure does not make it clear why two modes have
different handling of the standard input stream, but I do not think
of anything better, so I'll let it pass.

>  	ret = start_command(&cmd);
>  	if (ret)
>  		return ret;
>  
> +	if (geometry) {
> +		FILE *in = xfdopen(cmd.in, "w");
> +		/*
> +		 * The resulting pack should contain all objects in packs that
> +		 * are going to be rolled up, but exclude objects in packs which
> +		 * are being left alone.
> +		 */
> +		for (i = 0; i < geometry->split; i++)
> +			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
> +		for (i = geometry->split; i < geometry->pack_nr; i++)
> +			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
> +		fclose(in);
> +	}
> +
>  	out = xfdopen(cmd.out, "r");
>  	while (strbuf_getline_lf(&line, out) != EOF) {
>  		if (line.len != the_hash_algo->hexsz)
> @@ -507,6 +666,25 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  			if (!string_list_has_string(&names, sha1))
>  				remove_redundant_pack(packdir, item->string);
>  		}
> +
> +		if (geometry) {
> +			struct strbuf buf = STRBUF_INIT;
> +
> +			uint32_t i;
> +			for (i = 0; i < geometry->split; i++) {
> +				struct packed_git *p = geometry->pack[i];
> +				if (string_list_has_string(&names,
> +							   hash_to_hex(p->hash)))
> +					continue;
> +
> +				strbuf_reset(&buf);
> +				strbuf_addstr(&buf, pack_basename(p));
> +				strbuf_strip_suffix(&buf, ".pack");
> +
> +				remove_redundant_pack(packdir, buf.buf);
> +			}
> +			strbuf_release(&buf);
> +		}

Before this new code, we seem to remove all pre-existing packfiles
that are not in the output from the pack-objects already.  The only
reason that code does not harm the geometry case is we assume
get_non_kept_pack_filenames() call is never made while doing
geometric repack (iow, ALL_INTO_ONE is not set) and the list of
pre-existing packfiles &existing_packs is empty.  Am I reading the
code correctly?

 - It is a bit unnerving to learn (and it will be a maintenance
   burden in the future) that a variable whose name is
   existing_packs does not necessarily have a list of existing packs
   depending on the mode we are operating in.

 - The guard to make geometric incompatible with ALL_INTO_ONE does
   not mention ALL_INTO_ONE, even though that bit is what would
   corrupt the resulting repository if overlooked.  We should
   probably need s/pack_everything/& \& ALL_INTO_ONE/ in the hunk
    below.

> @@ -382,6 +504,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
>  		die(_(incremental_bitmap_conflict_error));
>  
> +	if (geometric_factor) {
> +		if (pack_everything)
> +			die(_("--geometric is incompatible with -A, -a"));
> +		init_pack_geometry(&geometry);
> +		split_pack_geometry(geometry, geometric_factor);
> +	}
> +
>  	packdir = mkpathdup("%s/pack", get_object_directory());
>  	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
>  

Other than that, it was a fun patch to read.

Thanks.
