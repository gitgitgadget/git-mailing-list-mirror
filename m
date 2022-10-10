Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C2C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJJR1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJJR1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:27:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B574DDB
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:27:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABD181CBE3D;
        Mon, 10 Oct 2022 13:27:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xh4kwe1wQ6JCMuN0VXqW1vheZAqiNLA6wSAOQ6
        eqoeg=; b=NGVgKL6uQBasAwOvqAQb3b/xBeNxugDfsOtcPaK8AVuF8dE/8MQMHu
        uuVuHVVu3ZoXwcDx5CyXpnspc8xtzMAcxdCBjjSG0Fn68AVVehSXZieRmbc1rPKj
        LM4AMjLVjo+Pb3OLI/pAaGQKkD9Uqmc/z803ZlGxh65WOHqglDQP0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 992361CBE3C;
        Mon, 10 Oct 2022 13:27:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CB2E11CBE3B;
        Mon, 10 Oct 2022 13:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 08/11] bundle: add flags to verify_bundle(), skip walk
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <83f2cd893a4c47c947a93fe99d202d67f540e963.1665417859.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 10:27:08 -0700
In-Reply-To: <83f2cd893a4c47c947a93fe99d202d67f540e963.1665417859.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 10 Oct 2022
        16:04:16 +0000")
Message-ID: <xmqqbkqj4mj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C53EDB3C-48C0-11ED-8F69-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The verify_bundle() method checks if a bundle can be applied to a given
> repository. This not only verifies that certain commits exist in the
> repository, but Git also checks that these commits are reachable.
>
> This behavior dates back to the original git-bundle builtin written in
> 2e0afafebd8 (Add git-bundle: move objects and references by archive,
> 2007-02-22), but the message does not go into detail why the
> reachability check is important.
>
> Since verify_bundle() is called from unbundle(), we need to add an
> option to pipe the flags through that method.

All makes sense.

> When unbundling from a list of bundles, Git will create refs that point
> to the tips of the latest bundle, which makes this reachability walk
> succeed, in theory. However, the loose refs cache does not get
> invalidated and hence the reachability walk fails. By disabling the
> reachability walk in the bundle URI code, we can get around this
> reachability check.

The above makes it sound like the real culprit is that cache goes
out of sync and the presented solution is a workaround; readers are
left in suspense if the "real" solution (as opposed to a workaround)
would come in a later step or in a future series.

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 8a7c11c6393..ad5baabdd94 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -301,7 +301,13 @@ static int unbundle_from_file(struct repository *r, const char *file)
>  	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
>  		return 1;
>  
> -	if ((result = unbundle(r, &header, bundle_fd, NULL)))
> +	/*
> +	 * Skip the reachability walk here, since we will be adding
> +	 * a reachable ref pointing to the new tips, which will reach
> +	 * the prerequisite commits.
> +	 */
> +	if ((result = unbundle(r, &header, bundle_fd, NULL,
> +			       VERIFY_BUNDLE_SKIP_REACHABLE)))
>  		return 1;

This is not a new problem introduced in this new round, but if we
are updating this, can we fix it to omit assignment inside if
condition?

 * result is initialized to 0.

 * when unbundle returns non-zero, it is assigned to result and the
   function returns immediately, discarding whatever was assigned to
   the variable.

 * if unbundle returns zero, it is assigned to result and the
   control continues from here.  We know result is set to 0, but
   then that is what it was initialized earlier.

