Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A733C636C9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF946115B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhGSIow (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:44:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:53428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235013AbhGSIov (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 04:44:51 -0400
Received: (qmail 30604 invoked by uid 109); 19 Jul 2021 08:25:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jul 2021 08:25:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10910 invoked by uid 111); 19 Jul 2021 08:25:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jul 2021 04:25:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 19 Jul 2021 04:25:29 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] perf: fix when running with TEST_OUTPUT_DIRECTORY
Message-ID: <YPU2+bG8Nge5FKWv@coredump.intra.peff.net>
References: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
 <cb9d948646e8181e9c9c8dc35b37d48c692a92fb.1624024532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb9d948646e8181e9c9c8dc35b37d48c692a92fb.1624024532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 03:56:08PM +0200, Patrick Steinhardt wrote:

> When the TEST_OUTPUT_DIRECTORY is defined, then all test data will be
> written in that directory instead of the default directory located in
> "t/". While this works as expected for our normal tests, performance
> tests fail to locate and aggregate performance data because they don't
> know to handle TEST_OUTPUT_DIRECTORY correctly and always look at the
> default location.
> 
> Fix the issue by adding a `--results-dir` parameter to "aggregate.perl"
> which identifies the directory where results are and by making the "run"
> script awake of the TEST_OUTPUT_DIRECTORY variable.

OK, that makes sense. My first thought is that the aggregation script
could simply use $TEST_OUTPUT_DIRECTORY itself, but:

  - we don't actually export that (and changing that is likely to have
    undesirable secondary effects)

  - people may run aggregate separately anyway (I know I do in order to
    produce nice tables without having to pointlessly re-run all tests)

So the new option makes sense. It is a little less convenient when
running aggregate manually (you have to say "--results-dir" manually),
but it's better than not being able to do it at all. :)

A few notes / questions below:

> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 601d9f67dd..f5ed092ee5 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -45,7 +45,7 @@ export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
>  MODERN_GIT=$GIT_BUILD_DIR/bin-wrappers/git
>  export MODERN_GIT
>  
> -perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
> +perf_results_dir=$TEST_RESULTS_DIR

This line puzzled me a bit. Isn't $TEST_RESULTS_DIR already defined to
be $TEST_OUTPUT_DIRECTORY/test-results? If the change here is just for
clarity / readability that's OK by me. I just want to make sure I'm not
missing something.

> @@ -253,7 +253,10 @@ test_size () {
>  # and does it after running everything)
>  test_at_end_hook_ () {
>  	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
> -		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
> +		(
> +			cd "$TEST_DIRECTORY"/perf &&
> +			./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
> +		)
>  	fi
>  }

OK, and we pass it unconditionally, which should work because it will
always be set, even if you aren't overriding the default. Good.

> diff --git a/t/perf/run b/t/perf/run
> index c7b86104e1..d19dec258a 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -188,10 +188,10 @@ run_subsection () {
>  
>  	if test -z "$GIT_PERF_SEND_TO_CODESPEED"
>  	then
> -		./aggregate.perl $codespeed_opt "$@"
> +		./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $codespeed_opt "$@"
>  	else
> -		json_res_file="test-results/$GIT_PERF_SUBSECTION/aggregate.json"
> -		./aggregate.perl --codespeed "$@" | tee "$json_res_file"
> +		json_res_file=""$TEST_RESULTS_DIR"/$GIT_PERF_SUBSECTION/aggregate.json"
> +		./aggregate.perl --results-dir="$TEST_RESULTS_DIR" --codespeed "$@" | tee "$json_res_file"
>  		send_data_url="$GIT_PERF_SEND_TO_CODESPEED/result/add/json/"
>  		curl -v --request POST --data-urlencode "json=$(cat "$json_res_file")" "$send_data_url"
>  	fi

In the earlier hunks from perf-lib.sh, we got $TEST_RESULTS_DIR by
sourcing test-lib.sh. But in the "run" script, we don't. So who sets
it? Looks like...

> @@ -203,10 +203,17 @@ get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" "perf" "sendToCodespeed"
>  cd "$(dirname $0)"
>  . ../../GIT-BUILD-OPTIONS
>  
> -mkdir -p test-results
> -get_subsections "perf" >test-results/run_subsections.names
> +if test -n "$TEST_OUTPUT_DIRECTORY"
> +then
> +	TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
> +else
> +	TEST_RESULTS_DIR=test-results
> +fi

...we now do. Makes sense. And we will get TEST_OUTPUT_DIRECTORY
directly from GIT-BUILD-OPTIONS (or it won't be set at all if
unspecified).

So the whole thing looks good to me, assuming there is nothing confusing
about the one assignment I mentioned.

-Peff
