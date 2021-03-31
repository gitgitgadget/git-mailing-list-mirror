Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B01EC433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C503061056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhCaWzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:55:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61097 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCaWzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 18:55:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72680124C88;
        Wed, 31 Mar 2021 18:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AO10L71N2OhV
        Z8igN0NHhMBiCqo=; b=P750MkyAkuyxCmkvA7YGvD69brNWUA/CItHofIWHLtYc
        aiabjyfUzu9PHKlBbbbAEb90oyzzMP669girdsoPx4WrEwsF9NmCQ4b8v7Ujdh9t
        7547v8Lcm/MHNddAVmRIBJyNXhjfmL9bdmlCBxCeKXjBET7QzP7Hij5V1jYs38g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JDKQat
        B1PBKujdf8HI6BJqjoBSwhyRrwDGeFoeod7gFB5wSYR9V9xZ/ynenVEZ8MavEsa9
        m4a0NWGZ/ogjyzsrE2SVNix/g3xYe3TjqfghLpJsC/8JPzbglqpw2E2RaMi7uXb4
        xUxjGfhtU2NsabcWrUKsJI9OtTEeHDbyNmiwM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C3D6124C87;
        Wed, 31 Mar 2021 18:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A29B6124C86;
        Wed, 31 Mar 2021 18:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 03/18] cache.h: have base_name_compare() take "is
 tree?", not "mode"
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-03.19-44c3fdd0085-20210331T190531Z-avarab@gmail.com>
Date:   Wed, 31 Mar 2021 15:55:09 -0700
In-Reply-To: <patch-03.19-44c3fdd0085-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:31
        +0200")
Message-ID: <xmqqeefv53xu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 260732FC-9274-11EB-90B6-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the base_name_compare() API and the related df_name_compare()
> function to take a boolean argument indicating whether the entry is a
> tree or not, instead of having them call S_ISDIR(mode) on their own.
>
> This introduces no functional change, but makes later (not part of
> this series) changes to abstract away "object_type" from "mode" more
> readable.
>
> The API being modified here was originally added way back in
> 958ba6c96eb (Introduce "base_name_compare()" helper function,
> 2005-05-20).
>
> None of these comparison functions used to have tests, but with
> preceding commits some of them now do. I thought the remainder was
> trivial enough to review without tests, and didn't want to spend more
> time on them.

Puzzled.  preceeding commits?

> diff --git a/cache.h b/cache.h
> index 41e99bd9c63..3bcea022ad2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1506,8 +1506,8 @@ int repo_interpret_branch_name(struct repository =
*r,
> =20
>  int validate_headref(const char *ref);
> =20
> -int base_name_compare(const char *name1, int len1, int mode1, const ch=
ar *name2, int len2, int mode2);
> -int df_name_compare(const char *name1, int len1, int mode1, const char=
 *name2, int len2, int mode2);
> +int base_name_compare(const char *name1, int len1, int istree1, const =
char *name2, int len2, int istree2);
> +int df_name_compare(const char *name1, int len1, int istree1, const ch=
ar *name2, int len2, int istree2);
>  int name_compare(const char *name1, size_t len1, const char *name2, si=
ze_t len2);
>  int cache_name_stage_compare(const char *name1, int len1, int stage1, =
const char *name2, int len2, int stage2);

Hopefully there won't be any new callers to these comparison
functions introduced while this topic is in flight.

Without seeing real users (not yet at this 3rd step in the 18 patch
series, anyway), this step feels to be a needless code churn whose
only effect is to increase risks of silent semantic conflicts that
compilers will not be able to help detecting.  It might make it
slightly less error prone to add

	if (istree1 !=3D 0 && istree1 !=3D 1)
		BUG("%o?  unconverted caller?", istree1);
	if (istree2 !=3D 0 && istree2 !=3D 1)
		BUG("%o?  unconverted caller?", istree2);

in the callee while the topic is still in flight.  Or do this in a
renamed function so that such a semantic conflict will be noticed by
the linker (although that would increase the busywork workload on
the integrator).

I know steps like this in a long series (not limited to this series)
means well, and we do encourage people to move necessary preliminary
clean-up to the early part of a series, but they make me wonder "can
we get to the point without 'clean-up while we are at it' steps that
may turn out to be more-or-less irrelevant?"

In other words, we do encourage people to do necessary preliminary
clean-up before the main part of a series, but it sometimes is
unclear if an early "clean-up" patch in a long series is "necessary"
or merely "while at it" that can be omitted.

But let me hold my judgment until I reach the end of the series to
know enough to say if this step is or is not "necessary" preliminary
clean-up.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 29029f34ed6..23c1640ae9a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -925,7 +925,7 @@ static int traverse_trees_recursive(int n, unsigned=
 long dirmask,
>  static int do_compare_entry_piecewise(const struct cache_entry *ce,
>  				      const struct traverse_info *info,
>  				      const char *name, size_t namelen,
> -				      unsigned mode)
> +				      unsigned istree)

Here, the "istree" boolean is expressed as unsigned, but in cache.h,
it is expressed as int?  Why the discrepancy?
