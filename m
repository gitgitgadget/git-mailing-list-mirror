Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A64C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244061AbiAEUe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:34:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55735 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiAEUe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:34:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7792E17B048;
        Wed,  5 Jan 2022 15:34:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=155SIbhwLPz3V6FNN2ikAgveKXddQcBWefsvlu
        Y6eak=; b=sgPSj04Y9OEXC958di3CTYdf9rO6VlavkYqwc6irm9Mwug1kRBAfGy
        k/YfFpmCwz3La5lyfP8TP3tlq+YywBxM7sWORzopc7WL+UqUMcX31kyfRviw7F37
        jGgQJBSKC9qzfDbVJGYp5Nw323H8r8IqfPl3T279jYZA96oGMdMqE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7120217B047;
        Wed,  5 Jan 2022 15:34:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF1B917B046;
        Wed,  5 Jan 2022 15:34:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4] builtin/reflog.c: use parse-options api for expire,
 delete subcommands
References: <pull.1175.v3.git.git.1641318061821.gitgitgadget@gmail.com>
        <pull.1175.v4.git.git.1641355561700.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 12:34:21 -0800
In-Reply-To: <pull.1175.v4.git.git.1641355561700.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Wed, 05 Jan 2022 04:06:01 +0000")
Message-ID: <xmqqy23thqgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDCE1E5E-6E66-11EC-BC36-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int expire_unreachable_callback(const struct option *opt,
> +				 const char *arg,
> +				 int unset)
> +{
> +	struct cmd_reflog_expire_cb *cmd = opt->value;
> +
> +	if (parse_expiry_date(arg, &cmd->expire_unreachable))
> +			die(_("malformed expiration date '%s'"), arg);

Was there a reason to indent this overly deep?  The same for the
other die() we can see below.

> +	cmd->explicit_expiry |= EXPIRE_UNREACH;
> +	return 0;
> +}
> +
> +static int expire_total_callback(const struct option *opt,
> +				 const char *arg,
> +				 int unset)
> +{
> +	struct cmd_reflog_expire_cb *cmd = opt->value;
> +
> +	if (parse_expiry_date(arg, &cmd->expire_total))
> +			die(_("malformed expiration date '%s'"), arg);

We used to say "'%s' is not a valid timestamp".  The same for the
other die() we saw earlier.

"expiration date" is more specific to "timestamp" and in that sense,
the new message might be an improvement, but if we were to improve
messages better, perhaps we should go one step further and tell the
user which option got an invalid value, e.g.

		die(_("invalid timestamp '%s' given to '--%s'"),
		    arg, opt->long_name);

perhaps.

>  static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  {
>  	struct cmd_reflog_expire_cb cmd = { 0 };
>  	timestamp_t now = time(NULL);
>  	int i, status, do_all, all_worktrees = 1;
> -	int explicit_expiry = 0;
>  	unsigned int flags = 0;
>  	int verbose = 0;
>  	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
> +	const struct option options[] = {
> +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
> +			EXPIRE_REFLOGS_DRY_RUN),
> +		OPT_BIT(0, "rewrite", &flags,
> +			N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
> +			EXPIRE_REFLOGS_REWRITE),
> +		OPT_BIT(0, "updateref", &flags,
> +			N_("update the reference to the value of the top reflog entry"),
> +			EXPIRE_REFLOGS_UPDATE_REF),
> +		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),

Somebody else might suggest OPT__VERBOSE() or OPT__VERBOSITY(), but
for the purpose of this "use parse-options" topic, a simple BOOL is
sufficient.  When we start supporting different levels of verbosity,
we can switch to more featureful variant (and change the behaviour).

> +static const char * reflog_delete_usage[] = {
> +	N_("git reflog delete [--rewrite] [--updateref] "
> +   "[--dry-run | -n] [--verbose] <refs>..."),

Funny indentation still here?

> +	NULL
> +};
> +
>  static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  {
>  	struct cmd_reflog_expire_cb cmd = { 0 };
> @@ -703,34 +725,28 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  	unsigned int flags = 0;
>  	int verbose = 0;
>  	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
> +	const struct option options[] = {
> +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
> +				EXPIRE_REFLOGS_DRY_RUN),

This is formatted quite differently from the one in reflog_expire().
Be consistent and make sure each line of what's inside
"OPT_BIT(...)" begins at the same column, e.g.

		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
			EXPIRE_REFLOGS_DRY_RUN),

> +	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
>  
>  	if (verbose)
>  		should_prune_fn = should_expire_reflog_ent_verbose;
>  
> -	if (argc - i < 1)
> +	if (argc < 1)
>  		return error(_("no reflog specified to delete"));

Nice.

> -	for ( ; i < argc; i++) {
> +	for (i = 0; i < argc; i++) {
>  		const char *spec = strstr(argv[i], "@{");
>  		char *ep, *ref;
>  		int recno;

Nice, too.

Thanks.
