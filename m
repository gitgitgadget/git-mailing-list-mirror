Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24605C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 20:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiAMURf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 15:17:35 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:3261 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbiAMURf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 15:17:35 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4JZbMG5QK4z5tl9;
        Thu, 13 Jan 2022 21:17:30 +0100 (CET)
Message-ID: <9ce034fd-b696-60d2-c292-98285aff180a@kdbg.org>
Date:   Thu, 13 Jan 2022 21:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/3] reftable: remove unreachable "return" statements
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
 <Yd3XpLaZ3qc25PzQ@nand.local> <220112.865yqpxge2.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220112.865yqpxge2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.01.22 um 13:47 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Tue, Jan 11 2022, Taylor Blau wrote:
> 
>> On Tue, Jan 11, 2022 at 05:40:22PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>> Remove unreachable return statements added in acb533440fc (reftable:
>>> implement refname validation, 2021-10-07) and f14bd719349 (reftable:
>>> write reftable files, 2021-10-07).
>>>
>>> This avoids the following warnings on SunCC 12.5 on
>>> gcc211.fsffrance.org:
>>>
>>>     "reftable/refname.c", line 135: warning: statement not reached
>>>     "reftable/refname.c", line 135: warning: statement not reached
>>
>> Interesting. From a cursory reading, I agree with the assessment of
>> at least my compiler that these return statements are both unnecessary,
>> but...
>>
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>  reftable/refname.c | 1 -
>>>  reftable/writer.c  | 1 -
>>>  2 files changed, 2 deletions(-)
>>>
>>> diff --git a/reftable/refname.c b/reftable/refname.c
>>> index 95734969324..136001bc2c7 100644
>>> --- a/reftable/refname.c
>>> +++ b/reftable/refname.c
>>> @@ -132,7 +132,6 @@ static int validate_refname(const char *name)
>>>  			return REFTABLE_REFNAME_ERROR;
>>>  		name = next + 1;
>>>  	}
>>> -	return 0;
>>>  }
>>
>> In this case the loop inside of validate_refname() should always
>> terminate the function within the loop body. But removing this return
>> statement here relies on the compiler to determine that fact.
>>
>> I could well imagine on the other end of the spectrum there exists a
>> compiler which _doesn't_ make this inference pass, and would complain
>> about the opposite thing as you're reporting from SunCC (i.e., that this
>> function which returns something other than void does not have a return
>> statement outside of the loop).
>>
>> So in that sense, I disagree with the guidance of SunCC's warning. In
>> other words: by quelching this warning under one compiler, are we
>> introducing a new warning under a different/less advanced compiler?
> 
> I'd think that any compiler who'd warn about this sort of thing at all
> would be able to spot constructs like this one, which are basically:
> 
>     while (1) {
>     	...
>         if (x)
>         	return;
> 	...
>     }
>     return; /* unreachable */
> 
> Where the elided code contains no "break", "goto" or other mechanism for
> exiting the for-loop.

Why not just sidestep the problematic case:

diff --git a/reftable/refname.c b/reftable/refname.c
index 9573496932..4f89956187 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -120,17 +120,17 @@ static int modification_has_ref_with_prefix(struct modification *mod,
 static int validate_refname(const char *name)
 {
 	while (1) {
 		char *next = strchr(name, '/');
 		if (!*name) {
 			return REFTABLE_REFNAME_ERROR;
 		}
 		if (!next) {
-			return 0;
+			break;
 		}
 		if (next - name == 0 || (next - name == 1 && *name == '.') ||
 		    (next - name == 2 && name[0] == '.' && name[1] == '.'))
 			return REFTABLE_REFNAME_ERROR;
 		name = next + 1;
 	}
 	return 0;
 }

Sure, there are returns in the loop, but they are clearly error cases.
The regular exit is now at the end of the function.

-- Hannes
