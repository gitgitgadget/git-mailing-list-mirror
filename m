From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/12] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Tue, 12 Feb 2013 11:58:55 -0800
Message-ID: <7vpq05fgn4.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <1360664260-11803-6-git-send-email-drafnel@gmail.com>
 <7v621xgxax.fsf@alter.siamese.dyndns.org> <511A98C0.70201@nvidia.com>
 <7vtxphfhoq.fsf@alter.siamese.dyndns.org> <511A9CDB.9060008@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds\@gmail.com" <pclouds@gmail.com>,
	"jrnieder\@gmail.com" <jrnieder@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5M0g-0007MT-8i
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933425Ab3BLT67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 14:58:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933153Ab3BLT66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 14:58:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FC22C5E3;
	Tue, 12 Feb 2013 14:58:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XduoPE+NR+ufCBSMD3LKoNLKtUI=; b=ZS++D2
	0nSNx83AR28EcddleoQffMfNvvWMSrlGKgGDrfyH9NlaAVhk+jxFrR9a0f3mko8O
	7e4PZgi77OE4mIJ0a8K7bGcTNsVbzvWqhTLx/tI+V8T9jxqJvmNOBE6FmJpIptQS
	4nd0Y7bkuy8dMDNo0JKboLb9yIIx/pt6XXM68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PRQr/3212DnT5b8QUw8HIPJSr9dkYvCv
	AU8PAiMObs1/Qzw3SYFKLBcA7zIjF0gygwPHd/WkmOfQo6IhddpaqE4kACBpEQ2V
	lq7ReZYeT4ZN0xE0DCvz0D09s7HJduoDZjEZDRA17kbyh8QkkiDg1GXhyrZ9P06l
	govxhKmr+as=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDB35C5E2;
	Tue, 12 Feb 2013 14:58:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4706BC5DC; Tue, 12 Feb 2013
 14:58:57 -0500 (EST)
In-Reply-To: <511A9CDB.9060008@nvidia.com> (Brandon Casey's message of "Tue,
 12 Feb 2013 11:49:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2C14C52-754E-11E2-A960-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216182>

Brandon Casey <bcasey@nvidia.com> writes:

> On 2/12/2013 11:36 AM, Junio C Hamano wrote:
>> Brandon Casey <bcasey@nvidia.com> writes:
>> 
>>>>> +	return len > strlen(cherry_picked_prefix) + 1 &&
>>>>> +		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
>>>>> +}
>>>>
>>>> Does the first "is it longer than the prefix?" check matter?  If it
>>>> is not, prefixcmp() would not match anyway, no?
>>>
>>> Probably not in practice, but technically we should only be accessing
>>> len characters in buf even though buf may be longer than len.  So the
>>> check is just making sure the function doesn't access chars it's not
>>> supposed to.
>> 
>> Sorry, I do not follow.  Isn't caller's buf terminated with LF at buf[len],
>> which would never match cherry_picked_prefix even if len is shorter
>> than the prefix?
>
> Heh, I almost pointed that out in my reply.  Yes, buf will be terminated
> with LF at buf[len].  And yes, that means that we will never get a false
> positive from prefixcmp even if the comparison overruns buf+len while
> doing its comparison.  That's why the check doesn't matter in practice,
> i.e. based on the way that is_cherry_picked_from_line is being called
> right now and the content of cherry_picked_prefix.
>
> But, hasn't is_cherry_picked_from_line entered into a contract with the
> caller and said "I will not access more than len characters"?
>
> It's ok with me if you think it reads better without the check.

As Jonathan says, if you rewrite it to

	return buf[len - 1] == ')' && !prefixcmp(buf, cherry_picked_prefix);

then the code can keep its promise without the length check, because
it knows there is no ')' in cherry-picked-prefix, and it also knows
prefixcmp() stops at the first difference.

It is not a huge deal; I was primarily reacting to the ugly multi-line
boolean expresion that is not inside a pair of parentheses (and because
this is a "return" statement, there is no good reason to have parentheses
except that this is a multi-line expression), which looked odd.
