Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D306C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCWUco (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:32:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:49197 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeCWUcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:32:43 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7959B3F4024;
        Fri, 23 Mar 2018 16:32:43 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4BFE93F401D;
        Fri, 23 Mar 2018 16:32:43 -0400 (EDT)
Subject: Re: [PATCH v2] json_writer: new routines to create data in JSON
 format
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180321192827.44330-1-git@jeffhostetler.com>
 <20180321192827.44330-2-git@jeffhostetler.com>
 <524c47a6-7c9f-5519-250a-4722081a0f32@web.de>
 <14bbf223-a4d1-3c11-cd2e-dff044e01fef@jeffhostetler.com>
 <306104ac-37ac-8198-1988-03efa818cde3@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e4a64bc0-40eb-9285-c3b5-f034d78ffb85@jeffhostetler.com>
Date:   Fri, 23 Mar 2018 16:32:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <306104ac-37ac-8198-1988-03efa818cde3@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2018 4:11 PM, René Scharfe wrote:
> Am 23.03.2018 um 20:55 schrieb Jeff Hostetler:
>>>> +struct json_writer_level
>>>> +{
>>>> +    unsigned level_is_array : 1;
>>>> +    unsigned level_is_empty : 1;
>>>> +};
>>>> +
>>>> +struct json_writer
>>>> +{
>>>> +    struct json_writer_level *levels;
>>>> +    int nr, alloc;
>>>> +    struct strbuf json;
>>>> +};
>>>
>>> A simpler and probably more compact representation of is_array would
>>> be a strbuf with one char per level, e.g. '[' for an array and '{'
>>> for an object (or ']' and '}').
>>>
>>> I don't understand the need to track emptiness per level.  Only the
>>> top level array/object can ever be empty, can it?
>>
>> My expectation was that any sub-object or sub-array could be empty.
>> That is, this should be valid (and the JSON parser in Python allows):
>>
>>       {"a":{}, "b":[], "c":[[]], "d":[{}]}
> 
> Sure, but the emptiness of finished arrays and objects doesn't matter
> for the purposes of error checking, comma setting or closing.  At most
> one of them is empty *and* unclosed while writing the overall JSON
> object -- the last one opened:
> 
> 	{
> 	{"a":{
> 	{"a":{}, "b":[
> 	{"a":{}, "b":[], "c":[
> 	{"a":{}, "b":[], "c":[[
> 	{"a":{}, "b":[], "c":[[]], "d":[
> 	{"a":{}, "b":[], "c":[[]], "d":[{
> 
> Any of the earlier written arrays/objects are either closed or contain
> at least a half-done sub-array/object, which makes them non-empty.
> 
> René
> 

good point.  i'll revisit.  thanks.
Jeff
