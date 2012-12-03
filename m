From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Mon, 03 Dec 2012 08:56:04 -0800
Message-ID: <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
References: <201212021417.25525.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 17:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfZJh-0001rW-Da
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 17:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab2LCQ4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2012 11:56:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab2LCQ4H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2012 11:56:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A9AFA1FB;
	Mon,  3 Dec 2012 11:56:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RMdXISmiqiIH
	ysR7aiegmMyBYHM=; b=YLUe5OKWAKANIpiRlVfjGhUQ5A2Vsb1VfVzdiuf+HKMF
	U3YEoMx68ClBn35R+KtLWksZ5UFKP0dMwUmxPwQZ+M7q/O6H0JMYWc/B9uZGGLSU
	zADAXQ0EdQioDwv+zuyuKCH8uSScfqlswt8HtO8+dftpHghNH+yxLU/QDbsFXGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jcdOFP
	USWM1dJmhqloxBgmnCNhpc9pXWtbVKzkTVZx1UoCUK6yX3910n/XwffJs1B4ScyX
	3Bz0KMBrLDHZiDDIWwylRTl9Q66hI9N1Osi0Eywnk6FbRf9Rriz3TJ2Is4205nNT
	FNSknCn/q2RdNpQ325yHQMeGZNyLQLSp2EZrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0921FA1FA;
	Mon,  3 Dec 2012 11:56:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56E13A1F8; Mon,  3 Dec 2012
 11:56:06 -0500 (EST)
In-Reply-To: <201212021417.25525.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sun, 2 Dec 2012 14:17:24
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 543CB560-3D6A-11E2-8563-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211045>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The test suite needs to be run on different platforms.
> As it may be difficult for contributors to catch syntax
> which work on GNU/linux, but is unportable, make a quick check
> for the most common problems.
> "sed -i", "echo -n" or "array in shell scripts"
> This list is not complete, and may need to be extended
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> We add 1 second test execution time
> Is this a useful idea at all?

Please do not name it after t/t[0-9]*.sh pattern, which are about
testing git.

This (once it gets cleaned up to reduce false positives) belongs to
"cd t && make test-lint".

> =20
>  t/t99999-syntax-check.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100755 t/t99999-syntax-check.sh
>
> diff --git a/t/t99999-syntax-check.sh b/t/t99999-syntax-check.sh
> new file mode 100755
> index 0000000..c4a9289
> --- /dev/null
> +++ b/t/t99999-syntax-check.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +
> +test_description=3D'Basic check if shell syntax is portable'
> +
> +. ./test-lib.sh
> +
> +
> +test_expect_success 'No arrays in shell scripts' '
> +	>expected &&
> +	(grep -i -n "^[	 ]*declare[	 ][	 ]*" ../*.sh ../../git-* >actual 2>=
&1 || : ) &&
> +	test_cmp expected actual &&
> +	rm expected actual
> +'
> +
> +test_expect_success 'No sed -i' '
> +	>expected &&
> +	(grep -n "^[	 ]*sed[	 ][	 ]*\-i" ../*.sh ../../git-* >actual 2>&1 |=
| : ) &&
> +	test_cmp expected actual &&
> +	rm expected actual
> +'
> +
> +test_expect_success 'No echo -n' '
> +	>expected &&
> +	(grep -n "^[	 ]*echo[	 ][	 ]*\-n" ../*.sh ../../git-* >actual 2>&1 =
|| : ) &&
> +	test_cmp expected actual &&
> +	rm expected actual
> +'
> +test_done
