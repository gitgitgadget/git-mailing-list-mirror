Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303181F859
	for <e@80x24.org>; Tue, 16 Aug 2016 17:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbcHPR1k (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:27:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbcHPR1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:27:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF8D34AD5;
	Tue, 16 Aug 2016 13:27:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=76rtTI9Psa8mlQ0j6DX0HpbZa4g=; b=uDXl2n
	7hJStFQxAPLNSUkbhZ7FznAzbbnfz79BvxhyKV1/E7Vlho2uI7JpM3arJFS4TEGc
	PgsPjaqwE0B9UxCPEsPW5I540chL66rLwb32osGA1PY7HwehB9ppuuUZgSjDGIZm
	Ar2bdxtefMtjFPMGOczenUPpO20UJbQ2qdq+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tMdp6NC8d3hhvlWoOZEYeqrhjVAnHO8o
	bxu83XCDw5rObszm+2xLV2tYLN0WTmSVe1pEFG4NmKoGUWR7sYpaSeG1JacNMP25
	5gOHrmqsnhVL6aV327qDZBxrYRcuePQyXodp/CLmt27J7EQV/3kMGmqzKGvv7f5y
	RR4ud6Hw+Ok=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44EDA34AD4;
	Tue, 16 Aug 2016 13:27:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F84834AD3;
	Tue, 16 Aug 2016 13:27:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ralf Thielow <ralf.thielow@gmail.com>
Cc:	git@vger.kernel.org, larsxschneider@gmail.com, me@jnm2.com,
	philipoakley@iee.org, john@keeping.me.uk
Subject: Re: [PATCH v3] help: make option --help open man pages only for Git commands
References: <20160815053628.3793-1-ralf.thielow@gmail.com>
	<20160816162030.27754-1-ralf.thielow@gmail.com>
Date:	Tue, 16 Aug 2016 10:27:35 -0700
In-Reply-To: <20160816162030.27754-1-ralf.thielow@gmail.com> (Ralf Thielow's
	message of "Tue, 16 Aug 2016 18:20:30 +0200")
Message-ID: <xmqq60r0ei9k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9FE70AA-63D6-11E6-8C05-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  builtin/help.c  | 30 +++++++++++++++++++++++-------
>  git.c           | 15 ++++++++++++++-
>  t/t0012-help.sh | 15 +++++++++++++++
>  3 files changed, 52 insertions(+), 8 deletions(-)
>  create mode 100755 t/t0012-help.sh
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 8848013..76f07c7 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -37,7 +37,9 @@ static int show_all = 0;
>  static int show_guides = 0;
>  static unsigned int colopts;
>  static enum help_format help_format = HELP_FORMAT_NONE;
> +static int swapped = 0;

This is not the first offender (show_guides above does so, too), but
please do not initialize static explicitly to 0 or NULL.

>  static struct option builtin_help_options[] = {
> +	OPT_BOOL('s', "swapped", &swapped, "mark as being called by <cmd> --help"),
>  	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
>  	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
> @@ -433,10 +435,29 @@ static void list_common_guides_help(void)
>  	putchar('\n');
>  }
>  
> +static const char* check_git_cmd(const char* cmd)

Style: "static const char *check_git_cmd(const char *cmd)".  The
asterisk that turns the base type to a pointer to the base type
sticks to the identifier, not to the type.

> +{
> +	char *alias;
> +
> +	if (is_git_command(cmd))
> +		return cmd;
> +
> +	alias = alias_lookup(cmd);
> +	if (alias) {
> +		printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
> +		free(alias);
> +		exit(0);
> +	}
> +
> +	if (swapped)
> +		return help_unknown_cmd(cmd);

I am guilty of suggesting "swapped"; even if we are going to mark
this as OPT_HIDDEN, I think we should be able to think of a better
name.  I think the meaning of this boolean is "we know that this is
not a guide and is meant to be a command.", and I hope we can come
up with a name that concisely expresses that (e.g. "--not-a-guide",
"--must-be-a-command").

> +	return cmd;
> +}
> +
>  int cmd_help(int argc, const char **argv, const char *prefix)
>  {
>  	int nongit;
> -	char *alias;
>  	enum help_format parsed_help_format;
>  
>  	argc = parse_options(argc, argv, prefix, builtin_help_options,
> @@ -476,12 +497,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	if (help_format == HELP_FORMAT_NONE)
>  		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
>  
> -	alias = alias_lookup(argv[0]);
> -	if (alias && !is_git_command(argv[0])) {
> -		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
> -		free(alias);
> -		return 0;
> -	}
> +	argv[0] = check_git_cmd(argv[0]);
>  
>  	switch (help_format) {
>  	case HELP_FORMAT_NONE:
> diff --git a/git.c b/git.c
> index 0f1937f..71ea983 100644
> --- a/git.c
> +++ b/git.c
> @@ -528,10 +528,23 @@ static void handle_builtin(int argc, const char **argv)
>  	strip_extension(argv);
>  	cmd = argv[0];
>  
> -	/* Turn "git cmd --help" into "git help cmd" */
> +	/* Turn "git cmd --help" into "git help --swapped cmd" */
>  	if (argc > 1 && !strcmp(argv[1], "--help")) {
> +		struct argv_array args;
> +		int i;
> +
>  		argv[1] = argv[0];
>  		argv[0] = cmd = "help";
> +
> +		argv_array_init(&args);
> +		for (i = 0; i < argc; i++) {
> +			argv_array_push(&args, argv[i]);
> +			if (i == 0)

It is more idiomatic to say

			if (!i)

around here.

> +				argv_array_push(&args, "--swapped");

> +		}
> +
> +		argc++;
> +		argv = argv_array_detach(&args);
>  	}
>  
>  	builtin = get_builtin(cmd);

The code does this after it:

	if (builtin)
        	exit(run_builtin(...));

and returns.  If we didn't get builtin, we risk leaking args.argv
here, but we assume argv[0] = cmd = "help" is always a builtin,
which I think is a safe assumption, so the code is OK.  Static
checkers that are only half intelligent may yell at you for not
releasing the resources, though.

> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> new file mode 100755
> index 0000000..6f700b1
> --- /dev/null
> +++ b/t/t0012-help.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +test_description='help'
> +
> +. ./test-lib.sh
> +
> +test_expect_success "pass --help to common guide" "
> +	cat <<-EOF >expected &&
> +		git: 'revisions' is not a git command. See 'git --help'.
> +	EOF
> +	(git revisions --help 2>actual || true) &&
> +	test_i18ncmp expected actual
> +"
> +
> +test_done
