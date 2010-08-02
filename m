From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5 v4] diff: parse detached options --stat-width n,
 --stat-name-width n
Date: Mon, 02 Aug 2010 09:56:31 -0700
Message-ID: <7v1vahnebk.fsf@alter.siamese.dyndns.org>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
 <1280478669-22973-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 18:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfyJk-0002dv-Ht
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 18:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0HBQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 12:56:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0HBQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 12:56:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA321CA503;
	Mon,  2 Aug 2010 12:56:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O3weGKRAYX5IE4oSyzgftwDHE2Q=; b=RLV713
	RXuyKSybG/JY7C0x2iKX7izXpw4ColJovLRnIVK5sX+07tKv7pLYfy97X5ihntFT
	qYsw6N/NCarCL1og6ODTUQevnD/5UWm4JiwLnktBvVItSOT6Lt1xdiU9nWiKV0mi
	RkEGalSs6kwDXq6CYLWYBekcP+8M+8E6qswxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iMi/WRjnNtMUuwkelaTqAO4WqsRAKHgT
	o90ZNLorOAuz7iCskzdPdoT3/X+g16rJGinKcch4uFP4hy5EDPr7j9X5ncp1sOQU
	dOM/fuR3tCQq3nH3uBRAZGhpgMX05X2/gzvZu7lPQ+OCUehxyHZ5yvPmrFSYTup4
	H2+LxpyEDfo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88E87CA502;
	Mon,  2 Aug 2010 12:56:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A84D5CA501; Mon,  2 Aug
 2010 12:56:32 -0400 (EDT)
In-Reply-To: <1280478669-22973-3-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 30 Jul 2010 10\:31\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E971BBD6-9E56-11DF-B3F4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152424>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Part of a campaign for unstuck forms of options.
>
>  	switch (*arg) {
>  	case '-':
> -		if (!prefixcmp(arg, "-width="))
> -			width = strtoul(arg + 7, &end, 10);
> -		else if (!prefixcmp(arg, "-name-width="))
> -			name_width = strtoul(arg + 12, &end, 10);
> +		if (!prefixcmp(arg, "-width")) {
> +			arg += strlen("-width");
> +			if (*arg == '=')
> +				width = strtoul(arg + 1, &end, 10);
> +			else if (!*arg && !av[1])
> +				die("Option '--stat-width' requires a value");
> +			else if (!*arg) {
> +				width = strtoul(av[1], &end, 10);
> +				argcount = 2;
> +			}
> +		} else if (!prefixcmp(arg, "-name-width")) {
> +			arg += strlen("-name-width");
> +			if (*arg == '=')
> +				name_width = strtoul(arg + 1, &end, 10);
> +			else if (!*arg && !av[1])
> +				die("Option '--stat-name-width' requires a value");
> +			else if (!*arg) {
> +				name_width = strtoul(av[1], &end, 10);
> +				argcount = 2;
> +			}
> +		}
>  		break;
>  	case '=':
>  		width = strtoul(arg+1, &end, 10);

This will accept "--stat-width=40", "--stat-width 40", and "--stat=40,20"
but not "--stat 40,20" --- am I reading the patch correctly?

Not a complaint but trying to double-check.  I think it is Ok not to try
guessing wrong (the user may be interested in a path 40,20, for example).

Thanks.
