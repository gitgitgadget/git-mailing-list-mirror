Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF0C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 23:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiEWXgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 19:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiEWXgl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 19:36:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1717CB48
        for <git@vger.kernel.org>; Mon, 23 May 2022 16:36:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DEC1178C82;
        Mon, 23 May 2022 19:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mRrv6OZXabCO009qHTtvhqpVU9u9dPNPub6fE2
        JJbYI=; b=md+ja5gj07rS42AxfGocbm+q5aWZut/pPCnn4omuhuMH8PvLWhqpg7
        bIdfpW8HqTE5vk9T/UZByMkmlhIt2kiaJUQhUiyaBlmAeiaiKoeW56YTfUyQ22RQ
        stkND+5QYzSERn6offN3o4Rim8K7XySe9vxNrWkfSV3nUZ2XGsfX4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56205178C80;
        Mon, 23 May 2022 19:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F38B0178C7F;
        Mon, 23 May 2022 19:36:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
Date:   Mon, 23 May 2022 16:36:34 -0700
In-Reply-To: <xmqqr14jluu4.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        23 May 2022 15:58:43 -0700")
Message-ID: <xmqqleurlt31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F7A0ABE-DAF1-11EC-95EA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> I stumbled over the need for this while investigating the build failures
>> caused by upgrading Git for Windows' SDK's GCC to v12.x.
>>
>>> diff --git a/http.c b/http.c
>>> index 229da4d148..85437b1980 100644
>>> --- a/http.c
>>> +++ b/http.c
>>> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slot)
>>>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>>>  		}
>>>  	}
>>> +
>>> +	if (slot->finished == &finished)
>>> +		slot->finished = NULL;
> ...
> I have a feeling that we've mentioned that at least twice (perhaps
> three times) in the recent past that it is in essense reverting what
> the "finished" change baa7b67d (HTTP slot reuse fixes, 2006-03-10)
> did.  We used to use the in-use bit of the slot as an indicator that
> the slot dispatched by run_active_slot() has finished (i.e. the
> in-use bit must be cleared when the request held in the struct is
> fully done), but that broke when a slot we are looking at in
> run_active_slot() is serviced (which makes in_use false), and then
> another request reuses the slot (now no longer in_use), before the
> control comes back to the loop.  "while (slot->in_use)" at the
> beginning of the loop was still true, but the original request the
> slot was being used for, the one that the run_active_slot() function
> cares about, has completed.

Given that the breakage we fixed in 2006 is about run_active_slot()
calling step_active_slots() repeatedly, during which this and other
requests in flight completes when curl_multi_perform() receives and
handles responses, and recursively ends up calling run_active_slot()
for _another_ request reusing the slot we are interested in in the
codepath in the above disccussion, I _think_ we do not have to
consider the case where slot->finished is pointing at somebody
else's finished variable on stack here.  Yes, while we repeatedly
call step_active_slots(), our request in the slot may complete, the
slot may be marked as unused, somebody else may reuse the slot,
marking it as in_use again and using slot->finished pointer to their
on-stack finsihed.  But that somebody else's invocation of
run_active_slot() will not give control back before their on-stack
finished indicates that their recursive call to step_active_slots()
completes their request.  So after they come back and we exit our
while() loop, either slot->finished points at our finished if slot
did not get reused, or it points at an unused part of the stack that
has long been rewound when we returned from the recursive call.  In
either case, slot->finished never points at an on-stack address of
an ongoing run_active_slot() call made by somebody else that the
guard I added (i.e. we must only clear it if it points our on-stack
"finished") was trying to protect against clobbering.

So, I guess an unconditional assignment of

	slot->finished = NULL;

there would be sufficient.
