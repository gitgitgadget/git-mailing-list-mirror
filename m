From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Mon, 25 Mar 2013 14:55:16 -0700
Message-ID: <7vk3ovw3ej.fsf@alter.siamese.dyndns.org>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321111333.GD18819@sigill.intra.peff.net>
 <CAPc5daVOksx56js_ascEr348PTLAZB9OeBrf3sELJUpdyB_kMg@mail.gmail.com>
 <20130324093212.GA28234@sigill.intra.peff.net>
 <7vfvzjxnq9.fsf@alter.siamese.dyndns.org>
 <20130325210625.GA16386@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:55:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFMq-00062j-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933358Ab3CYVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:55:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933353Ab3CYVzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:55:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D4C9B16C;
	Mon, 25 Mar 2013 17:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bYGW0Y+O14A7Zu8kzW0fxFqAJW8=; b=HdeurQ
	DyEz3i+Zm6ovAa67ebbggQkphqEX7pU4DGU2ud00ukQidIr1wy0e7vUhEDDwdVK7
	H1bWPSPanl9Q+YqoISub0Rj4JPIko6I3MP5BVFvTXaHIeOayv08gC1ARfIuFd6da
	0iKM3mEchLSBZfe7982le+fYOXkfn4tRfkTF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DfMc7YkBbGhdpGaRP/B74Hk4WuGfMVU8
	MiT0xzjQpHmudh1NXUUPXvrrJFDJH6o/F4dSAFEPPOeARejW6qA4Jg6So+FzG1eM
	UVXmSoa/5kkbGG8mCq60YE3e7oB2zrAPvCLJxP60gGmihtcS8OBiWQV7pkyjRFAZ
	Nu/EdQckDgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BF6B16B;
	Mon, 25 Mar 2013 17:55:18 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 459FCB168; Mon, 25 Mar 2013
 17:55:18 -0400 (EDT)
In-Reply-To: <20130325210625.GA16386@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Mar 2013 17:06:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEAFE682-9596-11E2-B9B7-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219103>

Jeff King <peff@peff.net> writes:

> I wonder, though, what made you look at this. It did not come up in my
> list of -Wuninitialized warnings. Did it get triggered by one of the
> other gcc versions?

No, but the function in question has that questionable construct
written by somebody who does not understand linked list, and it
dusgusted me enough to look at where that list came from, which
inevitably made me notice that "return dummy.next" that made me go
"wat?"

>
>> diff --git a/transport.c b/transport.c
>> index 87b8f14..e6f9346 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -106,7 +106,8 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
>>  		return;
>>  
>>  	for (;;) {
>> -		int cmp, len;
>> +		int cmp = 0; /* assigned before used */
>> +		int len;
>>  
>>  		if (!fgets(buffer, sizeof(buffer), f)) {
>>  			fclose(f);
>
> I think that's fine.
>
> -Peff
