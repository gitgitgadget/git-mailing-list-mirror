Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E5C4167B
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354686AbiDZUO1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 26 Apr 2022 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354808AbiDZUOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:14:03 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B3712099
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:10:46 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23QKAjir080047
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Apr 2022 16:10:45 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Derrick Stolee'" <derrickstolee@github.com>
Cc:     "=?UTF-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        <git@vger.kernel.org>, <philipoakley@iee.email>, <me@ttaylorr.com>,
        "'Guy Maurel'" <guy.j@maurel.de>,
        "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <20220426183105.99779-1-carenas@gmail.com>        <9658dea7-d421-b238-113d-c7b83eca4569@github.com> <xmqqlevrr53n.fsf@gitster.g>
In-Reply-To: <xmqqlevrr53n.fsf@gitster.g>
Subject: RE: [RFC PATCH] git-compat-util: avoid failing dir ownership checks if running priviledged
Date:   Tue, 26 Apr 2022 16:10:40 -0400
Organization: Nexbridge Inc.
Message-ID: <04bb01d859a9$b759cb50$260d61f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKW87AjxA2cdMBJpUJ6sUXK7KFdYwLolO0XAcgZoLarX+Ws8A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 26, 2022 3:56 PM, Junio C Hamano wrote:
>Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks if
>running priviledged
>
>Derrick Stolee <derrickstolee@github.com> writes:
>
>>> Original discussion in :
>>>
>>>
>>> https://lore.kernel.org/git/4ef9287b-6260-9538-7c89-cffb611520ee@maur
>>> el.de/
>>
>> I agree that the idea behind this change is a good one. The escalation
>> of privilege isn't a huge concern when the "real" user is the same.
>> The only way to trick the root user here is to set an environment
>> variable, in which case they might as well modify PATH and be done
>> with it.
>
>How much do we really want to trust SUDO_UID or DOSA_UID are telling the
>truth, though?
>
>>> +	euid = geteuid();
>>> +	if (euid == ROOT_UID) {
>>> +		/* we might have raised our priviledges with sudo or doas */
>>
>> Similar spelling error here.
>>
>>> +		const char *real_uid = getenv("SUDO_UID");
>>> +		if (real_uid && *real_uid)
>>> +			euid = atoi(real_uid);
>>> +		else {
>>> +			real_uid = getenv("DOAS_UID");
>>> +			if (real_uid && *real_uid)
>>> +				euid = atoi(real_uid);

This should be strtol() instead of atoi(). Putting garbage into DOAS_UID might end up causing some unwanted effects since atoi() could then return 0 or some partial value. The result should also be checked for sanity and the end pointer should point to a '\0'. My team has effectively banned the use of atoi() in new code and is migrating to strtol() or strtoll() as code is touched.

>>> +		}
>>
>> I imagine that something else could be added here to help Windows
>> users who have elevated to administrator privileges. It will use a
>> completely different mechanism, though, if needed at all. We can delay
>> that for now.
>>
>> Thanks,
>> -Stolee

