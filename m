Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198DC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhLTTuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:50:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63925 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhLTTuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:50:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E61F710F4D5;
        Mon, 20 Dec 2021 14:50:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4VVqhQ2pb4WvfJGoNf59BE8KZ5O+AIXD/tJFIv
        YJcDk=; b=S5eTWjvkI6pHXNITeHKNhl1Q5gyly1woYm1zmMSA9H1A8vZk1h7+J/
        tAtYR5uhmibIxvVNcilv3qEJScNTsi2X6e/RzRX6pYIR8NhC3+fYZM4sndHf5rJb
        2pPLewekxwn4PYa0eubTt/SFvAfaR5Mq49TY8hmLef6pwvWlMC/TI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B4C610F4D0;
        Mon, 20 Dec 2021 14:50:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08E5110F4CF;
        Mon, 20 Dec 2021 14:50:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v5 0/5] implement branch --recurse-submodules
In-Reply-To: <kl6lwnjzytyl.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 20 Dec 2021 11:09:06 -0800")
References: <20211216003213.99135-1-chooglen@google.com>
        <20211216233324.65126-1-chooglen@google.com>
        <xmqq35ms6pd3.fsf@gitster.g> <xmqqwnk45aah.fsf@gitster.g>
        <kl6lwnjzytyl.fsf@chooglen-macbookpro.roam.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Mon, 20 Dec 2021 11:50:04 -0800
Message-ID: <xmqq8rwfvyxf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07A0A030-61CE-11EC-B024-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> What happened was that I got confused by [1], where it reads:
>
>   [...]
>   find the tip of js/branch-track-inherit from 'seen' [*]
>   [...]
>
>   [Footnote]
>
>   * One way to do so would be:
>
>     $ git fetch
>     $ git show 'remote/origin/seen^{/^Merge branch .js/branch-track-inherit.}'
>
> The commit that I got was the "merge of js/branch-track-inherit into
> 'seen'", but what you intended was the "merge of js/branch-track-inherit
> into gc/branch-recurse-submodules"; I didn't realize that there might
> have been more than commit matching that regex.

Yeah, that was not quite clearly written.  The way it was showing
was to find the tip of the other branch.  The instruction was to
prepare you (and others reading from the sidelines) for a case where
your branch depends on somebody else's work that is *not* even in
'seen' (e.g. I may have an older version of 'seen' but there is a
newer and clearly improved version on the list that is likely to
replace).  In such a case, you'd 

 (1) "find" the tip of the other branch, either by traversing from
     the tip of 'seen' to find the merge and taking its second
     parent, or applying the latest from the list to a locally
     created topic branch forked off of 'main',

 (2) create your topic branch, forked off of 'main', and merge (1)
     into it, and

 (3) build your series on it.

If I have your previous round, and if the other topic you depend on
hasn't changed, you can omit (2) and instead find the equivalent of
(2) I created for your topic the last time I queued it.

> I made some commit message changes. Unless you think it's a good idea, I
> won't re-roll this to fix the issue.

Let's not waste your message changes to clarify the patches.

> So if my branch were not in 'seen', I should have based my changes on
> 'origin/js/branch-track-inherit'. If my branch is in 'seen', I should
> base it off the merge of js/branch-track-inherit' into my my branch?

Hopefully the above is clear now?  Sorry for the trouble.

Thanks.

