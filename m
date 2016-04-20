From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] convert.c: ident + core.autocrlf didn't work
Date: Wed, 20 Apr 2016 15:27:37 -0700
Message-ID: <xmqqoa93ud9i.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461072363-2874-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Apr 21 00:27:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at0b3-0004tt-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 00:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbcDTW1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 18:27:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751188AbcDTW1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 18:27:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02D2216056;
	Wed, 20 Apr 2016 18:27:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=og0aPvESddSvRxtN1Qxmkc2bImo=; b=OW/nGe
	/S9Ds4WZRrxPyWx4+EEdZ58yFp8QNjqbgD6NCFR0SjXvAlBkA8U/BLqcvjWTrQ0v
	QuaSD+YLcf2zJV0vmow8KBe2XPXxqRSAJUoNDH2UG6E9whj25uFNDJHe2eSeXpV6
	zAuO7UtaUdoNFzcGlIeuLc+hfhAro6CNh35Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tb7fO5mJH9axccR22VXXwi3CLw5hl1GD
	GyDCrNzKIdLt7ggUnZvjARwQVg0wlZ3a+2GVZjBRAiti/kDNUPBKJRULKCGHAxSU
	RT5h68MPLyxv4BlYOJcEREpOcbID2QidksofrVORohCvrmG4LMs0CoHCnyWrn0JC
	4CXYSS/nLU4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5A8616055;
	Wed, 20 Apr 2016 18:27:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C44116054;
	Wed, 20 Apr 2016 18:27:38 -0400 (EDT)
In-Reply-To: <1461072363-2874-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Tue, 19 Apr 2016 15:26:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 16848716-0747-11E6-84FE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292087>

tboegi@web.de writes:

>  	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
> -		return filter;
> +		return NULL;
>  
>  	if (ca.ident)
>  		filter = ident_filter(sha1);

We allocated an ident-filter here...

> -	crlf_action = ca.crlf_action;
> -
> -	if ((crlf_action == CRLF_BINARY) ||
> -			crlf_action == CRLF_AUTO_INPUT ||
> -			(crlf_action == CRLF_TEXT_INPUT))
> -		filter = cascade_filter(filter, &null_filter_singleton);
> -
> -	else if (output_eol(crlf_action) == EOL_CRLF &&
> -		 !(crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_CRLF))
> +	if (output_eol(ca.crlf_action) == EOL_CRLF) {
> +		if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
> +			return NULL;

and then by returning NULL, we lost it.

>  		filter = cascade_filter(filter, lf_to_crlf_filter());
> +	} else
> +		filter = cascade_filter(filter, &null_filter_singleton);
>  
>  	return filter;
>  }
