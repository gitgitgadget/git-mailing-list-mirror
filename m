From: Jeff King <peff@peff.net>
Subject: Re: Problem listing GIT repository with accents
Date: Mon, 1 Feb 2010 08:39:03 -0500
Message-ID: <20100201133903.GA923@coredump.intra.peff.net>
References: <7E88665723814E46BCBA1A39E84C27A5@elrond>
 <20100201113213.GA22663@coredump.intra.peff.net>
 <20100201121933.GA9995@coredump.intra.peff.net>
 <4B66CD81.3010005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?RWxsacOp?= Computing Open Source Program 
	<opensource@elliecomputing.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 14:39:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbwUn-0003FU-LK
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 14:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab0BANjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 08:39:10 -0500
Received: from peff.net ([208.65.91.99]:55316 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab0BANjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 08:39:09 -0500
Received: (qmail 25168 invoked by uid 107); 1 Feb 2010 13:39:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 08:39:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 08:39:03 -0500
Content-Disposition: inline
In-Reply-To: <4B66CD81.3010005@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138609>

On Mon, Feb 01, 2010 at 01:48:01PM +0100, Johannes Sixt wrote:

> Jeff King schrieb:
> > @@ -209,11 +209,14 @@ static size_t quote_c_style_counted(const cha=
r *name, ssize_t maxlen,
> >  	size_t len, count =3D 0;
> >  	const char *p =3D name;
> > =20
> > +	if (maxlen < 0)
> > +		maxlen =3D strlen(name);
> > +
> >  	for (;;) {
> >  		int ch;
> > =20
> >  		len =3D next_quote_pos(p, maxlen);
> > -		if (len =3D=3D maxlen || !p[len])
> > +		if (len =3D=3D maxlen)
> >  			break;
> > =20
> >  		if (!no_dq && p =3D=3D name)
> > @@ -223,6 +226,7 @@ static size_t quote_c_style_counted(const char =
*name, ssize_t maxlen,
> >  		EMIT('\\');
> >  		p +=3D len;
> >  		ch =3D (unsigned char)*p++;
> > +		maxlen -=3D len + 1;
>=20
> Couldn't you just write
>=20
> 		if (0 <=3D maxlen)
> 			maxlen -=3D len + 1;
>=20
> to avoid the strlen(), because the rest of the loop is actually OK wh=
en
> maxlen =3D=3D -1, isn't it?

If you want to keep the "!p[len]" condition, then yes. If we want to
properly quote internal NULs (which again, I am not sure is of practica=
l
use), then you would also have to make that condition "(maxlen >=3D 0 &=
&
!p[len])".  Which is really not that bad, but I was trying to make it
easier to read. I am OK with any of the three combinations of fixes.

And the fact that I am using the word "combination" probably means it
should be a separate patch anyway.

So here is the minimal patch to go on 'maint', for Junio's convenience.

-- >8 --
Subject: [PATCH] fix invalid read in quote_c_style_counted

This function did not work on strings that were not
NUL-terminated. It reads through a length-bounded string,
searching for characters in need of quoting. After we find
one, we output the quoted character, then advance our
pointer to find the next one. However, we never decremented
the length, meaning we ended up looking at whatever random
junk was stored after the string.

This bug was not found by the existing tests because most
code paths feed a NUL-terminated string. The notable
exception is a directory name being fed by ls-tree.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c           |    2 ++
 t/t3902-quoted.sh |   19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/quote.c b/quote.c
index acb6bf9..723bb4f 100644
--- a/quote.c
+++ b/quote.c
@@ -223,6 +223,8 @@ static size_t quote_c_style_counted(const char *nam=
e, ssize_t maxlen,
 		EMIT('\\');
 		p +=3D len;
 		ch =3D (unsigned char)*p++;
+		if (maxlen >=3D 0)
+			maxlen -=3D len + 1;
 		if (sq_lookup[ch] >=3D ' ') {
 			EMIT(sq_lookup[ch]);
 		} else {
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 5868052..14da45f 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -25,7 +25,7 @@ for_each_name () {
 	for name in \
 	    Name "Name and a${LF}LF" "Name and an${HT}HT" "Name${DQ}" \
 	    "$FN$HT$GN" "$FN$LF$GN" "$FN $GN" "$FN$GN" "$FN$DQ$GN" \
-	    "With SP in it"
+	    "With SP in it" "caract=C3=A8re sp=C3=A9cial/file"
 	do
 		eval "$1"
 	done
@@ -33,6 +33,7 @@ for_each_name () {
=20
 test_expect_success setup '
=20
+	mkdir "caract=C3=A8re sp=C3=A9cial" &&
 	for_each_name "echo initial >\"\$name\""
 	git add . &&
 	git commit -q -m Initial &&
@@ -50,6 +51,7 @@ Name
 "Name and an\tHT"
 "Name\""
 With SP in it
+"caract\303\250re sp\303\251cial/file"
 "\346\277\261\351\207\216\t\347\264\224"
 "\346\277\261\351\207\216\n\347\264\224"
 "\346\277\261\351\207\216 \347\264\224"
@@ -63,6 +65,7 @@ Name
 "Name and an\tHT"
 "Name\""
 With SP in it
+caract=C3=A8re sp=C3=A9cial/file
 "=E6=BF=B1=E9=87=8E\t=E7=B4=94"
 "=E6=BF=B1=E9=87=8E\n=E7=B4=94"
 =E6=BF=B1=E9=87=8E =E7=B4=94
@@ -97,6 +100,13 @@ test_expect_success 'check fully quoted output from=
 diff-tree' '
=20
 '
=20
+test_expect_success 'check fully quoted output from ls-tree' '
+
+	git ls-tree --name-only -r HEAD >current &&
+	test_cmp expect.quoted current
+
+'
+
 test_expect_success 'setting core.quotepath' '
=20
 	git config --bool core.quotepath false
@@ -130,4 +140,11 @@ test_expect_success 'check fully quoted output fro=
m diff-tree' '
=20
 '
=20
+test_expect_success 'check fully quoted output from ls-tree' '
+
+	git ls-tree --name-only -r HEAD >current &&
+	test_cmp expect.raw current
+
+'
+
 test_done
--=20
1.7.0.rc1.16.g21332.dirty
