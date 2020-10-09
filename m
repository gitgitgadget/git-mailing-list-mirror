Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A9C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 04:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092BA2223C
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 04:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJ5ypA1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgJIEsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 00:48:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62648 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgJIEsR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 00:48:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D33C38C714;
        Fri,  9 Oct 2020 00:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XV4VJBgsS9OyuZ6/8yG+1qFOxUk=; b=nJ5ypA
        1T5/E6BYWH+BhvOoxHTBumdEwt0k/V7KCivlZoNZr5i0I942okTQpxtWjRtPWVwA
        FPkfUkkre9lCIR/9pgZPMA1rlxrC0w/y/0XpvGrFzTKNW11vVHqL+ZBslvvGjhB7
        fqc1Od1iESahvHZjV/wjraizNp0S5x51akOXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AJfJu7PGe8xzP4YGVzRDKB2HhCjP8V6O
        EnHZ7j8zRBTLgH4C3usnJ+lyTL/BxFTMJ1Cwt9EiLbQPwX/1nOOfIr+C9Wjrlucw
        zW65LQ443wq1CaMVyQChAVU7/SUOkO8VsPe34a2kbrMmzEVmzQLugfcQG/W+aJfE
        R0bVO2P6AIo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB2058C713;
        Fri,  9 Oct 2020 00:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D2568C712;
        Fri,  9 Oct 2020 00:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 03/11] merge-index: libify merge_one_path() and
 merge_all()
References: <20200901105705.6059-1-alban.gruin@gmail.com>
        <20201005122646.27994-1-alban.gruin@gmail.com>
        <20201005122646.27994-4-alban.gruin@gmail.com>
Date:   Thu, 08 Oct 2020 21:48:12 -0700
In-Reply-To: <20201005122646.27994-4-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 5 Oct 2020 14:26:38 +0200")
Message-ID: <xmqqh7r4uhrn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A365F0AC-09EA-11EB-BEA5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> diff --git a/merge-strategies.c b/merge-strategies.c
> index bbe6f48698..f0e30f5624 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -2,6 +2,7 @@
>  #include "dir.h"
>  #include "ll-merge.h"
>  #include "merge-strategies.h"
> +#include "run-command.h"
>  #include "xdiff-interface.h"
>  
>  static int add_to_index_cacheinfo(struct index_state *istate,
> @@ -212,3 +213,101 @@ int merge_strategies_one_file(struct repository *r,
>  
>  	return 0;
>  }
> +
> +int merge_program_cb(const struct object_id *orig_blob,
> +		     const struct object_id *our_blob,
> +		     const struct object_id *their_blob, const char *path,
> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +		     void *data)
> +{
> +	char ownbuf[3][GIT_MAX_HEXSZ] = {{0}};
> +	const char *arguments[] = { (char *)data, "", "", "", path,
> +				    ownbuf[0], ownbuf[1], ownbuf[2],
> +				    NULL };
> +
> +	if (orig_blob)
> +		arguments[1] = oid_to_hex(orig_blob);
> +	if (our_blob)
> +		arguments[2] = oid_to_hex(our_blob);
> +	if (their_blob)
> +		arguments[3] = oid_to_hex(their_blob);

oid_to_hex() uses 4-slot rotating buffer, no?  Relying on the fact
that three would be available here without getting reused (or,
rather, our caller didn't make its own calls and/or does not mind
us invalidating all but one slot for them) feels a bit iffy.

Extending ownbuf[] to 6 elements and using oid_to_hex_r() would be a
trivial way to clarify the code.

> +	xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", orig_mode);
> +	xsnprintf(ownbuf[1], sizeof(ownbuf[1]), "%o", our_mode);
> +	xsnprintf(ownbuf[2], sizeof(ownbuf[2]), "%o", their_mode);

And these mode bits would not need GIT_MAX_HEXSZ to begin with.
This smells like a WIP that hasn't been carefullly proofread.

	char oidbuf[3][GIT_MAX_HEXSZ] = { 0 };
	char modebuf[3][8] = { 0 };
	char *args[] = {
		data, oidbuf[0], oidbuf[1], oidbuf[2], path,
		modebuf[0], modebuf[1], modebuf[2], NULL,
	};
        
        if (orig_blob)
		oid_to_hex_r(oidbuf[0], orig_blob);
	...
	xsnprintf(modebuf[0], ...);


Eh, wait.  Is this meant to be able to drive "git-merge-one-file",
i.e. a missing common/ours/theirs is indicated by an empty string
in both oiod and mode?  If so, an unconditional xsnprintf() would
either give garbage or "0" at best, neither of which is an empty
string.  So the body would be more like

	if (orig_blob) {
		oid_to_hex_r(oidbuf[0], orig_blob);
		xsnprintf(modebuf[0], "%o", orig_mode);
	}
	if (our_blob) {
		oid_to_hex_r(oidbuf[1], our_blob);
		xsnprintf(modebuf[1], "%o", our_mode);
	}
	...

wouldn't it?

> +	return run_command_v_opt(arguments, 0);
> +}
> +
> +static int merge_entry(struct index_state *istate, int quiet, int pos,
> +		       const char *path, merge_cb cb, void *data)

When we use an identifier "cb", it typically means callback data,
not a callback function which is often called "fn".  So, name the
type "merge_fn" (or "merge_func"), and call the parameter "fn".

> +{
> +	int found = 0;
> +	const struct object_id *oids[3] = {NULL};
> +	unsigned int modes[3] = {0};
> +
> +	do {
> +		const struct cache_entry *ce = istate->cache[pos];
> +		int stage = ce_stage(ce);
> +
> +		if (strcmp(ce->name, path))
> +			break;
> +		found++;
> +		oids[stage - 1] = &ce->oid;
> +		modes[stage - 1] = ce->ce_mode;
> +	} while (++pos < istate->cache_nr);
> +	if (!found)
> +		return error(_("%s is not in the cache"), path);
> +
> +	if (cb(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
> +		if (!quiet)
> +			error(_("Merge program failed"));
> +		return -2;
> +	}
> +
> +	return found;
> +}

This copies from builtin/merge-index.c::merge_entry().

> +int merge_one_path(struct index_state *istate, int oneshot, int quiet,
> +		   const char *path, merge_cb cb, void *data)
> +{
> +	int pos = index_name_pos(istate, path, strlen(path)), ret;
> +
> +	/*
> +	 * If it already exists in the cache as stage0, it's
> +	 * already merged and there is nothing to do.
> +	 */
> +	if (pos < 0) {
> +		ret = merge_entry(istate, quiet, -pos - 1, path, cb, data);
> +		if (ret == -1)
> +			return -1;
> +		else if (ret == -2)
> +			return 1;
> +	}
> +	return 0;
> +}

Likewise from the same function in that file.

Are we removing the "git merge-index" program?  Reusing the same
identifier for these copied-and-pasted pairs of functions bothers
me for two reasons.

 - An indentifier that was clear and unique enough in the original
   context as a file-scope static may not be a good name as a global
   identifier.  

 - Having two similar-looking functions with the same name makes
   reading and learning the codebase starting at "git grep" hits
   more difficult than necessary.

> +int merge_all(struct index_state *istate, int oneshot, int quiet,
> +	      merge_cb cb, void *data)
> +{
> +	int err = 0, i, ret;
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		const struct cache_entry *ce = istate->cache[i];
> +		if (!ce_stage(ce))
> +			continue;
> +
> +		ret = merge_entry(istate, quiet, i, ce->name, cb, data);
> +		if (ret > 0)
> +			i += ret - 1;
> +		else if (ret == -1)
> +			return -1;
> +		else if (ret == -2) {
> +			if (oneshot)
> +				err++;
> +			else
> +				return 1;
> +		}
> +	}
> +
> +	return err;
> +}

Likewise.

> diff --git a/merge-strategies.h b/merge-strategies.h
> index b527d145c7..cf78d7eaf4 100644
> --- a/merge-strategies.h
> +++ b/merge-strategies.h
> @@ -10,4 +10,21 @@ int merge_strategies_one_file(struct repository *r,
>  			      unsigned int orig_mode, unsigned int our_mode,
>  			      unsigned int their_mode);
>  
> +typedef int (*merge_cb)(const struct object_id *orig_blob,
> +			const struct object_id *our_blob,
> +			const struct object_id *their_blob, const char *path,
> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +			void *data);

Call it "merge_one_file_func", probably.

> +int merge_program_cb(const struct object_id *orig_blob,

Call it spawn_merge_one_file() perhaps?

> +		     const struct object_id *our_blob,
> +		     const struct object_id *their_blob, const char *path,
> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +		     void *data);
> +
> +int merge_one_path(struct index_state *istate, int oneshot, int quiet,
> +		   const char *path, merge_cb cb, void *data);
> +int merge_all(struct index_state *istate, int oneshot, int quiet,
> +	      merge_cb cb, void *data);
>  #endif /* MERGE_STRATEGIES_H */
