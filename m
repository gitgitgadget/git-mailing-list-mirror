Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0933EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 01:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383720AbiDUB4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 21:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357029AbiDUB4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 21:56:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7515739
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 18:53:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5101818A346;
        Wed, 20 Apr 2022 21:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=uUD9Kvll9neaf1xo6gOSmzqRejOEenBlfi3XfacjhQ4=; b=XUNS
        cENWqFm2Q6+4B66T/eQ3y0Zl7O6oJA75ekrQB/dnt8JCTyjncW/l5cDrQLoAguE1
        PN3PMUvplbMT2gXShx0i0eTYKc+RARyiDeLVeZvcpRAGuy0I5i75az0lbH7uCIx9
        3+0kXYyRlAfP3EcUY6/hye0Cl5+wwKeKnyS8+lc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3456B18A345;
        Wed, 20 Apr 2022 21:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A02F518A342;
        Wed, 20 Apr 2022 21:53:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for
 matching branches
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
        <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
        <Yl2qwO0SMPOhb5h9@google.com>
        <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
        <xmqqczhbr6pv.fsf@gitster.g>
        <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
Date:   Wed, 20 Apr 2022 18:53:24 -0700
Message-ID: <xmqqlevzkxrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D52EBFD6-C115-11EC-8AAC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> If they branched from a different-name remote branch (they created an
> new / independent local branch), then no remote tracking relationship
> will have been set up, and instead of the "fatal: The upstream branch
> of your current branch does not match
> the name of your current branch" error and advice, they will get a
> much simpler error and advice:
>
> ---
> fatal: The current branch whatevs has no upstream branch.
> To push the current branch and set the remote as upstream, use
>
>     git push --set-upstream origin whatevs
> ---
>
> When they follow those instructions, they will be in the "simple"
> setup same as if they had just branched from same-name.

Which means that they need to see an error once, offered to either
set push.default or branch.autosetupmerge (it is not "and/or", but
"or", because you want to tell them to set "instead of push.default,
set branch.autosetupmerge"), and if they follow the latter, they have
to then hit a different error and be told to do the "set-upstream"
individually.  I am wondering if that is more irritating than it is
worth.  Instead, if you tell them to use branch.autosetupmerge=simple
and use push.default to something better than simple, wouldn't that
cover more cases and give fewer roadblocks to the end-user with
unnecessary errors?

>> Setting the latter to 'simple'
>> means there are *MORE* branches that do not have .remote/.merge set
>> up, doesn't it?  Which in turn means that we are relying more on
>> what push.default is set to, right?
>
> No

Why no?  if setupauto is yes, then any new branch forked from a
remote-tracking branch will get .remote/.merge set up, and with these
specific configuration they can "push" back to the configured place.
If it is set to simple, only new branches forked from a remote-tracking
branch that happens to have the same name will get it, and others do
not get .remote/.merge set up.  Which means user's "git push" will then
consult push.default settings, and setting it right becomes more 
important, no?

