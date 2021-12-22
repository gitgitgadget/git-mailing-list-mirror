Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3653EC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhLVW4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:56:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:23633 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhLVW4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:56:05 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C50123F4859;
        Wed, 22 Dec 2021 17:56:04 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 820D73F47FA;
        Wed, 22 Dec 2021 17:56:04 -0500 (EST)
Subject: Re: [PATCH 8/9] trace2: add counter events to perf and event target
 formats
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <3e39c8172f5de572c7b67f381d51631623a41762.1640012469.git.gitgitgadget@gmail.com>
 <211220.86czlrurm6.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fe3e9ceb-428e-1f20-9f90-37ad378f50b8@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 17:56:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211220.86czlrurm6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/21 11:51 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]
> 
>> +static void fn_counter(uint64_t us_elapsed_absolute,
>> +		       const char *thread_name,
>> +		       const char *category,
>> +		       const char *counter_name,
>> +		       uint64_t value)
>> +{
>> +	const char *event_name = "counter";
>> +	struct strbuf buf_payload = STRBUF_INIT;
>> +
>> +	strbuf_addf(&buf_payload, "name:%s", counter_name);
>> +	strbuf_addf(&buf_payload, " value:%"PRIu64, value);
> 
> Odd to have these be two seperate strbuf_addf()...

yeah, i'll combine.  and in the body of fn_timer in 6/9.


> ....but more generally, and I see from e.g. the existing fn_version_fl
> that you're just using existing patterns, but it seems odd not to have a
> trivial varargs fmt helper for perf_io_write_fl that would avoid the
> whole strbuf/addf/release dance.
[...]

yeah, cut-n-paste was used here and i was maintaining
consistency with the other functions -- rather than inventing
something new and refactoring stuff that didn't need be refactored
in the middle of an on-going patch series.


> I did a quick experiment to do that, patch on "master" below. A lot of
> the boilerplate could be simplified by factoring out the
> sq_quote_buf_pretty() case, and even this approach (re)allocs in a way
> that looks avoidable in many cases if perf_fmt_prepare() were improved
> (but it looks like it nedes its if/while loops in some cases still):
> 
[...]
>   
> +__attribute__((format (printf, 8, 9)))
> +static void perf_io_write_fl_fmt(const char *file, int line, const char *event_name,
> +				 const struct repository *repo,
> +				 uint64_t *p_us_elapsed_absolute,
> +				 uint64_t *p_us_elapsed_relative,
> +				 const char *category,
> +				 const char *fmt, ...)
> +{
> +	va_list ap;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&sb, fmt, ap);
> +	va_end(ap);
> +
> +	perf_io_write_fl(file, line, event_name, repo, p_us_elapsed_absolute,
> +			 p_us_elapsed_relative, category, &sb);
> +
> +	strbuf_release(&sb);
> +}
> +
>   static void fn_version_fl(const char *file, int line)
>   {
>   	const char *event_name = "version";
> -	struct strbuf buf_payload = STRBUF_INIT;
> -
> -	strbuf_addstr(&buf_payload, git_version_string);
>   
> -	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
> -			 &buf_payload);
> -	strbuf_release(&buf_payload);
> +	perf_io_write_fl_fmt(file, line, event_name, NULL, NULL, NULL, NULL,
> +			     "%s", git_version_string);
>   }
[...]

Yes, it might be nice to have a _fmt() version as you suggest
and simplify many of the existing fn_*() function bodies.

It seems like I keep saying this today, but can we discuss that
in a new top-level topic and not down inside commit 8/9 of this
series?

Thanks,
Jeff

