Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1029C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 14:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354568AbiDOOdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354576AbiDOOcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 10:32:43 -0400
Received: from smtp-out-6.talktalk.net (smtp-out-6.talktalk.net [62.24.135.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD28186E0
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 07:30:13 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.talktalk.net with SMTP
        id fMxfn02GUB4JQfMxfne3xK; Fri, 15 Apr 2022 15:30:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1650033012;
        bh=jZmXfXH910nkrP5TkRhFXKvyMtdoX1skugfz7e5C19E=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=nHJGx3SZ7G1OXQMJqEi+skYa6BH9XBbBRUZCwec3MquMUd2VnI61fck3lS4czY/ww
         b8Iep8Q0hl/iu2TRNo8Aiv5Fy8Sru0HEvuOSgHI2YjOGvEw1GtGqF1OUbs+6jCWCgO
         flkLoto3UmmB4Kn0b3WIYTrYqdwhZUC1oHMRukrE=
X-Originating-IP: [31.185.185.192]
X-Spam: 0
X-OAuthority: v=2.3 cv=Uf0vt5aN c=1 sm=1 tr=0 a=BhDTt+XCViy/yeGwkgzVOQ==:117
 a=BhDTt+XCViy/yeGwkgzVOQ==:17 a=IkcTkHD0fZMA:10 a=a_6INitNxW12fJjkFT8A:9
 a=QEXdDO2ut3YA:10
Message-ID: <23138e2b-436a-0990-cefc-0662674373c3@talktalk.net>
Date:   Fri, 15 Apr 2022 15:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/2] reftable: don't memset() a NULL from failed
 malloc()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <20220415083058.29495-1-carenas@gmail.com>
 <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
 <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
 <4321a9dd-bb82-e2fe-5449-395f998378c5@web.de>
 <220415.86fsmebgds.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
In-Reply-To: <220415.86fsmebgds.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE8xsWK4VnBChs8V2OANbZ3xUV+3YnUJMPhHVV5zDF8kVAeg/TmWHJ78PYIcwJm5F3rVOwyJxN0fjSdvptFh+3GDTZ+loD6d98I/YiMO7YQvTq7vfqvY
 /Oe+Prj1EWTqU2oU0Y44DDiZ8F4CQwAkg2SD91Y5rTvAEktgULdGjs6ntcxkovzmXdmYca3BXQOL9aIW6880h89Mfr9H3gHWQJbEg3kvOmieIOGIqio3BbBH
 gxMRUgDmMXploXNbPcXIU3ZsqtZJiNRH4MJorKXF4WaQkKchKFvmCPmEq7WYmiMrPCJLpmSdw09XKyQQOfaaKA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar and René

On 15/04/2022 14:53, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Apr 15 2022, René Scharfe wrote:
> 
>> Am 15.04.22 um 12:21 schrieb Ævar Arnfjörð Bjarmason:
>>> Return NULL instead of possibly feeding a NULL to memset() in
>>> reftable_calloc(). This issue was noted by GCC 12's -fanalyzer:
>>>
>>> 	reftable/publicbasics.c: In function ‘reftable_calloc’:
>>> 	reftable/publicbasics.c:43:9: error: use of possibly-NULL ‘p’ where non-null expected [CWE-690] [-Werror=analyzer-possible-null-argument]
>>> 	   43 |         memset(p, 0, sz);
>>> 	      |         ^~~~~~~~~~~~~~~~
>>> 	[...]
>>>
>>> This bug has been with us ever since this code was added in
>>> ef8a6c62687 (reftable: utility functions, 2021-10-07).
>>
>> Not sure it's a bug, or limited to this specific location.  AFAICS it's
>> more a general lack of handling of allocation failures in the reftable
>> code.  Perhaps it was a conscious decision to let the system deal with
>> them via segfaults?
> 
> I think it's just buggy, it tries to deal with malloc returning NULL in
> other contexts.

Does it? I just quickly scanned the output of

git grep -e 'reftable_[mc]alloc' -e 'reftable_realloc' -A2 origin/master

and I didn't see a single NULL check

>> When the code is used by Git eventually it should use xmalloc and
>> xrealloc instead of calling malloc(3) and realloc(3) directly, to
>> handle allocation failures explicitly, and to support GIT_ALLOC_LIMIT.
>> This will calm down the analyzer and extend the safety to the rest of
>> the reftable code, not just this memset call.
> 
> Yeah, its whole custom malloc handling should go away.

Isn't it there so the same code can be used by libgit2 and other things 
that let the caller specify a custom allocator?

Best Wishes

Phillip
