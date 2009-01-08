From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline
	'Subject:' header
Date: Fri, 9 Jan 2009 02:11:35 +0300
Organization: St.Petersburg State University
Message-ID: <20090108231135.GB4185@roro3>
References: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090108100813.GA15640@myhost> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <7vy6xm42l3.fsf@gitster.siamese.dyndns.org> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 00:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL42X-0000cG-Pn
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 00:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945AbZAHXKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 18:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZAHXKZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 18:10:25 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:2090 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbZAHXKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 18:10:23 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 49B6417B65E; Fri,  9 Jan 2009 02:10:20 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LL42J-0003s2-SH; Fri, 09 Jan 2009 02:11:35 +0300
Content-Disposition: inline
In-Reply-To: <20090108100813.GA15640@myhost> <7vy6xm42l3.fsf@gitster.siamese.dyndns.org> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104964>

On Thu, Jan 08, 2009 at 12:13:42AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
>=20
> > On Fri, Dec 26, 2008 at 09:38:41PM +0300, Kirill Smelkov wrote:
> >> When native language (RU) is in use, subject header usually contai=
ns several
> >> parts, e.g.
> > ...
> > Junio, All,
> >
> > What about this patch?
>=20
> What's most interesting is that I do not recall seeing this patch bef=
ore.
> Neither gmane (which is my back-up interface to the mailing list) nor=
 my
> mailbox seems to have a copy, and from the look of quoted parts (name=
ly,
> some Russian strings in the message), it is not implausible that my s=
pam
> filter (either on my receiving end or at the ISP) may have eaten it.
>=20
> > It at least exposes bug in git-mailinfo wrt handling of multiline
> > subjects, and in very details documents it and adds a test for it.
> >
> > ..., but may I try to attract git
> > community attention one more time?
>=20
> It is very appreciated.

Thanks!


On Thu, Jan 08, 2009 at 12:35:52AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> > ...
> >> http://marc.info/?l=3Dgit&m=3D123031899307286&w=3D2
> >
> > I have not had chance to look at your patch at marc yet, but from t=
he look
> > of your problem description, I presume you could trigger this with =
any
> > utf-8 b-encoded loooooong subject line?
>=20
> Ok, I took a look at it after downloading from the marc archive.
>=20
> > diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> > index e890f7a..d138bc3 100644
> > --- a/builtin-mailinfo.c
> > +++ b/builtin-mailinfo.c
> > @@ -436,6 +436,14 @@ static struct strbuf *decode_b_segment(const s=
truct strbuf *b_seg)
> >  			 * for now we just trust the data.
> >  			 */
> >  			c =3D 0;
> > +
> > +			/* XXX: the following is needed not to output NUL in
> > +			 * the resulting string
> > +			 *
> > +			 * This seems to be ok, but I'm not 100% sure -- that's
> > +			 * why this is an RFC.
> > +			 */
> > +			continue;
> >  		}
> >  		else
> >  			continue; /* garbage */
>=20
> B encoding (RFC 2045) encodes an octet stream into a sequence of grou=
ps of
> 4 letters from 64-char alphabet, each of which encodes 6-bit, plus ze=
ro or
> more padding char '=3D' to make the result multiple of 4.
>=20
>  * If the length of the payload is a multiple of 3 octets, there is n=
o
>    special handling.  Padding char '=3D' is not produced;
>=20
>  * If it is a multiple of 3 octets plus one, the remaining one octet =
is
>    encoded with two letters, and two more padding char '=3D' is added=
;
>=20
>  * If it is a multiple of 3 octets plus two, the remaining two octets=
 are
>    encoded with three letters, and one padding char '=3D' is added.
>=20
> Hence, a "correct" implementation should decode the input as if '=3D'=
 were
> the same as 'A' (which encodes 6 bits of 0) til the end, making sure =
that
> the padding char '=3D' appears only at the end of the input, that no =
char
> outside the Base64 encoding alphabet appears in the input, and that t=
he
> length of the entire encoded string is multiple of 4.  Finally it wou=
ld
> discard either one or two octets (depending on the number of padding =
chars
> it saw) from the end of the output.
>=20
> Our decode_b_segment() however emits each octet as it completes, with=
out
> waiting for the 24-bit group that contains it to complete.  When deco=
ding
> a correctly encoded input, by the time we see a padding '=3D', all th=
e real
> payload octets are complete and we would not have any real informatio=
n
> still kept in the variable "acc" (accumulator), so ignoring '=3D' (yo=
u do
> not even need to assign c =3D 0) like your patch did would work just =
fine.
> An alternative would be to count the number of padding at the end and=
 drop
> the NULs from the output as necessary after the loop but that does no=
t add
> any value to the current code.
>=20
> Ideally we should validate the encoded string a bit more carefully (s=
ee
> the "correct" implementation about), and warn if a malformed input is
> found (but probably not reject outright).  But as a low-impact fix fo=
r the
> maintenance branches, I think your fix is very good.
>=20
> 	Side note: I suspect that the existing code was Ok before strbuf
> 	conversion as we assumed NUL terminated output buffer.

Junio, thanks for the explanation.

I've updated the patch and included your analysis into description.

> > @@ -513,7 +521,15 @@ static int decode_header_bq(struct strbuf *it)
> >  		strbuf_reset(&piecebuf);
> >  		rfc2047 =3D 1;
> > =20
> > -		if (in !=3D ep) {
> > +		/* XXX: the follwoing is needed not to output '\n' on every
> > +		 * multi-line segment in Subject.
> > +		 *
> > +		 * I suspect this is not 100% correct, but I'm not a MIME guy
> > +		 * -- that's why this is an RFC.
> > +		 */
> > +
> > +		/* if in does not end with '=3D?=3D', we emit it as is */
> > +		if (in <=3D (ep-2) && !(ep[-1]=3D=3D'\n' && ep[-2]=3D=3D'=3D')) =
{
> >  			strbuf_add(&outbuf, in, ep - in);
> >  			in =3D ep;
> >=20
> >  		}
>=20
> I am not a MIME guy either (and mailinfo has a big comment that says =
we do
> not really do MIME --- we just pretend to do), but let me give it a t=
ry.
>=20
> RFC2046 specifies that an encoded-word ("=3D?charset?encoding?...?=3D=
") may
> not be more than 75 characters long, and multiple encoded-words, sepa=
rated
> by CRLF SPACE can be used to encode more text if needed.
>=20
> It further specifies that an encoded-word can appear next to ordinary=
 text
> or another encoded-word but it must be separated by linear white spac=
e,
> and says that such linear white space is to be ignored when displayin=
g.
>=20
> Which means that we should be eating the CRLF SPACE we see if we have=
 seen
> an encoded-word immediately before and we are about to process anothe=
r
> encoded-word.
>=20
> Based on the above discussion, here is what I came up with.  It passe=
s
> your test, but I ran out of energy to try breaking it seriously in an=
y
> other way than just running the existing test suite. =20

Thanks again very much!

I was once maintaining software, and I think I understand what you mean
by saying 'ran out of energy', so I'll try to do my best to help improv=
e
this patch and to get it merged.

> We might want to steal some test cases from the "8. Examples" section=
 of
> RFC2047 and add them to t5100.

Good idea. I took all the examples and incorporated them into our
testsuite.

>=20
> Thanks.
>=20
>  builtin-mailinfo.c |   27 +++++++++++++++++++--------
>  1 files changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git c/builtin-mailinfo.c w/builtin-mailinfo.c
> index e890f7a..fcb32c9 100644
> --- c/builtin-mailinfo.c
> +++ w/builtin-mailinfo.c
> @@ -430,13 +430,6 @@ static struct strbuf *decode_b_segment(const str=
uct strbuf *b_seg)
>  			c -=3D 'a' - 26;
>  		else if ('0' <=3D c && c <=3D '9')
>  			c -=3D '0' - 52;
> -		else if (c =3D=3D '=3D') {
> -			/* padding is almost like (c =3D=3D 0), except we do
> -			 * not output NUL resulting only from it;
> -			 * for now we just trust the data.
> -			 */
> -			c =3D 0;
> -		}
>  		else
>  			continue; /* garbage */
>  		switch (pos++) {
> @@ -514,7 +507,25 @@ static int decode_header_bq(struct strbuf *it)
>  		rfc2047 =3D 1;
> =20
>  		if (in !=3D ep) {
> -			strbuf_add(&outbuf, in, ep - in);
> +			/*
> +			 * We are about to process an encoded-word
> +			 * that begins at ep, but there is something
> +			 * before the encoded word.
> +			 */
> +			char *scan;
> +			for (scan =3D in; scan < ep; scan++)
> +				if (!isspace(*scan))
> +					break;
> +
> +			if (scan !=3D ep || in =3D=3D it->buf) {
> +				/*
> +				 * We should not lose that "something",
> +				 * unless we have just processed an
> +				 * encoded-word, and there is only LWS
> +				 * before the one we are about to process.
> +				 */
> +				strbuf_add(&outbuf, in, ep - in);
> +			}
>  			in =3D ep;
>  		}
>  		/* E.g.

Based on the above description the code looks good now. I've
incorporated it into the patch and added tests from RFC2047 (see patch
below).

On Thu, Jan 08, 2009 at 01:08:13PM +0300, Alexander Potashev wrote:
> On 21:38 Fri 26 Dec     , Kirill Smelkov wrote:
> > When native language (RU) is in use, subject header usually contain=
s several
> > parts, e.g.
> >=20
> > Subject: [Navy-patches] [PATCH]
> > 	=3D?utf-8?b?0JjQt9C80LXQvdGR0L0g0YHQv9C40YHQvtC6INC/0LA=3D?=3D
> > 	=3D?utf-8?b?0LrQtdGC0L7QsiDQvdC10L7QsdGF0L7QtNC40LzRi9GFINC00LvRjy=
A=3D?=3D
> > 	=3D?utf-8?b?0YHQsdC+0YDQutC4?=3D
> >=20
>=20
> >  t/t5100/info0012    |    5 ++++
> >  t/t5100/msg0012     |    7 ++++++
> >  t/t5100/patch0012   |   30 +++++++++++++++++++++++++++++
> >  t/t5100/sample.mbox |   52 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  6 files changed, 112 insertions(+), 2 deletions(-)
>=20
> The testcases are too long, a minimal mbox with encoded "Subject:" wo=
uld
> be enough to test the mailinfo parser, it's all the you need to test
> here.

Thanks Alexander for pointing this out.

I've based my testcase on already-in-there tests, which e.g. for
t/t5100/{info,msg,patch}00{04,05,09,10,11} are of approximately the sam=
e
size and are based on real mails.

Is this ok?


As to new RFC2047-examples based tests, I've tried to keep them to the
bare minimum.


Changes since v1:

 o incorporated Junio's description and code about padding
 o incorporated Junio's description and code about LWS between encoded
   words
 o incorporated tests from RFC2047 examples  (one testresult is unclear
   -- see patch description)


=46rom: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: mailinfo: correctly handle multiline 'Subject:' header

When native language (RU) is in use, subject header usually contains se=
veral
parts, e.g.

Subject: [Navy-patches] [PATCH]
	=3D?utf-8?b?0JjQt9C80LXQvdGR0L0g0YHQv9C40YHQvtC6INC/0LA=3D?=3D
	=3D?utf-8?b?0LrQtdGC0L7QsiDQvdC10L7QsdGF0L7QtNC40LzRi9GFINC00LvRjyA=3D=
?=3D
	=3D?utf-8?b?0YHQsdC+0YDQutC4?=3D

( which btw should be extracted by git-mailinfo to:

    'Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=
=B8=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=
=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=
=D1=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8' )

This exposes several bugs in builtin-mailinfo.c which we try to fix:

1. decode_b_segment: do not append explicit NUL -- explicit NUL was pre=
venting
   correct header construction on parts concatenation via strbuf_addbuf=
 in
   decode_header_bq. Fixes:

-Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
+Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0

Junio:

> B encoding (RFC 2045) encodes an octet stream into a sequence of grou=
ps of
> 4 letters from 64-char alphabet, each of which encodes 6-bit, plus ze=
ro or
> more padding char '=3D' to make the result multiple of 4.
>
>  * If the length of the payload is a multiple of 3 octets, there is n=
o
>    special handling.  Padding char '=3D' is not produced;
>
>  * If it is a multiple of 3 octets plus one, the remaining one octet =
is
>    encoded with two letters, and two more padding char '=3D' is added=
;
>
>  * If it is a multiple of 3 octets plus two, the remaining two octets=
 are
>    encoded with three letters, and one padding char '=3D' is added.
>
> Hence, a "correct" implementation should decode the input as if '=3D'=
 were
> the same as 'A' (which encodes 6 bits of 0) til the end, making sure =
that
> the padding char '=3D' appears only at the end of the input, that no =
char
> outside the Base64 encoding alphabet appears in the input, and that t=
he
> length of the entire encoded string is multiple of 4.  Finally it wou=
ld
> discard either one or two octets (depending on the number of padding =
chars
> it saw) from the end of the output.
>
> Our decode_b_segment() however emits each octet as it completes, with=
out
> waiting for the 24-bit group that contains it to complete.  When deco=
ding
> a correctly encoded input, by the time we see a padding '=3D', all th=
e real
> payload octets are complete and we would not have any real informatio=
n
> still kept in the variable "acc" (accumulator), so ignoring '=3D' (yo=
u do
> not even need to assign c =3D 0) like your patch did would work just =
fine.
> An alternative would be to count the number of padding at the end and=
 drop
> the NULs from the output as necessary after the loop but that does no=
t add
> any value to the current code.
>
> Ideally we should validate the encoded string a bit more carefully (s=
ee
> the "correct" implementation about), and warn if a malformed input is
> found (but probably not reject outright).  But as a low-impact fix fo=
r the
> maintenance branches, I think your fix is very good.
>
> 	Side note: I suspect that the existing code was Ok before strbuf
> 	conversion as we assumed NUL terminated output buffer.


Then

2. whitespaces between encoded words should be removed

-Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
+Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0 =D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8

Junio:

> I am not a MIME guy either (and mailinfo has a big comment that says =
we do
> not really do MIME --- we just pretend to do), but let me give it a t=
ry.
>
> RFC2046 specifies that an encoded-word ("=3D?charset?encoding?...?=3D=
") may
> not be more than 75 characters long, and multiple encoded-words, sepa=
rated
> by CRLF SPACE can be used to encode more text if needed.
>
> It further specifies that an encoded-word can appear next to ordinary=
 text
> or another encoded-word but it must be separated by linear white spac=
e,
> and says that such linear white space is to be ignored when displayin=
g.
>
> Which means that we should be eating the CRLF SPACE we see if we have=
 seen
> an encoded-word immediately before and we are about to process anothe=
r
> encoded-word.

Also as suggested by Junio, in order to try to catch other MIME problem=
s test
cases from the "8. Examples" section of RFC2047 are added to t5100 test=
suite as
well.

    [but I'm not sure whether testresult with Nathaniel Borenstein
     (=D7=9D=D7=95=D7=9C=D7=A9 =D7=9F=D7=91 =D7=99=D7=9C=D7=98=D7=A4=D7=
=A0) is correct -- see rfc2047-info-0004]

Big-thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

---
 builtin-mailinfo.c           |   27 +++++++++++++++------
 t/t5100-mailinfo.sh          |   24 ++++++++++++++++++-
 t/t5100/info0012             |    5 ++++
 t/t5100/msg0012              |    7 +++++
 t/t5100/patch0012            |   30 ++++++++++++++++++++++++
 t/t5100/rfc2047-info-0001    |    4 +++
 t/t5100/rfc2047-info-0002    |    4 +++
 t/t5100/rfc2047-info-0003    |    4 +++
 t/t5100/rfc2047-info-0004    |    5 ++++
 t/t5100/rfc2047-info-0005    |    2 +
 t/t5100/rfc2047-info-0006    |    2 +
 t/t5100/rfc2047-info-0007    |    2 +
 t/t5100/rfc2047-info-0008    |    2 +
 t/t5100/rfc2047-info-0009    |    2 +
 t/t5100/rfc2047-info-0010    |    2 +
 t/t5100/rfc2047-info-0011    |    2 +
 t/t5100/rfc2047-samples.mbox |   48 ++++++++++++++++++++++++++++++++++=
++++
 t/t5100/sample.mbox          |   52 ++++++++++++++++++++++++++++++++++=
++++++++
 18 files changed, 215 insertions(+), 9 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index f7c8c08..77a7121 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -430,13 +430,6 @@ static struct strbuf *decode_b_segment(const struc=
t strbuf *b_seg)
 			c -=3D 'a' - 26;
 		else if ('0' <=3D c && c <=3D '9')
 			c -=3D '0' - 52;
-		else if (c =3D=3D '=3D') {
-			/* padding is almost like (c =3D=3D 0), except we do
-			 * not output NUL resulting only from it;
-			 * for now we just trust the data.
-			 */
-			c =3D 0;
-		}
 		else
 			continue; /* garbage */
 		switch (pos++) {
@@ -514,7 +507,25 @@ static int decode_header_bq(struct strbuf *it)
 		rfc2047 =3D 1;
=20
 		if (in !=3D ep) {
-			strbuf_add(&outbuf, in, ep - in);
+			/*
+			 * We are about to process an encoded-word
+			 * that begins at ep, but there is something
+			 * before the encoded word.
+			 */
+			char *scan;
+			for (scan =3D in; scan < ep; scan++)
+				if (!isspace(*scan))
+					break;
+
+			if (scan !=3D ep || in =3D=3D it->buf) {
+				/*
+				 * We should not lose that "something",
+				 * unless we have just processed an
+				 * encoded-word, and there is only LWS
+				 * before the one we are about to process.
+				 */
+				strbuf_add(&outbuf, in, ep - in);
+			}
 			in =3D ep;
 		}
 		/* E.g.
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index fe14589..625c204 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=3D`cat last` &&
 	echo total is $last &&
-	test `cat last` =3D 11'
+	test `cat last` =3D 12'
=20
 for mail in `echo 00*`
 do
@@ -26,6 +26,28 @@ do
 	'
 done
=20
+
+test_expect_success 'split box with rfc2047 samples' \
+	'mkdir rfc2047 &&
+	git mailsplit -orfc2047 "$TEST_DIRECTORY"/t5100/rfc2047-samples.mbox =
\
+	  >rfc2047/last &&
+	last=3D`cat rfc2047/last` &&
+	echo total is $last &&
+	test `cat rfc2047/last` =3D 11'
+
+for mail in `echo rfc2047/00*`
+do
+	test_expect_success "mailinfo $mail" '
+		git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+		echo msg &&
+		test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+		echo patch &&
+		test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+		echo info &&
+		test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $mai=
l-info
+	'
+done
+
 test_expect_success 'respect NULs' '
=20
 	git mailsplit -d3 -o. "$TEST_DIRECTORY"/t5100/nul-plain &&
diff --git a/t/t5100/empty b/t/t5100/empty
new file mode 100644
index 0000000..e69de29
diff --git a/t/t5100/info0012 b/t/t5100/info0012
new file mode 100644
index 0000000..ac1216f
--- /dev/null
+++ b/t/t5100/info0012
@@ -0,0 +1,5 @@
+Author: Dmitriy Blinov
+Email: bda@mnsspb.ru
+Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
+Date: Wed, 12 Nov 2008 17:54:41 +0300
+
diff --git a/t/t5100/msg0012 b/t/t5100/msg0012
new file mode 100644
index 0000000..1dc2bf7
--- /dev/null
+++ b/t/t5100/msg0012
@@ -0,0 +1,7 @@
+textlive-* =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D1=8B=
 =D0=BD=D0=B0 texlive-*
+docutils =D0=B7=D0=B0=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D0=BD=D0=B0 pytho=
n-docutils
+
+=D0=94=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=
=D0=BE, =D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BB=D0=BE=D1=81=D1=8C, =D1=87=D1=
=82=D0=BE rest2web =D0=B2=D1=8B=D1=82=D1=8F=D0=B3=D0=B8=D0=B2=D0=B0=D0=B5=
=D1=82 =D0=B7=D0=B0 =D1=81=D0=BE=D0=B1=D0=BE=D0=B9
+python-docutils. =D0=92 =D1=82=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=
=BA=D0=B0=D0=BA =D1=81=D0=B0=D0=BC rest2web =D0=BD=D0=B5 =D0=BD=D1=83=D0=
=B6=D0=B5=D0=BD.
+
+Signed-off-by: Dmitriy Blinov <bda@mnsspb.ru>
diff --git a/t/t5100/patch0012 b/t/t5100/patch0012
new file mode 100644
index 0000000..36a0b68
--- /dev/null
+++ b/t/t5100/patch0012
@@ -0,0 +1,30 @@
+---
+ howto/build_navy.txt |    6 +++---
+ 1 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/howto/build_navy.txt b/howto/build_navy.txt
+index 3fd3afb..0ee807e 100644
+--- a/howto/build_navy.txt
++++ b/howto/build_navy.txt
+@@ -119,8 +119,8 @@
+    - libxv-dev
+    - libusplash-dev
+    - latex-make
+-   - textlive-lang-cyrillic
+-   - textlive-latex-extra
++   - texlive-lang-cyrillic
++   - texlive-latex-extra
+    - dia
+    - python-pyrex
+    - libtool
+@@ -128,7 +128,7 @@
+    - sox
+    - cython
+    - imagemagick
+-   - docutils
++   - python-docutils
+=20
+ #. =D0=BD=D0=B0 =D0=BC=D0=B0=D1=88=D0=B8=D0=BD=D0=B5 dinar: =D0=B4=D0=
=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BE=
=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8B=D0=B9 ssh-=D0=BA=D0=BB=D1=8E=D1=87=
 =D0=B2 authorized_keys2 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D1=82=D0=B5=D0=BB=D1=8F ddev
+ #. =D0=BD=D0=B0 =D1=81=D0=B2=D0=BE=D0=B5=D0=B9 =D0=BC=D0=B0=D1=88=D0=B8=
=D0=BD=D0=B5: =D0=BE=D1=82=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=
=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C /etc/sudoers (=D0=BA=D0=BE=D0=BC=D0=B0=
=D0=BD=D0=B4=D0=B0 ``visudo``) =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80=D0=BD=
=D0=BE =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=BC =D0=BE=D0=
=B1=D1=80=D0=B0=D0=B7=D0=BE=D0=BC::
+--=20
+1.5.6.5
diff --git a/t/t5100/rfc2047-info-0001 b/t/t5100/rfc2047-info-0001
new file mode 100644
index 0000000..0a383b0
--- /dev/null
+++ b/t/t5100/rfc2047-info-0001
@@ -0,0 +1,4 @@
+Author: Keith Moore
+Email: moore@cs.utk.edu
+Subject: If you can read this you understand the example.
+
diff --git a/t/t5100/rfc2047-info-0002 b/t/t5100/rfc2047-info-0002
new file mode 100644
index 0000000..881be75
--- /dev/null
+++ b/t/t5100/rfc2047-info-0002
@@ -0,0 +1,4 @@
+Author: Olle J=C3=A4rnefors
+Email: ojarnef@admin.kth.se
+Subject: Time for ISO 10646?
+
diff --git a/t/t5100/rfc2047-info-0003 b/t/t5100/rfc2047-info-0003
new file mode 100644
index 0000000..d0f7891
--- /dev/null
+++ b/t/t5100/rfc2047-info-0003
@@ -0,0 +1,4 @@
+Author: Patrik F=C3=A4ltstr=C3=B6m
+Email: paf@nada.kth.se
+Subject: RFC-HDR care and feeding
+
diff --git a/t/t5100/rfc2047-info-0004 b/t/t5100/rfc2047-info-0004
new file mode 100644
index 0000000..850f831
--- /dev/null
+++ b/t/t5100/rfc2047-info-0004
@@ -0,0 +1,5 @@
+Author: Nathaniel Borenstein =20
+     (=D7=9D=D7=95=D7=9C=D7=A9 =D7=9F=D7=91 =D7=99=D7=9C=D7=98=D7=A4=D7=
=A0)
+Email: nsb@thumper.bellcore.com
+Subject: Test of new header generator
+
diff --git a/t/t5100/rfc2047-info-0005 b/t/t5100/rfc2047-info-0005
new file mode 100644
index 0000000..c27be3b
--- /dev/null
+++ b/t/t5100/rfc2047-info-0005
@@ -0,0 +1,2 @@
+Subject: (a)
+
diff --git a/t/t5100/rfc2047-info-0006 b/t/t5100/rfc2047-info-0006
new file mode 100644
index 0000000..9dad474
--- /dev/null
+++ b/t/t5100/rfc2047-info-0006
@@ -0,0 +1,2 @@
+Subject: (a b)
+
diff --git a/t/t5100/rfc2047-info-0007 b/t/t5100/rfc2047-info-0007
new file mode 100644
index 0000000..294f195
--- /dev/null
+++ b/t/t5100/rfc2047-info-0007
@@ -0,0 +1,2 @@
+Subject: (ab)
+
diff --git a/t/t5100/rfc2047-info-0008 b/t/t5100/rfc2047-info-0008
new file mode 100644
index 0000000..294f195
--- /dev/null
+++ b/t/t5100/rfc2047-info-0008
@@ -0,0 +1,2 @@
+Subject: (ab)
+
diff --git a/t/t5100/rfc2047-info-0009 b/t/t5100/rfc2047-info-0009
new file mode 100644
index 0000000..294f195
--- /dev/null
+++ b/t/t5100/rfc2047-info-0009
@@ -0,0 +1,2 @@
+Subject: (ab)
+
diff --git a/t/t5100/rfc2047-info-0010 b/t/t5100/rfc2047-info-0010
new file mode 100644
index 0000000..9dad474
--- /dev/null
+++ b/t/t5100/rfc2047-info-0010
@@ -0,0 +1,2 @@
+Subject: (a b)
+
diff --git a/t/t5100/rfc2047-info-0011 b/t/t5100/rfc2047-info-0011
new file mode 100644
index 0000000..9dad474
--- /dev/null
+++ b/t/t5100/rfc2047-info-0011
@@ -0,0 +1,2 @@
+Subject: (a b)
+
diff --git a/t/t5100/rfc2047-samples.mbox b/t/t5100/rfc2047-samples.mbo=
x
new file mode 100644
index 0000000..3ca2470
--- /dev/null
+++ b/t/t5100/rfc2047-samples.mbox
@@ -0,0 +1,48 @@
+From nobody Mon Sep 17 00:00:00 2001
+From: =3D?US-ASCII?Q?Keith_Moore?=3D <moore@cs.utk.edu>
+To: =3D?ISO-8859-1?Q?Keld_J=3DF8rn_Simonsen?=3D <keld@dkuug.dk>
+CC: =3D?ISO-8859-1?Q?Andr=3DE9?=3D Pirard <PIRARD@vm1.ulg.ac.be>
+Subject: =3D?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=3D?=3D
+ =3D?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg=3D=3D?=3D
+
+From nobody Mon Sep 17 00:00:00 2001
+From: =3D?ISO-8859-1?Q?Olle_J=3DE4rnefors?=3D <ojarnef@admin.kth.se>
+To: ietf-822@dimacs.rutgers.edu, ojarnef@admin.kth.se
+Subject: Time for ISO 10646?
+
+From nobody Mon Sep 17 00:00:00 2001
+To: Dave Crocker <dcrocker@mordor.stanford.edu>
+Cc: ietf-822@dimacs.rutgers.edu, paf@comsol.se
+From: =3D?ISO-8859-1?Q?Patrik_F=3DE4ltstr=3DF6m?=3D <paf@nada.kth.se>
+Subject: Re: RFC-HDR care and feeding
+
+From nobody Mon Sep 17 00:00:00 2001
+From: Nathaniel Borenstein <nsb@thumper.bellcore.com>
+      (=3D?iso-8859-8?b?7eXs+SDv4SDp7Oj08A=3D=3D?=3D)
+To: Greg Vaudreuil <gvaudre@NRI.Reston.VA.US>, Ned Freed
+   <ned@innosoft.com>, Keith Moore <moore@cs.utk.edu>
+Subject: Test of new header generator
+MIME-Version: 1.0
+Content-type: text/plain; charset=3DISO-8859-1
+
+From nobody Mon Sep 17 00:00:00 2001
+Subject: (=3D?ISO-8859-1?Q?a?=3D)
+
+From nobody Mon Sep 17 00:00:00 2001
+Subject: (=3D?ISO-8859-1?Q?a?=3D b)
+
+From nobody Mon Sep 17 00:00:00 2001
+Subject: (=3D?ISO-8859-1?Q?a?=3D =3D?ISO-8859-1?Q?b?=3D)
+
+From nobody Mon Sep 17 00:00:00 2001
+Subject: (=3D?ISO-8859-1?Q?a?=3D  =3D?ISO-8859-1?Q?b?=3D)
+
+From nobody Mon Sep 17 00:00:00 2001
+Subject: (=3D?ISO-8859-1?Q?a?=3D
+    =3D?ISO-8859-1?Q?b?=3D)
+
+From nobody Mon Sep 17 00:00:00 2001
+Subject: (=3D?ISO-8859-1?Q?a_b?=3D)
+
+From nobody Mon Sep 17 00:00:00 2001
+Subject: (=3D?ISO-8859-1?Q?a?=3D =3D?ISO-8859-2?Q?_b?=3D)
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 4bf7947..94da4da 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -501,3 +501,55 @@ index 3e5fe51..aabfe5c 100644
=20
 --=3D-=3D-=3D--
=20
+From bda@mnsspb.ru Wed Nov 12 17:54:41 2008
+From: Dmitriy Blinov <bda@mnsspb.ru>
+To: navy-patches@dinar.mns.mnsspb.ru
+Date: Wed, 12 Nov 2008 17:54:41 +0300
+Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
+X-Mailer: git-send-email 1.5.6.5
+MIME-Version: 1.0
+Content-Type: text/plain;
+  charset=3Dutf-8
+Content-Transfer-Encoding: 8bit
+Subject: [Navy-patches] [PATCH]
+	=3D?utf-8?b?0JjQt9C80LXQvdGR0L0g0YHQv9C40YHQvtC6INC/0LA=3D?=3D
+	=3D?utf-8?b?0LrQtdGC0L7QsiDQvdC10L7QsdGF0L7QtNC40LzRi9GFINC00LvRjyA=3D=
?=3D
+	=3D?utf-8?b?0YHQsdC+0YDQutC4?=3D
+
+textlive-* =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D1=8B=
 =D0=BD=D0=B0 texlive-*
+docutils =D0=B7=D0=B0=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D0=BD=D0=B0 pytho=
n-docutils
+
+=D0=94=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=
=D0=BE, =D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BB=D0=BE=D1=81=D1=8C, =D1=87=D1=
=82=D0=BE rest2web =D0=B2=D1=8B=D1=82=D1=8F=D0=B3=D0=B8=D0=B2=D0=B0=D0=B5=
=D1=82 =D0=B7=D0=B0 =D1=81=D0=BE=D0=B1=D0=BE=D0=B9
+python-docutils. =D0=92 =D1=82=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=
=BA=D0=B0=D0=BA =D1=81=D0=B0=D0=BC rest2web =D0=BD=D0=B5 =D0=BD=D1=83=D0=
=B6=D0=B5=D0=BD.
+
+Signed-off-by: Dmitriy Blinov <bda@mnsspb.ru>
+---
+ howto/build_navy.txt |    6 +++---
+ 1 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/howto/build_navy.txt b/howto/build_navy.txt
+index 3fd3afb..0ee807e 100644
+--- a/howto/build_navy.txt
++++ b/howto/build_navy.txt
+@@ -119,8 +119,8 @@
+    - libxv-dev
+    - libusplash-dev
+    - latex-make
+-   - textlive-lang-cyrillic
+-   - textlive-latex-extra
++   - texlive-lang-cyrillic
++   - texlive-latex-extra
+    - dia
+    - python-pyrex
+    - libtool
+@@ -128,7 +128,7 @@
+    - sox
+    - cython
+    - imagemagick
+-   - docutils
++   - python-docutils
+=20
+ #. =D0=BD=D0=B0 =D0=BC=D0=B0=D1=88=D0=B8=D0=BD=D0=B5 dinar: =D0=B4=D0=
=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BE=
=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8B=D0=B9 ssh-=D0=BA=D0=BB=D1=8E=D1=87=
 =D0=B2 authorized_keys2 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D1=82=D0=B5=D0=BB=D1=8F ddev
+ #. =D0=BD=D0=B0 =D1=81=D0=B2=D0=BE=D0=B5=D0=B9 =D0=BC=D0=B0=D1=88=D0=B8=
=D0=BD=D0=B5: =D0=BE=D1=82=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=
=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C /etc/sudoers (=D0=BA=D0=BE=D0=BC=D0=B0=
=D0=BD=D0=B4=D0=B0 ``visudo``) =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80=D0=BD=
=D0=BE =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=BC =D0=BE=D0=
=B1=D1=80=D0=B0=D0=B7=D0=BE=D0=BC::
+--=20
+1.5.6.5
--=20
tg: (c123b7c..) t/mailinfo-multiline-subject (depends on: master)

Thanks,
Kirill
