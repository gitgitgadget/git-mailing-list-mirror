Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A24C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 18:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386889AbiEGSqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386878AbiEGSqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 14:46:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858D1EEE2
        for <git@vger.kernel.org>; Sat,  7 May 2022 11:42:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FA6D18FC05;
        Sat,  7 May 2022 14:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HELhGYGTVvOO
        P2Dpl958cYo9WRaTNpa5Hv5HXuAIs64=; b=dhqXNO47wixKY+Cy+xZ40kkDqxjj
        axFVEi6fYKgdmxT7lO2zN5Zt1oe80xkqJ0K2Wl1c0x6upIHv+EyQUCRspSl8bZXk
        0iSKdC8pGZnBl3z+lSpq12V+MiURoefxkhehOrRpXsPu5f6kF+jYvVcUDVsp70/I
        UY5cUN3uwy13fMo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38BAE18FC04;
        Sat,  7 May 2022 14:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD12218FBC2;
        Sat,  7 May 2022 14:42:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <20220507054017.fnvb6xisr6s7m2l5@carlos-mbp.lan>
Date:   Sat, 07 May 2022 11:42:15 -0700
In-Reply-To: <20220507054017.fnvb6xisr6s7m2l5@carlos-mbp.lan> ("Carlo
 Marcelo
        Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 6 May 2022 22:40:17
 -0700")
Message-ID: <xmqq4k21gp6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B3A04F0-CE35-11EC-8CA7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Fri, May 06, 2022 at 02:17:01PM -0700, Junio C Hamano wrote:
>> diff --git a/http.c b/http.c
>> index 229da4d148..85437b1980 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot =
*slot)
>>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>>  		}
>>  	}
>> +
>> +	if (slot->finished =3D=3D &finished)
>> +		slot->finished =3D NULL;
>
> I am not completely sure yet (since I looked at it long ago and got
> sidetracked) but I think this might be optimized out (at least by gcc12=
)
> since it is technically UB, which is why it never "fixed" the warning.

UB meaning "undefined behaviour"?  Which part is?  Taking the
address of an on-stack variable "finished"?  Comparing it with a
pointer that may or may not have been assigned/overwritten elsewhere
in a structure?  Not clearing the member in the struct unconditionally?

Puzzled.
