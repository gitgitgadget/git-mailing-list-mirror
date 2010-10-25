From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 4/4] update-index: migrate to parse-options API
Date: Mon, 25 Oct 2010 03:30:39 -0700
Message-ID: <4CC55C4F.5020004@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com> <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino> <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino> <20101024081316.GA29630@burratino> <20101024081844.GE29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 12:31:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAKKV-00042r-Mf
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 12:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab0JYKa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 06:30:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57886 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0JYKa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 06:30:56 -0400
Received: by gwj21 with SMTP id 21so2338741gwj.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=MViGKy4PO7JzrUiMGENDkgj8t0AG5wgc3lJxArHIKt8=;
        b=KlFTLTcZ6OqBRtVpv+sbTR0hUicaZSY+qkkGY5NIqMiLuR1lRjcol/QKcvOtKwSxN2
         bly8oe6OYN+BM58LxQeTDa0V61av4bhsq/nAo64ZEtaC8d1VLLNs62ePz3ZexGCTKe55
         sH2lPDlwOL3ZwEORnd+07r9yyNv7LlNm2C8/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Pe3O42LvjiwtRvFZHVjwikj3gVfHLDrVl6Q4nVutMfmh3B6eE4OzbREQAyg6kIb16e
         jMt0s7RuBxqVv88LsccvLHBD6hDqA6yVPRAaw1vfWjE0Xr3/e/Gii7wxS8C8g4KHvP+/
         /42V7XYDoXR0bKI//TUGz7nLZOh7svzPxUu1g=
Received: by 10.151.46.15 with SMTP id y15mr12764425ybj.289.1288002655316;
        Mon, 25 Oct 2010 03:30:55 -0700 (PDT)
Received: from [192.168.1.105] ([75.85.182.25])
        by mx.google.com with ESMTPS id t4sm2736728ybe.1.2010.10.25.03.30.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 03:30:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20101020 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20101024081844.GE29630@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159940>

On 10/24/10 01:18, Jonathan Nieder wrote:
> ---
>  builtin/update-index.c |  389 +++++++++++++++++++++++++++++------------------
>  1 files changed, 240 insertions(+), 149 deletions(-)
> 

I would suspect that the code would get smaller. Too many callbacks?

>  
> -static const char update_index_usage[] =
> -"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] [<file>...]";
> +static const char * const update_index_usage[] = {
> +"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] [<file>...]",
> +	NULL
> +};

Please drop all this extraneous option stuff since it's already shown in
the -h output. The usage should list the different command modes. I know
that I've failed to do this in the past (and I should probably fix those).

Would

	git update-index [<options>] -- <file>

be enough?


> +static int cacheinfo_cb(struct parse_opt_ctx_t *ctx, const struct option *opt,
> +			int flags)
> +{
> +	unsigned char sha1[20];
> +	unsigned int mode;
> +	if (flags & OPT_UNSET)
> +		return error("--cacheinfo cannot be negated");

This shouldn't be possible right? I thought parse options made sure
NONEG options couldn't be negated... <goes and looks at patch 1>. Oh. It
seems like there will be a lot of duplicated code that way. Maybe we can
fixup patch 1 a bit so this isn't necessary.

> +	if (ctx->opt)
> +		return error("--cacheinfo does not accept an attached argument");

And this too.

> +	if (ctx->argc <= 3)
> +		return error("--cacheinfo requires three arguments");
> +	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
> +	    get_sha1_hex(*++ctx->argv, sha1) ||
> +	    add_cacheinfo(mode, sha1, *++ctx->argv, 0))
> +		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);

Hmm, it would be neat if die() always prefixed the death message with
the command in which it died.

> +	ctx->argc -= 3;
> +	return 0;
> +}
> +
> +static int stdin_cacheinfo_cb(struct parse_opt_ctx_t *ctx,
> +			      const struct option *opt, int flags)
> +{
> +	int *line_termination = opt->value;
> +	if (ctx->argc != 1 || ctx->opt)
> +		return error("--%s must be at the end", opt->long_name);
> +	if (flags & OPT_UNSET)
> +		return error("--%s cannot be negated", opt->long_name);
> +	allow_add = allow_replace = allow_remove = 1;
> +	read_index_info(*line_termination);
> +	return 0;
> +}
> +
> +static int last_arg_cb(struct parse_opt_ctx_t *ctx, const struct option *opt,
> +		       int flags)
> +{
> +	int *read_from_stdin = opt->value;
> +	if (ctx->argc != 1)
> +		return error("--%s must be at the end", opt->long_name);

Thinking out loud, this might be better served as an option flag
(PARSE_OPT_LAST_ARG?) to make it a bit more generic. Especially since
you use it twice.

> +	if (flags & OPT_UNSET)
> +		return error("--%s cannot be negated", opt->long_name);
> +	*read_from_stdin = 1;
> +	return 0;
> +}

And then this callback would go away and you could use a custom
OPTION_SET_PTR (or probably OPTION_SET_INT) right?


> +static int reupdate_cb(struct parse_opt_ctx_t *ctx, const struct option *opt,
> +		       int flags)
> +{
> +	int *has_errors = opt->value;
> +	const char *prefix = startup_info->prefix;

Doesn't the context also contain this? I know this is why you included
patch 3, but it doesn't seem strictly necessary to use startup_info over
ctx.

> +	setup_work_tree();
> +	*has_errors = do_reupdate(ctx->argc, ctx->argv,
> +				  prefix, !prefix ? 0 : strlen(prefix));
> +	ctx->argv += ctx->argc - 1;
> +	ctx->argc = 1;

At first I thought you forgot to make this a -= here. Then I realized
you're doing this to make parse options skip to the end of processing.
Perhaps you can just return PARSE_OPT_FINISH (equal to 1?) or something
to indicate to parse options that you're done parsing options entirely?
Or put a comment there so I don't get confused again.


> +	struct option options[] = {
> +		OPT_BIT('q', NULL, &refresh_args.flags,
> +			"continue refresh even when index needs update",
> +			REFRESH_QUIET),
[snip]
> +		OPT_SET_INT(0, "verbose", &verbose,
> +			"report actions to standard output", 1),
> +		{OPTION_CALLBACK, 0, "clear-resolve-undo", NULL, NULL,
> +			"(for porcelains) forget saved unresolved conflicts",
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG, resolve_undo_clear_cb},
> +		OPT_END()
> +	};

Any reason for OPT_SET_INT over OPT_BOOLEAN? Just curious.

> -			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
> -				usage(update_index_usage);
> -			die("unknown option %s", path);
> +			trace_printf("trace: update-index %s\n", path);

Maybe useful; but doubtful considering we already get the whole command
line already. Debugging stuff?
