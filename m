Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2D41F4B6
	for <e@80x24.org>; Sat, 13 Jul 2019 10:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfGMKoZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 06:44:25 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:49583 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfGMKoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 06:44:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45m5yG210Pz5tlF;
        Sat, 13 Jul 2019 12:44:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E84021E78;
        Sat, 13 Jul 2019 12:44:20 +0200 (CEST)
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
 <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
Date:   Sat, 13 Jul 2019 12:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.07.19 um 18:44 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 12.07.19 um 00:03 schrieb Ramsay Jones:
>>> diff --git a/range-diff.c b/range-diff.c
>>> index ba1e9a4265..0f24a4ad12 100644
>>> --- a/range-diff.c
>>> +++ b/range-diff.c
>>> @@ -102,7 +102,7 @@ static int read_patches(const char *range, struct string_list *list)
>>>  		}
>>>  
>>>  		if (starts_with(line, "diff --git")) {
>>> -			struct patch patch = { 0 };
>>> +			struct patch patch = { NULL };
>>
>> There is nothing wrong with 0 here. IMHO, zero-initialization should
>> *always* be written as = { 0 } and nothing else. Changing 0 to NULL to
>> pacify sparse encourages a wrong style.
> 
> Hmm, care to elaborate a bit?  Certainly, we have a clear preference
> between these two:
> 
> 	struct patch patch;
> 	patch.new_name = 0;
> 	patch.new_name = NULL;
> 
> where the "char *new_name" field is the first one in the structure.
> We always try to write the latter, even though we know they ought to
> be equivalent to the language lawyers.

I'm not questioning this case; the latter form is clearly preferable.

Using only = { 0 } for zero-initialization makes the code immune to
rearrangements of the struct members. That is not the case with = { NULL
} because it requires that the first member is a pointer; if
rearrangement makes the first member a non-pointer, the initializations
must be adjusted.

On the other hand, I'm not arguing that

  struct string_list dup_it = { NULL, 0, 0, 1, NULL };

should be written as

  struct string_list dup_it = { 0, 0, 0, 1, 0 };

I'm only complaining about the single-initializer = { 0 } "please
initialize this whole struct with zero values" form.

> Is the reason why you say 0 is fine here because we consider
> 
> 	struct patch patch, *dpatch;
> 	memset(&patch, 0, sizeof(patch));
> 	dpatch = xcalloc(1, sizeof(patch));
> 
> are perfectly good way to trivially iniitialize an instance of the
> struct?

Absolutely not. Both forms are evildoing as far as struct initialization
is concerned because they ignore the types of the members. The memset
form should always be replaced by = { 0 }. The correct replacement for
the xcalloc form would be

	struct patch zero = { 0 };
	struct patch *dpatch = xmalloc(sizeof(*dpatch));
	*dpatch = zero;

but I do understand that this transformation is unacceptably verbose.

> Do we want to talk to sparse folks about this?

I've no idea which camp they are in. How would they respond to an
exceptional case that is also very much a matter of taste?

-- Hannes
