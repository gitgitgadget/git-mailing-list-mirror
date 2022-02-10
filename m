Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343A7C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbiBJQpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:45:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiBJQpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:45:49 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64312122
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:45:50 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B442B1184E1;
        Thu, 10 Feb 2022 11:45:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PcHs3AV6rA7oKfT/WFyKXU0S7fs2WWCKs7gGm+
        xZmlQ=; b=qOuxmP8E4uzDAZ8eh3qy0RqrzfcLlt5K2fOxOXdnKBPkCYce7eMGtn
        6z0nOb16LKF/Llqg2O+IwNvcBWlb+pB8lj6TfVP3yupIRungXd9UkIR0V2fm/0Vo
        1V6qzNZcRphJbgNvn3dpnGCyyXOSaCfS/mqNBTlRO3wwjcMotQZXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA1351184E0;
        Thu, 10 Feb 2022 11:45:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A3081184DF;
        Thu, 10 Feb 2022 11:45:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 3/6] config: add repo_config_set_worktree_gently()
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <cf9e86fe3a403d0ceaff9fdf484a9bf6b07799ac.1644269583.git.gitgitgadget@gmail.com>
        <xmqqv8xpato3.fsf@gitster.g>
        <ab6021a8-cbb9-3261-8e08-bb4a83287473@gmail.com>
        <xmqqzgn07wwf.fsf@gitster.g>
        <2b88fa25-ec40-6416-05c8-81789a415844@gmail.com>
Date:   Thu, 10 Feb 2022 08:45:47 -0800
In-Reply-To: <2b88fa25-ec40-6416-05c8-81789a415844@gmail.com> (Derrick
        Stolee's message of "Thu, 10 Feb 2022 09:48:22 -0500")
Message-ID: <xmqqczjuwtz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E69CF014-8A90-11EC-AAE8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> True, they could be split. The reason to create the _multivar_
> version is for the case that worktree config is not specified,
> so that is the only caller at the moment.

Sorry, but I am not following this part.

> This is an interesting idea. This would require creating a list
> of "should be per-worktree" config keys that are checked within
> the different *_config_set_* methods.

Yes.

> The biggest technical hurdle is that the multivar versions might
> need to send a subset of the given config into the worktree
> config and the rest to the common config.

Yes, instead of having the caller do it.

> Let's see how this progresses in the future, and whether we
> have more config that we believe _must_ be stored on a per-
> worktree basis. At that point, we can see whether the current
> "distributed responsibility" model is too cumbersome.

It is not too distributed, which is a saving grace.  The callers
know they are setting core.sparseCheckout* and they are responsible
to call the per-worktree version.  It would be like having in ref
API an update_HEAD() helper for modifying HEAD, instead of having a
more generic update_ref() that can modify any ref and pass "HEAD" as
an argument to the latter.  The caller needs to know a bit more
details about what needs to happen when dealing with a special thing,
but the special case knowledge is fairly concentrated.

