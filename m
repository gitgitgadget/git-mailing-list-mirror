Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D71B1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbfHHTE1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:04:27 -0400
Received: from siwi.pair.com ([209.68.5.199]:46226 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390203AbfHHTE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:04:27 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 936483F40B4;
        Thu,  8 Aug 2019 15:04:25 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:9d4f:d974:4879:2e91] (unknown [IPv6:2001:4898:a800:1012:4e83:d974:4879:2e91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 49B863F4090;
        Thu,  8 Aug 2019 15:04:25 -0400 (EDT)
Subject: Re: [PATCH v2 5/7] quote: add sq_quote_argv_pretty_ltrim
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.298.git.gitgitgadget@gmail.com>
 <pull.298.v2.git.gitgitgadget@gmail.com>
 <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
 <xmqqh86rfs70.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7dbee619-2495-6426-b02b-49fd59e4f028@jeffhostetler.com>
Date:   Thu, 8 Aug 2019 15:04:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh86rfs70.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/8/2019 2:05 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create version of sq_quote_argv_pretty() that does not
>> insert a leading space before argv[0].
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   quote.c | 11 +++++++++++
>>   quote.h |  1 +
>>   2 files changed, 12 insertions(+)
> 
> I am OK with the basic idea, but I am somewhat unhappy about this
> particular patch for two reasons:
> 
>   - If we were to keep this as a part of proper API in the longer
>     term, the current sq_quote_argv_pretty() should be rewritten to
>     use this to avoid repetition (e.g. as long as !!*argv, add a SP
>     and then call this new thing);
> 
>   - something_ltrim() sounds as if you munge what is passed to you
>     and chop off the left end, but that is not what this does.
> 
> Now, what is the right name for this new thing?  What does it do?

I struggled with the proper name for this.
And even thought about adding a 3rd arg to the current function to
indicate whether to have the leading SP before argv[0], but wasn't
sure if that was too disruptive.

> 
> It looks to me that it appends each element of argv[], quoting it as
> needed, and with SP in between.  So the right name for the family of
> these functions should be around "append", which is the primary thing
> they do, with "quoted" somewhere.
> 
> Having made the primary purpose of the helper clearer leads me to
> wonder if "do not add SP before the first element, i.e. argv[0]", is
> really what we want.  If we always clear the *dst strbuf before
> starting to serialize argv[] into it, then the behaviour would make
> sense, but we do not---we are "appending".
> 
> As long as we are appending, would we be better off doing something
> sillily magical like this instead, I have to wonder?
> 
> 	void sq_append_strings_quoted(struct strbuf *buf, const char **av)
> 	{
> 		int i;
> 
> 		for (i = 0; av[i]; i++) {
> 			if (buf->len)
> 				strbuf_addch(buf, ' ');
> 			sq_quote_buf_pretty(buf, argv[0]);
> 		}
> 	}
> 
> That is, "if we are appending to an existing string, have SP to
> separate the first element from that existing string; treat the
> remaining elements the same way (if the buffer is empty, there is no
> point adding SP at the beginning)".

I don't think that would do what we want.  We don't know what the
caller's expectations are.  In my uses in commits 6/7 and 7/7 I
already added the leading chars I wanted in the strbuf before calling
sq_quote_argv_pretty_ltrim() and assumed the output would be a true
append.  For example:

+	strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
+	strbuf_addch(&buf_payload, ']');

I like your suggestion of putting my new function in the _append_
category.  I think I'll add the 3rd arg to this and then it will
be completely specified and I can get rid of the _ltrim suffix.

I'll re-roll this.

> 
> I may have found a long-standing bug in sq_quote_buf_pretty(), by
> the way.  What does it produce when *src is an empty string of
> length 0?  It does not add anything to dst, but shouldn't we be
> adding two single-quotes (i.e. an empty string inside sq pair)?

I would think so.  I did a quick grep and most of the calls looked
guarded, so I don't think this is urgent.  I'll address this in a
separate commit shortly.

Thanks
Jeff


> 
>> diff --git a/quote.c b/quote.c
>> index 7f2aa6faa4..7cad8798ac 100644
>> --- a/quote.c
>> +++ b/quote.c
>> @@ -94,6 +94,17 @@ void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
>>   	}
>>   }
>>   
>> +void sq_quote_argv_pretty_ltrim(struct strbuf *dst, const char **argv)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; argv[i]; i++) {
>> +		if (i > 0)
>> +			strbuf_addch(dst, ' ');
>> +		sq_quote_buf_pretty(dst, argv[i]);
>> +	}
>> +}
>> +
>>   static char *sq_dequote_step(char *arg, char **next)
>>   {
>>   	char *dst = arg;
>> diff --git a/quote.h b/quote.h
>> index fb08dc085c..3b3d041a61 100644
>> --- a/quote.h
>> +++ b/quote.h
>> @@ -40,6 +40,7 @@ void sq_quotef(struct strbuf *, const char *fmt, ...);
>>    */
>>   void sq_quote_buf_pretty(struct strbuf *, const char *src);
>>   void sq_quote_argv_pretty(struct strbuf *, const char **argv);
>> +void sq_quote_argv_pretty_ltrim(struct strbuf *, const char **argv);
>>   
>>   /* This unwraps what sq_quote() produces in place, but returns
>>    * NULL if the input does not look like what sq_quote would have
