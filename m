Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC586EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 20:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGKUPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 16:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGKUP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 16:15:27 -0400
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 13:15:26 PDT
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284D136
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 13:15:26 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6298ACA1262;
        Tue, 11 Jul 2023 16:07:16 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:d166:3bea:30ca:7102] (unknown [IPv6:2600:1700:840:e768:d166:3bea:30ca:7102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 23ED9CC83B2;
        Tue, 11 Jul 2023 16:07:15 -0400 (EDT)
Message-ID: <7c8d6012-5bb5-9ee5-eda1-80e46c4b6981@jeffhostetler.com>
Date:   Tue, 11 Jul 2023 16:07:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 1/8] trace2: log fsync stats in trace2 rather than
 wrapper
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-2-calvinwan@google.com>
Content-Language: en-US
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20230627195251.1973421-2-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/27/23 3:52 PM, Calvin Wan wrote:
> As a library boundary, wrapper.c should not directly log trace2
> statistics, but instead provide those statistics upon
> request. Therefore, move the trace2 logging code to trace2.[ch.]. This
> also allows wrapper.c to not be dependent on trace2.h and repository.h.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>   trace2.c  | 13 +++++++++++++
>   trace2.h  |  5 +++++
>   wrapper.c | 17 ++++++-----------
>   wrapper.h |  4 ++--
>   4 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/trace2.c b/trace2.c
> index 0efc4e7b95..f367a1ce31 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -915,3 +915,16 @@ const char *trace2_session_id(void)
>   {
>   	return tr2_sid_get();
>   }
> +
> +static void log_trace_fsync_if(const char *key)
> +{
> +	intmax_t value = get_trace_git_fsync_stats(key);
> +	if (value)
> +		trace2_data_intmax("fsync", the_repository, key, value);
> +}
> +
> +void trace_git_fsync_stats(void)
> +{
> +	log_trace_fsync_if("fsync/writeout-only");
> +	log_trace_fsync_if("fsync/hardware-flush");
> +}
> diff --git a/trace2.h b/trace2.h
> index 4ced30c0db..689e9a4027 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -581,4 +581,9 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason);
>   
>   const char *trace2_session_id(void);
>   
> +/*
> + * Writes out trace statistics for fsync
> + */
> +void trace_git_fsync_stats(void);
> +
>   #endif /* TRACE2_H */

Sorry to be late to this party, but none of this belongs
in trace2.[ch].

As Victoria stated, you can/should use the new "timers and counters"
feature in Trace2 to collect and log these stats.

And then you don't need specific log_trace_* functions or wrappers
-- just use the trace2_timer_start()/stop() or trace2_counter_add()
functions as necessary around the various fsync operations.


I haven't really followed the lib-ification effort, so I'm just going
to GUESS that all of the Trace2_ and tr2_ prefixed functions and data
structures will need to be in the lowest-level .a so that it can be
called from the main .exe and any other .a's between them.

Jeff

