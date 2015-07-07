From: Plamen Totev <plamen.totev@abv.bg>
Subject: Re: [PATCH] grep: use regcomp() for icase search with non-ascii patterns
Date: Tue, 7 Jul 2015 17:25:58 +0300 (EEST)
Message-ID: <790424569.1382943.1436279158871.JavaMail.apache@nm31.abv.bg>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
 <1436186551-32544-1-git-send-email-pclouds@gmail.com> <559AE0B9.2040704@web.de> <CACsJy8BDdxoN3m=FW9sCztz4Egjw7xnxXGZUkWQ3hAK9yXisnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 16:25:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTor-0006Z2-Jq
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbbGGOZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 10:25:52 -0400
Received: from smtp-out.abv.bg ([194.153.145.99]:36103 "EHLO smtp-out.abv.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251AbbGGOZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:25:25 -0400
Received: from nm31.abv.bg (nm31.ni.bg [192.168.151.86])
	by smtp-out.abv.bg (Postfix) with ESMTP id 9938114EB84;
	Tue,  7 Jul 2015 17:25:07 +0300 (EEST)
DomainKey-Signature: a=rsa-sha1; s=smtp-out; d=abv.bg; c=simple; q=dns;
	b=EAUjM0+vx6Etu6o5bEpiJVFUo9K34/1wLbnNnkoXMRmcLsm38uhfrJlfpk4qeTlSa
	OBCQhENfJfnmQrzCvGtoNinDODHEZmvxmntN8Ea4zovEsnWFkh2pj00IdWtbZ/0GDLq
	wQm+6PwDcqNZAnefcyBwvFOUOxchCbPDgyB4NAo=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=abv.bg; s=smtp-out;
	t=1436279107; bh=DZVJHFQ1wXxGbJnMOJyZ+OutjhpoOo6YSj2yubr/uuA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM; b=RyhOhB
	iwu77njGtQCc8iGvE1uziPvBvA5fB5NwD7UMDZWrTk1DGUcjeoQf14MTDu4M9wsj45d
	VeTfoddsxZNnITEUkHAJIQiQmpCrAad+J1uGT8LAfETEVujX//4r0WzmhqjAfAvU+Bk
	BzOKjvkJI14SD7Atgpso8nk5AWixogc=
Received: from nm31.abv.bg (localhost.localdomain [127.0.0.1])
	by nm31.abv.bg (Postfix) with ESMTP id D55F61CB09D;
	Tue,  7 Jul 2015 17:25:58 +0300 (EEST)
In-Reply-To: <CACsJy8BDdxoN3m=FW9sCztz4Egjw7xnxXGZUkWQ3hAK9yXisnA@mail.gmail.com>
X-Mailer: AbvMail 3.0
X-Originating-IP: 95.111.52.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273564>


On 07.07. 2015 at 02:02,=C2=A0Duy Nguyen <pclouds@gmail.com>=C2=A0wrote=
:=C2=A0
> On Tue, Jul 7, 2015 at 3:10 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrot=
e:=20
> > Am 06.07.2015 um 14:42 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy:=20

> > So the optimization before this patch was that if a string was sear=
ched for=20
> > without -F then it would be treated as a fixed string anyway unless=
 it=20
> > contained regex special characters. Searching for fixed strings usi=
ng the=20
> > kwset functions is faster than using regcomp and regexec, which mak=
es the=20
> > exercise worthwhile.=20
> >=20
> > Your patch disables the optimization if non-ASCII characters are se=
arched=20
> > for because kwset handles case transformations only for ASCII chars=
=2E=20
> >=20
> > Another consequence of this limitation is that -Fi (explicit=20
> > case-insensitive fixed-string search) doesn't work properly with no=
n-ASCII=20
> > chars neither. How can we handle this one? Fall back to regcomp by=20
> > escaping all special characters? Or at least warn?=20
>=20
> Hehe.. I noticed it too shortly after sending the patch. I was torn=20
> between simply documenting the limitation and waiting for the next=20
> person to come and fix it, or quoting the regex then passing to=20
> regcomp. GNU grep does the quoting in this case, but that code is=20
> GPLv3 so we can't simply copy over. It could be a problem if we need=20
> to quote a regex in a multibyte charset where ascii is not a subset.=20
> But i guess we can just go with utf-8..=C2=A0

I played a little bit with the code and I came up with this function to=
 escape
regular expressions in =C2=A0utf-8. Hope it helps.

static void escape_regexp(const char *pattern, size_t len,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char **new_patt=
ern, size_t *new_len)
{
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *p =3D pattern;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *np =3D *new_pattern =3D xmalloc(2 * l=
en);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int chrlen;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *new_len =3D len;

=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (len) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chrlen =3D mbs_=
chrlen(&p, &len, "utf-8");
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (chrlen =3D=3D=
 1 && is_regex_special(*pattern))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *np++ =3D '\\';

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(np, patt=
ern, chrlen);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 np +=3D chrlen;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D p;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }

=C2=A0 =C2=A0 =C2=A0 =C2=A0 *new_len =3D np - *new_pattern;
}
