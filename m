From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Tue, 18 May 2010 11:43:42 +0200
Message-ID: <4BF2614E.50003@drmicha.warpmail.net>
References: <878w7ieu4p.fsf@thor.thematica.it>	<4BF12C96.9030802@drmicha.warpmail.net>	<87vdamu2es.fsf@thor.thematica.it>	<4BF14508.8040307@drmicha.warpmail.net> <87d3wutt34.fsf@thor.thematica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 18 11:43:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEJKw-0002mF-5I
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 11:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab0ERJnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 05:43:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39126 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754689Ab0ERJnf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 05:43:35 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 22BB1F621A;
	Tue, 18 May 2010 05:43:35 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 18 May 2010 05:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OLUoeLXKWEnwy6yA2PnKk97KIE8=; b=ITUnviwsz/r7hnU465e/2VJod6FRmuUHI7XeWSZFMifnfsd9+8UFHqtAt36H+L/ajUcCp/R0yCxIgHeCU+Q0e0NFUhAXVJyk9vQw+8DryBNbZLiI17T1lE36qxM0xx1PFiyJSmRtETHawKuvHGnxFAoxg7HRnVBuY+7F2q1/kNs=
X-Sasl-enc: ZetS2u5cZPV6e4sU/fb+CljxrPzE6u2CA6cnxD2SUd3k 1274175814
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6E938553CD;
	Tue, 18 May 2010 05:43:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <87d3wutt34.fsf@thor.thematica.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147278>

Giuseppe Scrivano venit, vidit, dixit 17.05.2010 18:02:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Your patch puts both on stdout, and that is a problem, not only for
>> several test which could be adjusted, but also for scripters.
>>
>> A patch which *really* only changes '-h' to use stdout would certainly
>> not be objected. Actually, most calling sites are probably the "error
>> case" so that you only need to make sure that the "-h" path get's to use
>> a different output file descriptor.
> 
> I have changed my patches following your suggestions.

Thanks!

> I have also fixed two tests.
> 
> Cheers,
> Giuseppe
> 
> 
> 
> From 00100c61db30725011edf62e7e0e7bc6ac685cb0 Mon Sep 17 00:00:00 2001
> From: Giuseppe Scrivano <gscrivano@gnu.org>
> Date: Mon, 17 May 2010 17:34:41 +0200
> Subject: [PATCH] print the usage string on stdout instead of stderr
> 
> When -h is used, print usage messages on stdout.  If a command is invoked with
> wrong arguments then print the usage messages on stderr.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivano@gnu.org>
> ---
>  parse-options.c               |   64 +++++++++++++++++++++--------------------
>  t/t0040-parse-options.sh      |    8 +++--
>  t/t1502-rev-parse-parseopt.sh |    6 ++--
>  3 files changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 8546d85..c8aaf95 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -5,7 +5,7 @@
>  #include "color.h"
>  
>  static int parse_options_usage(const char * const *usagestr,
> -			       const struct option *opts);
> +			       const struct option *opts, int err);
>  
>  #define OPT_SHORT 1
>  #define OPT_UNSET 2
> @@ -352,7 +352,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
>  }
>  
>  static int usage_with_options_internal(const char * const *,
> -				       const struct option *, int);
> +				       const struct option *, int, int);
>  
>  int parse_options_step(struct parse_opt_ctx_t *ctx,
>  		       const struct option *options,
> @@ -380,10 +380,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  		if (arg[1] != '-') {
>  			ctx->opt = arg + 1;
>  			if (internal_help && *ctx->opt == 'h')
> -				return parse_options_usage(usagestr, options);
> +				return parse_options_usage(usagestr, options, 0);
>  			switch (parse_short_opt(ctx, options)) {
>  			case -1:
> -				return parse_options_usage(usagestr, options);
> +				return parse_options_usage(usagestr, options, 1);
>  			case -2:
>  				goto unknown;
>  			}
> @@ -391,10 +391,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  				check_typos(arg + 1, options);
>  			while (ctx->opt) {
>  				if (internal_help && *ctx->opt == 'h')
> -					return parse_options_usage(usagestr, options);
> +					return parse_options_usage(usagestr, options, 0);
>  				switch (parse_short_opt(ctx, options)) {
>  				case -1:
> -					return parse_options_usage(usagestr, options);
> +					return parse_options_usage(usagestr, options, 1);
>  				case -2:
>  					/* fake a short option thing to hide the fact that we may have
>  					 * started to parse aggregated stuff
> @@ -418,12 +418,12 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  		}
>  
>  		if (internal_help && !strcmp(arg + 2, "help-all"))
> -			return usage_with_options_internal(usagestr, options, 1);
> +			return usage_with_options_internal(usagestr, options, 1, 0);
>  		if (internal_help && !strcmp(arg + 2, "help"))
> -			return parse_options_usage(usagestr, options);
> +			return parse_options_usage(usagestr, options, 0);
>  		switch (parse_long_opt(ctx, arg + 2, options)) {
>  		case -1:
> -			return parse_options_usage(usagestr, options);
> +			return parse_options_usage(usagestr, options, 1);
>  		case -2:
>  			goto unknown;
>  		}
> @@ -468,7 +468,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  	return parse_options_end(&ctx);
>  }
>  
> -static int usage_argh(const struct option *opts)
> +static int usage_argh(const struct option *opts, FILE *outfile)
>  {
>  	const char *s;
>  	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
> @@ -479,72 +479,74 @@ static int usage_argh(const struct option *opts)
>  			s = literal ? "[%s]" : "[<%s>]";
>  	else
>  		s = literal ? " %s" : " <%s>";
> -	return fprintf(stderr, s, opts->argh ? opts->argh : "...");
> +	return fprintf(outfile, s, opts->argh ? opts->argh : "...");
>  }
>  
>  #define USAGE_OPTS_WIDTH 24
>  #define USAGE_GAP         2
>  
>  static int usage_with_options_internal(const char * const *usagestr,
> -				const struct option *opts, int full)
> +				const struct option *opts, int full, int err)
>  {
> +	FILE *outfile = err ? stderr : stdout;
> +
>  	if (!usagestr)
>  		return PARSE_OPT_HELP;
>  
> -	fprintf(stderr, "usage: %s\n", *usagestr++);
> +	fprintf(outfile, "usage: %s\n", *usagestr++);
>  	while (*usagestr && **usagestr)
> -		fprintf(stderr, "   or: %s\n", *usagestr++);
> +		fprintf(outfile, "   or: %s\n", *usagestr++);
>  	while (*usagestr) {
> -		fprintf(stderr, "%s%s\n",
> +		fprintf(outfile, "%s%s\n",
>  				**usagestr ? "    " : "",
>  				*usagestr);
>  		usagestr++;
>  	}
>  
>  	if (opts->type != OPTION_GROUP)
> -		fputc('\n', stderr);
> +		fputc('\n', outfile);
>  
>  	for (; opts->type != OPTION_END; opts++) {
>  		size_t pos;
>  		int pad;
>  
>  		if (opts->type == OPTION_GROUP) {
> -			fputc('\n', stderr);
> +			fputc('\n', outfile);
>  			if (*opts->help)
> -				fprintf(stderr, "%s\n", opts->help);
> +				fprintf(outfile, "%s\n", opts->help);
>  			continue;
>  		}
>  		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
>  			continue;
>  
> -		pos = fprintf(stderr, "    ");
> +		pos = fprintf(outfile, "    ");
>  		if (opts->short_name && !(opts->flags & PARSE_OPT_NEGHELP)) {
>  			if (opts->flags & PARSE_OPT_NODASH)
> -				pos += fprintf(stderr, "%c", opts->short_name);
> +				pos += fprintf(outfile, "%c", opts->short_name);
>  			else
> -				pos += fprintf(stderr, "-%c", opts->short_name);
> +				pos += fprintf(outfile, "-%c", opts->short_name);
>  		}
>  		if (opts->long_name && opts->short_name)
> -			pos += fprintf(stderr, ", ");
> +			pos += fprintf(outfile, ", ");
>  		if (opts->long_name)
> -			pos += fprintf(stderr, "--%s%s",
> +			pos += fprintf(outfile, "--%s%s",
>  				(opts->flags & PARSE_OPT_NEGHELP) ?  "no-" : "",
>  				opts->long_name);
>  		if (opts->type == OPTION_NUMBER)
> -			pos += fprintf(stderr, "-NUM");
> +			pos += fprintf(outfile, "-NUM");
>  
>  		if (!(opts->flags & PARSE_OPT_NOARG))
> -			pos += usage_argh(opts);
> +			pos += usage_argh(opts, outfile);
>  
>  		if (pos <= USAGE_OPTS_WIDTH)
>  			pad = USAGE_OPTS_WIDTH - pos;
>  		else {
> -			fputc('\n', stderr);
> +			fputc('\n', outfile);
>  			pad = USAGE_OPTS_WIDTH;
>  		}
> -		fprintf(stderr, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
> +		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
>  	}
> -	fputc('\n', stderr);
> +	fputc('\n', outfile);
>  
>  	return PARSE_OPT_HELP;
>  }
> @@ -552,7 +554,7 @@ static int usage_with_options_internal(const char * const *usagestr,
>  void usage_with_options(const char * const *usagestr,
>  			const struct option *opts)
>  {
> -	usage_with_options_internal(usagestr, opts, 0);
> +	usage_with_options_internal(usagestr, opts, 0, 1);
>  	exit(129);
>  }
>  
> @@ -565,9 +567,9 @@ void usage_msg_opt(const char *msg,
>  }
>  
>  static int parse_options_usage(const char * const *usagestr,
> -			       const struct option *opts)
> +			       const struct option *opts, int err)
>  {
> -	return usage_with_options_internal(usagestr, opts, 0);
> +	return usage_with_options_internal(usagestr, opts, 0, err);
>  }
>  
>  
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 3d450ed..2092450 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -7,7 +7,7 @@ test_description='our own option parser'
>  
>  . ./test-lib.sh
>  
> -cat > expect.err << EOF
> +cat > expect << EOF
>  usage: test-parse-options <options>
>  
>      -b, --boolean         get a boolean
> @@ -46,10 +46,12 @@ EOF
>  
>  test_expect_success 'test help' '
>  	test_must_fail test-parse-options -h > output 2> output.err &&
> -	test ! -s output &&
> -	test_cmp expect.err output.err
> +	test ! -s output.err &&
> +	test_cmp expect output
>  '
>  
> +mv expect expect.err
> +
>  cat > expect << EOF
>  boolean: 2
>  integer: 1729
> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
> index e504058..660487d 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -3,7 +3,7 @@
>  test_description='test git rev-parse --parseopt'
>  . ./test-lib.sh
>  
> -cat > expect.err <<EOF
> +cat > expect <<EOF
>  usage: some-command [options] <args>...
>  
>      some-command does foo and bar!
> @@ -38,8 +38,8 @@ extra1    line above used to cause a segfault but no longer does
>  EOF
>  
>  test_expect_success 'test --parseopt help output' '
> -	git rev-parse --parseopt -- -h 2> output.err < optionspec
> -	test_cmp expect.err output.err
> +	git rev-parse --parseopt -- -h > output < optionspec
> +	test_cmp expect output
>  '
>  
>  cat > expect <<EOF

I haven't checked whether this covers all code paths but other than that
it looks OK to me, and the tests pass.

Cheers,
Michael
