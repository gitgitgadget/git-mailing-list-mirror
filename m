From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Refactor --dirstat parsing; deprecate --cumulative
 and --dirstat-by-file
Date: Tue, 26 Apr 2011 09:36:21 -0700
Message-ID: <7vy62xezqy.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-1-git-send-email-johan@herland.net>
 <1303776102-9085-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QElFf-0005Mk-Aw
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 18:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958Ab1DZQgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 12:36:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab1DZQgc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 12:36:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 180B84BE7;
	Tue, 26 Apr 2011 12:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+3e9vrgOyklC8OX7S9GBAUPS2w=; b=n5KtMW
	elU0U3DfezHo1Gl9h8BiBPIWDwU/9vuo2JViUjo+x7fA8sKDyKqC/lqPP7drnhYE
	T4UEDDyDmo5dpBuTNH5ljsDJrjHA0+tSCuSON9K26OrQG56cO9V0rZEh3fzBwhXX
	QXt9vjsnDVTAxlpB8OBDFaq8SOQwaVBX9/ecc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fq02BtjV5ISjsrvSMq0/Fn8xLtzRZc+Q
	5kBzXfUy0n49XZQ2KFF0KG7nobcGvxY+EPaw+r56M9alHuB611F0BKpBMt9JQSa6
	MTwMq9eycBlbG0OXLUg8NF5gW80fFKIloprMmOCHYs6bbHhEw0Mt+ryQz1qK2otK
	wy6peDl/cAc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB55A4BE6;
	Tue, 26 Apr 2011 12:38:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A8E34BE5; Tue, 26 Apr 2011
 12:38:25 -0400 (EDT)
In-Reply-To: <1303776102-9085-4-git-send-email-johan@herland.net> (Johan
 Herland's message of "Tue, 26 Apr 2011 02:01:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DFC5FC2-7023-11E0-AE34-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172105>

Johan Herland <johan@herland.net> writes:

> Instead of having multiple interconnected dirstat-related options, teach
> the --dirstat option itself to accept all behavior modifiers as arguments.
>
> - Preserve the current --dirstat=<limit> (where <limit> is an integer
>   specifying a cut-off percentage)
> - Add --dirstat=cumulative, replacing --cumulative
> - Add --dirstat=files, replacing --dirstat-by-file
> - Also add --dirstat=changes and --dirstat=noncumulative for specifying the
>   current default behavior. These allow the user to reset other --dirstat
>   arguments (e.g. 'cumulative' and 'files') occuring earlier on the command
>   line.
>
> Allow multiple arguments to be separated by commas, e.g.:
>   --dirstat=files,10,cumulative
>
> Update the documentation accordingly, and add testcases verifying the
> behavior of the new syntax.

The above description is unclear if the version of git will error out when
given --cumulative or --dirstat-by-file.  I can sort of guess by lack of
removed lines from the documentation, but please do not make readers guess.

Also a miniscule style nitpick: could you indent your bulletted-list just
a bit (one space indent is just fine)?

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 7e4bd42..b6b1448 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -66,19 +66,40 @@ endif::git-format-patch[]
>  	number of modified files, as well as number of added and deleted
>  	lines.
>  
> ---dirstat[=<limit>]::
> -	Output the distribution of relative amount of changes (number of lines added or
> -	removed) for each sub-directory. Directories with changes below
> -	a cut-off percent (3% by default) are not shown. The cut-off percent
> -	can be set with `--dirstat=<limit>`. Changes in a child directory are not
> -	counted for the parent directory, unless `--cumulative` is used.
> +--dirstat[=<arg1,arg2,...>]::
> +	Output the distribution of relative amount of changes for each
> +	sub-directory. The behavior of `--dirstat` can be customized by
> +	passing it a comma separated list of arguments. The defaults
> +	are controlled by the `diff.dirstat` configuration variable (see
> +	linkgit:git-config[1]). The following arguments are available:

These "arguments" feel more like "options" (or "parameters"), no?  Your
code in diff.c also calls it "opt".  The second line of the proposed log
message has the same issue.

> +--
> +`changes`;;
> +	Compute the dirstat numbers by counting the lines that have been
> +	removed from the source, or added to the destination. This ignores
> +	the amount of pure code movements within a file.  In other words,
> +	rearranging lines in a file is not counted as much as other changes.
> +	This is the default `--dirstat` behavior.

"default behavior when no option is given"?

> +`files`;;
> +	Compute the dirstat numbers by counting the number of files changed.
> +	Each changed file counts equally in the dirstat analysis. This is
> +	the computationally cheapest `--dirstat` behavior, since it does
> +	not look at the file contents at all.

s/not look/not have to look/?

> +`cumulative`;;
> +	Count changes in a child directory for the parent directory as well.
> +	Note that when using `cumulative`, the sum of the percentages
> +	reported may exceed 100%. The default (non-cumulative) behavior can
> +	be specified with the `noncumulative` argument.

So the later one wins?  I.e. --dirstat=cumulative,noncumulative from the
command line (which seems silly), or more importantly with

    [alias]
    	dstat = diff --dirstat=cumulative

and you can say "git dstat --dirstat=noncumulative A..B"?

> diff --git a/diff.c b/diff.c
> index cfbfa92..08aaa47 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3144,6 +3144,72 @@ static int stat_opt(struct diff_options *options, const char **av)
>  	return argcount;
>  }
>  

/*
 * Document what the return value from this function means here.
 */
> +static int dirstat_opt(struct diff_options *options, const char **av)

Do you have to pass "const char **av", or just "const char *arg"?

> +{
> +	const char *p, *arg = av[0];
> +	char *mangled = NULL;
> +	char sep = '=';
> +
> +	if (!strcmp(arg, "--cumulative")) /* deprecated */
> +		/* handle '--cumulative' like '--dirstat=cumulative' */
> +		p = "=cumulative";
> +	else if (!strcmp(arg, "--dirstat-by-file") ||
> +		 !prefixcmp(arg, "--dirstat-by-file=")) { /* deprecated */
> +		/* handle '--dirstat-by-file=*' like '--dirstat=files,*' */
> +		mangled = xstrdup(arg + 2);
> +		memcpy(mangled, "--dirstat=files", 15);
> +		if (mangled[15]) {
> +			assert(mangled[15] == '=');
> +			mangled[15] = ',';
> +		}
> +		arg = mangled;
> +		p = mangled + 9;

I understand you wanted to reuse the while() loop below, but I do not
think it is worth it.  Isn't it easier to read if you handled the above
cases in their if/else body and return?

	if (--cumulative) {
		options->output_format |= DIFF_FORMAT_DIRSTAT;
        	DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
                return 1;
	}
        if (--dirstat-by-file) {
		options->output_format |= DIFF_FORMAT_DIRSTAT;
		DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
		return 1;
	}
	...

Even better, probably they can be left to diff_opt_parse() without calling
this function, as you are deprecating them and do not have to allow them
to take the opt1,opt2,... form of parameter.

> +	}
> +	else if (!prefixcmp(arg, "-X"))
> +		p = arg + 2;
> +	else if (!prefixcmp(arg, "--dirstat"))
> +		p = arg + 9;
> +	else
> +		return 0;
> +
> +	options->output_format |= DIFF_FORMAT_DIRSTAT;
> +
> +	while (*p) {
> +		if (*p != sep)

What happens to "diff -X3 A..B"?

> +			die("Missing argument separator ('%c'), at index %lu of '%s'",
> +			    sep, p - arg, arg);

Don't you need to cast (p-arg) for %lu from ptrdiff type here?  It
probably is more common to say s/index/char/;

> +		sep = ',';
> +		++p;

We tend to write postincrement when there is no strong reason to do
otherwise.

> +		if (!prefixcmp(p, "changes")) {
> +			p += 7;
> +			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
> +		}
> +		else if (!prefixcmp(p, "files")) {
> +			p += 5;
> +			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
> +		}
> +		else if (!prefixcmp(p, "noncumulative")) {
> +			p += 13;
> +			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
> +		}
> +		else if (!prefixcmp(p, "cumulative")) {
> +			p += 10;
> +			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
> +		}
> +		else if (isdigit(*p)) {
> +			char *end;
> +			options->dirstat_percent = strtoul(p, &end, 10);
> +			assert(end > p);
> +			p = end;
> +		}

That's a senseless assert(), isn't it?

You already know the first letter is a digit, so assert(p < end) will
always be true.  You may want to check that this particular option is all
digit by checking (*end == '\0' || *end == ',') but that is done at the
beginning of this loop anyway, so I don't think there is anything to check
here.

> +		else
> +			die("Unknown --dirstat argument '%s'", p);

The function parses dirstat_OPT, but this says argument?
