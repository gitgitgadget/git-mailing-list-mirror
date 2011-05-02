From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: add known breakage of coloring when using extended
 patterns
Date: Mon, 02 May 2011 19:14:26 +0200
Message-ID: <4DBEE672.5070707@lsrfire.ath.cx>
References: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>,
	Thiago dos Santos Alvest <hiago.salves@gmail.com>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:14:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGwhl-0001Cn-1E
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 19:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab1EBROg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 13:14:36 -0400
Received: from india601.server4you.de ([85.25.151.105]:38419 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1EBROf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 13:14:35 -0400
Received: from [192.168.2.106] (p4FFDB93C.dip.t-dialin.net [79.253.185.60])
	by india601.server4you.de (Postfix) with ESMTPSA id 1503D2F8050;
	Mon,  2 May 2011 19:14:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172603>

Am 02.05.2011 13:35, schrieb Bert Wesarg:
> The coloring code does not respect the extended pattern format, expos=
e
> this with an known breakage test.
>
> Signed-off-by: Bert Wesarg<bert.wesarg@googlemail.com>
> ---
>   t/t7812-grep-color.sh |   25 +++++++++++++++++++++++++
>   1 files changed, 25 insertions(+), 0 deletions(-)
>   create mode 100755 t/t7812-grep-color.sh
>
> diff --git a/t/t7812-grep-color.sh b/t/t7812-grep-color.sh
> new file mode 100755
> index 0000000..2cffff3
> --- /dev/null
> +++ b/t/t7812-grep-color.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +test_description=3D'git grep --color
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit initial input "foo bar baz
> +bar baz
> +"
> +'
> +
> +cat>expected<<EOF
> +input<CYAN>:<RESET><BOLD;RED>foo<RESET>  bar baz
> +EOF
> +
> +
> +test_expect_failure 'grep coloring does not honor boolean algebra' '
> +	git grep --color -e foo --or \( -e bar --and --not -e baz \) |
> +		test_decode_color>actual
> +    test_cmp expected actual
> +'
> +
> +test_done

The current code highlights the given search terms ("atoms").  You=20
expect the matching part of a line to be highlighted instead.  Another=20
example with differing results between the two ways is this:

	$ git grep -v -e foo --and -e bar

The first one was easy to implement and useful already.  I wonder how t=
o=20
implement the second one (I couldn't think of an easy way back then) an=
d=20
also if we really prefer it to the current behaviour in the first place=
=2E

The twisted logic that convinced me to forget about the issue goes like=
=20
this: Even by giving negative search terms, the user is expressing a=20
certain value of interest in them; highlighting these atoms even in=20
lines which were not matched by them is a courtesy.

Ren=C3=A9
