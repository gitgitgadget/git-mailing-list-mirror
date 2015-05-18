From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/14] pull: pass verbosity, --progress flags to fetch
 and merge
Date: Mon, 18 May 2015 19:41:19 +0200
Organization: gmx
Message-ID: <4213f4fa8fb52fb020c2e9b5d78fbf7b@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 19:41:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuP2g-0006yY-0O
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 19:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbbERRlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 13:41:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:65303 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbbERRlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 13:41:24 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLeoF-1Yu8Bv2uDD-000wsT; Mon, 18 May 2015 19:41:20
 +0200
In-Reply-To: <1431961571-20370-3-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9iX4lpJUBfYeFja91cNdv1gxPAD1qMu4TYQ+zhKOq26OwScG9i4
 Rs1fPddk1BunE79Kbj4bpweC4QFX282Ru8ZUUwulzWth0SzcyoKSdZMm44AtTiMF3nRPOcg
 Xas5kLRkBAcDlVNzBa5ug2A2v/7HpIIC7oYInBVLGGALbMz80U6ITd9UpROX8XFjiNdnixx
 +P2OV8M2e14rGpAnjHafA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269282>

Hi Paul,

On 2015-05-18 17:05, Paul Tan wrote:

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 0b771b9..a4d9c92 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -11,16 +11,64 @@
>  #include "argv-array.h"
>  #include "run-command.h"
>  
> +/**
> + * Given an option opt, where opt->value points to a char* and opt->defval is a
> + * string, sets opt->value to the evaluation of "--$defval=$arg". If `arg` is
> + * NULL, then opt->value is set to "--$defval". If unset is true, then
> + * opt->value is set to "--no-$defval".
> + */
> +static int parse_opt_passthru(const struct option *opt, const char
> *arg, int unset)

How about adding this to parse-options-cb.c in a separate patch? I guess the description could say something like:

/**
 * Given an option opt, recreate the command-line option, as strbuf. This is useful
 * when a command needs to parse a command-line option in order to pass it to yet
 * another command. This callback can be used in conjunction with the
 * PARSE_OPT_(OPTARG|NOARG|NONEG) options, but not with PARSE_OPT_LASTARG_DEFAULT
 * because it expects `defval` to be the name of the command-line option to
 * reconstruct.
 *
 * The result will be stored in opt->value, which is expected to be a pointer to an
 * strbuf.
 */

Implied by my suggested description, I also propose to put the re-recreated command-line option into a strbuf instead of a char *, to make memory management easier (read: avoid memory leaks).

You might also want to verify that arg is `NULL` when `unset != 0`. Something like this:

int parse_opt_passthru(const struct option *opt, const char *arg, int unset)
{
	struct strbuf *buf = opt->value;

	assert(opt->defval);
	strbuf_reset(buf);
	if (unset) {
		assert(!arg);
		strbuf_addf(buf, "--no-%s", opt->defval);
	}
	else {
		strbuf_addf(buf, "--%s", opt->defval);
		if (arg)
			strbuf_addf(buf, "=%s", arg);
	}

	return 0;
}

>  static struct option pull_options[] = {
> +	/* Shared options */
> +	OPT__VERBOSITY(&opt_verbosity),
> +	{ OPTION_CALLBACK, 0, "progress", &opt_progress, NULL,
> +	  N_("force progress reporting"),
> +	  PARSE_OPT_NOARG, parse_opt_passthru},

I *think* there is a '(intptr_t) "progress"' missing...

>  /**
> + * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
> + */
> +static void argv_push_verbosity(struct argv_array *arr)
> +{
> +	int verbosity;
> +
> +	for (verbosity = opt_verbosity; verbosity > 0; verbosity--)
> +		argv_array_push(arr, "-v");
> +
> +	for (verbosity = opt_verbosity; verbosity < 0; verbosity++)
> +		argv_array_push(arr, "-q");
> +}

Hmm... I guess this is *really* nit-picky, but I'd rather use "i" instead of "verbosity" because the second loop is about quietness instead of verbosity ;-)

Ciao,
Dscho
