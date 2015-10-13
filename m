From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 26/26] mailinfo: libify the whole thing
Date: Tue, 13 Oct 2015 16:16:47 -0700
Message-ID: <1444778207-859-27-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pf-00079E-4R
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbbJMXSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:18:03 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36266 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbbJMXRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:20 -0400
Received: by pacex6 with SMTP id ex6so34355852pac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=fGEuHJp81HPxp2vzX3rFzzf/LExdQbjII2nB9JaJaGo=;
        b=f3QdsViAPm0ACr6q+1n8uQtcfbwtQCQaByzAmGwcwVl5KYJ90oi+wnP9KZaEdrB82s
         apbd79aO6N23YR5QfC4Vi1wgqChral7MdY2QbzMm/WVKHxMBDMbSLzgtbadYcAPS7Q9O
         bsa09BGwhz3NonhW5SNh3b5QaoJD8eGChQ/mZM4NFU2mlylX0+PqrbcfJoo5QPD5ZJQ+
         7cA193OXrUfxN82426YK9vVpGYy5siSEUwncQT2B6qthDPNIUuI9+AuSAVcizdr1fK1N
         Qv+IXjTpLHxc+Krm9/HGDZtfReLYCTUc1pMrVNE1TjDDF1w0s2NKFrm+BOo3dOj61RDx
         YE+A==
X-Received: by 10.66.235.4 with SMTP id ui4mr42799782pac.129.1444778240393;
        Tue, 13 Oct 2015 16:17:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id w9sm5845409pbt.29.2015.10.13.16.17.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:19 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279549>

With this, the builtin "git am" can hopefully make an internal call
to the mailinfo() function without going through the run_command()
interface, whose overhead is heavyweight compared to what mailinfo()
itself does on some platforms.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile           |    1 +
 builtin/mailinfo.c | 1091 +---------------------------------------------------
 mailinfo.c         | 1058 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mailinfo.h         |   41 ++
 4 files changed, 1101 insertions(+), 1090 deletions(-)
 create mode 100644 mailinfo.c
 create mode 100644 mailinfo.h

diff --git a/Makefile b/Makefile
index 8d5df7e..7dd3bff 100644
--- a/Makefile
+++ b/Makefile
@@ -726,6 +726,7 @@ LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge.o
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index eb9ff96..f6df274 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -6,1096 +6,7 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "strbuf.h"
-
-#define MAX_BOUNDARIES 5
-
-struct mailinfo {
-	FILE *input;
-	FILE *output;
-	FILE *patchfile;
-
-	struct strbuf name;
-	struct strbuf email;
-	int keep_subject;
-	int keep_non_patch_brackets_in_subject;
-	int add_message_id;
-	int use_scissors;
-	int use_inbody_headers; /* defaults to 1 */
-	const char *metainfo_charset;
-
-	struct strbuf *content[MAX_BOUNDARIES];
-	struct strbuf **content_top;
-	struct strbuf charset;
-	char *message_id;
-	enum  {
-		TE_DONTCARE, TE_QP, TE_BASE64
-	} transfer_encoding;
-	int patch_lines;
-	int filter_stage; /* still reading log or are we copying patch? */
-	int header_stage; /* still checking in-body headers? */
-	struct strbuf **p_hdr_data;
-	struct strbuf **s_hdr_data;
-
-	struct strbuf log_message;
-	int input_error;
-};
-
-#define MAX_HDR_PARSED 10
-
-static void cleanup_space(struct strbuf *sb);
-
-
-static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
-{
-	struct strbuf *src = name;
-	if (name->len < 3 || 60 < name->len || strchr(name->buf, '@') ||
-		strchr(name->buf, '<') || strchr(name->buf, '>'))
-		src = email;
-	else if (name == out)
-		return;
-	strbuf_reset(out);
-	strbuf_addbuf(out, src);
-}
-
-static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
-{
-	/* John Doe <johndoe> */
-
-	char *bra, *ket;
-	/* This is fallback, so do not bother if we already have an
-	 * e-mail address.
-	 */
-	if (mi->email.len)
-		return;
-
-	bra = strchr(line->buf, '<');
-	if (!bra)
-		return;
-	ket = strchr(bra, '>');
-	if (!ket)
-		return;
-
-	strbuf_reset(&mi->email);
-	strbuf_add(&mi->email, bra + 1, ket - bra - 1);
-
-	strbuf_reset(&mi->name);
-	strbuf_add(&mi->name, line->buf, bra - line->buf);
-	strbuf_trim(&mi->name);
-	get_sane_name(&mi->name, &mi->name, &mi->email);
-}
-
-static void handle_from(struct mailinfo *mi, const struct strbuf *from)
-{
-	char *at;
-	size_t el;
-	struct strbuf f;
-
-	strbuf_init(&f, from->len);
-	strbuf_addbuf(&f, from);
-
-	at = strchr(f.buf, '@');
-	if (!at) {
-		parse_bogus_from(mi, from);
-		return;
-	}
-
-	/*
-	 * If we already have one email, don't take any confusing lines
-	 */
-	if (mi->email.len && strchr(at + 1, '@')) {
-		strbuf_release(&f);
-		return;
-	}
-
-	/* Pick up the string around '@', possibly delimited with <>
-	 * pair; that is the email part.
-	 */
-	while (at > f.buf) {
-		char c = at[-1];
-		if (isspace(c))
-			break;
-		if (c == '<') {
-			at[-1] = ' ';
-			break;
-		}
-		at--;
-	}
-	el = strcspn(at, " \n\t\r\v\f>");
-	strbuf_reset(&mi->email);
-	strbuf_add(&mi->email, at, el);
-	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
-
-	/* The remainder is name.  It could be
-	 *
-	 * - "John Doe <john.doe@xz>"			(a), or
-	 * - "john.doe@xz (John Doe)"			(b), or
-	 * - "John (zzz) Doe <john.doe@xz> (Comment)"	(c)
-	 *
-	 * but we have removed the email part, so
-	 *
-	 * - remove extra spaces which could stay after email (case 'c'), and
-	 * - trim from both ends, possibly removing the () pair at the end
-	 *   (cases 'a' and 'b').
-	 */
-	cleanup_space(&f);
-	strbuf_trim(&f);
-	if (f.buf[0] == '(' && f.len && f.buf[f.len - 1] == ')') {
-		strbuf_remove(&f, 0, 1);
-		strbuf_setlen(&f, f.len - 1);
-	}
-
-	get_sane_name(&mi->name, &f, &mi->email);
-	strbuf_release(&f);
-}
-
-static void handle_header(struct strbuf **out, const struct strbuf *line)
-{
-	if (!*out) {
-		*out = xmalloc(sizeof(struct strbuf));
-		strbuf_init(*out, line->len);
-	} else
-		strbuf_reset(*out);
-
-	strbuf_addbuf(*out, line);
-}
-
-/* NOTE NOTE NOTE.  We do not claim we do full MIME.  We just attempt
- * to have enough heuristics to grok MIME encoded patches often found
- * on our mailing lists.  For example, we do not even treat header lines
- * case insensitively.
- */
-
-static int slurp_attr(const char *line, const char *name, struct strbuf *attr)
-{
-	const char *ends, *ap = strcasestr(line, name);
-	size_t sz;
-
-	strbuf_setlen(attr, 0);
-	if (!ap)
-		return 0;
-	ap += strlen(name);
-	if (*ap == '"') {
-		ap++;
-		ends = "\"";
-	}
-	else
-		ends = "; \t";
-	sz = strcspn(ap, ends);
-	strbuf_add(attr, ap, sz);
-	return 1;
-}
-
-static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
-{
-	struct strbuf *boundary = xmalloc(sizeof(struct strbuf));
-	strbuf_init(boundary, line->len);
-
-	if (slurp_attr(line->buf, "boundary=", boundary)) {
-		strbuf_insert(boundary, 0, "--", 2);
-		if (++mi->content_top >= &mi->content[MAX_BOUNDARIES]) {
-			error("Too many boundaries to handle");
-			mi->input_error = -1;
-			mi->content_top = mi->content + MAX_BOUNDARIES - 1;
-			return;
-		}
-		*(mi->content_top) = boundary;
-		boundary = NULL;
-	}
-	slurp_attr(line->buf, "charset=", &mi->charset);
-
-	if (boundary) {
-		strbuf_release(boundary);
-		free(boundary);
-	}
-}
-
-static void handle_message_id(struct mailinfo *mi, const struct strbuf *line)
-{
-	if (mi->add_message_id)
-		mi->message_id = strdup(line->buf);
-}
-
-static void handle_content_transfer_encoding(struct mailinfo *mi,
-					     const struct strbuf *line)
-{
-	if (strcasestr(line->buf, "base64"))
-		mi->transfer_encoding = TE_BASE64;
-	else if (strcasestr(line->buf, "quoted-printable"))
-		mi->transfer_encoding = TE_QP;
-	else
-		mi->transfer_encoding = TE_DONTCARE;
-}
-
-static int is_multipart_boundary(struct mailinfo *mi, const struct strbuf *line)
-{
-	struct strbuf *content_top = *(mi->content_top);
-
-	return ((content_top->len <= line->len) &&
-		!memcmp(line->buf, content_top->buf, content_top->len));
-}
-
-static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
-{
-	size_t at = 0;
-
-	while (at < subject->len) {
-		char *pos;
-		size_t remove;
-
-		switch (subject->buf[at]) {
-		case 'r': case 'R':
-			if (subject->len <= at + 3)
-				break;
-			if ((subject->buf[at + 1] == 'e' ||
-			     subject->buf[at + 1] == 'E') &&
-			    subject->buf[at + 2] == ':') {
-				strbuf_remove(subject, at, 3);
-				continue;
-			}
-			at++;
-			break;
-		case ' ': case '\t': case ':':
-			strbuf_remove(subject, at, 1);
-			continue;
-		case '[':
-			pos = strchr(subject->buf + at, ']');
-			if (!pos)
-				break;
-			remove = pos - subject->buf + at + 1;
-			if (!mi->keep_non_patch_brackets_in_subject ||
-			    (7 <= remove &&
-			     memmem(subject->buf + at, remove, "PATCH", 5)))
-				strbuf_remove(subject, at, remove);
-			else {
-				at += remove;
-				/*
-				 * If the input had a space after the ], keep
-				 * it.  We don't bother with finding the end of
-				 * the space, since we later normalize it
-				 * anyway.
-				 */
-				if (isspace(subject->buf[at]))
-					at += 1;
-			}
-			continue;
-		}
-		break;
-	}
-	strbuf_trim(subject);
-}
-
-static void cleanup_space(struct strbuf *sb)
-{
-	size_t pos, cnt;
-	for (pos = 0; pos < sb->len; pos++) {
-		if (isspace(sb->buf[pos])) {
-			sb->buf[pos] = ' ';
-			for (cnt = 0; isspace(sb->buf[pos + cnt + 1]); cnt++);
-			strbuf_remove(sb, pos + 1, cnt);
-		}
-	}
-}
-
-static int decode_header(struct mailinfo *mi, struct strbuf *line);
-static const char *header[MAX_HDR_PARSED] = {
-	"From","Subject","Date",
-};
-
-static inline int cmp_header(const struct strbuf *line, const char *hdr)
-{
-	int len = strlen(hdr);
-	return !strncasecmp(line->buf, hdr, len) && line->len > len &&
-			line->buf[len] == ':' && isspace(line->buf[len + 1]);
-}
-
-static int is_format_patch_separator(const char *line, int len)
-{
-	static const char SAMPLE[] =
-		"From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n";
-	const char *cp;
-
-	if (len != strlen(SAMPLE))
-		return 0;
-	if (!skip_prefix(line, "From ", &cp))
-		return 0;
-	if (strspn(cp, "0123456789abcdef") != 40)
-		return 0;
-	cp += 40;
-	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
-}
-
-static int check_header(struct mailinfo *mi,
-			const struct strbuf *line,
-			struct strbuf *hdr_data[], int overwrite)
-{
-	int i, ret = 0, len;
-	struct strbuf sb = STRBUF_INIT;
-
-	/* search for the interesting parts */
-	for (i = 0; header[i]; i++) {
-		int len = strlen(header[i]);
-		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i])) {
-			/* Unwrap inline B and Q encoding, and optionally
-			 * normalize the meta information to utf8.
-			 */
-			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
-			if (!decode_header(mi, &sb))
-				handle_header(&hdr_data[i], &sb);
-			ret = 1;
-			goto check_header_out;
-		}
-	}
-
-	/* Content stuff */
-	if (cmp_header(line, "Content-Type")) {
-		len = strlen("Content-Type: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
-		if (!decode_header(mi, &sb)) {
-			strbuf_insert(&sb, 0, "Content-Type: ", len);
-			handle_content_type(mi, &sb);
-		}
-		ret = 1;
-		goto check_header_out;
-	}
-	if (cmp_header(line, "Content-Transfer-Encoding")) {
-		len = strlen("Content-Transfer-Encoding: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
-		if (!decode_header(mi, &sb))
-			handle_content_transfer_encoding(mi, &sb);
-		ret = 1;
-		goto check_header_out;
-	}
-	if (cmp_header(line, "Message-Id")) {
-		len = strlen("Message-Id: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
-		if (!decode_header(mi, &sb))
-			handle_message_id(mi, &sb);
-		ret = 1;
-		goto check_header_out;
-	}
-
-	/* for inbody stuff */
-	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
-		ret = is_format_patch_separator(line->buf + 1, line->len - 1);
-		goto check_header_out;
-	}
-	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
-		for (i = 0; header[i]; i++) {
-			if (!strcmp("Subject", header[i])) {
-				handle_header(&hdr_data[i], line);
-				ret = 1;
-				goto check_header_out;
-			}
-		}
-	}
-
-check_header_out:
-	strbuf_release(&sb);
-	return ret;
-}
-
-static int is_rfc2822_header(const struct strbuf *line)
-{
-	/*
-	 * The section that defines the loosest possible
-	 * field name is "3.6.8 Optional fields".
-	 *
-	 * optional-field = field-name ":" unstructured CRLF
-	 * field-name = 1*ftext
-	 * ftext = %d33-57 / %59-126
-	 */
-	int ch;
-	char *cp = line->buf;
-
-	/* Count mbox From headers as headers */
-	if (starts_with(cp, "From ") || starts_with(cp, ">From "))
-		return 1;
-
-	while ((ch = *cp++)) {
-		if (ch == ':')
-			return 1;
-		if ((33 <= ch && ch <= 57) ||
-		    (59 <= ch && ch <= 126))
-			continue;
-		break;
-	}
-	return 0;
-}
-
-static int read_one_header_line(struct strbuf *line, FILE *in)
-{
-	/* Get the first part of the line. */
-	if (strbuf_getline(line, in, '\n'))
-		return 0;
-
-	/*
-	 * Is it an empty line or not a valid rfc2822 header?
-	 * If so, stop here, and return false ("not a header")
-	 */
-	strbuf_rtrim(line);
-	if (!line->len || !is_rfc2822_header(line)) {
-		/* Re-add the newline */
-		strbuf_addch(line, '\n');
-		return 0;
-	}
-
-	/*
-	 * Now we need to eat all the continuation lines..
-	 * Yuck, 2822 header "folding"
-	 */
-	for (;;) {
-		int peek;
-		struct strbuf continuation = STRBUF_INIT;
-
-		peek = fgetc(in); ungetc(peek, in);
-		if (peek != ' ' && peek != '\t')
-			break;
-		if (strbuf_getline(&continuation, in, '\n'))
-			break;
-		continuation.buf[0] = ' ';
-		strbuf_rtrim(&continuation);
-		strbuf_addbuf(line, &continuation);
-	}
-
-	return 1;
-}
-
-static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
-{
-	const char *in = q_seg->buf;
-	int c;
-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
-	strbuf_init(out, q_seg->len);
-
-	while ((c = *in++) != 0) {
-		if (c == '=') {
-			int d = *in++;
-			if (d == '\n' || !d)
-				break; /* drop trailing newline */
-			strbuf_addch(out, (hexval(d) << 4) | hexval(*in++));
-			continue;
-		}
-		if (rfc2047 && c == '_') /* rfc2047 4.2 (2) */
-			c = 0x20;
-		strbuf_addch(out, c);
-	}
-	return out;
-}
-
-static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
-{
-	/* Decode in..ep, possibly in-place to ot */
-	int c, pos = 0, acc = 0;
-	const char *in = b_seg->buf;
-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
-	strbuf_init(out, b_seg->len);
-
-	while ((c = *in++) != 0) {
-		if (c == '+')
-			c = 62;
-		else if (c == '/')
-			c = 63;
-		else if ('A' <= c && c <= 'Z')
-			c -= 'A';
-		else if ('a' <= c && c <= 'z')
-			c -= 'a' - 26;
-		else if ('0' <= c && c <= '9')
-			c -= '0' - 52;
-		else
-			continue; /* garbage */
-		switch (pos++) {
-		case 0:
-			acc = (c << 2);
-			break;
-		case 1:
-			strbuf_addch(out, (acc | (c >> 4)));
-			acc = (c & 15) << 4;
-			break;
-		case 2:
-			strbuf_addch(out, (acc | (c >> 2)));
-			acc = (c & 3) << 6;
-			break;
-		case 3:
-			strbuf_addch(out, (acc | c));
-			acc = pos = 0;
-			break;
-		}
-	}
-	return out;
-}
-
-static int convert_to_utf8(struct mailinfo *mi,
-			   struct strbuf *line, const char *charset)
-{
-	char *out;
-
-	if (!mi->metainfo_charset || !charset || !*charset)
-		return 0;
-
-	if (same_encoding(mi->metainfo_charset, charset))
-		return 0;
-	out = reencode_string(line->buf, mi->metainfo_charset, charset);
-	if (!out) {
-		mi->input_error = -1;
-		return error("cannot convert from %s to %s",
-			     charset, mi->metainfo_charset);
-	}
-	strbuf_attach(line, out, strlen(out), strlen(out));
-	return 0;
-}
-
-static int decode_header(struct mailinfo *mi, struct strbuf *it)
-{
-	char *in, *ep, *cp;
-	struct strbuf outbuf = STRBUF_INIT, *dec;
-	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
-	int found_error = -1; /* pessimism */
-
-	in = it->buf;
-	while (in - it->buf <= it->len && (ep = strstr(in, "=?")) != NULL) {
-		int encoding;
-		strbuf_reset(&charset_q);
-		strbuf_reset(&piecebuf);
-
-		if (in != ep) {
-			/*
-			 * We are about to process an encoded-word
-			 * that begins at ep, but there is something
-			 * before the encoded word.
-			 */
-			char *scan;
-			for (scan = in; scan < ep; scan++)
-				if (!isspace(*scan))
-					break;
-
-			if (scan != ep || in == it->buf) {
-				/*
-				 * We should not lose that "something",
-				 * unless we have just processed an
-				 * encoded-word, and there is only LWS
-				 * before the one we are about to process.
-				 */
-				strbuf_add(&outbuf, in, ep - in);
-			}
-		}
-		/* E.g.
-		 * ep : "=?iso-2022-jp?B?GyR...?= foo"
-		 * ep : "=?ISO-8859-1?Q?Foo=FCbar?= baz"
-		 */
-		ep += 2;
-
-		if (ep - it->buf >= it->len || !(cp = strchr(ep, '?')))
-			goto release_return;
-
-		if (cp + 3 - it->buf > it->len)
-			goto release_return;
-		strbuf_add(&charset_q, ep, cp - ep);
-
-		encoding = cp[1];
-		if (!encoding || cp[2] != '?')
-			goto release_return;
-		ep = strstr(cp + 3, "?=");
-		if (!ep)
-			goto release_return;
-		strbuf_add(&piecebuf, cp + 3, ep - cp - 3);
-		switch (tolower(encoding)) {
-		default:
-			goto release_return;
-		case 'b':
-			dec = decode_b_segment(&piecebuf);
-			break;
-		case 'q':
-			dec = decode_q_segment(&piecebuf, 1);
-			break;
-		}
-		if (convert_to_utf8(mi, dec, charset_q.buf))
-			goto release_return;
-
-		strbuf_addbuf(&outbuf, dec);
-		strbuf_release(dec);
-		free(dec);
-		in = ep + 2;
-	}
-	strbuf_addstr(&outbuf, in);
-	strbuf_reset(it);
-	strbuf_addbuf(it, &outbuf);
-	found_error = 0;
-release_return:
-	strbuf_release(&outbuf);
-	strbuf_release(&charset_q);
-	strbuf_release(&piecebuf);
-
-	return found_error;
-}
-
-static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
-{
-	struct strbuf *ret;
-
-	switch (mi->transfer_encoding) {
-	case TE_QP:
-		ret = decode_q_segment(line, 0);
-		break;
-	case TE_BASE64:
-		ret = decode_b_segment(line);
-		break;
-	case TE_DONTCARE:
-	default:
-		return;
-	}
-	strbuf_reset(line);
-	strbuf_addbuf(line, ret);
-	strbuf_release(ret);
-	free(ret);
-}
-
-static inline int patchbreak(const struct strbuf *line)
-{
-	size_t i;
-
-	/* Beginning of a "diff -" header? */
-	if (starts_with(line->buf, "diff -"))
-		return 1;
-
-	/* CVS "Index: " line? */
-	if (starts_with(line->buf, "Index: "))
-		return 1;
-
-	/*
-	 * "--- <filename>" starts patches without headers
-	 * "---<sp>*" is a manual separator
-	 */
-	if (line->len < 4)
-		return 0;
-
-	if (starts_with(line->buf, "---")) {
-		/* space followed by a filename? */
-		if (line->buf[3] == ' ' && !isspace(line->buf[4]))
-			return 1;
-		/* Just whitespace? */
-		for (i = 3; i < line->len; i++) {
-			unsigned char c = line->buf[i];
-			if (c == '\n')
-				return 1;
-			if (!isspace(c))
-				break;
-		}
-		return 0;
-	}
-	return 0;
-}
-
-static int is_scissors_line(const struct strbuf *line)
-{
-	size_t i, len = line->len;
-	int scissors = 0, gap = 0;
-	int first_nonblank = -1;
-	int last_nonblank = 0, visible, perforation = 0, in_perforation = 0;
-	const char *buf = line->buf;
-
-	for (i = 0; i < len; i++) {
-		if (isspace(buf[i])) {
-			if (in_perforation) {
-				perforation++;
-				gap++;
-			}
-			continue;
-		}
-		last_nonblank = i;
-		if (first_nonblank < 0)
-			first_nonblank = i;
-		if (buf[i] == '-') {
-			in_perforation = 1;
-			perforation++;
-			continue;
-		}
-		if (i + 1 < len &&
-		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2) ||
-		     !memcmp(buf + i, ">%", 2) || !memcmp(buf + i, "%<", 2))) {
-			in_perforation = 1;
-			perforation += 2;
-			scissors += 2;
-			i++;
-			continue;
-		}
-		in_perforation = 0;
-	}
-
-	/*
-	 * The mark must be at least 8 bytes long (e.g. "-- >8 --").
-	 * Even though there can be arbitrary cruft on the same line
-	 * (e.g. "cut here"), in order to avoid misidentification, the
-	 * perforation must occupy more than a third of the visible
-	 * width of the line, and dashes and scissors must occupy more
-	 * than half of the perforation.
-	 */
-
-	visible = last_nonblank - first_nonblank + 1;
-	return (scissors && 8 <= visible &&
-		visible < perforation * 3 &&
-		gap * 2 < perforation);
-}
-
-static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
-{
-	/*
-	 * Are we still scanning and discarding in-body headers?
-	 * It is initially set to 1, set to 2 when we do see a
-	 * valid in-body header.
-	 */
-	int is_empty_line;
-
-	assert(!mi->filter_stage);
-
-	is_empty_line = (!line->len || (line->len == 1 && line->buf[0] == '\n'));
-	if (mi->header_stage == 1) {
-		/*
-		 * Haven't seen a known in-body header; discard an empty line.
-		 */
-		if (is_empty_line)
-			return 0;
-	}
-
-	if (mi->use_inbody_headers && mi->header_stage) {
-		int is_known_header = check_header(mi, line, mi->s_hdr_data, 0);
-
-		if (mi->header_stage == 2) {
-			/*
-			 * an empty line after the in-body header block,
-			 * or a line obviously not an attempt to invent
-			 * an unsupported in-body header.
-			 */
-			if (is_empty_line || !is_rfc2822_header(line))
-				mi->header_stage = 0;
-			if (is_empty_line)
-				return 0;
-			/* otherwise do not discard the line, but keep going */
-		} else if (is_known_header) {
-			mi->header_stage = 2;
-		} else if (mi->header_stage != 2) {
-			mi->header_stage = 0;
-		}
-
-		if (mi->header_stage)
-			return 0;
-	} else
-		/* Only trim the first (blank) line of the commit message
-		 * when ignoring in-body headers.
-		 */
-		mi->header_stage = 0;
-
-	/* normalize the log message to UTF-8. */
-	if (convert_to_utf8(mi, line, mi->charset.buf))
-		return 0; /* the caller will reject this input */
-
-	if (mi->use_scissors && is_scissors_line(line)) {
-		int i;
-
-		strbuf_setlen(&mi->log_message, 0);
-		mi->header_stage = 1;
-
-		/*
-		 * We may have already read "secondary headers"; purge
-		 * them to give ourselves a clean restart.
-		 */
-		for (i = 0; header[i]; i++) {
-			if (mi->s_hdr_data[i])
-				strbuf_release(mi->s_hdr_data[i]);
-			mi->s_hdr_data[i] = NULL;
-		}
-		return 0;
-	}
-
-	if (patchbreak(line)) {
-		if (mi->message_id)
-			strbuf_addf(&mi->log_message,
-				    "Message-Id: %s\n", mi->message_id);
-		return 1;
-	}
-
-	strbuf_addbuf(&mi->log_message, line);
-	return 0;
-}
-
-static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
-{
-	fwrite(line->buf, 1, line->len, mi->patchfile);
-	mi->patch_lines++;
-}
-
-static void handle_filter(struct mailinfo *mi, struct strbuf *line)
-{
-	if (mi->input_error)
-		return;
-
-	switch (mi->filter_stage) {
-	case 0:
-		if (!handle_commit_msg(mi, line))
-			break;
-		mi->filter_stage++;
-	case 1:
-		handle_patch(mi, line);
-		break;
-	}
-}
-
-static int find_boundary(struct mailinfo *mi, struct strbuf *line)
-{
-	while (!strbuf_getline(line, mi->input, '\n')) {
-		if (*(mi->content_top) && is_multipart_boundary(mi, line))
-			return 1;
-	}
-	return 0;
-}
-
-static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
-{
-	struct strbuf newline = STRBUF_INIT;
-
-	strbuf_addch(&newline, '\n');
-again:
-	if (line->len >= (*(mi->content_top))->len + 2 &&
-	    !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
-		/* we hit an end boundary */
-		/* pop the current boundary off the stack */
-		strbuf_release(*(mi->content_top));
-		free(*(mi->content_top));
-		*(mi->content_top) = NULL;
-
-		/* technically won't happen as is_multipart_boundary()
-		   will fail first.  But just in case..
-		 */
-		if (--mi->content_top < mi->content) {
-			error("Detected mismatched boundaries, can't recover");
-			mi->input_error = -1;
-			mi->content_top = mi->content;
-			return 0;
-		}
-		handle_filter(mi, &newline);
-		strbuf_release(&newline);
-		if (mi->input_error)
-			return 0; /* punt to the end */
-
-		/* skip to the next boundary */
-		if (!find_boundary(mi, line))
-			return 0;
-		goto again;
-	}
-
-	/* set some defaults */
-	mi->transfer_encoding = TE_DONTCARE;
-	strbuf_reset(&mi->charset);
-
-	/* slurp in this section's info */
-	while (read_one_header_line(line, mi->input))
-		check_header(mi, line, mi->p_hdr_data, 0);
-
-	strbuf_release(&newline);
-	/* replenish line */
-	if (strbuf_getline(line, mi->input, '\n'))
-		return 0;
-	strbuf_addch(line, '\n');
-	return 1;
-}
-
-static void handle_body(struct mailinfo *mi, struct strbuf *line)
-{
-	struct strbuf prev = STRBUF_INIT;
-
-	/* Skip up to the first boundary */
-	if (*(mi->content_top)) {
-		if (!find_boundary(mi, line))
-			goto handle_body_out;
-	}
-
-	do {
-		/* process any boundary lines */
-		if (*(mi->content_top) && is_multipart_boundary(mi, line)) {
-			/* flush any leftover */
-			if (prev.len) {
-				handle_filter(mi, &prev);
-				strbuf_reset(&prev);
-			}
-			if (!handle_boundary(mi, line))
-				goto handle_body_out;
-		}
-
-		/* Unwrap transfer encoding */
-		decode_transfer_encoding(mi, line);
-
-		switch (mi->transfer_encoding) {
-		case TE_BASE64:
-		case TE_QP:
-		{
-			struct strbuf **lines, **it, *sb;
-
-			/* Prepend any previous partial lines */
-			strbuf_insert(line, 0, prev.buf, prev.len);
-			strbuf_reset(&prev);
-
-			/*
-			 * This is a decoded line that may contain
-			 * multiple new lines.  Pass only one chunk
-			 * at a time to handle_filter()
-			 */
-			lines = strbuf_split(line, '\n');
-			for (it = lines; (sb = *it); it++) {
-				if (*(it + 1) == NULL) /* The last line */
-					if (sb->buf[sb->len - 1] != '\n') {
-						/* Partial line, save it for later. */
-						strbuf_addbuf(&prev, sb);
-						break;
-					}
-				handle_filter(mi, sb);
-			}
-			/*
-			 * The partial chunk is saved in "prev" and will be
-			 * appended by the next iteration of read_line_with_nul().
-			 */
-			strbuf_list_free(lines);
-			break;
-		}
-		default:
-			handle_filter(mi, line);
-		}
-
-		if (mi->input_error)
-			break;
-	} while (!strbuf_getwholeline(line, mi->input, '\n'));
-
-handle_body_out:
-	strbuf_release(&prev);
-}
-
-static void output_header_lines(FILE *fout, const char *hdr, const struct strbuf *data)
-{
-	const char *sp = data->buf;
-	while (1) {
-		char *ep = strchr(sp, '\n');
-		int len;
-		if (!ep)
-			len = strlen(sp);
-		else
-			len = ep - sp;
-		fprintf(fout, "%s: %.*s\n", hdr, len, sp);
-		if (!ep)
-			break;
-		sp = ep + 1;
-	}
-}
-
-static void handle_info(struct mailinfo *mi)
-{
-	struct strbuf *hdr;
-	int i;
-
-	for (i = 0; header[i]; i++) {
-		/* only print inbody headers if we output a patch file */
-		if (mi->patch_lines && mi->s_hdr_data[i])
-			hdr = mi->s_hdr_data[i];
-		else if (mi->p_hdr_data[i])
-			hdr = mi->p_hdr_data[i];
-		else
-			continue;
-
-		if (!strcmp(header[i], "Subject")) {
-			if (!mi->keep_subject) {
-				cleanup_subject(mi, hdr);
-				cleanup_space(hdr);
-			}
-			output_header_lines(mi->output, "Subject", hdr);
-		} else if (!strcmp(header[i], "From")) {
-			cleanup_space(hdr);
-			handle_from(mi, hdr);
-			fprintf(mi->output, "Author: %s\n", mi->name.buf);
-			fprintf(mi->output, "Email: %s\n", mi->email.buf);
-		} else {
-			cleanup_space(hdr);
-			fprintf(mi->output, "%s: %s\n", header[i], hdr->buf);
-		}
-	}
-	fprintf(mi->output, "\n");
-}
-
-static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
-{
-	FILE *cmitmsg;
-	int peek;
-	struct strbuf line = STRBUF_INIT;
-
-	cmitmsg = fopen(msg, "w");
-	if (!cmitmsg) {
-		perror(msg);
-		return -1;
-	}
-	mi->patchfile = fopen(patch, "w");
-	if (!mi->patchfile) {
-		perror(patch);
-		fclose(cmitmsg);
-		return -1;
-	}
-
-	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
-	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
-
-	do {
-		peek = fgetc(mi->input);
-	} while (isspace(peek));
-	ungetc(peek, mi->input);
-
-	/* process the email header */
-	while (read_one_header_line(&line, mi->input))
-		check_header(mi, &line, mi->p_hdr_data, 1);
-
-	handle_body(mi, &line);
-	if (!mi->input_error) {
-		handle_info(mi);
-		fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
-	}
-	fclose(cmitmsg);
-
-	return mi->input_error;
-}
-
-static int git_mailinfo_config(const char *var, const char *value, void *mi_)
-{
-	struct mailinfo *mi = mi_;
-
-	if (!starts_with(var, "mailinfo."))
-		return git_default_config(var, value, NULL);
-	if (!strcmp(var, "mailinfo.scissors")) {
-		mi->use_scissors = git_config_bool(var, value);
-		return 0;
-	}
-	/* perhaps others here */
-	return 0;
-}
-
-static void setup_mailinfo(struct mailinfo *mi)
-{
-	memset(mi, 0, sizeof(*mi));
-	strbuf_init(&mi->name, 0);
-	strbuf_init(&mi->email, 0);
-	strbuf_init(&mi->charset, 0);
-	strbuf_init(&mi->log_message, 0);
-	mi->header_stage = 1;
-	mi->use_inbody_headers = 1;
-	mi->content_top = mi->content;
-	git_config(git_mailinfo_config, &mi);
-}
-
-static void clear_mailinfo(struct mailinfo *mi)
-{
-	strbuf_release(&mi->name);
-	strbuf_release(&mi->email);
-	strbuf_release(&mi->charset);
-	strbuf_release(&mi->log_message);
-
-	while (mi->content < mi->content_top) {
-		free(*(mi->content_top));
-		mi->content_top--;
-	}
-}
+#include "mailinfo.h"
 
 static const char mailinfo_usage[] =
 	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
diff --git a/mailinfo.c b/mailinfo.c
new file mode 100644
index 0000000..ca40030
--- /dev/null
+++ b/mailinfo.c
@@ -0,0 +1,1058 @@
+#include "cache.h"
+#include "builtin.h"
+#include "utf8.h"
+#include "strbuf.h"
+#include "mailinfo.h"
+
+static void cleanup_space(struct strbuf *sb)
+{
+	size_t pos, cnt;
+	for (pos = 0; pos < sb->len; pos++) {
+		if (isspace(sb->buf[pos])) {
+			sb->buf[pos] = ' ';
+			for (cnt = 0; isspace(sb->buf[pos + cnt + 1]); cnt++);
+			strbuf_remove(sb, pos + 1, cnt);
+		}
+	}
+}
+
+static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
+{
+	struct strbuf *src = name;
+	if (name->len < 3 || 60 < name->len || strchr(name->buf, '@') ||
+		strchr(name->buf, '<') || strchr(name->buf, '>'))
+		src = email;
+	else if (name == out)
+		return;
+	strbuf_reset(out);
+	strbuf_addbuf(out, src);
+}
+
+static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
+{
+	/* John Doe <johndoe> */
+
+	char *bra, *ket;
+	/* This is fallback, so do not bother if we already have an
+	 * e-mail address.
+	 */
+	if (mi->email.len)
+		return;
+
+	bra = strchr(line->buf, '<');
+	if (!bra)
+		return;
+	ket = strchr(bra, '>');
+	if (!ket)
+		return;
+
+	strbuf_reset(&mi->email);
+	strbuf_add(&mi->email, bra + 1, ket - bra - 1);
+
+	strbuf_reset(&mi->name);
+	strbuf_add(&mi->name, line->buf, bra - line->buf);
+	strbuf_trim(&mi->name);
+	get_sane_name(&mi->name, &mi->name, &mi->email);
+}
+
+static void handle_from(struct mailinfo *mi, const struct strbuf *from)
+{
+	char *at;
+	size_t el;
+	struct strbuf f;
+
+	strbuf_init(&f, from->len);
+	strbuf_addbuf(&f, from);
+
+	at = strchr(f.buf, '@');
+	if (!at) {
+		parse_bogus_from(mi, from);
+		return;
+	}
+
+	/*
+	 * If we already have one email, don't take any confusing lines
+	 */
+	if (mi->email.len && strchr(at + 1, '@')) {
+		strbuf_release(&f);
+		return;
+	}
+
+	/* Pick up the string around '@', possibly delimited with <>
+	 * pair; that is the email part.
+	 */
+	while (at > f.buf) {
+		char c = at[-1];
+		if (isspace(c))
+			break;
+		if (c == '<') {
+			at[-1] = ' ';
+			break;
+		}
+		at--;
+	}
+	el = strcspn(at, " \n\t\r\v\f>");
+	strbuf_reset(&mi->email);
+	strbuf_add(&mi->email, at, el);
+	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
+
+	/* The remainder is name.  It could be
+	 *
+	 * - "John Doe <john.doe@xz>"			(a), or
+	 * - "john.doe@xz (John Doe)"			(b), or
+	 * - "John (zzz) Doe <john.doe@xz> (Comment)"	(c)
+	 *
+	 * but we have removed the email part, so
+	 *
+	 * - remove extra spaces which could stay after email (case 'c'), and
+	 * - trim from both ends, possibly removing the () pair at the end
+	 *   (cases 'a' and 'b').
+	 */
+	cleanup_space(&f);
+	strbuf_trim(&f);
+	if (f.buf[0] == '(' && f.len && f.buf[f.len - 1] == ')') {
+		strbuf_remove(&f, 0, 1);
+		strbuf_setlen(&f, f.len - 1);
+	}
+
+	get_sane_name(&mi->name, &f, &mi->email);
+	strbuf_release(&f);
+}
+
+static void handle_header(struct strbuf **out, const struct strbuf *line)
+{
+	if (!*out) {
+		*out = xmalloc(sizeof(struct strbuf));
+		strbuf_init(*out, line->len);
+	} else
+		strbuf_reset(*out);
+
+	strbuf_addbuf(*out, line);
+}
+
+/* NOTE NOTE NOTE.  We do not claim we do full MIME.  We just attempt
+ * to have enough heuristics to grok MIME encoded patches often found
+ * on our mailing lists.  For example, we do not even treat header lines
+ * case insensitively.
+ */
+
+static int slurp_attr(const char *line, const char *name, struct strbuf *attr)
+{
+	const char *ends, *ap = strcasestr(line, name);
+	size_t sz;
+
+	strbuf_setlen(attr, 0);
+	if (!ap)
+		return 0;
+	ap += strlen(name);
+	if (*ap == '"') {
+		ap++;
+		ends = "\"";
+	}
+	else
+		ends = "; \t";
+	sz = strcspn(ap, ends);
+	strbuf_add(attr, ap, sz);
+	return 1;
+}
+
+static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
+{
+	struct strbuf *boundary = xmalloc(sizeof(struct strbuf));
+	strbuf_init(boundary, line->len);
+
+	if (slurp_attr(line->buf, "boundary=", boundary)) {
+		strbuf_insert(boundary, 0, "--", 2);
+		if (++mi->content_top >= &mi->content[MAX_BOUNDARIES]) {
+			error("Too many boundaries to handle");
+			mi->input_error = -1;
+			mi->content_top = mi->content + MAX_BOUNDARIES - 1;
+			return;
+		}
+		*(mi->content_top) = boundary;
+		boundary = NULL;
+	}
+	slurp_attr(line->buf, "charset=", &mi->charset);
+
+	if (boundary) {
+		strbuf_release(boundary);
+		free(boundary);
+	}
+}
+
+static void handle_message_id(struct mailinfo *mi, const struct strbuf *line)
+{
+	if (mi->add_message_id)
+		mi->message_id = strdup(line->buf);
+}
+
+static void handle_content_transfer_encoding(struct mailinfo *mi,
+					     const struct strbuf *line)
+{
+	if (strcasestr(line->buf, "base64"))
+		mi->transfer_encoding = TE_BASE64;
+	else if (strcasestr(line->buf, "quoted-printable"))
+		mi->transfer_encoding = TE_QP;
+	else
+		mi->transfer_encoding = TE_DONTCARE;
+}
+
+static int is_multipart_boundary(struct mailinfo *mi, const struct strbuf *line)
+{
+	struct strbuf *content_top = *(mi->content_top);
+
+	return ((content_top->len <= line->len) &&
+		!memcmp(line->buf, content_top->buf, content_top->len));
+}
+
+static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
+{
+	size_t at = 0;
+
+	while (at < subject->len) {
+		char *pos;
+		size_t remove;
+
+		switch (subject->buf[at]) {
+		case 'r': case 'R':
+			if (subject->len <= at + 3)
+				break;
+			if ((subject->buf[at + 1] == 'e' ||
+			     subject->buf[at + 1] == 'E') &&
+			    subject->buf[at + 2] == ':') {
+				strbuf_remove(subject, at, 3);
+				continue;
+			}
+			at++;
+			break;
+		case ' ': case '\t': case ':':
+			strbuf_remove(subject, at, 1);
+			continue;
+		case '[':
+			pos = strchr(subject->buf + at, ']');
+			if (!pos)
+				break;
+			remove = pos - subject->buf + at + 1;
+			if (!mi->keep_non_patch_brackets_in_subject ||
+			    (7 <= remove &&
+			     memmem(subject->buf + at, remove, "PATCH", 5)))
+				strbuf_remove(subject, at, remove);
+			else {
+				at += remove;
+				/*
+				 * If the input had a space after the ], keep
+				 * it.  We don't bother with finding the end of
+				 * the space, since we later normalize it
+				 * anyway.
+				 */
+				if (isspace(subject->buf[at]))
+					at += 1;
+			}
+			continue;
+		}
+		break;
+	}
+	strbuf_trim(subject);
+}
+
+#define MAX_HDR_PARSED 10
+
+static const char *header[MAX_HDR_PARSED] = {
+	"From","Subject","Date",
+};
+
+static inline int cmp_header(const struct strbuf *line, const char *hdr)
+{
+	int len = strlen(hdr);
+	return !strncasecmp(line->buf, hdr, len) && line->len > len &&
+			line->buf[len] == ':' && isspace(line->buf[len + 1]);
+}
+
+static int is_format_patch_separator(const char *line, int len)
+{
+	static const char SAMPLE[] =
+		"From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n";
+	const char *cp;
+
+	if (len != strlen(SAMPLE))
+		return 0;
+	if (!skip_prefix(line, "From ", &cp))
+		return 0;
+	if (strspn(cp, "0123456789abcdef") != 40)
+		return 0;
+	cp += 40;
+	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
+}
+
+static int is_rfc2822_header(const struct strbuf *line)
+{
+	/*
+	 * The section that defines the loosest possible
+	 * field name is "3.6.8 Optional fields".
+	 *
+	 * optional-field = field-name ":" unstructured CRLF
+	 * field-name = 1*ftext
+	 * ftext = %d33-57 / %59-126
+	 */
+	int ch;
+	char *cp = line->buf;
+
+	/* Count mbox From headers as headers */
+	if (starts_with(cp, "From ") || starts_with(cp, ">From "))
+		return 1;
+
+	while ((ch = *cp++)) {
+		if (ch == ':')
+			return 1;
+		if ((33 <= ch && ch <= 57) ||
+		    (59 <= ch && ch <= 126))
+			continue;
+		break;
+	}
+	return 0;
+}
+
+static int read_one_header_line(struct strbuf *line, FILE *in)
+{
+	/* Get the first part of the line. */
+	if (strbuf_getline(line, in, '\n'))
+		return 0;
+
+	/*
+	 * Is it an empty line or not a valid rfc2822 header?
+	 * If so, stop here, and return false ("not a header")
+	 */
+	strbuf_rtrim(line);
+	if (!line->len || !is_rfc2822_header(line)) {
+		/* Re-add the newline */
+		strbuf_addch(line, '\n');
+		return 0;
+	}
+
+	/*
+	 * Now we need to eat all the continuation lines..
+	 * Yuck, 2822 header "folding"
+	 */
+	for (;;) {
+		int peek;
+		struct strbuf continuation = STRBUF_INIT;
+
+		peek = fgetc(in); ungetc(peek, in);
+		if (peek != ' ' && peek != '\t')
+			break;
+		if (strbuf_getline(&continuation, in, '\n'))
+			break;
+		continuation.buf[0] = ' ';
+		strbuf_rtrim(&continuation);
+		strbuf_addbuf(line, &continuation);
+	}
+
+	return 1;
+}
+
+static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
+{
+	const char *in = q_seg->buf;
+	int c;
+	struct strbuf *out = xmalloc(sizeof(struct strbuf));
+	strbuf_init(out, q_seg->len);
+
+	while ((c = *in++) != 0) {
+		if (c == '=') {
+			int d = *in++;
+			if (d == '\n' || !d)
+				break; /* drop trailing newline */
+			strbuf_addch(out, (hexval(d) << 4) | hexval(*in++));
+			continue;
+		}
+		if (rfc2047 && c == '_') /* rfc2047 4.2 (2) */
+			c = 0x20;
+		strbuf_addch(out, c);
+	}
+	return out;
+}
+
+static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
+{
+	/* Decode in..ep, possibly in-place to ot */
+	int c, pos = 0, acc = 0;
+	const char *in = b_seg->buf;
+	struct strbuf *out = xmalloc(sizeof(struct strbuf));
+	strbuf_init(out, b_seg->len);
+
+	while ((c = *in++) != 0) {
+		if (c == '+')
+			c = 62;
+		else if (c == '/')
+			c = 63;
+		else if ('A' <= c && c <= 'Z')
+			c -= 'A';
+		else if ('a' <= c && c <= 'z')
+			c -= 'a' - 26;
+		else if ('0' <= c && c <= '9')
+			c -= '0' - 52;
+		else
+			continue; /* garbage */
+		switch (pos++) {
+		case 0:
+			acc = (c << 2);
+			break;
+		case 1:
+			strbuf_addch(out, (acc | (c >> 4)));
+			acc = (c & 15) << 4;
+			break;
+		case 2:
+			strbuf_addch(out, (acc | (c >> 2)));
+			acc = (c & 3) << 6;
+			break;
+		case 3:
+			strbuf_addch(out, (acc | c));
+			acc = pos = 0;
+			break;
+		}
+	}
+	return out;
+}
+
+static int convert_to_utf8(struct mailinfo *mi,
+			   struct strbuf *line, const char *charset)
+{
+	char *out;
+
+	if (!mi->metainfo_charset || !charset || !*charset)
+		return 0;
+
+	if (same_encoding(mi->metainfo_charset, charset))
+		return 0;
+	out = reencode_string(line->buf, mi->metainfo_charset, charset);
+	if (!out) {
+		mi->input_error = -1;
+		return error("cannot convert from %s to %s",
+			     charset, mi->metainfo_charset);
+	}
+	strbuf_attach(line, out, strlen(out), strlen(out));
+	return 0;
+}
+
+static int decode_header(struct mailinfo *mi, struct strbuf *it)
+{
+	char *in, *ep, *cp;
+	struct strbuf outbuf = STRBUF_INIT, *dec;
+	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
+	int found_error = -1; /* pessimism */
+
+	in = it->buf;
+	while (in - it->buf <= it->len && (ep = strstr(in, "=?")) != NULL) {
+		int encoding;
+		strbuf_reset(&charset_q);
+		strbuf_reset(&piecebuf);
+
+		if (in != ep) {
+			/*
+			 * We are about to process an encoded-word
+			 * that begins at ep, but there is something
+			 * before the encoded word.
+			 */
+			char *scan;
+			for (scan = in; scan < ep; scan++)
+				if (!isspace(*scan))
+					break;
+
+			if (scan != ep || in == it->buf) {
+				/*
+				 * We should not lose that "something",
+				 * unless we have just processed an
+				 * encoded-word, and there is only LWS
+				 * before the one we are about to process.
+				 */
+				strbuf_add(&outbuf, in, ep - in);
+			}
+		}
+		/* E.g.
+		 * ep : "=?iso-2022-jp?B?GyR...?= foo"
+		 * ep : "=?ISO-8859-1?Q?Foo=FCbar?= baz"
+		 */
+		ep += 2;
+
+		if (ep - it->buf >= it->len || !(cp = strchr(ep, '?')))
+			goto release_return;
+
+		if (cp + 3 - it->buf > it->len)
+			goto release_return;
+		strbuf_add(&charset_q, ep, cp - ep);
+
+		encoding = cp[1];
+		if (!encoding || cp[2] != '?')
+			goto release_return;
+		ep = strstr(cp + 3, "?=");
+		if (!ep)
+			goto release_return;
+		strbuf_add(&piecebuf, cp + 3, ep - cp - 3);
+		switch (tolower(encoding)) {
+		default:
+			goto release_return;
+		case 'b':
+			dec = decode_b_segment(&piecebuf);
+			break;
+		case 'q':
+			dec = decode_q_segment(&piecebuf, 1);
+			break;
+		}
+		if (convert_to_utf8(mi, dec, charset_q.buf))
+			goto release_return;
+
+		strbuf_addbuf(&outbuf, dec);
+		strbuf_release(dec);
+		free(dec);
+		in = ep + 2;
+	}
+	strbuf_addstr(&outbuf, in);
+	strbuf_reset(it);
+	strbuf_addbuf(it, &outbuf);
+	found_error = 0;
+release_return:
+	strbuf_release(&outbuf);
+	strbuf_release(&charset_q);
+	strbuf_release(&piecebuf);
+
+	return found_error;
+}
+
+static int check_header(struct mailinfo *mi,
+			const struct strbuf *line,
+			struct strbuf *hdr_data[], int overwrite)
+{
+	int i, ret = 0, len;
+	struct strbuf sb = STRBUF_INIT;
+
+	/* search for the interesting parts */
+	for (i = 0; header[i]; i++) {
+		int len = strlen(header[i]);
+		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i])) {
+			/* Unwrap inline B and Q encoding, and optionally
+			 * normalize the meta information to utf8.
+			 */
+			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
+			if (!decode_header(mi, &sb))
+				handle_header(&hdr_data[i], &sb);
+			ret = 1;
+			goto check_header_out;
+		}
+	}
+
+	/* Content stuff */
+	if (cmp_header(line, "Content-Type")) {
+		len = strlen("Content-Type: ");
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		if (!decode_header(mi, &sb)) {
+			strbuf_insert(&sb, 0, "Content-Type: ", len);
+			handle_content_type(mi, &sb);
+		}
+		ret = 1;
+		goto check_header_out;
+	}
+	if (cmp_header(line, "Content-Transfer-Encoding")) {
+		len = strlen("Content-Transfer-Encoding: ");
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		if (!decode_header(mi, &sb))
+			handle_content_transfer_encoding(mi, &sb);
+		ret = 1;
+		goto check_header_out;
+	}
+	if (cmp_header(line, "Message-Id")) {
+		len = strlen("Message-Id: ");
+		strbuf_add(&sb, line->buf + len, line->len - len);
+		if (!decode_header(mi, &sb))
+			handle_message_id(mi, &sb);
+		ret = 1;
+		goto check_header_out;
+	}
+
+	/* for inbody stuff */
+	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
+		ret = is_format_patch_separator(line->buf + 1, line->len - 1);
+		goto check_header_out;
+	}
+	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
+		for (i = 0; header[i]; i++) {
+			if (!strcmp("Subject", header[i])) {
+				handle_header(&hdr_data[i], line);
+				ret = 1;
+				goto check_header_out;
+			}
+		}
+	}
+
+check_header_out:
+	strbuf_release(&sb);
+	return ret;
+}
+
+static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
+{
+	struct strbuf *ret;
+
+	switch (mi->transfer_encoding) {
+	case TE_QP:
+		ret = decode_q_segment(line, 0);
+		break;
+	case TE_BASE64:
+		ret = decode_b_segment(line);
+		break;
+	case TE_DONTCARE:
+	default:
+		return;
+	}
+	strbuf_reset(line);
+	strbuf_addbuf(line, ret);
+	strbuf_release(ret);
+	free(ret);
+}
+
+static inline int patchbreak(const struct strbuf *line)
+{
+	size_t i;
+
+	/* Beginning of a "diff -" header? */
+	if (starts_with(line->buf, "diff -"))
+		return 1;
+
+	/* CVS "Index: " line? */
+	if (starts_with(line->buf, "Index: "))
+		return 1;
+
+	/*
+	 * "--- <filename>" starts patches without headers
+	 * "---<sp>*" is a manual separator
+	 */
+	if (line->len < 4)
+		return 0;
+
+	if (starts_with(line->buf, "---")) {
+		/* space followed by a filename? */
+		if (line->buf[3] == ' ' && !isspace(line->buf[4]))
+			return 1;
+		/* Just whitespace? */
+		for (i = 3; i < line->len; i++) {
+			unsigned char c = line->buf[i];
+			if (c == '\n')
+				return 1;
+			if (!isspace(c))
+				break;
+		}
+		return 0;
+	}
+	return 0;
+}
+
+static int is_scissors_line(const struct strbuf *line)
+{
+	size_t i, len = line->len;
+	int scissors = 0, gap = 0;
+	int first_nonblank = -1;
+	int last_nonblank = 0, visible, perforation = 0, in_perforation = 0;
+	const char *buf = line->buf;
+
+	for (i = 0; i < len; i++) {
+		if (isspace(buf[i])) {
+			if (in_perforation) {
+				perforation++;
+				gap++;
+			}
+			continue;
+		}
+		last_nonblank = i;
+		if (first_nonblank < 0)
+			first_nonblank = i;
+		if (buf[i] == '-') {
+			in_perforation = 1;
+			perforation++;
+			continue;
+		}
+		if (i + 1 < len &&
+		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2) ||
+		     !memcmp(buf + i, ">%", 2) || !memcmp(buf + i, "%<", 2))) {
+			in_perforation = 1;
+			perforation += 2;
+			scissors += 2;
+			i++;
+			continue;
+		}
+		in_perforation = 0;
+	}
+
+	/*
+	 * The mark must be at least 8 bytes long (e.g. "-- >8 --").
+	 * Even though there can be arbitrary cruft on the same line
+	 * (e.g. "cut here"), in order to avoid misidentification, the
+	 * perforation must occupy more than a third of the visible
+	 * width of the line, and dashes and scissors must occupy more
+	 * than half of the perforation.
+	 */
+
+	visible = last_nonblank - first_nonblank + 1;
+	return (scissors && 8 <= visible &&
+		visible < perforation * 3 &&
+		gap * 2 < perforation);
+}
+
+static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
+{
+	/*
+	 * Are we still scanning and discarding in-body headers?
+	 * It is initially set to 1, set to 2 when we do see a
+	 * valid in-body header.
+	 */
+	int is_empty_line;
+
+	assert(!mi->filter_stage);
+
+	is_empty_line = (!line->len || (line->len == 1 && line->buf[0] == '\n'));
+	if (mi->header_stage == 1) {
+		/*
+		 * Haven't seen a known in-body header; discard an empty line.
+		 */
+		if (is_empty_line)
+			return 0;
+	}
+
+	if (mi->use_inbody_headers && mi->header_stage) {
+		int is_known_header = check_header(mi, line, mi->s_hdr_data, 0);
+
+		if (mi->header_stage == 2) {
+			/*
+			 * an empty line after the in-body header block,
+			 * or a line obviously not an attempt to invent
+			 * an unsupported in-body header.
+			 */
+			if (is_empty_line || !is_rfc2822_header(line))
+				mi->header_stage = 0;
+			if (is_empty_line)
+				return 0;
+			/* otherwise do not discard the line, but keep going */
+		} else if (is_known_header) {
+			mi->header_stage = 2;
+		} else if (mi->header_stage != 2) {
+			mi->header_stage = 0;
+		}
+
+		if (mi->header_stage)
+			return 0;
+	} else
+		/* Only trim the first (blank) line of the commit message
+		 * when ignoring in-body headers.
+		 */
+		mi->header_stage = 0;
+
+	/* normalize the log message to UTF-8. */
+	if (convert_to_utf8(mi, line, mi->charset.buf))
+		return 0; /* the caller will reject this input */
+
+	if (mi->use_scissors && is_scissors_line(line)) {
+		int i;
+
+		strbuf_setlen(&mi->log_message, 0);
+		mi->header_stage = 1;
+
+		/*
+		 * We may have already read "secondary headers"; purge
+		 * them to give ourselves a clean restart.
+		 */
+		for (i = 0; header[i]; i++) {
+			if (mi->s_hdr_data[i])
+				strbuf_release(mi->s_hdr_data[i]);
+			mi->s_hdr_data[i] = NULL;
+		}
+		return 0;
+	}
+
+	if (patchbreak(line)) {
+		if (mi->message_id)
+			strbuf_addf(&mi->log_message,
+				    "Message-Id: %s\n", mi->message_id);
+		return 1;
+	}
+
+	strbuf_addbuf(&mi->log_message, line);
+	return 0;
+}
+
+static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
+{
+	fwrite(line->buf, 1, line->len, mi->patchfile);
+	mi->patch_lines++;
+}
+
+static void handle_filter(struct mailinfo *mi, struct strbuf *line)
+{
+	if (mi->input_error)
+		return;
+
+	switch (mi->filter_stage) {
+	case 0:
+		if (!handle_commit_msg(mi, line))
+			break;
+		mi->filter_stage++;
+	case 1:
+		handle_patch(mi, line);
+		break;
+	}
+}
+
+static int find_boundary(struct mailinfo *mi, struct strbuf *line)
+{
+	while (!strbuf_getline(line, mi->input, '\n')) {
+		if (*(mi->content_top) && is_multipart_boundary(mi, line))
+			return 1;
+	}
+	return 0;
+}
+
+static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
+{
+	struct strbuf newline = STRBUF_INIT;
+
+	strbuf_addch(&newline, '\n');
+again:
+	if (line->len >= (*(mi->content_top))->len + 2 &&
+	    !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
+		/* we hit an end boundary */
+		/* pop the current boundary off the stack */
+		strbuf_release(*(mi->content_top));
+		free(*(mi->content_top));
+		*(mi->content_top) = NULL;
+
+		/* technically won't happen as is_multipart_boundary()
+		   will fail first.  But just in case..
+		 */
+		if (--mi->content_top < mi->content) {
+			error("Detected mismatched boundaries, can't recover");
+			mi->input_error = -1;
+			mi->content_top = mi->content;
+			return 0;
+		}
+		handle_filter(mi, &newline);
+		strbuf_release(&newline);
+		if (mi->input_error)
+			return 0; /* punt to the end */
+
+		/* skip to the next boundary */
+		if (!find_boundary(mi, line))
+			return 0;
+		goto again;
+	}
+
+	/* set some defaults */
+	mi->transfer_encoding = TE_DONTCARE;
+	strbuf_reset(&mi->charset);
+
+	/* slurp in this section's info */
+	while (read_one_header_line(line, mi->input))
+		check_header(mi, line, mi->p_hdr_data, 0);
+
+	strbuf_release(&newline);
+	/* replenish line */
+	if (strbuf_getline(line, mi->input, '\n'))
+		return 0;
+	strbuf_addch(line, '\n');
+	return 1;
+}
+
+static void handle_body(struct mailinfo *mi, struct strbuf *line)
+{
+	struct strbuf prev = STRBUF_INIT;
+
+	/* Skip up to the first boundary */
+	if (*(mi->content_top)) {
+		if (!find_boundary(mi, line))
+			goto handle_body_out;
+	}
+
+	do {
+		/* process any boundary lines */
+		if (*(mi->content_top) && is_multipart_boundary(mi, line)) {
+			/* flush any leftover */
+			if (prev.len) {
+				handle_filter(mi, &prev);
+				strbuf_reset(&prev);
+			}
+			if (!handle_boundary(mi, line))
+				goto handle_body_out;
+		}
+
+		/* Unwrap transfer encoding */
+		decode_transfer_encoding(mi, line);
+
+		switch (mi->transfer_encoding) {
+		case TE_BASE64:
+		case TE_QP:
+		{
+			struct strbuf **lines, **it, *sb;
+
+			/* Prepend any previous partial lines */
+			strbuf_insert(line, 0, prev.buf, prev.len);
+			strbuf_reset(&prev);
+
+			/*
+			 * This is a decoded line that may contain
+			 * multiple new lines.  Pass only one chunk
+			 * at a time to handle_filter()
+			 */
+			lines = strbuf_split(line, '\n');
+			for (it = lines; (sb = *it); it++) {
+				if (*(it + 1) == NULL) /* The last line */
+					if (sb->buf[sb->len - 1] != '\n') {
+						/* Partial line, save it for later. */
+						strbuf_addbuf(&prev, sb);
+						break;
+					}
+				handle_filter(mi, sb);
+			}
+			/*
+			 * The partial chunk is saved in "prev" and will be
+			 * appended by the next iteration of read_line_with_nul().
+			 */
+			strbuf_list_free(lines);
+			break;
+		}
+		default:
+			handle_filter(mi, line);
+		}
+
+		if (mi->input_error)
+			break;
+	} while (!strbuf_getwholeline(line, mi->input, '\n'));
+
+handle_body_out:
+	strbuf_release(&prev);
+}
+
+static void output_header_lines(FILE *fout, const char *hdr, const struct strbuf *data)
+{
+	const char *sp = data->buf;
+	while (1) {
+		char *ep = strchr(sp, '\n');
+		int len;
+		if (!ep)
+			len = strlen(sp);
+		else
+			len = ep - sp;
+		fprintf(fout, "%s: %.*s\n", hdr, len, sp);
+		if (!ep)
+			break;
+		sp = ep + 1;
+	}
+}
+
+static void handle_info(struct mailinfo *mi)
+{
+	struct strbuf *hdr;
+	int i;
+
+	for (i = 0; header[i]; i++) {
+		/* only print inbody headers if we output a patch file */
+		if (mi->patch_lines && mi->s_hdr_data[i])
+			hdr = mi->s_hdr_data[i];
+		else if (mi->p_hdr_data[i])
+			hdr = mi->p_hdr_data[i];
+		else
+			continue;
+
+		if (!strcmp(header[i], "Subject")) {
+			if (!mi->keep_subject) {
+				cleanup_subject(mi, hdr);
+				cleanup_space(hdr);
+			}
+			output_header_lines(mi->output, "Subject", hdr);
+		} else if (!strcmp(header[i], "From")) {
+			cleanup_space(hdr);
+			handle_from(mi, hdr);
+			fprintf(mi->output, "Author: %s\n", mi->name.buf);
+			fprintf(mi->output, "Email: %s\n", mi->email.buf);
+		} else {
+			cleanup_space(hdr);
+			fprintf(mi->output, "%s: %s\n", header[i], hdr->buf);
+		}
+	}
+	fprintf(mi->output, "\n");
+}
+
+int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
+{
+	FILE *cmitmsg;
+	int peek;
+	struct strbuf line = STRBUF_INIT;
+
+	cmitmsg = fopen(msg, "w");
+	if (!cmitmsg) {
+		perror(msg);
+		return -1;
+	}
+	mi->patchfile = fopen(patch, "w");
+	if (!mi->patchfile) {
+		perror(patch);
+		fclose(cmitmsg);
+		return -1;
+	}
+
+	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
+	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
+
+	do {
+		peek = fgetc(mi->input);
+	} while (isspace(peek));
+	ungetc(peek, mi->input);
+
+	/* process the email header */
+	while (read_one_header_line(&line, mi->input))
+		check_header(mi, &line, mi->p_hdr_data, 1);
+
+	handle_body(mi, &line);
+	if (!mi->input_error) {
+		handle_info(mi);
+		fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
+	}
+	fclose(cmitmsg);
+
+	return mi->input_error;
+}
+
+static int git_mailinfo_config(const char *var, const char *value, void *mi_)
+{
+	struct mailinfo *mi = mi_;
+
+	if (!starts_with(var, "mailinfo."))
+		return git_default_config(var, value, NULL);
+	if (!strcmp(var, "mailinfo.scissors")) {
+		mi->use_scissors = git_config_bool(var, value);
+		return 0;
+	}
+	/* perhaps others here */
+	return 0;
+}
+
+void setup_mailinfo(struct mailinfo *mi)
+{
+	memset(mi, 0, sizeof(*mi));
+	strbuf_init(&mi->name, 0);
+	strbuf_init(&mi->email, 0);
+	strbuf_init(&mi->charset, 0);
+	strbuf_init(&mi->log_message, 0);
+	mi->header_stage = 1;
+	mi->use_inbody_headers = 1;
+	mi->content_top = mi->content;
+	git_config(git_mailinfo_config, &mi);
+}
+
+void clear_mailinfo(struct mailinfo *mi)
+{
+	strbuf_release(&mi->name);
+	strbuf_release(&mi->email);
+	strbuf_release(&mi->charset);
+	strbuf_release(&mi->log_message);
+
+	while (mi->content < mi->content_top) {
+		free(*(mi->content_top));
+		mi->content_top--;
+	}
+}
diff --git a/mailinfo.h b/mailinfo.h
new file mode 100644
index 0000000..e15e0de
--- /dev/null
+++ b/mailinfo.h
@@ -0,0 +1,41 @@
+#ifndef MAILINFO_H
+#define MAILINFO_H
+
+#define MAX_BOUNDARIES 5
+
+struct mailinfo {
+	FILE *input;
+	FILE *output;
+	FILE *patchfile;
+
+	struct strbuf name;
+	struct strbuf email;
+	int keep_subject;
+	int keep_non_patch_brackets_in_subject;
+	int add_message_id;
+	int use_scissors;
+	int use_inbody_headers; /* defaults to 1 */
+	const char *metainfo_charset;
+
+	struct strbuf *content[MAX_BOUNDARIES];
+	struct strbuf **content_top;
+	struct strbuf charset;
+	char *message_id;
+	enum  {
+		TE_DONTCARE, TE_QP, TE_BASE64
+	} transfer_encoding;
+	int patch_lines;
+	int filter_stage; /* still reading log or are we copying patch? */
+	int header_stage; /* still checking in-body headers? */
+	struct strbuf **p_hdr_data;
+	struct strbuf **s_hdr_data;
+
+	struct strbuf log_message;
+	int input_error;
+};
+
+extern void setup_mailinfo(struct mailinfo *);
+extern void clear_mailinfo(struct mailinfo *);
+extern int mailinfo(struct mailinfo *, const char *msg, const char *patch);
+
+#endif /* MAILINFO_H */
-- 
2.6.1-320-g86a1181
