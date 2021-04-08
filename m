Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F3FC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074CA61106
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhDHWq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:46:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62326 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhDHWq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:46:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 494631300BC;
        Thu,  8 Apr 2021 18:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fl9HxmFFJOnPtbgGZGhZliEWR10=; b=hbYbUY
        NI/pzDkBarewHCVwLNFtMrg0+ZXNtau/z/PCPoQQSg6w/la7YTPiU6JIL46nuqZC
        WI2qHpwT46ATvoSrM7+nTZQQGPLBEH5FyB5Wv8J4N8zk8V8o6CLa0nnkb7y73YZl
        H6o/AztRJrYPYXCYMZZ9M+Fmm23sP8rx/ozBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lned71wWJYNZxLw4/RLrbNkyUzz0xer+
        1GRfdU9F5gdD29f0xqYuh5t1dxvT0oFnAT1U6sTJhm0iUJ2x0NtpUfqkL46xcoRs
        W3Li56+H5Jbljakns5NNW6WHjlDONjhF9aAIog9lAqDHgjfRhkOr8rq4UPpItsgY
        ExDB4j8Caj4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43A861300BB;
        Thu,  8 Apr 2021 18:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 877EE1300B3;
        Thu,  8 Apr 2021 18:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks
 into a function
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
        <xmqqft0447lu.fsf@gitster.g> <xmqqpmz4qtxi.fsf@gitster.g>
Date:   Thu, 08 Apr 2021 15:46:40 -0700
In-Reply-To: <xmqqpmz4qtxi.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        08 Apr 2021 15:43:05 -0700")
Message-ID: <xmqqft00qtrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49E17B8A-98BC-11EB-99CF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> One big thing that is different between this version and the one in
>> Emily's "config hook" topic is that this is still limited to the
>> case where $repo exists.  In the new world order, it will not matter
>> in what directory the command runs, as long as "git hook" finds the
>> hook, and details of the invocation is hidden behind the command.
>>
>> I presume that Emily's series is expected to be updated soonish?
>> Please figure out who to go first and other details to work well
>> together between you two.
>
> Since I didn't hear from either of you, I'll queue with this
> possibly bogus conflict resolution for now.
>

Well, I retract it.  This makes many steps in send-email tests
fail.  For now, es/config-hooks topic is excluded from 'seen'.

What's the status of that topic, if there weren't other topics in
flight that interfere with it, by the way?  Is it otherwise a good
enough shape to be given priority and stable enough to get other
topics rebased on top of it?

Thanks.
