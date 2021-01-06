Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83416C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 03:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB9522CB1
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 03:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbhAFD4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 22:56:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51881 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFD4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 22:56:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE42710BF63;
        Tue,  5 Jan 2021 22:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8Sp60l7W1A0+4KytHqhUS4w1x5k=; b=b3lonK8QPgyVl7A3Kd4T
        ml/bYJ0Sjn1+CRRYInglzk5pOARkXNSiten48on9NnE6L/GptGDJMih+l39Kxwlx
        W/RfgEE8e4HOF6r76tqrE5tLqu9ksNQUX5qY69tQ0PM8/sQUIoJ2+HTiks6MFYo6
        sTfm0+1cKZ8Qa2WM++4ls4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=MydmF7xr1NX9u0GXGsTKdDsFBlnVD+IahhRpudDk4JUVS2
        y8YXzfPZ35D1jl8eNrzvC/wVAfmBCkzFpF7sRD5ZGjIZKvZ6+ADjD+TxlI7JVMR2
        PRnylm14fVuOdVrMM73D2I4gRYMheJ57cwLHy+JzgJo+JmiwCJRuFJGr/HyXM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6C0210BF62;
        Tue,  5 Jan 2021 22:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F86010BF61;
        Tue,  5 Jan 2021 22:55:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 19:55:22 -0800
Message-ID: <xmqqczyiwwgl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 013864AC-4FD3-11EB-A428-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> My strategy for update-index was to create static globals "repo" and
> "istate" that point to the_repository and the_index, respectively. Then, I
> was able to remove macros one-by-one without changing method prototypes
> within the file.

Knee-jerk reaction: swapping one pair of global with another?  Would
that give us enough upside?  It may allow some codepaths involved to
work on an in-core index instance that is different from the_index,
but does not make them reentrant.

Do we now have callers that actually pass an in-core index instance
that is different from the_index, and more importantly, that fail
loudly if the codepaths involved in this conversion forgets to
update some accesses to the_index not to the specified one?

If not, ... 

> In total, this allows us to remove four of the compatibility macros because
> they are no longer used.

... a conversion like this, removing the use of the compatibility
macros for the sake of removing them, invites future headaches by
leaving untested code churn behind with potential bugs that will
only get discovered after somebody actually starts making calls
with the non-default in-core index instances.

I've come to know the competence of you well enough to trust your
patches like patches from other proficient, prolific and prominent
contributors (I won't name names, but you know who you are), but we
are all human and are prone to introduce bugs.

That's all my knee-jerk impression before actually reading the
series through, though.  I'll certainloy know more after reading
them.

Thanks.

> Derrick Stolee (12):
>   merge-index: drop index compatibility macros
>   mv: remove index compatibility macros
>   rm: remove compatilibity macros
>   update-index: drop the_index, the_repository
>   update-index: use istate->cache over active_cache
>   update-index: use index->cache_nr over active_nr
>   update-index: use istate->cache_changed
>   update-index: use index_name_pos() over cache_name_pos()
>   update-index: use remove_file_from_index()
>   update-index: use add_index_entry()
>   update-index: replace several compatibility macros
>   update-index: remove ce_match_stat(), all macros
>
>  Documentation/technical/racy-git.txt |   6 +-
>  builtin/merge-index.c                |  33 +++---
>  builtin/mv.c                         |  42 ++++----
>  builtin/rm.c                         |  56 ++++++-----
>  builtin/update-index.c               | 145 ++++++++++++++-------------
>  cache.h                              |   4 -
>  6 files changed, 149 insertions(+), 137 deletions(-)
>
>
> base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-830%2Fderrickstolee%2Findex-compatibility-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-830/derrickstolee/index-compatibility-1-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/830
