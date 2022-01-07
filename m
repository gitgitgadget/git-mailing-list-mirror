Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB67C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiAGTkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:40:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59276 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiAGTkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:40:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1A6010F609;
        Fri,  7 Jan 2022 14:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=s/XJPjcTQ8iA
        JKeWfkqLGN1qP842fGBl1PMSDuF+4Ww=; b=tyZu/DaeC7FLL02IbHajgZy5iSXF
        7IM8vJaIOCIoa7FEXXxDcSx0WJ76CQ3o0rlIVap7ceUWFw0G5pZ4QYC1Ulu2TNWJ
        G6hR+jifoR4dnndDVK3be1QFJt07/LuzNwlSySXHuf1mbKhn+jFtbGS3ut9L3RU1
        3CJOo8HhfjoMplg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E094B10F608;
        Fri,  7 Jan 2022 14:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30E4210F601;
        Fri,  7 Jan 2022 14:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for
 CHERI/Arm's Morello
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
        <xmqqczl4bhmo.fsf@gitster.g>
        <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de>
Date:   Fri, 07 Jan 2022 11:40:06 -0800
In-Reply-To: <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Jan 2022 13:16:53 +0100")
Message-ID: <xmqq35lz9vxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9ECDD4C4-6FF1-11EC-8A56-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I actually wonder if it results in code that is much easier to
>> follow if we did:
>>
>>  * Introduce an "enum apply_symlink_treatment" that has
>>    APPLY_SYMLINK_GOES_AWAY and APPLY_SYMLINK_IN_RESULT as its
>>    possible values;
>>
>>  * Make register_symlink_changes() and check_symlink_changes()
>>    work with "enum apply_symlink_treatment";
>>
>>  * (optional) stop using string_list() to store the symlink_changes;
>>    use strintmap and use strintmap_set() and strintmap_get() to
>>    access its entries, so that the ugly implementation detail
>>    (i.e. "the container type we use only has a (void *) field to
>>    store caller-supplied data, so we cast an integer and a pointer
>>    back and forth") can be safely hidden.
>>
> Or strsets -- we only need two.

True.

When we check a path, we make a single look-up of two bit in a
single hashtable but now we need two look-ups, but addition, removal
and renaming of a symlink would be rare enough to matter either way.

Will queue; thanks.

> --- >8 ---
> Subject: [PATCH] apply: use strsets to track symlinks
>
> Symlink changes are tracked in a string_list, with the util pointer
> value indicating whether a symlink is kept or removed.  Using fake
> pointer values requires awkward casts.  Use one strset for each type of
> change instead to simplify and shorten the code.
>
> Original-patch-by: Jessica Clarke <jrtc27@jrtc27.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  apply.c | 42 ++++++++----------------------------------
>  apply.h | 26 +++++++++++---------------
>  2 files changed, 19 insertions(+), 49 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index fed195250b..7deb4f79fd 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -103,7 +103,8 @@ int init_apply_state(struct apply_state *state,
>  	state->linenr =3D 1;
>  	string_list_init_nodup(&state->fn_table);
>  	string_list_init_nodup(&state->limit_by_name);
> -	string_list_init_nodup(&state->symlink_changes);
> +	strset_init(&state->removed_symlinks);
> +	strset_init(&state->kept_symlinks);
>  	strbuf_init(&state->root, 0);
>
>  	git_apply_config();
> @@ -117,7 +118,8 @@ int init_apply_state(struct apply_state *state,
>  void clear_apply_state(struct apply_state *state)
>  {
>  	string_list_clear(&state->limit_by_name, 0);
> -	string_list_clear(&state->symlink_changes, 0);
> +	strset_clear(&state->removed_symlinks);
> +	strset_clear(&state->kept_symlinks);
>  	strbuf_release(&state->root);
>
>  	/* &state->fn_table is cleared at the end of apply_patch() */
> @@ -3812,59 +3814,31 @@ static int check_to_create(struct apply_state *=
state,
>  	return 0;
>  }
>
> -static uintptr_t register_symlink_changes(struct apply_state *state,
> -					  const char *path,
> -					  uintptr_t what)
> -{
> -	struct string_list_item *ent;
> -
> -	ent =3D string_list_lookup(&state->symlink_changes, path);
> -	if (!ent) {
> -		ent =3D string_list_insert(&state->symlink_changes, path);
> -		ent->util =3D (void *)0;
> -	}
> -	ent->util =3D (void *)(what | ((uintptr_t)ent->util));
> -	return (uintptr_t)ent->util;
> -}
> -
> -static uintptr_t check_symlink_changes(struct apply_state *state, cons=
t char *path)
> -{
> -	struct string_list_item *ent;
> -
> -	ent =3D string_list_lookup(&state->symlink_changes, path);
> -	if (!ent)
> -		return 0;
> -	return (uintptr_t)ent->util;
> -}
> -
>  static void prepare_symlink_changes(struct apply_state *state, struct =
patch *patch)
>  {
>  	for ( ; patch; patch =3D patch->next) {
>  		if ((patch->old_name && S_ISLNK(patch->old_mode)) &&
>  		    (patch->is_rename || patch->is_delete))
>  			/* the symlink at patch->old_name is removed */
> -			register_symlink_changes(state, patch->old_name, APPLY_SYMLINK_GOES=
_AWAY);
> +			strset_add(&state->removed_symlinks, patch->old_name);
>
>  		if (patch->new_name && S_ISLNK(patch->new_mode))
>  			/* the symlink at patch->new_name is created or remains */
> -			register_symlink_changes(state, patch->new_name, APPLY_SYMLINK_IN_R=
ESULT);
> +			strset_add(&state->kept_symlinks, patch->new_name);
>  	}
>  }
>
>  static int path_is_beyond_symlink_1(struct apply_state *state, struct =
strbuf *name)
>  {
>  	do {
> -		unsigned int change;
> -
>  		while (--name->len && name->buf[name->len] !=3D '/')
>  			; /* scan backwards */
>  		if (!name->len)
>  			break;
>  		name->buf[name->len] =3D '\0';
> -		change =3D check_symlink_changes(state, name->buf);
> -		if (change & APPLY_SYMLINK_IN_RESULT)
> +		if (strset_contains(&state->kept_symlinks, name->buf))
>  			return 1;
> -		if (change & APPLY_SYMLINK_GOES_AWAY)
> +		if (strset_contains(&state->removed_symlinks, name->buf))
>  			/*
>  			 * This cannot be "return 0", because we may
>  			 * see a new one created at a higher level.
> diff --git a/apply.h b/apply.h
> index 16202da160..4052da50c0 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -4,6 +4,7 @@
>  #include "hash.h"
>  #include "lockfile.h"
>  #include "string-list.h"
> +#include "strmap.h"
>
>  struct repository;
>
> @@ -25,20 +26,6 @@ enum apply_verbosity {
>  	verbosity_verbose =3D 1
>  };
>
> -/*
> - * We need to keep track of how symlinks in the preimage are
> - * manipulated by the patches.  A patch to add a/b/c where a/b
> - * is a symlink should not be allowed to affect the directory
> - * the symlink points at, but if the same patch removes a/b,
> - * it is perfectly fine, as the patch removes a/b to make room
> - * to create a directory a/b so that a/b/c can be created.
> - *
> - * See also "struct string_list symlink_changes" in "struct
> - * apply_state".
> - */
> -#define APPLY_SYMLINK_GOES_AWAY 01
> -#define APPLY_SYMLINK_IN_RESULT 02
> -
>  struct apply_state {
>  	const char *prefix;
>
> @@ -86,7 +73,16 @@ struct apply_state {
>
>  	/* Various "current state" */
>  	int linenr; /* current line number */
> -	struct string_list symlink_changes; /* we have to track symlinks */
> +	/*
> +	 * We need to keep track of how symlinks in the preimage are
> +	 * manipulated by the patches.  A patch to add a/b/c where a/b
> +	 * is a symlink should not be allowed to affect the directory
> +	 * the symlink points at, but if the same patch removes a/b,
> +	 * it is perfectly fine, as the patch removes a/b to make room
> +	 * to create a directory a/b so that a/b/c can be created.
> +	 */
> +	struct strset removed_symlinks;
> +	struct strset kept_symlinks;
>
>  	/*
>  	 * For "diff-stat" like behaviour, we keep track of the biggest chang=
e
> --
> 2.34.1
