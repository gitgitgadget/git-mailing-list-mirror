From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Tue, 04 Sep 2007 22:50:08 +0200
Message-ID: <46DDC500.5000606@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISfM0-0007iO-N3
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 22:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbXIDUuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 16:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXIDUuR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 16:50:17 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:57982 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbXIDUuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 16:50:12 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id BEFE28C1E;
	Tue,  4 Sep 2007 22:50:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070804 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57643>

Hi.

This is an attempt to use "The Better String Library"[1] in builtin-mailinfo.c

The patch doesn't pass all the tests in the testsuit yet, but I thought I'd
send it out so people can decide if they like how the code looks.

I'm not sending a patch to add the library files at this time. I'll send
that patch when this patch is working.

The changes required to make it pass the tests shouldn't be very large.

/Lukas

[1] http://bstring.sourceforge.net/

---
 builtin-mailinfo.c |  795 ++++++++++++++++++++++++++--------------------------
 1 files changed, 392 insertions(+), 403 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index d7cb11d..2ddc15d 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -5,14 +5,14 @@
 #include "cache.h"
 #include "builtin.h"
 #include "utf8.h"
+#include "bstring/bstrlib.h"
 
 static FILE *cmitmsg, *patchfile, *fin, *fout;
 
 static int keep_subject;
-static const char *metainfo_charset;
-static char line[1000];
-static char name[1000];
-static char email[1000];
+static bstring metainfo_charset;
+static bstring name;
+static bstring email;
 
 static enum  {
 	TE_DONTCARE, TE_QP, TE_BASE64,
@@ -21,321 +21,291 @@ static enum  {
 	TYPE_TEXT, TYPE_OTHER,
 } message_type;
 
-static char charset[256];
+static bstring charset;
 static int patch_lines;
-static char **p_hdr_data, **s_hdr_data;
+static bstring *p_hdr_data, *s_hdr_data;
 
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
 
-static char *sanity_check(char *name, char *email)
+static bstring sanity_check(bstring name, bstring email)
 {
-	int len = strlen(name);
-	if (len < 3 || len > 60)
+	static struct tagbstring email_ind = bsStatic("<@>");
+	if (blength(name) < 3 || blength(name) > 60)
 		return email;
-	if (strchr(name, '@') || strchr(name, '<') || strchr(name, '>'))
+	if (binchr(name, 0, &email_ind) != BSTR_ERR)
 		return email;
 	return name;
 }
 
-static int bogus_from(char *line)
+static int bogus_from(const_bstring line)
 {
 	/* John Doe <johndoe> */
-	char *bra, *ket, *dst, *cp;
-
+	int bra, ket;
 	/* This is fallback, so do not bother if we already have an
 	 * e-mail address.
 	 */
-	if (*email)
+	if (blength(email))
 		return 0;
 
-	bra = strchr(line, '<');
-	if (!bra)
+	bra = bstrchr(line, '<');
+	if (bra == BSTR_ERR)
 		return 0;
-	ket = strchr(bra, '>');
-	if (!ket)
+	ket = bstrchrp(line, bra, '>');
+	if (ket == BSTR_ERR)
 		return 0;
 
-	for (dst = email, cp = bra+1; cp < ket; )
-		*dst++ = *cp++;
-	*dst = 0;
-	for (cp = line; isspace(*cp); cp++)
-		;
-	for (bra--; isspace(*bra); bra--)
-		*bra = 0;
-	cp = sanity_check(cp, email);
-	strcpy(name, cp);
+	bdestroy(email);
+	email = bmidstr(line, bra + 1, ket - bra - 1);
+
+	name = bmidstr(line, 0, bra);
+	btrimws(name);
+	bassign(name, sanity_check(name, email));
 	return 1;
 }
 
-static int handle_from(char *in_line)
+static int handle_from(const_bstring line)
 {
-	char line[1000];
-	char *at;
-	char *dst;
+	int at, es, ee;
+	static struct tagbstring email_delim = bsStatic(" \n\t\r\v\f<>");
 
-	strcpy(line, in_line);
-	at = strchr(line, '@');
-	if (!at)
+	at = bstrchr(line, '@');
+	if (at == BSTR_ERR)
 		return bogus_from(line);
 
 	/*
 	 * If we already have one email, don't take any confusing lines
 	 */
-	if (*email && strchr(at+1, '@'))
+	if (blength(email) && bstrchrp(line, '@', at + 1) != BSTR_ERR)
 		return 0;
 
 	/* Pick up the string around '@', possibly delimited with <>
-	 * pair; that is the email part.  White them out while copying.
+	 * pair; that is the email part.
 	 */
-	while (at > line) {
-		char c = at[-1];
-		if (isspace(c))
-			break;
-		if (c == '<') {
-			at[-1] = ' ';
-			break;
-		}
-		at--;
-	}
-	dst = email;
-	for (;;) {
-		unsigned char c = *at;
-		if (!c || c == '>' || isspace(c)) {
-			if (c == '>')
-				*at = ' ';
-			break;
-		}
-		*at++ = ' ';
-		*dst++ = c;
-	}
-	*dst++ = 0;
+
+	es = binchrr(line, at, &email_delim);
+	ee = binchr(line, at, &email_delim);
+	bdestroy(email);
+	email = bmidstr(line, es + 1, ee - es - 1);
 
 	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
 	 * or "john.doe@xz (John Doe)", but we have whited out the
 	 * email part, so trim from both ends, possibly removing
 	 * the () pair at the end.
 	 */
-	at = line + strlen(line);
-	while (at > line) {
-		unsigned char c = *--at;
-		if (!isspace(c)) {
-			at[(c == ')') ? 0 : 1] = 0;
-			break;
-		}
-	}
 
-	at = line;
-	for (;;) {
-		unsigned char c = *at;
-		if (!c || !isspace(c)) {
-			if (c == '(')
-				at++;
-			break;
-		}
-		at++;
-	}
-	at = sanity_check(at, email);
-	strcpy(name, at);
+	bdestroy(name);
+	name = bstrcpy(line);
+	bdelete(name, es, ee - es + 1);
+	btrimws(name);
+	if (bchar(name, 0) == '(')
+		bdelete(name, 0, 1);
+	if (bchar(name, blength(name) - 1) == ')')
+		btrunc(name, blength(name) - 1);
+	
+	bassign(name, sanity_check(name, email));
 	return 1;
 }
 
-static int handle_header(char *line, char *data, int ofs)
-{
-	if (!line || !data)
-		return 1;
-
-	strcpy(data, line+ofs);
-
-	return 0;
-}
-
 /* NOTE NOTE NOTE.  We do not claim we do full MIME.  We just attempt
  * to have enough heuristics to grok MIME encoded patches often found
  * on our mailing lists.  For example, we do not even treat header lines
  * case insensitively.
  */
 
-static int slurp_attr(const char *line, const char *name, char *attr)
+static bstring slurp_attr(const_bstring line, const char *name)
 {
-	const char *ends, *ap = strcasestr(line, name);
-	size_t sz;
+	int end, start;
+	static struct tagbstring endchars = bsStatic("; \t");
+	struct tagbstring bname;
 
-	if (!ap) {
-		*attr = 0;
-		return 0;
-	}
-	ap += strlen(name);
-	if (*ap == '"') {
-		ap++;
-		ends = "\"";
+	btfromcstr(bname, name);
+	start =  binstrcaseless(line, 0, &bname);
+	if (start == BSTR_ERR)
+		return NULL;
+	
+	start += blength(&bname);
+	if (blength(line) > start && bchar(line, start) == '"') {
+		start++;
+		if ((end = bstrchrp(line, start, '"')) == BSTR_ERR)
+			end = blength(line);
+		return bmidstr(line, start, end - start);
 	}
-	else
-		ends = "; \t";
-	sz = strcspn(ap, ends);
-	memcpy(attr, ap, sz);
-	attr[sz] = 0;
-	return 1;
+	if ((end = binchr(line, start, &endchars)) == BSTR_ERR)
+		end = blength(line);
+	return bmidstr(line, start, end - start);
 }
 
 struct content_type {
-	char *boundary;
-	int boundary_len;
+	bstring boundary;
 };
 
 static struct content_type content[MAX_BOUNDARIES];
 
 static struct content_type *content_top = content;
 
-static int handle_content_type(char *line)
+static int handle_content_type(const_bstring line)
 {
-	char boundary[256];
-
-	if (strcasestr(line, "text/") == NULL)
+	static struct tagbstring cmp_text = bsStatic("text/");
+	bstring attr, boundary;
+	
+	if (binstrcaseless(line, 0, &cmp_text) == BSTR_ERR)
 		 message_type = TYPE_OTHER;
-	if (slurp_attr(line, "boundary=", boundary + 2)) {
-		memcpy(boundary, "--", 2);
+
+	if ((attr = slurp_attr(line, "boundary="))) {
+		boundary = bfromcstr("--");
+		bconcat(boundary, attr);
+		bdestroy(attr);
 		if (content_top++ >= &content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
 			exit(1);
 		}
-		content_top->boundary_len = strlen(boundary);
-		content_top->boundary = xmalloc(content_top->boundary_len+1);
-		strcpy(content_top->boundary, boundary);
+		content_top->boundary = boundary;
+		return 0;
 	}
-	if (slurp_attr(line, "charset=", charset)) {
-		int i, c;
-		for (i = 0; (c = charset[i]) != 0; i++)
-			charset[i] = tolower(c);
+	if ((attr = slurp_attr(line, "charset="))) {
+		if (btolower(attr) == BSTR_ERR)
+			die("Couldn't convert %s to lowercase.\n", attr->data);
+		charset = attr;
 	}
 	return 0;
 }
 
-static int handle_content_transfer_encoding(char *line)
+static int handle_content_transfer_encoding(const_bstring line)
 {
-	if (strcasestr(line, "base64"))
+	static struct tagbstring cmp_base64 = bsStatic("base64");
+	static struct tagbstring cmp_qp = bsStatic("quoted-printable");
+
+	if (binstrcaseless(line, 0, &cmp_base64) != BSTR_ERR)
 		transfer_encoding = TE_BASE64;
-	else if (strcasestr(line, "quoted-printable"))
+	else if (binstrcaseless(line, 0, &cmp_qp))
 		transfer_encoding = TE_QP;
 	else
 		transfer_encoding = TE_DONTCARE;
 	return 0;
 }
 
-static int is_multipart_boundary(const char *line)
-{
-	return (!memcmp(line, content_top->boundary, content_top->boundary_len));
-}
-
-static int eatspace(char *line)
+static int is_multipart_boundary(const_bstring line)
 {
-	int len = strlen(line);
-	while (len > 0 && isspace(line[len-1]))
-		line[--len] = 0;
-	return len;
+	return !bstrncmp(line, content_top->boundary, blength(content_top->boundary));
 }
 
-static char *cleanup_subject(char *subject)
+/*
+ * Removes (Re:|[ \[\t:]|\[.*\])* if prefixed and
+ * trims trailing whitespace.
+ */
+static void cleanup_subject(bstring subject)
 {
-	for (;;) {
-		char *p;
-		int len, remove;
-		switch (*subject) {
+	int pos;
+	while (blength(subject)) {
+		switch (bchar(subject, 0)) {
 		case 'r': case 'R':
-			if (!memcmp("e:", subject+1, 2)) {
-				subject += 3;
+			if (blength(subject) <= 3)
+				break;
+			if (!memcmp(bdata(subject) + 1, "e:", 2)) {
+				bdelete(subject, 0, 3);
 				continue;
 			}
 			break;
-		case ' ': case '\t': case ':':
-			subject++;
-			continue;
-
 		case '[':
-			p = strchr(subject, ']');
-			if (!p) {
-				subject++;
-				continue;
-			}
-			len = strlen(p);
-			remove = p - subject;
-			if (remove <= len *2) {
-				subject = p+1;
-				continue;
+			if ((pos = bstrchr(subject, ']')) != BSTR_ERR) {
+				/* Don't remove more than a third of the subject. */
+				if (pos <= blength(subject)/3) {
+					bdelete(subject, 0, pos + 1);
+					continue;
+				}
+				break;
 			}
-			break;
+		/* fall through */
+		case ' ': case '\t': case ':':
+			bdelete(subject, 0, 1);
+			continue;
 		}
-		eatspace(subject);
-		return subject;
+
+		btrimws(subject);
+		return;
 	}
 }
 
-static void cleanup_space(char *buf)
+static void cleanup_space(bstring buf)
 {
-	unsigned char c;
-	while ((c = *buf) != 0) {
-		buf++;
-		if (isspace(c)) {
-			buf[-1] = ' ';
-			c = *buf;
-			while (isspace(c)) {
-				int len = strlen(buf);
-				memmove(buf, buf+1, len);
-				c = *buf;
-			}
+	struct bstrList *tok;
+	static struct tagbstring whitespace = bsStatic(" \n\t\r\f\v");
+	int i;
+
+	tok = bsplitstr(buf, &whitespace);
+	btrunc(buf, 0);
+	for (i = 0; i < tok->qty; i++) {
+		if (blength(tok->entry[i])) {
+			bconcat(buf, tok->entry[i]);
+			bconchar(buf, ' ');
 		}
 	}
+	/* Remove the last ' ' */
+	btrunc(buf, blength(buf) - 1);
+	bstrListDestroy(tok);
+}
+
+static int handle_header(bstring line, bstring *data, int ofs)
+{
+	if (!line)
+		return 1;
+
+	bdestroy(*data);
+	*data = bmidstr(line, ofs, blength(line) - ofs);
+
+	return 0;
 }
 
-static void decode_header(char *it, unsigned itsize);
+static void decode_header(bstring line);
 static char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
 
-static int check_header(char *line, unsigned linesize, char **hdr_data, int overwrite)
+static int check_header(bstring line, bstring hdr_data[], int overwrite)
 {
 	int i;
 
 	/* search for the interesting parts */
 	for (i = 0; header[i]; i++) {
 		int len = strlen(header[i]);
+
 		if ((!hdr_data[i] || overwrite) &&
-		    !strncasecmp(line, header[i], len) &&
-		    line[len] == ':' && isspace(line[len + 1])) {
+		    bisstemeqcaselessblk(line, header[i], len) &&
+		    bchar(line, len) == ':' && isspace(bchar(line, len + 1))) {
 			/* Unwrap inline B and Q encoding, and optionally
 			 * normalize the meta information to utf8.
 			 */
-			decode_header(line + len + 2, linesize - len - 2);
-			hdr_data[i] = xmalloc(1000 * sizeof(char));
-			if (! handle_header(line, hdr_data[i], len + 2)) {
+			decode_header(line);
+			if (!handle_header(line, &hdr_data[i], len + 2)) {
 				return 1;
 			}
 		}
 	}
 
 	/* Content stuff */
-	if (!strncasecmp(line, "Content-Type", 12) &&
-		line[12] == ':' && isspace(line[12 + 1])) {
-		decode_header(line + 12 + 2, linesize - 12 - 2);
+	if (!bisstemeqcaselessblk(line, bsStaticBlkParms("Content-Type")) &&
+		bchar(line, 12) == ':' && isspace(bchar(line, 12 + 1))) {
+		decode_header(line);
 		if (! handle_content_type(line)) {
 			return 1;
 		}
 	}
-	if (!strncasecmp(line, "Content-Transfer-Encoding", 25) &&
-		line[25] == ':' && isspace(line[25 + 1])) {
-		decode_header(line + 25 + 2, linesize - 25 - 2);
+	if (!bisstemeqcaselessblk(line, bsStaticBlkParms("Content-Transfer-Encoding")) &&
+		bchar(line, 25) == ':' && isspace(bchar(line, 25 + 1))) {
+		decode_header(line);
 		if (! handle_content_transfer_encoding(line)) {
 			return 1;
 		}
 	}
 
 	/* for inbody stuff */
-	if (!memcmp(">From", line, 5) && isspace(line[5]))
+	if (bisstemeqblk(line, bsStaticBlkParms(">From")) && isspace(bchar(line, 5)))
 		return 1;
-	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
+	if (bisstemeqblk(line, bsStaticBlkParms("[PATCH]")) && isspace(bchar(line, 7))) {
 		for (i = 0; header[i]; i++) {
-			if (!memcmp("Subject: ", header[i], 9)) {
-				if (! handle_header(line, hdr_data[i], 0)) {
+			if (!memcmp("Subject", header[i], 7)) {
+				if (!handle_header(line, &hdr_data[i], 0)) {
 					return 1;
 				}
 			}
@@ -346,7 +316,7 @@ static int check_header(char *line, unsigned linesize, char **hdr_data, int over
 	return 0;
 }
 
-static int is_rfc2822_header(char *line)
+static int is_rfc2822_header(const_bstring line)
 {
 	/*
 	 * The section that defines the loosest possible
@@ -357,15 +327,15 @@ static int is_rfc2822_header(char *line)
 	 * ftext = %d33-57 / %59-126
 	 */
 	int ch;
-	char *cp = line;
+	char *cp = bdata(line);
 
 	/* Count mbox From headers as headers */
-	if (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6))
+	if (blength(line) >= 6 && (!memcmp(cp, "From ", 5) || !memcmp(cp, ">From ", 6)))
 		return 1;
 
 	while ((ch = *cp++)) {
 		if (ch == ':')
-			return cp != line;
+			return cp != bdata(line);
 		if ((33 <= ch && ch <= 57) ||
 		    (59 <= ch && ch <= 126))
 			continue;
@@ -375,34 +345,23 @@ static int is_rfc2822_header(char *line)
 }
 
 /*
- * sz is size of 'line' buffer in bytes.  Must be reasonably
- * long enough to hold one physical real-world e-mail line.
+ * 'line' must be a valid bstring
  */
-static int read_one_header_line(char *line, int sz, FILE *in)
+static int read_one_header_line(struct bStream *in, bstring line)
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
-		return 0;
+	if (bsreadln(line, in, '\n') != BSTR_OK)
+		goto unread_line;
 
 	/*
 	 * Is it an empty line or not a valid rfc2822 header?
 	 * If so, stop here, and return false ("not a header")
 	 */
-	len = eatspace(line);
-	if (!len || !is_rfc2822_header(line)) {
+	brtrimws(line);
+	if (!blength(line) || !is_rfc2822_header(line)) {
 		/* Re-add the newline */
-		line[len] = '\n';
-		line[len + 1] = '\0';
-		return 0;
+		bconchar(line, '\n');
+		goto unread_line;
 	}
 
 	/*
@@ -410,63 +369,57 @@ static int read_one_header_line(char *line, int sz, FILE *in)
 	 * Yuck, 2822 header "folding"
 	 */
 	for (;;) {
-		int peek, addlen;
-		static char continuation[1000];
+		bstring continuation;
+		continuation = bfromcstr("");
 
-		peek = fgetc(in); ungetc(peek, in);
-		if (peek != ' ' && peek != '\t')
+		if (bsreadln(continuation, in, '\n') != BSTR_OK)
 			break;
-		if (!fgets(continuation, sizeof(continuation), in))
+		if (bchar(continuation, 0) != ' ' && bchar(continuation, 0) != '\t') {
+			bsunread(in, continuation);
 			break;
-		addlen = eatspace(continuation);
-		if (len < sz - 1) {
-			if (addlen >= sz - len)
-				addlen = sz - len - 1;
-			memcpy(line + len, continuation, addlen);
-			line[len] = '\n';
-			len += addlen;
 		}
+
+		continuation->data[0] = '\n';
+		brtrimws(continuation);
+		bconcat(line, continuation);
 	}
-	line[len] = 0;
 
 	return 1;
+unread_line:
+	bsunread(in, line);
+	return 0;
 }
 
-static int decode_q_segment(char *in, char *ot, unsigned otsize, char *ep, int rfc2047)
+static bstring decode_q_segment(bstring line, int rfc2047)
 {
-	char *otend = ot + otsize;
+	char *in = bdata(line);
 	int c;
-	while ((c = *in++) != 0 && (in <= ep)) {
-		if (ot == otend) {
-			*--ot = '\0';
-			return -1;
-		}
+	bstring out = bfromcstralloc(blength(line), "");
+
+	while ((c = *in++) != 0) {
 		if (c == '=') {
 			int d = *in++;
 			if (d == '\n' || !d)
 				break; /* drop trailing newline */
-			*ot++ = ((hexval(d) << 4) | hexval(*in++));
+			bconchar(out, (hexval(d) << 4) | hexval(*in++));
 			continue;
 		}
 		if (rfc2047 && c == '_') /* rfc2047 4.2 (2) */
 			c = 0x20;
-		*ot++ = c;
+		bconchar(out, c);
 	}
-	*ot = 0;
-	return 0;
+	return out;
 }
 
-static int decode_b_segment(char *in, char *ot, unsigned otsize, char *ep)
+static bstring decode_b_segment(bstring line)
 {
 	/* Decode in..ep, possibly in-place to ot */
 	int c, pos = 0, acc = 0;
-	char *otend = ot + otsize;
+	char *in = bdata(line);
+	bstring out;
 
-	while ((c = *in++) != 0 && (in <= ep)) {
-		if (ot == otend) {
-			*--ot = '\0';
-			return -1;
-		}
+	out = bfromcstralloc(blength(line), "");
+	while ((c = *in++) != 0) {
 		if (c == '+')
 			c = 62;
 		else if (c == '/')
@@ -491,21 +444,20 @@ static int decode_b_segment(char *in, char *ot, unsigned otsize, char *ep)
 			acc = (c << 2);
 			break;
 		case 1:
-			*ot++ = (acc | (c >> 4));
+			bconchar(out, (acc | (c >> 4)));
 			acc = (c & 15) << 4;
 			break;
 		case 2:
-			*ot++ = (acc | (c >> 2));
+			bconchar(out, (acc | (c >> 2)));
 			acc = (c & 3) << 6;
 			break;
 		case 3:
-			*ot++ = (acc | c);
+			bconchar(out, (acc | c));
 			acc = pos = 0;
 			break;
 		}
 	}
-	*ot = 0;
-	return 0;
+	return out;
 }
 
 /*
@@ -519,147 +471,174 @@ static int decode_b_segment(char *in, char *ot, unsigned otsize, char *ep)
  * Otherwise, we default to assuming it is Latin1 for historical
  * reasons.
  */
-static const char *guess_charset(const char *line, const char *target_charset)
+static bstring guess_charset(bstring line, bstring target_charset)
 {
-	if (is_encoding_utf8(target_charset)) {
-		if (is_utf8(line))
+	//FIXME: convert utf8.c to bstring
+	if (is_encoding_utf8(bdata(target_charset))) {
+		if (is_utf8(bdata(line)))
 			return NULL;
 	}
-	return "latin1";
+	return bfromcstr("latin1");
 }
 
-static void convert_to_utf8(char *line, unsigned linesize, const char *charset)
+static void convert_to_utf8(bstring line, bstring charset)
 {
-	char *out;
+	bstring out;
+	char *cout;
 
-	if (!charset || !*charset) {
-		charset = guess_charset(line, metainfo_charset);
-		if (!charset)
+	if (blength(charset) == 0) {
+		out = guess_charset(line, metainfo_charset);
+		if (!out) {
+			bdestroy(charset);
+			charset = NULL;
 			return;
+		}
+		bassign(charset, out);
+		bdestroy(out);
 	}
 
-	if (!strcmp(metainfo_charset, charset))
+	if (!bstrcmp(metainfo_charset, charset))
 		return;
-	out = reencode_string(line, metainfo_charset, charset);
-	if (!out)
+	//FIXME: convert utf8.c to use bstring
+	cout = reencode_string(bdata(line), bdata(metainfo_charset), bdata(charset));
+	if (!cout)
 		die("cannot convert from %s to %s\n",
-		    charset, metainfo_charset);
-	strlcpy(line, out, linesize);
-	free(out);
+		    bdata(charset), bdata(metainfo_charset));
+	bassigncstr(line, cout);
 }
 
-static int decode_header_bq(char *it, unsigned itsize)
+static int decode_header_bq(bstring line)
 {
-	char *in, *out, *ep, *cp, *sp;
-	char outbuf[1000];
+	bstring out;
+	bstring decoded = NULL, charset_q = NULL, tmp;
 	int rfc2047 = 0;
+	int in = 0, cp, ep;
 
-	in = it;
-	out = outbuf;
-	while ((ep = strstr(in, "=?")) != NULL) {
-		int sz, encoding;
-		char charset_q[256], piecebuf[256];
+	struct tagbstring cmp_eq_qst = bsStatic("=?");
+	struct tagbstring cmp_qst_eq = bsStatic("?=");
+
+	out = bfromcstralloc(blength(line), "");
+
+	while ((ep = binstr(line, 0, &cmp_eq_qst)) != BSTR_ERR) {
+		int encoding;
 		rfc2047 = 1;
 
-		if (in != ep) {
-			sz = ep - in;
-			memcpy(out, in, sz);
-			out += sz;
-			in += sz;
-		}
+		bcatblk(out, bdataofs(line, in), ep - in);
+		in += ep - in + 2;
 		/* E.g.
 		 * ep : "=?iso-2022-jp?B?GyR...?= foo"
 		 * ep : "=?ISO-8859-1?Q?Foo=FCbar?= baz"
 		 */
-		ep += 2;
-		cp = strchr(ep, '?');
-		if (!cp)
-			return rfc2047; /* no munging */
-		for (sp = ep; sp < cp; sp++)
-			charset_q[sp - ep] = tolower(*sp);
-		charset_q[cp - ep] = 0;
-		encoding = cp[1];
-		if (!encoding || cp[2] != '?')
-			return rfc2047; /* no munging */
-		ep = strstr(cp + 3, "?=");
-		if (!ep)
-			return rfc2047; /* no munging */
+
+		cp = bstrchrp(line, in, '?');
+		if (cp == BSTR_ERR)
+			goto out0; /* no munging */
+
+		charset_q = bmidstr(line, in, cp - in);
+		if (charset_q->slen)
+			btolower(charset_q);
+
+		if (line->slen < cp + 2)
+			goto out1;
+			//die("Bad header: %s,", line->data);
+
+		encoding = bchar(line, cp + 1);
+		if (!encoding || bchar(line, cp + 2) != '?')
+			goto out1; /* no munging */
+		ep = binstr(line, cp + 3, &cmp_qst_eq);
+		if (ep == BSTR_ERR)
+			goto out1; /* no munging */
 		switch (tolower(encoding)) {
 		default:
-			return rfc2047; /* no munging */
+			goto out1; /* no munging */
 		case 'b':
-			sz = decode_b_segment(cp + 3, piecebuf, sizeof(piecebuf), ep);
+			//FIXME: use bmid2tbstr ?
+			// Needs to change the decode function to not look for null
+			tmp = bmidstr(line, cp + 3, ep - cp -3);
+			decoded = decode_b_segment(tmp);
 			break;
 		case 'q':
-			sz = decode_q_segment(cp + 3, piecebuf, sizeof(piecebuf), ep, 1);
+			tmp = bmidstr(line, cp + 3, ep - cp -3);
+			decoded = decode_q_segment(tmp, 1);
 			break;
 		}
-		if (sz < 0)
-			return rfc2047;
+		bdestroy(tmp);
+		if (decoded == NULL)
+			goto out1;
 		if (metainfo_charset)
-			convert_to_utf8(piecebuf, sizeof(piecebuf), charset_q);
+			convert_to_utf8(decoded, charset_q);
 
-		sz = strlen(piecebuf);
-		if (outbuf + sizeof(outbuf) <= out + sz)
-			return rfc2047; /* no munging */
-		strcpy(out, piecebuf);
-		out += sz;
+		bconcat(out, decoded);
 		in = ep + 2;
+
+		bdestroy(decoded);
+		bdestroy(charset_q);
 	}
-	strcpy(out, in);
-	strlcpy(it, outbuf, itsize);
+	/* Add the remainder of the line. */
+	bcatblk(out, bdataofs(line, in), blength(line) - in);
+
+	bassign(line, out);
+
+	bdestroy(decoded);
+out1:
+	bdestroy(charset_q);
+out0:
+	bdestroy(out);
 	return rfc2047;
 }
 
-static void decode_header(char *it, unsigned itsize)
+static void decode_header(bstring line)
 {
-
-	if (decode_header_bq(it, itsize))
+	if (decode_header_bq(line))
 		return;
 	/* otherwise "it" is a straight copy of the input.
 	 * This can be binary guck but there is no charset specified.
 	 */
 	if (metainfo_charset)
-		convert_to_utf8(it, itsize, "");
+		convert_to_utf8(line, NULL);
 }
 
-static void decode_transfer_encoding(char *line, unsigned linesize)
+static void decode_transfer_encoding(bstring line)
 {
-	char *ep;
+	bstring ret = NULL;
 
 	switch (transfer_encoding) {
 	case TE_QP:
-		ep = line + strlen(line);
-		decode_q_segment(line, line, linesize, ep, 0);
+		ret = decode_q_segment(line, 0);
 		break;
 	case TE_BASE64:
-		ep = line + strlen(line);
-		decode_b_segment(line, line, linesize, ep);
+		ret = decode_b_segment(line);
 		break;
 	case TE_DONTCARE:
 		break;
 	}
+	if (ret)
+		bassign(line, ret);
+	bdestroy(ret);
 }
 
-static int handle_filter(char *line, unsigned linesize);
+static int handle_filter(bstring line);
 
-static int find_boundary(void)
+static int find_boundary(struct bStream *in, bstring line)
 {
-	while(fgets(line, sizeof(line), fin) != NULL) {
+	while(bsreadln(line, in, '\n') != BSTR_ERR) {
 		if (is_multipart_boundary(line))
 			return 1;
 	}
 	return 0;
 }
 
-static int handle_boundary(void)
+static int handle_boundary(struct bStream *in, bstring line)
 {
-	char newline[]="\n";
+	struct tagbstring newline = bsStatic("\n");
+	char *c;
 again:
-	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
+	if (blength(line) >= blength(content_top->boundary) + 2 &&
+	    (c = bdataofs(line, blength(content_top->boundary))) &&
+	    !memcmp(c, "--", 2)) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
-		free(content_top->boundary);
+		bdestroy(content_top->boundary);
 
 		/* technically won't happen as is_multipart_boundary()
 		   will fail first.  But just in case..
@@ -669,49 +648,52 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(newline, sizeof(newline));
+		handle_filter(&newline);
 
 		/* skip to the next boundary */
-		if (!find_boundary())
+		if (!find_boundary(in, line)) {
+			bsunread(in, line);
 			return 0;
+		}
 		goto again;
 	}
 
 	/* set some defaults */
 	transfer_encoding = TE_DONTCARE;
-	charset[0] = 0;
+	bassigncstr(charset, "");
 	message_type = TYPE_TEXT;
 
 	/* slurp in this section's info */
-	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, sizeof(line), p_hdr_data, 0);
+	while (read_one_header_line(in, line))
+		check_header(line, p_hdr_data, 0);
 
 	/* eat the blank line after section info */
-	return (fgets(line, sizeof(line), fin) != NULL);
+	return (bsreadln(line, in, '\n') != BSTR_ERR);
 }
 
-static inline int patchbreak(const char *line)
+static inline int patchbreak(const_bstring line)
 {
+	int i;
+
 	/* Beginning of a "diff -" header? */
-	if (!memcmp("diff -", line, 6))
+	if (!bisstemeqblk(line, bsStaticBlkParms("diff -")))
 		return 1;
 
 	/* CVS "Index: " line? */
-	if (!memcmp("Index: ", line, 7))
+	if (!bisstemeqblk(line, bsStaticBlkParms("Index: ")))
 		return 1;
 
 	/*
 	 * "--- <filename>" starts patches without headers
 	 * "---<sp>*" is a manual separator
 	 */
-	if (!memcmp("---", line, 3)) {
-		line += 3;
+	if (!bisstemeqblk(line, bsStaticBlkParms("---"))) {
 		/* space followed by a filename? */
-		if (line[0] == ' ' && !isspace(line[1]))
+		if (bchar(line, 3) == ' ' && !isspace(bchar(line, 4)))
 			return 1;
 		/* Just whitespace? */
-		for (;;) {
-			unsigned char c = *line++;
+		for (i = 3; i < blength(line); i++) {
+			unsigned char c = bchar(line, i);
 			if (c == '\n')
 				return 1;
 			if (!isspace(c))
@@ -723,31 +705,25 @@ static inline int patchbreak(const char *line)
 }
 
 
-static int handle_commit_msg(char *line, unsigned linesize)
+static int handle_commit_msg(bstring line)
 {
 	static int still_looking = 1;
-	char *endline = line + linesize;
+	char *c;
 
 	if (!cmitmsg)
 		return 0;
 
 	if (still_looking) {
-		char *cp = line;
-		if (isspace(*line)) {
-			for (cp = line + 1; *cp; cp++) {
-				if (!isspace(*cp))
-					break;
-			}
-			if (!*cp)
-				return 0;
-		}
-		if ((still_looking = check_header(cp, endline - cp, s_hdr_data, 0)) != 0)
+		brtrimws(line);
+		if (blength(line) == 0)
+			return 0;
+		if ((still_looking = check_header(line, s_hdr_data, 0)) != 0)
 			return 0;
 	}
 
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
-		convert_to_utf8(line, endline - line, charset);
+		convert_to_utf8(line, charset);
 
 	if (patchbreak(line)) {
 		fclose(cmitmsg);
@@ -755,18 +731,24 @@ static int handle_commit_msg(char *line, unsigned linesize)
 		return 1;
 	}
 
-	fputs(line, cmitmsg);
+	if ((c = bdata(line)) == NULL)
+		die("Programming error: line had no data\n");
+	fputs(c, cmitmsg);
 	return 0;
 }
 
-static int handle_patch(char *line)
+static int handle_patch(const_bstring line)
 {
-	fputs(line, patchfile);
+	char *c;
+
+	if ((c = bdata(line)) == NULL)
+		die("Programming error: patch line had no data\n");
+	fputs(c, patchfile);
 	patch_lines++;
 	return 0;
 }
 
-static int handle_filter(char *line, unsigned linesize)
+static int handle_filter(bstring line)
 {
 	static int filter = 0;
 
@@ -775,7 +757,7 @@ static int handle_filter(char *line, unsigned linesize)
 	 */
 	switch (filter) {
 	case 0:
-		if (!handle_commit_msg(line, linesize))
+		if (!handle_commit_msg(line))
 			break;
 		filter++;
 	case 1:
@@ -789,16 +771,19 @@ static int handle_filter(char *line, unsigned linesize)
 	return 0;
 }
 
-static void handle_body(void)
+static void handle_body(struct bStream *in)
 {
-	int rc = 0;
-	static char newline[2000];
-	static char *np = newline;
+	//FIXME: bdestroy line. unread line in more places?
+	bstring line;
+	int rc = 0, i, end;
 
+	line = bfromcstr("");
 	/* Skip up to the first boundary */
-	if (content_top->boundary) {
-		if (!find_boundary())
+	if (content_top->boundary) {//FIXME: ?
+		if (!find_boundary(in, line)) {
+			bsunread(in, line);
 			return;
+		}
 	}
 
 	do {
@@ -806,24 +791,24 @@ static void handle_body(void)
 		if (content_top->boundary && is_multipart_boundary(line)) {
 			/* flush any leftover */
 			if ((transfer_encoding == TE_BASE64)  &&
-			    (np != newline)) {
-				handle_filter(newline, sizeof(newline));
+			    (blength(line))) {
+				handle_filter(line);
 			}
-			if (!handle_boundary())
+			if (!handle_boundary(in, line))
 				return;
 		}
 
 		/* Unwrap transfer encoding */
-		decode_transfer_encoding(line, sizeof(line));
+		decode_transfer_encoding(line);
 
 		switch (transfer_encoding) {
 		case TE_BASE64:
 		{
-			char *op = line;
+			struct bstrList *lines;
 
 			/* binary data most likely doesn't have newlines */
 			if (message_type != TYPE_TEXT) {
-				rc = handle_filter(line, sizeof(newline));
+				rc = handle_filter(line);
 				break;
 			}
 
@@ -832,54 +817,55 @@ static void handle_body(void)
 			 * at a time to handle_filter()
 			 */
 
-			do {
-				while (*op != '\n' && *op != 0)
-					*np++ = *op++;
-				*np = *op;
-				if (*np != 0) {
-					/* should be sitting on a new line */
-					*(++np) = 0;
-					op++;
-					rc = handle_filter(newline, sizeof(newline));
-					np = newline;
-				}
-			} while (*op != 0);
-			/* the partial chunk is saved in newline and
+			lines = bsplit(line, '\n');
+			end = lines->qty - 1;
+			/* the partial chunk is saved in line and
 			 * will be appended by the next iteration of fgets
 			 */
+			if (bchar(line, blength(line) - 1) != '\n') {
+				bassign(line, lines->entry[end]);
+				end--;
+			} else
+				btrunc(line, 0);
+			for (i = 0; i <= end; i++)
+				rc = handle_filter(lines->entry[i]);
+
+			bstrListDestroy(lines);
 			break;
 		}
 		default:
-			rc = handle_filter(line, sizeof(newline));
+			rc = handle_filter(line);
+			btrunc(line, 0);
 		}
 		if (rc)
 			/* nothing left to filter */
 			break;
-	} while (fgets(line, sizeof(line), fin));
+	} while (bsreadlna(line, in, '\n') != BSTR_ERR);
 
 	return;
 }
 
-static void output_header_lines(FILE *fout, const char *hdr, char *data)
+static void output_header_lines(FILE *fout, const char *hdr, const_bstring data)
 {
+	char *sp;
+	sp = bdata(data);
 	while (1) {
-		char *ep = strchr(data, '\n');
+		char *ep = strchr(sp, '\n');
 		int len;
 		if (!ep)
-			len = strlen(data);
+			len = strlen(sp);
 		else
-			len = ep - data;
-		fprintf(fout, "%s: %.*s\n", hdr, len, data);
+			len = ep - sp;
+		fprintf(fout, "%s: %.*s\n", hdr, len, sp);
 		if (!ep)
 			break;
-		data = ep + 1;
+		sp = ep + 1;
 	}
 }
 
 static void handle_info(void)
 {
-	char *sub;
-	char *hdr;
+	bstring hdr;
 	int i;
 
 	for (i = 0; header[i]; i++) {
@@ -893,32 +879,32 @@ static void handle_info(void)
 			continue;
 
 		if (!memcmp(header[i], "Subject", 7)) {
-			if (keep_subject)
-				sub = hdr;
-			else {
-				sub = cleanup_subject(hdr);
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
+			fprintf(fout, "Author: %s\n", bdata(name));
+			fprintf(fout, "Email: %s\n", bdata(email));
 		} else {
 			cleanup_space(hdr);
-			fprintf(fout, "%s: %s\n", header[i], hdr);
+			fprintf(fout, "%s: %s\n", header[i], bdata(hdr));
 		}
 	}
 	fprintf(fout, "\n");
 }
 
-static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
+static int mailinfo(FILE *in, FILE *out, int ks, const_bstring encoding,
 		    const char *msg, const char *patch)
 {
 	keep_subject = ks;
-	metainfo_charset = encoding;
+	metainfo_charset = bstrcpy(encoding);
 	fin = in;
 	fout = out;
+	bstring line;
+	struct bStream *in_stream = bsopen((bNread) fread, in);
 
 	cmitmsg = fopen(msg, "w");
 	if (!cmitmsg) {
@@ -932,14 +918,17 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 		return -1;
 	}
 
-	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
-	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
+	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*p_hdr_data));
+	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*s_hdr_data));
 
 	/* process the email header */
-	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, sizeof(line), p_hdr_data, 1);
+	line = bfromcstr("");
+	while (read_one_header_line(in_stream, line))
+		check_header(line, p_hdr_data, 1);
 
-	handle_body();
+	bsunread(in_stream, line);
+	
+	handle_body(in_stream);
 	handle_info();
 
 	return 0;
@@ -958,17 +947,17 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config);
 
 	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
-	metainfo_charset = def_charset;
+	metainfo_charset = bfromcstr(def_charset);
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
 		else if (!strcmp(argv[1], "-u"))
-			metainfo_charset = def_charset;
+			bassigncstr(metainfo_charset, def_charset);
 		else if (!strcmp(argv[1], "-n"))
 			metainfo_charset = NULL;
 		else if (!prefixcmp(argv[1], "--encoding="))
-			metainfo_charset = argv[1] + 11;
+			bassigncstr(metainfo_charset, argv[1] + 11);
 		else
 			usage(mailinfo_usage);
 		argc--; argv++;
-- 
1.5.3.rc7
