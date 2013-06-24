From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 01/16] test: add test cases for relative_path
Date: Mon, 24 Jun 2013 12:01:27 -0700
Message-ID: <7vli5z8ha0.fsf@alter.siamese.dyndns.org>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<85c9aa4d05dba4320a7cc85eae7570e0f450e58e.1372087065.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrC19-0005QN-HN
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab3FXTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:01:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935Ab3FXTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:01:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA6382AF00;
	Mon, 24 Jun 2013 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gOcQedzEPPf4qirqtwVaIPgj+/E=; b=kH1rNh
	VC1vpRghO8HTtmxipEVmbZfxzBrc4h5GAknYpSz9/xe261AL7ovbU/K27e2uLc1D
	fr/tv2GOF4ZZ/8qCTG3YkNpQAqFxr5UihzJBA0+TVZ3XP3xbTmqCOwbZmqZRqam0
	9sDTlrx+VtWtPPuSFtjAQR6pBiyFQmeFROJhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WVYEXok/D1GFXPdXP8e3RYFRF+EtiJyL
	LGeHHbBUAxg9YzRdNKzrmXk15C7+Xx2+z/+TbA42qyh/wPr9d3cdXfdlRjzss00B
	ZvsdPF1NKOmLaraeUc+dmxxQV1eR/veLHJK6u4ZF28S9sNomBkPq5iyLSBJdwtmB
	OlGNE0YoGWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE4F32AEFF;
	Mon, 24 Jun 2013 19:01:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D2C32AEFC;
	Mon, 24 Jun 2013 19:01:29 +0000 (UTC)
In-Reply-To: <85c9aa4d05dba4320a7cc85eae7570e0f450e58e.1372087065.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Mon, 24 Jun 2013 23:21:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A0D57D2-DD00-11E2-AEF5-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228899>

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/test-path-utils.c b/test-path-utils.c
> index 0092cb..dcc530 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -28,6 +28,19 @@ static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
>  	return 1;
>  }
>  
> +static void normalize_argv_string(const char **var, const char *input)
> +{
> +	if (!strcmp(input, "<null>"))
> +		*var = NULL;
> +	else if (!strcmp(input, "<empty>"))
> +		*var = "";
> +	else
> +		*var = input;
> +
> +	if (*var && (**var == '<' || **var == '('))
> +		die("Bad value: %s\n", input);
> +}
> +

If you have to munge the input string like this anyway, perhaps you
can work around the command line mangling done by Windows bash
runtime, perhaps add something like:

	if (*input == '_')
        	input++;

and then protecting the path with the underscore, like so?

	relative_path _/a/b/c/	_/a/b/		c/

Wouldn't that let you avoid having to handle "POSIX" prereq for
these paths?
