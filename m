Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B55C433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 00:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiFGAsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiFGAst (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 20:48:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120EBA553
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 17:48:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6ADD519238E;
        Mon,  6 Jun 2022 20:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DuMcrzVuFAf7F8LRzy677ltTnm947b/XQ6ivrM
        LZ+0g=; b=DzE3eZ817eHwXqHnnsZowO/tNLH6ZuW1/O3AKGMmqT6+G9YHnBQpqW
        EIcRsc7tFLy9BBaksAX+UaS1gzRM7M2ZzyTHnTMHeLFlk6EF6ZEDNmP9gx0ct27c
        zSKltT0MMq6LMFYAOR3aVlP9DsuZwE28XUSoZG5CMjNBCunTd5DaM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63D1319238D;
        Mon,  6 Jun 2022 20:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D866319238B;
        Mon,  6 Jun 2022 20:48:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com
Subject: Re: [PATCH] submodule merge: update conflict error message
References: <20220606235449.2890858-1-calvinwan@google.com>
Date:   Mon, 06 Jun 2022 17:48:42 -0700
In-Reply-To: <20220606235449.2890858-1-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 6 Jun 2022 23:54:49 +0000")
Message-ID: <xmqqh74x1eol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 957A525A-E5FB-11EC-A9D9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> When attempting to do a non-fast-forward merge in a project with
> conflicts in the submodules, the merge fails and git prints the
> following error:
>
> Failed to merge submodule <submodules>
> CONFLICT (submodule):Merge conflict in <submodule>
> Automatic merge failed; fix conflicts and then commit the result.
>
> Git is left in a conflicted state, which requires the user to:
>  1. abort the merge
>  2. merge submodules
>  3. merge superproject
> These steps are non-obvious for newer submodule users to figure out

Hmph.  Is 1. necessary?

IOW, based on the information we already have (we may not be
surfacing, which can be corrected), wouldn't it be easier to instead
(A) go to submodule and make a merge and then (B) come back to the
superproject, "git add <submodule" to record the result of submodule
merge, and say "git commit" to conclude?

The thing I am worried most about is that you may be throwing away
information that would help the user by aborting the superproject
merge.  Before doing so, you have stage #2 and stage #3 of the
submodule commit, so which commits in the submodule you need to
merge in (A) above should be fairly clear.  If you abort the merge
first, how does the user know which commits in the submodule the
user needs to merge?

> The error message is based off of what would happen when `merge
> --recurse-submodules` is eventually supported

OK.

> Failed to merge submodule <submodule>
> CONFLICT (submodule): Merge conflict in <submodule>
> Automatic merge failed; recursive merging with submodules is currently
> not supported. To manually merge, the following steps are recommended:
>  - abort the current merge
>  - merge submodules individually
>  - merge superproject

Again, I am not sure about the recommendation.  The message saying
"currently not supported" I think is a good idea.

> I considered automatically aborting the merge if git detects the merge
> failed because of a submodule conflict, however, doing so causes a
> significant amount of tests in `t7610-mergetool.sh` (and some other test
> scripts as well) to fail, suggesting users have come to expect this
> state and have their workarounds with `git mergetool`

With or without test failures, my gut feeling sais that it cannot be
a good idea to automatically abort the merge, without first grabbing
some information out of the conflicted state.

Thanks.
