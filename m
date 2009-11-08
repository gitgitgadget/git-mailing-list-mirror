From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/3] Generalized "string function" syntax
Date: Sun, 08 Nov 2009 02:02:20 +0100
Message-ID: <4AF6189C.9050500@lsrfire.ath.cx>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <4ADA3153.7070606@lsrfire.ath.cx> <7v63ad5o8p.fsf@alter.siamese.dyndns.org> <4ADAD0D2.504@lsrfire.ath.cx> <7vr5t0nwu8.fsf@alter.siamese.dyndns.org> <4ADCF117.2030905@lsrfire.ath.cx> <7vd44jx9at.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 02:02:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6wAv-0001Wq-HT
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 02:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZKHBC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 20:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZKHBC0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 20:02:26 -0500
Received: from india601.server4you.de ([85.25.151.105]:49838 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZKHBCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 20:02:25 -0500
Received: from [10.0.1.101] (p57B7DAAC.dip.t-dialin.net [87.183.218.172])
	by india601.server4you.de (Postfix) with ESMTPSA id 6728F2F807C;
	Sun,  8 Nov 2009 02:02:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vd44jx9at.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132380>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>> I'm more in favour of adding ways to customize the shape of the elem=
ents
>> rather than adding string functions.  %S(width=3D76,indent=3D4) over
>> %[wrap(76,4)%s%].
>=20
> Yeah, %X(some modifier) that can apply to any 'X' looks much simpler =
and
> easier to look at.  The way the code is structured currently it might=
 be
> more work and risk to break things, though.

Here's something along this line.  It's an experiment that tries to
explore named parameters and extending individual place holders instead=
 of
adding a generic modifier (%w).

The patch implements a way to pass named parameters to %s and %b.  Thos=
e
parameters are width, indent1 and indent2, which are then passed to
strbuf_add_wrapped_text() to indent and wrap the subject or body text,
respectively.

Handling wrapping for the individual place holders avoids having to dea=
l
with terminal colour codes.  The patch that implements %w() currently i=
n
next ignores this issue.

It also allows to avoid copying the results around -- no temporary strb=
uf
is needed for %b().  However, quick tests showed no measurable performa=
nce
improvement.

While indent1 and indent2 are numerical parameters in this patch, they
really should be strings, in order to allow indenting using tabs etc..
=46or that to work, strbuf_add_wrapped_text() would need to be changed
first, though.

The parser parse_params() supports strings and numerical values, but on=
ly
the latter are used in this patch.  String parameters are intended to b=
e
fed to unquote_c_style().  It never complains about syntax errors.  It
aborts if the string ends prematurely, but otherwise ignores invalid in=
put
and just keeps going.  That's how the % place holder parser has always
worked, but perhaps the introduction of named parameters justifies a mo=
re
strict approach?


My main motivation for this experiment was to avoid extra copies in the
hope to speed things up.  However, my basic timing tests show that it's
not that much of an improvement.

The remaining reason is the handling of colour codes.  I think we can k=
eep
ignoring this issue -- the only impact is that lines with colour codes =
and
wrapping combined (e.g. "%w(72)%Cred%s") shorter than they should be,
because the colour code is considered (incorrectly) to have a non-zero
width.  I think we can get away with mentioning that fact in the docs.
After all, one can simple use "%Cred%w(72)%s".

Anyway, here's the patch.


 pretty.c |  154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index da15cf2..09272ec 100644
--- a/pretty.c
+++ b/pretty.c
@@ -596,6 +596,117 @@ static void format_decoration(struct strbuf *sb, =
const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
=20
+struct param {
+	const char *name;
+	long *numeric_value;
+	const char *value;
+	size_t value_len;
+};
+
+static size_t prefixlen(const char *s, const char *prefix)
+{
+	size_t len =3D 0;
+
+	while (*prefix) {
+		if (*s !=3D *prefix)
+			return 0;
+		s++;
+		prefix++;
+		len++;
+	}
+	return len;
+}
+
+static size_t parse_params(const char *s, struct param *params, int co=
unt,
+			   int end)
+{
+	const char *start =3D s;
+	int i;
+
+	for (;;) {
+		while (isspace(*s))
+			s++;
+again:
+		if (*s =3D=3D end)
+			return s - start + 1;
+		if (*s =3D=3D '\0')
+			return 0;
+
+		for (i =3D 0; i < count; i++) {
+			size_t len =3D prefixlen(s, params[i].name);
+			if (len) {
+				if (s[len] =3D=3D end)
+					return s - start + 1;
+				if (s[len] =3D=3D '\0')
+					return 0;
+				if (isspace(s[len])) {
+					s +=3D len + 1;
+					while (isspace(*s))
+						s++;
+					if (*s !=3D '=3D')
+						goto again;
+					s++;
+					break;
+				} else if (s[len] =3D=3D '=3D') {
+					s +=3D len + 1;
+					break;
+				}
+			}
+		}
+
+		if (i < count) {
+			while (isspace(*s))
+				s++;
+			if (*s =3D=3D end)
+				return s - start + 1;
+			if (*s =3D=3D '\0')
+				return 0;
+
+			params[i].value =3D s;
+			if (*s =3D=3D '"') {
+				for (;;) {
+					int quoted =3D 0;
+					const char *q;
+
+					s =3D strchr(s + 1, '"');
+					if (!s)
+						return 0;
+
+					for (q =3D s - 1; *q =3D=3D '\\'; q--)
+						quoted =3D !quoted;
+					if (!quoted)
+						break;
+				}
+				s++;
+			} else {
+				char *endp;
+				long num =3D strtol(s, &endp, 10);
+
+				s =3D endp;
+				if (isspace(*s) || *s =3D=3D end) {
+					if (params[i].numeric_value)
+						*params[i].numeric_value =3D num;
+				} else {
+					while (!isspace(*s) && *s !=3D end) {
+						if (*s =3D=3D '\0')
+							return 0;
+						s++;
+					}
+				}
+			}
+			params[i].value_len =3D s - params[i].value;
+		} else {
+			while (!isspace(*s)) {
+				if (*s =3D=3D end)
+					return s - start + 1;
+				if (*s =3D=3D '\0')
+					return 0;
+				s++;
+			}
+		}
+	}
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
                                void *context)
 {
@@ -744,14 +855,49 @@ static size_t format_commit_item(struct strbuf *s=
b, const char *placeholder,
=20
 	switch (placeholder[0]) {
 	case 's':	/* subject */
-		format_subject(sb, msg + c->subject_off, " ");
-		return 1;
+		if (placeholder[1] =3D=3D '(') {
+			struct strbuf subject =3D STRBUF_INIT;
+			long indent1 =3D 0, indent2 =3D 0, width =3D 0;
+			struct param params[] =3D {
+				{ "indent1", &indent1 },
+				{ "indent2", &indent2 },
+				{ "width", &width },
+			};
+			size_t consumed =3D parse_params(placeholder + 2, params,
+						       ARRAY_SIZE(params), ')');
+			if (!consumed)
+				return 0;
+			format_subject(&subject, msg + c->subject_off, " ");
+			strbuf_add_wrapped_text(sb, subject.buf, indent1,
+						indent2, width);
+			strbuf_release(&subject);
+			return consumed + 2;
+		} else {
+			format_subject(sb, msg + c->subject_off, " ");
+			return 1;
+		}
 	case 'f':	/* sanitized subject */
 		format_sanitized_subject(sb, msg + c->subject_off);
 		return 1;
 	case 'b':	/* body */
-		strbuf_addstr(sb, msg + c->body_off);
-		return 1;
+		if (placeholder[1] =3D=3D '(') {
+			long indent1 =3D 0, indent2 =3D 0, width =3D 0;
+			struct param params[] =3D {
+				{ "indent1", &indent1 },
+				{ "indent2", &indent2 },
+				{ "width", &width },
+			};
+			size_t consumed =3D parse_params(placeholder + 2, params,
+						       ARRAY_SIZE(params), ')');
+			if (!consumed)
+				return 0;
+			strbuf_add_wrapped_text(sb, msg + c->body_off, indent1,
+						indent2, width);
+			return consumed + 2;
+		} else {
+			strbuf_addstr(sb, msg + c->body_off);
+			return 1;
+		}
 	}
 	return 0;	/* unknown placeholder */
 }
