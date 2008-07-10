From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH/RFC] git-mailinfo: use strbuf's instead of fixed buffers
Date: Fri, 11 Jul 2008 01:43:13 +0200
Organization: Chalmers
Message-ID: <48769E91.60205@etek.chalmers.se>
References: <4876820D.4070806@etek.chalmers.se> <7vod55o0tx.fsf@gitster.siamese.dyndns.org> <48768F30.8070409@etek.chalmers.se> <7v3amhnwy9.fsf@gitster.siamese.dyndns.org> <48769E40.8030303@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:44:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5oQ-00020M-4r
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbYGJXnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 19:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbYGJXnS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:43:18 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:55982 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbYGJXnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:43:16 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id 18C749D4C;
	Fri, 11 Jul 2008 01:43:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <48769E40.8030303@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88059>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 builtin-mailinfo.c |  705 +++++++++++++++++++++++++-------------------=
--------
 1 files changed, 333 insertions(+), 372 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2d1520f..254a97c 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -5,14 +5,15 @@
 #include "cache.h"
 #include "builtin.h"
 #include "utf8.h"
+#include "strbuf.h"
=20
 static FILE *cmitmsg, *patchfile, *fin, *fout;
=20
 static int keep_subject;
 static const char *metainfo_charset;
-static char line[1000];
-static char name[1000];
-static char email[1000];
+static struct strbuf line =3D STRBUF_INIT;
+static struct strbuf name =3D STRBUF_INIT;
+static struct strbuf email =3D STRBUF_INIT;
=20
 static enum  {
 	TE_DONTCARE, TE_QP, TE_BASE64,
@@ -21,74 +22,74 @@ static enum  {
 	TYPE_TEXT, TYPE_OTHER,
 } message_type;
=20
-static char charset[256];
+static struct strbuf charset =3D STRBUF_INIT;
 static int patch_lines;
-static char **p_hdr_data, **s_hdr_data;
+static struct strbuf **p_hdr_data, **s_hdr_data;
=20
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
=20
-static char *sanity_check(char *name, char *email)
+static void sanity_check(struct strbuf *out, struct strbuf *name, stru=
ct strbuf *email)
 {
-	int len =3D strlen(name);
-	if (len < 3 || len > 60)
-		return email;
-	if (strchr(name, '@') || strchr(name, '<') || strchr(name, '>'))
-		return email;
-	return name;
+	struct strbuf o =3D STRBUF_INIT;
+	if (name->len < 3 || name->len > 60)
+		strbuf_addbuf(&o, email);
+	if (strchr(name->buf, '@') || strchr(name->buf, '<') ||
+		strchr(name->buf, '>'))
+		strbuf_addbuf(&o, email);
+	strbuf_addbuf(&o, name);
+	strbuf_reset(out);
+	strbuf_addbuf(out, &o);
+	strbuf_release(&o);
 }
=20
-static int bogus_from(char *line)
+static int bogus_from(const struct strbuf *line)
 {
 	/* John Doe <johndoe> */
-	char *bra, *ket, *dst, *cp;
=20
+	char *bra, *ket;
 	/* This is fallback, so do not bother if we already have an
 	 * e-mail address.
 	 */
-	if (*email)
+	if (email.len)
 		return 0;
=20
-	bra =3D strchr(line, '<');
+	bra =3D strchr(line->buf, '<');
 	if (!bra)
 		return 0;
 	ket =3D strchr(bra, '>');
 	if (!ket)
 		return 0;
=20
-	for (dst =3D email, cp =3D bra+1; cp < ket; )
-		*dst++ =3D *cp++;
-	*dst =3D 0;
-	for (cp =3D line; isspace(*cp); cp++)
-		;
-	for (bra--; isspace(*bra); bra--)
-		*bra =3D 0;
-	cp =3D sanity_check(cp, email);
-	strcpy(name, cp);
+	strbuf_reset(&email);
+	strbuf_add(&email, bra + 1, ket - bra - 1);
+
+	strbuf_reset(&name);
+	strbuf_add(&name, line->buf, bra - line->buf);
+	strbuf_trim(&name);
+	sanity_check(&name, &name, &email);
 	return 1;
 }
=20
-static int handle_from(char *in_line)
+static int handle_from(struct strbuf *from)
 {
-	char line[1000];
 	char *at;
-	char *dst;
+	size_t el;
=20
-	strcpy(line, in_line);
-	at =3D strchr(line, '@');
+	at =3D strchr(from->buf, '@');
 	if (!at)
-		return bogus_from(line);
+		return bogus_from(from);
=20
 	/*
 	 * If we already have one email, don't take any confusing lines
 	 */
-	if (*email && strchr(at+1, '@'))
+	if (email.len && strchr(at + 1, '@'))
 		return 0;
=20
 	/* Pick up the string around '@', possibly delimited with <>
-	 * pair; that is the email part.  White them out while copying.
+	 * pair; that is the email part.
 	 */
-	while (at > line) {
+	while (at > from->buf) {
 		char c =3D at[-1];
 		if (isspace(c))
 			break;
@@ -98,56 +99,35 @@ static int handle_from(char *in_line)
 		}
 		at--;
 	}
-	dst =3D email;
-	for (;;) {
-		unsigned char c =3D *at;
-		if (!c || c =3D=3D '>' || isspace(c)) {
-			if (c =3D=3D '>')
-				*at =3D ' ';
-			break;
-		}
-		*at++ =3D ' ';
-		*dst++ =3D c;
-	}
-	*dst++ =3D 0;
-
+	el =3D strcspn(at, " \n\t\r\v\f>");
+	strbuf_reset(&email);
+	strbuf_add(&email, at, el);
+	strbuf_remove(from, at - from->buf, el + 1);
 	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
 	 * or "john.doe@xz (John Doe)", but we have whited out the
 	 * email part, so trim from both ends, possibly removing
 	 * the () pair at the end.
 	 */
-	at =3D line + strlen(line);
-	while (at > line) {
-		unsigned char c =3D *--at;
-		if (!isspace(c)) {
-			at[(c =3D=3D ')') ? 0 : 1] =3D 0;
-			break;
-		}
-	}
=20
-	at =3D line;
-	for (;;) {
-		unsigned char c =3D *at;
-		if (!c || !isspace(c)) {
-			if (c =3D=3D '(')
-				at++;
-			break;
-		}
-		at++;
-	}
-	at =3D sanity_check(at, email);
-	strcpy(name, at);
+	strbuf_trim(from);
+	if (*from->buf =3D=3D '(')
+		strbuf_remove(&name, 0, 1);
+	if (*(from->buf + from->len - 1) =3D=3D ')')
+		strbuf_setlen(from, from->len - 1);
+
+	sanity_check(&name, from, &email);
 	return 1;
 }
=20
-static int handle_header(char *line, char *data, int ofs)
+static void handle_header(struct strbuf **out, const struct strbuf *li=
ne)
 {
-	if (!line || !data)
-		return 1;
-
-	strcpy(data, line+ofs);
+	if (!*out) {
+		*out =3D xmalloc(sizeof(struct strbuf));
+		strbuf_init(*out, line->len);
+	} else
+		strbuf_reset(*out);
=20
-	return 0;
+	strbuf_addbuf(*out, (struct strbuf *)line); /* const warning */
 }
=20
 /* NOTE NOTE NOTE.  We do not claim we do full MIME.  We just attempt
@@ -156,13 +136,13 @@ static int handle_header(char *line, char *data, =
int ofs)
  * case insensitively.
  */
=20
-static int slurp_attr(const char *line, const char *name, char *attr)
+static int slurp_attr(const char *line, const char *name, struct strbu=
f *attr)
 {
 	const char *ends, *ap =3D strcasestr(line, name);
 	size_t sz;
=20
 	if (!ap) {
-		*attr =3D 0;
+		strbuf_setlen(attr, 0);
 		return 0;
 	}
 	ap +=3D strlen(name);
@@ -173,180 +153,176 @@ static int slurp_attr(const char *line, const c=
har *name, char *attr)
 	else
 		ends =3D "; \t";
 	sz =3D strcspn(ap, ends);
-	memcpy(attr, ap, sz);
-	attr[sz] =3D 0;
+	strbuf_add(attr, ap, sz);
 	return 1;
 }
=20
 struct content_type {
-	char *boundary;
-	int boundary_len;
+	struct strbuf *boundary;
 };
=20
 static struct content_type content[MAX_BOUNDARIES];
=20
 static struct content_type *content_top =3D content;
=20
-static int handle_content_type(char *line)
+static int handle_content_type(struct strbuf *line)
 {
-	char boundary[256];
+	struct strbuf *boundary =3D xmalloc(sizeof(struct strbuf));
+	strbuf_init(boundary, line->len);
=20
-	if (strcasestr(line, "text/") =3D=3D NULL)
+	if (!strcasestr(line->buf, "text/"))
 		 message_type =3D TYPE_OTHER;
-	if (slurp_attr(line, "boundary=3D", boundary + 2)) {
-		memcpy(boundary, "--", 2);
+	if (slurp_attr(line->buf, "boundary=3D", boundary)) {
+		strbuf_insert(boundary, 0, "--", 2);
 		if (content_top++ >=3D &content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
 			exit(1);
 		}
-		content_top->boundary_len =3D strlen(boundary);
-		content_top->boundary =3D xmalloc(content_top->boundary_len+1);
-		strcpy(content_top->boundary, boundary);
-	}
-	if (slurp_attr(line, "charset=3D", charset)) {
-		int i, c;
-		for (i =3D 0; (c =3D charset[i]) !=3D 0; i++)
-			charset[i] =3D tolower(c);
+		content_top->boundary =3D boundary;
+	} else {
+		strbuf_release(boundary);
+		free(boundary);
 	}
+	if (slurp_attr(line->buf, "charset=3D", &charset))
+		strbuf_tolower(&charset);
 	return 0;
 }
=20
-static int handle_content_transfer_encoding(char *line)
+static int handle_content_transfer_encoding(struct strbuf *line)
 {
-	if (strcasestr(line, "base64"))
+	if (strcasestr(line->buf, "base64"))
 		transfer_encoding =3D TE_BASE64;
-	else if (strcasestr(line, "quoted-printable"))
+	else if (strcasestr(line->buf, "quoted-printable"))
 		transfer_encoding =3D TE_QP;
 	else
 		transfer_encoding =3D TE_DONTCARE;
 	return 0;
 }
=20
-static int is_multipart_boundary(const char *line)
-{
-	return (!memcmp(line, content_top->boundary, content_top->boundary_le=
n));
-}
-
-static int eatspace(char *line)
+static int is_multipart_boundary(struct strbuf *line)
 {
-	int len =3D strlen(line);
-	while (len > 0 && isspace(line[len-1]))
-		line[--len] =3D 0;
-	return len;
+	return !strbuf_cmp(line, content_top->boundary);
 }
=20
-static char *cleanup_subject(char *subject)
+static void cleanup_subject(struct strbuf *subject)
 {
-	for (;;) {
-		char *p;
-		int len, remove;
-		switch (*subject) {
+	char *pos;
+	size_t remove;
+	while (subject->len) {
+		switch (*subject->buf) {
 		case 'r': case 'R':
-			if (!memcmp("e:", subject+1, 2)) {
-				subject +=3D 3;
+			if (subject->len <=3D 3)
+				break;
+			if (!memcmp(subject->buf + 1, "e:", 2)) {
+				strbuf_remove(subject, 0, 3);
 				continue;
 			}
 			break;
 		case ' ': case '\t': case ':':
-			subject++;
+			strbuf_remove(subject, 0, 1);
 			continue;
-
+			break;
 		case '[':
-			p =3D strchr(subject, ']');
-			if (!p) {
-				subject++;
-				continue;
-			}
-			len =3D strlen(p);
-			remove =3D p - subject;
-			if (remove <=3D len *2) {
-				subject =3D p+1;
-				continue;
-			}
+			if ((pos =3D strchr(subject->buf, ']'))) {
+				remove =3D pos - subject->buf + 1;
+				/* Don't remove too much. */
+				if (remove <=3D (subject->len - remove + 1) * 2) {
+					strbuf_remove(subject, 0, remove);
+					continue;
+				}
+			} else
+				strbuf_remove(subject, 0, 1);
 			break;
 		}
-		eatspace(subject);
-		return subject;
+		strbuf_trim(subject);
+		return;
 	}
 }
=20
-static void cleanup_space(char *buf)
+static void cleanup_space(struct strbuf *sb)
 {
-	unsigned char c;
-	while ((c =3D *buf) !=3D 0) {
-		buf++;
-		if (isspace(c)) {
-			buf[-1] =3D ' ';
-			c =3D *buf;
-			while (isspace(c)) {
-				int len =3D strlen(buf);
-				memmove(buf, buf+1, len);
-				c =3D *buf;
-			}
+	size_t pos, cnt;
+	for (pos =3D 0; pos < sb->len; pos++) {
+		if (isspace(sb->buf[pos])) {
+			sb->buf[pos] =3D ' ';
+			for (cnt =3D 0; isspace(sb->buf[pos + cnt + 1]); cnt++);
+			strbuf_remove(sb, pos + 1, cnt);
 		}
 	}
 }
=20
-static void decode_header(char *it, unsigned itsize);
+static void decode_header(struct strbuf *line);
 static const char *header[MAX_HDR_PARSED] =3D {
 	"From","Subject","Date",
 };
=20
-static int check_header(char *line, unsigned linesize, char **hdr_data=
, int overwrite)
+static int cmp_header(const struct strbuf *line, const char *hdr)
 {
-	int i;
+	int len =3D strlen(hdr);
+	return !strncasecmp(line->buf, hdr, len) && line->len > len &&
+			line->buf[len] =3D=3D ':' && isspace(line->buf[len + 1]);
+}
=20
+static int check_header(const struct strbuf *line, struct strbuf *hdr_=
data[], int overwrite)
+{
+	int i, ret =3D 0, len;
+	struct strbuf sb =3D STRBUF_INIT;
 	/* search for the interesting parts */
 	for (i =3D 0; header[i]; i++) {
 		int len =3D strlen(header[i]);
-		if ((!hdr_data[i] || overwrite) &&
-		    !strncasecmp(line, header[i], len) &&
-		    line[len] =3D=3D ':' && isspace(line[len + 1])) {
+		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i])) {
 			/* Unwrap inline B and Q encoding, and optionally
 			 * normalize the meta information to utf8.
 			 */
-			decode_header(line + len + 2, linesize - len - 2);
-			hdr_data[i] =3D xmalloc(1000 * sizeof(char));
-			if (! handle_header(line, hdr_data[i], len + 2)) {
-				return 1;
-			}
+			strbuf_add(&sb, line->buf + len + 2, line->len - len -2);
+			decode_header(&sb);
+			handle_header(&hdr_data[i], &sb);
+			ret =3D 1;
+			goto check_header_out;
 		}
 	}
=20
 	/* Content stuff */
-	if (!strncasecmp(line, "Content-Type", 12) &&
-		line[12] =3D=3D ':' && isspace(line[12 + 1])) {
-		decode_header(line + 12 + 2, linesize - 12 - 2);
-		if (! handle_content_type(line)) {
-			return 1;
-		}
-	}
-	if (!strncasecmp(line, "Content-Transfer-Encoding", 25) &&
-		line[25] =3D=3D ':' && isspace(line[25 + 1])) {
-		decode_header(line + 25 + 2, linesize - 25 - 2);
-		if (! handle_content_transfer_encoding(line)) {
-			return 1;
-		}
+	if (cmp_header(line, "Content-Type")) {
+		len =3D strlen("Content-Type: ");
+		strbuf_reset(&sb);
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		decode_header(&sb);
+		strbuf_insert(&sb, 0, "Content-Type: ", len);
+		if (!handle_content_type(&sb))
+			ret =3D 1;
+			goto check_header_out;
+	}
+	if (cmp_header(line, "Content-Transfer-Encoding")) {
+		len =3D strlen("Content-Transfer-Encoding: ");
+		strbuf_reset(&sb);
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		decode_header(&sb);
+		if (!handle_content_transfer_encoding(&sb))
+			ret =3D 1;
+			goto check_header_out;
 	}
=20
 	/* for inbody stuff */
-	if (!memcmp(">From", line, 5) && isspace(line[5]))
-		return 1;
-	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
+	if (!prefixcmp(line->buf, ">From") && isspace(line->buf[5]))
+		ret =3D 1;
+		goto check_header_out;
+	if (!prefixcmp(line->buf, "[PATCH]") && isspace(line->buf[7])) {
 		for (i =3D 0; header[i]; i++) {
 			if (!memcmp("Subject", header[i], 7)) {
-				if (! handle_header(line, hdr_data[i], 0)) {
-					return 1;
-				}
+				handle_header(&hdr_data[i], line);
+				ret =3D 1;
+				goto check_header_out;
 			}
 		}
 	}
=20
-	/* no match */
-	return 0;
+check_header_out:
+	strbuf_release(&sb);
+	return ret;
 }
=20
-static int is_rfc2822_header(char *line)
+static int is_rfc2822_header(const struct strbuf *line)
 {
 	/*
 	 * The section that defines the loosest possible
@@ -357,15 +333,15 @@ static int is_rfc2822_header(char *line)
 	 * ftext =3D %d33-57 / %59-126
 	 */
 	int ch;
-	char *cp =3D line;
+	char *cp =3D line->buf;
=20
 	/* Count mbox From headers as headers */
-	if (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6))
+	if (line->len >=3D 6 && (!memcmp(cp, "From ", 5) || !memcmp(cp, ">Fro=
m ", 6)))
 		return 1;
=20
 	while ((ch =3D *cp++)) {
 		if (ch =3D=3D ':')
-			return cp !=3D line;
+			return 1;
 		if ((33 <=3D ch && ch <=3D 57) ||
 		    (59 <=3D ch && ch <=3D 126))
 			continue;
@@ -374,34 +350,20 @@ static int is_rfc2822_header(char *line)
 	return 0;
 }
=20
-/*
- * sz is size of 'line' buffer in bytes.  Must be reasonably
- * long enough to hold one physical real-world e-mail line.
- */
-static int read_one_header_line(char *line, int sz, FILE *in)
+static int read_one_header_line(struct strbuf *line, FILE *in)
 {
-	int len;
-
-	/*
-	 * We will read at most (sz-1) bytes and then potentially
-	 * re-add NUL after it.  Accessing line[sz] after this is safe
-	 * and we can allow len to grow up to and including sz.
-	 */
-	sz--;
-
 	/* Get the first part of the line. */
-	if (!fgets(line, sz, in))
+	if (strbuf_getline(line, in, '\n'))
 		return 0;
=20
 	/*
 	 * Is it an empty line or not a valid rfc2822 header?
 	 * If so, stop here, and return false ("not a header")
 	 */
-	len =3D eatspace(line);
-	if (!len || !is_rfc2822_header(line)) {
+	strbuf_rtrim(line);
+	if (!line->len || !is_rfc2822_header(line)) {
 		/* Re-add the newline */
-		line[len] =3D '\n';
-		line[len + 1] =3D '\0';
+		strbuf_addch(line, '\n');
 		return 0;
 	}
=20
@@ -410,65 +372,53 @@ static int read_one_header_line(char *line, int s=
z, FILE *in)
 	 * Yuck, 2822 header "folding"
 	 */
 	for (;;) {
-		int peek, addlen;
-		static char continuation[1000];
+		int peek;
+		struct strbuf continuation =3D STRBUF_INIT;
=20
 		peek =3D fgetc(in); ungetc(peek, in);
 		if (peek !=3D ' ' && peek !=3D '\t')
 			break;
-		if (!fgets(continuation, sizeof(continuation), in))
+		if (strbuf_getline(&continuation, in, '\n'))
 			break;
-		addlen =3D eatspace(continuation);
-		if (len < sz - 1) {
-			if (addlen >=3D sz - len)
-				addlen =3D sz - len - 1;
-			memcpy(line + len, continuation, addlen);
-			line[len] =3D '\n';
-			len +=3D addlen;
-		}
+		continuation.buf[0] =3D '\n';
+		strbuf_rtrim(&continuation);
+		strbuf_addbuf(line, &continuation);
 	}
-	line[len] =3D 0;
=20
 	return 1;
 }
=20
-static int decode_q_segment(char *in, char *ot, unsigned otsize, char =
*ep, int rfc2047)
+static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int=
 rfc2047)
 {
-	char *otbegin =3D ot;
-	char *otend =3D ot + otsize;
+	const char *in =3D q_seg->buf;
 	int c;
-	while ((c =3D *in++) !=3D 0 && (in <=3D ep)) {
-		if (ot =3D=3D otend) {
-			*--ot =3D '\0';
-			return -1;
-		}
+	struct strbuf *out =3D xmalloc(sizeof(struct strbuf));
+	strbuf_init(out, q_seg->len);
+
+	while ((c =3D *in++) !=3D 0) {
 		if (c =3D=3D '=3D') {
 			int d =3D *in++;
 			if (d =3D=3D '\n' || !d)
 				break; /* drop trailing newline */
-			*ot++ =3D ((hexval(d) << 4) | hexval(*in++));
+			strbuf_addch(out, (hexval(d) << 4) | hexval(*in++));
 			continue;
 		}
 		if (rfc2047 && c =3D=3D '_') /* rfc2047 4.2 (2) */
 			c =3D 0x20;
-		*ot++ =3D c;
+		strbuf_addch(out, c);
 	}
-	*ot =3D 0;
-	return (ot - otbegin);
+	return out;
 }
=20
-static int decode_b_segment(char *in, char *ot, unsigned otsize, char =
*ep)
+static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 {
 	/* Decode in..ep, possibly in-place to ot */
 	int c, pos =3D 0, acc =3D 0;
-	char *otbegin =3D ot;
-	char *otend =3D ot + otsize;
+	const char *in =3D b_seg->buf;
+	struct strbuf *out =3D xmalloc(sizeof(struct strbuf));
+	strbuf_init(out, b_seg->len);
=20
-	while ((c =3D *in++) !=3D 0 && (in <=3D ep)) {
-		if (ot =3D=3D otend) {
-			*--ot =3D '\0';
-			return -1;
-		}
+	while ((c =3D *in++) !=3D 0) {
 		if (c =3D=3D '+')
 			c =3D 62;
 		else if (c =3D=3D '/')
@@ -493,21 +443,20 @@ static int decode_b_segment(char *in, char *ot, u=
nsigned otsize, char *ep)
 			acc =3D (c << 2);
 			break;
 		case 1:
-			*ot++ =3D (acc | (c >> 4));
+			strbuf_addch(out, (acc | (c >> 4)));
 			acc =3D (c & 15) << 4;
 			break;
 		case 2:
-			*ot++ =3D (acc | (c >> 2));
+			strbuf_addch(out, (acc | (c >> 2)));
 			acc =3D (c & 3) << 6;
 			break;
 		case 3:
-			*ot++ =3D (acc | c);
+			strbuf_addch(out, (acc | c));
 			acc =3D pos =3D 0;
 			break;
 		}
 	}
-	*ot =3D 0;
-	return (ot - otbegin);
+	return out;
 }
=20
 /*
@@ -521,16 +470,16 @@ static int decode_b_segment(char *in, char *ot, u=
nsigned otsize, char *ep)
  * Otherwise, we default to assuming it is Latin1 for historical
  * reasons.
  */
-static const char *guess_charset(const char *line, const char *target_=
charset)
+static const char *guess_charset(const struct strbuf *line, const char=
 *target_charset)
 {
 	if (is_encoding_utf8(target_charset)) {
-		if (is_utf8(line))
+		if (is_utf8(line->buf))
 			return NULL;
 	}
 	return "latin1";
 }
=20
-static void convert_to_utf8(char *line, unsigned linesize, const char =
*charset)
+static void convert_to_utf8(struct strbuf *line, const char *charset)
 {
 	char *out;
=20
@@ -542,112 +491,119 @@ static void convert_to_utf8(char *line, unsigne=
d linesize, const char *charset)
=20
 	if (!strcmp(metainfo_charset, charset))
 		return;
-	out =3D reencode_string(line, metainfo_charset, charset);
+	out =3D reencode_string(line->buf, metainfo_charset, charset);
 	if (!out)
 		die("cannot convert from %s to %s\n",
 		    charset, metainfo_charset);
-	strlcpy(line, out, linesize);
-	free(out);
+	strbuf_attach(line, out, strlen(out), strlen(out));
 }
=20
-static int decode_header_bq(char *it, unsigned itsize)
+static int decode_header_bq(struct strbuf *it)
 {
 	char *in, *out, *ep, *cp, *sp;
-	char outbuf[1000];
+	struct strbuf outbuf =3D STRBUF_INIT, *dec;
+	struct strbuf charset_q =3D STRBUF_INIT, piecebuf =3D STRBUF_INIT;
 	int rfc2047 =3D 0;
=20
-	in =3D it;
-	out =3D outbuf;
-	while ((ep =3D strstr(in, "=3D?")) !=3D NULL) {
-		int sz, encoding;
-		char charset_q[256], piecebuf[256];
+	in =3D it->buf;
+	while (in - it->buf <=3D it->len && (ep =3D strstr(in, "=3D?")) !=3D =
NULL) {
+		int encoding;
+		strbuf_reset(&charset_q);
+		strbuf_reset(&piecebuf);
 		rfc2047 =3D 1;
=20
 		if (in !=3D ep) {
-			sz =3D ep - in;
-			memcpy(out, in, sz);
-			out +=3D sz;
-			in +=3D sz;
+			strbuf_add(&outbuf, in, ep - in);
+			in =3D ep;
 		}
 		/* E.g.
 		 * ep : "=3D?iso-2022-jp?B?GyR...?=3D foo"
 		 * ep : "=3D?ISO-8859-1?Q?Foo=3DFCbar?=3D baz"
 		 */
 		ep +=3D 2;
-		cp =3D strchr(ep, '?');
-		if (!cp)
-			return rfc2047; /* no munging */
-		for (sp =3D ep; sp < cp; sp++)
-			charset_q[sp - ep] =3D tolower(*sp);
-		charset_q[cp - ep] =3D 0;
+
+		if (ep - it->buf >=3D it->len || !(cp =3D strchr(ep, '?')))
+			goto decode_header_bq_out;
+
+		if (cp + 3 - it->buf > it->len)
+			goto decode_header_bq_out;
+		strbuf_add(&charset_q, ep, cp - ep);
+		strbuf_tolower(&charset_q);
+
 		encoding =3D cp[1];
 		if (!encoding || cp[2] !=3D '?')
-			return rfc2047; /* no munging */
+			goto decode_header_bq_out;
 		ep =3D strstr(cp + 3, "?=3D");
 		if (!ep)
-			return rfc2047; /* no munging */
+			goto decode_header_bq_out;
+		strbuf_add(&piecebuf, cp + 3, ep - cp - 3);
 		switch (tolower(encoding)) {
 		default:
-			return rfc2047; /* no munging */
+			goto decode_header_bq_out;
 		case 'b':
-			sz =3D decode_b_segment(cp + 3, piecebuf, sizeof(piecebuf), ep);
+			dec =3D decode_b_segment(&piecebuf);
 			break;
 		case 'q':
-			sz =3D decode_q_segment(cp + 3, piecebuf, sizeof(piecebuf), ep, 1);
+			dec =3D decode_q_segment(&piecebuf, 1);
 			break;
 		}
-		if (sz < 0)
-			return rfc2047;
 		if (metainfo_charset)
-			convert_to_utf8(piecebuf, sizeof(piecebuf), charset_q);
+			convert_to_utf8(dec, charset_q.buf);
=20
-		sz =3D strlen(piecebuf);
-		if (outbuf + sizeof(outbuf) <=3D out + sz)
-			return rfc2047; /* no munging */
-		strcpy(out, piecebuf);
-		out +=3D sz;
+		strbuf_addbuf(&outbuf, dec);
+		strbuf_release(dec);
+		free(dec);
 		in =3D ep + 2;
 	}
-	strcpy(out, in);
-	strlcpy(it, outbuf, itsize);
+	strbuf_addstr(&outbuf, in);
+	strbuf_reset(it);
+	strbuf_addbuf(it, &outbuf);
+decode_header_bq_out:
+	strbuf_release(&outbuf);
+	strbuf_release(&charset_q);
+	strbuf_release(&piecebuf);
 	return rfc2047;
 }
=20
-static void decode_header(char *it, unsigned itsize)
+static void decode_header(struct strbuf *it)
 {
-
-	if (decode_header_bq(it, itsize))
+	if (decode_header_bq(it))
 		return;
 	/* otherwise "it" is a straight copy of the input.
 	 * This can be binary guck but there is no charset specified.
 	 */
 	if (metainfo_charset)
-		convert_to_utf8(it, itsize, "");
+		convert_to_utf8(it, "");
 }
=20
-static int decode_transfer_encoding(char *line, unsigned linesize, int=
 inputlen)
+static void decode_transfer_encoding(struct strbuf *line)
 {
-	char *ep;
+	struct strbuf *ret;
+	int len;
=20
 	switch (transfer_encoding) {
 	case TE_QP:
-		ep =3D line + inputlen;
-		return decode_q_segment(line, line, linesize, ep, 0);
+		ret =3D decode_q_segment(line, 0);
+		break;
 	case TE_BASE64:
-		ep =3D line + inputlen;
-		return decode_b_segment(line, line, linesize, ep);
+		ret =3D decode_b_segment(line);
+		break;
 	case TE_DONTCARE:
 	default:
-		return inputlen;
+		return;
 	}
+	strbuf_reset(line);
+	strbuf_addbuf(line, ret);
+	strbuf_release(ret);
+	free(ret);
 }
=20
-static int handle_filter(char *line, unsigned linesize, int linelen);
+static int handle_filter(struct strbuf *line);
=20
 static int find_boundary(void)
 {
-	while(fgets(line, sizeof(line), fin) !=3D NULL) {
-		if (is_multipart_boundary(line))
+	while(!strbuf_getline(&line, fin, '\n')) {
+		if (is_multipart_boundary(&line))
 			return 1;
 	}
 	return 0;
@@ -655,11 +611,15 @@ static int find_boundary(void)
=20
 static int handle_boundary(void)
 {
-	char newline[]=3D"\n";
+	struct strbuf newline =3D STRBUF_INIT;
+
+	strbuf_addch(&newline, '\n');
 again:
-	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
+	if (line.len >=3D content_top->boundary->len + 2 &&
+	    !memcmp(line.buf + content_top->boundary->len, "--", 2)) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
+		strbuf_release(content_top->boundary);
 		free(content_top->boundary);
=20
 		/* technically won't happen as is_multipart_boundary()
@@ -670,7 +630,8 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(newline, sizeof(newline), strlen(newline));
+		handle_filter(&newline);
+		strbuf_release(&newline);
=20
 		/* skip to the next boundary */
 		if (!find_boundary())
@@ -680,39 +641,44 @@ again:
=20
 	/* set some defaults */
 	transfer_encoding =3D TE_DONTCARE;
-	charset[0] =3D 0;
+	strbuf_reset(&charset);
 	message_type =3D TYPE_TEXT;
=20
 	/* slurp in this section's info */
-	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, sizeof(line), p_hdr_data, 0);
+	while (read_one_header_line(&line, fin))
+		check_header(&line, p_hdr_data, 0);
=20
+	strbuf_release(&newline);
 	/* eat the blank line after section info */
-	return (fgets(line, sizeof(line), fin) !=3D NULL);
+	return (strbuf_getline(&line, fin, '\n') =3D=3D 0);
 }
=20
-static inline int patchbreak(const char *line)
+static inline int patchbreak(const struct strbuf *line)
 {
+	size_t i;
+
 	/* Beginning of a "diff -" header? */
-	if (!memcmp("diff -", line, 6))
+	if (!prefixcmp(line->buf, "diff -"))
 		return 1;
=20
 	/* CVS "Index: " line? */
-	if (!memcmp("Index: ", line, 7))
+	if (!prefixcmp(line->buf, "Index: "))
 		return 1;
=20
 	/*
 	 * "--- <filename>" starts patches without headers
 	 * "---<sp>*" is a manual separator
 	 */
-	if (!memcmp("---", line, 3)) {
-		line +=3D 3;
+	if (line->len < 4)
+		return 0;
+
+	if (!prefixcmp(line->buf, "---")) {
 		/* space followed by a filename? */
-		if (line[0] =3D=3D ' ' && !isspace(line[1]))
+		if (line->buf[3] =3D=3D ' ' && !isspace(line->buf[4]))
 			return 1;
 		/* Just whitespace? */
-		for (;;) {
-			unsigned char c =3D *line++;
+		for (i =3D 3; i < line->len; i++) {
+			unsigned char c =3D line->buf[i];
 			if (c =3D=3D '\n')
 				return 1;
 			if (!isspace(c))
@@ -723,32 +689,25 @@ static inline int patchbreak(const char *line)
 	return 0;
 }
=20
-
-static int handle_commit_msg(char *line, unsigned linesize)
+static int handle_commit_msg(struct strbuf *line)
 {
 	static int still_looking =3D 1;
-	char *endline =3D line + linesize;
+	char *c;
=20
 	if (!cmitmsg)
 		return 0;
=20
 	if (still_looking) {
-		char *cp =3D line;
-		if (isspace(*line)) {
-			for (cp =3D line + 1; *cp; cp++) {
-				if (!isspace(*cp))
-					break;
-			}
-			if (!*cp)
-				return 0;
-		}
-		if ((still_looking =3D check_header(cp, endline - cp, s_hdr_data, 0)=
) !=3D 0)
+		strbuf_ltrim(line);
+		if (!line->len)
+			return 0;
+		if ((still_looking =3D check_header(line, s_hdr_data, 0)) !=3D 0)
 			return 0;
 	}
=20
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
-		convert_to_utf8(line, endline - line, charset);
+		convert_to_utf8(line, charset.buf);
=20
 	if (patchbreak(line)) {
 		fclose(cmitmsg);
@@ -756,18 +715,18 @@ static int handle_commit_msg(char *line, unsigned=
 linesize)
 		return 1;
 	}
=20
-	fputs(line, cmitmsg);
+	fputs(line->buf, cmitmsg);
 	return 0;
 }
=20
-static int handle_patch(char *line, int len)
+static int handle_patch(const struct strbuf *line)
 {
-	fwrite(line, 1, len, patchfile);
+	fwrite(line->buf, 1, line->len, patchfile);
 	patch_lines++;
 	return 0;
 }
=20
-static int handle_filter(char *line, unsigned linesize, int linelen)
+static int handle_filter(struct strbuf *line)
 {
 	static int filter =3D 0;
=20
@@ -776,11 +735,11 @@ static int handle_filter(char *line, unsigned lin=
esize, int linelen)
 	 */
 	switch (filter) {
 	case 0:
-		if (!handle_commit_msg(line, linesize))
+		if (!handle_commit_msg(line))
 			break;
 		filter++;
 	case 1:
-		if (!handle_patch(line, linelen))
+		if (!handle_patch(line))
 			break;
 		filter++;
 	default:
@@ -793,101 +752,105 @@ static int handle_filter(char *line, unsigned l=
inesize, int linelen)
 static void handle_body(void)
 {
 	int rc =3D 0;
-	static char newline[2000];
-	static char *np =3D newline;
-	int len =3D strlen(line);
+	int len =3D 0;
+	struct strbuf prev =3D STRBUF_INIT;
=20
 	/* Skip up to the first boundary */
 	if (content_top->boundary) {
 		if (!find_boundary())
-			return;
+			goto handle_body_out;
 	}
=20
 	do {
+		strbuf_setlen(&line, line.len + len);
+
 		/* process any boundary lines */
-		if (content_top->boundary && is_multipart_boundary(line)) {
+		if (content_top->boundary && is_multipart_boundary(&line)) {
 			/* flush any leftover */
-			if (np !=3D newline)
-				handle_filter(newline, sizeof(newline),
-					      np - newline);
+			if (line.len)
+				handle_filter(&line);
+
 			if (!handle_boundary())
-				return;
-			len =3D strlen(line);
+				goto handle_body_out;
 		}
=20
 		/* Unwrap transfer encoding */
-		len =3D decode_transfer_encoding(line, sizeof(line), len);
-		if (len < 0) {
-			error("Malformed input line");
-			return;
-		}
+		decode_transfer_encoding(&line);
=20
 		switch (transfer_encoding) {
 		case TE_BASE64:
 		case TE_QP:
 		{
-			char *op =3D line;
+			struct strbuf **lines, **it, *sb;
+
+			/* Prepend any previous partial lines */
+			strbuf_insert(&line, 0, prev.buf, prev.len);
+			strbuf_reset(&prev);
=20
 			/* binary data most likely doesn't have newlines */
 			if (message_type !=3D TYPE_TEXT) {
-				rc =3D handle_filter(line, sizeof(line), len);
+				rc =3D handle_filter(&line);
 				break;
 			}
-
 			/*
 			 * This is a decoded line that may contain
 			 * multiple new lines.  Pass only one chunk
 			 * at a time to handle_filter()
 			 */
-			do {
-				while (op < line + len && *op !=3D '\n')
-					*np++ =3D *op++;
-				*np =3D *op;
-				if (*np !=3D 0) {
-					/* should be sitting on a new line */
-					*(++np) =3D 0;
-					op++;
-					rc =3D handle_filter(newline, sizeof(newline), np - newline);
-					np =3D newline;
-				}
-			} while (op < line + len);
+			lines =3D strbuf_split(&line, '\n');
+			strbuf_reset(&line);
+			for (it =3D lines; (sb =3D *it); it++) {
+				if (*(it + 1) =3D=3D NULL) /* The last token */
+					if (sb->buf[sb->len - 1] !=3D '\n') {
+						/* Partial line, save it for later. */
+						strbuf_addbuf(&prev, sb);
+						break;
+					}
+				rc =3D handle_filter(sb);
+			}
 			/*
-			 * The partial chunk is saved in newline and will be
+			 * The partial chunk is saved in "prev" and will be
 			 * appended by the next iteration of read_line_with_nul().
 			 */
+			strbuf_list_free(lines);
 			break;
 		}
 		default:
-			rc =3D handle_filter(line, sizeof(line), len);
+			rc =3D handle_filter(&line);
+			strbuf_reset(&line);
 		}
 		if (rc)
 			/* nothing left to filter */
 			break;
-	} while ((len =3D read_line_with_nul(line, sizeof(line), fin)));
+		if (strbuf_avail(&line) < 100)
+			strbuf_grow(&line, 100);
+	} while ((len =3D read_line_with_nul(line.buf, strbuf_avail(&line), f=
in)));
=20
+handle_body_out:
+	strbuf_release(&prev);
 	return;
 }
=20
-static void output_header_lines(FILE *fout, const char *hdr, char *dat=
a)
+static void output_header_lines(FILE *fout, const char *hdr, const str=
uct strbuf *data)
 {
+	char *sp =3D data->buf;
 	while (1) {
-		char *ep =3D strchr(data, '\n');
+		char *ep =3D strchr(sp, '\n');
 		int len;
 		if (!ep)
-			len =3D strlen(data);
+			len =3D strlen(sp);
 		else
-			len =3D ep - data;
-		fprintf(fout, "%s: %.*s\n", hdr, len, data);
+			len =3D ep - sp;
+		fprintf(fout, "%s: %.*s\n", hdr, len, sp);
 		if (!ep)
 			break;
-		data =3D ep + 1;
+		sp =3D ep + 1;
 	}
 }
=20
 static void handle_info(void)
 {
-	char *sub;
-	char *hdr;
+	struct strbuf *hdr;
 	int i;
=20
 	for (i =3D 0; header[i]; i++) {
@@ -901,20 +864,18 @@ static void handle_info(void)
 			continue;
=20
 		if (!memcmp(header[i], "Subject", 7)) {
-			if (keep_subject)
-				sub =3D hdr;
-			else {
-				sub =3D cleanup_subject(hdr);
-				cleanup_space(sub);
+			if (!keep_subject) {
+				cleanup_subject(hdr);
+				cleanup_space(hdr);
 			}
-			output_header_lines(fout, "Subject", sub);
+			output_header_lines(fout, "Subject", hdr);
 		} else if (!memcmp(header[i], "From", 4)) {
 			handle_from(hdr);
-			fprintf(fout, "Author: %s\n", name);
-			fprintf(fout, "Email: %s\n", email);
+			fprintf(fout, "Author: %s\n", name.buf);
+			fprintf(fout, "Email: %s\n", email.buf);
 		} else {
 			cleanup_space(hdr);
-			fprintf(fout, "%s: %s\n", header[i], hdr);
+			fprintf(fout, "%s: %s\n", header[i], hdr->buf);
 		}
 	}
 	fprintf(fout, "\n");
@@ -941,8 +902,8 @@ static int mailinfo(FILE *in, FILE *out, int ks, co=
nst char *encoding,
 		return -1;
 	}
=20
-	p_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(char *));
-	s_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(char *));
+	p_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*p_hdr_data));
+	s_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*s_hdr_data));
=20
 	do {
 		peek =3D fgetc(in);
@@ -950,8 +911,8 @@ static int mailinfo(FILE *in, FILE *out, int ks, co=
nst char *encoding,
 	ungetc(peek, in);
=20
 	/* process the email header */
-	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, sizeof(line), p_hdr_data, 1);
+	while (read_one_header_line(&line, fin))
+		check_header(&line, p_hdr_data, 1);
=20
 	handle_body();
 	handle_info();
--=20
1.5.4.5
