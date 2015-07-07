From: Plamen Totev <plamen.totev@abv.bg>
Subject: Re: Git grep does not support multi-byte characters (like UTF-8)
Date: Tue, 7 Jul 2015 11:58:54 +0300 (EEST)
Message-ID: <775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg> <CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 10:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCOi1-00073F-5p
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 10:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbbGGI61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 04:58:27 -0400
Received: from smtp-out.abv.bg ([194.153.145.99]:33521 "EHLO smtp-out.abv.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991AbbGGI6S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 04:58:18 -0400
Received: from nm31.abv.bg (nm31.ni.bg [192.168.151.86])
	by smtp-out.abv.bg (Postfix) with ESMTP id 6306114EF9D;
	Tue,  7 Jul 2015 11:58:05 +0300 (EEST)
DomainKey-Signature: a=rsa-sha1; s=smtp-out; d=abv.bg; c=simple; q=dns;
	b=pyOO9Xiq4uB+LOCwaSmO8rE7SXM/NtYYn4ogCzWZL2nPQWuInuBbUfi+AMH5gpiuH
	ZNNPQS9qAxIN0qP4thR9rTDM2+AfUCx5fKY5i++qvL0Ajbj84qn0GfKTIVqjeXAF3pG
	Be6o4H5NtZypUeMkDSbJSzM+NVJXDhp+BhuNQTU=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=abv.bg; s=smtp-out;
	t=1436259485; bh=+vI3l+H22ovLfQyc/J/2M92aMaHEYwNa8WeAu8RHJe0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM; b=lZOWs2
	Q8REF6R8Vf8xfjn54+ZHOJjMk7C/c+P7wJLoohHmO8rB2Lz51pGo+KPjno9ektZhwnV
	2xIxHalsYHGneyKVNmViC/NbrFJ+5Rf6CoLcYRPErruKHxZWpaPJtwANg8ByZeuVgvh
	lTY8kRT+2a8ffkGfvnoBERHm2F5gIoo=
Received: from nm31.abv.bg (localhost.localdomain [127.0.0.1])
	by nm31.abv.bg (Postfix) with ESMTP id D057B1CB09D;
	Tue,  7 Jul 2015 11:58:54 +0300 (EEST)
In-Reply-To: <CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com>
X-Mailer: AbvMail 3.0
X-Originating-IP: 95.111.52.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273492>

Nguyen, thanks for the help and the patch. Also the escaping suggested =
by=C2=A0Scharfe seems as good choice. But i dig some more into the prob=
lem and I found some other thing. That's why I replied on the main thre=
ad not on the patch. I hope you'll excuse me if this is a bad practice.

git grep -i -P also does not works because the PCRE_UTF8 is not set and=
 pcre library does not treat the string as UTF-8.

pickaxe search also uses kwsearch so the case insensitive search with i=
t does not work (e.g. git log -i -S). =C2=A0Maybe this is a less of a p=
roblem here as one is expected to search for exact string (hence knows =
the case)

There is a interesting corner case.=C2=A0is_fixed treats all patterns c=
ontaining nulls as fixed. So what about if the string contains non-ASCI=
I symbols as well as nulls and the search is case insensitive :) I have=
 to admin that my knowledge in UTF-8 is not enough to answer the questi=
on if this could occur during normal usage. For example the second byte=
 in multi-byte symbol is NULL. I would guess that's not true as it woul=
d break a lot of programs that depend on NULL delimited string but it's=
 good if somebody could confirm.

GNU grep indeed uses escaped regular expressions when the string is usi=
ng multi-byte encoding and the search is case insensitive. If the encod=
ing is UTF-8 then this strategy could be used in git too. Especially th=
at git already have support and helper functions to work with UTF-8. As=
 for the other multi-byte encodings - I think the things would become m=
ore complicated. As far I know in UTF-8 the '{' character for example i=
s two bytes not one. Maybe really a support could be added only for the=
 UTF-8 and if the string is not UTF-8 to issue a warning.

So maybe the following makes sense when a grep search is performed:
* check if the multi-byte encoding is used. If it's and the search is c=
ase insensitive and the encoding is not UTF-8 give a warning;
* if pcre is used and the string is UTF-8 encoded set the=C2=A0PCRE_UTF=
8 flag;
* if the search is case insensitive, the string is fixed and the encodi=
ng =C2=A0used is UTF-8 use=C2=A0regcomp instead of kwsearch and escape =
any regex special characters in the pattern;

And the question with the behavior of pickaxe search remains open. Usin=
g kwset does not work with case insensitive non-ASCII searches. Instead=
 of fixing grep.c maybe it's better if new function is introduced that =
performs keyword searches so it could be used by both grep, diffcore-pi=
ckaxe and any other code in the future that may require such functional=
ity. Or maybe diffcore-pickaxe should use grep instead of directly kwse=
t/regcomp

Regards,
Plamen Totev



>-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE =
=D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------=20
>=D0=9E=D1=82: Duy Nguyen pclouds@gmail.com=20
>=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: Git grep does not supp=
ort multi-byte characters (like UTF-8)=20
>=D0=94=D0=BE: Plamen Totev <plamen.totev@abv.bg>=20
>=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: 0=
6.07.2015 15:23=20

> I think we over-optimized a bit. If you your system provides regex=20
> with locale support (e.g. Linux) and you don't explicitly use fallbac=
k=20
> regex implementation, it should work. I suppose your test patterns=20
> look "fixed" (i.e. no regex special characters)? Can you try just add=
=20
> "." and see if case insensitive matching works?=20

This is indeed the problem. When I added the "." the matching works jus=
t fine.
