Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88873C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJJSka (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJJSk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:40:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99865E0DF
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:40:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB5911BE870;
        Mon, 10 Oct 2022 14:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7GO4Wm7aB9cb6VcyKdtiQMixyFxOyjRDDhm13h
        1waxM=; b=PY8pgMIgKK4vv/BoQdIUb/gIcsYu90WvzPBnp8WUeyMRqak6UCLJy9
        X9kIsMGydD9P2X59HA+WHA777tycaFEw3XYzo688vzWJjR2wbOrN3BxdDBLwyuN1
        q/3AkZU9v+oueRp17dDv6Nfa4H6L8vi7QgnlS5mglNLtqncTXbz2M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B29401BE86F;
        Mon, 10 Oct 2022 14:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB0471BE86A;
        Mon, 10 Oct 2022 14:40:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 08/11] bundle: add flags to verify_bundle(), skip walk
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <83f2cd893a4c47c947a93fe99d202d67f540e963.1665417859.git.gitgitgadget@gmail.com>
        <xmqqbkqj4mj7.fsf@gitster.g>
        <08877824-b454-df37-1819-edee34919f95@github.com>
Date:   Mon, 10 Oct 2022 11:40:20 -0700
In-Reply-To: <08877824-b454-df37-1819-edee34919f95@github.com> (Derrick
        Stolee's message of "Mon, 10 Oct 2022 14:13:10 -0400")
Message-ID: <xmqqk05734kr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF287556-48CA-11ED-B5BE-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I've been going over the refs code multiple times today trying to
> fix this "real" culprit, with no luck. I can share this interesting
> point:
>
>  * The initial loop over the bundles tries to apply each, but the
>    prerequisite objects are not present so we never reach the revision
>    walk. A refs/bundle/* ref is added via update_ref().
>
>  * The second loop over the bundles tries to apply each, but the only
>    bundle with its prerequisites present also finds the commits as
>    reachable (this must be where the loose ref cache is populated).
>    Then, a refs/bundle/* ref is added via update_ref().
>
>  * The third loop over the bundles finds a bundle whose prerequisites
>    are present, but verify_bundle() rejected it because those commits
>    were not seen from any ref.
>
> Other than identifying that issue, I was unable to track down exactly
> what is happening here or offer a fix. I had considered inserting
> more cache frees deep in the refs code, but I wasn't sure what effect
> that would have across the wider system.

OK.  That certainly is understandable.

As a comment in the proposed log message that BUNDLE_SKIP_REACHABLE
bit is a band aid papering over a problem we punted in this series,
to guide future developers, I think what you wrote is sufficient.
We do not want them to think that skipping the check is our
preferred longer term solution and add their own hack to keep
skipping the check when they resolve "the real culprit".

Thanks.
