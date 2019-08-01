Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9599B1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbfHAVeo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:34:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59278 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHAVeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:34:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD35C1662AA;
        Thu,  1 Aug 2019 17:34:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vQtOwlR4SQ6FgomhUf10EFTDpoQ=; b=IF8LEa
        +ts8Qai2EYqGPq5PpUMjCqQg2elUeFdkm3HTmxJyjFL6fYuowZUBhpr/x3gMOCfk
        Z4TswzZeSlrl5uBsZfOH0x7GihuRygHwwYPbxcA9KW8CUJawpNdIsXlERJTgCBuD
        KqxiNHwMUHTvBfq/oPb1ruu7OPBBGoxdY2qiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tZtGg9xtunZ0xj+jEkUrNF/xj802tRgt
        60/hPEhMQjnaCEjJAQ4dQpRGD3HbtHUB6Ee3SY8j54zBKuYryxlK8w4KqzaU2XMn
        ezWbgMKyoBbY3+YbH9IeunBwF7qxyDlASgZA5NvYCLV3DNmK9+vJMloFkxDQqjk6
        zOI9rddnMwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C54001662A8;
        Thu,  1 Aug 2019 17:34:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D9C71662A7;
        Thu,  1 Aug 2019 17:34:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] trace2: trim whitespace in start message in perf target format
References: <pull.298.git.gitgitgadget@gmail.com>
        <834ee95cd2fe919c7a5a2d3cc3d647cfdeebe9e6.1564603467.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Aug 2019 14:34:37 -0700
In-Reply-To: <834ee95cd2fe919c7a5a2d3cc3d647cfdeebe9e6.1564603467.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Wed, 31 Jul 2019
        13:04:29 -0700 (PDT)")
Message-ID: <xmqqef24muxe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29E52B68-B4A4-11E9-9D63-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Trim leading/trailing whitespace from the command line
> printed in the "start" message in the perf target format.
>
> We use `sq_quote_argv_pretty()` to format the message
> and it adds a leading space to the output.  Trim that.

strbuf_trim() not just drops a single leading space, but removes
consecutive spaces from both ends.  But the first char after the SP
comes from the first arg, and it can never be a whitespace (as a
payload that begins with a whitespace will be quoted, so it will be
a single quote), and the last char in the buffer would also be
either a closing single quote (if the last argument ends with a
whitespace) or a non whitespace "safe" character, so it is safe to
use strbuf_trim() here.

I wonder if we want to lose the prepending of SP from
sq_quote_argv_pretty(), though:

 * run-command.c::trace_run_command() does rely on having SP there,
   so the caller needs adjusting if we did so.

 * trace.c::trace_argv_vprintf_fl() also needs SP there after the
   caller supplied format.

 * trace.c::print_command_performance_atexit() expects command_line
   begins with the extra SP left by the sq_quote_argv_pretty()
   called by the trace_command_performance(); the format string
   given to trace_performance_leave() there needs adjusting.


By the way, use of sq_quote_argv_pretty() in builtin/rebase.c on
opts->git_am_opts.argv done in run_specific_rebase() is dubious.
The argv array is made into a single string that safely uses sq,
appropriate to feed a shell.  But that string is passed as the
"value" parameter to add_var() helper that expects to receive a raw
value (hence it calls sq_quote_buf() on the value), resulting in a
string that is doubly quoted.  I am not sure if that was intended.

In any case, the patch itself obviously look correct.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  trace2/tr2_tgt_perf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index 4a9d99218b..ed4e708f28 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -185,6 +185,7 @@ static void fn_start_fl(const char *file, int line,
>  	struct strbuf buf_payload = STRBUF_INIT;
>  
>  	sq_quote_argv_pretty(&buf_payload, argv);
> +	strbuf_trim(&buf_payload);
>  
>  	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
>  			 NULL, NULL, &buf_payload);
