Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0AEC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiFHTNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 15:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiFHTNo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 15:13:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41A28720
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 12:13:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2103312E928;
        Wed,  8 Jun 2022 15:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4NKkdYWyTv5xt5w/uPbdBoqRpmarnatdedOosv
        E9gK0=; b=T3cj+QcwLoJNOS54F+LePnewB2O4lO3vOw0CzFa37qqM5RKXO8CyJP
        NVDu5HYvw0YpWMCnq/UkzdBXKla6ZQ8BCgzmsmDsgHUN+FdA3dRuppMpkPgDsrpr
        aZm1WC+Gce6S2dmWJza7G4qBhi7GXfCDliUKANlZxOzmk1my5wTE0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 177D112E927;
        Wed,  8 Jun 2022 15:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E6A612E926;
        Wed,  8 Jun 2022 15:13:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule merge: update conflict error message
References: <20220606235449.2890858-1-calvinwan@google.com>
        <xmqqh74x1eol.fsf@gitster.g>
        <CAFySSZC0ieObo=CzhoHiqrcdv3335VaRBtYMLFe9oEJ0hucOCA@mail.gmail.com>
        <kl6l8rq76oub.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAFySSZBV8r1PuLb7br90VHbHmXgdgW2Ta4qw07BN9SXvh=aFpw@mail.gmail.com>
Date:   Wed, 08 Jun 2022 12:13:38 -0700
In-Reply-To: <CAFySSZBV8r1PuLb7br90VHbHmXgdgW2Ta4qw07BN9SXvh=aFpw@mail.gmail.com>
        (Calvin Wan's message of "Wed, 8 Jun 2022 11:01:00 -0700")
Message-ID: <xmqqy1y7q87x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A922012-E75F-11EC-ABBB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> The user probably
>> wants to merge the submodules, but they can choose however they want to
>> resolve the merge conflict
>
> It sounds like I should reword "merge conflicted submodules" to
> "resolve conflicted submodules". That should cover those 10% cases.
>
> I would prefer to find a generic, but still helpful message that doesn't
> require going into the advice() API or require some config change

We want the users not to blow away the half-merged state in the
working tree.  We are guiding them to first go into submodules and
merge (in which case, we should tell them merge what with what---I
think the first parent should be what they have checked out there,
but the other parent, which is what is recorded in the tree of the
superproject commit being merged as gitlink, may not be at the tip
of any branch you have in the submodule).  And then they come back
to the superproject and resolve the conflict in the working tree and
the index.

> > Failed to merge submodule <submodule>
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Automatic merge failed; recursive merging with submodules is currently
> > not supported. To manually merge, merge conflicted submodules first
> > before merging the superproject.

So,

    to manually complete the merge:
    - go to submodule A, and merge commit a24c4e37d0
    - go to submodule B, and merge commit a6f14c960b
    - come back to superproject, and "git add A B" to record the above merge
    - in superproject, resolve the other conflicts
    - commit the resulting index in the superproject

or something along that line, perhaps?



