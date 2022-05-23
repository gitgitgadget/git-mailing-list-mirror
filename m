Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4CC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 22:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiEWW6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 18:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiEWW6u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 18:58:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181C1AF1F8
        for <git@vger.kernel.org>; Mon, 23 May 2022 15:58:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2B9F184650;
        Mon, 23 May 2022 18:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YnC2IjOcpsdEN4+fIar5jwRvLGE+GpclMRtpnm
        X90dQ=; b=eVWspxie7NHFa03YEZAgtRZ7icEDVjVzuQ2fV1WqCvwFPMvFE0bWwi
        xitTMKGbaMKvlCOwD3WExe8I4HkYhTWvR6aX6jsKR+NaH8QmXFd8PJG9dHg5IIpZ
        3pLpE/xMEhcfLejtPzDTML4WmygKHgNr6AvaP5jJH/Rc9uK8TI+MM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A70D18464F;
        Mon, 23 May 2022 18:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43CC218464E;
        Mon, 23 May 2022 18:58:44 -0400 (EDT)
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
Date:   Mon, 23 May 2022 15:58:43 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 23 May 2022 23:58:56 +0200 (CEST)")
Message-ID: <xmqqr14jluu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E56CEE3C-DAEB-11EC-9AE4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I stumbled over the need for this while investigating the build failures
> caused by upgrading Git for Windows' SDK's GCC to v12.x.
>
>> diff --git a/http.c b/http.c
>> index 229da4d148..85437b1980 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slot)
>>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>>  		}
>>  	}
>> +
>> +	if (slot->finished == &finished)
>> +		slot->finished = NULL;
>
> First of all, I suspect that
> https://github.com/git/git/blob/v2.36.1/http.c#L1207 makes sure that GCC's
> complaint is not actually accurate: we always re-set `finished` to `NULL`
> when getting an unused slot, so even if there is a left-over dangling
> pointer, it is not actually used, ever.
>
> But we need something to pacify GCC. Let's look at your patch.
>
> The first thing to note is that this is not _quite_ thread-safe: between

Does this part of the code ever run multi-threaded?

> If that analysis is correct, I would expect the correct solution to turn
> `finished` into an attribute of the slot, and change its role to be a flag
> that this slot is spoken for and cannot be re-used quite yet even if it is
> not currently in use.

I have a feeling that we've mentioned that at least twice (perhaps
three times) in the recent past that it is in essense reverting what
the "finished" change baa7b67d (HTTP slot reuse fixes, 2006-03-10)
did.  We used to use the in-use bit of the slot as an indicator that
the slot dispatched by run_active_slot() has finished (i.e. the
in-use bit must be cleared when the request held in the struct is
fully done), but that broke when a slot we are looking at in
run_active_slot() is serviced (which makes in_use false), and then
another request reuses the slot (now no longer in_use), before the
control comes back to the loop.  "while (slot->in_use)" at the
beginning of the loop was still true, but the original request the
slot was being used for, the one that the run_active_slot() function
cares about, has completed.

So...
