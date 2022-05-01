Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B91CC433F5
	for <git@archiver.kernel.org>; Sun,  1 May 2022 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348926AbiEAQRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348925AbiEAQRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 12:17:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABC53A48
        for <git@vger.kernel.org>; Sun,  1 May 2022 09:14:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9934A12D0C1;
        Sun,  1 May 2022 12:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfM56v8vLwUbCo9SLEtm1kQD2UsBY2UMqsFV/I
        USHds=; b=yCTpJeO52VGFqnXTEGfJM/l+nicW+6jdmsYRArg9Lkl+er1/dj41r5
        TdWEVbEFaLtB2ozzCM7zZn4IvmS13ZQH98EhcOvl5O8+3/a7izroxNxgBUo9nxiA
        fiJowbDuAfgzPWw1hCTbrQTEuzfJt6R2a14tXw1ryUH9vW8+Wt4qk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9210B12D0C0;
        Sun,  1 May 2022 12:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01E1D12D0BF;
        Sun,  1 May 2022 12:14:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
References: <xmqqczgy6zk5.fsf@gitster.g>
        <20220501155725.93866-1-chakrabortyabhradeep79@gmail.com>
Date:   Sun, 01 May 2022 09:14:17 -0700
In-Reply-To: <20220501155725.93866-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Sun, 1 May 2022 21:27:25 +0530")
Message-ID: <xmqqfslt44di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C11C691A-C969-11EC-A30D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Sorry for the late response.
>
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Three comments and a half on the code:
>>
>>  - Is it likely that to new readers it would be obvious that what is
>>    in the [square brackets] is the list-objects-filter used?  When we
>>    want to add new kinds of information other than the URL and the
>>    list-objects-filter, what is our plan to add them? 
>
> I do think that new readers can easily understand the meaning of the
> text inside the [square brackets]. These square brackets (with the
> list-objects-filter inside it) will be shown only if the remote is
> a promisor remote. So, users who don't use promisor remotes, will not
> be affected. Those who used the filters can only notice the change.
> They can easily understand it. In fact, I think it would give them an
> option to quickly check which are the promisor remotes and which are not.
> Though this change should be properly documented (which I forgot to
> add) so that they can be sure about it.

You forgot to answer more important half of the question.  It would
be easy for you to know what the string inside brackets means
because you are so obsessed with the promisor remote to write this
patch ;-) But when we need to add even more pieces of information in
the future, will it stay so?  Can "[some-random-string]" easily be
identified as a list-objects-filter by those who do not care
particularly about promisor remotes (e.g. those who wanted to see
the URL to tell multiple remote nicknames apart) when the line has
even more piece of information in the future?

At some point, we'd need to either (1) stop adding too many details
to avoid cluttering the output line, or (2) start labeling each
piece of information to make it easy for the readers to identify
which one is which [*].  We need to ask ourselves why now is not
that "some point" already.

    Side note: and the strategy to add new pieces of information
    need to take the same approach between the two, and that is why
    we need "what is the plan to add new pieces of information?"
    answered.

> (i.e. which are promisor remotes and which are not) one by one. If the
> user try to search for the promisor remotes in the config file, he/she
> have to go through the other configuration settings (irrelevant to him/her
> at that time) to reach the `[remote]` section. Isn't it?

Sorry, but the question does not make much sense to me.  Why is a
piece of information you get from "git config" irrelevant if you get
it in order to figure out what you want to know, i.e.  what promisor
remote do we rely on?

>> ...  If
>> it makes sense to add the extra <list-objects-filtrer> information,
>> that would mean that there are probably two remote nicknames that
>> refer to the same URL (i.e. "remote -v" readers cannot tell them
>> apart without extra information), but how likely is that, I wonder?
>
> I think, having a proper documentation about the new changes is the
> answer to it.

The question is "what can readers achieve by having this extra
information in 'remote -v' output".  Do you have to duck the
question because you cannot answer in a simple sentence, and instead
readers must read reams of documentation pages?  I doubt it would be
that obscure.

I wanted to like the patch, the changed text is simple enough, but
quite honestly, the lack of clarity in the answers to the most basic
"why do we want this? what is this good for? how does this help the
users?" questions, I am not yet succeeding to do so.

Thanks.
