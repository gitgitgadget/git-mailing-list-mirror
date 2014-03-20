From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: optimise parse_dirstat_params() to only compare strings when necessary
Date: Thu, 20 Mar 2014 10:18:54 -0700
Message-ID: <xmqqmwgkzt35.fsf@gitster.dls.corp.google.com>
References: <1395274076-6720-1-git-send-email-dragos.foianu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:19:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgca-0005Ob-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759419AbaCTRTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 13:19:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759353AbaCTRTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 13:19:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E112D7635A;
	Thu, 20 Mar 2014 13:18:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=laGONZ4xZpUgBmsvA+RdWTesnJI=; b=TRxZ8d
	aZ3sXpQvSYEsxHm26VcNcQYvj+p6Qvr9BmiKkOc0KCFb/k5URemXEqpRvwyyKcYI
	SIPx0o17nOUzV7QWfJliEPYiKXI41YYu4gXgiYY6qugT7MxpUKP48osoG8OrfwOT
	0Jq5sgReqveepbCEx5fC8UtJ0jEwf60n/R9pU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i4OBY2m64uT+RBPS0/Y36BBMzn3LDT3P
	TLkBaNaC3gjIF/tMtRwyiaF0W4S+/SfPNHpLaYMSRUmBvbxnx39GU3KKscjHFodf
	HHVFk0oR4Um8Wgflm2r49b1S7lNkeyThBB2exuPM6LxlmG51IKp2gZ2IrynLYFc/
	QcFoHlxIz6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7C2D76358;
	Thu, 20 Mar 2014 13:18:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D017A7634D;
	Thu, 20 Mar 2014 13:18:58 -0400 (EDT)
In-Reply-To: <1395274076-6720-1-git-send-email-dragos.foianu@gmail.com>
	(Dragos Foianu's message of "Thu, 20 Mar 2014 02:07:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B9493FC0-B053-11E3-83D5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244561>

Dragos Foianu <dragos.foianu@gmail.com> writes:

> parse_dirstat_params() goes through a chain of if statements using
> strcmp to parse parameters. When the parameter is a digit, the
> value must go through all comparisons before the function realises
> it is a digit. Optimise this logic by only going through the chain
> of string compares when the parameter is not a digit.

This change could be an optimization only if parse_dirstat_params()
is called with a param that begins with a digit a lot more often
than with other forms of params, but that is a mere assumption.
Unless that assumption is substantiated, this change can be a
pessimization.

Even if the assumption were true (which I doubt), a simpler solution
to optimize such a call pattern would be to simply tweak of the
order if/else cascade to check if the param begins with a digit
first before checking other keywords, wouldn't it?  I am not sure
why you even need to change the structure into a nested if
statement.

> Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
> ---
>  diff.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index e343191..733764e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -84,20 +84,25 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
>  		string_list_split_in_place(&params, params_copy, ',', -1);
>  	for (i = 0; i < params.nr; i++) {
>  		const char *p = params.items[i].string;
> -		if (!strcmp(p, "changes")) {
> -			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
> -			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
> -		} else if (!strcmp(p, "lines")) {
> -			DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
> -			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
> -		} else if (!strcmp(p, "files")) {
> -			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
> -			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
> -		} else if (!strcmp(p, "noncumulative")) {
> -			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
> -		} else if (!strcmp(p, "cumulative")) {
> -			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
> -		} else if (isdigit(*p)) {
> +		if (!isdigit(*p)) {
> +			if (!strcmp(p, "changes")) {
> +				DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
> +				DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
> +			} else if (!strcmp(p, "lines")) {
> +				DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
> +				DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
> +			} else if (!strcmp(p, "files")) {
> +				DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
> +				DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
> +			} else if (!strcmp(p, "noncumulative")) {
> +				DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
> +			} else if (!strcmp(p, "cumulative")) {
> +				DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
> +			} else {
> +				strbuf_addf(errmsg, _("  Unknown dirstat parameter '%s'\n"), p);
> +				ret++;
> +			}
> +		} else  {
>  			char *end;
>  			int permille = strtoul(p, &end, 10) * 10;
>  			if (*end == '.' && isdigit(*++end)) {
> @@ -114,11 +119,7 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
>  					    p);
>  				ret++;
>  			}
> -		} else {
> -			strbuf_addf(errmsg, _("  Unknown dirstat parameter '%s'\n"), p);
> -			ret++;
>  		}
> -
>  	}
>  	string_list_clear(&params, 0);
>  	free(params_copy);
