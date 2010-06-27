From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] parse-options: add two helper functions
Date: Sun, 27 Jun 2010 11:22:54 -0700
Message-ID: <7vaaqggwsh.fsf@alter.siamese.dyndns.org>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
 <1277558857-23103-3-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 20:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSwVj-0005fE-2f
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 20:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab0F0SXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 14:23:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab0F0SXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 14:23:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 662F0BF5D6;
	Sun, 27 Jun 2010 14:23:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+ap+PUvA6E2gVGmOWHOWYOehRGQ=; b=Yb359sQ7dflCCOn2hxLSLkZ
	9dD658MRKpUjmGQufPXpGU59hJKaWE61FmOHwD5Uaa0HeMkRHJujvj5mJjl/uxDv
	9IpDAZ2IkhOprZEUnV4wjcPZPIrPHbns76GSB3+6v/iYmF1GgUpIFB+uW01802Vl
	Hw200lkfaDU33O8XkNSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xx8uN6fQKBG+xlQ/1qGIiqH0VARisZqiZfM3Gj0uXvp1FJ1pr
	NofSkvaWKNsWfJuXt5/QwC2Te1+WmnbZ++511g3GxqQnZnjnmceU6wyNvb7UG8S9
	PNVN/8sxUFliqETTsj3vv80gSel5LGwLy+9e0z2UD+N1DZhkqVSE08Sl4o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C21BF5D4;
	Sun, 27 Jun 2010 14:23:02 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 219A4BF5D2; Sun, 27 Jun
 2010 14:22:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05625544-8219-11DF-98AC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149796>

> diff --git a/parse-options.c b/parse-options.c
> index cbb49d3..013dbdb 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -439,6 +439,27 @@ unknown:
>  	return PARSE_OPT_DONE;
>  }
>  
> +const char *parse_options_current(struct parse_opt_ctx_t *ctx)
> +{
> +	return ctx->argv[0];
> +}
> +
> +int parse_options_next(struct parse_opt_ctx_t *ctx, int retain)
> +{
> +	if (ctx->argc <= 0)
> +		return -1;
> +
> +	if (retain == 1)
> +	{
> +		ctx->out[ctx->cpidx++] = ctx->argv[0];
> +	}

Style.  Either drop the unnecessary curly pair, or open the curly at the
end of the line that has the closing parenthesis of "if" condition.

These two functions makes sense.  You could then use parse-options-step to
let the machinery mostly be driven by the usual table lookup, and when
(and only when) the machinery says "I don't know what this is", you can
check "current" to see what it is (e.g. it may be "-L"), handle it
yourself, and if you need to do something different (e.g. eat the <path>
that immedately follows "-L"), you can use "next" to skip it without ever
showing that to the table based parseopt machinery.

I however wonder why you would need two passes if you have these two APIs
into parse-options machinery, though...
