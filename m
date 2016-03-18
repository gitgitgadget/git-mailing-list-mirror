From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/2] parse-options.c: make OPTION__COUNTUP consider negative values
Date: Fri, 18 Mar 2016 15:59:13 -0700
Message-ID: <xmqq4mc3pf3y.fsf@gitster.mtv.corp.google.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:59:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah3MX-000618-HS
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 23:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbcCRW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 18:59:18 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751804AbcCRW7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 18:59:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E7854DC2F;
	Fri, 18 Mar 2016 18:59:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TO7ACzWamFryoneALMYasqsQCag=; b=T5UXqw
	VqBQnLj1FySuk3BnyS/jR6I9VQJz2lfCPU+KZ8Jr9wEDVMSATHqqTtaLvAeVyKBf
	CasYq7+/QnLXv0UxV8zHem+P5e2ay9UvpEX9+ENu8Sfqf63aI4tMhoLMomlxAhjV
	b0NqV3soh0rS8Nf3beBKczV8FhsSEEX97dLX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OYCih8i+TEG1gRt044Yw4zP9MU7PuGlL
	sZB3JoqwiNiD74BGtY0RL6GCjxtVzeJ5DjT4ETjrf6ufBN52Nou067aPfD7hL4b+
	hrF4XInB9oot4pcQUa+GCFDMcE5t8rHb/wCe/diMwDINssc8BGvSYo13y0ZOA3Dg
	l7e5batTeGY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 230394DC2B;
	Fri, 18 Mar 2016 18:59:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 879764DC2A;
	Fri, 18 Mar 2016 18:59:14 -0400 (EDT)
In-Reply-To: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Fri, 18 Mar 2016 21:19:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 092382EC-ED5D-11E5-8B2E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289264>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> The reason to make it consider negative values or more specifically
> "unspecified" values is to give the ability to differentiate between
> once, multiple time or with --no-option.
>
> Eg. :
> initialize verbose = -1
> `git commit` => verbose = -1
> `git commit -v` => verbose = 1
> `git commit -v -v` => verbose = 2
> `git commit --no-verbose` => verbose = 0

A few more things I noticed about this are:

 - Many uses of COUNTUP has now been replaced with BOOL and what
   remains are verbose/quiet/force.

 - This change will not affect existing users of COUNTUP at all, as
   long as they use the initial value of 0 (or more), as there is no
   mechanism to decrement.  The only thing the command line can do
   is to reset it to zero with "--no-foo".

So it seems a safe and sensible change.  Even though I suspect that
the justification can be written more clearly, I am not sure if it
worth the extra effort.

>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> ---
> The discussion about this patch:
> [1] : http://thread.gmane.org/gmane.comp.version-control.git/289027
>
> Previous version of the patch:
> [v1] : http://thread.gmane.org/gmane.comp.version-control.git/289061
>
> Changes introduced:
> Use a different language in commit message to make the change and its
> utility more clear.
> ---
>  Documentation/technical/api-parse-options.txt | 6 ++++--
>  parse-options.c                               | 8 +++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 5f0757d..a908d8a 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -144,8 +144,10 @@ There are some macros to easily define options:
>  
>  `OPT_COUNTUP(short, long, &int_var, description)`::
>  	Introduce a count-up option.
> -	`int_var` is incremented on each use of `--option`, and
> -	reset to zero with `--no-option`.
> +	If the `int_var` is negative and `--option` is absent,
> +	then it will retain its value. Otherwise it will first set
> +	`int_var` to 0 and then increment it on each use of `--option`,
> +	and reset to zero with `--no-option`.
>  
>  `OPT_BIT(short, long, &int_var, description, mask)`::
>  	Introduce a boolean option.
> diff --git a/parse-options.c b/parse-options.c
> index 47a9192..86d30bd 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -110,7 +110,13 @@ static int get_value(struct parse_opt_ctx_t *p,
>  		return 0;
>  
>  	case OPTION_COUNTUP:
> -		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
> +		if (unset)
> +			*(int *)opt->value = 0;
> +		else {
> +			if (*(int *)opt->value < 0)
> +				*(int *)opt->value = 0;
> +			*(int *)opt->value += 1;
> +		}
>  		return 0;
>  
>  	case OPTION_SET_INT:
>
> --
> https://github.com/git/git/pull/213
