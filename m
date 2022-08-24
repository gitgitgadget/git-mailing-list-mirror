Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A2EC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 15:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiHXPsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiHXPra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 11:47:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119F5FAC9
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 08:46:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1844B1AC935;
        Wed, 24 Aug 2022 11:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JdcGjNaBlR3yNKnKYYZJFMgPHsuHMBD4dJy4qL
        Ghlf4=; b=i7xUfigFJoJg9IiX4MRH4yBFA1sk0022NN+8qbgn9Nkjcit8633hDd
        rsnNgS6R1cBk+XjSLzMPvjSeefAV4XtfiEOivuiP/xLACy9VFPJhq2MbBosHsn6W
        lg/HLUNkbFDghHYtPuoKTHuKU2t6wQxYP2lqgFFMvK81zFhPhS/4o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 103931AC934;
        Wed, 24 Aug 2022 11:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A46CF1AC932;
        Wed, 24 Aug 2022 11:46:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com
Subject: Re: [PATCH v3 3/5] clone: add --bundle-uri option
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
        <00debaf6e77852efe1dcad4bfda5ebd5bf590ac4.1660050704.git.gitgitgadget@gmail.com>
        <xmqq8rngas5q.fsf@gitster.g>
        <5229519b-3af2-a023-8996-43343b130722@github.com>
Date:   Wed, 24 Aug 2022 08:46:13 -0700
In-Reply-To: <5229519b-3af2-a023-8996-43343b130722@github.com> (Derrick
        Stolee's message of "Tue, 23 Aug 2022 10:05:13 -0400")
Message-ID: <xmqq1qt5ablm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2ACE5DC-23C3-11ED-91D9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
> Date: Tue, 23 Aug 2022 09:53:47 -0400
> Subject: [PATCH] clone: warn on failure to repo_init()
>
> The --bundle-uri option was added in 55568919616 (clone: add
> --bundle-uri option, 2022-08-09), but this also introduced a call to
> repo_init() whose return value was ignored. Fix that ignored value by
> warning that the bundle URI process could not continue if it failed.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---

OK.  It looks like a sensible thing to do.

>  builtin/clone.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 4463789680b..e21d42dfee5 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1245,8 +1245,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	 */
>  	if (bundle_uri) {
>  		/* At this point, we need the_repository to match the cloned repo. */
> -		repo_init(the_repository, git_dir, work_tree);
> -		if (fetch_bundle_uri(the_repository, bundle_uri))
> +		if (repo_init(the_repository, git_dir, work_tree))
> +			warning(_("failed to initialize the repo, skipping bundle URI"));
> +		else if (fetch_bundle_uri(the_repository, bundle_uri))
>  			warning(_("failed to fetch objects from bundle URI '%s'"),
>  				bundle_uri);
>  	}
