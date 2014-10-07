From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo = bar"
Date: Tue, 07 Oct 2014 10:29:59 -0700
Message-ID: <xmqqsiiziy94.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003202743.GH16293@peff.net> <5433E8CB.1050005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 07 19:30:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbYaU-0004Wr-2h
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 19:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbaJGRaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 13:30:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57367 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754548AbaJGRaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 13:30:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D44151332E;
	Tue,  7 Oct 2014 13:30:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5HDi+JnwUihRSy8l/Q4PHDt2HKI=; b=g7QTy7
	QKgOvaW6DEbuH2tpOOr3fNQdURr89ycq1420D0ylvf7n6t/2qjh19A4pfhvHAYme
	W4FkT1LflxmpdEimThT/vNFQKrAa+d3JsPVpMZvaLkBcQzPz9tf25bHr4crGTobr
	Esz+drbIhTu1dKdhZURmr0SGDWQa84WJHFfi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MW/+sM10ce0I/c2YCXqS9a9f6Ilm6v+w
	qhA/4+1nbRI9LjAUfNK+UsIk2Kej1xYpv7+eQ7FdbX7KjxCCBBnxUaDCMtEGpADw
	txv2r1J5OCCDvpMng0zWHI5dWoD3A+YPe0rtaevBuIbYH9cvwWx7/zjTp6ukyVDT
	4hvHdYtfZfc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C79FF1332D;
	Tue,  7 Oct 2014 13:30:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AC521332B;
	Tue,  7 Oct 2014 13:30:02 -0400 (EDT)
In-Reply-To: <5433E8CB.1050005@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 07 Oct 2014 15:21:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91BA770C-4E47-11E4-A31F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257934>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I don't like the three-argument version of test_eq. Wouldn't using a
> comparison operator other than "=" would be very confusing, given that
> "eq" is in the name of the function? It also doesn't look like you use
> this feature.

> An alternative direction to go would be to specialize the function for
> equality testing and delegate to test_cmp to get better output for
> failures, but optimized to avoid excess process creation in the happy path:
>
> test_eq () {
> 	if test "$1" != "$2"
> 	then
> 		printf "%s" "$1" >expect &&
> 		printf "%s" "$2" >actual &&
> 		test_cmp expect actual
> 	fi
> }
>
> (but using properly-created temporary file names).

I agree that it would be a good idea to use a randomly generated
temporary filename that does not collide, as long as we make sure
not to leave cruft in the working tree of the test and we leave the
file there when the test script is run under "-i" or "-d" option.

The above superficially looks nice; "! test_eq a b" would give
useless output under "-v", and "test_ne a b" needs to be added if
you go that route, though.

Anyway, with the version posted, you cannot do "! test_eq a b",
either but with "test_eq a b !=", you do not have to.

	Side note. Yes, now I looked at it again, I agree that the
	three-arg form is awkwards in at least two ways.  The
	operator, if we are to take one, should be infix, and the
	name "eq" no longer matches what it does when it is given an
	operator.

The function is similar to test_cmp which takes two files but takes
two strings, so "test_cmp_str" or something perhaps (we already have
test_cmp_rev to compare two revisions, and the suggested name
follows that pattern)?
