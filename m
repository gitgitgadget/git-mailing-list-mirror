From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: add known breakage of coloring when using extended
 patterns
Date: Mon, 02 May 2011 23:07:54 +0200
Message-ID: <4DBF1D2A.6030807@lsrfire.ath.cx>
References: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com> <4DBEE672.5070707@lsrfire.ath.cx> <7vd3k1ngun.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoQ==?= =?UTF-8?B?aSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>,
	Thiago dos Santos Alvest <hiago.salves@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 23:08:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH0Ld-0008Gr-FL
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 23:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852Ab1EBVH7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 17:07:59 -0400
Received: from india601.server4you.de ([85.25.151.105]:40930 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1EBVH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 17:07:58 -0400
Received: from [192.168.2.106] (p4FFDA511.dip.t-dialin.net [79.253.165.17])
	by india601.server4you.de (Postfix) with ESMTPSA id 1A03C2F8050;
	Mon,  2 May 2011 23:07:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vd3k1ngun.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172633>

Am 02.05.2011 19:37, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>>> +	test_commit initial input "foo bar baz
> ...
>>> +	git grep --color -e foo --or \( -e bar --and --not -e baz \) |
> ...
>> The current code highlights the given search terms ("atoms").
>
> Hmm, I was probably not paying attention to "coloring the parts that
> matched" topic at all, but wouldn't it be easier and more efficient t=
o
> paint only "foo" without painting "bar baz"?  We know the first term =
"foo"
> matches, and the rest \(...\) that is --or'ed does not have to even b=
e
> evaluated, no?

Aggregating the set of matching characters and passing them back during=
=20
expression evaluation can be more efficient, yes, as it would avoid=20
calling regexec() on the printed lines again only to find out what to=20
color.  But I wouldn't call it easy.  E.g. how to return the set of=20
matching characters in the following case?

	$ git grep --color -e foo --and -e bar

I can only think of using lists or, even uglier, perhaps a bitmap to=20
remember which characters to highlight.

Also GNU grep doesn't only color the first sufficient match.  E.g. this=
=20
will color both b and d:

	$ echo abcde | grep --color -e b -e d

And I think this makes sense and meets my expectations.

But the other mode, which only colors the exact characters that were=20
used to determine that the shown line matches (or doesn't match, if -v=20
is given) may be interesting as well.  I'm curious to see an=20
implementation and wonder if the results are really better than the one=
s=20
of the current (cheating) approach. :)

Ren=C3=A9
