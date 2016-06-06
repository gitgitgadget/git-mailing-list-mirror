From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon, 06 Jun 2016 16:24:53 -0700
Message-ID: <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 01:25:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3tG-0006Qi-53
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbcFFXY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:24:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750886AbcFFXY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 19:24:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD5A7226E6;
	Mon,  6 Jun 2016 19:24:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PyePVz2/SR5y9PW9+l7prYu/428=; b=MMgvdT
	UDIR1/FjI5Z92lHwuqshM2TDuYUmwPlSkV2mMstGfkOuYd/nxYK8X2glFGzdDof4
	kimSKcDRr8Hh1DmG49fJii3XEijTCVabYfTzCOxQcOM0ADHKGVbC+Idy/ur9p8me
	Kac6KHXP24Roet4I4vmnWbeVvVeeVJz5vVQZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=whVt21hqlZ+pbEznHuHmaRtRZxRaJ2r8
	cAFB3vi/AczGe1APnH/9X7C0tTM4plVuUZlRIUxPayoC2dUNZiPtwX0oHnBO7m0/
	QFf348/MupFxH2suBWlzz/8Zh8HjdfoAxBexAZWiaWr04ZHUKXXKxHgS7LbjcxE0
	tqX80VVbO8I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5E4C226E5;
	Mon,  6 Jun 2016 19:24:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B4DA226E4;
	Mon,  6 Jun 2016 19:24:55 -0400 (EDT)
In-Reply-To: <20160606225847.GA22756@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 Jun 2016 18:58:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E09E79EC-2C3D-11E6-9C28-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296574>

Jeff King <peff@peff.net> writes:

>> I think that call should reset line.buf to the original buffer on
>> the stack, instead of saying "Ok, I'll ignore the original memory
>> not owned by us and instead keep pointing at the allocated memory",
>> as the allocation was done as a fallback measure.
>
> I am not sure I agree. Do we think accessing the stack buffer is somehow
> cheaper than the heap buffer (perhaps because of cache effects)? If so,
> how much cheaper?

This is not about stack vs heap or even "cheaper" (whatever your
definition of cheap is).  The principle applies equally if the
original buffer came from BSS.

Perhaps I made it clearer by using a more exaggerated example e.g. a
typical expected buffer size of 128 bytes, but the third line of
1000 line input file was an anomaly that is 200k bytes long.  I do
not want to keep that 200k bytes after finishing to process that
third line while using its initial 80 bytes for the remaining 977
lines.

By the way, William seemed to be unhappy with die(), but I actually
think having a die() in the API may not be a bad thing if the check
were about something more sensible.  For example, even if a strbuf
that can grow dynamically, capping the maximum size and say "Hey
this is a one-lne-at-a-time text interface; if we need to grow the
buffer to 10MB, there is something wrong and a producer of such an
input does not even deserve a nice error message" could be an
entirely sensible attitude.  But that does not mean an initial
allocation should be 10MB.  If the expected typical workload fits
within a lot lower bound, starting from there and allowing it to
grow up to that maximum would be the more natural thing to do.

And the problem I have with the proposed "fixed" is that it does not
allow us to do that.
