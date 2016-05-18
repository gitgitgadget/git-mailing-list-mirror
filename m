From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 5/5] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 15:59:20 -0700
Message-ID: <xmqq4m9vq8fr.fsf@gitster.mtv.corp.google.com>
References: <20160518190222.28105-1-sbeller@google.com>
	<20160518190222.28105-6-sbeller@google.com>
	<xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka0Of6S3AGx24jrvso=AwMsxQOnWVFZA-XWy3590JbVgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 19 00:59:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3AR6-0002mT-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbcERW7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:59:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbcERW7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:59:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54ADE1C2C2;
	Wed, 18 May 2016 18:59:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hLb0B5Mmt8ERDbc8zbV8tdsgLuI=; b=ZxuSJU
	vqZpRAdbsCAgXe9EN/zWo0CFtyqXMqix/t3RLQ+e1H3KBVxTLiKYfUBbd5jTK2my
	Z4wUwCypLcWEQManamABfa3u2jvKDmXxhD+x9QXS5gr+RQLswH7t1TIKLdA0b11p
	KQhgdhSPzSMjHJhmtBbrMoD/jnnXeQ69ccBGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bjJwwlgwhDKPRhJbUD9dhsZwFcP4LDdc
	kzsWEelaFpO6eIc61h6KLz9dT3hF/dK+mO4b/OdNlhu5xhPjwAKzqtVGUKkSTbrb
	5ggIqrYT/fMvYuqaJluGlkZgaR6NQYHd0/0mBxP0YZgMBgZcMk0X5aSLJ/paWanB
	uEuSO0+t+58=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C4161C2C1;
	Wed, 18 May 2016 18:59:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB48C1C2C0;
	Wed, 18 May 2016 18:59:22 -0400 (EDT)
In-Reply-To: <CAGZ79ka0Of6S3AGx24jrvso=AwMsxQOnWVFZA-XWy3590JbVgA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 18 May 2016 15:31:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 293A99D4-1D4C-11E6-BCAB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295027>

Stefan Beller <sbeller@google.com> writes:

> and those are not yet codified, but for discussion then:
>
>  - "`?`" the attribute must not be unspecified, i.e. set, unset or has any value
>  - "`+`" the attribute must be set or has any value

I'd suggest not to support these until we see any concrete and
convincing example use case to tell us why this is useful.

> That is why I am not super happy with it though.
>
>     ":(attr:A=a,attr:B)/path",
>     ":(attr:A=a B)/path",
>
> are the same for the user as well as in the internal data structures.

You can interpret the former as ORed :(attr:A=a) and :(attr:B) if
you really wanted to.  You left the door open for such a future
extension by explicitly rejecting multiple attributes added to a
single pathspec element in earlier round, which was good.  You could
do the same here if you do not want to code that ORed ANDs, so that
it (or some other semantics) can be introduced later without breaking
the mental model the users would form with the initial implementation.

>>> +             val_len = strcspn(val, "=,)");
>>
>> I understand "=", but can "," and ")" appear here?
>
> This was overly caution from some intermediate state, where the caller
> handed in more than required.

Is that being overly cautious?

It looks to me more like being sloppy and sweeping bugs in callers
that you could have diagnosed here.

If you didn't have ",)" in the cspn set above, at least you would
see the effect caused by a broken caller.  E.g. ":(attr:FOO,icase)"
would be given to you as "FOO,icase)" by a broken caller, you would
split "FOO,icase" as one of the SP separated items, and try to parse
it as an attribute name.  You can notice the breakage of the caller
at that time.  With ",)" in cspn set, you silently pass the parameter
given by a broken caller.
