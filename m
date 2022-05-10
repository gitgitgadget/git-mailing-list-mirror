Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F68C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 20:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiEJUrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEJUrk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 16:47:40 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975451CC99F
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:47:39 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 79E953F4131;
        Tue, 10 May 2022 16:47:38 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 21ED03F4114;
        Tue, 10 May 2022 16:47:38 -0400 (EDT)
Subject: Re: [PATCH v2 4/5] bitmap: add trace2 outputs during open "bitmap"
 file
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
References: <8005642d-979f-8e48-7a93-07b8a888bdc7@jeffhostetler.com>
 <20220506124333.58956-1-dyroneteng@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7047d8f1-5959-a553-5a53-ace7b5b925c1@jeffhostetler.com>
Date:   Tue, 10 May 2022 16:47:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220506124333.58956-1-dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/6/22 8:43 AM, Teng Long wrote:
>> This might just be a style thing, but rather than logging the pathname
>> in a separate data_string message, you can use the _printf version of
>> region_enter and region_leave to also print the name of the
>> path -- like I did in read-cache.c for the "do_read_index"
>> calls.
>>
>> ... | region_enter | ... | index | label:do_read_index .git/index
>> ...
>> ... | region_leave | ... | index | label:do_read_index .git/index
> 
> Appreciate for the input about the _printf version, we can choose to
> let the region_enter and region_leave to print the pathname by moving
> the related "midx_bitmap_filename()" and "pack_bitmap_filename" at
> front, but it's not enough because both midx and normal bitmap support
> multiple opening, so it's likely we keep on the current way using
> "trace2_data_string()" in "open_pack_bitmap_1()" and "open_midx_bitmap_1()"
> is a simpler solution.
> 
> I'm not sure If I totally get the meaning about your suggestion,
> so correct me if I understand you wrong.

That's fine.  I was assuming that you were only operating
on a single file at a time and opening, using, closing it
in a nicely bracketed fashion.  The region_enter and _leave
is good for capturing that.  But if you might be handling
both files concurrently, then your messages would be better
since we don't want mix or improperly nest the regions.

(I must admit that I haven't studied the bitmap code, so
I defer to your judgement here.)

> 
>> As AEvar suggests in another message in this thread, I'm not sure if
>> you need the region timing here for reading the bitmap, but all of
>> the error and any other data messages will be bounded between the
>> region_enter and region_leave events and that might (or might not)
>> be helpful.
> 
> I think it's needed in my opinion, the bounded between the region is
> helpful, especially when we want to know the detailed debug info like
> we do in "open_midx_bitmap_1()".
> 
> 
>> Also, I agree with AEvar's statements about using error() and getting
>> the trace2 error messages for free and not needing some of the
>> trace2_data_string() messages that you have later in this file.
>>
>> I wonder if it would be worth adding the pathname of the invalid
>> file to those new error messages.  Granted you'll have it in the
>> trace2 log, but then you'll also get it on stderr if that would
>> be helpful.
> 
> I think I will remove the redundant "trace2_data_string()" code when
> it will return by "error()".
> 
> 
> Thanks.
> 
