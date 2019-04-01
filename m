Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF8420248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDAVQv (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:16:51 -0400
Received: from siwi.pair.com ([209.68.5.199]:32889 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfDAVQv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:16:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 59C573F40D0;
        Mon,  1 Apr 2019 17:16:50 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:74a2:1cda:f42b:77ce] (unknown [IPv6:2001:4898:8010:0:5dd8:1cda:f42b:77ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D3CFA3F40C7;
        Mon,  1 Apr 2019 17:16:49 -0400 (EDT)
Subject: Re: [PATCH v2 7/7] trace2: make SIDs more unique
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
 <4352952677a11776a18ec9b6862cf358307cfafd.1553879063.git.gitgitgadget@gmail.com>
 <87lg0x9voz.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5a507e32-cf84-21c9-4ffe-246ecef49370@jeffhostetler.com>
Date:   Mon, 1 Apr 2019 17:16:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lg0x9voz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/29/2019 6:12 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 29 2019, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Update SID component construction to use the current UTC datetime
>> and a portion of the SHA1 of the hostname.
>>
>> Use an simplified date/time format to make it easier to use the
>> SID component as a logfile filename.
>> [...]
>> +static void tr2_sid_append_my_sid_component(void)
>> +{
>> +	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
>> +	struct tr2_tbuf tb_now;
>> +	git_hash_ctx ctx;
>> +	unsigned char hash[GIT_MAX_RAWSZ + 1];
>> +	char hex[GIT_MAX_HEXSZ + 1];
>> +	char hostname[HOST_NAME_MAX + 1];
>> +
>> +	tr2_tbuf_utc_datetime_for_filename(&tb_now);
>> +	strbuf_addstr(&tr2sid_buf, tb_now.buf);
>> +	strbuf_addch(&tr2sid_buf, '-');
>> +
>> +	if (xgethostname(hostname, sizeof(hostname)))
>> +		xsnprintf(hostname, sizeof(hostname), "localhost");
>> +
>> +	algo->init_fn(&ctx);
>> +	algo->update_fn(&ctx, hostname, strlen(hostname));
>> +	algo->final_fn(hash, &ctx);
>> +	hash_to_hex_algop_r(hex, hash, algo);
>> +	strbuf_add(&tr2sid_buf, hex, 8);
>> +
>> +	strbuf_addch(&tr2sid_buf, '-');
>> +	strbuf_addf(&tr2sid_buf, "%06"PRIuMAX, (uintmax_t)getpid());
>> +}
>> +
> 
> Thanks for turning my shitty half-formed idea into a patch :)
> 
> I wrote this on top to bikeshed this a bit further, wonder what you
> think:
> https://github.com/gitgitgadget/git/compare/pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v2...avar:pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v2
> 
> So e.g.:
> 
>      Before: 20190329-220413-446441-c2f5b994-018702
>      After:  20190329T220431.244562Z-Hc2f5b994-P19812F
> 
> I.e:
> 
>   * Using <date>T<time> as is ISO 8601 convention/easier to read
> 
>   * <dateime>.<microseconds>Z, so seperating with "." to indicate it's
>     the same value + add "Z" for "it's UTC". I'm least sure about the
>     ".". Is that going to cause issues on Windows these days (the rest
>     being the "extension"...).

I had a version that did just that.  I checked the various ISO and RFCs
and it seems like the fractional seconds is usually allowed between the
whole seconds and the "Z".

I've not seen any problems with that format.

I think I got spooked by your original suggestion to put the fraction in
a term after the whole "<date>T<time>Z" term.

I'll convert it back to match your suggestion.

> 
>   * I changed the hostname discovery so if gethostbyname() fails we'll
>     print "-H00000000-" for that part, instead of "-H<first 8 chars of
>     the sha1 for 'localhost'>-". Also prefix with "H" for "Host".

I like that.

> 
>   * Wrap pids to 0xffff, prefix with "P" (Pid)" and trail with either "F"
>     = Full or "W" = Wrapped (not the real PID).

I could see the "P".  I'm not sure about the hex -- I sometimes want to
do a "ps" or watch the processes go by in TaskManager and friends and
they all print the pid in decimal.  But it's not that big a deal.

> 
>   * I didn't add "T<datetime>" like "H" and "P" for the rest, since it's
>     obvious what sort of value it is.
> 
> Maybe this is going a bit overboard, but I think it's easier to read at
> a glance for humans, and since it's meant to be opaque to machines
> anyway and the length is simliar enough not to matter I figure it's
> worth it.
> 

I'll re-roll.
Thanks
Jeff

