Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A07C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiCIW7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiCIW7A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:59:00 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901C255AB
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:57:57 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45B1517904C;
        Wed,  9 Mar 2022 17:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2x5lYgtqcz4J
        j+OFspoH6h7vD5xpBVJbp9e3VKYyBvs=; b=RY+IRLA1iv0FHltuwdshrdqQ4yiz
        qoYgA84Wt2mF06kI2HS3td7Q7ri8leBYi8N1N10usv3bt4TFtE+G8y13feCfcDLb
        GqDSvPv8MR49WRSIX5RDqHIMTVa0mCQ6xAIVH0mErrXTVncYu1O2xDjY/H0Bi/hU
        B3aPlNkaoy2dugE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EFF917904B;
        Wed,  9 Mar 2022 17:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 783A117904A;
        Wed,  9 Mar 2022 17:57:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/24] revision.[ch]: provide and start using a
 release_revisions()
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
Date:   Wed, 09 Mar 2022 14:57:52 -0800
In-Reply-To: <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 9 Mar
 2022 14:16:35
        +0100")
Message-ID: <xmqqmthylonj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A2C4356-9FFC-11EC-9B7F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 9244827ca02..ed993383531 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -629,7 +629,7 @@ static void show_local_changes(struct object *head,
>  	diff_setup_done(&rev.diffopt);
>  	add_pending_object(&rev, head, NULL);
>  	run_diff_index(&rev, 0);
> -	object_array_clear(&rev.pending);
> +	release_revisions(&rev);
>  }

I very much like this.

> -	object_array_clear(&rev.pending);
>  	clear_pathspec(&rev.prune_data);
> +	release_revisions(&rev);

But this makes readers wonder why .prune_data still needs a separate
call to clear.  We are making it unnecessary to clear .pending
separately, which was what made me say I very much like this in the
first place.

At least surviving clear_pathspec() now deserves an in-code comment?
We'll know when we see what release_revisions() actually does.

>  	run_diff_index(&rev, 1);
> -	object_array_clear(&rev.pending);
> -	return (rev.diffopt.flags.has_changes !=3D 0);
> +	has_changes =3D rev.diffopt.flags.has_changes;
> +	release_revisions(&rev);
> +	return (has_changes !=3D 0);

This is necessary because release_revisions(&rev) is a way to
release all resources held by rev, and .has_changes is stored
as a part of a resource that will be cleared.

> diff --git a/revision.c b/revision.c
> index 5824fdeddfd..831f2cf977b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2926,6 +2926,13 @@ static void release_revisions_commit_list(struct=
 rev_info *revs)
>  	revs->commits =3D NULL;
>  }
> =20
> +void release_revisions(struct rev_info *revs)
> +{
> +	if (!revs)
> +		return;
> +	object_array_clear(&revs->pending);
> +}

Whoa. =20

Earlier, we saw a code that indicates that a call to this function
will invalidate the revs->diffopt.flags.has_changes but that is not
the case, at least at this point in the series.  Is this a result of
an incorrect "rebase -i"?

Regarding the clear_pathspec() earlier we saw, it is OK to leave the
call there without any extra comment, if the plan is to first start
by introducing release_revisions() that does nothing but .pending
field.  But then the diffopt.flags.has_changes thing we saw earlier
should be postponed to a step where release_revisions() clears the
diffopt structure that is embedded in rev_info.

> @@ -2568,8 +2568,9 @@ int has_uncommitted_changes(struct repository *r,
> =20
>  	diff_setup_done(&rev_info.diffopt);
>  	result =3D run_diff_index(&rev_info, 1);
> -	object_array_clear(&rev_info.pending);
> -	return diff_result_code(&rev_info.diffopt, result);
> +	result =3D diff_result_code(&rev_info.diffopt, result);
> +	release_revisions(&rev_info);
> +	return result;

Ditto.
