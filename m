From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] revert/cherry-pick: Add --no-verify option, and pass it on to commit
Date: Wed, 03 Sep 2014 12:32:41 -0700
Message-ID: <xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Lars Gullik =?utf-8?Q?Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:32:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPGIV-00039o-SU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbaICTcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:32:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54498 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661AbaICTco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:32:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B1A03752B;
	Wed,  3 Sep 2014 15:32:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZKfdkRJ+h5e3NOxnN6rF6OdlT50=; b=O1TjRn
	4faCHFZ/uhBd8DwaNAMWCZJ0JVDeslOWe7nxdpFV4W14nTndSPl6qJg5OFNmpm3Q
	qkSeJfywxHieYyLSAumOZ+Sh+udnEOGnHBvlzLdOO5M9Ae1mbxGBOiVYj678mlIB
	hAijHxC0XSFkJN5Tbjvu1voTOBz7+QLSMxyZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rt9xx8xqN9syMSCDrkf3AEEcCQsXKrRl
	a5wgQl22cFYSqGcgvhT583ZvgD5g4UnFFuVbhq8eV2PceGcdRhk3lhhslULrD/a6
	L2Pk2EpMcD1eHc3KTWpkeTqQwfIMCJgkB5FKWwGDwlFBId78VrRClVqD26SNtFlz
	tZbMwk3DSwQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7FD3437529;
	Wed,  3 Sep 2014 15:32:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D22D837528;
	Wed,  3 Sep 2014 15:32:42 -0400 (EDT)
In-Reply-To: <1409753034-9459-3-git-send-email-johan@herland.net> (Johan
	Herland's message of "Wed, 3 Sep 2014 16:03:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 12F4578C-33A1-11E4-9D5D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256407>

Johan Herland <johan@herland.net> writes:

> Allow users to temporarily disable the pre-commit and commit-msg hooks
> when running "git revert" or "git cherry-pick", just like they currently
> can for "git commit".
>
> The --no-verify option is added to the sequencer machinery and handled
> like the other commit-related options.
>
> This fixes the failing t7503/t7504 test cases added previously.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  builtin/revert.c           | 1 +
>  sequencer.c                | 7 +++++++
>  sequencer.h                | 1 +
>  t/t7503-pre-commit-hook.sh | 4 ++--
>  t/t7504-commit-msg-hook.sh | 4 ++--
>  5 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index f9ed5bd..831c2cd 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -91,6 +91,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  			N_("option for merge strategy"), option_parse_x),
>  		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>  		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		OPT_BOOL('n', "no-verify", &opts->no_verify, N_("bypass pre-commit hook")),

I doubt we want this option to squat on '-n'; besides, it is already
taken by a more often used "--no-commit".

I thought that we added sanity checker for the options[] array to parse-options
API.  I wonder why it did not kick in...



>  		OPT_END(),
>  		OPT_END(),
>  		OPT_END(),
> diff --git a/sequencer.c b/sequencer.c
> index 3c060e0..3d68113 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -378,6 +378,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	if (opts->allow_empty_message)
>  		argv_array_push(&array, "--allow-empty-message");
>  
> +	if (opts->no_verify)
> +		argv_array_push(&array, "--no-verify");
> +
>  	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
>  	argv_array_clear(&array);
>  	return rc;
> @@ -773,6 +776,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.allow-ff"))
>  		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
> +	else if (!strcmp(key, "options.no-verify"))
> +		opts->no_verify = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.mainline"))
>  		opts->mainline = git_config_int(key, value);
>  	else if (!strcmp(key, "options.strategy"))
> @@ -944,6 +949,8 @@ static void save_opts(struct replay_opts *opts)
>  		git_config_set_in_file(opts_file, "options.record-origin", "true");
>  	if (opts->allow_ff)
>  		git_config_set_in_file(opts_file, "options.allow-ff", "true");
> +	if (opts->no_verify)
> +		git_config_set_in_file(opts_file, "options.no-verify", "true");
>  	if (opts->mainline) {
>  		struct strbuf buf = STRBUF_INIT;
>  		strbuf_addf(&buf, "%d", opts->mainline);
> diff --git a/sequencer.h b/sequencer.h
> index db43e9c..abfadc0 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -34,6 +34,7 @@ struct replay_opts {
>  	int allow_empty;
>  	int allow_empty_message;
>  	int keep_redundant_commits;
> +	int no_verify;
>  
>  	int mainline;
>  
> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
> index adc892b..b0307f4 100755
> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh
> @@ -80,13 +80,13 @@ test_expect_success '--no-verify with failing hook' '
>  
>  '
>  
> -test_expect_failure 'revert --no-verify with failing hook' '
> +test_expect_success 'revert --no-verify with failing hook' '
>  
>  	git revert --no-verify HEAD
>  
>  '
>  
> -test_expect_failure 'cherry-pick --no-verify with failing hook' '
> +test_expect_success 'cherry-pick --no-verify with failing hook' '
>  
>  	git cherry-pick --no-verify HEAD^
>  
> diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
> index 4f8b9fe..e819c25 100755
> --- a/t/t7504-commit-msg-hook.sh
> +++ b/t/t7504-commit-msg-hook.sh
> @@ -138,13 +138,13 @@ test_expect_success '--no-verify with failing hook' '
>  
>  '
>  
> -test_expect_failure 'revert --no-verify with failing hook' '
> +test_expect_success 'revert --no-verify with failing hook' '
>  
>  	git revert --no-verify HEAD
>  
>  '
>  
> -test_expect_failure 'cherry-pick --no-verify with failing hook' '
> +test_expect_success 'cherry-pick --no-verify with failing hook' '
>  
>  	git cherry-pick --no-verify HEAD^
