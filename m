Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D867420986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936089AbcI0SSC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:18:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60176 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935769AbcI0SSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:18:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A16874021A;
        Tue, 27 Sep 2016 14:17:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AjqgmUuXOZIqTXzTk+zFc/h2Gsk=; b=viMXT3
        UMs2BEoG07Wsfdz3//yT7i11td76o5cQBPRcQRaxxCwttrZl/ljHWhOQXfXSwFPj
        NYy40dkZpmsOiQzeXmYFGlebQbbdmo5+u/TXkISaiDuXDUgttHOrL9vDqsrcg0fU
        UeIcY2CvDb8/pwuNDzuSBrFv5T8ZSPcMNyMAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C8NVeHKfUHUQwcHr4R6ijLY1PHAmEeoP
        Z6kMwVH40cxALRnmctOaH8HvHdMYboH8bm0jtZ9l7LDfJGZfcFMW7fZrp2ytx2Eu
        Xyj5nXqYItONX69hOGFTm/Dbtmj3QYql/czjn2MtoQciPmMavqteXfYECbz2qcuP
        RsDlSvnC3q8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9968C40218;
        Tue, 27 Sep 2016 14:17:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DB0440216;
        Tue, 27 Sep 2016 14:17:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4 v4] submodules: make submodule-prefix option
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-2-git-send-email-bmwill@google.com>
Date:   Tue, 27 Sep 2016 11:17:57 -0700
In-Reply-To: <1474930003-83750-2-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 26 Sep 2016 15:46:40 -0700")
Message-ID: <xmqqtwd1nr56.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B85213E6-84DE-11E6-A85D-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +--submodule-prefix=<path>::
> +	Set a prefix which gives submodules context about the superproject that
> +	invoked it.  Only allowed for commands which support submodules.

This, and also the message in die(), uses a phrase "support
submodules", but it is unclear what it exactly means to the end
users and readers.

A "ls-files" that is recursively run as an implementation detail of
the "grep --recurse-submodules" would be taught to support this
option with this series.  Who is supporting submodules in that
context?

I'd imagine (close to) 100% of the people would say it is "grep"
that is supporting submodules, not "ls-files", but what this
paragraph and die() message want to express by the phrase "support
submodules" is the fact that "ls-files" knows how to react to
"--submodule-prefix" option.

I'd suggest not to worry too much about this phrasing at this point,
until we figure out exactly how we want to present these to end
users.  For now, perhaps drop the second sentence and replace it
with "The end-users are not expected to use this option" or
something like that?

> diff --git a/git.c b/git.c
> index 1c61151..b2b096a 100644
> --- a/git.c
> +++ b/git.c
> @@ -164,6 +164,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd, 1);
>  			if (envchanged)
>  				*envchanged = 1;
> +		} else if (!strcmp(cmd, "--submodule-prefix")) {
> +			if (*argc < 2) {
> +				fprintf(stderr, "No prefix given for --submodule-prefix.\n" );
> +				usage(git_usage_string);
> +			}
> +			setenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT, (*argv)[1], 1);
> +			if (envchanged)
> +				*envchanged = 1;
> +			(*argv)++;
> +			(*argc)--;
> +		} else if (skip_prefix(cmd, "--submodule-prefix=", &cmd)) {
> +			setenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT, cmd, 1);
> +			if (envchanged)
> +				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--bare")) {
>  			char *cwd = xgetcwd();
>  			is_bare_repository_cfg = 1;
> @@ -310,6 +324,7 @@ static int handle_alias(int *argcp, const char ***argv)
>   * RUN_SETUP for reading from the configuration file.
>   */
>  #define NEED_WORK_TREE		(1<<3)
> +#define SUPPORT_SUBMODULES	(1<<4)
>  
>  struct cmd_struct {
>  	const char *cmd;
> @@ -344,6 +359,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	}
>  	commit_pager_choice();
>  
> +	if (!help && (getenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT) &&
> +		      !(p->option & SUPPORT_SUBMODULES)))
> +		die("%s doesn't support submodules", p->cmd);

s/submodules/submodule-prefix/ at least.

>  	if (!help && p->option & NEED_WORK_TREE)
>  		setup_work_tree();
