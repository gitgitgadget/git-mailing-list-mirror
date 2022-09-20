Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CFDECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 14:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiITOgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiITOf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 10:35:58 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF54B4A3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:35:57 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5BAE1CA126B;
        Tue, 20 Sep 2022 10:35:56 -0400 (EDT)
Received: from jeffhost-mbp.local (addr-66.249.231.194.nptpop-cmts01-cable-sub.rdns-bnin.net [66.249.231.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0191DCC8319;
        Tue, 20 Sep 2022 10:35:55 -0400 (EDT)
Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git directory
 is remote
To:     Eric DeCosta <edecosta@mathworks.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
        <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
 <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
 <075340bd2a713905d8bee4f53765dcbcba9a17c4.1663358014.git.gitgitgadget@gmail.com>
 <xmqqy1ujf5a9.fsf@gitster.g>
 <5c50a3cf-c5ac-6b11-2548-8400e5574b32@jeffhostetler.com>
 <xmqq35cnco3h.fsf@gitster.g>
 <40b47246-adb6-cf56-02ef-25ab1429a42e@jeffhostetler.com>
 <xmqq35cnb6fw.fsf@gitster.g>
 <BL0PR05MB557100B0802A8407C9CA55BFD94D9@BL0PR05MB5571.namprd05.prod.outlook.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <454ed375-471e-44b9-f636-d1992e4a3c34@jeffhostetler.com>
Date:   Tue, 20 Sep 2022 10:35:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BL0PR05MB557100B0802A8407C9CA55BFD94D9@BL0PR05MB5571.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/22 7:51 PM, Eric DeCosta wrote:
> 
> 
>> -----Original Message-----
>> From: Junio C Hamano <gitster@pobox.com>
>> Sent: Monday, September 19, 2022 1:49 PM
>> To: Jeff Hostetler <git@jeffhostetler.com>
>> Cc: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>;
>> git@vger.kernel.org; Eric Sunshine <sunshine@sunshineco.com>; Torsten
>> Bögershausen <tboegi@web.de>; Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com>; Ramsay Jones <ramsay@ramsayjones.plus.com>;
>> Johannes Schindelin <Johannes.Schindelin@gmx.de>; Eric DeCosta
>> <edecosta@mathworks.com>
>> Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git directory is
>> remote
>>
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>>
>>> Aren't we in the middle of a transition from always using the global
>>> "the_repository" to a passed "r" variable?
>>> We're getting closer to being able to hide the the global symbol, but
>>> we're not there yet, right?
>>
>> We may still have code that works ONLY on the_repository, but letting a
>> function take "r" and lettin it ignore is worse than leaving it explicitly limited
>> to the_repository only, no?
>>
>>> I'm thinking that at as long as the global exists, we are not safe to
>>> have multiple "struct repository" instances, right?
>>
>> By itself, Not at all.  It is the code like I am criticizing that makes it unsafe.
>>
>> I do not mind adding
>>
>> 	if (!r)
>> 		BUG(...);
>>
>> at the place you have the "sweep it under the rug" band-aid, though.
> 
> Appreciate all the insights and comments. Where are we landing with this? Very close to the finish line and I'd like to be able to push these changes over that line.
> 
> -Eric
> 

I'm OK doing it either way.  Junio seems to prefer the BUG() version,
so let's go with that.  That lets us make progress on getting rid of
direct references to "the_repository".

Jeff
