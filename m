From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/4] config: improve support for http.<url>.* settings
Date: Fri, 19 Jul 2013 12:59:43 -0700
Message-ID: <7vehauuxqo.fsf@alter.siamese.dyndns.org>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
	<2cca0770a1e8495ac1418834c57f23d@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 21:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0GqG-0001VM-0z
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 21:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab3GST7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 15:59:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab3GST7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 15:59:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFB433286E;
	Fri, 19 Jul 2013 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jgzxPgPIqvvjcKKQdWaJ+Bf9o1Q=; b=vSF4zL
	wJs7KDT6cpYKDL8RFcDmBV0CdQkzBMDmv2FyrupycBp0O1Qhj7FuU4cY3lvfEexn
	Ht0CWRJGJTzVY2N+damQhIgZzz9IWQEj0y6JQRLk8MveTlBNsInjM51kKTus8pLq
	davwpG/YRoWRDozlI9r7TRExhn0QuxZN6dymo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NO/N7+ipp02leWGnZhIeK8E5m3TOIAMj
	hOOJwXfaV6sA/XQqmXRsrP5nhVSUwn4R/3ZjIFicE8bStyhShvPlqfnghUYlhywJ
	zovmw4S5BZojlO3MSnP1VrPuAr6JZ7nQKjKOtwUQHacu/pVif6vpPwn8YAvG0V29
	KM/BaFKxtLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A34CE3286D;
	Fri, 19 Jul 2013 19:59:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A13FC3286A;
	Fri, 19 Jul 2013 19:59:45 +0000 (UTC)
In-Reply-To: <2cca0770a1e8495ac1418834c57f23d@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Fri, 19 Jul 2013 05:48:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2869C74-F0AD-11E2-A714-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230844>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> +#define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
> +#define URL_DIGIT "0123456789"
> +#define URL_HEXDIGIT URL_DIGIT "ABCDEFabcdef"
> +#define URL_ALPHADIGIT URL_ALPHA URL_DIGIT
> +#define URL_SCHEME_CHARS URL_ALPHADIGIT "+.-"
> +#define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals need [:] */
> +#define URL_UNSAFE_CHARS " <>\"%{}|\\^`" /* plus 0x00-0x1F,0x7F-0xFF */
> +#define URL_GEN_RESERVED ":/?#[]@"
> +#define URL_SUB_RESERVED "!$&'()*+,;="
> +#define URL_RESERVED URL_GEN_RESERVED URL_SUB_RESERVED /* only allowed delims */
> + ...
> +	while (from_len) {
> +		int ch = *from++;
> +		int was_esc = 0;
> +
> +		from_len--;
> +		if (ch == '%') {
> +			if (from_len < 2 ||
> +			    !strchr(URL_HEXDIGIT, from[0]) ||
> +			    !strchr(URL_HEXDIGIT, from[1]))

I actually do like the readability of the approach in this patch,
but these repeated strchrs() in a loop may want to be optimized,
using a trick similar to what is used in ctype.c::sane_ctype[].

A small build-time-only program or script gen-http-ctype.perl that
defines and uses these URL_* cpp macros and generates a C source
file http-ctype-gen.c that can be #included from http.c, with
something like this in the Makefile:

	http-ctype-gen.c: gen-http-ctype.perl
		rm -f $@ $@+
                $(PERL_PATH) gen-http-ctype.perl >$@+
                mv $@+ $@
	http.o: http.c http-ctype-gen.c

would give us both readability and efficiency, perhaps?
