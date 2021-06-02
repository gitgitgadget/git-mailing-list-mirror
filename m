Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BCBC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 02:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2758613BE
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 02:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFBCeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 22:34:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54603 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhFBCeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 22:34:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A565C95D9;
        Tue,  1 Jun 2021 22:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+fV/M8Q8k5L26RBZdJSABwJxvqkkUjEeNhRoHn
        FPPlU=; b=cml3GFBerlo/jStV0Rje265yvOd41QNR+lNMOZ8A2qGo6ONTkiokur
        bP+heuYtVwsJnHudcwQf0qautYYuoJm/lZjCLvOJEFFHzvEGrxUvsz1ZbFylGBpt
        3fZuPnGDjNHiHauCqxXIJJvQq3wmCErYw7d55v5DX++k3IBZqP8G8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 420AFC95D8;
        Tue,  1 Jun 2021 22:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C31A5C95D6;
        Tue,  1 Jun 2021 22:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Tim Renouf <tpr.ll@botech.co.uk>, newren@gmail.com,
        dstolee@microsoft.com, git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: add core.sparseCheckoutRmFiles config
References: <20210601183106.3084008-1-tpr.ll@botech.co.uk>
        <f6d39636-308c-c846-55b5-3f16a155e69d@gmail.com>
Date:   Wed, 02 Jun 2021 11:32:53 +0900
In-Reply-To: <f6d39636-308c-c846-55b5-3f16a155e69d@gmail.com> (Derrick
        Stolee's message of "Tue, 1 Jun 2021 22:00:50 -0400")
Message-ID: <xmqqmts9q9m2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D547EAAC-C34A-11EB-BDFC-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> This commit adds the above config item, defaulting to "true" to get the
>> old behavior. Set it to "false" to avoid removing such a file from the
>> worktree.
>
> I don't think config is necessary here. This behavior is niche
> enough to create a behavior-breaking change. However, we do want
> to ensure that the full flow of eventually clearing the file when
> clean is handled.

I didn't have a chance to get around to commenting on the patch
(instead I was preparing for -rc3), but you covered pretty much
everything I wanted to say.  It is unusual for those who are using
sparse checkout to have a modified (=tracked and dirty) file that
shouldn't be there, and making sure the user notices these unusual
files, instead of silently losing the changes to them, is probably a
"bugfix".

An explicit request to destructively overwrite the path ("git
restore -- path") or remove the working tree file along with
modification ("git reset --hard") is a good thing to have, but
the branch switching "git switch" is supposed to preserve local
modification (or fail to switch), whether the dirty path is inside
or outside the sparse checkout area.

> If we _are_ going to go with a config option, then I'm not a big
> fan of this name. I've also been thinking that the sparse-checkout
> config has been squatting in the "core.*" space too long. Perhaps
> it is time to create its own section?
>
> What about something like sparseCheckout.keepDirtyFiles, which
> defaults to false?

What about not having a configuration?

> 1. How does a user with a dirty, tracked, sparse file get back
>    into a state where that file is deleted? What commands do
>    they need to run? Can that be tested and added to the sparse-
>    checkout documentation?
>
> 2. What does 'git status' look like when a user is in this state?
>    Is that helpful?

Good points.

Thanks.
