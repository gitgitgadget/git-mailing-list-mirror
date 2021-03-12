Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC75C4360C
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3876501E
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhCLKY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:24:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57652 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhCLKYe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 05:24:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9137BA149;
        Fri, 12 Mar 2021 05:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+6AHw0cObdHBL40JnmXUvx04JTg=; b=Xs/DqZwhyP457tC6+2du
        q4IoEeZ6NSkPOPr5do/decdVe0MqMjwDzldzfg2pzRAsbnjVmsgxLas9hRfIcsFF
        X2zqqttiGAFXrTfXKP/d2Bfqzmnm2vhXDRtNW8733YJffkKHhfd4zaP7xYz7lODU
        uP9qx9fyUDC1wZByXHQQC8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=u9d7JcK2NwPjy1fpY/ui/3SVvAbI4g0CGdJCcXsgZikTr4
        zEPn0WNESug7oGt+cCSPyqC7QXbD+RNRPEriwx0gT0qY6BPE9NtjwiZAEHBzM/bC
        Dnp6HTPBFe6JJkhxTfcCtO9VgHOYnnNZLkN7QWSD5Q9gxQTtVNnCURZAXYbUQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1633BA148;
        Fri, 12 Mar 2021 05:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6DF13BA147;
        Fri, 12 Mar 2021 05:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 22/37] rebase: teach pre-rebase to use hook.h
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-23-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 02:24:32 -0800
Message-ID: <xmqqr1kk7jq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 234FB572-831D-11EB-8A80-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -1318,6 +1319,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	char *squash_onto_name = NULL;
>  	int reschedule_failed_exec = -1;
>  	int allow_preemptive_ff = 1;
> +	struct run_hooks_opt hook_opt;
>  	struct option builtin_rebase_options[] = {
>  		OPT_STRING(0, "onto", &options.onto_name,
>  			   N_("revision"),
> @@ -1431,6 +1433,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	};
>  	int i;
>  
> +	run_hooks_opt_init_async(&hook_opt);
> +
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_rebase_usage,
>  				   builtin_rebase_options);
> @@ -2032,9 +2036,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	/* If a hook exists, give it a chance to interrupt*/
> +	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
>  	if (!ok_to_skip_pre_rebase &&
> -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
> -			argc ? argv[0] : NULL, NULL))
> +	    run_hooks("pre-rebase", &hook_opt))
>  		die(_("The pre-rebase hook refused to rebase."));

This may needlessly populate hook_opt.args even when run_hooks() is
not triggered, but that probably is OK.  Except for a place or two
where we call die(), the exit path from this function after this
point all eventually passes ...

>  	if (options.flags & REBASE_DIFFSTAT) {
> @@ -2114,6 +2118,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	ret = !!run_specific_rebase(&options, action);
>  
>  cleanup:

... this label, so everybody calls opt_clear() at the end, which is
good.

> +	run_hooks_opt_clear(&hook_opt);
>  	strbuf_release(&buf);
>  	strbuf_release(&revisions);
>  	free(options.head_name);
