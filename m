Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401391F461
	for <e@80x24.org>; Thu,  4 Jul 2019 21:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfGDVyb (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 17:54:31 -0400
Received: from mail-gateway-shared10.cyon.net ([194.126.200.61]:46112 "EHLO
        mail-gateway-shared10.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfGDVyb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Jul 2019 17:54:31 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared10.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1hj9gQ-0001eI-BA
        for git@vger.kernel.org; Thu, 04 Jul 2019 23:54:28 +0200
Received: from [10.20.10.233] (port=17892 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1hj9gP-00015o-3o; Thu, 04 Jul 2019 23:54:25 +0200
Subject: Re: [PATCH 1/2] mingw: get pw_name in UTF-8 format
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.147.git.gitgitgadget@gmail.com>
 <54fff4ef40d1dba2153de27413fb53e992228b5b.1561628237.git.gitgitgadget@gmail.com>
 <9bd9efde-8971-08f2-8417-1036286c9d1a@drbeat.li>
 <nycvar.QRO.7.76.6.1907042350510.44@tvgsbejvaqbjf.bet>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <1ab5bb1e-140a-cee1-0910-33e495cde11e@drbeat.li>
Date:   Thu, 4 Jul 2019 23:54:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907042350510.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 04.07.19 23:52, Johannes Schindelin wrote:
> Hi Beat,
> 
> On Thu, 4 Jul 2019, Beat Bolli wrote:
> 
>> On 27.06.19 11:37, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> Previously, we would have obtained the user name encoded in whatever the
>>> current code page is.
>>>
>>> Note: the "user name" here does not denote the full name but instead the
>>> short logon name.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>  compat/mingw.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index 9b6d2400e1..8526876262 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> @@ -1946,13 +1946,19 @@ struct passwd *getpwuid(int uid)
>>>  	static unsigned initialized;
>>>  	static char user_name[100];
>>>  	static struct passwd *p;
>>> +	wchar_t buf[100];
>>>  	DWORD len;
>>>
>>>  	if (initialized)
>>>  		return p;
>>>
>>> -	len = sizeof(user_name);
>>> -	if (!GetUserName(user_name, &len)) {
>>> +	len = sizeof(buf);
>>
>> I think this should be "len = sizeof(buf) / sizeof(buf[0])".
>>
>> GetUserNameW() takes the number of characters, not bytes.
> 
> Good catch.
> 
> How about I use `ARRAY_SIZE(buf)`? Since this is already in `next`, I will
> prepare a follow-up patch.

Of course, ARRAY_SIZE() is even better. I didn't remember it existed.

Cheers,
Beat

> 
> Ciao,
> Dscho
> 
>>
>>> +	if (!GetUserNameW(buf, &len)) {
>>> +		initialized = 1;
>>> +		return NULL;
>>> +	}
>>> +
>>> +	if (xwcstoutf(user_name, buf, sizeof(user_name)) < 0) {
>>>  		initialized = 1;
>>>  		return NULL;
>>>  	}
>>>
>>
>> Cheers,
>> Beat
>>

