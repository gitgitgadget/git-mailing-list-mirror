Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD601F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 15:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeJNWpG (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 18:45:06 -0400
Received: from avasout03.plus.net ([84.93.230.244]:43492 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeJNWpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 18:45:05 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id BhvpgvPYgO2g2BhvqgZZuE; Sun, 14 Oct 2018 16:03:50 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=kjfK_3I9ULUtONQyDZ8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de> <20181012222234.GF19800@szeder.dev>
 <20181013050057.GA6805@tor.lan>
 <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
 <20181014025207.GA1527@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <1e3233f4-ea40-6fff-0951-6b4885f88445@ramsayjones.plus.com>
Date:   Sun, 14 Oct 2018 16:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014025207.GA1527@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOj/vdvCKJJeqQtNzJt4ExSFfpvOCv+m3uAnAH1vfGm+bljnR1brqflqG0Tay19sA0bwUN9kMMH8d5b04JrPsWyv1/tUCmN5iBGe0I1hBj+sIE5saujo
 rth213b8po2roEMb5OB3sikHQD+4vqM+nXxf862wcEmBo29kUEaq/j10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/10/18 03:52, Jeff King wrote:
> On Sun, Oct 14, 2018 at 03:16:36AM +0100, Ramsay Jones wrote:
> 
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index b059b86aee..3b5f2c38b3 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -269,12 +269,12 @@ static void copy_pack_data(struct hashfile *f,
>>  		off_t len)
>>  {
>>  	unsigned char *in;
>> -	unsigned long avail;
>> +	size_t avail;
>>  
>>  	while (len) {
>>  		in = use_pack(p, w_curs, offset, &avail);
>>  		if (avail > len)
>> -			avail = (unsigned long)len;
>> +			avail = xsize_t(len);
> 
> We don't actually care about truncation here. The idea is that we take a
> bite-sized chunk via use_pack, and loop as necessary. So mod-2^32
> truncation via a cast would be bad (we might not make forward progress),
> but truncating to SIZE_MAX would be fine.
> 
> That said, we know that would not truncate here, because we must
> strictly be shrinking "avail", which was already a size_t (unless "len"
> is negative, but then we are really screwed ;) ).
> 
> So I kind of wonder if a comment would be better than xsize_t here.
> Something like:
> 
>   if (avail > len) {
> 	/*
> 	 * This can never truncate because we know that len is smaller
> 	 * than avail, which is already a size_t.
> 	 */
> 	avail = (size_t)len;
>   }

Heh, you are, of course, correct! (that will learn me[1]). :-D

Hmm, let's see if I can muster the enthusiasm to do all that
testing again!

ATB,
Ramsay Jones

[1] Since I started with my patch, when I had finished 'paring
it back', the result didn't have this xsize_t() call. In order
to make the result 'v2 + SZEDER's patch' (which I thought was
quite neat) I added this call right at the end. :-P

