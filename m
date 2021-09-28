Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB918C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21E461209
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbhI1Wvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:51:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57315 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1Wvf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 18:51:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F04CE14BC2C;
        Tue, 28 Sep 2021 18:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hASrqxOivQkReN68ZRi4EnYBx18qiaRQtoCOQS
        vgKrI=; b=G4DjqHRZNueRt7eeJ++rgY9FJvyyJ3uDb4q7jLb5CLAekCXgozHPel
        f7rLzEvghqiIJgujfZjzg06R2dvhPeDqHH/XZAaaMzImeNGfKMy3IwDUTPk4DewD
        GlLO9JR/CPBdzgK0mGCdXHi+wddoQ5e9DuLlGnwRHctHFDK+wUPo8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8E1814BC2B;
        Tue, 28 Sep 2021 18:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 600EA14BC29;
        Tue, 28 Sep 2021 18:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, newren@gmail.com
Subject: Re: [PATCH v2 4/9] refs: teach refs_for_each_ref() arbitrary repos
References: <cover.1632242495.git.jonathantanmy@google.com>
        <cover.1632859147.git.jonathantanmy@google.com>
        <da0c9c2d44da40e25c2c5b68697e3461cefd63a5.1632859148.git.jonathantanmy@google.com>
Date:   Tue, 28 Sep 2021 15:49:51 -0700
In-Reply-To: <da0c9c2d44da40e25c2c5b68697e3461cefd63a5.1632859148.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 28 Sep 2021 13:10:50 -0700")
Message-ID: <xmqqh7e4iacw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 647F1522-20AE-11EC-9094-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  	} else if (!(flags & OPT_CACHED)) {
>  		struct object_id oid;
> -		struct ref_store *refs = get_submodule_ref_store(path);
> +		struct repository subrepo;
>  
> -		if (!refs) {
> +		if (repo_submodule_init(&subrepo, the_repository, path, null_oid())) {
>  			print_status(flags, '-', path, ce_oid, displaypath);
>  			goto cleanup;
>  		}
> -		if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
> +		if (refs_head_ref(&subrepo, handle_submodule_head_ref, &oid))
>  			die(_("could not resolve HEAD ref inside the "
>  			      "submodule '%s'"), path);
> +		repo_clear(&subrepo);

While this makes perfect sense, if we extended the ref_store to know
what repository it belongs to, I suspect that we don't have to
change anything in a "user" codepath like this one.
get_submodule_ref_store() would repare a ref store that is bound to
the submodule repository, refs_head_ref() and other helpers that
take a ref_store would not have to gain an extra "repository"
parameter (because it is known via the ref_store) and does the
iteration in the right repository, etc...

> @@ -1018,9 +1019,12 @@ static void generate_submodule_summary(struct summary_cb *info,
>  
>  	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
>  		if (S_ISGITLINK(p->mod_dst)) {
> -			struct ref_store *refs = get_submodule_ref_store(p->sm_path);
> -			if (refs)
> -				refs_head_ref(refs, handle_submodule_head_ref, &p->oid_dst);
> +			struct repository subrepo;
> +
> +			if (!repo_submodule_init(&subrepo, the_repository, p->sm_path, null_oid())) {
> +				refs_head_ref(&subrepo, handle_submodule_head_ref, &p->oid_dst);
> +				repo_clear(&subrepo);
> +			}

The story looks the same here, too.

