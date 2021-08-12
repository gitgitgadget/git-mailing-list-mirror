Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B71C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F3960C3F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhHLRv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:51:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62083 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLRv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 13:51:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CD02D58AC;
        Thu, 12 Aug 2021 13:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9bJFZyg3gCQqIUn1oGBBQkbHM4ALAhM04Ela6P
        IXt4Y=; b=MtmNCJEhqfVs1iSgX/xAP+QWEonLRUBGTq1y4iNswsXBgacgwF5cE1
        TGJsV79z1h4rHcKyO2zW58QdQ3JzBOwNfbJR4322m6iw7rxigOWhSVNQ60o28LMm
        STeBn8Z6JcEnq9liTKSojf+nSvimBx6Cvr8EIcfZeAO6RGCEqXAaQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 018D1D58AB;
        Thu, 12 Aug 2021 13:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66E51D58AA;
        Thu, 12 Aug 2021 13:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 2/6] hook: allow parallel hook execution
References: <20210812004258.74318-1-emilyshaffer@google.com>
        <20210812004258.74318-3-emilyshaffer@google.com>
Date:   Thu, 12 Aug 2021 10:51:01 -0700
In-Reply-To: <20210812004258.74318-3-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 11 Aug 2021 17:42:54 -0700")
Message-ID: <xmqqmtpm4kmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBFC5364-FB95-11EB-8D40-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> In many cases, there's no reason not to allow hooks to execute in
> parallel. run_processes_parallel() is well-suited - it's a task queue
> that runs its housekeeping in series, which means users don't
> need to worry about thread safety on their callback data. True
> multithreaded execution with the async_* functions isn't necessary here.
> Synchronous hook execution can be achieved by only allowing 1 job to run
> at a time.
>
> Teach run_hooks() to use that function for simple hooks which don't
> require stdin or capture of stderr.

Since run_hooks() has been using run_processes_parallel_tr2()
already in the ab/config-based-hooks-base topic, the above
description puzzled me quite a bit.  I think you meant to say with
this step you update the callers to pass either .jobs=1 or .jobs=0
in the hooks_opt, so that hooks _can_ run in parallel (as opposed
to using hardcoded jobs=1 in run_hooks() when calling the underlying
run_processes_parallel_tr2() function).

I do not think SYNC and ASYNC are great adjectives for what you are
doing in this step.  Wouldn't ASYNC mean "the caller tells the hooks
to run, continues without waiting for them to finish"?  In order to
let more than one hooks to run at the same time, the caller has to
continue without waiting for the first one it started so that it can
start the second one before the first one finishes (otherwise these
two hooks will not run at the same time), but ASYNC implys a lot
more than that.  After starting all of these hooks, the caller may
continue doing things that are not even related to these spawned
hooks if a hook is run asynchronously.

But I do not think that is what is happening here.  After all,
run_processes_parallel_tr2() will not return until all of the
subprocesses are culled.

Perhaps the distinction you are trying to express is easier to
convey to readers if you instead used the verb TO RUN with the
adverb SERIALLY vs IN PARALLEL (as opposed to SYNCHRONOUSLY vs
ASYNCHRONOUSLY)?

> diff --git a/builtin/hook.c b/builtin/hook.c
> index 4d39c9e75e..12c9126032 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -22,7 +22,7 @@ static const char * const builtin_hook_run_usage[] = {
>  static int run(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> -	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
>  	int ignore_missing = 0;
>  	const char *hook_name;
>  	struct list_head *hooks;
> @@ -32,6 +32,8 @@ static int run(int argc, const char **argv, const char *prefix)
>  			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
>  		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
>  			   N_("file to read into hooks' stdin")),
> +		OPT_INTEGER('j', "jobs", &opt.jobs,
> +			    N_("run up to <n> hooks simultaneously")),
>  		OPT_END(),
>  	};
>  	int ret;

OK, so by default "git hook" runs 1 at a time but we can instruct to
run the optimal number of jobs via "git hook -j0" etc.

> diff --git a/hook.c b/hook.c
> index 80e150548c..37f682c6d8 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -228,6 +228,28 @@ static int notify_hook_finished(int result,
>  	return 0;
>  }
>  
> +/*
> + * Determines how many jobs to use after we know we want to parallelize. First
> + * priority is the config 'hook.jobs' and second priority is the number of CPUs.
> + */
> +static int configured_hook_jobs(void)
> +{
> +	/*
> +	 * The config and the CPU count probably won't change during the process
> +	 * lifetime, so cache the result in case we invoke multiple hooks during
> +	 * one process.
> +	 */
> +	static int jobs = 0;
> +	if (jobs)
> +		return jobs;
> +
> +	if (git_config_get_int("hook.jobs", &jobs))
> +		/* if the config isn't set, fall back to CPU count. */
> +		jobs = online_cpus();
> +
> +	return jobs;
> +}

Not a suggestion to make this improvement as a part of this series,
but there already are more than several codepaths doing essentially
the same thing as above, taking their own configuration or
environment variables and falling back to online_cpus().

It may be worth introducing a shared helper function so that this
can become

	static int configured_hook_jobs(void)
	{
		static int jobs; /* no need for "= 0" */

		if (!jobs)
			jobs = default_parallelism("hook.jobs", NULL);
		return jobs;
	}

where the new helper takes the configuration and environment
variable names.

Thanks.
