Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D048208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 01:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbdIFBRY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 21:17:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56019 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750968AbdIFBRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 21:17:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1AFCAF399;
        Tue,  5 Sep 2017 21:17:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=wst/+Z2UHUw44aAKG8P4lxX0q7M=; b=F/NORHzQ7xwLJe7iOoj6
        nJJ+vnViAQMo7Vi7vppIU/OT5aUW16trP4Cwu3xn8o5NEsehl0NMdSV+/HVCg435
        P3Iaj7fzoBSyqToJnn8yc4JIwSpGgskZUjAe+6gRgrsG4UY4vSs30PRQRIyMk3Kk
        yG0pP4HNdwQdCInr07OD7xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=wZNUCegPnTpFSZ0l4683szgBBzaa/H/yvQMHBob8SnHhlm
        7p5V9/zz2xt0Xoj2EI3M4L1bYkgZuXaTHcsjyvdiusKB7oHQcWS8Y+FuAC7UXsCp
        Uxg1OxYmIfkPFeZQyoO8L8yuuNMcsBUYcV9aOEbGsKjoveSvzzkAFIj4uk3Pw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8411AF398;
        Tue,  5 Sep 2017 21:17:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 157DEAF397;
        Tue,  5 Sep 2017 21:17:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCHv2] pull: honor submodule.recurse config option
References: <40ecf559-0348-b838-72f7-0ad7746a7072@morey-chaisemartin.com>
Date:   Wed, 06 Sep 2017 10:17:21 +0900
Message-ID: <xmqqvakwaan2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22E71802-92A1-11E7-8DD0-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> "git pull" supports a --recurse-submodules option but does not parse the
> submodule.recurse configuration item to set the default for that option.
> Meanwhile "git fetch" does support submodule.recurse, producing
> confusing behavior: when submodule.recurse is enabled, "git pull"
> recursively fetches submodules but does not update them after fetch.
>
> Handle submodule.recurse in "git pull" to fix this.
>
> Reported-by: Magnus Homann <magnus@homann.se>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>
> Changes since v1:
>  * Cleanup commit message
>  * Add test
>  * Remove extra var in code and fallthrough to git_default_config
>
>  builtin/pull.c            |  4 ++++
>  t/t5572-pull-submodule.sh | 10 ++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 7fe281414..ce8ccb15b 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -325,6 +325,10 @@ static int git_pull_config(const char *var, const char *value, void *cb)
>  	if (!strcmp(var, "rebase.autostash")) {
>  		config_autostash = git_config_bool(var, value);
>  		return 0;
> +	} else if (!strcmp(var, "submodule.recurse")) {
> +		recurse_submodules = git_config_bool(var, value) ?
> +			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
> +		return 0;
>  	}
>  	return git_default_config(var, value, cb);
>  }

If I am reading the existing code correctly, things happen in
cmd_pull() in this order:

 - recurse_submodules is a file-scope static that is initialized to
   RECURSE_SUBMODULES_DEFAULT

 - pull_options[] is given to parse_options() so that
   submodule-config.c::option_fetch_parse_recurse_submodules() can
   read "--recurse-submodules=<value>" from the command line to
   update recurse_submodules.

 - git_pull_config() is given to git_config() so that settings in
   the configuration files are read.

Care must be taken to make sure that values given from the command
line is never overriden by the default value specified in the
configuration system because the order of the second and third items
in the above are backwards from the usual flow.  This patch does not
seem to have any such provision.

Existing handling of "--autostash" vs "rebase.autostash" solves this
issue by having opt_autostash and config_autostash as two separate
variables, so I suspect that something similar to it must be there,
at least, for this new configuration.

If we want to keep the current code structure, that is.  I do not
recall if we did not notice the fact that the order of options and
config parsing is backwards and unknowingly worked it around with
two variables when we added the rebase.autostash thing, or we knew
the order was unusual but there was a good reason to keep that
unusual order (iow, if we simply swapped the order of
parse_options() and git_config() calls, there are things that will
break).  

If it is not the latter, perhaps we may want to flip the order of
config parsing and option parsing around?  That will allow us to fix
the handling of autostash thing to use only one variable, and also
fix your patch to do the right thing.

> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index 077eb07e1..1b3a3f445 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -65,6 +65,16 @@ test_expect_success 'recursive pull updates working tree' '
>  	test_path_is_file super/sub/merge_strategy.t
>  '
>  
> +test_expect_success "submodule.recurse option triggers recursive pull" '
> +	test_commit -C child merge_strategy_2 &&
> +	git -C parent submodule update --remote &&
> +	git -C parent add sub &&
> +	git -C parent commit -m "update submodule" &&
> +
> +	git -C super -c submodule.recurse pull --no-rebase &&
> +	test_path_is_file super/sub/merge_strategy_2.t
> +'

This new test does not test interactions with submodule.recurse
configuration and --recurse-submodules=<value> from the command
line.  It would be necessary to add tests to cover the permutations
in addition to the basic test we see above.

Thanks.
