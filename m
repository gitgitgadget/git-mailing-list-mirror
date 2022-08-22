Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF357C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 21:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiHVVYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiHVVYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 17:24:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8C337F9F
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:24:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C0981AD9DE;
        Mon, 22 Aug 2022 17:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KlnyAKD4cpRv
        4Y4tkNrqgWoRxq9jaI8JpEB6Fu7ExaM=; b=DwyVrpLL1ZHJ99E9SOVjIM3aSp1k
        lvtcUj28JCa6xjmDoStMTajva3Ob1FCiX+NCyD9nFHzT2FydCCbBema7W8cvMgUh
        TQ9vKGnWkIt4zETQDItHpfdOOtctuwM2oU6nWECpSwgRL1wxbe4v4Xs1ODTD5oxq
        ALjmeu9TQp8wSLU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 873921AD9DD;
        Mon, 22 Aug 2022 17:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 22E2C1AD9DC;
        Mon, 22 Aug 2022 17:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 3/5] clone: add --bundle-uri option
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
        <00debaf6e77852efe1dcad4bfda5ebd5bf590ac4.1660050704.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 14:24:01 -0700
In-Reply-To: <00debaf6e77852efe1dcad4bfda5ebd5bf590ac4.1660050704.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 09 Aug 2022
        13:11:41 +0000")
Message-ID: <xmqq8rngas5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BECBBEF4-2260-11ED-B9F3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * Before fetching from the remote, download and install bundle
> +	 * data from the --bundle-uri option.
> +	 */
> +	if (bundle_uri) {
> +		/* At this point, we need the_repository to match the cloned repo. *=
/
> +		repo_init(the_repository, git_dir, work_tree);
> +		if (fetch_bundle_uri(the_repository, bundle_uri))
> +			warning(_("failed to fetch objects from bundle URI '%s'"),
> +				bundle_uri);
> +	}

I do not offhand know why I suddenly started seeing the issue for
this relatively old commit I have had in my tree for at least 10
days, but I am getting this

builtin/clone.c: In function 'cmd_clone':
builtin/clone.c:1248:17: error: ignoring return value of 'repo_init' decl=
ared with attribute 'warn_unused_result' [-Werror=3Dunused-result]
 1248 |                 repo_init(the_repository, git_dir, work_tree);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


with the commit merged in 'seen'.

It seems that the updated ab/submodule-helper-prep is doing it. =20

Why can't that (or any of =C3=86var's) topic focus on what it needs to
do, without churning the codebase and inflict damages to other
topics like this?  Quite frustrating.

I'll redo today's integration without the offending topic to give
other topics test coverage.


