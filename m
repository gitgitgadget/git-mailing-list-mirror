From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Push the NATIVE_CRLF Makefile variable to C and added a test for native.
Date: Tue, 19 Aug 2014 11:19:43 -0700
Message-ID: <xmqqsiksuytc.fsf@gitster.dls.corp.google.com>
References: <53F25488.8000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:20:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJo0m-00045S-3F
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 20:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaHSSTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2014 14:19:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61460 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbaHSSTy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2014 14:19:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 756052FB9E;
	Tue, 19 Aug 2014 14:19:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cFoTUzQwvLnc
	AU2VfCnZtrv3swA=; b=yUWnZxKYXAu2FHCZvNuNJ+1eZSSVUolxgksC+vlTxHdZ
	pBtvcFQz7qUIhkAz9TewQTavRX0W4FT0siW9z+x6WgQXRWsE5eUwdMhEP7pBc0l3
	b9tmJdfn5+Iotmnntx7mntF9NwN1aUhFwV5DCI9kfTVO68aW0xqtiVnifG2lU4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S96lcp
	CocalL4SBnHAmehQ3kNlkJ1H6vFihydACDIoGbCAKD/pc+OI73VhVAhiRWVHyihh
	VlkCKCNZUDPpcB+saKiRZy6oKTI0Nw3LTA0cRqM3AX8epkEcFGoL9QgXiCHOLAoz
	Yd/0nYR59nsfNTOrLJDwH7GWx6wyUEXaYH+18=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B9502FB9D;
	Tue, 19 Aug 2014 14:19:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 09DA42FB8B;
	Tue, 19 Aug 2014 14:19:44 -0400 (EDT)
In-Reply-To: <53F25488.8000103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 18 Aug 2014 21:31:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 655F9EDA-27CD-11E4-8359-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255507>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Commit 95f31e9a correctly points out that the NATIVE_CRLF setting is
> incorrectly set on Mingw git. However, the Makefile variable is not
> propagated to the C preprocessor and results in no change. This patch
> pushes the definition to the C code and adds a test to validate that
> when core.eol as native is crlf, we actually normalize text files to =
this
> line ending convention when core.autocrlf is false.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> (This is from MINGW, and some part of my brain thougth that this was =
send
> upstream, but it wasn't. Only 95f31e9a is in git.git)
>
>  Makefile              |  3 +++
>  t/t0026-eol-config.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 63a210d..13311d2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1481,6 +1481,9 @@ ifdef NO_REGEX
>  	COMPAT_CFLAGS +=3D -Icompat/regex
>  	COMPAT_OBJS +=3D compat/regex/regex.o
>  endif
> +ifdef NATIVE_CRLF
> +	BASIC_CFLAGS +=3D -DNATIVE_CRLF
> +endif
> =20
>  ifdef USE_NED_ALLOCATOR
>         COMPAT_CFLAGS +=3D -Icompat/nedmalloc
> diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
> index 4807b0f..43a580a 100755
> --- a/t/t0026-eol-config.sh
> +++ b/t/t0026-eol-config.sh
> @@ -80,4 +80,22 @@ test_expect_success 'autocrlf=3Dtrue overrides uns=
et eol' '
>  	test -z "$onediff" && test -z "$twodiff"
>  '
> =20
> +test_expect_success NATIVE_CRLF 'eol native is crlf' '

Who defines this test prerequisite?

> +
> +	rm -rf native_eol && mkdir native_eol &&
> +	( cd native_eol &&
> +	printf "*.txt text\n" > .gitattributes
> +	printf "one\r\ntwo\r\nthree\r\n" > filedos.txt
> +	printf "one\ntwo\nthree\n" > fileunix.txt

Style and nits:

 - No SP between a redirection operator and its target.
 - Broken && chain.
 - Not indented.

i.e.

	rm -rf native_eol &&
        mkdir native_eol &&
        (
		cd native_eol &&
                printf ... >.gitattributes &&
		...
                has_cr filedos.txt &&
                has_cr fileunix.txt
	)

> +	git init &&
> +	git config core.autocrlf false &&
> +	git config core.eol native &&
> +	git add filedos.txt fileunix.txt &&
> +	git commit -m "first" &&
> +	rm file*.txt &&
> +	git reset --hard HEAD &&
> +	has_cr filedos.txt && has_cr fileunix.txt
> +	)
> +'
> +
>  test_done
