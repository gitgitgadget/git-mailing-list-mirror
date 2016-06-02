From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] pathspec: allow escaped query values
Date: Thu, 02 Jun 2016 16:23:41 -0700
Message-ID: <xmqqwpm7qio2.fsf@gitster.mtv.corp.google.com>
References: <20160602231413.9028-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, ramsay@ramsayjones.plus.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:23:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bxs-0007UL-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbcFBXXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:23:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932587AbcFBXXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:23:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B89B219DF;
	Thu,  2 Jun 2016 19:23:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o3K0DMx07bG9yoOqYm7VXWz4S9o=; b=UJ/U4E
	tSAYNeA25TVWw+cb5BVdvyEH8Yq+mqXDR94MSktiUIaREuWJmGpvM9xB2nB9Fker
	wahI71sAi8HlRdS/WCyt0XFOXISNF3RQFPekql3z1OQg3CeAPzOGfVZ/3SDuHPNC
	COzWbDHPdKHv4DdIJxJURk6bVPw7sxDKiSu8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jI+G7g7bu8vTvTNCW43bMZrXxznhZTBT
	iGsDxU7kTUU5lcRtkkQSKg4JBeOimuULosgBF1Gjjj++FZOxtB3FNCMzUnkM7+6h
	mBSXHjKuDmG9MsWwGrSkXxX0M7w+yjKjeze2iybbVFmxVVv77nI89ddJw4Tf43Ea
	I7yxktdH5TI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 53C36219DE;
	Thu,  2 Jun 2016 19:23:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFA65219DD;
	Thu,  2 Jun 2016 19:23:42 -0400 (EDT)
In-Reply-To: <20160602231413.9028-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 2 Jun 2016 16:14:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0BA98A3C-2919-11E6-80D9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296262>

Stefan Beller <sbeller@google.com> writes:

> However if we add a value restriction here, we need to be as strict in the
> .gitattributes parsing as well and put a warning there (similar to
> invalid_attr_name_message) I would think.

Remember, the attribute system is used for many purposes other than
this new "further limit pathspec".  While the (hopefully temporary)
limitation hurts here, users will limit the attributes they use for
":(attr:VAR=VAL)" pathspec magic, and it is unlikely that either the
VAR part or its VALue are something the core Git currently uses
anyway.

So I do not think it is necessary or even beneficial to add such a
warning.

> +static char *attr_value_unescape(const char *value)
> +{
> +	const char *src;
> +	char *dst, *ret;
> +
> +	ret = xmallocz(strlen(value));
> +	for (src = value, dst = ret; *src; src++, dst++) {
> +		if (*src == '\\') {
> +			if (!src[1])
> +				die(_("Escape character '\\' not allowed as "
> +				      "last character in attr value"));
> +			src++;
> +		}
> +		if (*src && invalid_value_char(*src))
> +			die("cannot use '%c' for value matching", *src);
> +		*dst = *src;
> +	}
> +	*dst = '\0';
> +	return ret;
> +}

Please sanity-check me.  Just like I said to your original "I doubt
*i could be NUL here", I now doubt *src could be NUL there where
invalid_value_char() gets called.

If *src could be NUL there, then *dst gets NUL once, and then after
loop exits (presumably after incrementing dst), *dst gets another
NUL, which was the terminating NUL condition being iffy I mentioned,
but as you said, I do not think it would happen, so we can lose the
"*src && " before invalid_value_char() is called.

Thanks.
