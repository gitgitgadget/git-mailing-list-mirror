From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Thu, 28 Mar 2013 15:30:44 -0700
Message-ID: <7vk3orrwbv.fsf@alter.siamese.dyndns.org>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 23:31:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLLt-0005q8-RC
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 23:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab3C1Wax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 18:30:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab3C1Waw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 18:30:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2222EE2B2;
	Thu, 28 Mar 2013 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ps3hGGgiWrt1GN+r10DqV7R0J4k=; b=ZhLvWW
	Roq7LT8N3EyOY1OIGhuSo+q8UdCw+TdwV0ivzgrC+YE04kXQK25hZbp+9gheaYVt
	uat1/jAQPlHSUCHJm+s5oeNkNK0h/Lew4Qw1Fbia5Mt0ORd9f/mPWkCbdX/QD8Qr
	HXK8AntC5w2pHzzka5c/ZcUWEfOqRICeLHy2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cpFz1CvvETn3b7Iw/mWEcKi1Z1fQ6Tfc
	GbMSWtRq2uUa7qWeZaC74MZGbQpOJVSj4F2FSSLxSY4dbQwOfZHw9NkgeIQiSgzi
	k1Hee7N2WMUqt7m5NXUi+DcaVDrfM60dHJxTqWwcCtj1CVX1GwFoKHVj87yUlFHe
	asisN4jFGho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18503E2B1;
	Thu, 28 Mar 2013 22:30:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89F9FE2AF; Thu, 28 Mar 2013
 22:30:51 +0000 (UTC)
In-Reply-To: <20130328214821.GD10936@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 28 Mar 2013 17:48:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 257628E6-97F7-11E2-8953-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219471>

Jeff King <peff@peff.net> writes:

> This function takes two counted strings: a <pattern, patternlen> pair
> and a <pathname, pathlen> pair. But we end up feeding the result to
> fnmatch, which expects NUL-terminated strings.
>
> We can fix this by calling the fnmatch_icase_mem function, which
> handles re-allocating into a NUL-terminated string if necessary.
>
> While we're at it, we can avoid even calling fnmatch in some cases. In
> addition to patternlen, we get "prefix", the size of the pattern that
> contains no wildcard characters. We do a straight match of the prefix
> part first, and then use fnmatch to cover the rest. But if there are
> no wildcards in the pattern at all, we do not even need to call
> fnmatch; we would simply be comparing two empty strings.

It is not a new issue, but it would be nicer to have a comment to
warn people that this part needs to be adjusted when they want to
add support for using FNM_PERIOD in our codebase.

Other than that, looks sane to me.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> New in this iteration.
>
>  dir.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index cc4ce8b..3ad44c3 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -624,11 +624,22 @@ int match_pathname(const char *pathname, int pathlen,
>  		if (strncmp_icase(pattern, name, prefix))
>  			return 0;
>  		pattern += prefix;
> +		patternlen -= prefix;
>  		name    += prefix;
>  		namelen -= prefix;
> +
> +		/*
> +		 * If the whole pattern did not have a wildcard,
> +		 * then our prefix match is all we need; we
> +		 * do not need to call fnmatch at all.
> +		 */
> +		if (!patternlen && !namelen)
> +			return 1;
>  	}
>  
> -	return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
> +	return fnmatch_icase_mem(pattern, patternlen,
> +				 name, namelen,
> +				 FNM_PATHNAME) == 0;
>  }
>  
>  /* Scan the list and let the last match determine the fate.
