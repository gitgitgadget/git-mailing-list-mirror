From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Thu, 19 Mar 2015 00:32:34 -0700
Message-ID: <xmqqk2ydjvcd.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<20150319052620.GA30645@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 08:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYUwd-0006qV-5b
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 08:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbbCSHci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 03:32:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750852AbbCSHch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 03:32:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E23E63C20D;
	Thu, 19 Mar 2015 03:32:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1a/HeqLzMm0C3uV6/Deyf+3Gu4Y=; b=YsG7lY
	LhfY/880L851MS3l9DqKqzRhgm2fUhLX0hQVc/Z7VUfA4rQejq6ZPin3UYjbJ1jW
	r3aZ5WNql9lAGsuKfY+P/nq/s0YcI8DxAdBLr2lx0p7A7H7xP8m8CRKT4Z9KioVv
	Pg1XoWDFfwPFGC5pELP50WeQZxum3P9O0OPyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MuqwcUG3BjWlhPU/ttCiDq5yTMXdnspT
	+rP+dq7AHwTRFo73YgGYhvXcPbPG7yRCj+bj31JEIVA5mnTiR0Durj465mKaNvDL
	0tqJTUkuthQX+LU5ufKASeVEGLPvqPRk202UsvBpC45P7716arauKnbTeLSjYAdr
	fSHpKHOaklQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA34D3C20C;
	Thu, 19 Mar 2015 03:32:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5419F3C20A;
	Thu, 19 Mar 2015 03:32:36 -0400 (EDT)
In-Reply-To: <20150319052620.GA30645@peff.net> (Jeff King's message of "Thu,
	19 Mar 2015 01:26:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D3E9FD2-CE0A-11E4-9D17-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265794>

Jeff King <peff@peff.net> writes:

> I wonder how much of the boilerplate in the parse_* functions could be
> factored out to use a uintmax_t, with the caller just providing the
> range. That would make it easier to add new types like off_t, and
> possibly even constrained types (e.g., an integer from 0 to 100). On the
> other hand, you mentioned to me elsewhere that there may be some bugs in
> the range-checks of config.c's integer parsing. I suspect they are
> related to exactly this kind of refactoring, so perhaps writing things
> out is best.

I like this idea very well.  I wonder if we can implement the family
of

    parse_{type}(const char *, unsigned int flags,
    		 const char **endptr, {type} *result)

functions by calls a helper that internally deals with the numbers
in uintmax_t, and then checks if the value fits within the possible
range of the *result before returning.

    int parse_i(const char *str, unsigned flags,
		const char **endptr, int *result) {
	uintmax_t val;
        int sign = 1, status;
        if (*str == '-') {
		sign = -1; 
                str++;
	}
        status = parse_num(str, flags, endptr, &val, INT_MAX);
        if (status < 0)
        	return status;
	*result = sign < 0 ? -val : val;
        return 0;
    }

(assuming the last parameter to parse_num is used to check if the
result fits within that range).  Or that may be easier and cleaner
to be done in the caller with or something like that:

	status = parse_num(str, flags, endptr, &val);
        if (status < 0)
        	return status;
	if (INT_MAX <= val * sign || val * sign <= INT_MIN) {
        	errno = ERANGE;
                return -1;
	}

If we wanted to, we may even be able to avoid duplication of
boilerplate by wrapping the above pattern within a macro,
parameterizing the TYPE_{MIN,MAX} and using token pasting, to
expand to four necessary result types.

There is no reason for the implementation of the parse_num() helper
to be using strtoul(3) or strtoull(3); its behaviour will be under
our total control.  It can become fancier by enriching the flags
bits (e.g. allow scaling factor, etc.) only once and all variants
for various result types will get the same feature.
