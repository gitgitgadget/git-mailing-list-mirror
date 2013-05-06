From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening refs/remotes/origin/HEAD to origin
Date: Mon, 06 May 2013 10:52:14 -0700
Message-ID: <7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 06 19:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZPaJ-0002tq-9D
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab3EFRwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 13:52:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab3EFRwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 13:52:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 392381CB1A;
	Mon,  6 May 2013 17:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QoW80pEqrEbanmFB+3E4iP63moI=; b=Bkgen8
	d4uWCIfeE1sO3pkiOks9kQ9sj6a84dUxGhh2CNgpxx38eZj09VGbo8rdnnskNC5L
	1muxRHD19tLEs4FTg/5J1vPfXpSJxPa7Dy2GN/GilDBdR2TORj5C7M/fGH36zBIq
	Vu1Fv7A1CpZ95Gb25rdKaR5f06iU6ftr3FKv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3nPXrwjGS/dBg7j1tCcQdso/8tXIx9S
	NXNTtpTUkgHd1j4vk6E/epJ5x//hBBkIVwH/t8hOZ4W4QijTZS/beu/g1k+M/SJ0
	3Yfq84II2PuAbDChbe7vVhvuRoXxZrLBQlrtE0nLoqugx6Pez3MiFpaZ/VPHE8GP
	b2Oqh21gjvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C2741CB17;
	Mon,  6 May 2013 17:52:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64B5F1CB15;
	Mon,  6 May 2013 17:52:16 +0000 (UTC)
In-Reply-To: <1367711749-8812-2-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 5 May 2013 01:55:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B09061DE-B675-11E2-B460-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223479>

Johan Herland <johan@herland.net> writes:

> ... there is AFAICS _no_ way for sscanf() - having
> already done one or more format extractions - to indicate to its caller
> that the input fails to match the trailing part of the format string.

Yeah, we can detect when we did not have enough, but we cannot tell
where it stopped matching.

It is interesting that this bug has stayed so long with us, which
may indicate that nobody actually uses the feature at all.

Good eyes.

>
> Cc: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  refs.c                  | 82 +++++++++++++++++++------------------------------
>  t/t6300-for-each-ref.sh | 12 ++++++++
>  2 files changed, 43 insertions(+), 51 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d17931a..7231f54 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2945,80 +2945,60 @@ struct ref *find_ref_by_name(const struct ref *list, const char *name)
>  	return NULL;
>  }
>  
> +int shorten_ref(const char *refname, const char *pattern, char *short_name)

Does this need to be an extern?

>  {
> +	/*
> +	 * pattern must be of the form "[pre]%.*s[post]". Check if refname
> +	 * starts with "[pre]" and ends with "[post]". If so, write the
> +	 * middle part into short_name, and return the number of chars
> +	 * written (not counting the added NUL-terminator). Otherwise,
> +	 * if refname does not match pattern, return 0.
> +	 */
> +	size_t pre_len, post_start, post_len, match_len;
> +	size_t ref_len = strlen(refname);
> +	char *sep = strstr(pattern, "%.*s");
> +	if (!sep || strstr(sep + 4, "%.*s"))
> +		die("invalid pattern in ref_rev_parse_rules: %s", pattern);
> +	pre_len = sep - pattern;
> +	post_start = pre_len + 4;
> +	post_len = strlen(pattern + post_start);
> +	if (pre_len + post_len >= ref_len)
> +		return 0; /* refname too short */
> +	match_len = ref_len - (pre_len + post_len);
> +	if (strncmp(refname, pattern, pre_len) ||
> +	    strncmp(refname + ref_len - post_len, pattern + post_start, post_len))
> +		return 0; /* refname does not match */
> +	memcpy(short_name, refname + pre_len, match_len);
> +	short_name[match_len] = '\0';
> +	return match_len;
>  }

OK. Looks correct, even though I suspect some people might come up
with a more concise way to express the above.

>  char *shorten_unambiguous_ref(const char *refname, int strict)
>  {
>  	int i;
>  	char *short_name;
>  
>  	/* skip first rule, it will always match */
> -	for (i = nr_rules - 1; i > 0 ; --i) {
> +	for (i = ARRAY_SIZE(ref_rev_parse_rules) - 1; i > 0 ; --i) {
>  		int j;
>  		int rules_to_fail = i;
>  		int short_name_len;
>  
> +		if (!ref_rev_parse_rules[i] ||

What is this skippage about?  Isn't it what you already compensated
away by starting from "ARRAY_SIZE() - 1"?

Ahh, no.  But wait.  Isn't there a larger issue here?

> +		    !(short_name_len = shorten_ref(refname,
> +						   ref_rev_parse_rules[i],
> +						   short_name)))
>  			continue;
>  
> -		short_name_len = strlen(short_name);
> -
>  		/*
>  		 * in strict mode, all (except the matched one) rules
>  		 * must fail to resolve to a valid non-ambiguous ref
>  		 */
>  		if (strict)
> -			rules_to_fail = nr_rules;
> +			rules_to_fail = ARRAY_SIZE(ref_rev_parse_rules);

Isn't nr_rules in the original is "ARRAY_SIZE()-1"?

>  
>  		/*
>  		 * check if the short name resolves to a valid ref,

Could you add a test to trigger the "strict" codepath?

Thanks.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 752f5cb..57e3109 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -466,4 +466,16 @@ test_expect_success 'Verify sort with multiple keys' '
>  		refs/tags/bogo refs/tags/master > actual &&
>  	test_cmp expected actual
>  '
> +
> +cat >expected <<\EOF
> +origin
> +origin/master
> +EOF
> +
> +test_expect_success 'Check refs/remotes/origin/HEAD shortens to origin' '
> +	git remote set-head origin master &&
> +	git for-each-ref --format="%(refname:short)" refs/remotes >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
