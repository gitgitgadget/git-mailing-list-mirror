From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] color: allow multiple attributes
Date: Sun, 28 Feb 2010 10:16:19 -0800
Message-ID: <7vhbp1cjkc.fsf@alter.siamese.dyndns.org>
References: <7vfx4mv0h9.fsf@alter.siamese.dyndns.org>
 <1267325798-8280-1-git-send-email-gitster@pobox.com>
 <20100228122019.GB24247@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Lodato <lodatom@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 28 19:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlngx-0005Su-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 19:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab0B1SQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 13:16:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab0B1SQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 13:16:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B16B9E8C6;
	Sun, 28 Feb 2010 13:16:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Vc8o9Dg679n0omBsFDifcB+DmKw=; b=hl0Xdnx+8/pNBykwmAfTj0+
	H8y4pFzuHWnIYmYqKjGOkWOR0F6HpammAQ3aQtQIVqNaIiJiZh+Hu66auw95PFbF
	Im7rKvLlnxeNh9rlIpXyfwJ+rtF564nXWJXcowAFyp9JUhi8eop/56Lvrypi1w7P
	y/Mj0sQzM9ZhoE2/dMyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bjOwb6fK/faTJw0exmP5eG4jS+alHGspEvgKBcKYjOeEpP4ta
	Pl8yawf7NhN6BZX9GUNIYzBF+vYa0WF0Smi31YC94zvGNMAgYU/3fEPgZYtEefuc
	vOqU5PeE3lx9swdxjFnfdp+a4GsJByyEUP/p6tp6BVclN2yzijdFlIyR/g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 090C39E8C3;
	Sun, 28 Feb 2010 13:16:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EDA39E8C1; Sun, 28 Feb
 2010 13:16:21 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61914906-2495-11DF-9672-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141259>

Jeff King <peff@peff.net> writes:

>> +		if (COLOR_MAXLEN <=
>> +		    /* Number of bytes to denote colors and attributes */
>> +		    num_attrs
>> +		    + (fg < 0 ? 0 : (fg < 8) ? 2 : 8) /* "3x" or "38;5;xxx" */
>> +		    + (bg < 0 ? 0 : (bg < 8) ? 2 : 8) /* "4x" or "48;5;xxx" */
>> +		    /* Number of semicolons between the above elements */
>> +		    + (num_attrs + (0 <= fg) + (0 <= bg) - 1)
>> +		    /* ESC '[', terminating 'm' and NUL */
>> +		    + 4)
>> +			goto bad;
>
> We don't need this, because the length of what can be specified is
> bounded, and we simply need to set COLOR_MAXLEN high enough to handle
> the longest case?

Yes, I think we are now bounded and don't need this; I just thought it
would have an educational value to show how to comment a complex
expression in a readable way ;-)

>> +test_expect_success 'fg bg attr...' '
>> +	color "blue bold dim ul blink reverse" "[1;2;4;5;7;34m"
>> +'
>
> Hmm. Just a thought on the bit-setting approach, but does the order of
> attributes ever matter? We are going to lose the ordering information
> the user specifies, obviously.

True, I don't know if it matters.  I don't know if "blue bold bold" would
result in bolder blue than "blue bold" on some terminal emulators, either.

I'd suggest that we ignore the issue for now, and when somebody complains
with an actual non-working case, we would assess the damage that comes
from this reordering to decide what to do next.  Parhaps a "non-working
case" could be "'blink ul' blinks letter without blinking underline, but
'ul blink' makes both letter and underline blink".  At that point we can
say "Ok, you found a case the order changes the results.  But does that
difference matter in practice?" and move forward, either by fixing it, or
declaring it doesn't matter in practice.

We were already losing the order by emitting attr then fg then bg even
though attr can come before any colors (an undocumented side effect of a
sloppy parsing logic, but some of the existing tests insist on kepping it
working), by the way.
