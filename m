From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/15] ref-filter: align: introduce long-form syntax
Date: Mon, 25 Jan 2016 15:45:43 -0800
Message-ID: <xmqqa8ntdxzs.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-13-git-send-email-Karthik.188@gmail.com>
	<CAPig+cT56AiO-3GNzia7UsGZFM5zu5zsEC31XPuq-by1p4+sbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 00:45:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNqpU-0003qt-KX
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 00:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933535AbcAYXps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 18:45:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932955AbcAYXpq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 18:45:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DB2140B0E;
	Mon, 25 Jan 2016 18:45:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c6FHTcNrZZq1/4400NTjd+7DpU8=; b=uzeJ1Z
	KotmKfggFyEOdZAMupM43qbCDhj+cEIXqcGCY2FlERv0soSVbI//XGO+ymjnQyJK
	YNDBWGxZ211MGuxqEpAT8nylM1DVkOQfurMs2LlhSYYSOVCTR4BhloBwi7h4nCcJ
	fd5sbYtM8D6+nelqczHH7ZPEEMxEIQsZYaLGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJzFI4v6ewEuNaKh2zL4+G+Oe+Pg9R8l
	5MkMglE9TQReg0kyPDVRmy6h2HxnJF34x329jIecmG3YPybSvxMKjeFI56eRsEb/
	1acutOZQuIr1/fRX5k7NK2sAOCTSuyAOHfh5NGW8V1WwwkXDIZbX7E1xfXL5+lY0
	Imj6X/y3VQA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15E5C40B0D;
	Mon, 25 Jan 2016 18:45:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 88C0340B0B;
	Mon, 25 Jan 2016 18:45:45 -0500 (EST)
In-Reply-To: <CAPig+cT56AiO-3GNzia7UsGZFM5zu5zsEC31XPuq-by1p4+sbw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 25 Jan 2016 17:58:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C0CFE3B4-C3BD-11E5-987B-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284769>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +               git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
>
> This is not wrong, per se, but referencing $option inside the
> non-interpolating single-quote context of the test body makes it a bit
> harder to understand than it need be. As it is, at the time that the
> test body actually gets executed, $option still evaluates to the
> desired permutation value so it works. 

I think I said this in one of my recent reviews to somebody else,
but this needs repeating.

My position on this has been and still is a complete opposite.  It
is a designed behaviour that variable references made inside test
body that is quoted with sq pair can see the values of the variables
that are defined outside test_expect_success, and you can freely use
the global $TRASH_DIRECTORY, $_x40, etc. inside the test body that
is quoted with single quote.  The $option here is no different.

In fact, it is more desirable to avoid double-quoting the test body.
The problem with using double-quote around the test body and
formulating the executable shell script using variable interpolation
before test_expect_success even runs is that you would be tempted to
do something silly like this:

    HEAD_SHA1=$(git rev-parse --verify HEAD)

    test_expect_success "check something" "
	HEAD_SHA1=$(git rev-parse --verify HEAD) &&
	... do other things that should not move the HEAD ... &&
	test '$(git rev-parse HEAD)' = '$HEAD_SHA1' &&
	test '$SOME_VAR' = '$OTHER_VAR' &&
    "

It is not just error prone (if variable reference had a shell
metacharacter in it, e.g. a single-quote in OTHER_VAR's value, you'd
have a syntax error in the test body), but because two invocations
of rev-parse in the above are both made before test_expect_success
runs, and would yield the same value.  It is not even testing the
right thing.  If you broke rev-parse, the invocation will not fail
inside test_expect_success but outside when the arguments to that
helper is being prepared.

So please do not write something like this:

>     test_align_permutations () {
>         while ...
>         do
>             test_expect_success "align:$option" "
>                 git for-each-ref --format='...$option...' >actual &&
>                 ...
>             "
>         done
>     }

but make it more like this:

	for option in ...
        do
        	test_expect_success "align:$option" '
                	git for-each-ref --format="...$option..." &&
                        ...
		'
	done
