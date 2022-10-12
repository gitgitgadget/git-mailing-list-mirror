Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CCCC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJLQdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJLQc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:32:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25386FD26
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:32:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36B9014EC73;
        Wed, 12 Oct 2022 12:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DLWtXcFsDyLviUgFehlHuGFBCAr5ZuWacawNkB
        lRuII=; b=v4f4Rk981C9f20BQgaqu+QMi71ztgNbVfYerokqdwhkRXzKg8OEmV3
        hcftrYrViQ1jTGkRP4wj0tn4EGvkx8MqHknpDUErn8mxhVJkoIchxVVpeYK68oAc
        l34MM8f+nq4sgsgupO5FyPu/IRkK2ErhIA9ymnVK4bEWXRIo3sGAY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BFE214EC72;
        Wed, 12 Oct 2022 12:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6393A14EC71;
        Wed, 12 Oct 2022 12:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 11/12] bundle-uri: quiet failed unbundlings
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
        <2e0bfa834f14e1f4f66adf36d4326e5f1c2c9c20.1665579160.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:32:53 -0700
In-Reply-To: <2e0bfa834f14e1f4f66adf36d4326e5f1c2c9c20.1665579160.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 12 Oct 2022
        12:52:38 +0000")
Message-ID: <xmqqtu49knnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85B0CC5A-4A4B-11ED-94FC-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When downloading a list of bundles in "all" mode, Git has no
> understanding of the dependencies between the bundles. Git attempts to
> unbundle the bundles in some order, but some may not pass the
> verify_bundle() step because of missing prerequisites. This is passed as
> error messages to the user, even when they eventually succeed in later
> attempts after their dependent bundles are unbundled.
>
> Add a new VERIFY_BUNDLE_QUIET flag to verify_bundle() that avoids the
> error messages from the missing prerequisite commits. The method still
> returns the number of missing prerequisit commits, allowing callers to
> unbundle() to notice that the bundle failed to apply.
>
> Use this flag in bundle-uri.c and test that the messages go away for
> 'git clone --bundle-uri' commands.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---

Interesting that we ended up with <quiet, normal, verbose> verbosity
levels, but "bundle verify --verbose" does not (have to) exist, as
that is the default, and 0 (aka "normal") is no longer used to call
verify_bundle() by anybody.

I actually was wondering that with SKIP_REACHABLE gone, we would
lose the "enum verify_bundle_flags" altogether, without the need for
a new "quiet" option.  But that would not work as unbundle() calls
verify_bundle() and callers of unbundle() do not necessarily want
the verification step to squelch errors.

So looks good overall.

Thanks.
