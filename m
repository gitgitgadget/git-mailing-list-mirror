From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Avoid a useless prefix lookup in strbuf_expand()
Date: Thu, 03 Jan 2008 01:45:17 +0100
Message-ID: <477C301D.7060509@lsrfire.ath.cx>
References: <e5bfff550712300546o167c460bl4628d87f8a4e14db@mail.gmail.com>	 <477BD3B4.2070708@lsrfire.ath.cx> <e5bfff550801021027i6d6a399cob96ae3c840661884@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:46:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAEDi-0006si-FT
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 01:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYACApi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 19:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbYACApi
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 19:45:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:58806 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbYACApf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 19:45:35 -0500
Received: from [10.0.1.201] (p57B7FA27.dip.t-dialin.net [87.183.250.39])
	by india601.server4you.de (Postfix) with ESMTP id D6EBD2F81DA;
	Thu,  3 Jan 2008 01:45:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550801021027i6d6a399cob96ae3c840661884@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69503>

Marco Costalba schrieb:
> If we go on complex stuff then we can bite the bullet and use a text
> matcher state machine, but again, I still think that the best way is
> to avoid the 99% unusless loop and use only a (slightly) beefed up
> switch case instead.
>=20
> I would think you agree with me that searching if a string is found i=
n
> a string vector then pass the _same_ string to another function that
> (practically) redoes *the same* check using a switch statement is not
> the best optimization one can think about.

The loop makes implementing the callback function a bit easier, since
you don't need to cover all cases; the input is already checked by
strbuf_expand().

Anyway, here's your patch again with a few small changes: the
placeholders array is gone as you suggested, the cases for %Cx, %ax and
%cx are check for unknown placeholders and the callback function return=
s
the number of bytes it consumed as size_t.

All in all: less code, slightly more complex callback functions (needs
to return the length of the consumed placeholder or 0 if the input
doesn't match a placeholder) and increased speed.  I have to admit that
I start to like it. :-)

I tried to cover all cases of valid and invalid input; did I miss any?

Ren=C3=A9


 pretty.c |  143 ++++++++++++++++++++++++++----------------------------=
--------
 strbuf.c |   19 ++++-----
 strbuf.h |    4 +-
 3 files changed, 70 insertions(+), 96 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5b1078b..c0e9c8a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -282,8 +282,8 @@ static char *logmsg_reencode(const struct commit *c=
ommit,
 	return out;
 }
=20
-static void format_person_part(struct strbuf *sb, char part,
-                               const char *msg, int len)
+static size_t format_person_part(struct strbuf *sb, char part,
+                                 const char *msg, int len)
 {
 	int start, end, tz =3D 0;
 	unsigned long date;
@@ -297,36 +297,36 @@ static void format_person_part(struct strbuf *sb,=
 char part,
 		end--;
 	if (part =3D=3D 'n') {	/* name */
 		strbuf_add(sb, msg, end);
-		return;
+		return 1;
 	}
=20
 	if (start >=3D len)
-		return;
+		return 1;
=20
 	/* parse email */
 	for (end =3D start + 1; end < len && msg[end] !=3D '>'; end++)
 		; /* do nothing */
=20
 	if (end >=3D len)
-		return;
+		return 1;
=20
 	if (part =3D=3D 'e') {	/* email */
 		strbuf_add(sb, msg + start, end - start);
-		return;
+		return 1;
 	}
=20
 	/* parse date */
 	for (start =3D end + 1; start < len && isspace(msg[start]); start++)
 		; /* do nothing */
 	if (start >=3D len)
-		return;
+		return 1;
 	date =3D strtoul(msg + start, &ep, 10);
 	if (msg + start =3D=3D ep)
-		return;
+		return 1;
=20
 	if (part =3D=3D 't') {	/* date, UNIX timestamp */
 		strbuf_add(sb, msg + start, ep - (msg + start));
-		return;
+		return 1;
 	}
=20
 	/* parse tz */
@@ -341,17 +341,19 @@ static void format_person_part(struct strbuf *sb,=
 char part,
 	switch (part) {
 	case 'd':	/* date */
 		strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
-		return;
+		return 1;
 	case 'D':	/* date, RFC2822 style */
 		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
-		return;
+		return 1;
 	case 'r':	/* date, relative */
 		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
-		return;
+		return 1;
 	case 'i':	/* date, ISO 8601 */
 		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
-		return;
+		return 1;
 	}
+
+	return 0;	/* unknown person part */
 }
=20
 struct chunk {
@@ -432,8 +434,8 @@ static void parse_commit_header(struct format_commi=
t_context *context)
 	context->commit_header_parsed =3D 1;
 }
=20
-static void format_commit_item(struct strbuf *sb, const char *placehol=
der,
-                               void *context)
+static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
+                                 void *context)
 {
 	struct format_commit_context *c =3D context;
 	const struct commit *commit =3D c->commit;
@@ -443,23 +445,23 @@ static void format_commit_item(struct strbuf *sb,=
 const char *placeholder,
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
-		switch (placeholder[3]) {
-		case 'd':	/* red */
+		if (!prefixcmp(placeholder + 1, "red")) {
 			strbuf_addstr(sb, "\033[31m");
-			return;
-		case 'e':	/* green */
+			return 4;
+		} else if (!prefixcmp(placeholder + 1, "green")) {
 			strbuf_addstr(sb, "\033[32m");
-			return;
-		case 'u':	/* blue */
+			return 6;
+		} else if (!prefixcmp(placeholder + 1, "blue")) {
 			strbuf_addstr(sb, "\033[34m");
-			return;
-		case 's':	/* reset color */
+			return 5;
+		} else if (!prefixcmp(placeholder + 1, "reset")) {
 			strbuf_addstr(sb, "\033[m");
-			return;
-		}
+			return 6;
+		} else
+			return 0;
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
-		return;
+		return 1;
 	}
=20
 	/* these depend on the commit */
@@ -469,34 +471,34 @@ static void format_commit_item(struct strbuf *sb,=
 const char *placeholder,
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
-		return;
+		return 1;
 	case 'h':		/* abbreviated commit hash */
 		if (add_again(sb, &c->abbrev_commit_hash))
-			return;
+			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
 		                                     DEFAULT_ABBREV));
 		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
-		return;
+		return 1;
 	case 'T':		/* tree hash */
 		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
-		return;
+		return 1;
 	case 't':		/* abbreviated tree hash */
 		if (add_again(sb, &c->abbrev_tree_hash))
-			return;
+			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
 		                                     DEFAULT_ABBREV));
 		c->abbrev_tree_hash.len =3D sb->len - c->abbrev_tree_hash.off;
-		return;
+		return 1;
 	case 'P':		/* parent hashes */
 		for (p =3D commit->parents; p; p =3D p->next) {
 			if (p !=3D commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
 		}
-		return;
+		return 1;
 	case 'p':		/* abbreviated parent hashes */
 		if (add_again(sb, &c->abbrev_parent_hashes))
-			return;
+			return 1;
 		for (p =3D commit->parents; p; p =3D p->next) {
 			if (p !=3D commit->parents)
 				strbuf_addch(sb, ' ');
@@ -505,14 +507,14 @@ static void format_commit_item(struct strbuf *sb,=
 const char *placeholder,
 		}
 		c->abbrev_parent_hashes.len =3D sb->len -
 		                              c->abbrev_parent_hashes.off;
-		return;
+		return 1;
 	case 'm':		/* left/right/bottom */
 		strbuf_addch(sb, (commit->object.flags & BOUNDARY)
 		                 ? '-'
 		                 : (commit->object.flags & SYMMETRIC_LEFT)
 		                 ? '<'
 		                 : '>');
-		return;
+		return 1;
 	}
=20
 	/* For the rest we have to parse the commit header. */
@@ -520,66 +522,41 @@ static void format_commit_item(struct strbuf *sb,=
 const char *placeholder,
 		parse_commit_header(c);
=20
 	switch (placeholder[0]) {
-	case 's':
+	case 's':		/* subject */
 		strbuf_add(sb, msg + c->subject.off, c->subject.len);
-		return;
-	case 'a':
-		format_person_part(sb, placeholder[1],
-		                   msg + c->author.off, c->author.len);
-		return;
-	case 'c':
-		format_person_part(sb, placeholder[1],
-		                   msg + c->committer.off, c->committer.len);
-		return;
-	case 'e':
+		return 1;
+	case 'a':		/* author ... */
+		if (format_person_part(sb, placeholder[1],
+		                       msg + c->author.off,
+		                       c->author.len))
+			return 2;
+		else
+			return 0;
+	case 'c':		/* committer ... */
+		if (format_person_part(sb, placeholder[1],
+		                       msg + c->committer.off,
+		                       c->committer.len))
+			return 2;
+		else
+			return 0;
+	case 'e':		/* encoding */
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
-		return;
-	case 'b':
+		return 1;
+	case 'b':		/* body */
 		strbuf_addstr(sb, msg + c->body_off);
-		return;
+		return 1;
 	}
+	return 0;		/* unknown placeholder */
 }
=20
 void format_commit_message(const struct commit *commit,
                            const void *format, struct strbuf *sb)
 {
-	const char *placeholders[] =3D {
-		"H",		/* commit hash */
-		"h",		/* abbreviated commit hash */
-		"T",		/* tree hash */
-		"t",		/* abbreviated tree hash */
-		"P",		/* parent hashes */
-		"p",		/* abbreviated parent hashes */
-		"an",		/* author name */
-		"ae",		/* author email */
-		"ad",		/* author date */
-		"aD",		/* author date, RFC2822 style */
-		"ar",		/* author date, relative */
-		"at",		/* author date, UNIX timestamp */
-		"ai",		/* author date, ISO 8601 */
-		"cn",		/* committer name */
-		"ce",		/* committer email */
-		"cd",		/* committer date */
-		"cD",		/* committer date, RFC2822 style */
-		"cr",		/* committer date, relative */
-		"ct",		/* committer date, UNIX timestamp */
-		"ci",		/* committer date, ISO 8601 */
-		"e",		/* encoding */
-		"s",		/* subject */
-		"b",		/* body */
-		"Cred",		/* red */
-		"Cgreen",	/* green */
-		"Cblue",	/* blue */
-		"Creset",	/* reset color */
-		"n",		/* newline */
-		"m",		/* left/right/bottom */
-		NULL
-	};
 	struct format_commit_context context;
=20
 	memset(&context, 0, sizeof(context));
 	context.commit =3D commit;
-	strbuf_expand(sb, format, placeholders, format_commit_item, &context)=
;
+	strbuf_expand(sb, format, format_commit_item, &context);
 }
=20
 static void pp_header(enum cmit_fmt fmt,
diff --git a/strbuf.c b/strbuf.c
index b9b194b..7bb087c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -137,11 +137,12 @@ void strbuf_addf(struct strbuf *sb, const char *f=
mt, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
=20
-void strbuf_expand(struct strbuf *sb, const char *format,
-                   const char **placeholders, expand_fn_t fn, void *co=
ntext)
+void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t =
fn,
+                   void *context)
 {
 	for (;;) {
-		const char *percent, **p;
+		const char *percent;
+		size_t consumed;
=20
 		percent =3D strchrnul(format, '%');
 		strbuf_add(sb, format, percent - format);
@@ -149,14 +150,10 @@ void strbuf_expand(struct strbuf *sb, const char =
*format,
 			break;
 		format =3D percent + 1;
=20
-		for (p =3D placeholders; *p; p++) {
-			if (!prefixcmp(format, *p))
-				break;
-		}
-		if (*p) {
-			fn(sb, *p, context);
-			format +=3D strlen(*p);
-		} else
+		consumed =3D fn(sb, format, context);
+		if (consumed)
+			format +=3D consumed;
+		else
 			strbuf_addch(sb, '%');
 	}
 }
diff --git a/strbuf.h b/strbuf.h
index 36d61db..faec229 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -103,8 +103,8 @@ static inline void strbuf_addbuf(struct strbuf *sb,=
 struct strbuf *sb2) {
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
=20
-typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeholde=
r, void *context);
-extern void strbuf_expand(struct strbuf *sb, const char *format, const=
 char **placeholders, expand_fn_t fn, void *context);
+typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placehol=
der, void *context);
+extern void strbuf_expand(struct strbuf *sb, const char *format, expan=
d_fn_t fn, void *context);
=20
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
