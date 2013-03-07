From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 07 Mar 2013 10:40:46 -0800
Message-ID: <7vfw07m4sx.fsf@alter.siamese.dyndns.org>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
 <20130307180157.GA6604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 19:41:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDfkh-0005mb-Tn
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933Ab3CGSku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:40:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542Ab3CGSkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:40:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86459B179;
	Thu,  7 Mar 2013 13:40:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OVM1xxwzxrNb6hrh/2c+3kEY0D4=; b=WdoKbX
	BXE7H8guufV0rcIwGmJ6y15jaViIA9kuznfnz7rKRnSmIV0UK6mXZllhSBitTf5T
	DsL7EWcpbdhd8nRITWwRfeMAa6lBTf4aKtQTd5j8WHa/5l1wNDjLasjCArl0O3S7
	wo09TvErGp1ygE/pbjptrojMImzPE2LAV8nN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sild50HtbDakNbZkDRk31BKaE0YV2BBO
	iOmbMNFLq7SDkjRWwsHdS6ppV/+PiQjoAT2zcCdZzL//jAdIj+uGzFJrFKHsIiaP
	klpDqpc2r9vm2fkzX4o/myuvYrotF9HsfbJMCrz9JrfwSTb1aR/SKnmHniEn3qoq
	nHYrxq5Nlv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B2B0B178;
	Thu,  7 Mar 2013 13:40:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1784B177; Thu,  7 Mar 2013
 13:40:47 -0500 (EST)
In-Reply-To: <20130307180157.GA6604@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 7 Mar 2013 13:01:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8736A2CE-8756-11E2-88F9-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217608>

Jeff King <peff@peff.net> writes:

> I'm not sure I agree. In this output (which does the zealous
> simplification, the splitting, and arbitrarily assigns deleted preimage
> to the first of the split hunks):
>
>   1234A<B|56=X>C<D|Y>E789
>
> I do not see the promotion of C to "already resolved, you cannot tell if
> it was really in the preimage or not" as any more or less misleading or
> wrong than that of A or E.  It is no more misleading than what the
> merge-marker case would do, which would be:
>
>   1234A<B=X>C<D=Y>E789

That is exactly my point and I think we are in complete agreement.
While the intended difference between RCS merge and diff3 -m is for
the latter not to lose information on the original, zealous-diff3
chooses to lose information in "both sides added, identically" case.

Where we differ is if such information loss is a good thing to have.

We could say "both sides added, identically" is auto-resolved when
you use the zealous option, and do so regardless of how the merge
conflicts are presented.  Then it becomes perfectly fine to eject
"A" and "E" out of the conflicted block and merge them to be part of
pre/post contexts.  The same goes for reducing "<C|=C>" to "C".  As
long as we clearly present the users what the option does and what
its implications are, it is not bad to have such an option, I think.

> The wrong thing to me is the arbitrary choice about how to distribute
> the preimage lines.

Yeah, but that is not "diff3 -m" vs "zealous-diff3" issue, is it?
If you value the original and want to show it somewhere, you cannot
avoid making the choice whether you are zealous or not if you split
such a hunk.
