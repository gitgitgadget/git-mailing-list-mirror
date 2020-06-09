Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A59C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0533320774
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="veQ8hVjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFIFlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:41:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59359 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIFlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 01:41:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09BEDD0EFD;
        Tue,  9 Jun 2020 01:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2zY2eBAQkapLW0CoItDSIMJQheM=; b=veQ8hV
        jzvMioIjzEzoj64GWDsfHDRr8N9tXOgnXfBAjE6/C8UcDP0SJArUkefn/51fROeB
        YPP85Rp1tL4MxZ90+9T5+mrXOMPH7dQzfZyXRHWdQq8BiS8Dq8L2mJldVYxFkk6o
        z8zyCSDDqbTItgQhWr5LzVLdpNJzfxy6w4Aj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hAPB5y9G0zGGWB7BaTsBewIKutSrBVKN
        QfpccoDHH5CjmZYRQHH7z7BWjuOnr3Z5B2sFdlMdnVpNUnxS21q8VXxKR4dGpV/6
        wajVWr2bnRdtv1Udhx5u/tcPF7ZfvG0HVVPmJVOjVUZyOuy0ZoY0OIZ/GFgFK2Pt
        6J++qYhS82U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 01360D0EFC;
        Tue,  9 Jun 2020 01:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32CC5D0EFA;
        Tue,  9 Jun 2020 01:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH 2/3] git diff: improve A...B merge-base handling
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <f7c8f094e02406a7d0cb0c61f880e5b01fa413c4.1591661021.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Jun 2020 22:40:57 -0700
In-Reply-To: <f7c8f094e02406a7d0cb0c61f880e5b01fa413c4.1591661021.git.gitgitgadget@gmail.com>
        (Chris Torek via GitGitGadget's message of "Tue, 09 Jun 2020 00:03:40
        +0000")
Message-ID: <xmqqmu5ciyom.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC05BBF0-AA13-11EA-8ABF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct symdiff {
> +	struct bitmap *skip;	/* bitmap of commit indices to skip, or NULL */
> +	int warn;		/* true if there were multiple merge bases */
> +	int base, left, right;	/* index of chosen merge base and left&right */
> +};
> +
> +/*
> + * Check for symmetric-difference arguments, and if present, arrange
> + * everything we need to know to handle them correctly.
> + *
> + * For an actual symmetric diff, *symdiff is set this way:
> + *
> + *  - its skip is non-NULL and marks *all* rev->pending.objects[i]
> + *    indices that the caller should ignore (extra merge bases, of
> + *    which there might be many, and A in A...B).  Note that the
> + *    chosen merge base and right side are NOT marked.
> + *  - warn is set if there are multiple merge bases.
> + *  - base, left, and right hold the merge base and left and
> + *    right side indices, for warnings or errors.
> + *
> + * If there is no symmetric diff argument, sym->skip is NULL and
> + * sym->warn is cleared.  The remaining fields are not set.
> + *
> + * If the user provides a symmetric diff with no merge base, or
> + * more than one range, we do a usage-exit.
> + */
> +static void builtin_diff_symdiff(struct rev_info *rev, struct symdiff *sym)

The function name feels quite suboptimal.  At least I thought that
by the time a call to this function returns, we would have already
produced a symmetric diff output from its name, but apparently that
is not what is being done.  Calling it symdiff_prepare() may be a
vast improvement, perhaps.

> +{
> +	int i, lcount = 0, rcount = 0, basecount = 0;
> +	int lpos = -1, rpos = -1, basepos = -1;
> +	struct bitmap *map = NULL;
> +
> +	/*
> +	 * Use the whence fields to find merge bases and left and
> +	 * right parts of symmetric difference, so that we do not
> +	 * depend on the order that revisions are parsed.  If there
> +	 * are any revs that aren't from these sources, we have a
> +	 * "git diff C A...B" or "git diff A...B C" case.  Or we
> +	 * could even get "git diff A...B C...E", for instance.
> +	 *
> +	 * If we don't have just one merge base, we pick one
> +	 * at random.
> +	 *
> +	 * NB: REV_CMD_LEFT, REV_CMD_RIGHT are also used for A..B,
> +	 * so we must check for SYMMETRIC_LEFT too.  The two arrays
> +	 * rev->pending.objects and rev->cmdline.rev are parallel.
> +	 */
> +	for (i = 0; i < rev->cmdline.nr; i++) {
> +		struct object *obj = rev->pending.objects[i].item;
> +		switch (rev->cmdline.rev[i].whence) {
> +		case REV_CMD_MERGE_BASE:
> +			if (basepos < 0)
> +				basepos = i;
> +			basecount++;
> +			break;		/* do mark all bases */
> +		case REV_CMD_LEFT:
> +			if (obj->flags & SYMMETRIC_LEFT) {
> +				lpos = i;
> +				lcount++;
> +				break;	/* do mark A */
> +			}
> +			continue;
> +		case REV_CMD_RIGHT:
> +			rpos = i;
> +			rcount++;

Even though, unlike lcount, you allow arbitrary number of rcount,
and rpos uses "the last one wins" semantics.  Can we describe in the
comment above what use case benefits from this looseness (as opposed
to erroring out when rcount is NOT 1, like done for lcount)?

> +			continue;	/* don't mark B */
> +		default:
> +			continue;
> +		}
> +		if (map == NULL)
> +			map = bitmap_new();
> +		bitmap_set(map, i);
> +	}
> +
> +	if (lcount == 0) {	/* not a symmetric difference */
> +		bitmap_free(map);
> +		sym->warn = 0;
> +		sym->skip = NULL;
> +		return;
> +	}
> +
> +	if (lcount != 1)
> +		die(_("cannot use more than one symmetric difference"));
> +
> +	if (basecount == 0) {
> +		const char *lname = rev->pending.objects[lpos].name;
> +		const char *rname = rev->pending.objects[rpos].name;
> +		die(_("%s...%s: no merge base"), lname, rname);
> +	}
> +	bitmap_unset(map, basepos);	/* unmark the base we want */
> +	sym->base = basepos;
> +	sym->left = lpos;
> +	sym->right = rpos;
> +	sym->warn = basecount > 1;
> +	sym->skip = map;
> +}
> +
>  int cmd_diff(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> @@ -263,6 +361,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	struct object_array_entry *blob[2];
>  	int nongit = 0, no_index = 0;
>  	int result = 0;
> +	struct symdiff sdiff;
>  
>  	/*
>  	 * We could get N tree-ish in the rev.pending_objects list.
> @@ -382,6 +481,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> +	builtin_diff_symdiff(&rev, &sdiff);
>  	for (i = 0; i < rev.pending.nr; i++) {
>  		struct object_array_entry *entry = &rev.pending.objects[i];
>  		struct object *obj = entry->item;
> @@ -394,8 +494,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			die(_("invalid object '%s' given."), name);
>  		if (obj->type == OBJ_COMMIT)
>  			obj = &get_commit_tree(((struct commit *)obj))->object;
> -
>  		if (obj->type == OBJ_TREE) {
> +			if (sdiff.skip && bitmap_get(sdiff.skip, i))
> +				continue;
>  			obj->flags |= flags;
>  			add_object_array(obj, name, &ent);
>  		} else if (obj->type == OBJ_BLOB) {
> @@ -437,24 +538,22 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		usage(builtin_diff_usage);
>  	else if (ent.nr == 1)
>  		result = builtin_diff_index(&rev, argc, argv);
> -	else if (ent.nr == 2)
> +	else if (ent.nr == 2) {
> +		if (sdiff.warn) {
> +			const char *lname = rev.pending.objects[sdiff.left].name;
> +			const char *rname = rev.pending.objects[sdiff.right].name;
> +			const char *basename = rev.pending.objects[sdiff.base].name;
> +			warning(_("%s...%s: multiple merge bases, using %s"),
> +				lname, rname, basename);
> +		}
>  		result = builtin_diff_tree(&rev, argc, argv,
>  					   &ent.objects[0], &ent.objects[1]);
> -	else if (ent.objects[0].item->flags & UNINTERESTING) {
> -		/*
> -		 * diff A...B where there is at least one merge base
> -		 * between A and B.  We have ent.objects[0] ==
> -		 * merge-base, ent.objects[ents-2] == A, and
> -		 * ent.objects[ents-1] == B.  Show diff between the
> -		 * base and B.  Note that we pick one merge base at
> -		 * random if there are more than one.
> -		 */
> -		result = builtin_diff_tree(&rev, argc, argv,
> -					   &ent.objects[0],
> -					   &ent.objects[ent.nr-1]);
> -	} else
> +	} else {
> +		if (sdiff.skip)
> +			usage(builtin_diff_usage);

sdiff.skip being non-NULL means symdiff_prepare() saw one A...B that
produced two ents and the fact that we have more than two ents mean
that the command line gave us other tree-ishes, e.g. "git diff A...B C"
and it is rejected here.  OK.

>  		result = builtin_diff_combined(&rev, argc, argv,
>  					       ent.objects, ent.nr);
> +	}
