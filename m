From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] format-patch: RFC 2047 says multi-octet character may
 not be split
Date: Thu, 7 Mar 2013 14:55:07 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20130307105430.GA3049@tugrik.mns.mnsspb.ru>
References: <1362568106-30741-1-git-send-email-kirr@mns.spb.ru>
 <7vd2vcqv1y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Komissarov <dak@mnsspb.ru>, git@vger.kernel.org,
	Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <schnhrr@cs.tu-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 11:55:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDYUE-00063q-NM
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 11:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab3CGKzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 05:55:20 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:57704 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab3CGKzT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 05:55:19 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1UDYTf-0000VY-K4; Thu, 07 Mar 2013 14:55:11 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1UDYTb-0004h3-To; Thu, 07 Mar 2013 14:55:07 +0400
Content-Disposition: inline
In-Reply-To: <7vd2vcqv1y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217590>

Junio,

On Wed, Mar 06, 2013 at 09:47:53AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
>=20
> > Intro
> > -----
>=20
> Drop this.  We know the beginning part is "intro" already ;-)

:)


> >     Subject: .... f=F6=F6 bar
> >
> > encoding
> >
> >     Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
> >      =3D?UTF-8?q?=3D20bar?=3D
> >
> > is correct, and
> >
> >     Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3?=3D      <-- NOT=
E =F6 is broken here
> >      =3D?UTF-8?q?=3DB6=3D20bar?=3D
> >
> > is not, because "=F6" character UTF-8 encoding C3 B6 is split here =
across
> > adjacent encoded words.
>=20
> The above is an important part to keep in the log message.
> Everything above that I snipped can be left out for brevity.
>=20
> > As it is now, format-patch does not respect "multi-octet charactes =
may
> > not be split" rule, and so sending patches with non-english subject=
 has
> > issues:
> >
> >     The problematic case shows in mail readers as ".... f=F6?? bar"=
=2E
>=20
> But the log message lacks crucial bits of information before you
> start talking about your solution.  Where does it go wrong?  What
> did the earlier attempt bafc478..41dd00bad miss?  This can be fixed
> trivially by replacing the above (and the "solution" section),
> perhaps like this:
>=20
>     Even though an earlier attempt (bafc478..41dd00bad) cleaned
>     up RFC 2047 encoding, pretty.c::add_rfc2047() still decides
>     where to split the output line by going through the input
>     one byte at a time, and potentially splits a character in
>     the middle.  A subject line may end up showing like this:
>=20
>          The problematic case shows in mail readers as ".... f=F6?? b=
ar".
>=20
>     Instead, make the loop grab one _character_ at a time and
>     determine its output length to see where to break the output
>     line.  Note that this version only knows about UTF-8, but the
>     logic to grab one character is abstracted out in mbs_chrlen()
>     function to make it possible to extend it to other encodings.

I agree my description was messy and thanks for reworking and clarifyin=
g
it - your version is much better.

I'll use its slight variation for the updated patch.


> > +	while (len) {
> > +		/*
> > +		 * RFC 2047, section 5 (3):
> > +		 *
> > +		 * Each 'encoded-word' MUST represent an integral number of
> > +		 * characters.  A multi-octet character may not be split across
> > +		 * adjacent 'encoded- word's.
> > +		 */
> > +		const unsigned char *p =3D (const unsigned char *)line;
> > +		int chrlen =3D mbs_chrlen(&line, &len, encoding);
> > +		int is_special =3D (chrlen > 1) || is_rfc2047_special(*p, type);
> > =20
> >  		/*
> >  		 * According to RFC 2047, we could encode the special character
> > @@ -367,16 +376,18 @@ static void add_rfc2047(struct strbuf *sb, co=
nst char *line, int len,
> >  		 * causes ' ' to be encoded as '=3D20', avoiding this problem.
> >  		 */
> > =20
> > +		if (line_len + 2 + (is_special ? 3*chrlen : 1) > max_encoded_len=
gth) {
>=20
> Always have SP around binary operators such as '*' (multiplication).

ok, but note that's just a matter of style, and if one is used to code
formulas, _not_ having SP is more convenient sometimes.


> I would actually suggest adding an extra variable "encoded_len" and
> do something like this:
>=20
> 	/* "=3D%02X" times num_char, or the byte itself */
> 	encoded_len =3D is_special ? 3 * num_char : 1;
>         if (max_encoded_length < line_len + 2 + encoded_len) {
>         	/* It will not fit---break the line */
> 		...

Right. Actually if we add encoded_len, adding encoded_fmt is tempting

    const char *encoded_fmt =3D is_special ? "=3D%02X"    : "%c";

and then encoding part simplifies to just unconditional

    for (i =3D 0; i < chrlen; i++)
            strbuf_addf(sb, encoded_fmt, p[i]);
    line_len +=3D encoded_len;


> You may also want to say what the hardcoded "2" is about in the
> comment there.

ok.


> > diff --git a/utf8.c b/utf8.c
> > index 8f6e84b..7911b58 100644
> > --- a/utf8.c
> > +++ b/utf8.c
> > @@ -531,3 +531,42 @@ char *reencode_string(const char *in, const ch=
ar *out_encoding, const char *in_e
> >  	return out;
> >  }
> >  #endif
> > +
> > +/*
> > + * Returns first character length in bytes for multi-byte `text` a=
ccording to
> > + * `encoding`.
> > + *
> > + * - The `text` pointer is updated to point at the next character.
> > + * - When `remainder_p` is not NULL, on entry `*remainder_p` is ho=
w much bytes
> > + *   we can consume from text, and on exit `*remainder_p` is reduc=
ed by returned
> > + *   character length. Otherwise `text` is treated as limited by N=
UL.
> > + */
> > +int mbs_chrlen(const char **text, size_t *remainder_p, const char =
*encoding)
> > +{
> > +	int chrlen;
> > +	const char *p =3D *text;
> > +	size_t r =3D (remainder_p ? *remainder_p : INT_MAX);
>=20
> Ugly, and more importantly I suspect this is wrong because size_t is
> not signed and INT_MAX is.

Why is it ugly? There is similiar snippet in pick_one_utf8_char():

        /*
         * A caller that assumes NUL terminated text can choose
         * not to bother with the remainder length.  We will
         * stop at the first NUL.
         */=20
        remainder =3D (remainder_p ? *remainder_p : 999);

only ad-hoc 999 is used there.

I agree about INT_MAX being signed - my mistake - better change it to
SIZE_MAX or ((size_t)-1) for portability, but otherwise the construct i=
s
imho ok. I'll change to SIZE_MAX since it is alredy used in Git.

Computing r in the beginning simplifies following code.

> > +	if (r < 1)
> > +		return 0;
> > +
> > +	if (is_encoding_utf8(encoding)) {
> > +		pick_one_utf8_char(&p, &r);
> > +
> > +		chrlen =3D p ? (p - *text)
> > +			   : 1 /* not valid UTF-8 -> raw byte sequence */;
> > +	}
> > +	else {
> > +		/* TODO use iconv to decode one char and obtain its chrlen
> > +		 *
> > +		 * for now, let's treat encodings !=3D UTF-8 as one-byte
> > +		 */
> > +		chrlen =3D 1;
>=20
> 	/*
>          * We format our multi-line
>          * comments like this
>          */

ok, I agree.


> Thanks.

Thanks too,
Kirill


Interdiff and updated patch follows:

diff -u b/pretty.c b/pretty.c
--- b/pretty.c
+++ b/pretty.c
@@ -369,4 +369,8 @@
 		int is_special =3D (chrlen > 1) || is_rfc2047_special(*p, type);
=20
+		/* "=3D%02X" * chrlen, or the byte itself */
+		const char *encoded_fmt =3D is_special ? "=3D%02X"    : "%c";
+		int	    encoded_len =3D is_special ? 3 * chrlen : 1;
+
 		/*
 		 * According to RFC 2047, we could encode the special character
@@ -376,20 +380,15 @@
 		 * causes ' ' to be encoded as '=3D20', avoiding this problem.
 		 */
=20
-		if (line_len + 2 + (is_special ? 3*chrlen : 1) > max_encoded_length)=
 {
+		if (line_len + encoded_len + /* ?=3D */2 > max_encoded_length) {
+			/* It will not fit---break the line */
 			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
 			line_len =3D strlen(encoding) + 5 + 1; /* =3D??q? plus SP */
 		}
=20
-		if (is_special) {
-			for (i =3D 0; i < chrlen; i++) {
-				strbuf_addf(sb, "=3D%02X", p[i]);
-				line_len +=3D 3;
-			}
-		} else {
-			strbuf_addch(sb, *p);
-			line_len++;
-		}
+		for (i =3D 0; i < chrlen; i++)
+			strbuf_addf(sb, encoded_fmt, p[i]);
+		line_len +=3D encoded_len;
 	}
 	strbuf_addstr(sb, "?=3D");
 }
diff -u b/utf8.c b/utf8.c
--- b/utf8.c
+++ b/utf8.c
@@ -545,7 +545,7 @@
 {
 	int chrlen;
 	const char *p =3D *text;
-	size_t r =3D (remainder_p ? *remainder_p : INT_MAX);
+	size_t r =3D (remainder_p ? *remainder_p : SIZE_MAX);
=20
 	if (r < 1)
 		return 0;
@@ -557,8 +557,8 @@
 			   : 1 /* not valid UTF-8 -> raw byte sequence */;
 	}
 	else {
-		/* TODO use iconv to decode one char and obtain its chrlen
-		 *
+		/*
+		 * TODO use iconv to decode one char and obtain its chrlen
 		 * for now, let's treat encodings !=3D UTF-8 as one-byte
 		 */
 		chrlen =3D 1;

---- 8< ----
=46rom 46b9cddc63c07cb5513cfbf6d20aaaa98c66bcdf Mon Sep 17 00:00:00 200=
1
=46rom: Kirill Smelkov <kirr@mns.spb.ru>
Date: Wed, 6 Mar 2013 14:28:46 +0400
Subject: [PATCH v2] format-patch: RFC 2047 says multi-octet character m=
ay not be split

Even though an earlier attempt (bafc478..41dd00bad) cleaned
up RFC 2047 encoding, pretty.c::add_rfc2047() still decides
where to split the output line by going through the input
one byte at a time, and potentially splits a character in
the middle.  A subject line may end up showing like this:

     ".... f=F6?? bar".   (instead of  ".... f=F6=F6 bar".)

if split incorrectly.

RFC 2047, section 5 (3) explicitly forbids such beaviour

    Each 'encoded-word' MUST represent an integral number of
    characters.  A multi-octet character may not be split across
    adjacent 'encoded- word's.

that means that e.g. for

    Subject: .... f=F6=F6 bar

encoding

    Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
     =3D?UTF-8?q?=3D20bar?=3D

is correct, and

    Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3?=3D      <-- NOTE =F6=
 is broken here
     =3D?UTF-8?q?=3DB6=3D20bar?=3D

is not, because "=F6" character UTF-8 encoding C3 B6 is split here acro=
ss
adjacent encoded words.

To fix the problem, make the loop grab one _character_ at a time and
determine its output length to see where to break the output line.  Not=
e
that this version only knows about UTF-8, but the logic to grab one
character is abstracted out in mbs_chrlen() function to make it possibl=
e
to extend it to other encodings with the help of iconv in the future.

(With help from Junio C Hamano <gitster@pobox.com>)
Cc: Jan H. Sch=F6nherr <schnhrr@cs.tu-berlin.de>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 pretty.c                | 34 ++++++++++++++++++++++------------
 t/t4014-format-patch.sh | 27 ++++++++++++++-------------
 utf8.c                  | 39 +++++++++++++++++++++++++++++++++++++++
 utf8.h                  |  2 ++
 4 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/pretty.c b/pretty.c
index b57adef..c5fae69 100644
--- a/pretty.c
+++ b/pretty.c
@@ -345,7 +345,7 @@ static int needs_rfc2047_encoding(const char *line,=
 int len,
 	return 0;
 }
=20
-static void add_rfc2047(struct strbuf *sb, const char *line, int len,
+static void add_rfc2047(struct strbuf *sb, const char *line, size_t le=
n,
 		       const char *encoding, enum rfc2047_type type)
 {
 	static const int max_encoded_length =3D 76; /* per rfc2047 */
@@ -355,9 +355,22 @@ static void add_rfc2047(struct strbuf *sb, const c=
har *line, int len,
 	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=3D?%s?q?", encoding);
 	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
-	for (i =3D 0; i < len; i++) {
-		unsigned ch =3D line[i] & 0xFF;
-		int is_special =3D is_rfc2047_special(ch, type);
+
+	while (len) {
+		/*
+		 * RFC 2047, section 5 (3):
+		 *
+		 * Each 'encoded-word' MUST represent an integral number of
+		 * characters.  A multi-octet character may not be split across
+		 * adjacent 'encoded- word's.
+		 */
+		const unsigned char *p =3D (const unsigned char *)line;
+		int chrlen =3D mbs_chrlen(&line, &len, encoding);
+		int is_special =3D (chrlen > 1) || is_rfc2047_special(*p, type);
+
+		/* "=3D%02X" * chrlen, or the byte itself */
+		const char *encoded_fmt =3D is_special ? "=3D%02X"    : "%c";
+		int	    encoded_len =3D is_special ? 3 * chrlen : 1;
=20
 		/*
 		 * According to RFC 2047, we could encode the special character
@@ -367,18 +380,15 @@ static void add_rfc2047(struct strbuf *sb, const =
char *line, int len,
 		 * causes ' ' to be encoded as '=3D20', avoiding this problem.
 		 */
=20
-		if (line_len + 2 + (is_special ? 3 : 1) > max_encoded_length) {
+		if (line_len + encoded_len + /* ?=3D */2 > max_encoded_length) {
+			/* It will not fit---break the line */
 			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
 			line_len =3D strlen(encoding) + 5 + 1; /* =3D??q? plus SP */
 		}
=20
-		if (is_special) {
-			strbuf_addf(sb, "=3D%02X", ch);
-			line_len +=3D 3;
-		} else {
-			strbuf_addch(sb, ch);
-			line_len++;
-		}
+		for (i =3D 0; i < chrlen; i++)
+			strbuf_addf(sb, encoded_fmt, p[i]);
+		line_len +=3D encoded_len;
 	}
 	strbuf_addstr(sb, "?=3D");
 }
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 78633cb..b993dae 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -837,25 +837,26 @@ Subject: [PATCH] =3D?UTF-8?q?f=3DC3=3DB6=3DC3=3DB=
6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar?=3D
 EOF
 test_expect_success 'format-patch wraps extremely long subject (rfc204=
7)' '
 	rm -rf patches/ &&
diff --git a/utf8.c b/utf8.c
index 8f6e84b..7f64857 100644
--- a/utf8.c
+++ b/utf8.c
@@ -531,3 +531,42 @@ char *reencode_string(const char *in, const char *=
out_encoding, const char *in_e
 	return out;
 }
 #endif
+
+/*
+ * Returns first character length in bytes for multi-byte `text` accor=
ding to
+ * `encoding`.
+ *
+ * - The `text` pointer is updated to point at the next character.
+ * - When `remainder_p` is not NULL, on entry `*remainder_p` is how mu=
ch bytes
+ *   we can consume from text, and on exit `*remainder_p` is reduced b=
y returned
+ *   character length. Otherwise `text` is treated as limited by NUL.
+ */
+int mbs_chrlen(const char **text, size_t *remainder_p, const char *enc=
oding)
+{
+	int chrlen;
+	const char *p =3D *text;
+	size_t r =3D (remainder_p ? *remainder_p : SIZE_MAX);
+
+	if (r < 1)
+		return 0;
+
+	if (is_encoding_utf8(encoding)) {
+		pick_one_utf8_char(&p, &r);
+
+		chrlen =3D p ? (p - *text)
+			   : 1 /* not valid UTF-8 -> raw byte sequence */;
+	}
+	else {
+		/*
+		 * TODO use iconv to decode one char and obtain its chrlen
+		 * for now, let's treat encodings !=3D UTF-8 as one-byte
+		 */
+		chrlen =3D 1;
+	}
+
+	*text +=3D chrlen;
+	if (remainder_p)
+		*remainder_p -=3D chrlen;
+
+	return chrlen;
+}
diff --git a/utf8.h b/utf8.h
index 501b2bd..1f8ecad 100644
--- a/utf8.h
+++ b/utf8.h
@@ -22,4 +22,6 @@ char *reencode_string(const char *in, const char *out=
_encoding, const char *in_e
 #define reencode_string(a,b,c) NULL
 #endif
=20
+int mbs_chrlen(const char **text, size_t *remainder_p, const char *enc=
oding);
+
 #endif
--=20
1.8.2.rc2.353.gd2380b4
