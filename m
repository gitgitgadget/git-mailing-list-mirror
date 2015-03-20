From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] numparse: new module for parsing integral numbers
Date: Fri, 20 Mar 2015 10:51:59 -0700
Message-ID: <xmqq7fubftfk.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<1426608016-2978-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ15b-00071d-TX
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbbCTRwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:52:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751381AbbCTRwC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:52:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A96F40B5D;
	Fri, 20 Mar 2015 13:52:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aVFGAaBoFIjq/3F4pnaFkig6Jmk=; b=gNZPs8ZMNHSXJABn3gKX
	ALMj9vKDsOqcwc7FJglKUkE/gzf8WbyyuMP8U2cj6nfIl9Yk1B2DXDtF0S7AI/aG
	qPkoZcWi6lwKNEP6vch97MLlNWlaRy+Lt2j0MeUq/dm9Q6+3aJB0ZH42Y4dRJ1I0
	oEB3lWub0t30d0D8sPUfCzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Iupe63hq+2QxEX0Pas28NkvYHliVplTgPqAJEPvRSUkxn8
	XjUux4ztvbEWkkIu3+PdWUHaF7XMX08BB6YItvMUaTOnpeaxpL/7ld1X0t91u0j+
	MTIZ8/pIUJot5H2P3uEXGVTW06hpL+TuCIwXPs2QyNNCANDH8LQVqak/npFzQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82AE540B5B;
	Fri, 20 Mar 2015 13:52:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D3B440B5A;
	Fri, 20 Mar 2015 13:52:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF13BBE6-CF29-11E4-AB49-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265921>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +static int parse_precheck(const char *s, unsigned int *flags)
> +{
> +	const char *number;
> +
> +	if (isspace(*s)) {
> +		if (!(*flags & NUM_LEADING_WHITESPACE))
> +			return -NUM_LEADING_WHITESPACE;
> +		do {
> +			s++;
> +		} while (isspace(*s));
> +	}
> +
> +	if (*s == '+') {
> +		if (!(*flags & NUM_PLUS))
> +			return -NUM_PLUS;
> +		number = s + 1;
> +		*flags &= ~NUM_NEGATIVE;
> +	} else if (*s == '-') {
> +		if (!(*flags & NUM_MINUS))
> +			return -NUM_MINUS;
> +		number = s + 1;
> +		*flags |= NUM_NEGATIVE;
> +	} else {
> +		number = s;
> +		*flags &= ~NUM_NEGATIVE;
> +	}
> +
> +	if (!(*flags & NUM_BASE_SPECIFIER)) {
> +		int base = *flags & NUM_BASE_MASK;
> +		if (base == 0) {
> +			/* This is a pointless combination of options. */
> +			die("BUG: base=0 specified without NUM_BASE_SPECIFIER");
> +		} else if (base == 16 && starts_with(number, "0x")) {
> +			/*
> +			 * We want to treat this as zero terminated by
> +			 * an 'x', whereas strtol()/strtoul() would
> +			 * silently eat the "0x". We accomplish this
> +			 * by treating it as a base 10 number:
> +			 */
> +			*flags = (*flags & ~NUM_BASE_MASK) | 10;
> +		}
> +	}
> +	return 0;
> +}

I somehow feel that a pre-processing that only _inspects_ part of
the string, without munging that string (e.g. notice '-' but feed
that to underlying strtol(3)) somewhat a brittle approach.  When I
read the above for the first time, I somehow expected that the code
would notice leading '-', strip that leading '-' and remember the
fact that it did so in the *flags, let the strtol(3) to parse the
remainder _and_ always make sure the returned result is not negative
(because that would imply that the original input had two leading
minuses and digits), and give the sign based on what this preprocess
found out in *flags, and then seeing that there is no sign of such
processing in the caller I scratched my head.

I still have not convinced myself that what I am seeing in the
base==16 part in the above is correct.
