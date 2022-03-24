Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C137FC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbiCXEep (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 00:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiCXEem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 00:34:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA179C4E
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:33:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81B2912D898;
        Thu, 24 Mar 2022 00:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=AVVlUs0RSzMqsV50nocuh4CaR
        WhDK6gpB+NujFpzsCY=; b=Y0uko7zEikrw8xdcxjvoV3RAUjHcxr52jms5x2wyG
        ooc5qZtWpR0TBWlzsuI+HungGit3a3oKJPjduT50jOBHF+9RcxE2Akr43WUFcYgb
        njDKHd9EkJB7FHSo5yjIZuRcLabF50oYibPHU4iwsrk97bhV8CpyPolNlPIBI7m8
        3s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D4112D897;
        Thu, 24 Mar 2022 00:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E115612D896;
        Thu, 24 Mar 2022 00:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/27] revision.[ch]: split freeing of revs->commit
 into a function
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-05.27-4c0718b43d7-20220323T203149Z-avarab@gmail.com>
Date:   Wed, 23 Mar 2022 21:33:07 -0700
Message-ID: <xmqqa6dgm0l8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81B0494C-AB2B-11EC-95CD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +static void release_revisions_commit_list(struct rev_info *revs)
> +{
> +	struct commit_list *commits =3D revs->commits;
> +
> +	if (!commits)
> +		return;
> +	free_commit_list(commits);
> +	revs->commits =3D NULL;
> +}

It makes sense to have this as a separate helper, but the original
implementation this was lifted from is much easier to follow than
this version with an unnecessary rewrite, I would think.

> @@ -4080,10 +4090,7 @@ static void create_boundary_commit_list(struct r=
ev_info *revs)
>  	 * boundary commits anyway.  (This is what the code has always
>  	 * done.)
>  	 */
> -	if (revs->commits) {
> -		free_commit_list(revs->commits);
> -		revs->commits =3D NULL;
> -	}
> +	release_revisions_commit_list(revs);

IOW

static void release_revisions_commit_list(struct rev_info *revs)
{
	if (revs->commits) {
		free_commit_list(revs->commits);
		revs->commits =3D NULL;
	}
}

