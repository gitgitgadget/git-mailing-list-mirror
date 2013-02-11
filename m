From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: re-encode commit messages before grepping
Date: Mon, 11 Feb 2013 13:11:24 -0800
Message-ID: <7vmwvalfnn.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <20130211205958.GA32740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50fH-000460-Qm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759991Ab3BKVL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 16:11:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759229Ab3BKVL1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2013 16:11:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9B39BAED;
	Mon, 11 Feb 2013 16:11:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BVkWgeQOg25H
	qCyo00o7lzB0Js8=; b=DXeuCpkt6DxFenDpoIlaRx0bnEZvkWMRAVq3arb0JwvQ
	b5D7QA+FN/Fsn1kBPisfFRZlWXfUHH0WcTz2EpWbuQNZHnAV8fmBQC+ivZytCR/M
	fydNxwYiq/6fjwaD1Ig7BCFLjx/VxYeJGrZ0PXhXncwenBdVI52WF2U9cXPnS5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RBMJYa
	vHwbpZWBJrRYyHgqKhpKoeFp8I5qyso6nKko3Uurrr75jjnC2chdV+q5eCwKG15q
	G7o7Ot7VblEoV+V2XSv7cXl28K1ApqoDaRc+KKnVByUIPnwzOdDhiyNXK7+CZstl
	xm3+OUzkft/OWojjUrqOdDc2xtjfDnT88d27g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE88BAEB;
	Mon, 11 Feb 2013 16:11:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F153BAE4; Mon, 11 Feb 2013
 16:11:26 -0500 (EST)
In-Reply-To: <20130211205958.GA32740@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Feb 2013 15:59:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9872E842-748F-11E2-98C6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216090>

Jeff King <peff@peff.net> writes:

>   1. I suppose we could also use $LANG or one of the $LC_* variables =
to
>      guess at the encoding of the user's pattern. But I think using t=
he
>      output encoding makes the most sense, since then the pattern you
>      searched for will actually be in the output.

I agree.  In addition, if we were to do anything with LANG/LC_CTYPE,
it should be done at the layer that implements log-output-encoding
(e.g. lack of configured encoding with nonstandard LANG/LC_CTYPE
would use the locale, or something), I think.

>   2. There are still problems with utf8 normalization. E.g., my tests
>      represent utf-8 =C3=A9 with \xc3\xa9 (the code point for that gl=
yph),
>      but it could also be represented by \x65\xcc\x81 (e + combining
>      acute). But that is not a new problem; it is an inherent issue w=
ith
>      grepping utf8. We might in the future want to offer an option to
>      normalize utf8 (or possibly the regex library can be taught to
>      handle this).

True; in either case, this caller (or any other callers) should
care.  Only grep_buffer() (actually, grep_source_1()) needs to be
taught about it.

>   4. I'm still not clear on why "--graph --no-walk" wants to look at
>      commit_match after we have already cleared the commit buffer. I
>      agree it's nonsensical, but I wonder if it might be a symptom of=
 an
>      underlying bug or inefficiency.

Yeah, that may be something we may want to check, I agree.

The aded test is also nice.  Thanks.

> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> new file mode 100755
> index 0000000..52a7472
> --- /dev/null
> +++ b/t/t4210-log-i18n.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +test_description=3D'test log with i18n features'
> +. ./test-lib.sh
> +
> +# two forms of =C3=A9
> +utf8_e=3D$(printf '\303\251')
> +latin1_e=3D$(printf '\351')
> +
> +test_expect_success 'create commits in different encodings' '
> +	test_tick &&
> +	cat >msg <<-EOF &&
> +	utf8
> +
> +	t${utf8_e}st
> +	EOF
> +	git add msg &&
> +	git -c i18n.commitencoding=3Dutf8 commit -F msg &&
> +	cat >msg <<-EOF &&
> +	latin1
> +
> +	t${latin1_e}st
> +	EOF
> +	git add msg &&
> +	git -c i18n.commitencoding=3DISO-8859-1 commit -F msg
> +'
> +
> +test_expect_success 'log --grep searches in log output encoding (utf=
8)' '
> +	cat >expect <<-\EOF &&
> +	latin1
> +	utf8
> +	EOF
> +	git log --encoding=3Dutf8 --format=3D%s --grep=3D$utf8_e >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --grep searches in log output encoding (lat=
in1)' '
> +	cat >expect <<-\EOF &&
> +	latin1
> +	utf8
> +	EOF
> +	git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$latin1_e >a=
ctual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --grep does not find non-reencoded values (=
utf8)' '
> +	>expect &&
> +	git log --encoding=3Dutf8 --format=3D%s --grep=3D$latin1_e >actual =
&&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --grep does not find non-reencoded values (=
latin1)' '
> +	>expect &&
> +	git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$utf8_e >act=
ual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
