From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/5] pretty describe: add %ds, %dn, %dd placeholders
Date: Mon, 05 Nov 2007 02:20:25 +0100
Message-ID: <472E6FD9.7030603@lsrfire.ath.cx>
References: <472DB1B0.1050904@lsrfire.ath.cx> <Pine.LNX.4.64.0711041356330.4362@racer.site> <472DDA3B.4090100@lsrfire.ath.cx> <Pine.LNX.4.64.0711041518130.4362@racer.site> <472E010B.5070602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 02:21:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoqeE-0000Rz-E6
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 02:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbXKEBUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 20:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbXKEBUr
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 20:20:47 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:56234
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754192AbXKEBUq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 20:20:46 -0500
Received: from [10.0.1.201] (p57B7F8A7.dip.t-dialin.net [87.183.248.167])
	by neapel230.server4you.de (Postfix) with ESMTP id E2CC7873BA;
	Mon,  5 Nov 2007 02:20:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <472E010B.5070602@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63468>

Ren=E9 Scharfe schrieb:
> In any case, interpolate.c needs some attention, with or without my
> patch.  I agree that a native strbuf version would be nice.  How abou=
t
> an interface like that:
>=20
> 	typedef const char *(*expand_fn_t)
> 		(const char *placeholder, void *context);
> 	void strbuf_addexpand(struct strbuf *sb, const char *format,
> 	                      const char **placeholders,
> 	                      expand_fn_t fn, void *context);
>=20
> strbuf_addexpand() would call fn() when it recognizes a placeholder,
> avoiding unneeded setup code.  It could cache the result, so that fn(=
)
> gets called at most a single time for each given placeholder.  contex=
t
> would be passed through to fn(), e.g. a struct commit in case of
> format_commit_message().  Makes sense?

OK, for discussion, I've experimented a bit, and here's what I could
come up with.  This version doesn't do any caching.  Is it even needed?

Anyway, strbuf_expand() is really simple, and the callback is expected
to add it's output directly to the strbuf.  That means that the number
of strdups and memdupz is reduced significantly, speeding up the whole
thing.  Converting code to use strbuf_expand is easy, but not trivial
(i.e. not doable by a script).

Ren=E9


 commit.c |  275 ++++++++++++++++++++++++++++++++++--------------------=
-------
 strbuf.c |   22 +++++
 strbuf.h |    3 +
 3 files changed, 178 insertions(+), 122 deletions(-)

diff --git a/commit.c b/commit.c
index 8262f6a..4a47b0e 100644
--- a/commit.c
+++ b/commit.c
@@ -698,7 +698,8 @@ static char *logmsg_reencode(const struct commit *c=
ommit,
 	return out;
 }
=20
-static void fill_person(struct interp *table, const char *msg, int len=
)
+static void format_person_part(struct strbuf *sb, char part,
+                               const char *msg, int len)
 {
 	int start, end, tz =3D 0;
 	unsigned long date;
@@ -710,7 +711,10 @@ static void fill_person(struct interp *table, cons=
t char *msg, int len)
 	start =3D end + 1;
 	while (end > 0 && isspace(msg[end - 1]))
 		end--;
-	table[0].value =3D xmemdupz(msg, end);
+	if (part =3D=3D 'n') {	/* name */
+		strbuf_add(sb, msg, end);
+		return;
+	}
=20
 	if (start >=3D len)
 		return;
@@ -722,7 +726,10 @@ static void fill_person(struct interp *table, cons=
t char *msg, int len)
 	if (end >=3D len)
 		return;
=20
-	table[1].value =3D xmemdupz(msg + start, end - start);
+	if (part =3D=3D 'e') {	/* email */
+		strbuf_add(sb, msg + start, end - start);
+		return;
+	}
=20
 	/* parse date */
 	for (start =3D end + 1; start < len && isspace(msg[start]); start++)
@@ -733,7 +740,10 @@ static void fill_person(struct interp *table, cons=
t char *msg, int len)
 	if (msg + start =3D=3D ep)
 		return;
=20
-	table[5].value =3D xmemdupz(msg + start, ep - (msg + start));
+	if (part =3D=3D 't') {	/* date, UNIX timestamp */
+		strbuf_add(sb, msg + start, ep - (msg + start));
+		return;
+	}
=20
 	/* parse tz */
 	for (start =3D ep - msg + 1; start < len && isspace(msg[start]); star=
t++)
@@ -744,123 +754,107 @@ static void fill_person(struct interp *table, c=
onst char *msg, int len)
 			tz =3D -tz;
 	}
=20
-	interp_set_entry(table, 2, show_date(date, tz, DATE_NORMAL));
-	interp_set_entry(table, 3, show_date(date, tz, DATE_RFC2822));
-	interp_set_entry(table, 4, show_date(date, tz, DATE_RELATIVE));
-	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
+	switch (part) {
+	case 'd':	/* date */
+		strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
+		return;
+	case 'D':	/* date, RFC2822 style */
+		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
+		return;
+	case 'r':	/* date, relative */
+		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
+		return;
+	case 'i':	/* date, ISO 8601 */
+		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
+		return;
+	}
 }
=20
-void format_commit_message(const struct commit *commit,
-                           const void *format, struct strbuf *sb)
+static void format_commit_item(struct strbuf *sb, const char *placehol=
der,
+                               void *context)
 {
-	struct interp table[] =3D {
-		{ "%H" },	/* commit hash */
-		{ "%h" },	/* abbreviated commit hash */
-		{ "%T" },	/* tree hash */
-		{ "%t" },	/* abbreviated tree hash */
-		{ "%P" },	/* parent hashes */
-		{ "%p" },	/* abbreviated parent hashes */
-		{ "%an" },	/* author name */
-		{ "%ae" },	/* author email */
-		{ "%ad" },	/* author date */
-		{ "%aD" },	/* author date, RFC2822 style */
-		{ "%ar" },	/* author date, relative */
-		{ "%at" },	/* author date, UNIX timestamp */
-		{ "%ai" },	/* author date, ISO 8601 */
-		{ "%cn" },	/* committer name */
-		{ "%ce" },	/* committer email */
-		{ "%cd" },	/* committer date */
-		{ "%cD" },	/* committer date, RFC2822 style */
-		{ "%cr" },	/* committer date, relative */
-		{ "%ct" },	/* committer date, UNIX timestamp */
-		{ "%ci" },	/* committer date, ISO 8601 */
-		{ "%e" },	/* encoding */
-		{ "%s" },	/* subject */
-		{ "%b" },	/* body */
-		{ "%Cred" },	/* red */
-		{ "%Cgreen" },	/* green */
-		{ "%Cblue" },	/* blue */
-		{ "%Creset" },	/* reset color */
-		{ "%n" },	/* newline */
-		{ "%m" },	/* left/right/bottom */
-	};
-	enum interp_index {
-		IHASH =3D 0, IHASH_ABBREV,
-		ITREE, ITREE_ABBREV,
-		IPARENTS, IPARENTS_ABBREV,
-		IAUTHOR_NAME, IAUTHOR_EMAIL,
-		IAUTHOR_DATE, IAUTHOR_DATE_RFC2822, IAUTHOR_DATE_RELATIVE,
-		IAUTHOR_TIMESTAMP, IAUTHOR_ISO8601,
-		ICOMMITTER_NAME, ICOMMITTER_EMAIL,
-		ICOMMITTER_DATE, ICOMMITTER_DATE_RFC2822,
-		ICOMMITTER_DATE_RELATIVE, ICOMMITTER_TIMESTAMP,
-		ICOMMITTER_ISO8601,
-		IENCODING,
-		ISUBJECT,
-		IBODY,
-		IRED, IGREEN, IBLUE, IRESET_COLOR,
-		INEWLINE,
-		ILEFT_RIGHT,
-	};
+	struct commit *commit =3D context;
 	struct commit_list *p;
-	char parents[1024];
-	unsigned long len;
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
 	const char *msg =3D commit->buffer;
=20
-	if (ILEFT_RIGHT + 1 !=3D ARRAY_SIZE(table))
-		die("invalid interp table!");
-
 	/* these are independent of the commit */
-	interp_set_entry(table, IRED, "\033[31m");
-	interp_set_entry(table, IGREEN, "\033[32m");
-	interp_set_entry(table, IBLUE, "\033[34m");
-	interp_set_entry(table, IRESET_COLOR, "\033[m");
-	interp_set_entry(table, INEWLINE, "\n");
+	switch (placeholder[0]) {
+	case 'C':
+		switch (placeholder[3]) {
+		case 'd':	/* red */
+			strbuf_addstr(sb, "\033[31m");
+			return;
+		case 'e':	/* green */
+			strbuf_addstr(sb, "\033[32m");
+			return;
+		case 'u':	/* blue */
+			strbuf_addstr(sb, "\033[34m");
+			return;
+		case 's':	/* reset color */
+			strbuf_addstr(sb, "\033[m");
+			return;
+		}
+	case 'n':		/* newline */
+		strbuf_addch(sb, '\n');
+		return;
+	}
=20
 	/* these depend on the commit */
 	if (!commit->object.parsed)
 		parse_object(commit->object.sha1);
-	interp_set_entry(table, IHASH, sha1_to_hex(commit->object.sha1));
-	interp_set_entry(table, IHASH_ABBREV,
-			find_unique_abbrev(commit->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, ITREE, sha1_to_hex(commit->tree->object.sha1)=
);
-	interp_set_entry(table, ITREE_ABBREV,
-			find_unique_abbrev(commit->tree->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, ILEFT_RIGHT,
-			 (commit->object.flags & BOUNDARY)
-			 ? "-"
-			 : (commit->object.flags & SYMMETRIC_LEFT)
-			 ? "<"
-			 : ">");
-
-	parents[1] =3D 0;
-	for (i =3D 0, p =3D commit->parents;
-			p && i < sizeof(parents) - 1;
-			p =3D p->next)
-		i +=3D snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			sha1_to_hex(p->item->object.sha1));
-	interp_set_entry(table, IPARENTS, parents + 1);
-
-	parents[1] =3D 0;
-	for (i =3D 0, p =3D commit->parents;
-			p && i < sizeof(parents) - 1;
-			p =3D p->next)
-		i +=3D snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			find_unique_abbrev(p->item->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
=20
+	switch (placeholder[0]) {
+	case 'H':		/* commit hash */
+		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+		return;
+	case 'h':		/* abbreviated commit hash */
+		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
+		                                     DEFAULT_ABBREV));
+		return;
+	case 'T':		/* tree hash */
+		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
+		return;
+	case 't':		/* abbreviated tree hash */
+		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
+		                                     DEFAULT_ABBREV));
+		return;
+	case 'P':		/* parent hashes */
+		for (p =3D commit->parents; p; p =3D p->next) {
+			if (p !=3D commit->parents)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
+		}
+		return;
+	case 'p':		/* abbreviated parent hashes */
+		for (p =3D commit->parents; p; p =3D p->next) {
+			if (p !=3D commit->parents)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, find_unique_abbrev(
+					p->item->object.sha1, DEFAULT_ABBREV));
+		}
+		return;
+	case 'm':		/* left/right/bottom */
+		strbuf_addch(sb, (commit->object.flags & BOUNDARY)
+		                 ? '-'
+		                 : (commit->object.flags & SYMMETRIC_LEFT)
+		                 ? '<'
+		                 : '>');
+		return;
+	}
+
+	/* For the rest we have to parse the commit header. */
 	for (i =3D 0, state =3D HEADER; msg[i] && state < BODY; i++) {
 		int eol;
 		for (eol =3D i; msg[eol] && msg[eol] !=3D '\n'; eol++)
 			; /* do nothing */
=20
 		if (state =3D=3D SUBJECT) {
-			table[ISUBJECT].value =3D xmemdupz(msg + i, eol - i);
+			if (placeholder[0] =3D=3D 's') {
+				strbuf_add(sb, msg + i, eol - i);
+				return;
+			}
 			i =3D eol;
 		}
 		if (i =3D=3D eol) {
@@ -868,29 +862,66 @@ void format_commit_message(const struct commit *c=
ommit,
 			/* strip empty lines */
 			while (msg[eol + 1] =3D=3D '\n')
 				eol++;
-		} else if (!prefixcmp(msg + i, "author "))
-			fill_person(table + IAUTHOR_NAME,
-					msg + i + 7, eol - i - 7);
-		else if (!prefixcmp(msg + i, "committer "))
-			fill_person(table + ICOMMITTER_NAME,
-					msg + i + 10, eol - i - 10);
-		else if (!prefixcmp(msg + i, "encoding "))
-			table[IENCODING].value =3D
-				xmemdupz(msg + i + 9, eol - i - 9);
+		} else if (!prefixcmp(msg + i, "author ")) {
+			if (placeholder[0] =3D=3D 'a') {
+				format_person_part(sb, placeholder[1],
+				                   msg + i + 7, eol - i - 7);
+				return;
+			}
+		} else if (!prefixcmp(msg + i, "committer ")) {
+			if (placeholder[0] =3D=3D 'c') {
+				format_person_part(sb, placeholder[1],
+				                   msg + i + 10, eol - i - 10);
+				return;
+			}
+		} else if (!prefixcmp(msg + i, "encoding ")) {
+			if (placeholder[0] =3D=3D 'e') {
+				strbuf_add(sb, msg + i + 9, eol - i - 9);
+				return;
+			}
+		}
 		i =3D eol;
 	}
-	if (msg[i])
-		table[IBODY].value =3D xstrdup(msg + i);
-
-	len =3D interpolate(sb->buf + sb->len, strbuf_avail(sb),
-				format, table, ARRAY_SIZE(table));
-	if (len > strbuf_avail(sb)) {
-		strbuf_grow(sb, len);
-		interpolate(sb->buf + sb->len, strbuf_avail(sb) + 1,
-					format, table, ARRAY_SIZE(table));
-	}
-	strbuf_setlen(sb, sb->len + len);
-	interp_clear_table(table, ARRAY_SIZE(table));
+	if (msg[i] && placeholder[0] =3D=3D 'b')	/* body */
+		strbuf_addstr(sb, msg + i);
+}
+
+void format_commit_message(const struct commit *commit,
+                           const void *format, struct strbuf *sb)
+{
+	const char *placeholders[] =3D {
+		"H",		/* commit hash */
+		"h",		/* abbreviated commit hash */
+		"T",		/* tree hash */
+		"t",		/* abbreviated tree hash */
+		"P",		/* parent hashes */
+		"p",		/* abbreviated parent hashes */
+		"an",		/* author name */
+		"ae",		/* author email */
+		"ad",		/* author date */
+		"aD",		/* author date, RFC2822 style */
+		"ar",		/* author date, relative */
+		"at",		/* author date, UNIX timestamp */
+		"ai",		/* author date, ISO 8601 */
+		"cn",		/* committer name */
+		"ce",		/* committer email */
+		"cd",		/* committer date */
+		"cD",		/* committer date, RFC2822 style */
+		"cr",		/* committer date, relative */
+		"ct",		/* committer date, UNIX timestamp */
+		"ci",		/* committer date, ISO 8601 */
+		"e",		/* encoding */
+		"s",		/* subject */
+		"b",		/* body */
+		"Cred",		/* red */
+		"Cgreen",	/* green */
+		"Cblue",	/* blue */
+		"Creset",	/* reset color */
+		"n",		/* newline */
+		"m",		/* left/right/bottom */
+		NULL
+	};
+	strbuf_expand(sb, format, placeholders, format_commit_item, (void *)c=
ommit);
 }
=20
 static void pp_header(enum cmit_fmt fmt,
diff --git a/strbuf.c b/strbuf.c
index f4201e1..b71da99 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -129,6 +129,28 @@ void strbuf_addf(struct strbuf *sb, const char *fm=
t, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
=20
+void strbuf_expand(struct strbuf *sb, const char *fmt,
+                   const char **placeholders, expand_fn_t fn, void *co=
ntext)
+{
+	char c;
+	const char **p;
+
+	while ((c =3D *fmt++)) {
+		if (c !=3D '%') {
+			strbuf_addch(sb, c);
+			continue;
+		}
+
+		for (p =3D placeholders; *p; p++) {
+			if (!prefixcmp(fmt, *p)) {
+				fn(sb, *p, context);
+				fmt +=3D strlen(*p);
+				break;
+			}
+		}
+	}
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index 9b9e861..b9c3e79 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -102,6 +102,9 @@ static inline void strbuf_addbuf(struct strbuf *sb,=
 struct strbuf *sb2) {
 	strbuf_add(sb, sb2->buf, sb2->len);
 }
=20
+typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeholde=
r, void *context);
+extern void strbuf_expand(struct strbuf *sb, const char *fmt, const ch=
ar **placeholders, expand_fn_t fn, void *context);
+
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
=20
