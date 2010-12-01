From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] parse-options: sanity check PARSE_OPT_NOARG flag
Date: Wed, 01 Dec 2010 15:01:37 -0800
Message-ID: <7v7hftt7vy.fsf@alter.siamese.dyndns.org>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino> <20101130025223.GA5326@burratino>
 <20101130025551.GB5326@burratino> <4CF4B21B.5030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 00:01:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvgV-0005JA-2J
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab0LAXBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:01:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab0LAXBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:01:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4D562ABC;
	Wed,  1 Dec 2010 18:02:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B/nmdWBLcD/PqWQfrzyITojDQSU=; b=liFu1m
	nFTDnNY+8xLJ+0h6LgeP8xir3j7SFVRvMAyo+rZNJrjyXEX5QksGRGGBX1ycXCYJ
	TebB9yBglmpl2vAsc5BGo09VqxMpKbD7QuG8PKmxSqrnBgPambk144rgSSE5lptP
	eWEiMrRjeC5/aXeOcqGecdJiIRHG0niPs/e8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wl2JL4KoYP8nJKHo6CdV2CCbebvhlRWK
	rpJUzVgRClP98YbD89WSK7mf5uzJA1k7PtHbQHUIUhdnlJiil/CXEfLOp9NevKzG
	qgXPgZawEgfy34hN7whBPzeoNPKKyKGRaqAMjj8UQgLbzQBNaT/HSkMEKuJ0Ycfl
	aLvh2LnuYpQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 822D22ABA;
	Wed,  1 Dec 2010 18:02:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C27D2AB2; Wed,  1 Dec 2010
 18:01:57 -0500 (EST)
In-Reply-To: <4CF4B21B.5030401@gmail.com> (Stephen Boyd's message of "Tue\,
 30 Nov 2010 00\:13\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03827004-FD9F-11DF-B2C2-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162635>

Stephen Boyd <bebarino@gmail.com> writes:

> Looks like parse_options_check() is being called for each
> parse_options_step(). Here's a patch to fix that. Junio, this can
> probably be applied to maint.

Looks correct, but why is it a maint material?

> ---8<------>8-----
> Subject: [PATCH] parse-options: Don't call parse_options_check() so much
>
> parse_options_check() is being called for each invocation of
> parse_options_step() which can be quite a bit for some commands. The
> commit introducing this function cb9d398 (parse-options: add
> parse_options_check to validate option specs., 2009-06-09) had the
> correct motivation and explicitly states that parse_options_check()
> should be called from parse_options_start(). However, the implementation
> differs from the motivation. Fix it.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  builtin/blame.c    |    2 +-
>  builtin/shortlog.c |    2 +-
>  parse-options.c    |    7 +++----
>  parse-options.h    |    2 +-
>  4 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index f5fccc1..19a2ebf 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2310,7 +2310,7 @@ int cmd_blame(int argc, const char **argv, const
> char *prefix)
>  	dashdash_pos = 0;
>
>  	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
> -			    PARSE_OPT_KEEP_ARGV0);
> +			    PARSE_OPT_KEEP_ARGV0, options);
>  	for (;;) {
>  		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
>  		case PARSE_OPT_HELP:
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 2135b0d..8473391 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -269,7 +269,7 @@ int cmd_shortlog(int argc, const char **argv, const
> char *prefix)
>  	shortlog_init(&log);
>  	init_revisions(&rev, prefix);
>  	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
> -			    PARSE_OPT_KEEP_ARGV0);
> +			    PARSE_OPT_KEEP_ARGV0, options);
>
>  	for (;;) {
>  		switch (parse_options_step(&ctx, options, shortlog_usage)) {
> diff --git a/parse-options.c b/parse-options.c
> index 0fa79bc..196ba71 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -338,7 +338,7 @@ static void parse_options_check(const struct option
> *opts)
>
>  void parse_options_start(struct parse_opt_ctx_t *ctx,
>  			 int argc, const char **argv, const char *prefix,
> -			 int flags)
> +			 int flags, const struct option *options)
>  {
>  	memset(ctx, 0, sizeof(*ctx));
>  	ctx->argc = argc - 1;
> @@ -350,6 +350,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
>  	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
>  	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
>  		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
> +	parse_options_check(options);
>  }
>
>  static int usage_with_options_internal(struct parse_opt_ctx_t *,
> @@ -362,8 +363,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  {
>  	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
>
> -	parse_options_check(options);
> -
>  	/* we must reset ->opt, unknown short option leave it dangling */
>  	ctx->opt = NULL;
>
> @@ -452,7 +451,7 @@ int parse_options(int argc, const char **argv, const
> char *prefix,
>  {
>  	struct parse_opt_ctx_t ctx;
>
> -	parse_options_start(&ctx, argc, argv, prefix, flags);
> +	parse_options_start(&ctx, argc, argv, prefix, flags, options);
>  	switch (parse_options_step(&ctx, options, usagestr)) {
>  	case PARSE_OPT_HELP:
>  		exit(129);
> diff --git a/parse-options.h b/parse-options.h
> index ae8647d..828c056 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -180,7 +180,7 @@ struct parse_opt_ctx_t {
>
>  extern void parse_options_start(struct parse_opt_ctx_t *ctx,
>  				int argc, const char **argv, const char *prefix,
> -				int flags);
> +				int flags, const struct option *options);
>
>  extern int parse_options_step(struct parse_opt_ctx_t *ctx,
>  			      const struct option *options,
> -- 
> 1.7.3.2.614.g03864
