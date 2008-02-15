From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain
 messages
Date: Fri, 15 Feb 2008 09:10:19 -0800
Message-ID: <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ45y-0007xI-Gg
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYBORKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbYBORKq
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:10:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYBORKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:10:45 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CDF40227B;
	Fri, 15 Feb 2008 12:10:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 AAF1A2278; Fri, 15 Feb 2008 12:10:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73959>

I really do not like this.

format=flowed instructs the receivers MUA that it is Ok to
reflow the text when the message is presented to the user.  That
is exactly what we do _NOT_ want to happen to patches.  Your
implementation may cleanly salvage what the sender intended to
send, but salvaging when applying the patch is too late.

You review the patch, decide to apply or reject, and then
finally apply.  Unmangling of corrupt contents should be done
before you review, not before you apply.

We have similar hacks to clean-up MIME attachments and CTE.
They are useful when your mailpath is not clean and can corrupt
contents even if you try to send it as text/plain in-line patch
as a fallback measure to ensure the contents not to get
corrupted.  format=flowed is completely opposite --- you are
giving your and recipients MUA freedom to reflow the text, but
there is no valid reason to allow that when sending patches.

We do not even encourage MIME attachments and ask senders to try
sending uncorrupt patch in-line, _even though_ MIME attachments
is a way to try harder not to corrupt the payload.  Why should
we encourage format=flowed which is meant to do the opposite
(i.e. we do not care about the exact content, we care more about
how better the paragraph looks and easier to read on screens
with different width)?

The format is not meant for the exact transmission of text (like
"patch") but more for paragraphed prose that can be re-fit on
narrower display like phones.  Section 5. even goes to say
"Hand-aligned text, such as ASCII tables or art, source code,
etc., SHOULD be sent as fixed, not flowed lines."

Side note.  I did not look at the patch very carefully, but can
you salvage a deleted text in the patch that removes a line that
consists of "- " (minus followed by a single space and then
end-of-line), or any deleted or added text that ends with a SP
without making them misinterpreted as "flowed" line for that
matter?

I even suspect that the sending MUA client may misbehave for
such a patch line.  In fact, doesn't section 4.2 say "a
generating agant should trim spaces before user-inserted hard
line breaks."?  It implies to me that you cannot have a fixed
line that ends with SP.

So just reject the patch when somebody sends you format=flowed
and ask them to re-send without =flowed, and the world will be
a much better place.
