Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8E4C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 19:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiDVTFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiDVTFs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 15:05:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC6713BD4A
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:56:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAFB0180B62;
        Fri, 22 Apr 2022 14:48:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VXWjkrhqthhMl27motWQJBcqzTol3hI5TLTzvY
        t+JIU=; b=s2o9QVCxn7KjxfPs7MC/9t558LRtEeCXvl7T+xLmVV7wCLT9AKr5cs
        0KO5Bu0SNhQaxjKvpXxiipYv2788qKKqJPNIOgFc/Q0nSM2ylHhsXFahTb7ylNAS
        PKsZeJTCJwQfhBJQEtt9XZ0dEI2BRIxNqfhB0sMSD+MQnumyBUMAo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3B47180B61;
        Fri, 22 Apr 2022 14:48:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 71361180B5F;
        Fri, 22 Apr 2022 14:48:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>, demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: git log --since to not stop after first old commit?
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu> <xmqq1qygy9nd.fsf@gitster.g>
        <Yk8Gvf/fjVca9hDB@vmiklos.hu> <xmqqv8vkpara.fsf@gitster.g>
        <xmqqtub3moa0.fsf@gitster.g>
        <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
        <xmqqilrfk14q.fsf@gitster.g>
Date:   Fri, 22 Apr 2022 11:48:45 -0700
In-Reply-To: <xmqqilrfk14q.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        11 Apr 2022 09:58:45 -0700")
Message-ID: <xmqqzgkd7y42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D739F928-C26C-11EC-BB70-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> When you do have the cycles perhaps it is worth considering whether
>> splitting it up, so that --as-filter is a modifier for traversal stoppers,
>> would avoid the problem of proliferating options.   Eg, instead of saying
>> --since-as-filter you would say --since ... --as-filter. That way the
>> stoppers where "filter like behavior" made sense could just check if the
>> --as-filter flag was set.
>
> Yes, that has exactly the opposite problem I wanted to warn us about
> by sending an extra message (to which you are reponding to).  If we
> have (or can have) very many traversal stopping option, it might
> make sense to have --as-filter as a modifier and avoid doubling the
> number of options, but if we only have very few (and fundamentally
> cannot have more than very few), then giving each of these very few
> --X its own --X-as-filter variant would probably make more sense.
> Because end users would probably not know which ones are inherently
> filters and will not be affected with --as-filter modifier, it would
> help them understand if we give them independent --since-as-filter
> option and document it separately, if there aren't many of them.
>
> Besides, if we had very few but still multiple of them, --X and
> --Y-as-filter can be combined to say "X stops as before, but Y is
> applied as filter", which is strictly more expressive than a
> separate --as-filter modifier.
>
> So that is why I threw out the message for those interested in the
> topic to first think about.  I know we agree that --since may be a
> good candidate to have these two flavours of behaviour.  I do not
> think anybody carefully thought about existing options to see if
> there are many like --since that want two flavours, let alone
> possible options we have said in the past that we may want to have
> but not yet added.

Now I had some time to think about it, I have a feeling that it is
quite unlikely for us to add traversal stopper other than since, so
having a separate "--as-filter" would probably be more confusing
than adding "--since-as-filter", stressing on "only the 'show
commits with timestamp after this one' has two variants".

Thanks.
