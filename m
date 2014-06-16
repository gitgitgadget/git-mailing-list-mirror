From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: fix charset detection of extract_content_type()
Date: Mon, 16 Jun 2014 11:29:39 -0700
Message-ID: <xmqqha3kr9m4.fsf@gitster.dls.corp.google.com>
References: <539caff7.e7bc420a.76b9.fffff853@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nori <semtlenori@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbfC-00078Z-N5
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbaFPS3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:29:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51237 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105AbaFPS3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:29:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D14F203A9;
	Mon, 16 Jun 2014 14:29:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VzNwBqplfhAw52VROl06URE9ZIE=; b=ZH6VjN
	UlDQu5MeF82psBMZU9UTSvkSzF3lonczR6twTXFV1V72jwNUM+24nWxMMkoQ6Kps
	tJsjybGGmgkGGrdyCXng4x0R+r2eMxMdCJQUvk2Ym2+olpOBRowW0feNUiWxNbwW
	JLe4laayUhk62wTxdDfEKix+w2J/FA4xpHias=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TpArhyPNvBI+a+uFQ+PEJxpe9hsqg7pu
	OHUqX24vASA6cBd9MGWsk6B4mhSsiuiO1goH3UXD7F4GPXBAkhEHFiSECFyCT7uP
	Q1ZkquIIYzemNC1nDQ1cnKH+x/FEXrLj+2sXx3yDOXvzSyd5TMHVfdFLL1efl4sl
	CFATAYVMDPU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43863203A8;
	Mon, 16 Jun 2014 14:29:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0025D203A0;
	Mon, 16 Jun 2014 14:29:38 -0400 (EDT)
In-Reply-To: <539caff7.e7bc420a.76b9.fffff853@mx.google.com> (nori's message
	of "Sun, 15 Jun 2014 03:49:34 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2CF728AE-F584-11E3-806D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251795>

nori <semtlenori@gmail.com> writes:

> extract_content_type() could not extract a charset parameter if the
> parameter is not the first one and there is a whitespace and a following
> semicolon just before the parameter. For example:
>
>     text/plain; format=fixed ;charset=utf-8
>
> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
> ---

Peff, doesn't this look somehow familiar?  Perhaps with e3131626
(http: optionally extract charset parameter from content-type,
2014-05-22), this patch is unnecessary?

>  http.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index 2b4f6a3..05e8b91 100644
> --- a/http.c
> +++ b/http.c
> @@ -971,7 +971,7 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>  
>  	strbuf_reset(charset);
>  	while (*p) {
> -		while (isspace(*p))
> +		while (isspace(*p) || *p == ';')
>  			p++;
>  		if (!extract_param(p, "charset", charset))
>  			return;
