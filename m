From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo = bar"
Date: Tue, 07 Oct 2014 14:53:58 -0700
Message-ID: <xmqqiojvczrd.fsf@gitster.dls.corp.google.com>
References: <xmqq61fveg1j.fsf@gitster.dls.corp.google.com>
	<20141007212941.GA24508@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:54:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbchs-0004ZH-9g
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbaJGVyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:54:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55269 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754662AbaJGVyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:54:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF0181336A;
	Tue,  7 Oct 2014 17:54:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJ0Y2S7FY5yU/C3RZn3BKSnnBmU=; b=FCjxZ0
	mPbV4ZtrniQqzkCaIMM251IIDF3BtuorV0Lq09u7CQis+YZ05nAZtsobtwjR53QF
	JuLU1hLqcDKk/0bKvRNgxX8ojfV/hcHVhsbhIOa4zbImavkM31q4DqUAmDyJAmBu
	Vxts9RL1pcchOLi/R2Q/EuGj3DuVTWtX6kDl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vDEauS9me0Okt46RF/NWQzpJ0GQ50gmq
	JMiz4gAqbvoOHtZAWXtUe+HygTmb0v4WIKGFdIPwoB9wAb32YpQ1MhENvek+7fH7
	KMmpM69MA1XSn9lHTUS79mkzt/kz1FP9XNykYDGZ9Hkqeu/bnmqV/sYsNPfoAufs
	rfTkNxQTfOs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B38813369;
	Tue,  7 Oct 2014 17:54:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C17F113368;
	Tue,  7 Oct 2014 17:53:59 -0400 (EDT)
In-Reply-To: <20141007212941.GA24508@peff.net> (Jeff King's message of "Tue, 7
	Oct 2014 17:29:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71A4C27C-4E6C-11E4-B5EF-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 07, 2014 at 01:35:15PM -0700, Junio C Hamano wrote:
>
>> Yeah, if we are going to reduce it down to the above implementation,
>> intereseting things like "test -f $frotz" will become possible and
>> "cmp-str" stops making sense.  It really is about "We run test and
>> expect it to yield true.  Report the failure a bit more prominently
>> under the '-v' option to help us debug".
>
> We already have test_path_is_file to do the same thing just for "-f". We
> could in theory switch all of those to this new, more generic wrapper. I
> don't know if it is worth doing a mass-conversion, but we could
> discourage test_path_is_file in new tests. We could also implement
> test_path_is_{dir,file} on top of this.

Oh, I wasn't going in that direction when I mentioned "-f"; I just
wanted to say that 'test "$@"' is clearly about 'test' (/bin/test or
shell built-in) and less about 'compare string'.  I do not think it
is necessarily a good direction to go in to replace test-path-is-file
with the test_cond thing; after all, type specific tests have chance
to report breakage of expectation in type specifc ways, e.g.

	test_path_is_file () {
		test -f "$1" && return 0
		echo >&2 "expected '$1' to be file"
		if test -e "$1"
                then
	               	echo >&2 "but it is missing"
		else
                	echo >&2 "but it is a non-file"
			ls >&2 -ld "$1"
		fi
                return 1
	}

But that is also just in theory ;-).

>> So among the ones you listed, test_verbose may be the least silly, I
>> would think.
>
> Somehow test_verbose seems to me like checking the "verbose" option of
> the test suite. I prefer "test_cond", but I do not feel too strongly, if
> you want to override me.

Hmph, your 'test' in that name is a generic verb "we check that...",
which I think aligns better with the other test_foo functions.  When
I suggested 'test_verbose', 'test' in that name was specifically
meant to refer to the 'test' command.

Still "test_cond" feels somewhat funny, as "we check that..." always
validates some condition, but I don't think of anything better X-<.
