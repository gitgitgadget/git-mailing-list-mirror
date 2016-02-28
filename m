From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: fix object_id of exact sha1
Date: Sun, 28 Feb 2016 11:29:39 -0800
Message-ID: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com>
References: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
	<1456605174-28360-1-git-send-email-gabrielfrancosouza@gmail.com>
	<20160227221248.GB17475@sigill.intra.peff.net>
	<CABaesJJCfd6FzgEVCWMJH8-gKiv3pT8BGq4f-qFgprVde+ViQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:29:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa72J-0003ig-HE
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 20:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbcB1T3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 14:29:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754914AbcB1T3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 14:29:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B259476EA;
	Sun, 28 Feb 2016 14:29:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p+vj4vCqRLrWdY3pS9xR92ss2Y8=; b=Blz3qe
	gqunwtyptRv43HlrZRFK8QDmIN8K+INfg8WosbTKQJ53H+8NicvteHqLpfIJsCDh
	uvRKk3yETfEA25fI/7GmkK4Rx/57DhuMaV4z4r9HNi6ClIUqQxVm5nnusllf8cz5
	q2UxshOUknTgGgZK6P6Q9XdqBaf9LRD9Zkzt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vqbtrh3TkLc/re1TAhGl19sBUL2KWg7Z
	xATP1H85UrXzkzOBOzA1uTzqe9Fpf9F2fu0geMNYtaeoEWI1dVktXkzHNFIGJrax
	5nO4PQouzNzkbf3PgKQo4tHqjK+1ONeCHSAL9MDatMfrHz4bsplJwPie0bPLVD/f
	t83KMMXTioQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 831EE476E9;
	Sun, 28 Feb 2016 14:29:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01856476E8;
	Sun, 28 Feb 2016 14:29:40 -0500 (EST)
In-Reply-To: <CABaesJJCfd6FzgEVCWMJH8-gKiv3pT8BGq4f-qFgprVde+ViQQ@mail.gmail.com>
	(Gabriel Souza Franco's message of "Sat, 27 Feb 2016 19:23:22 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9CDE17EC-DE51-11E5-A970-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287786>

Gabriel Souza Franco <gabrielfrancosouza@gmail.com> writes:

>>>       struct object_id oid;
>>>
>>> -     if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
>>> -             name += GIT_SHA1_HEXSZ + 1;
>>> -     else
>>> +     if (get_oid_hex(name, &oid))
>>>               oidclr(&oid);
>>> +     else if (name[GIT_SHA1_HEXSZ] == ' ')
>>> +             name += GIT_SHA1_HEXSZ + 1;
>>
>> This makes sense to me. I wonder if we should be more particular about
>> the pure-sha1 case consuming the whole string, though. E.g., if we get:
>>
>>   1234567890123456789012345678901234567890-bananas
>>
>> that should probably not have sha1 1234...
>>
>> I don't think it should ever really happen in practice, but it might be
>> worth noticing and complaining when name[GIT_SHA1_HEXSZ] is neither
>> space nor '\0'.
>
> Right. What kind of complaining? Is doing oidclr(&oid) and letting it
> fail elsewhere enough?

I think that is the most sensible.  After all, the first get-oid-hex
expects to find a valid 40-hex object name at the beginning of line,
and oidclr() is the way for it to signal a broken input, which is
how the callers of this codepath expects errors to be caught.

Thanks.
