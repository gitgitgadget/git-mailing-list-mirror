From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Fri, 03 Aug 2012 09:39:48 -0700
Message-ID: <7vsjc4aq0b.fsf@alter.siamese.dyndns.org>
References: <1344005630-6541-1-git-send-email-dark.panda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: J Smith <dark.panda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 18:39:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxKur-0004ao-32
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 18:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab2HCQjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 12:39:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab2HCQjv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 12:39:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B1637168;
	Fri,  3 Aug 2012 12:39:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lRPb0LS/NBOPTTBVqtqdA/VURpI=; b=KS79Ru
	HWjlju9omvEFOsdIjU17N9Ui42iPRGOK5oYkMNrqKMclhE4MofkvrxluhJg77u/r
	YT/r5UzzfQg676RSLeYTcem229XnmC9dSVn0DLTq7xThNeLjfBnkPa7gWy5dsGIM
	Y314bUPrjbnB1AqfgqTvJRXKnZp/ePWQ88ErU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NcGp8YBHD9ZIsxFprn6W7g1JY8gNR1sr
	YKWI7K2jiJjecyIXHXD6UzyUD3RIMYgPtKqrvg6PNTa4QuJCXW76EEAxSKt+x4Nk
	Tm4z7905EdxPoYbCBGfqfoCcDmEOqhzwDfPHr13hwXaJuCZwtG4fyfFZ9wtb3V6U
	IvDv+Op/9jk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7949F7167;
	Fri,  3 Aug 2012 12:39:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80EF47166; Fri,  3 Aug 2012
 12:39:49 -0400 (EDT)
In-Reply-To: <1344005630-6541-1-git-send-email-dark.panda@gmail.com> (J.
 Smith's message of "Fri, 3 Aug 2012 10:53:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D79B28A6-DD89-11E1-85A0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202842>

J Smith <dark.panda@gmail.com> writes:

> The grep.extendedRegexp configuration setting enables the -E flag on grep
> by default but there are no equivalents for the -G, -F and -P flags.
>
> Rather than adding an additional setting for grep.fooRegexp for current
> and future pattern matching options, add a grep.patternType setting that
> can accept appropriate values for modifying the default grep pattern
> matching behavior. The current values are "basic", "extended", "fixed",
> "perl" and "default" for setting -G, -E, -F, -P and the default behavior
> respectively.
>
> When grep.patternType is set to a value other than "default", the
> grep.extendedRegexp setting is ignored. The value of "default" restores
> the current default behavior, including the grep.extendedRegexp
> behavior.
>
> Signed-off-by: J Smith <dark.panda@gmail.com>
> ---

Nicely done.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 29adb0a..7ff64da 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -260,6 +260,53 @@ static int wait_all(void)
>  }
>  #endif
>
> +static int parse_pattern_type_arg(const char *opt, const char *arg)
> +{
> +	if (!strcmp(arg, "default"))
> +		return GREP_PATTERN_TYPE_UNSPECIFIED;
> +	else if (!strcmp(arg, "basic"))
> +		return GREP_PATTERN_TYPE_BRE;
> +	else if (!strcmp(arg, "extended"))
> +		return GREP_PATTERN_TYPE_ERE;
> +	else if (!strcmp(arg, "fixed"))
> +		return GREP_PATTERN_TYPE_FIXED;
> +	else if (!strcmp(arg, "perl"))
> +		return GREP_PATTERN_TYPE_PCRE;
> +	die("bad %s argument: %s", opt, arg);
> +}
> +
> +static void grep_pattern_type_options(const int pattern_type, struct grep_opt *opt)
> +{
> +	switch (pattern_type) {
> +	case GREP_PATTERN_TYPE_UNSPECIFIED:
> +		/* fall through */
> +
> +	case GREP_PATTERN_TYPE_BRE:
> +		opt->fixed = 0;
> +		opt->pcre = 0;
> +		opt->regflags &= ~REG_EXTENDED;
> +		break;
> +
> +	case GREP_PATTERN_TYPE_ERE:
> +		opt->fixed = 0;
> +		opt->pcre = 0;
> +		opt->regflags |= REG_EXTENDED;
> +		break;
> +
> +	case GREP_PATTERN_TYPE_FIXED:
> +		opt->fixed = 1;
> +		opt->pcre = 0;
> +		opt->regflags &= ~REG_EXTENDED;
> +		break;
> +
> +	case GREP_PATTERN_TYPE_PCRE:
> +		opt->fixed = 0;
> +		opt->pcre = 1;
> +		opt->regflags &= ~REG_EXTENDED;
> +		break;
> +	}
> +}
> +
>  static int grep_config(const char *var, const char *value, void *cb)
>  {
>  	struct grep_opt *opt = cb;
> @@ -270,12 +317,17 @@ static int grep_config(const char *var, const char *value, void *cb)
>
>  	if (!strcmp(var, "grep.extendedregexp")) {
>  		if (git_config_bool(var, value))
> -			opt->regflags |= REG_EXTENDED;
> +			opt->extended_regexp_option = 1;
>  		else
> -			opt->regflags &= ~REG_EXTENDED;
> +			opt->extended_regexp_option = 0;
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "grep.patterntype")) {
> +		opt->pattern_type_option = parse_pattern_type_arg(var, value);
> +		return 0;
> +  }
> +
>  	if (!strcmp(var, "grep.linenumber")) {
>  		opt->linenum = git_config_bool(var, value);
>  		return 0;
> ...
> @@ -799,6 +844,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> +	opt.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
> +	opt.extended_regexp_option = 0;
> ...
> +
> +	if (pattern_type_arg > GREP_PATTERN_TYPE_UNSPECIFIED)
> +		grep_pattern_type_options(pattern_type_arg, &opt);
> +	else {
> +		if (opt.pattern_type_option > GREP_PATTERN_TYPE_UNSPECIFIED)
> +			grep_pattern_type_options(opt.pattern_type_option, &opt);
> +		else if (opt.extended_regexp_option)
> +			grep_pattern_type_options(GREP_PATTERN_TYPE_ERE, &opt);

Ok, so while reading the configuration and command line options, we
do not touch the real fields that affect how the comparison is done,
(namely: regflags, fixed, ...), and just "buffer" what we read so
far in extended_regexp_option and pattern_type_option, and at the
very end set the real fields to their appropriate values.

Much nicer than the drafts in earlier discussion.  One micronit is
that probably it is preferrable to do '!=' instead of '>', as we are
only trying to see if it is unspecified on the command line (hence
need to pay attention to configuration) and do not care how the
enums are ordered, but that is nothing that requires a re-roll.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 523d041..35d357d 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> ...
> +test_expect_success 'grep -G pattern with grep.patternType=fixed' '
> +	{
> +		echo "ab:a+b*c"
> +		echo "ab:a+bc"
> +	} >expected &&
> +	git \
> +		-c grep.patterntype=fixed \
> +		grep -G "a+b" ab >actual &&
> +	test_cmp expected actual
> +'

All the new tests in the script looked very well thought out.

I noticed that this particular one will still succeed when somebody
breaks your code to ignore the configuration (as -G "a+b" would give
the expected match) or give higher precedence to the configuration
(as fixed "a+b" also will give the expected match).  Not that it is
wrong to have such a test that is unlikely to catch certain kinds of
regressions in the suite, and the particular kind of breakage will
be caught by the next test (snipped) anyway.

Will queue.  Thanks.
