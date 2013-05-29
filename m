From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Wed, 29 May 2013 09:42:17 -0700
Message-ID: <7v38t5wxee.fsf@alter.siamese.dyndns.org>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
	<1369448666-17515-8-git-send-email-felipe.contreras@gmail.com>
	<7vvc632g1s.fsf@alter.siamese.dyndns.org>
	<51a5686ba7f2c_807b33e189951a@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 18:42:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhjSC-0004pg-To
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759365Ab3E2QmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 12:42:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757683Ab3E2QmU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:42:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ABB522AB6;
	Wed, 29 May 2013 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g90T0E2dnCiZBBsezyqVxktFwSA=; b=FRkQuJ
	63l0i25bWzKKHu8jtqhiNRi8Aq1WjhbJ7Cu/d+K/nxejcQcrgYW0fRhvswZe8AgT
	6j+aLw0OBJujhKRFyDkppEGdevWNa2hUMk/fhA0SI9ts3/wcR0n1UZDYxnuTCTeN
	TzqIxzqABN87JdeMO1CKBWkf+E+bPEErUM1q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9Km1OccMNYjhA47aRjlstHRE07Ij0ZA
	yrppWucQ5va0cTAwl/JKbmXOQ/0cibDAxfJ/S2Nucr3kG2zUohBSZUcXuunEK41f
	WwmZGV/ePaq9S56QOi6C8w2lW36Gyj/44VYvRCoC2JCyGm6wgzEUY4PhAhqpomJ+
	XbirA6+96QI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 826C722AB4;
	Wed, 29 May 2013 16:42:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0A0A22AB0;
	Wed, 29 May 2013 16:42:18 +0000 (UTC)
In-Reply-To: <51a5686ba7f2c_807b33e189951a@nysa.mail> (Felipe Contreras's
	message of "Tue, 28 May 2013 21:31:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA2A18D2-C87E-11E2-9381-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225840>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > +    wanted = get_config('remote-bzr.branches').rstrip().split(', ')
>> 
>> Two minor nits and one design suggestion:
>> 
>>  - Why rstrip() not strip()?
>
> The purpose of the strip is to remove the _single_ "\n" at the end that
> subprocess communicate. Maybe get_config() should do that.
>
>> It appears that this only is helping
>>    an end-user "mistake" like this:
>> 
>> 	git config remote-bzr.branches 'trunk, devel, test '
>> 
>>    without helping people who have done this:
>> 
>> 	git config remote-bzr.branches 'trunk,  devel, test'
>
> No, that's tnot it.

Yes, rstrip() will also lose LF at the end.

But it also is true that your code also removes the trailing extra
SP in the first example above, while not losing the extra SP in the
middle in the second example, no?

So where does "that's tnot it" come from?  Is it true or false that
the former is helped while the latter is not?

>>  - Is
>> 
>>      git config remote-bzr.branches trunk,devel,test
>> 
>>    a grave sin?
>> 
>>    In other words, wouldn't we want something like this instead?
>> 
>> 	map(lambda s: s.strip(), get_config('...').split(','))
>
> Yeah, that might make sense.

If you go that route, you do not even have to even say "stupid
python".  You can write a more meaningful list comprehension, e.g.

	wanted = [s.strip() for s in get_config('...').split(',')]

without an unsightly lambda in it.

>>  - Doesn't allowing multi-valued variable, e.g.
>> 
>> 	[remote-bzr]
>>             branches = trunk
>>             branches = devel
>>             branches = test
>> 
>>    make it easier for the user to manage this configuration by
>>    e.g. selectively removing or adding tracked branches?
>
> How would the 'git config' command look like?
>
> Either way, that's orthogonal to this patch.

Yeah, I notice that "single variable, split at comma" comes way
before this series anyway, so it is too late (and it is not worth)
to fix it using multi-valued variables.  It was just an "if we were
designing this from scratch" kind of suggestion.
