From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a simple option parser.
Date: Sat, 13 Oct 2007 15:39:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710131519510.25221@racer.site>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <1192282153-26684-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 16:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igi9H-00014N-3h
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbXJMOjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 10:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbXJMOjQ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:39:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:46013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754384AbXJMOjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 10:39:15 -0400
Received: (qmail invoked by alias); 13 Oct 2007 14:39:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 13 Oct 2007 16:39:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EO+dUZMLEg36kdry/8uyCm0HXpzqaCb2cA8hYQX
	tJvCtj5A0oN6iR
X-X-Sender: gene099@racer.site
In-Reply-To: <1192282153-26684-2-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 13 Oct 2007, Pierre Habouzit wrote:

> Aggregation of single switches is allowed:
>   -rC0 is the same as -r -C 0 (supposing that -C wants an arg).

I'd be more interested in "-rC 0" working...  Is that supported, too?

> diff --git a/parse-options.c b/parse-options.c
> new file mode 100644
> index 0000000..07abb50
> --- /dev/null
> +++ b/parse-options.c
> @@ -0,0 +1,227 @@
> +#include "git-compat-util.h"
> +#include "parse-options.h"
> +#include "strbuf.h"
> +
> +#define OPT_SHORT 1
> +#define OPT_UNSET 2
> +
> +struct optparse_t {
> +	const char **argv;
> +	int argc;
> +	const char *opt;
> +};
> +
> +static inline const char *get_arg(struct optparse_t *p)
> +{
> +	if (p->opt) {
> +		const char *res = p->opt;
> +		p->opt = NULL;
> +		return res;
> +	}
> +	p->argc--;
> +	return *++p->argv;
> +}

This is only used once; I wonder if it is really that more readable having 
this as a function in its own right.

> +static inline const char *skippfx(const char *str, const char *prefix)

Personally, I do not like abbreviations like that.  They do not save that 
much screen estate (skip_prefix is only 4 characters longer, but much more 
readable).  Same goes for "cnt" later.

> +static int get_value(struct optparse_t *p, struct option *opt, int flags)
> +{
> +	if (p->opt && (flags & OPT_UNSET))
> +		return opterror(opt, "takes no value", flags);
> +
> +	switch (opt->type) {
> +	case OPTION_BOOLEAN:
> +		if (!(flags & OPT_SHORT) && p->opt)
> +			return opterror(opt, "takes no value", flags);
> +		if (flags & OPT_UNSET) {
> +			*(int *)opt->value = 0;
> +		} else {
> +			(*(int *)opt->value)++;
> +		}
> +		return 0;
> +
> +	case OPTION_STRING:
> +		if (flags & OPT_UNSET) {
> +			*(const char **)opt->value = (const char *)NULL;
> +		} else {
> +			if (!p->opt && p->argc < 1)
> +				return opterror(opt, "requires a value", flags);
> +			*(const char **)opt->value = get_arg(p);
> +		}
> +		return 0;
> +
> +	case OPTION_INTEGER:
> +		if (flags & OPT_UNSET) {
> +			*(int *)opt->value = 0;
> +		} else {
> +			const char *s;
> +			if (!p->opt && p->argc < 1)
> +				return opterror(opt, "requires a value", flags);
> +			*(int *)opt->value = strtol(*p->argv, (char **)&s, 10);
> +			if (*s)
> +				return opterror(opt, "expects a numerical value", flags);
> +		}
> +		return 0;
> +
> +	default:
> +		die("should not happen, someone must be hit on the forehead");

:-P

> +static int parse_long_opt(struct optparse_t *p, const char *arg,
> +                          struct option *options, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		const char *rest;
> +		int flags = 0;
> +		
> +		if (!options[i].long_name)
> +			continue;
> +
> +		rest = skippfx(arg, options[i].long_name);
> +		if (!rest && !strncmp(arg, "no-", 3)) {
> +			rest = skippfx(arg + 3, options[i].long_name);
> +			flags |= OPT_SHORT;
> +		}

Would this not be more intuitive as

		if (!prefixcmp(arg, "no-")) {
			arg += 3;
			flags |= OPT_UNSET;
		}
		rest = skip_prefix(arg, options[i].long_name);

Hm?  (Note that I say UNSET, not SHORT... ;-)

> +		if (!rest)
> +			continue;
> +		if (*rest) {
> +			if (*rest != '=')
> +				continue;

Is this really no error?  For example, "git log 
--decorate-walls-and-roofs" would not fail...

> +int parse_options(int argc, const char **argv,
> +                  struct option *options, int count,
> +				  const char * const usagestr[], int flags)

Please indent by the same amount.

> +		if (arg[1] != '-') {
> +			optp.opt = arg + 1;
> +			do {
> +				if (*optp.opt == 'h')
> +					make_usage(usagestr, options, count);

How about calling this "usage_with_options()"?  With that name I expected 
make_usage() to return a strbuf.

> +		if (!arg[2]) { /* "--" */
> +			if (!(flags & OPT_COPY_DASHDASH))
> +				optp.argc--, optp.argv++;

I would prefer this as 

			if (!(flags & OPT_COPY_DASHDASH)) {
				optp.argc--;
				optp.argv++;
			}

While I'm at it: could you use "args" instead of "optp"?  It is misleading 
both in that it not only contains options (but other arguments, too) as in 
that it is not a pointer (the trailing "p" is used as an indicator of that 
very often, including git's source code).

In the same vein, OPT_COPY_DASHDASH should be named 
PARSE_OPT_KEEP_DASHDASH.

> +		if (opts->short_name) {
> +			strbuf_addf(&sb, "-%c", opts->short_name);
> +		}
> +		if (opts->long_name) {
> +			strbuf_addf(&sb, opts->short_name ? ", --%s" : "--%s",
> +						opts->long_name);
> +		}

Please lose the curly brackets.

> +		if (sb.len - pos <= USAGE_OPTS_WIDTH) {
> +			int pad = USAGE_OPTS_WIDTH - (sb.len - pos) + USAGE_GAP;
> +			strbuf_addf(&sb, "%*s%s\n", pad, "", opts->help);
> +		} else {
> +			strbuf_addf(&sb, "\n%*s%s\n", USAGE_OPTS_WIDTH + USAGE_GAP, "",
> +						opts->help);
> +		}

Same here.  (And I'd also make sure that the lines are not that long.)

> diff --git a/parse-options.h b/parse-options.h
> new file mode 100644
> index 0000000..4b33d17
> --- /dev/null
> +++ b/parse-options.h
> @@ -0,0 +1,37 @@
> +#ifndef PARSE_OPTIONS_H
> +#define PARSE_OPTIONS_H
> +
> +enum option_type {
> +	OPTION_BOOLEAN,

I know that I proposed "BOOLEAN", but actually, you use it more like an 
"INCREMENTAL", right?

Other than that: I like it very much.

Ciao,
Dscho
