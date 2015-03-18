From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Wed, 18 Mar 2015 10:00:40 +0100
Organization: gmx
Message-ID: <4cae16222697894b19856d12b062f68e@www.dscho.org>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:00:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY9qO-000328-7P
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbbCRJAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:00:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:51376 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755222AbbCRJAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:00:44 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ma1tv-1YozEl3qdb-00LliZ; Wed, 18 Mar 2015 10:00:40
 +0100
In-Reply-To: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:P8fSHKuqf47eBXlcs8szJKJ9psKBDTEYhSjYgD98cDfsL3P6/sM
 OVwIy8FewikEnkONVrHx10hjTLGn8BDl2qk6cPniXPBr06nxz5P385fJQIo2Nx0k4vaTRHd
 7ufK9Lo5kuYBJ4ruClPwsGZnPb93DHo4DFGt3q4PRfN8CI7UchF+k/t+no2sMw+GmXEI04m
 uc8T/YGwc8D8EOQPWhpqg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265698>

Hi Paul,

thank you for this very detailed mail. It was a real pleasure to read this well-researched document.

In the following, I will pick out only parts from the mail, in the interest of both of our time. Please assume that I agree with everything that I do not quote below (and even the with quoted parts I agree mostly ;-)).

On 2015-03-17 14:57, Paul Tan wrote:

> on Windows the runtime fell from 8m 25s to 1m 3s.

This is *exactly* the type of benefit that makes this project so important! Nice one.

> A simpler, but less perfect strategy might be to just convert the shell
> scripts directly statement by statement to C, using the run_command*()
> functions as Duy Nguyen[2] suggested, before changing the code to use
> the internal API.

Yeah, the idea is to have a straight-forward strategy to convert the scripts in as efficient manner as possible. It also makes reviewing easier if the first step is an almost one-to-one translation to `run_command*()`-based builtins.

Plus, it is rewarding to have concise steps that can be completed in a timely manner.


> +/* NOTE: git-pull.sh only supports --log and --no-log, as opposed to what
> + * man git-pull says. */
> +static int opt_shortlog_len;

This comment might want to live in the commit message instead... It is prone to get stale in the code while it will always be correct (and easier to spot) in the commit message.

> +/**
> + * Returns default rebase option value
> + */
> +static int rebase_config_default(void)
> +{
> +	struct strbuf name = STRBUF_INIT;
> +	const char *value = NULL;
> +	int boolval;
> +
> +	strbuf_addf(&name, "branch.%s.rebase", head_name_short);
> +	if (git_config_get_value(name.buf, &value))
> +		git_config_get_value("pull.rebase", &value);
> +	strbuf_release(&name);
> +	if (!value)
> +		return REBASE_FALSE;
> +	boolval = git_config_maybe_bool("pull.rebase", value);
> +	if (boolval >= 0)
> +		return boolval ? REBASE_TRUE : REBASE_FALSE;
> +	else if (value && !strcmp(value, "preserve"))
> +		return REBASE_PRESERVE;
> +	die(_("invalid value for branch.%s.rebase \"%s\""), head_name_short, value);
> +}

Personally, I would use a couple of empty lines for enhanced structure. Conceptually, there are four parts: the variable declarations, querying the config, parsing the value, and `die()`ing in case of error. There is already an empty line between the first two parts, and I would imagine that readability would be improved further by having an empty line after the `strbuf_release()` and the `return REBASE_PRESERVE` statement, respectively.

> +static int parse_opt_rebase(const struct option *opt, const char
> *arg, int unset)
> +{
> +	if (arg)
> +		*(int *)opt->value = parse_rebase(arg);
> +	else
> +		*(int *)opt->value = unset ? REBASE_FALSE : REBASE_TRUE;
> +	return (*(int *)opt->value) >= 0 ? 0 : -1;
> +}

In this function (and also in other places below), there is this pattern that a `struct option` pointer is passed to the function, but then only `*(int *)opt->value` is written to. Therefore, I would suggest to change the signature of the function and pass `(int *)opt->value` as function parameter.

> +static int has_unstaged_changes(void)

Yeah, this function, as well as the ones below it, look as if they are so common that they *should* be already somewhere in libgit.a. But I did not find them, either...

Of course it *would* be nice to identify places where essentially the same code is needed, and refactor accordingly. But I think that is outside the scope of this project.

The rest looks pretty good (and you realize that my comments above are really more nit picks than anything else).

The FIXMEs should be relatively easy to address. It would be my pleasure to work with you.

Ciao,
Johannes
