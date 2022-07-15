Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E9C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 20:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiGOUKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 16:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGOUKO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 16:10:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B6C4C625
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 13:10:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6223419F434;
        Fri, 15 Jul 2022 16:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QBs5J33pw2PU/7ABsc6pUizXqX5OKKQEmnIr2t
        op3zU=; b=BgLafQ1sutTJ2K6P7yLzRCzbNIWz0BjbwbJrV4CR89a7wF9u7MBxMp
        b9vGDsUKzdbUt9XoJYMW5qkXmnA7Hz/awSZpRB3K5K6aEvG9EvwPhi/xEYV8L0fC
        B0gUN2FHS+h1yQOEAEFoWDSbM9RSZMo2zAHdsRazbX6RZ2viNAEiA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AD7019F433;
        Fri, 15 Jul 2022 16:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB71919F424;
        Fri, 15 Jul 2022 16:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
References: <20220715190956.2908637-1-jonathantanmy@google.com>
Date:   Fri, 15 Jul 2022 13:10:04 -0700
In-Reply-To: <20220715190956.2908637-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 15 Jul 2022 12:09:56 -0700")
Message-ID: <xmqqfsj2yw6b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E2D926E-047A-11ED-8CAA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> >> This is implemented for protocol v0, v1, and v2.
>> 
>> Is that different to say "for all protocols"?  I am wondering if it
>> is worth saying (unlike in a hypothetical case where we do not
>> support v0 and v1 we may want to state why we only support v2).
>
> I wrote it that way to avoid confusion with things like HTTP (which is a
> protocol, at least in its name). Maybe better would be "This is
> implemented for all protocols (v0, v1, and v2)".

I still wonder if it is better left unsaid.  When adding a new
thing, it would not be noteworthy if the new thing is available no
matter what protocol is being used, no?

>> >> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
>> >>   		packet_buf_write(&req_buf, "filter %s", spec);
>> >> +	} else {
>> >> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");
>> 
>> Do we show "none" anywhere else where an expanded list objects
>> filter spec is expected?
>
> Hmm...no, we don't.
>
>> I am wondering two things: 
>> 
>>  - The lack of this line would be a cleaner implementation of a
>>    signal to say "this client did not ask any filtering".
>
> I think the presence is important to distinguish "no filtering" versus
> someone using an old Git version that does not emit such traces, but I'm
> open to changing the "none" to "none-specified" or something like that.

OK.

>>  - It would be good if we keep what report here more-or-less the
>>    same as what we can pass "--filter=" on the command line of
>>    "git pack-objects".
>
> My intent is to report what is being sent to the server in the fetch
> request.

Then I'd be OK with a design that reports "none", if we send "none"
to the server in this case.  If not, then I do not think we should.

Perhaps report an empty string or not reporting at all?  After all,
the reader knows the client version and capability in the log so it
is easy to tell between 'no filter was used' and 'too old to report
the filter', no?  I dunno.



