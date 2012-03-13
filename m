From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use macro HANDLER_WRAPPER in sigchain to wrap clean
 function of sigchain
Date: Tue, 13 Mar 2012 11:11:23 -0700
Message-ID: <7vmx7kweus.fsf@alter.siamese.dyndns.org>
References: <CAMocUqRsEvwnoV32Cr05dJeUj7iNDj1cLP5kAzgyMNEo1O0kCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git =?utf-8?B?6YKu5Lu25YiX6KGo?= <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCPXltbBsoQg==?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 19:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7WC3-0002sL-JG
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 19:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759253Ab2CMSL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 14:11:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759109Ab2CMSL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 14:11:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CFD8659B;
	Tue, 13 Mar 2012 14:11:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Q1TbLxfXWzwh0Lfoy8ozEKDiUM=; b=geNh4M
	L3HXCo/t42mSEKzl4tR32Zo6lmTVkjbLcO7H0Pxv1Ll1a/h4ETmU7RO/IOajo/ld
	yHgSnLmbjUGjHJahClz8bpqTqFB5iaHZuL1wRV02XTOoaXenZG0ZAxzehTASu8GX
	x5z3FKM0ZzEptbq/0Uy9XUKEhHmpcrA8cPZm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dTRZJ04p/QYkbKi2fy1/j9+Szi6oJBbr
	7P04t0PpqnLuaeGCuQHjA2KJeOcPzesLkMKPvcTmhs6OM7CUuUw4JDmKKdEAAozF
	tIAefCTbU2KfLpugydy9HkUg6QIl+CA+MW8Q3CVoMSad0d7RO8sPiV6TXJ1kK+Zp
	cQGVCi/+LeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6312A659A;
	Tue, 13 Mar 2012 14:11:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA18E6595; Tue, 13 Mar 2012
 14:11:24 -0400 (EDT)
In-Reply-To: <CAMocUqRsEvwnoV32Cr05dJeUj7iNDj1cLP5kAzgyMNEo1O0kCw@mail.gmail.com>
 (=?iso-2022-jp?B?IhskQj15bWwbKEIiJ3M=?= message of "Tue, 13 Mar 2012 15:52:56
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1F40384-6D37-11E1-BD52-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193050>

徐迪 <xudifsd@gmail.com> writes:

> The sigchain APIs require user to code like:
>
> void clean_foo_on_signal(int sig)
> {
>  clean_foo();
>  sigchain_pop(sig);
>  raise(sig);
> }

I can see the repetition, but I do not think your macro is a very good way
to reduce it.  Can't we fix the sigchain API a bit, perhaps first by
making a bit more state available to the sigchain stack?

	typedef void (*sigchain_fn)(int, void *);
        int sigchain_push(int sig, sigchain_fn fn, void *cb_data);
        int sigchain_pop(int sig);
        void sigchain_push_common(sigchain_fn fn, void *cb_data);

And then make the repetitive one into a single copy of a helper function,
while giving a new external interface to register a on_signal handler:

        static void relay_fn(int sig, void *cb_data)
        {
                void (*fn)(void) = cb_data; /* [*1*] */
        	fn();
                sigchain_pop(sig);
                raise(sig);
        }

        void sigchain_add_relayed(void (*fn)(void))
        {
		sigchain_push_common(relay_fn, fn);
        }

The code that wants to register a clean-up action would do:

	sigchain_add_relayed(clean_foo);

instead of

	sigchain_push_common(clean_foo_on_signal);

with repeated definition of clean_xxx_on_signal.

Hmm?

[Footnote]

*1* Yes, I know, this casts between a data pointer and a function pointer
that is not portable, but the purpose of this pseudo-code is primarily to
illustrate the high level view of the idea.  We would probably want to be
able to pass callback value to the clean_foo() function and at that point,
we would likely to be passing a pointer to a struct, and we could declare
the first element of such a struct is a pointer to a sigchain_fn, or
something.
