Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E81C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8416420671
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEOThX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 15:37:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:33186 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOThX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 15:37:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BBD8D3F47FA;
        Fri, 15 May 2020 15:37:21 -0400 (EDT)
Received: from BHC-0178C.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9C9A83F47F9;
        Fri, 15 May 2020 15:37:21 -0400 (EDT)
Subject: Re: [PATCH] trace2: log progress time and throughput
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
References: <20200512214420.36329-1-emilyshaffer@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <90f800d5-c647-6750-52d1-da973f036bd0@jeffhostetler.com>
Date:   Fri, 15 May 2020 15:37:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200512214420.36329-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/12/20 5:44 PM, Emily Shaffer wrote:
> Rather than teaching only one operation, like 'git fetch', how to write
> down throughput to traces, we can learn about a wide range of user
> operations that may seem slow by adding tooling to the progress library
> itself. Operations which display progress are likely to be slow-running
> and the kind of thing we want to monitor for performance anyways. By
> showing object counts and data transfer size, we should be able to
> make some derived measurements to ensure operations are scaling the way
> we expect.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

We need to be careful here.  The region_enter and _leave calls need
to always be properly nested.  Having an implicit region within the
progress code means the code path between all of the different start_ 
and stop_progress calls need to not interleave with explicit regions.

How about putting something like this in stop_progress:

     struct json_writer jw = JSON_WRITER_INIT;
     jw_object_begin(&jw, 0);
     jw_object_intmax(&jw, "total", p->total);
     if (p->throughput)
         jw_object_intmax(&jw, "throughput", p->throughput->curr_total);
     /*
      * and so on...
      * and maybe include the elapsed time in since the start_progress.
      */
     jw_end(&jw);
     trace2_data_json("progress", NULL, p->title, &jw);
     jw_release(&jw);

That will give you a single record summary of the progress meter
and you won't have to worry about any interleaving.

You could also add a bit to `struct progress` to let you opt-in
or opt-out of the message on a case-by-case basis.

Jeff



> ---
> One note: by putting trace collection into the progress library, we end
> up with data events which have titles like "Receiving objects" - not
> very machine-parseable. An alternative might be to ask for a
> machine-readable title in the progress struct, but I didn't think it was
> worth the code churn. However, I don't have experience with processing
> the trace data after it's been collected, so if this is a bigger problem
> than I think, please say so and I'll figure something out.
> 
> CI run here, although it failed on the same error Junio noted today[1]:
> https://github.com/nasamuffin/git/runs/668457062
> 
>   - Emily
> 
> [1]: https://lore.kernel.org/git/xmqqtv0kc2q1.fsf@gitster.c.googlers.com
> 
>   progress.c                  | 17 +++++++++++++++++
>   t/t0500-progress-display.sh | 26 ++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+)
> 
> diff --git a/progress.c b/progress.c
> index 75633e9c5e..6d2dcff0b6 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -265,6 +265,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>   	progress->title_len = utf8_strwidth(title);
>   	progress->split = 0;
>   	set_progress_signal();
> +	trace2_region_enter("progress", title, the_repository);
>   	return progress;
>   }
>   
> @@ -320,6 +321,22 @@ void stop_progress(struct progress **p_progress)
>   {
>   	finish_if_sparse(*p_progress);
>   
> +	if (p_progress && *p_progress) {
> +		trace2_data_intmax("progress", the_repository, "total_objects",
> +				   (*p_progress)->total);
> +
> +		if ((*p_progress)->throughput)
> +			trace2_data_intmax("progress", the_repository,
> +					   "total_bytes",
> +					   (*p_progress)->throughput->curr_total);
> +	}
> +
> +	trace2_region_leave("progress",
> +			    p_progress && *p_progress
> +				? (*p_progress)->title
> +				: NULL,
> +			    the_repository);
> +
>   	stop_progress_msg(p_progress, _("done"));
>   }
>   
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index d2d088d9a0..1ed1df351c 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -283,4 +283,30 @@ test_expect_success 'cover up after throughput shortens a lot' '
>   	test_i18ncmp expect out
>   '
>   
> +test_expect_success 'progress generates traces' '
> +	cat >in <<-\EOF &&
> +	throughput 102400 1000
> +	update
> +	progress 10
> +	throughput 204800 2000
> +	update
> +	progress 20
> +	throughput 307200 3000
> +	update
> +	progress 30
> +	throughput 409600 4000
> +	update
> +	progress 40
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
> +		"Working hard" <in 2>stderr &&
> +
> +	# t0212/parse_events.perl intentionally omits regions and data.
> +	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
> +	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
> +	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
> +	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
> +'
> +
>   test_done
> 
