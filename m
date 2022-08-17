Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005CAC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 18:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbiHQSra (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiHQSr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 14:47:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD25A344B
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 11:47:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6D60140EA8;
        Wed, 17 Aug 2022 14:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TZB0u8vQLBLoEdbhy7TAZvOdP/XCtnjH/Slhe/
        EIZrc=; b=SO0TackJBhXLoWeim0wjdQNaYopuN8g1vsMHV3tpcHKcLvJ3ccs9Vx
        rubMyEeyUBO7qZR27+Eq6L7ZkcSRZyX0rA6coqamFp53tWwtIzsIHcf05U46j7po
        7bVU/VuD+wz5KtXHUfT/r5UJRzwIj+AqZuyPn59/FJ431WkS8fsis=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E81C140EA7;
        Wed, 17 Aug 2022 14:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB3A9140EA6;
        Wed, 17 Aug 2022 14:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
        <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
        <xmqqh72ayeru.fsf@gitster.g>
        <bc923a75-7d60-1199-40cd-9d5067d6511c@github.com>
        <e719d1e1-1849-07bc-ea08-2729985e5048@github.com>
Date:   Wed, 17 Aug 2022 11:47:23 -0700
In-Reply-To: <e719d1e1-1849-07bc-ea08-2729985e5048@github.com> (Derrick
        Stolee's message of "Wed, 17 Aug 2022 13:43:54 -0400")
Message-ID: <xmqqlermwvus.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08FB3DA4-1E5D-11ED-A797-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> It is a bit unintuitive, but '--sparse' is already used to mean "operate on
>> SKIP_WORKTREE entries (i.e., pretend the repo isn't a sparse-checkout)" in
>> both 'add' (0299a69694 (add: implement the --sparse option, 2021-09-24)) and
>> 'rm' (f9786f9b85 (rm: add --sparse option, 2021-09-24)). The
>> 'checkout-index' option '--ignore-skip-worktree-bits' indicates similar
>> behavior (and is, IMO, similarly confusing with its use of "ignore").

OK, I forgot about these precedents.  "ignore skip worktree bits" is
quite a mouthful, but expresses what is going on quite clearly.
Instead of honoring the skip-worktree bit, behave as if they are not
set, so we bust the "sparse" boundary.

> The existing pattern here means that it isn't Shaoxuan's responsibility
> to pick a better name, but if we are interested in changing the name,
> then we have some work to replace the previous '--sparse' options with
> that name. I could do that replacement, assuming we land on a better name
> and are willing to have that change of behavior.

It all depends on how deeply the existing "--sparse" are anchored in
users' minds.  If we have been with them for nearly a year and three
major releases, it is too late to casually "fix" without a proper
transition strategy, I am afraid.  And I am not even sure if it is
worth the trouble.

In any case, let's leave it totally outside the scope of the topic.
As long as we are consistently unintuitive with "--sparse", then I
think we are OK, because users are malleable and can easily get used
to anything as long as it is consistent ;-)

Thanks.
