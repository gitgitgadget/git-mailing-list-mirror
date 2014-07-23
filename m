From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] config.c: fix accuracy of line number in errors
Date: Wed, 23 Jul 2014 14:49:43 -0700
Message-ID: <xmqqegxbd9u0.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:49:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA4Q9-0005rc-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933824AbaGWVtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:49:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53238 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933756AbaGWVtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:49:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FA312B55F;
	Wed, 23 Jul 2014 17:49:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fmywA1aIK6Z09tmYqhZzAZmSHOw=; b=WyZGlk
	PywMdSpwLdydVL8o0VUG+1DI2XB7V8Xk6prsoScXMPdlherQVBJtex/ef9R9kxVy
	mSRhPThhLt6URyyL4SanNqnatHNU/j3p2uUvNqF/Z6q5+E8Jsx10OFWQAWdF7lsM
	JBsgtS3nGou3afU+FwPmZ8wI4wr0x4uQ1wvbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wpZP9sCRbVeYgX39DzfS7TkTz737qgEF
	A68fORRk1E7pqelofv+tuQDnk1++hfM+Gh827qU5aI/M/JS3hc884OLW3XIhKztE
	zPNVT//eqgv/XRg99Vi+od84rkGk/fDs9Qf+0jskvUcZ0u4dKCHJ0N72g8Md6kmh
	lzlxus4nvZA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1212E2B55E;
	Wed, 23 Jul 2014 17:49:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8F2FC2B54D;
	Wed, 23 Jul 2014 17:49:45 -0400 (EDT)
In-Reply-To: <1406140978-9472-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42BB9ED0-12B3-11E4-9345-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254130>

Tanay Abhra <tanayabh@gmail.com> writes:

> If a callback returns a negative value to `git_config*()` family,
> they call `die()` while printing the line number and the file name.
> Currently the printed line number is off by one, thus printing the
> wrong line number.
>
> Make `linenr` point to the line we just parsed during the call
> to callback to get accurate line number in error messages.
>
> Discovered-by: Tanay Abhra <tanayabh@gmail.com>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

Thanks.

I am not sure what to read in these two lines.  Was the fix done by
you or Matthieu?

> ---
>  config.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 22971e9..6db8f97 100644
> --- a/config.c
> +++ b/config.c
> @@ -244,6 +244,7 @@ static int get_next_char(void)
>  		cf->linenr++;
>  	if (c == EOF) {
>  		cf->eof = 1;
> +		cf->linenr++;
>  		c = '\n';
>  	}
>  	return c;
> @@ -319,6 +320,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>  {
>  	int c;
>  	char *value;
> +	int ret;
>  
>  	/* Get the full name */
>  	for (;;) {
> @@ -341,7 +343,15 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>  		if (!value)
>  			return -1;
>  	}
> -	return fn(name->buf, value, data);
> +	/*
> +	 * We already consumed the \n, but we need linenr to point to
> +	 * the line we just parsed during the call to fn to get
> +	 * accurate line number in error messages.
> +	 */
> +	cf->linenr--;
> +	ret = fn(name->buf, value, data);
> +	cf->linenr++;
> +	return ret;
>  }
>  
>  static int get_extended_base_var(struct strbuf *name, int c)
