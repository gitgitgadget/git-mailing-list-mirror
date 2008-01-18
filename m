From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998 characters
Date: Fri, 18 Jan 2008 12:57:41 -0800
Message-ID: <7v8x2mdf7e.fsf@gitster.siamese.dyndns.org>
References: <20080117153252.GD2816@coredump.intra.peff.net>
	<1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>
	<47905F70.5090003@viscovery.net>
	<4790746D.1000502@users.sourceforge.net>
	<47907914.6000105@viscovery.net>
	<7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>
	<20080118141638.GA14928@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFyI8-0002om-Ie
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 21:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761262AbYARU5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 15:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757617AbYARU5v
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 15:57:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733AbYARU5u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 15:57:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D9AD7F9B;
	Fri, 18 Jan 2008 15:57:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BCCF7F94;
	Fri, 18 Jan 2008 15:57:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71062>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 18, 2008 at 02:08:24AM -0800, Junio C Hamano wrote:
>
>> On the other hand, git-send-email _is_ all about SMTP transfer.
>> Perhaps a loop over input files upfront to check the line length
>> limit, and warn if there are suspiciously long lines even before
>> sending the first piece of e-mail out, would be a reasonable
>> approach.
>
> I think that is sensible. Patch series will follow:
>
>   1/3: send-email: detect invocation errors earlier
>
>        This is a code cleanup in preparation for 2/3, but has
>        user-friendly side effects.
>
>   2/3: send-email: validate patches before sending anything
>
>        The actual up front long-lines check.

I wonder what the performance implication of this approach would
be, though.  I am tempted to say that it would be negligible --
scanning text in Perl is fast enough.

>   3/3: send-email: add no-validate option
>
>        A knob for users who know something send-email doesn't.
>
> That at least detects the situation and lets the user deal with it (by
> fixing the patch, or by sending it as an attachment with another MUA).

I suspect that taking this "Safe against SMTP line length limit"
topic all the way ("all the way" is post 1.5.4, I am inclined to
agree that this may be a good fix to an existing bug) would
require that git-format-patch --attach to learn to apply QP on
patch text to avoid producing very long lines to root-cause the
issue [*1*].

[Footnote]

*1* It's actually second-to-root-cause it, because the real root
cause is for the source tree to have such an insanely long line.
