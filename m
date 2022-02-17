Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4452EC433FE
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbiBQWH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:07:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiBQWH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:07:27 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21AC12751
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:07:11 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F010187121;
        Thu, 17 Feb 2022 17:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ftEGCvcnI0bGqX31AKlMotw8LDNRFirWL6uexO
        zq+zU=; b=J6pwccvAktcL5Lsx7th77pR6nHrSnYpVOn672G8y8+BQJgXLvk6KfY
        +UFItJnWvp0rE5C1Z8x4IE72srIVOt7mQeY8z30rZNzjUxPgMUi59XddHx6Rd5Fg
        PVCKkqCxrDAoNGK+HdEHlofIGRZ62OOqs0cegkDLGzMymbJGekWdg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0831F187120;
        Thu, 17 Feb 2022 17:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7369618711F;
        Thu, 17 Feb 2022 17:07:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/7] fetch: backfill tags before setting upstream
References: <cover.1645102965.git.ps@pks.im>
        <b0a067bbc1e7b9d3ad76acd437d8095c5a48c5d7.1645102965.git.ps@pks.im>
Date:   Thu, 17 Feb 2022 14:07:07 -0800
In-Reply-To: <b0a067bbc1e7b9d3ad76acd437d8095c5a48c5d7.1645102965.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 17 Feb 2022 14:04:20 +0100")
Message-ID: <xmqqzgmp6tbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2F024AA-903D-11EC-969E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The fetch code flow is a bit hard to understand right now:
>
>     1. We optionally prune all references which have vanished on the
>        remote side.
>     2. We fetch and update all other references locally.
>     3. We update the upstream branch in the gitconfig.
>     4. We backfill tags pointing into the history we have just fetched.
>
> It is quite confusing that we fetch objects and update references in
> both (2) and (4), which is further stressed by the point that we use a
> `skip` goto label to jump from (3) to (4) in case we fail to update the
> gitconfig as expected.
>
> Reorder the code to first update all local references, and only after we
> have done so update the upstream branch information. This improves the
> code flow and furthermore makes it easier to refactor the way we update
> references together.

OK, as "setting upsream" is more or less unrelated to the act of
actual fetching the refs and objects reachable from them, moving it
outside the main code that is about fetching does make sense.

>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs)
>  {
> -	struct ref *ref_map;
> +	struct ref *ref_map = NULL;

This is needed because we will always do free_refs() on the variable
after this patch, and one early "goto cleanup" happens even before
we touch ref_map, when truncate_fetch_head() fails.

> @@ -1620,11 +1620,24 @@ static int do_fetch(struct transport *transport,
>  			retcode = 1;
>  	}
>  	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
> -		free_refs(ref_map);
>  		retcode = 1;
>  		goto cleanup;

And because we always free_refs(ref_map), we can lose a call here.
OK.

> +	/*
> +	 * If neither --no-tags nor --tags was specified, do automated tag
> +	 * following.
> +	 */
> +	if (tags == TAGS_DEFAULT && autotags) {
> +		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
> +
> +		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
> +		if (tags_ref_map)
> +			backfill_tags(transport, tags_ref_map, worktrees);
> +
> +		free_refs(tags_ref_map);
> +	}

Here, the new code uses a local and separete tags_ref_map variable
and free it before we leave, instead of reusing ref_map variable.

OK.

