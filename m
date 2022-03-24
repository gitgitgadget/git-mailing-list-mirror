Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79875C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbiCXEom (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 00:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiCXEoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 00:44:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56232C23
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:43:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6944D12DA58;
        Thu, 24 Mar 2022 00:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=LcrNWwZIB5dpUpP9dLkL0qB1p
        ITyXXg0pDuZF0pC9Uc=; b=IgXQ9pYu5Kqj574d/PCogplAgAbYimPc+pRspa/c5
        TS4yaNMRXONy4eABUfxFNILVxdlElaVh4D+3XUjhuaaNRd6QQI4iwin8l8d9fK/j
        sOU403U0Bv1AoHBvvMwbsurcIqRMqkNT2DPEj/CthwfUKFEGBScxVdYp67tJQYUf
        bY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EC0112DA57;
        Thu, 24 Mar 2022 00:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBCC412DA56;
        Thu, 24 Mar 2022 00:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 06/27] revision.[ch]: provide and start using a
 release_revisions()
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-06.27-7194aac88e1-20220323T203149Z-avarab@gmail.com>
Date:   Wed, 23 Mar 2022 21:43:05 -0700
Message-ID: <xmqq4k3om04m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E60B613C-AB2C-11EC-B503-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/revision.c b/revision.c
> index 303d1188207..90bac9ada03 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2933,6 +2933,13 @@ static void release_revisions_commit_list(struct=
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

Yay.

It is unclear why we want to allow passing NULL to this, though.  Do
we even have any code paths that allocate on-heap rev-info?  Address
of an on-stack or global rev_info will never be NULL.
