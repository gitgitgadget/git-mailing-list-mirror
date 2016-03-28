From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] path.c enter_repo(): fix unproper strbuf unwrapping and memory leakage
Date: Mon, 28 Mar 2016 10:58:56 -0700
Message-ID: <xmqqwpomxz4v.fsf@gitster.mtv.corp.google.com>
References: <20160325175947.GC10563@sigill.intra.peff.net>
	<1459180638-6034-1-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pickfire@riseup.net, peff@peff.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:59:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akbRa-00077T-07
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 19:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbcC1R7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 13:59:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753852AbcC1R67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 13:58:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E76624D5FC;
	Mon, 28 Mar 2016 13:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J5vXK/jKY0Y1zNhXDqlTkQ2d03w=; b=NFGrRh
	4fdIGYb7ZMZwzDriIvKtoSAo2eGliEkc1wd/IHEBLL9bhDtjHU/3D1dGR/V9PuJC
	2CEPLt695Jrhs61VZwYtqvoJf8WRIFZ+f2VLMDznoJ7L7TQ2OExd6AdBQJrkIT/k
	j4GSiqdh1ty34YSxu+hZxrfVxknyrR1Cgp7M0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEFRFDIzOiWpi1dhrV1UDVjGTMeEDMxI
	O5C8tcYOGAHO7qug75kVrgqGiEnI0QZb3zV2qrtgdsBIjVYEZDGjnr6M80md7NrC
	McsELEwTzgnj3LPLK3NLlmi3WU9V7/rs/gcDPwy+sho5zTBuzOVNB3264nOwsuAb
	GNj2/Oq1uWI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE7834D5FB;
	Mon, 28 Mar 2016 13:58:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5CD014D5FA;
	Mon, 28 Mar 2016 13:58:57 -0400 (EDT)
In-Reply-To: <1459180638-6034-1-git-send-email-huiyiqun@gmail.com> (Hui
	Yiqun's message of "Mon, 28 Mar 2016 23:57:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE31AB74-F50E-11E5-9562-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290053>

Hui Yiqun <huiyiqun@gmail.com> writes:

> According to strbuf.h, strbuf_detach is the sole supported method
> to unwrap a memory buffer from its strbuf shell.
> ...
> diff --git a/path.c b/path.c
> index 969b494..9801617 100644
> --- a/path.c
> +++ b/path.c
> @@ -625,6 +625,7 @@ const char *enter_repo(const char *path, int strict)
>  {
>  	static struct strbuf validated_path = STRBUF_INIT;
>  	static struct strbuf used_path = STRBUF_INIT;
> ...
> +return_null:
> +	free(dbuf);
> +	strbuf_release(&used_path);
> +	strbuf_release(&validated_path);
>  	return NULL;
>  }

I see these strbuf's are "static" storage class, so that they do not
have to get freed.
