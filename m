Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B1C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075BF6509F
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCEXS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:18:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53598 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEXSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 18:18:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DEE3122CD4;
        Fri,  5 Mar 2021 18:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=oWLyrRtn8KqoXKdkDtwPtJQQ3mQ=; b=J54G+k
        hpl2TA3xdt6MniXIxDi4Z9KF1Yjdux+hmU/imWf3m66iHw/N7bu8FTKhUEeIcFCA
        /sjd8AL3bFyzEAxR8rqE+/kRd7xvgO301vHhFFOJkd3AUpwXqS5lkeSByEHPdztw
        GERB7XaX8fnJNT+WFa5XL5Leuq+E9bZ7LtuVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fOQkRxHNLDI6XeAb1oRZ5Nreg2uxaLJu
        ekGyJrjemfqVJBLqbw2JitJlcII/mpdxUVUMJIRUzYULOQmJo23mKXl0+m3vdgIU
        tjbKSRD9s0kkkkJBjSOJMeAniFTPRGypVi3t092qKXQNCoBPX5fyURIUXaGdUyH7
        +3YQWK6YmzU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76672122CD3;
        Fri,  5 Mar 2021 18:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 748E4122CD2;
        Fri,  5 Mar 2021 18:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
In-Reply-To: <20210305225953.739816-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 5 Mar 2021 14:59:53 -0800")
References: <xmqqzgzha0z5.fsf@gitster.c.googlers.com>
        <20210305225953.739816-1-jonathantanmy@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
Date:   Fri, 05 Mar 2021 15:18:11 -0800
Message-ID: <xmqqv9a58a18.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EE91DB2-7E09-11EB-A917-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I should probably have written more in the commit message to justify the
> unification, but it is also part of a bug fix (in particular,
> --fsck-objects wasn't being passed to the index-pack that indexed the
> packfiles linked by URI) and for code health purposes (to prevent future
> bugs by eliminating the divergence). So reverting that commit would
> reintroduce another bug.

Not necessarily.  Unifying two that do not inherently have to be
identical makes it impossible to pass two different things, and that
is what we are seeing in the bug this patch is trying to fix (by
forcing the two to be identical by eliminating the unpack-objects
codepath in certain cases).  

The right "fix" for the original bug would have been to keep them
still separate yet making it easy to pass args that must be used in
both of them, no?

>> > -		if (do_keep && (args->lock_pack || unpack_limit)) {
>> > +		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
>> >  			char hostname[HOST_NAME_MAX + 1];
>> >  			if (xgethostname(hostname, sizeof(hostname)))
>> >  				xsnprintf(hostname, sizeof(hostname), "localhost");
>> 
>> I do not quite get what this hunk is doing.  Care to explain?
>
> The "do_keep" part was unnecessarily restrictive and I used a band-aid
> solution to loosen it. I think this started from 88e2f9ed8e ("introduce
> fetch-object: fetch one promisor object", 2017-12-05) where I might have
> misunderstood what do_keep was meant to do, and taught fetch-pack to use
> "index-pack" if do_keep is true or args->from_promisor is true. What I
> should have done is to set do_keep to true if args->from_promisor is
> true. Future commits continued to do that with fsck_objects and
> index_pack_args.

> Maybe what I can do is to refactor get_pack() so that do_keep retains
> its original meaning of whether to use "index-pack" or "unpack-objects",
> and then we wouldn't need this line. What do you think (code-wise and
> whether this fits in with the release schedule, if we want to get this
> in before release)?

How bad is the breakage this one is trying to fix?  I know it would
only affect folks who have to interact with the server that uses
packfile URI feature, but do they have a workaround, perhaps with a
configuration knob or command line option to ignore the packfile
URI, and how large is the affected population?

I cannot shake the feeling that we are seeing band-aid on top of
band-aid forced by having chosen to go in a wrong direction in the
beginning X-<, and prefer to see the code drift even further into
the same direction; hence my earlier suggestion to go back to the
root cause by first reverting the wrong fix that introduced this bug
and fixing the original bug in a different way.

I dunno how involved the necessary surgery would be, though.  If
this is easy to work around, perhaps it might be a better option for
the overall project to ship the upcoming release with this listed as
a known breakage.

Thanks.



