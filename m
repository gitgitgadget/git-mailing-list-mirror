From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] refs.c: Refactor code for shortening full refnames into shorthand names
Date: Mon, 06 May 2013 18:44:03 -0700
Message-ID: <7vwqrbo97g.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 03:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZWwz-0003JB-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 03:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539Ab3EGBoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 21:44:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461Ab3EGBoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 21:44:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B341112AB0;
	Tue,  7 May 2013 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u7yKbuSnuGkei7kHNSrolX6+2MU=; b=WtpxaH
	W20zmnfSyspxB6MmYytHNqgiLP1ibMI/Xku175lFEvk3VQxP4khsBzMlMTmHiN3d
	ctAxbqBylrd0jlfjs5zhKLY+/oZc5hDFE4ExJOEGKqFMKQ9cvNNb0kjVNqbFIV63
	Stv2StUSGX+nju1ed3nRG/Y7SM64fzyLym4xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YkMycSzsABWKNy6KEKXoFxF5Q91hHAmz
	2epruOHHjFBRbQyUJmpVV5M/FKo8fWZy8X+TKhTIXFVukZayOub7OwSCQ2Tk15hn
	uAR5WLiZheznyKonNKl5RrrZtmu3MO1qi9a+2A5JBRxtmP9VC1d9zyttXwp+0x91
	PWJDBWhCNt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A734112AAD;
	Tue,  7 May 2013 01:44:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E27B512AAA;
	Tue,  7 May 2013 01:44:04 +0000 (UTC)
In-Reply-To: <1367711749-8812-6-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 5 May 2013 01:55:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99C0C56A-B6B7-11E2-A639-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223519>

Johan Herland <johan@herland.net> writes:

> This patch removes the only remaining user of ref_rev_parse_rules.
> It has now been fully replaced by ref_expand_rules. Hence this patch
> also removes ref_rev_parse_rules.

Yeah, I was wondering when you would do this while reading [4/7], as
removing the parse_rules[] would break shortener side, and leaving
it in for long would risk allowing parse_rules[] and expand_rules[]
to drift apart.

> -const struct ref_expand_rule ref_expand_rules[] = {
> -	{ ref_expand_txtly, "%.*s" },
> -	{ ref_expand_txtly, "refs/%.*s" },
> -	{ ref_expand_txtly, "refs/tags/%.*s" },
> -	{ ref_expand_txtly, "refs/heads/%.*s" },
> -	{ ref_expand_txtly, "refs/remotes/%.*s" },
> -	{ ref_expand_txtly, "refs/remotes/%.*s/HEAD" },
> -	{ NULL, NULL }
> -};

I wonder if you planned the previous step a bit better, this removal
of a large block of text could have come next to the replacement of
it we see after the addition of ref_shorten_txtly() function.

> +static char *ref_shorten_txtly(const struct ref_expand_rule *rule,
> +			       const char *refname)
> +{
> +...
> +}
>  
> -static const char *ref_rev_parse_rules[] = {
> -	"%.*s",
> -	"refs/%.*s",
> -	"refs/tags/%.*s",
> -	"refs/heads/%.*s",
> -	"refs/remotes/%.*s",
> -	"refs/remotes/%.*s/HEAD",
> -	NULL
> +const struct ref_expand_rule ref_expand_rules[] = {
> +	{ ref_expand_txtly, NULL, "%.*s" },
> +	{ ref_expand_txtly, ref_shorten_txtly, "refs/%.*s" },
> +	{ ref_expand_txtly, ref_shorten_txtly, "refs/tags/%.*s" },
> +	{ ref_expand_txtly, ref_shorten_txtly, "refs/heads/%.*s" },
> +	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s" },
> +	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s/HEAD" },
> +	{ NULL, NULL, NULL }
>  };
>  
>  int refname_match(const char *abbrev_name, const char *full_name,

>  char *shorten_unambiguous_ref(const char *refname, int strict)
>  {
>  	int i;
>  	char *short_name;
>  
> -	/* buffer for scanf result, at most refname must fit */
> -	short_name = xstrdup(refname);
> -
> -	/* skip first rule, it will always match */
> -	for (i = ARRAY_SIZE(ref_rev_parse_rules) - 1; i > 0 ; --i) {
> +	for (i = ARRAY_SIZE(ref_expand_rules) - 1; i >= 0 ; --i) {
> ...
>  		/*
>  		 * in strict mode, all (except the matched one) rules
>  		 * must fail to resolve to a valid non-ambiguous ref
>  		 */
>  		if (strict)
> -			rules_to_fail = ARRAY_SIZE(ref_rev_parse_rules);
> +			rules_to_fail = ARRAY_SIZE(ref_expand_rules);

This part obviously depends on 1/7; do we still have an off-by-one
change from the original, or did I miscount when I reviewed 1/7?

Again, the overall strategy to refactor sounds sound.

It may be a lot simpler if you have ref_expand/shorten_append() and
ref_expand/shortn_append_with_HEAD() built-in helper functions.
Then you can perform the expansion and contraction without "%.*s" at
all.
