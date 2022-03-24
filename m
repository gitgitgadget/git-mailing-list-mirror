Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB66C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 21:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354185AbiCXVfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiCXVfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 17:35:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F289B6E52
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 14:34:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 549F010630D;
        Thu, 24 Mar 2022 17:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1wdss03g31okcDCuBR8hUu5TIZOMYwGBRUy0v5
        4E0T4=; b=llA9xJWh70MR7zASHXb4aqnwRiihZgbcOlnkTpLIGGdS4JS3vhd8Sc
        eghoWpT/ieUhlXR9tavGGISfnXm7dc5dilRbc5xzMGrrwSgH6eFkeHCl0FRDWWgB
        E0DTPCgsj1wKOmTGVAuNv+Uxh3QniaYgj5BYy6VYYw1HrfRou6eSk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C94E10630C;
        Thu, 24 Mar 2022 17:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8EE3E106308;
        Thu, 24 Mar 2022 17:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 05/11] update-index: use the bulk-checkin infrastructure
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <913ce1b3df9cf273f1572c256dffad1cacc192a6.1648097906.git.gitgitgadget@gmail.com>
        <xmqqfsn7i594.fsf@gitster.g>
        <CANQDOdcuBRvWx7iMYBvLYEEb6A_=SURLAGumk026ZyDODpfAsQ@mail.gmail.com>
Date:   Thu, 24 Mar 2022 14:34:06 -0700
In-Reply-To: <CANQDOdcuBRvWx7iMYBvLYEEb6A_=SURLAGumk026ZyDODpfAsQ@mail.gmail.com>
        (Neeraj Singh's message of "Thu, 24 Mar 2022 13:25:38 -0700")
Message-ID: <xmqq8rszf31t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22B3AD1E-ABBA-11EC-A246-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> IOW, I am not sure end_if_active() should exist in the first place.
>> Shouldn't end_transaction() do that instead?
>>
>
> Today there's an "assert(bulk_checkin_plugged)" in
> end_odb_transaction. In principle we could just drop the assert and
> allow a transaction to be ended multiple times.  But maybe in the long
> run for composability we'd like to have nested callers to begin/end
> transaction (e.g. we could have a nested transaction around writing
> the cache tree to the ODB to minimize fsyncs there).

I am not convinced that "transaction" is a good mental model for
this mechanism to begin with, in the sense that the sense that it is
not a bug or failure of the implementation if two or more operations
in the same <begin,end> bracket did not happen (or not happen)
atomically, or if 'begin' and 'end' were not properly nested.  With
the design getting more complex with things like tentative object
store that needs to be explicitly migrated after the outermost level
of end-transaction, we may end up _requiring_ that sufficient number
of 'end' must come once we issued 'begin', which I am not sure is
necessarily a good thing.

In any case, we aspire/envision to have a nested plug/unplug, I
think it is a good thing.  A helper for one subsystem may have its
large batch of operations inside plug/unplug pair, another help may
do the same, and the caller of these two helpers may want to say

	plug
		call helper A
			A does plug
			A does many things
			A does unplug
		call helper B
			B does plug
			B does many things
			B does unplug
	unplug

to "cancel" the unplug helper A and B has.

> In that world,
> having a subsystem not maintain a balanced pairing could be a problem.

And in such a world, you never want to have end-if-active to
implement what you are doing here, as you may end up being not
properly nested:

	begin
		begin
			do many things
			if some condtion
				end_if_active
			do more things
		end
	end

> An alternative API here could be to have an "flush_odb_transaction"
> call to make the objects visible at this point.

Yes, what you want is a forced-flush instead, I think.

So I suspect you'd want these three primitives, perhaps?

 * begin increments the nesting level
   - if outermost, you may have to do real "setup" things
   - otherwise, you may not have anything other than just counting
     the nesting level

 * flush implements unplug, fsync, etc. and does so immediately,
   even when plugged.

 * end decrements the nesting level
   - if outermost, you'd do "flush".
   - otherwise, you may only count the nesting level and do nothing else,
     but doing "flush" when you realize that you've queued too many
     is not a bug or a crime.

