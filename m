Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B69C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02FB20709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOTpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 15:45:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:35577 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOTpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 15:45:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6D1FE3F4129;
        Fri, 15 May 2020 15:44:59 -0400 (EDT)
Received: from BHC-0178C.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4C3963F40FA;
        Fri, 15 May 2020 15:44:59 -0400 (EDT)
Subject: Re: [PATCH] trace2: log progress time and throughput
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
References: <20200512214420.36329-1-emilyshaffer@google.com>
 <90f800d5-c647-6750-52d1-da973f036bd0@jeffhostetler.com>
Message-ID: <369ab235-e23a-712a-d2bf-82735194ceff@jeffhostetler.com>
Date:   Fri, 15 May 2020 15:44:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <90f800d5-c647-6750-52d1-da973f036bd0@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/15/20 3:37 PM, Jeff Hostetler wrote:
> 
> 
> On 5/12/20 5:44 PM, Emily Shaffer wrote:
>> Rather than teaching only one operation, like 'git fetch', how to write
>> down throughput to traces, we can learn about a wide range of user
>> operations that may seem slow by adding tooling to the progress library
>> itself. Operations which display progress are likely to be slow-running
>> and the kind of thing we want to monitor for performance anyways. By
>> showing object counts and data transfer size, we should be able to
>> make some derived measurements to ensure operations are scaling the way
>> we expect.
>>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> 
> We need to be careful here.  The region_enter and _leave calls need
> to always be properly nested.  Having an implicit region within the
> progress code means the code path between all of the different start_ 
> and stop_progress calls need to not interleave with explicit regions.
> 
> How about putting something like this in stop_progress:
> 
>      struct json_writer jw = JSON_WRITER_INIT;
>      jw_object_begin(&jw, 0);
>      jw_object_intmax(&jw, "total", p->total);
>      if (p->throughput)
>          jw_object_intmax(&jw, "throughput", p->throughput->curr_total);
>      /*
>       * and so on...
>       * and maybe include the elapsed time in since the start_progress.
>       */
>      jw_end(&jw);
>      trace2_data_json("progress", NULL, p->title, &jw);
>      jw_release(&jw);
> 
> That will give you a single record summary of the progress meter
> and you won't have to worry about any interleaving.
> 
> You could also add a bit to `struct progress` to let you opt-in
> or opt-out of the message on a case-by-case basis.
> 
> Jeff

Hit send too quickly...

One of the advantages of a "data_json" event is that it will keep
the multiple values together in one event.  This makes it easier to
correlate them during post processing.

For example, you could grep for "\"data_json\".*\"progress\".*<title>"
and easily parse and see the total and time and etc in one record.



