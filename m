From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/5] Refactor parse_loc
Date: Thu, 28 Feb 2013 09:16:50 -0800
Message-ID: <7vobf4icjh.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <d22070b416a1787ece6f98a722614a54826b93ce.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB76d-0007DY-J4
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 18:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759187Ab3B1RQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 12:16:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979Ab3B1RQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 12:16:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB08FBC7D;
	Thu, 28 Feb 2013 12:16:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJtxgel5Ax3S+0vo9vW7hjdGlno=; b=WN91T1
	ZyFtFQU64eLZQsFb3SetWuPdft89vnIp6RB3niMIJzmwZ/5yq/7fooQ3xJoaQUXv
	8shYH1f06r70dVa6s2nKaATQDRX/d9l0qn5Do9SsfULfvkol9UTOB10lX9I6cSTl
	zk0ufa0OpNiiKJtYPYEDp3DaArApJ4vXBCKqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BO9tVo6oAipuFvWjaw2P8wnkPV5w3FNk
	t4sWtZ9A24guxW5r79QfzoETC+9NwxiKLjF8+Q4iYFudt1C12So8L+IqK27atFlt
	NgVZncjgoMr3erM+mL4QnyL8flZ61L1/1kLgzgVSfBAb3v41iCB10X8n4JjpN/9F
	truHFsBfx04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F318BC7C;
	Thu, 28 Feb 2013 12:16:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3365BC7B; Thu, 28 Feb 2013
 12:16:51 -0500 (EST)
In-Reply-To: <d22070b416a1787ece6f98a722614a54826b93ce.1362069310.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 28 Feb 2013 17:38:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A470F9F2-81CA-11E2-9EFC-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217242>

Thomas Rast <trast@student.ethz.ch> writes:

> From: Bo Yang <struggleyb.nku@gmail.com>
>
> We want to use the same style of -L n,m argument for 'git log -L' as
> for git-blame.  Refactor the argument parsing of the range arguments
> from builtin/blame.c to the (new) file that will hold the 'git log -L'
> logic.
>
> To accommodate different data structures in blame and log -L, the file
> contents are abstracted away; parse_range_arg takes a callback that it
> uses to get the contents of a line of the (notional) file.
>
> The new test is for a case that made me pause during debugging: the
> 'blame -L with invalid end' test was the only one that noticed an
> outright failure to parse the end *at all*.  So make a more explicit
> test for that.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/blame-options.txt     |  19 +------
>  Documentation/line-range-format.txt |  18 +++++++
>  Makefile                            |   2 +
>  builtin/blame.c                     |  99 +++-------------------------------
>  line-log.c                          | 105 ++++++++++++++++++++++++++++++++++++
>  line-log.h                          |  23 ++++++++

Was this churn necessary?  

It is strange to move existing functions that will be tweaked to be
shared by two different codepaths (blame and line-log) to the new
user.

The only effect this has, as opposed to tweaking the functions in
place and making them extern, is to make it harder to see the tweaks
made while moving the lines, and also make it more cumbersome to
determine the lineage of the code later.
 
It would have been understandable if they were moved to a new
library-ish file (perhaps "line-range.[ch]"); even though that
approach shares the same downsides, at least it would have a better
excuse "We will share this, so let's move it to a neutral third
place to allow us to hide the implementation details from both
users".  The arrangement this patch series makes does not even have
that excuse.  The final implementation still stay with one of the
users; the only difference is that it is away from the original user
and close to the new user.

> @@ -1927,83 +1933,6 @@ static const char *add_prefix(const char *prefix, const char *path)
>  }
>  
>  /*
> - * Parsing of (comma separated) one item in the -L option
> - */
> -static const char *parse_loc(const char *spec,
> -			     struct scoreboard *sb, long lno,
> -			     long begin, long *ret)
> -{
> -	char *term;
> -	const char *line;
> -	long num;
> -	int reg_error;
> -	regex_t regexp;
> -	regmatch_t match[1];
> -
> -	/* Allow "-L <something>,+20" to mean starting at <something>
> -	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
> -	 * <something>.
> -	 */
> -	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {

Did you fix a bug here?

This original only process -L begin,+20 and -L begin,-4 for the
value of begin larger than 1 while reading the second part that
comes after the comma, but incoming begin must be 2 or more, because
the caller adds one to the result of parsing what comes before the
comma, and "1 < begin" here, not "begin != -1", is done for that
reason.

I noticed these slight differences only after eyeballing the lines
deleted from here and lines added to the other place, but the
differences would have been unnoticed if reviewers were not careful.

Again, was it really necessary to move these functions to the new
file?

> diff --git a/line-log.c b/line-log.c
> new file mode 100644
> index 0000000..a24a86b
> --- /dev/null
> +++ b/line-log.c
> @@ -0,0 +1,105 @@
> +#include "git-compat-util.h"
> +#include "line-log.h"
> +
> +/*
> + * Parse one item in the -L option
> + */
> +const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
> +		void *data, long lines, long begin, long *ret)
> +{
> +	char *term;
> +	const char *line;
> +	long num;
> +	int reg_error;
> +	regex_t regexp;
> +	regmatch_t match[1];
> +
> +	/*
> +	 * Allow "-L <something>,+20" to mean starting at <something>
> +	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
> +	 * <something>.
> +	 */
> +	if (begin != -1 && (spec[0] == '+' || spec[0] == '-')) {
> +		num = strtol(spec + 1, &term, 10);
> +		if (term != spec + 1) {
> +			if (spec[0] == '-')
> +				num = 0 - num;
> +			if (0 < num)
> +				*ret = begin + num - 2;
> +			else if (!num)
> +				*ret = begin;
> +			else
> +				*ret = begin + num;
> +			return term;
> +		}
> +		return spec;
> +	}
> +	num = strtol(spec, &term, 10);
> +	if (term != spec) {
> +		*ret = num;
> +		return term;
> +	}
> +	if (spec[0] != '/')
> +		return spec;
> +
> +	/* it could be a regexp of form /.../ */
> +	for (term = (char *) spec + 1; *term && *term != '/'; term++) {
> +		if (*term == '\\')
> +			term++;
> +	}
> +	if (*term != '/')
> +		return spec;
> +
> +	/* try [spec+1 .. term-1] as regexp */
> +	*term = 0;
> +	if (begin == -1)
> +		begin = 1;
> +	begin--; /* input is in human terms */
> +	line = nth_line(data, begin);
> +
> +	if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
> +	    !(reg_error = regexec(&regexp, line, 1, match, 0))) {
> +		const char *cp = line + match[0].rm_so;
> +		const char *nline;
> +
> +		while (begin++ < lines) {
> +			nline = nth_line(data, begin);
> +			if (line <= cp && cp < nline)
> +				break;
> +			line = nline;
> +		}
> +		*ret = begin;
> +		regfree(&regexp);
> +		*term++ = '/';
> +		return term;
> +	} else {
> +		char errbuf[1024];
> +		regerror(reg_error, &regexp, errbuf, 1024);
> +		die("-L parameter '%s': %s", spec + 1, errbuf);
> +	}
> +}
> +
> +int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
> +		void *cb_data, long lines, long *begin, long *end)
> +{

This, especially the nth-line function, is a good abstraction.

> +	arg = parse_loc(arg, nth_line_cb, cb_data, lines, -1, begin);
> +
> +	if (*arg == ',') {

Can the input string begin with a comma, e.g. ",-4" which we may
want to mean the last four lines or something?

> +		arg = parse_loc(arg+1, nth_line_cb, cb_data, lines, *begin+1, end);
> +		if (*begin > *end) {
> +			long tmp = *begin;
> +			*begin = *end;
> +			*end = tmp;
> +		}
> +	}
> +
> +	if (*begin <= 0)
> +		*begin = 1;
> +	if (*end > lines)
> +		*end = lines;
> +
> +	if (*arg)
> +		return -1;
> +
> +	return 0;
> +}
> diff --git a/line-log.h b/line-log.h
> new file mode 100644
> index 0000000..22b1c80
> --- /dev/null
> +++ b/line-log.h
> @@ -0,0 +1,23 @@
> +#ifndef LINE_LOG_H
> +#define LINE_LOG_H
> +
> +/*
> + * Parse one item in an -L begin,end option w.r.t. the notional file
> + * object 'cb_data' consisting of 'lines' lines.
> + *
> + * The 'nth_line_cb' callback is used to determine the start of the
> + * line 'lno' inside the 'cb_data'.  The caller is expected to already
> + * have a suitable map at hand to make this a constant-time lookup.
> + *
> + * Returns 0 in case of success and -1 if there was an error.  The
> + * caller should print a usage message in the latter case.
> + */

line number counts from 0 or 1?

> +
> +typedef const char *(*nth_line_fn_t)(void *data, long lno);
> +
> +extern int parse_range_arg(const char *arg,
> +			   nth_line_fn_t nth_line_cb,
> +			   void *cb_data, long lines,
> +			   long *begin, long *end);
> +
> +#endif /* LINE_LOG_H */
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 230143c..e7cac1d 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -175,6 +175,12 @@ test_expect_success 'blame -L with invalid end' '
>  	grep "has only 2 lines" errors
>  '
>  
> +test_expect_success 'blame parses <end> part of -L' '
> +	git blame -L1,1 tres >out &&
> +	cat out &&
> +	test $(wc -l < out) -eq 1
> +'
> +
>  test_expect_success 'indent of line numbers, nine lines' '
>  	git blame nine_lines >actual &&
>  	test $(grep -c "  " actual) = 0
