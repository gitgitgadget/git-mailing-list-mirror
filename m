From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: Recognize epoch timestamps with : in the timezone
Date: Wed, 13 Oct 2010 16:37:15 -0700
Message-ID: <7vvd55fyvo.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
 <20100929214107.GA4485@capella.cs.uchicago.edu>
 <7v4ocpncli.fsf@alter.siamese.dyndns.org>
 <7vvd55lwjl.fsf@alter.siamese.dyndns.org> <20101013225012.GB9509@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@ksplice.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 01:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6AtT-00063f-RD
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 01:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab0JMXhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 19:37:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab0JMXhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 19:37:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C08B6DE781;
	Wed, 13 Oct 2010 19:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TqvYJZaz0wNtFsJ5NPbHULoxZpQ=; b=ruplr6
	iSukhDtL0O9CVfDJJsmk/wVCEOY+4lbvOrb3ilmK2f5wpGOHbLK/2x14VAJ523Et
	ttIPrlUfRKtUakOqDktz9y3tU5ZZUMxzmMf+ZmNwbWNVNUO81rn6CYGyOC7DRxOa
	G+hWTf9j6ZsmFqzUiojycNCZPoSmzr/pd94qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=woygVQqsh0lxLBV+y9y/mfHQY9eFuZl3
	Yc3XvjPasgnSu8mWVNGi4JsPA7w+3k/FMrtoEQJt3uR48ThvoyBnbrOFMq/iAsoj
	eYASu3eqrejN5ojKZrvworeGEdMfaHy2caN87xr9+ky7W7QEvuvP0nVaE2q4lJ6F
	1lutdWbsbE0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AF3ADE780;
	Wed, 13 Oct 2010 19:37:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6B59DE77A; Wed, 13 Oct
 2010 19:37:16 -0400 (EDT)
In-Reply-To: <20101013225012.GB9509@burratino> (Jonathan Nieder's message of
 "Wed\, 13 Oct 2010 17\:50\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D287DDD8-D722-11DF-87FF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159007>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Neither the patch nor your suggestion makes much sense to me.  With the
>>> patch, the regexp is now
>>>
>>>     ^(1969-12-31|1970-01-01) <time>(\.0+)? ([-+][0-2][0-9]):?([0-5][0-9])
> [...]
>> Well, I was missing that without ':' strtol() goes through to parse $3$4
>> as a single integer
>
> So maybe something like the following would make this easier to follow.

Yeah, this feels much more natural.

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 0fa9a8d..000d3e5 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -733,8 +733,8 @@ static int has_epoch_timestamp(const char *nameline)
>  		" "
>  		"[0-2][0-9]:[0-5][0-9]:00(\\.0+)?"
>  		" "
> -		"([-+][0-2][0-9]):?([0-5][0-9])\n";
> +		"([-+][0-2][0-9]:?[0-5][0-9])\n";
> -	const char *timestamp = NULL, *cp;
> +	const char *timestamp = NULL, *cp, *colon;
>  	static regex_t *stamp;
>  	regmatch_t m[10];
>  	int zoneoffset;
> @@ -764,10 +764,11 @@ static int has_epoch_timestamp(const char *nameline)
>  		return 0;
>  	}
>  
> -	zoneoffset = strtol(timestamp + m[3].rm_so + 1, NULL, 10);
> +	zoneoffset = strtol(timestamp + m[3].rm_so + 1, (char **) &colon, 10);
> -	if (m[4].rm_so == m[3].rm_so + 3)
> -		zoneoffset /= 100;
> -	zoneoffset = zoneoffset * 60 + strtol(timestamp + m[4].rm_so, NULL, 10);
> +	if (*colon == ':')
> +		zoneoffset = zoneoffset * 60 + strtol(colon + 1, NULL, 10);
> +	else
> +		zoneoffset = (zoneoffset / 100) * 60 + (zoneoffset % 100);
>  	if (timestamp[m[3].rm_so] == '-')
>  		zoneoffset = -zoneoffset;
>  
