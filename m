Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E7C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiCYBJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348928AbiCYBJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:09:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8EEBBE14
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:07:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0C7812EFE9;
        Thu, 24 Mar 2022 21:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4x89c2d9h1Jk
        fS4tGm5/Ro9FP5Nzwxx56499Ci1IQNk=; b=vCtZnAwfwRu9MYY/NjJTFaU+uFbi
        OTs8vgDVXGeuurFKahbOb79blouD/N/AVCobot3/aji4G50+XrZwEo+MerbNsEQU
        K0AQUKGy+nF/iSZfwIkWCikeMN7cidD2pzAaPcf5dFSOqTtp+J+uR56chRj3fyU5
        oM9Rt3CDCL2kNXk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5F5512EFE8;
        Thu, 24 Mar 2022 21:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 173AD12EFE7;
        Thu, 24 Mar 2022 21:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 14/27] revisions API users: use release_revisions()
 in submodule.c edge case
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-14.27-38f4f1c4ecb-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 18:07:51 -0700
In-Reply-To: <patch-v2-14.27-38f4f1c4ecb-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:32:04
        +0100")
Message-ID: <xmqq1qyqet5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FEB344A6-ABD7-11EC-B8DF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/submodule.c b/submodule.c
> index 0510cb193b6..285c1896c9e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -638,7 +638,7 @@ void show_submodule_diff_summary(struct diff_option=
s *o, const char *path,
>  		struct object_id *one, struct object_id *two,
>  		unsigned dirty_submodule)
>  {
> -	struct rev_info rev;
> +	struct rev_info rev =3D { 0 };

Exactly the same comment as an earlier step about bundle and bisect
applies here.

>  	struct commit *left =3D NULL, *right =3D NULL;
>  	struct commit_list *merge_bases =3D NULL;
>  	struct repository *sub;
> @@ -664,6 +664,7 @@ void show_submodule_diff_summary(struct diff_option=
s *o, const char *path,
>  	print_submodule_diff_summary(sub, &rev, o);
> =20
>  out:
> +	release_revisions(&rev);
>  	if (merge_bases)
>  		free_commit_list(merge_bases);
>  	clear_commit_marks(left, ~0);
