From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-format-patch should include a checksum
Date: Tue, 26 Jan 2010 19:01:07 -0800
Message-ID: <7vljfkw8ss.fsf@alter.siamese.dyndns.org>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
 <7vljfkxxj9.fsf@alter.siamese.dyndns.org>
 <7ir5pccp9n.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
X-From: git-owner@vger.kernel.org Wed Jan 27 04:01:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZy9i-0000Mw-Ha
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 04:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab0A0DBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 22:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327Ab0A0DBQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 22:01:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0A0DBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 22:01:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C45694C32;
	Tue, 26 Jan 2010 22:01:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qv5myg9E6sE2RHRlhvmq3wDqNkk=; b=CNuZXk
	a3Ggi/3fOzSOUuzezQj4ps1UfJoga4JwCTj47XvFlGfqFYtAius3x6/fbIAnFGlx
	zPnmUqZR+V20KFiSRacqiNUa2egKkEdMgS1BaqeRx0S/w/Lg9czrJ3ySShCl66mg
	fGUs0l7OlZydDTJrxTK53nhtbfpSaaCSeLoJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L88+G40JrocAP/OqOBTsr4GaECSNYuBM
	yJOAyVonDskKSqbN4MuCjqIPay1y+h5LBFvyiLOMzCcmlu8hf+DmTYkbGGMmUgif
	HFYooI3M2p3Y1R7M0hSw2bs1/TwH+bHidESpcnlbtGDMuxMJbTLkxee1WCiVuo8R
	f8zLFAQg9UY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19DF694C2F;
	Tue, 26 Jan 2010 22:01:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61CE294C2A; Tue, 26 Jan
 2010 22:01:09 -0500 (EST)
In-Reply-To: <7ir5pccp9n.fsf@lanthane.pps.jussieu.fr> (Juliusz Chroboczek's
 message of "Wed\, 27 Jan 2010 02\:25\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39B17802-0AF0-11DF-8DC5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138104>

Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr> writes:

>> Do you have an example of such corrupted and incorrectly applied patches?
>> What kind of corruption are you talking about?
>
> The commit message getting rewrapped.  For some reason, the patch itself
> was not corrupted.

You hopefully check the message (and of course the patch) before applying,
so "automatically reject and require force" wouldn't help you much in this
case.  Either you reject and tell the sender to resend, or you reflow it
yourself to save the sender (and yourself) the hassle of round-trip.

And if you choose to do the latter, having to force it would actively
inconvenience you.

> Another case is that of the commit message having its non-ASCII
> characters corrupted.

I've seen this one.  It often is that the commit object records UTF-8, but
somehow the MUA didn't mark it as such (or incorrectly marked it as
ISO-8859-1), and mailinfo ended up doing unnecessary conversion.  When
this happens, not just the message but also the patch text is affected.

But to use "checksumming" as a solution for this, you need to think about
what you checksum.  Output from format-patch is "text/plain;charset=UTF-8"
and requires 8-bit clean transport, but by cutting and pasting that into
MUA you often end up with whatever MIME B/Q-quoting your MUA gives you,
and mailinfo is actively unwraps them, so the right place to add an
optional check _might_ be immediately after we run mailinfo.  At that
point, however, the author name and the subject line is in separate
records from the body of the commit log message.

More realistically, the kind of MUA corruption I personally see most often
is "text/plain; format-flowed"; I have a pre-applypatch hook to reject
them altogether, but they tend to corrupt leading whitespaces so badly
that the patch seldome applies.  This is not something "checksumming" is
the right tool to solve.

One thing that we _might_ consider doing is to reduce the default length
of the function name we place on the hunk header line.  For some reason, I
see they get wrapped in messages I see, even when the proposed commit log
message has overlong lines.
