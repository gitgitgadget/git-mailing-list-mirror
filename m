From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] fast-import: don't fail on omitted committer name
Date: Thu, 11 Aug 2011 15:06:59 -0700
Message-ID: <7vwrejppq4.fsf@alter.siamese.dyndns.org>
References: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
 <1313058070-4774-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, SASAKI Suguru <sss.sonik@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 00:07:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrdPJ-0000MX-6P
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 00:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab1HKWHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 18:07:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349Ab1HKWHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 18:07:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF6F64729;
	Thu, 11 Aug 2011 18:07:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wHtucB717pAEieIXU3WH3g4moXc=; b=oi2iRc
	DahcLUktiu3BTx0SBrwf8avp5I0MIuRvl+j6HvbEFlftHxQZl0YJ64FfWIoTft0v
	rWkexeJYJB6RAVYvJIgKya73tuP2Q9tw5NNznD71KaA8BkGP+hTg0bsz+uJtCoTj
	Tvur7sYKOrBN4Qkep7+/Wy5CgcsFuHAE0+U24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TP1VRXR0KssPgSE4t7UydsDnIbzaIO1/
	t0/u3bN0wjEmiu7L+9ZFy1vidHsezQwe/XgtOfH1JGY5y2/UE5CMu3OLnMhnvDDS
	dmtnwYz0bp7k6HfPKFFwru19bgXGaz/sSXfpQ+xEXVwI5kbnFFKP3ijh3u8km/qS
	JiWIoHw8atY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5BB04728;
	Thu, 11 Aug 2011 18:07:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25C024727; Thu, 11 Aug 2011
 18:07:01 -0400 (EDT)
In-Reply-To: <1313058070-4774-3-git-send-email-divanorama@gmail.com> (Dmitry
 Ivankov's message of "Thu, 11 Aug 2011 16:21:07 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D15A866-C466-11E0-9611-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179147>

Dmitry Ivankov <divanorama@gmail.com> writes:

> diff --git a/fast-import.c b/fast-import.c
> index 7cc2262..ed1f7c9 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1973,6 +1973,10 @@ static char *parse_ident(const char *buf)
>  	size_t name_len;
>  	char *ident;
>  
> +	/* ensure there is a space delimiter even if there is no name */
> +	if (*buf == '<')
> +		--buf;
> +

This is somewhat cryptic, even though it may be correct, especially if the
reader of the code does not know that this function is called by the
caller after reading "author " (or committer/tagger) and buf points at one
byte beyond that SP after the string that specifies the kind of the
person, hence "--buf" [*1*] makes the subsequent strncpy() start copying
from that SP which makes the result correct.

Perhaps an additional comment before the function is in order?

Thanks.

[Footnote]

*1* by the way, as pure style thing, I think our codebase favors to use
post-*crement, i.e. "buf--", if you are doing pre/post-*crement purely for
its side effect.
