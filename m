From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for status_printf
Date: Tue, 09 Jul 2013 22:35:25 -0700
Message-ID: <7vip0jt1sy.fsf@alter.siamese.dyndns.org>
References: <20130710001659.GA11643@sigill.intra.peff.net>
	<20130710002328.GC19423@sigill.intra.peff.net>
	<7vmwpvt28j.fsf@alter.siamese.dyndns.org>
	<20130710052859.GA5339@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 07:35:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwn3s-0001j3-JT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 07:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab3GJFf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 01:35:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab3GJFf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 01:35:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 346B9275AF;
	Wed, 10 Jul 2013 05:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1yod5T3ypOHvakrb0d+dkh8LQtk=; b=ye2Uow
	4Bj9SHETK4yBX1bK561COwpg/qiexxsPJvzAB/kNIU+7WReHG3RqIO0rSFMkhQN2
	0v1E28L+cCiROGHK16SonQGeDt59u66L3a6fc6KK5elB0AwOHyRXFSB2ZaGxB32F
	2kcp99tEKzjPDmk+ThI6fr9QmjEjOnyWMZRok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tpS8mDuWAHSLjs32PT+7wLw4yYvuiLJI
	Vgnwj/YJoVkCIAh3Wy4pmcNXbvXYT+JC/C5ggnca1arGNfPZaGofrjUvEusA1PFe
	5zAfRioZ+irhyMwtWiOMDD9Z4IipKa56LIYRak6KaCDhNZWQxl/psKeqIP1UB/f4
	4PvEiTI25Rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29453275AD;
	Wed, 10 Jul 2013 05:35:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79747275AA;
	Wed, 10 Jul 2013 05:35:26 +0000 (UTC)
In-Reply-To: <20130710052859.GA5339@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jul 2013 01:28:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8640977A-E922-11E2-8BCA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230025>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 09, 2013 at 10:26:04PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > These functions could benefit from the added compile-time
>> > safety of having the compiler check printf arguments.
>> >
>> > Unfortunately, we also sometimes pass an empty format string,
>> > which will cause false positives with -Wformat-zero-length.
>> > In this case, that warning is wrong because our function is
>> > not a no-op with an empty format: it may be printing
>> > colorized output along with a trailing newline.
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> > I'm torn on this one. It really does provide us with more compile-time
>> > safety checks, but it's annoying that "-Wall -Werror" will no longer
>> > work out of the box.
>> 
>> Yeah, that is a show-stopper for me X-<.
>
> You can "fix" it with -Wno-zero-format-length, so the hassle is not
> huge. 

Yes, or just do func(..., "%s", "") perhaps?  That also sound iffy.

> But I am also inclined to just drop this one. We have lived
> without the extra safety for a long time, and list review does tend to
> catch such problems in practice.
>
> -Peff
