From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon, 06 Jun 2016 16:25:55 -0700
Message-ID: <xmqq7fe1vr0c.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
	<xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 01:26:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3uI-000750-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbcFFXZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:25:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752998AbcFFXZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 19:25:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9123223E22;
	Mon,  6 Jun 2016 19:25:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wv8NqrV38UO9o9O7PmDETfNq+cU=; b=MOSgeG
	gq++qmstEfJv403PIwKZGfz9pOhrsVW/8aTlvW2Uie9N9m/VnLg7pgeLbl+5KNyT
	72tODb38Di1cJ5b54xPinTLscaWNez3mmzRReUc8V+2y/zQkzjfVvX8Ev8PV8mB4
	6DJem3fArnGsEfk2lCaKM2SZ0TTYfopiYJQuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKgUK00NPyktnIj1jWSf7ObCmdOs1bvj
	R1r7oLy+WQxHyAJnWuBU033FlmkWtgX9ER1gUb6xclZiyt2K9s8fbyqUSfwrnkRq
	y3fHtv/FaDb90/iSSIxirwDyNZVhIvsu56H2njWaeAaOYla2WyGQ8wjuPaQNJ7eH
	s1r7y18uhw4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8791B23E21;
	Mon,  6 Jun 2016 19:25:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13AE623E20;
	Mon,  6 Jun 2016 19:25:57 -0400 (EDT)
In-Reply-To: <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 06 Jun 2016 16:24:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0566A93E-2C3E-11E6-AC4A-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296576>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> I think that call should reset line.buf to the original buffer on
>>> the stack, instead of saying "Ok, I'll ignore the original memory
>>> not owned by us and instead keep pointing at the allocated memory",
>>> as the allocation was done as a fallback measure.
>>
>> I am not sure I agree. Do we think accessing the stack buffer is somehow
>> cheaper than the heap buffer (perhaps because of cache effects)? If so,
>> how much cheaper?
>
> This is not about stack vs heap or even "cheaper" (whatever your
> definition of cheap is).  The principle applies equally if the
> original buffer came from BSS.
>
> Perhaps I made it clearer by using a more exaggerated example e.g. a

s/I made/I should have made/; sorry but I have a horrible wifi
around here today...

> typical expected buffer size of 128 bytes, but the third line of
> 1000 line input file was an anomaly that is 200k bytes long.  I do
> not want to keep that 200k bytes after finishing to process that
> third line while using its initial 80 bytes for the remaining 977
> lines.
>
> By the way, William seemed to be unhappy with die(), but I actually
> think having a die() in the API may not be a bad thing if the check
> were about something more sensible.  For example, even if a strbuf
> that can grow dynamically, capping the maximum size and say "Hey
> this is a one-lne-at-a-time text interface; if we need to grow the
> buffer to 10MB, there is something wrong and a producer of such an
> input does not even deserve a nice error message" could be an
> entirely sensible attitude.  But that does not mean an initial
> allocation should be 10MB.  If the expected typical workload fits
> within a lot lower bound, starting from there and allowing it to
> grow up to that maximum would be the more natural thing to do.
>
> And the problem I have with the proposed "fixed" is that it does not
> allow us to do that.
