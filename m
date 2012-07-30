From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: bug (?) in send email
Date: Mon, 30 Jul 2012 14:30:35 +0200
Message-ID: <873949mnx0.fsf@thomas.inf.ethz.ch>
References: <50145A90.1090904@web.de> <50166408.8000008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Christoph Miebach <christoph.miebach@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 30 14:30:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svp7U-0003Ku-CW
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 14:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab2G3Maj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 08:30:39 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39704 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622Ab2G3Mai convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 08:30:38 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 30 Jul
 2012 14:30:35 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 30 Jul
 2012 14:30:35 +0200
In-Reply-To: <50166408.8000008@web.de> (Christoph Miebach's message of "Mon,
	30 Jul 2012 12:38:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202539>

[+Cc people involved with this function]

Christoph Miebach <christoph.miebach@web.de> writes:

> > git commit --author=3D"Micha=C5=82 Tz <name_1911@some.com>" modifie=
d.file -m
> > "Test"
> >
> > git format-patch -o patches origin
> >
> > Now, the patch seems to have the address right, see [1]
> >
> > git send-email  --to MYOWN.ADDRESS@mail.com --suppress-cc=3Dauthor
> > patches/0001-Test.patch
> >
> > But checking my inbox now shows an email starting with:
> > From: Micha=C5=82 Tz <name 1911@some.com>
>=20
> Removing this line
> s/_/ /g;
> here
> https://github.com/git/git/blob/master/git-send-email.perl#L867
>
> Solves this problem for me. But I really don't have any clue, what
> kind of side effects this modification on "sub unquote_rfc2047" might
> have.

It would prevent spaces from being decoded correctly if the encoding
program chooses to make the '_'.  git-format-patch does not actually do
this, see the big comment around pretty.c:304.

I think this patch would be a better match for what RFC2047 specifies.
On the one hand it avoids substituting _ outside of encodings, but OTOH
it also handles more than one encoded-word.  It still does not handle
the case where there are several encoded-words of *different* encodings=
,
but who would do such a crazy thing?


diff --git i/git-send-email.perl w/git-send-email.perl
index ef30c55..88c4758 100755
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@ -862,11 +862,13 @@ sub make_message_id {
 sub unquote_rfc2047 {
 	local ($_) =3D @_;
 	my $encoding;
-	if (s/=3D\?([^?]+)\?q\?(.*)\?=3D/$2/g) {
+	s{=3D\?([^?]+)\?q\?(.*)\?=3D}{
 		$encoding =3D $1;
-		s/_/ /g;
-		s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
-	}
+		my $e =3D $2;
+		$e =3D~ s/_/ /g;
+		$e =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
+		$e;
+	}eg;
 	return wantarray ? ($_, $encoding) : $_;
 }
=20


--=20
Thomas Rast
trast@{inf,student}.ethz.ch
