Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F736C04FF7
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjITUCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjITUCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 16:02:13 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B099AC
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 13:02:05 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id ABA62CA1295;
        Wed, 20 Sep 2023 16:02:01 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:fd89:af42:bea6:fd68] (unknown [IPv6:2600:1700:840:e768:fd89:af42:bea6:fd68])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 57070CC839A;
        Wed, 20 Sep 2023 16:02:01 -0400 (EDT)
Message-ID: <dc45106c-d569-3438-d2ff-c3c94b6161d7@jeffhostetler.com>
Date:   Wed, 20 Sep 2023 16:02:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] fix: check parameters in json-write.c
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        mark via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, mark <870355373@qq.com>,
        wangsirun <wangsirun@zhidaoauto.com>,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1576.git.git.1695124498925.gitgitgadget@gmail.com>
 <ZQne3ThSw6HVmNJc@nand.local>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <ZQne3ThSw6HVmNJc@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/23 1:48 PM, Taylor Blau wrote:
> [+cc Jeff Hostetler]
> 
> On Tue, Sep 19, 2023 at 11:54:58AM +0000, mark via GitGitGadget wrote:
>> diff --git a/json-writer.c b/json-writer.c
>> index 005c820aa42..23ba7046e5d 100644
>> --- a/json-writer.c
>> +++ b/json-writer.c
>> @@ -20,6 +20,11 @@ static void append_quoted_string(struct strbuf *out, const char *in)
>>   {
>>   	unsigned char c;
>>
>> +	if (!in || !*in) {
>> +		strbuf_addstr(out, "\"\"");
>> +		return;
>> +	}
> 
>  From reading the implementation of append_quoted_string(), I think that
> the case where "in" is the empty string is already covered. IOW, doing
> something like:
> 
>      struct strbuf buf = STRBUF_INIT;
>      append_quoted_string(&out, "");
>      warning("'%s'", buf.buf);
> 
> would print out something like:
> 
>      warning: '""'
> 
> as expected. Handling a NULL "in" argument is new behavior, but I am not
> sure if it is appropriate to coerce a NULL input into the empty string.
> I've CC'd the author of this code, whose opinion I trust more than my
> own here.
> 
> Thanks,
> Taylor

There are three callers of `append_quoted_string()` and it is static
to the json-writer.c code.

Basically, in a JSON object, we have 2 uses:

     {
         "<key>" : "<string-value>",
         "<key>" : <integer>,
         ...
     }

And in a JSON array, we have the other:

     [
         "<string-value>",
         ...
     ]

I suppose it is OK for the 2 string-value cases to assume a NULL pointer
could be written as "" in the JSON output.  Although, I kinda think a
NULL pointer should call BUG() as we have in the various assert_*()
routines. It really is a kind of logic error in the caller.

Regardless what we decide for the <string-value> case, in the <key>
case, the resulting JSON would not be valid. We need for the key to
be a non-empty string.  For example { "" : 1 } is not valid JSON.
So the key case should call BUG() and not try to hide it.

So I'm leaning towards just making it a BUG() in all cases, but I'm
open to the other mixed handling.

Jeff
