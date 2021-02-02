Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F052C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B2164DA3
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhBBRpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:45:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53150 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhBBRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 12:43:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0BBD93DDD;
        Tue,  2 Feb 2021 12:43:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IN9Ofi+f3WCCbViSIWUpx1Ntbok=; b=k9Y+5X
        nrAJ8tvIME6KEEP9nw7kRUaDqFQIqmDZ0ZqTLs2aU1MvUhiWBlzj473nCC6+f/DK
        NZg+kRpEcZNs0fVtaW5/oVZr4Wmksy+4csaJyi4v0R7LfjheWL49xYZ9T618Mzl/
        2FmdOvzKnkSe5xTc3g50OhqmmLFYofdrYuFZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h8q6vzhuibHzrZ6Lo/E1n1pX0PbdE8Dn
        AfyxDDHzAghg4x/YkItS5aXYFTok/grB8ikciXWYm8LkrWCL/rdU0aJWps7UvNkU
        zQkCU0I+0YrWgXjuQyrL47447It0dTtZqAjqQdNIHZXz6JDbmXJsHy3AsYnwTCvd
        nR/niiVo+vo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9877593DDC;
        Tue,  2 Feb 2021 12:43:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D08193DDB;
        Tue,  2 Feb 2021 12:43:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v3 1/1] MacOS: precompose_argv_prefix()
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
        <20210202151158.27028-1-tboegi@web.de>
Date:   Tue, 02 Feb 2021 09:43:10 -0800
In-Reply-To: <20210202151158.27028-1-tboegi@web.de> (tboegi@web.de's message
        of "Tue, 2 Feb 2021 16:11:58 +0100")
Message-ID: <xmqqk0rqgyc1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E352CA0-657E-11EB-A73F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index 1e352dd8f7..e3851dd1c0 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -35,7 +35,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  	 */
>  	rev.diffopt.ita_invisible_in_index = 1;
>
> -	precompose_argv(argc, argv);
> +	prefix = precompose_argv_prefix(argc, argv, prefix);

When git.c::cmd_main() calls run_builtin() to call cmd_diff_files(),
precompose would have already been called, and we end up calling the
already processed argv[] and prefix again here.

Is there a codepath where cmd_diff_files() gets called _without_
making the call to precompose() in git.c::run_builtin()?

Previous round removed the precompose call and I thought the logic
was sound, but I must be missing something.

The same question applies to other built-ins.

Standalone commands that go through execv_dashed_external() should
still have a call to precompose() in their own cmd_main() as the
prefix is not affected for them, but I suspect that they are not
expected to be run from a subdirectory to begin with?

> +const char *precompose_argv_prefix(int argc, const char **argv, const char *prefix)
> +{
> +	int i = 0;
>
>  	while (i < argc) {
> -		size_t namelen;
> -		oldarg = argv[i];
> -		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
> -			newarg = reencode_string_iconv(oldarg, namelen, ic_precompose, 0, NULL);
> -			if (newarg)
> -				argv[i] = newarg;
> -		}
> +		argv[i] = precompose_string_if_needed(argv[i]);
>  		i++;
>  	}
> -	iconv_close(ic_precompose);
> +	if (prefix) {
> +		prefix = precompose_string_if_needed(prefix);
> +	}
> +	return prefix;
>  }

OK.  I missed that the previous round did return NULL when the
original should have been returned.  It is clear that this caller,
and the updated precompose_string_if_needed(), returns the original.

Good.

> diff --git a/git.c b/git.c
> index a00a0a4d94..16a485fbe7 100644
> --- a/git.c
> +++ b/git.c
> @@ -420,7 +420,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  			int nongit_ok;
>  			prefix = setup_git_directory_gently(&nongit_ok);
>  		}
> -
> +		prefix = precompose_argv_prefix(argc, argv, prefix);
>  		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
>  		    !(p->option & DELAY_PAGER_CONFIG))
>  			use_pager = check_pager_config(p->cmd);
> diff --git a/parse-options.c b/parse-options.c
> index f0507432ee..fbea16eaf5 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -869,7 +869,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  		usage_with_options(usagestr, options);
>  	}
>
> -	precompose_argv(argc, argv);
> +	precompose_argv_prefix(argc, argv, NULL);

The correctness of this call also relies on that precompose() is
expected to be idempotent (not saying it is necessarily bad, but
just making a note), as argv[] must have been already processed
before a built-in calls this function.

> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
> index 54ce19e353..8f7b49221f 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -191,6 +191,22 @@ test_expect_failure 'handle existing decomposed filenames' '
>  	test_must_be_empty untracked
>  '
>
> +test_expect_success "unicode decomposed: git restore -p . " '
> +	DIRNAMEPWD=dir.Odiarnfc &&
> +	DIRNAMEINREPO=dir.$Adiarnfc &&
> +	export DIRNAMEPWD DIRNAMEINREPO &&

The above is fine, but

> +	git init $DIRNAMEPWD &&
> +	(
> +		cd $DIRNAMEPWD &&
> +		mkdir $DIRNAMEINREPO &&
> +		cd $DIRNAMEINREPO &&

Shouldn't these variable references be "quoted" for readers (I know
they happen to be free of $IFS whitespaces etc., but readers and
more importantly those who may casually cut-and-paste would not
know)?

> +		echo "Initial" >file &&
> +		git add file &&
> +		echo "More stuff" >>file &&
> +		echo y | git restore -p .
> +	)
> +'
> +
>  # Test if the global core.precomposeunicode stops autosensing
>  # Must be the last test case
>  test_expect_success "respect git config --global core.precomposeunicode" '
> --
> 2.30.0.155.g66e871b664

Thanks.
