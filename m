From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] log --format: document %w
Date: Mon, 23 Nov 2009 00:46:34 +0100
Message-ID: <4B09CD5A.4070401@lsrfire.ath.cx>
References: <4B0963A3.4060804@lsrfire.ath.cx> <7vzl6eiiyx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 00:46:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCM8i-0001Zz-Au
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 00:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbZKVXqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 18:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755790AbZKVXqc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 18:46:32 -0500
Received: from india601.server4you.de ([85.25.151.105]:49539 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbZKVXqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 18:46:32 -0500
Received: from [10.0.1.101] (p57B7C097.dip.t-dialin.net [87.183.192.151])
	by india601.server4you.de (Postfix) with ESMTPSA id 1A0022F8051;
	Mon, 23 Nov 2009 00:46:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vzl6eiiyx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133465>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> I'm not especially proud of the triple negative in that note.  How t=
o say it
>> better, yet concise?
>> +- '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w opti=
on of
>> +  linkgit:git-shortlog[1].  NOTE: Color placeholders (`%C*`) are no=
t
>> +  recognized as having no width, so they should not be put into wra=
pped
>> +  sections.
>=20
> "The code miscounts the width of '%C*' color placeholders"?
>=20
> Perhaps somebody in the codepath leading to pick_one_utf8_char() in u=
tf8.c
> can be made aware of them?
>=20
> utf8_width() is called from many places (has one caller outside utf8.=
c as
> well).  It is given a pointer to a pointer that points at the current
> position in a string, and is responsible for picking up one logical l=
etter
> advancing the given pointer to skip over that letter, and returning t=
he
> display width of that one letter.  The function wants the string to b=
e
> encoded in utf-8 and signals by putting NULL in the pointer when it
> detects the input string is not.
>=20
> Picking up one logical letter is done by pick_one_utf8_char(), which =
is a
> nicely written generic "We are at the character boundary of a potenti=
ally
> multi-byte utf-8 string; pick the first character" implementation, an=
d we
> wouldn't want to contaminate that with escape sequence logic---we mig=
ht
> want to reuse it in other codepaths where we have no reason to expect=
 any
> escape sequences.
>=20
> So perhaps we can introduce is_esc_sequence(s, r, w) that
>=20
>  - returns true if we are at the beginning of an esc-sequence;
>  - skips the sequence just like utf8_width() does with s and r; and
>  - counts the width of the sequence and returns it in *w
>=20
> The implementation of the is_esc_sequence() could be to only detect t=
he
> color sequence (if the sequence has things like cursor-position contr=
ol
> then we are already lost, as calling "utf8_width()" on such a string =
does
> not make much sense anyway) and report zero-width.
>=20
> I dunno.
>=20
> diff --git a/utf8.c b/utf8.c
> index 5c18f0c..d45e75f 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -241,7 +241,12 @@ invalid:
>   */
>  int utf8_width(const char **start, size_t *remainder_p)
>  {
> -	ucs_char_t ch =3D pick_one_utf8_char(start, remainder_p);
> +	ucs_char_t ch;
> +	int w;
> +
> +	if (is_esc_sequence(start, remainder_p, &w))
> +		return w;
> +	ch =3D pick_one_utf8_char(start, remainder_p);
>  	if (!*start)
>  		return 0;
>  	return git_wcwidth(ch);

I think utf8_width() is too generic for that; we shouldn't teach it ter=
minal
control details.  Something like this?  It keeps it all local to
strbuf_add_wrapped_text(); ignoring display mode escape codes in there =
can be
justified with its purpose.

 utf8.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/utf8.c b/utf8.c
index 5c18f0c..fcc0aeb 100644
--- a/utf8.c
+++ b/utf8.c
@@ -298,6 +298,21 @@ static void print_spaces(struct strbuf *buf, int c=
ount)
 	strbuf_write(buf, s, count);
 }
=20
+/* XXX: this handles display mode sequences, only.  Do we need more? *=
/
+static size_t esc_sequence_len(const char *s)
+{
+	const char *p =3D s;
+	if (*p++ !=3D '\033')
+		return 0;
+	if (*p++ !=3D '[')
+		return 0;
+	while (isdigit(*p) || *p =3D=3D ';')
+		p++;
+	if (*p++ !=3D 'm')
+		return 0;
+	return p - s;
+}
+
 /*
  * Wrap the text, if necessary. The variable indent is the indent for =
the
  * first line, indent2 is the indent for all other lines.
@@ -329,7 +344,13 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 	}
=20
 	for (;;) {
-		char c =3D *text;
+		char c;
+		size_t skip;
+
+		while ((skip =3D esc_sequence_len(text)))
+			text +=3D skip;
+
+		c =3D *text;
 		if (!c || isspace(c)) {
 			if (w < width || !space) {
 				const char *start =3D bol;
