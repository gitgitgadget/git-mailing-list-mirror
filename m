From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Wed, 18 Mar 2015 23:22:14 -0700
Message-ID: <xmqq7fudld61.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 19 07:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYTqX-0007Td-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 07:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbbCSGWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 02:22:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750799AbbCSGWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 02:22:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7E4A3A4FB;
	Thu, 19 Mar 2015 02:22:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FAhgYZEW0wiAzoPWycJl0xHrUg8=; b=jYe4Xs
	6/ue7KxmRFvrC6WF1KiRGrRYuMWiGWJeXa1DTTxZrzm6EQEXLukXxqgyuVwoe5aN
	a4FYolat7lSZ128Vrj1Jg6XTacCWdJJYHJei0CuhyBSFkv8NaFpS0Hb8OgmYMyWd
	yQRs0kML9RU0Qp1BuwA09lfmyTMclx01ag0SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OIt/A5TG6xGWhhoB7rDBNyF+EAe1GWC0
	3cot5zKrFEq9fvFGSJU0Kuo3FlXtq8l/I8kdsWGgL+VTID+1oHOCqA8ucKmqlGqW
	eUKKIEMpThn5Tky7SgA3JX3UVKtyBMcI44xIIQ2c/EHJRsRcciBLZIVGiSWD2JL/
	q0gz9r9dpfQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFB7D3A4FA;
	Thu, 19 Mar 2015 02:22:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 613D83A4F8;
	Thu, 19 Mar 2015 02:22:15 -0400 (EDT)
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 17 Mar 2015 17:00:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 495CD476-CE00-11E4-B067-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265787>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * It allows leading whitespace.

This might be blessing in disguise.  Our friends on MacOS may be
relying on that

    git cmd --abbrev="$(wc -c <foo)"

to work "as expected", even though their "wc" gives leading spaces,
for example.

> * It allows arbitrary trailing characters.

Which is why we have introduced strtoul_ui() and such.

> * It allows a leading sign character ('+' or '-'), even though the
>   result is unsigned.

I do not particularly see it a bad thing to accept "--abbrev=+7".
Using unsigned type to accept a width and parsing "--abbrev=-7" into
a large positive integer _is_ a problem, and we may want to fix it,
but I think that is still within the scope of the original "better
strtol/strtoul", and I do not see it as a justification to introduce
a set of functions with completely unfamiliar name.

> * If the string doesn't contain a number at all, it sets its "endptr"
>   argument to point at the start of the string but doesn't set errno.

Why is that a problem?  A caller that cares is supposed to check
endptr and the string it gave, no?  Now, if strtoul_ui() and friends
do not do so, I again think that is still within the scope of the
original "better strtol/strtoul".

> * If the value is larger than fits in an unsigned long, it returns the
>   value clamped to the range 0..ULONG_MAX (setting errno to ERANGE).

Ditto.

> * If the value is between -ULONG_MAX and 0, it returns the positive
>   integer with the same bit pattern, without setting errno(!) (I can
>   hardly think of a scenario where this would be useful.)

Ditto.

> * For base=0 (autodetect base), it allows a base specifier prefix "0x"
>   or "0" and parses the number accordingly. For base=16 it also allows
>   a "0x" prefix.

Why is it a problem to allow "git cmd --hexval=0x1234", even if "git
cmd --hexval=1234" would suffice?

> When I looked around, I found scores of sites that call atoi(),
> strtoul(), and strtol() carelessly. And it's understandable. Calling
> any of these functions safely is so much work as to be completely
> impractical in day-to-day code.

Yes, these burdens on the caller were exactly why strtoul_ui()
etc. wanted to reduce---and it will be a welcome change to do
necessary checks that are currently not done.

> Please see the docstrings in numparse.h in the first commit for
> detailed API docs. Briefly, there are eight new functions:
>
>     parse_{l,ul,i,ui}(const char *s, unsigned int flags,
>                       T *result, char **endptr);
>     convert_{l,ul,i,ui}(const char *s, unsigned int flags, T *result);
>
> The parse_*() functions are for parsing a number from the start of a
> string; the convert_*() functions are for parsing a string that
> consists of a single number.

I am not sure if I follow.  Why not unify them into one 4-function
set, with optional endptr that could be NULL?

While we are on the topic of improving number parsing, one thing
that I found somewhat frustrating is that config.c layer knows the
scaling suffix but option parsing layer does not.  These functions
should offer an option (via their "flags") to say "I allow scaled
numbers like 2k, 4M, etc.".
