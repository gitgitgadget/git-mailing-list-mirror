Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2321C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbhLVWSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:18:37 -0500
Received: from siwi.pair.com ([209.68.5.199]:20612 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhLVWSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:18:36 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3E8353F4113;
        Wed, 22 Dec 2021 17:18:36 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 05A3C3F40E6;
        Wed, 22 Dec 2021 17:18:35 -0500 (EST)
Subject: Re: [PATCH 9/9] trace2: add global counters
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <596caede216c44d2a01358229bc1a47248e708b1.1640012469.git.gitgitgadget@gmail.com>
 <211220.868rwfur46.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <db155798-eb74-1ddf-d932-1243e76bd2ae@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 17:18:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211220.868rwfur46.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/21 12:14 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]

>> +	int nr_threads = 0;
>> +	int k;
>> +	pthread_t *pids = NULL;
>> +
>> +	if (argc != 3)
>> +		die("%s", usage_error);
>> +	if (get_i(&data.v1, argv[0]))
>> +		die("%s", usage_error);
>> +	if (get_i(&data.v2, argv[1]))
>> +		die("%s", usage_error);
>> +	if (get_i(&nr_threads, argv[2]))
>> +		die("%s", usage_error);
> 
> A partial nit on existing code, as this just extends the pattern, but
> couldn't much of this get_i() etc. just be made redundant by simply
> using the parse-options.c API here?  I.e. OPTION_INTEGER and using named
> arguments would do the validation or you.

I suppose.  It just seemed like a little overkill setting things
up for such a simple and isolated test.  And the cut-n-paste was
quick enough for my purposes.

> 
>> +# Exercise the global counter in a loop and confirm that we get the
>> +# expected sum in an event record.
>> +#
>> +
>> +have_counter_event () {
>> +	thread=$1
>> +	name=$2
>> +	value=$3
>> +	file=$4
>> +
>> +	grep "\"event\":\"counter\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"value\":${value}" $file
>> +
>> +	return $?
>> +}
> 
> It looks like there's no helper, but this is the Nth thing I see where
> wish our "test_region" helper were just a bit more generalized. I.e.:
> 
>      test_trace2 --match=counter --match=thread=$thread --match=name=$name --match=value=$value <trace>
> 
> With test_region just being a wrapper for something like:
> 
>      test_trace2 --match=region_enter --match=category=$category --match=label=$label <trace> &&
>      test_trace2 --match=region_leave --match=category=$category --match=label=$label <trace>

Yes, that would be nice.  But I don't think we should
start that in the middle of this patch series.  Perhaps
you could start a top-level message with a fleshed out
proposal and let everyone discuss it.

> 
>> +static void tr2main_emit_summary_counters(uint64_t us_elapsed_absolute)
>> +{
>> +	struct tr2_tgt *tgt_j;
>> +	int j;
>> +	struct tr2ctr_block merged;
>> +
>> +	memset(&merged, 0, sizeof(merged));
> 
> nit: more memset v.s. "{ 0 }".

Yeah, but lldb wouldn't stop complaining until it was "= { { { 0 } } }"

Jeff

