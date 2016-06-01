From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 28/39] i18n: config: unfold error messages marked for translation
Date: Wed, 01 Jun 2016 10:43:33 -0700
Message-ID: <xmqqzir4yfcq.fsf@gitster.mtv.corp.google.com>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
	<1464799289-7639-29-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:44:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ABV-0003M9-LH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 19:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbcFARnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 13:43:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932719AbcFARnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 13:43:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 714CC1E649;
	Wed,  1 Jun 2016 13:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y7pEd7m91u7xpiuEUp+4vngdcEs=; b=tY9cnF
	XA5Q3zgrlFY+xGPq1xrJmPFcvzXS4fNfxN62xFnCE67xuwIKAmT4XGo/trbp7/GD
	38olU5TedVEx6FdzcEY1iVXPVP0IEHQpNny5+Zned9MMiMwlXwPByqmfGha+KZbU
	+B/WJQa9+8jWqgI+1O7aDrPN0U1xQZcHPIvs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H+APXf+3oTMbQ/VYMv+fqc4andKBqLXv
	TlaHPmoj+C8ogQ0kLJfYIRq7f9pGR5nDFWpHANU4qfXN/qesOBHSelExuceUySmd
	/6ure/9YKw/j8LSQTAp/J5XVJ1ZuSrvogwes7bWnWgHI5vIXqEtB2+CqNnnzMW3J
	UHQxtqYFrHU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68A191E647;
	Wed,  1 Jun 2016 13:43:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E406D1E646;
	Wed,  1 Jun 2016 13:43:34 -0400 (EDT)
In-Reply-To: <1464799289-7639-29-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Wed, 1 Jun 2016 16:41:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D3930C2-2820-11E6-AE05-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296138>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Introduced in 473166b ("config: add 'origin_type' to config_source
> struct", 2016-02-19), Git can inform the user about the origin of a
> config error, but the implementation does not allow translators to
> translate the keywords 'file', 'blob, 'standard input', and
> 'submodule-blob'. Moreover, for the second message, a reason for the
> error is appended to the message, not allowing translators to translate
> that reason either.

Good intentions.

> @@ -417,6 +417,7 @@ static int git_parse_source(config_fn_t fn, void *data)
>  	int comment = 0;
>  	int baselen = 0;
>  	struct strbuf *var = &cf->var;
> +	char error_msg[128];
>  
>  	/* U+FEFF Byte Order Mark in UTF8 */
>  	const char *bomptr = utf8_bom;
> @@ -471,10 +472,38 @@ static int git_parse_source(config_fn_t fn, void *data)
>  		if (get_value(fn, data, var) < 0)
>  			break;
>  	}
> +
> +	switch (cf->origin_type) {
> +	case CFG_BLOB:
> +		xsnprintf(error_msg, sizeof(error_msg),
> +			  _("bad config line %d in blob %s"),
> +			  cf->linenr, cf->name);

Use xstrfmt() intead, perhaps?  That would be cleaner.
