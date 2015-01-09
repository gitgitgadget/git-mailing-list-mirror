From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] receive-pack.c: only accept push-cert if push_cert_nonce was advertised
Date: Fri, 09 Jan 2015 15:05:46 -0800
Message-ID: <xmqqfvbjblmd.fsf@gitster.dls.corp.google.com>
References: <1420836437-11068-1-git-send-email-sbeller@google.com>
	<xmqqsifjbmu2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 00:05:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9icr-0007Im-TL
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 00:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265AbbAIXFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 18:05:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752915AbbAIXFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 18:05:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A22F82DBA8;
	Fri,  9 Jan 2015 18:05:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fch18dQGAcjnbUvDWimJA7ldv/0=; b=FhK1FQ
	X0W48nTeRymdEkiomivNQ2b+FDHNrBWOVwi9jv4TIf+lqPwDA0ygygQ6qSOyCOLA
	gDyGeJ2wmnv6hHJAYWQyelnsj4VA2XF2848m1jH3nzqHuwuqh5lpcg0A5YXiqXUW
	eTZybQyDbU9Yi1R/WE7mYvUFv5fOhPv1N/GnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v8gGGhdQyAfT8q8/7iN3+ijkXpiz0aIp
	RX0DnnSYEdJCD5J6D2ZsYm9hNmAd4GDCVENX+Ao5eDX2OaTn10fc63xNjNZH9r41
	nPZ81S0YFTur/gRJBHx7uoglp2Ck9R6TUEFOV7km2iYNcGWovAMzB2+9I5fZCfvH
	pXHofcl55pg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98ED12DBA7;
	Fri,  9 Jan 2015 18:05:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20F6E2DBA6;
	Fri,  9 Jan 2015 18:05:48 -0500 (EST)
In-Reply-To: <xmqqsifjbmu2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 09 Jan 2015 14:39:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C729122-9854-11E4-BFEC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262250>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 4c069c5..628d13a 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1276,7 +1276,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
>>  				use_atomic = 1;
>>  		}
>>  
>> -		if (!strcmp(line, "push-cert")) {
>> +		if (push_cert_nonce &&
>> +		    !strcmp(line, "push-cert")) {
>>  			int true_flush = 0;
>>  			char certbuf[1024];
>
> This implementation is somewhat questionable.
>
> The server knows how to parse "push-cert" line, knows that what
> follows after that line up to "push-cert-end" line are shaped very
> differently from protocol commands outside the push-cert block.  In
> other words, it knows how to parse the request meant for the capable
> server; it just wants to refuse to serve that request.
>
> The patched code will make it fail by hoping that queue_command()
> that only handles "40-hex 40-hex ref" will reject the line that
> begins with "push-cert".  Instead of relying on such a hidden
> dependency, wouldn't it be cleaner to actually parse the push-cert
> block and then at the end notice and explictly say "Your requests
> were syntactically correct, but I am not going to honor your request
> to use the push-cert extension, because I never told you that I'd
> offer you that capability", instead of rejecting the request with "I
> was expecting old/new/ref but you sent a line with 'push-cert' on
> it; what are you talking about?"

Note that I said "somewhat" questionable, not "horribly broken",
because another part of me wants to say that this implementation may
be better than "parse and reject" from security point of view.  The
pusher cannot tell if the push failed because the server is old to
know about the extension, or the server is new but is refusing, by
observing the failure.

But the other side of the same coin is that it makes it harder to
diagnose the failure.

When the protocol exchange gets to this state, in practice, we know
we are talking with somebody who has push privilege into the
repository, so revealing a bit more about the server by taking
"parse and reject" route may be a reasonable price to give diagnosis
that is more useful to help the users in this case, though.
