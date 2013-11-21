From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/10] t5500: Test case for diag-url
Date: Thu, 21 Nov 2013 15:27:23 -0800
Message-ID: <xmqqfvqp2v50.fsf@gitster.dls.corp.google.com>
References: <201311212140.58804.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 00:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjdek-0006SR-Su
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 00:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab3KUX11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 18:27:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3KUX10 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 18:27:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86DA15451C;
	Thu, 21 Nov 2013 18:27:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=m72xUs9ELqP7
	AoGvnXP7SPo1Xgw=; b=DxC8839xubjKbrPSscA9DZHBpOhGkU00rR28FTN/W4Qd
	TBVMphImlBvaZz8lttiB66pnBDJMPxc9GYClnWr3BLGRUIol3x9L4HZ/n5scBbRu
	j+QmGqBlCLXWU/nZVyHEsxHoKOTUyVBGYIFJcbE5DYvK6+JzfYZ2WR4L4L5SQZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xhZWka
	7lVuEX249kzBwykG3fUwjAJpUQPahncMlMngawJBKQQu+VWyTi3lCzoey6SmF3fO
	7g2CF0f1jOiVGYdkcnLgBzq2R+dBHIsw4xOH4Mv7FAcot9VxAFTsyGPJm0PlnA4V
	yZGSj2DQkkGVGwf40/W3HzR9wwFqtENJSb1zI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 778775451B;
	Thu, 21 Nov 2013 18:27:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD68C5451A;
	Thu, 21 Nov 2013 18:27:24 -0500 (EST)
In-Reply-To: <201311212140.58804.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 21 Nov 2013 21:40:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A496C98-5304-11E3-9F3B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238163>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Add test cases using git fetch-pack --diag-url:
>
> - parse out host and path for URLs with a scheme (git:// file:// ssh:=
//)
> - parse host names embedded by [] correctly
> - extract the port number, if present
> - seperate URLs like "file" (which are local)
>   from URLs like "host:repo" which should use ssh
> ---
>  t/t5500-fetch-pack.sh | 72 +++++++++++++++++++++++++++++++++++++++--=
----------
>  1 file changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 9136f2a..7f55b95 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -533,7 +533,7 @@ test_expect_success 'shallow fetch with tags does=
 not break the repository' '
>  '
>  check_prot_path() {
>  	> actual &&
> -	(git fetch-pack --diag-url "$1" 2>&1 1>stdout) | grep -v host=3D >a=
ctual &&
> +	(git fetch-pack --diag-url  "$1" 2>&1 1>stdout) | grep -v host=3D >=
actual &&

What is this change about???

>  	echo "Diag: url=3D$1" >expected &&
>  	echo "Diag: protocol=3D$2" >>expected &&
>  	echo "Diag: path=3D$3" >>expected &&
> @@ -542,7 +542,7 @@ check_prot_path() {
> =20
>  check_prot_host_path() {
>  	> actual &&
> -	git fetch-pack --diag-url "$1" 2>actual &&
> +	git fetch-pack --diag-url  "$1" 2>actual &&

Likewise...

> @@ -564,29 +564,69 @@ do
>  				hh=3D$h
>  				pp=3D$p
>  			fi
> -			test_expect_success "fetch-pack $p://$h/$r" '
> +			test_expect_success "fetch-pack --diag-url $p://$h/$r" '
>  				check_prot_host_path $p://$h/$r $pp "$hh" "/$r"
>  			'
> -			# "/~" -> "~" conversion for git
> -			test_expect_success "fetch-pack $p://$h/~$r" '
> +			# "/~" -> "~" conversion
> +			test_expect_success "fetch-pack --diag-url $p://$h/~$r" '

Is this part, especially the "s/ for git//" bit, an "oops, the
earlier one was wrong" fix to [05/10]?  If so, please don't.
Instead, please get it right in that patch before sending the series
out.
