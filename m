Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32FAC433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 20:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348506AbiEQURp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbiEQURo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 16:17:44 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D7451E64
        for <git@vger.kernel.org>; Tue, 17 May 2022 13:17:41 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8D6313F4813;
        Tue, 17 May 2022 16:17:40 -0400 (EDT)
Received: from REPLICASERVER01.azshci.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3C7A03F4161;
        Tue, 17 May 2022 16:17:40 -0400 (EDT)
Subject: Re: [PATCH v6 20/28] fsmonitor: optimize processing of directory
 events
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten B??gershausen <tboegi@web.de>, rsbecker@nexbridge.com,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
 <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <48af0813deccab924d3591b4df025b17bf309260.1650662994.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2205121708400.352@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c716b1d6-a0a8-6d03-dfe5-70613e4ed942@jeffhostetler.com>
Date:   Tue, 17 May 2022 16:17:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2205121708400.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/12/22 11:08 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach Git to perform binary search over the cache-entries for a directory
>> notification and then linearly scan forward to find the immediate children.
>>
[...]

>>   static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>>   {
>>   	int i, len = strlen(name);
>> -	if (name[len - 1] == '/') {
>> +	int pos = index_name_pos(istate, name, len);
>> +
>> +	trace_printf_key(&trace_fsmonitor,
>> +			 "fsmonitor_refresh_callback '%s' (pos %d)",
>> +			 name, pos);
>>
[...]

>> +	if (name[len - 1] == '/') {
[...]
>>   	}

>> @@ -215,7 +253,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>>   	 * Mark the untracked cache dirty even if it wasn't found in the index
>>   	 * as it could be a new untracked file.
>>   	 */
>> -	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", name);
> 
> Did you mean to remove this statement in this patch? Not a big issue, but
> I wonder what the rationale for it is, and since I have an inquisitive
> mind, I figured I'd just ask.

I just moved it to the top of the function.  That lets me see `name`
before it is modified in one of the else arms (it was helpful to see
whether the daemon sent a trailing slash or not).  And I also wanted
to see the computed value of `pos` (before the "-pos - 1" tricks).

Jeff
