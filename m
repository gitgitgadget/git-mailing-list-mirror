From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 20 May 2016 15:37:26 -0700
Message-ID: <xmqqshxcbbkp.fsf@gitster.mtv.corp.google.com>
References: <20160520132829.7937-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 21 00:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3t3F-0004Xj-HI
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcETWhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:37:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751314AbcETWha (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:37:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2920C1CB77;
	Fri, 20 May 2016 18:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nBybU/Kx4kAmEn+TK75/Y/VN3/w=; b=v7xZij
	2m1BkMrGMQ6QLEQYhdiQ0nj2JVbYknT7/GBGp/TqyDvYxwnfk5pPUFtcX5o5mnGG
	SVRL4VJESpKWzahZp9+PLfpM37siUe7UM0Ct2KJOzGLZXfM7KhwVGB4kxB1WqSr1
	JEFk1/c7ZjaBuD0OhlXBqRhjsWd7OEsoGuTLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZIW7g2h3RjGmGNefdKfIOlkC2fjFAVW
	L71N/9Lt9HdU6RPkBoj63oo82VOzPwgsOfZzRXgGb2o1E7JmMgoyKwNNzH+WRW3b
	D56A1c0ie+4kmPhkSQH2QLer8Jy/0ZRV6BUCewxFcrNzMmV3njnqGYT3HhgxowEX
	16N3tzVEVEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21DEA1CB76;
	Fri, 20 May 2016 18:37:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96B341CB75;
	Fri, 20 May 2016 18:37:28 -0400 (EDT)
In-Reply-To: <20160520132829.7937-1-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Fri, 20 May 2016 15:28:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EC314A0-1EDB-11E6-BDF2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295219>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> CSS is widely used, motivating it being included as a built-in pattern.
>
> It must be noted that the word_regex for CSS (i.e. the regex defining
> what is a word in the language) does not consider '.' and '#' characters
> (in CSS selectors) to be part of the word. This behavior is documented
> by the test t/t4018/css-rule.
> The logic behind this behavior is the following: identifiers in CSS
> selectors are identifiers in a HTML/XML document. Therefore, the '.'/'#'
> character are not part of the identifier, but an indicator of the nature
> of the identifier in HTML/XML (class or id). Diffing ".class1" and
> ".class2" must show that the class name is changed, but we still are
> selecting a class.

In other words, if "div#foo" changed to "span#bar", word-diff would
say that "div changed to span, # didn't change and foo changed to
bar".

Which makes sense to me.

The above is not a request to change anything; just me thinking
aloud to see if I agree with the reasoning.

> diff --git a/userdiff.c b/userdiff.c
> index 6bf2505..0f9cfbe 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -148,6 +148,14 @@ PATTERNS("csharp",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
> +PATTERNS("css",
> +	 "^([^,{}]+)((,[^}]*\\{)|([ \t]*\\{))$",
> +	 /* -- */
> +	 /* This regex comes from W3C CSS specs. Should theoretically also allow ISO 10646 characters U+00A0 and higher,
> +	  * this not handled in this regex. */
> +	 "-?[_a-zA-F][-_a-zA-F0-9]*" /* identifiers */
> +	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
> +),

Style:

	/*
         * This regex comes from ...
         * ...
         * but they are not handled with this regex.
         */

I wonder if IPATTERN() may make it easier to express the above.

Also, a-zA-F (twice seen in "identifiers" section) looks somewhat
suspicious.  a-fA-F or a-zA-Z I would understand, and I suspect this
is a misspelled form of the latter.
