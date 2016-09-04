Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035541F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbcIDQeI (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:34:08 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43184 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbcIDQeH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 12:34:07 -0400
Received: from [10.0.2.15] ([209.93.82.95])
        by avasout07 with smtp
        id fUX81t00323PrXV01UX9gp; Sun, 04 Sep 2016 17:31:23 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CYlK3/jl c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=dIu3SnmMAAAA:8
 a=SbOkhUo7pqfvw8taOL4A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=nJcEw6yWrPvoIXZ49MH8:22 a=Ua9G7VpiFza3u12uuhVB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v13 10/14] apply: change error_routine when silent
To:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-11-chriscool@tuxfamily.org>
 <CAGZ79kbdoF-1=ZBZG8y3sEz6LVaNP4Ou+KVk+=M7y9PSzQ1J0Q@mail.gmail.com>
 <CAP8UFD2Lwd_1+cWT702deF8=iFmBRKCi9gLSOizPbyLmeKepsw@mail.gmail.com>
 <CAP8UFD38CC-Ah9zVcnU3a4nGH2CzOn74Adx=42pmckjPv=e_Bg@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e39d9b83-949b-075c-07f6-60118dc24961@ramsayjones.plus.com>
Date:   Sun, 4 Sep 2016 17:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD38CC-Ah9zVcnU3a4nGH2CzOn74Adx=42pmckjPv=e_Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/09/16 11:54, Christian Couder wrote:
> On Thu, Sep 1, 2016 at 10:19 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Thu, Sep 1, 2016 at 12:20 AM, Stefan Beller <sbeller@google.com> wrote:
>>> On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>> To avoid printing anything when applying with
>>>> `state->apply_verbosity == verbosity_silent`, let's save the
>>>> existing warn and error routines before applying, and let's
>>>> replace them with a routine that does nothing.
>>>>
>>>> Then after applying, let's restore the saved routines.
>>>>
>>>> Helped-by: Stefan Beller <sbeller@google.com>
>>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>>> ---
>>>>  apply.c | 21 ++++++++++++++++++++-
>>>>  apply.h |  8 ++++++++
>>>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/apply.c b/apply.c
>>>> index ddbb0a2..bf81b70 100644
>>>> --- a/apply.c
>>>> +++ b/apply.c
>>>> @@ -112,6 +112,11 @@ void clear_apply_state(struct apply_state *state)
>>>>         /* &state->fn_table is cleared at the end of apply_patch() */
>>>>  }
>>>>
>>>> +static void mute_routine(const char *bla, va_list params)
>>>
>>> Instead of 'bla' you could go with 'format' as the man page for
>>> [f]printf puts it.
>>> Or you could leave it empty, i.e.
>>>
>>>     static void mute_routine(const char *, va_list)
>>>     ...
>>
>> Ok to do that.
> 
> Actually I get the following error when doing that:
> 
> apply.c: In function ‘mute_routine’:
> apply.c:115:1: error: parameter name omitted
>  static void mute_routine(const char *, va_list)
>  ^
> apply.c:115:1: error: parameter name omitted
> make: *** [apply.o] Error 1

Yes, this is not C++. ;-)

> So I will leave it as is.

I think I would prefer to see:

    static void mute_routine(const char *msg, va_list params)

given that it would either be an error-msg or a warning-msg.

ATB,
Ramsay Jones

