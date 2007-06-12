From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Extend --pretty=oneline to cover the first paragraph,
 so that an ugly commit message like this can be
 handled sanely.
Date: Mon, 11 Jun 2007 22:34:34 -0700
Message-ID: <7vvedtlor9.fsf_-_@assigned-by-dhcp.pobox.com>
References: <20070610091259.48F8D13A4F8@magnus.utsl.gen.nz>
	<20070610212459.GA12222@muzzle>
	<7vhcpfrlk1.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 07:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxz1o-0000DP-Rl
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 07:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbXFLFeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 01:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbXFLFeh
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 01:34:37 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54536 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbXFLFeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 01:34:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612053436.XTDM2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 01:34:36 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AVaa1X00K1kojtg0000000; Tue, 12 Jun 2007 01:34:35 -0400
In-Reply-To: <7vhcpfrlk1.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Mon, 11 Jun 2007 00:34:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49922>

Currently, --pretty=oneline and --pretty=email (hence
format-patch) take and use only the first line of the commit log
message.  This changes them to:

 - Take the first paragraph, where the definition of the first
   paragraph is "skip all blank lines from the beginning, and
   then grab everything up to the next empty line".

 - Replace all line breaks with a whitespace.

This change would not affect a well-behaved commit message that
adheres to the convention of "single line summary, a blank line,
and then body of message", as its first paragraph always
consists of a single line.  Commit messages from different
culture, such as the ones imported from CVS/SVN, can however get
chomped with the existing behaviour at the first linebreak in
the middle of sentence right now, which would become much easier
to see with this change.

The Subject: and --pretty=oneline output would become very long
and unsightly for non-conforming commits, but their messages are
already ugly anyway, and thischange at least avoids the loss of
information.

The Subject: line from a multi-line paragraph is folded using
RFC2822 line folding rules at the places where line breaks were
in the original.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is on top of the previous "Lift 16kB limit" clean-up.
   I haven't checked what mailinfo does when it unfolds a folded
   Subject: line yet, but it may have to be updated to match
   this, so that "format-patch --stdout | am" behaves sanely on
   commits with multi-line first paragraph.

 commit.c |  396 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 262 insertions(+), 134 deletions(-)

diff --git a/commit.c b/commit.c
index d43a68e..e2fd9ba 100644
--- a/commit.c
+++ b/commit.c
@@ -529,6 +529,14 @@ static int add_rfc2047(char *buf, const char *line, int len,
 	return bp - buf;
 }
 
+static unsigned long bound_rfc2047(unsigned long len, const char *encoding)
+{
+	/* upper bound of q encoded string of length 'len' */
+	unsigned long elen = strlen(encoding);
+
+	return len * 3 + elen + 100;
+}
+
 static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 			 const char *line, enum date_mode dmode,
 			 const char *encoding)
@@ -922,6 +930,224 @@ static long format_commit_message(const struct commit *commit,
 	return strlen(*buf_p);
 }
 
+#define ALLOC_GROW(buf, space, need) \
+	do { \
+		if ((space) < (need)) { \
+			buf = xrealloc(buf, need); \
+			space = need; \
+		} \
+	} while (0)
+
+static void pp_header(enum cmit_fmt fmt,
+		      int abbrev,
+		      enum date_mode dmode,
+		      const char *encoding,
+		      const struct commit *commit,
+		      const char **msg_p,
+		      unsigned long *len_p,
+		      unsigned long *ofs_p,
+		      char **buf_p,
+		      unsigned long *space_p)
+{
+	int parents_shown = 0;
+
+	for (;;) {
+		const char *line = *msg_p;
+		char *dst;
+		int linelen = get_one_line(*msg_p, *len_p);
+		unsigned long len;
+
+		if (!linelen)
+			return;
+		*msg_p += linelen;
+		*len_p -= linelen;
+
+		if (linelen == 1)
+			/* End of header */
+			return;
+
+		ALLOC_GROW(*buf_p, *space_p, linelen + *ofs_p + 20);
+		dst = *buf_p + *ofs_p;
+
+		if (fmt == CMIT_FMT_RAW) {
+			memcpy(dst, line, linelen);
+			*ofs_p += linelen;
+			continue;
+		}
+
+		if (!memcmp(line, "parent ", 7)) {
+			if (linelen != 48)
+				die("bad parent line in commit");
+			continue;
+		}
+
+		if (!parents_shown) {
+			struct commit_list *parent;
+			int num;
+			for (parent = commit->parents, num = 0;
+			     parent;
+			     parent = parent->next, num++)
+				;
+			/* with enough slop */
+			num = *ofs_p + num * 50 + 20;
+			ALLOC_GROW(*buf_p, *space_p, num);
+			dst = *buf_p + *ofs_p;
+			*ofs_p += add_merge_info(fmt, dst, commit, abbrev);
+			parents_shown = 1;
+		}
+
+		/*
+		 * MEDIUM == DEFAULT shows only author with dates.
+		 * FULL shows both authors but not dates.
+		 * FULLER shows both authors and dates.
+		 */
+		if (!memcmp(line, "author ", 7)) {
+			len = linelen;
+			if (fmt == CMIT_FMT_EMAIL)
+				len = bound_rfc2047(linelen, encoding);
+			ALLOC_GROW(*buf_p, *space_p, *ofs_p + len);
+			dst = *buf_p + *ofs_p;
+			*ofs_p += add_user_info("Author", fmt, dst,
+						line + 7, dmode, encoding);
+		}
+
+		if (!memcmp(line, "committer ", 10) &&
+		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER)) {
+			len = linelen;
+			if (fmt == CMIT_FMT_EMAIL)
+				len = bound_rfc2047(linelen, encoding);
+			ALLOC_GROW(*buf_p, *space_p, *ofs_p + len);
+			dst = *buf_p + *ofs_p;
+			*ofs_p += add_user_info("Commit", fmt, dst,
+						line + 10, dmode, encoding);
+		}
+	}
+}
+
+static void pp_title_line(enum cmit_fmt fmt,
+			  const char **msg_p,
+			  unsigned long *len_p,
+			  unsigned long *ofs_p,
+			  char **buf_p,
+			  unsigned long *space_p,
+			  int indent,
+			  const char *subject,
+			  const char *after_subject,
+			  const char *encoding,
+			  int plain_non_ascii)
+{
+	char *title;
+	unsigned long title_alloc, title_len;
+	unsigned long len;
+
+	title_len = 0;
+	title_alloc = 80;
+	title = xmalloc(title_alloc);
+	for (;;) {
+		const char *line = *msg_p;
+		int linelen = get_one_line(line, *len_p);
+		*msg_p += linelen;
+		*len_p -= linelen;
+
+		if (!linelen || is_empty_line(line, &linelen))
+			break;
+
+		if (title_alloc <= title_len + linelen + 2) {
+			title_alloc = title_len + linelen + 80;
+			title = xrealloc(title, title_alloc);
+		}
+		len = 0;
+		if (title_len) {
+			if (fmt == CMIT_FMT_EMAIL) {
+				len++;
+				title[title_len++] = '\n';
+			}
+			len++;
+			title[title_len++] = ' ';
+		}
+		memcpy(title + title_len, line, linelen);
+		title_len += linelen;
+	}
+
+	/* Enough slop for the MIME header and rfc2047 */
+	len = bound_rfc2047(title_len, encoding)+ 1000;
+	if (subject)
+		len += strlen(subject);
+	if (after_subject)
+		len += strlen(after_subject);
+	if (encoding)
+		len += strlen(encoding);
+	ALLOC_GROW(*buf_p, *space_p, title_len + *ofs_p + len);
+
+	if (subject) {
+		len = strlen(subject);
+		memcpy(*buf_p + *ofs_p, subject, len);
+		*ofs_p += len;
+		*ofs_p += add_rfc2047(*buf_p + *ofs_p,
+				      title, title_len, encoding);
+	} else {
+		memcpy(*buf_p + *ofs_p, title, title_len);
+		*ofs_p += title_len;
+	}
+	(*buf_p)[(*ofs_p)++] = '\n';
+	if (plain_non_ascii) {
+		const char *header_fmt =
+			"MIME-Version: 1.0\n"
+			"Content-Type: text/plain; charset=%s\n"
+			"Content-Transfer-Encoding: 8bit\n";
+		*ofs_p += snprintf(*buf_p + *ofs_p,
+				   *space_p - *ofs_p,
+				   header_fmt, encoding);
+	}
+	if (after_subject) {
+		len = strlen(after_subject);
+		memcpy(*buf_p + *ofs_p, after_subject, len);
+		*ofs_p += len;
+	}
+	free(title);
+	if (fmt == CMIT_FMT_EMAIL) {
+		ALLOC_GROW(*buf_p, *space_p, *ofs_p + 20);
+		(*buf_p)[(*ofs_p)++] = '\n';
+	}
+}
+
+static void pp_remainder(enum cmit_fmt fmt,
+			 const char **msg_p,
+			 unsigned long *len_p,
+			 unsigned long *ofs_p,
+			 char **buf_p,
+			 unsigned long *space_p,
+			 int indent)
+{
+	int first = 1;
+	for (;;) {
+		const char *line = *msg_p;
+		int linelen = get_one_line(line, *len_p);
+		*msg_p += linelen;
+		*len_p -= linelen;
+
+		if (!linelen)
+			break;
+
+		if (is_empty_line(line, &linelen)) {
+			if (first)
+				continue;
+			if (fmt == CMIT_FMT_SHORT)
+				break;
+		}
+		first = 0;
+
+		ALLOC_GROW(*buf_p, *space_p, *ofs_p + linelen + indent + 20);
+		if (indent) {
+			memset(*buf_p + *ofs_p, ' ', indent);
+			*ofs_p += indent;
+		}
+		memcpy(*buf_p + *ofs_p, line, linelen);
+		*ofs_p += linelen;
+		(*buf_p)[(*ofs_p)++] = '\n';
+	}
+}
+
 unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  const struct commit *commit,
 				  unsigned long len,
@@ -930,16 +1156,14 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  const char *after_subject,
 				  enum date_mode dmode)
 {
-	int hdr = 1, body = 0, seen_title = 0;
 	unsigned long offset = 0;
+	unsigned long beginning_of_body;
 	int indent = 4;
-	int parents_shown = 0;
 	const char *msg = commit->buffer;
 	int plain_non_ascii = 0;
 	char *reencoded;
 	const char *encoding;
 	char *buf;
-	unsigned long space, slop;
 
 	if (fmt == CMIT_FMT_USERFORMAT)
 		return format_commit_message(commit, msg, buf_p, space_p);
@@ -950,8 +1174,10 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	if (!encoding)
 		encoding = "utf-8";
 	reencoded = logmsg_reencode(commit, encoding);
-	if (reencoded)
+	if (reencoded) {
 		msg = reencoded;
+		len = strlen(reencoded);
+	}
 
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
 		indent = 0;
@@ -982,155 +1208,57 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 		}
 	}
 
-	space = *space_p;
-	buf = *buf_p;
-
-	/*
-	 * We do not want to repeatedly realloc below, so
-	 * preallocate with enough slop to hold MIME headers,
-	 * "Subject: " prefix, etc.
-	 */
-	slop = 1000;
-	if (subject)
-		slop += strlen(subject);
-	if (after_subject)
-		slop += strlen(after_subject);
-	if (space < strlen(msg) + slop) {
-		space = strlen(msg) + slop;
-		buf = xrealloc(buf, space);
-		*space_p = space;
-		*buf_p = buf;
+	pp_header(fmt, abbrev, dmode, encoding,
+		  commit, &msg, &len,
+		  &offset, buf_p, space_p);
+	if (fmt != CMIT_FMT_ONELINE && !subject) {
+		ALLOC_GROW(*buf_p, *space_p, offset + 20);
+		(*buf_p)[offset++] = '\n';
 	}
 
+	/* Skip excess blank lines at the beginning of body, if any... */
 	for (;;) {
-		const char *line = msg;
 		int linelen = get_one_line(msg, len);
-
+		int ll = linelen;
 		if (!linelen)
 			break;
-
-		/* 20 would cover indent and leave us some slop */
-		if (offset + linelen + 20 > space) {
-			space = offset + linelen + 20;
-			buf = xrealloc(buf, space);
-			*buf_p = buf;
-			*space_p = space;
-		}
-
+		if (!is_empty_line(msg, &ll))
+			break;
 		msg += linelen;
 		len -= linelen;
-		if (hdr) {
-			if (linelen == 1) {
-				hdr = 0;
-				if ((fmt != CMIT_FMT_ONELINE) && !subject)
-					buf[offset++] = '\n';
-				continue;
-			}
-			if (fmt == CMIT_FMT_RAW) {
-				memcpy(buf + offset, line, linelen);
-				offset += linelen;
-				continue;
-			}
-			if (!memcmp(line, "parent ", 7)) {
-				if (linelen != 48)
-					die("bad parent line in commit");
-				continue;
-			}
-
-			if (!parents_shown) {
-				offset += add_merge_info(fmt, buf + offset,
-							 commit, abbrev);
-				parents_shown = 1;
-				continue;
-			}
-			/*
-			 * MEDIUM == DEFAULT shows only author with dates.
-			 * FULL shows both authors but not dates.
-			 * FULLER shows both authors and dates.
-			 */
-			if (!memcmp(line, "author ", 7))
-				offset += add_user_info("Author", fmt,
-							buf + offset,
-							line + 7,
-							dmode,
-							encoding);
-			if (!memcmp(line, "committer ", 10) &&
-			    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER))
-				offset += add_user_info("Commit", fmt,
-							buf + offset,
-							line + 10,
-							dmode,
-							encoding);
-			continue;
-		}
+	}
 
-		if (!subject)
-			body = 1;
+	/* These formats treat the title line specially. */
+	if (fmt == CMIT_FMT_ONELINE
+	    || fmt == CMIT_FMT_EMAIL)
+		pp_title_line(fmt, &msg, &len, &offset,
+			      buf_p, space_p, indent,
+			      subject, after_subject, encoding,
+			      plain_non_ascii);
 
-		if (is_empty_line(line, &linelen)) {
-			if (!seen_title)
-				continue;
-			if (!body)
-				continue;
-			if (subject)
-				continue;
-			if (fmt == CMIT_FMT_SHORT)
-				break;
-		}
+	beginning_of_body = offset;
+	if (fmt != CMIT_FMT_ONELINE)
+		pp_remainder(fmt, &msg, &len, &offset,
+			     buf_p, space_p, indent);
 
-		seen_title = 1;
-		if (subject) {
-			int slen = strlen(subject);
-			memcpy(buf + offset, subject, slen);
-			offset += slen;
-			offset += add_rfc2047(buf + offset, line, linelen,
-					      encoding);
-		}
-		else {
-			memset(buf + offset, ' ', indent);
-			memcpy(buf + offset + indent, line, linelen);
-			offset += linelen + indent;
-		}
-		buf[offset++] = '\n';
-		if (fmt == CMIT_FMT_ONELINE)
-			break;
-		if (subject && plain_non_ascii) {
-			int sz;
-			char header[512];
-			const char *header_fmt =
-				"MIME-Version: 1.0\n"
-				"Content-Type: text/plain; charset=%s\n"
-				"Content-Transfer-Encoding: 8bit\n";
-			sz = snprintf(header, sizeof(header), header_fmt,
-				      encoding);
-			if (sizeof(header) < sz)
-				die("Encoding name %s too long", encoding);
-			memcpy(buf + offset, header, sz);
-			offset += sz;
-		}
-		if (after_subject) {
-			int slen = strlen(after_subject);
-			if (slen > space - offset - 1)
-				slen = space - offset - 1;
-			memcpy(buf + offset, after_subject, slen);
-			offset += slen;
-			after_subject = NULL;
-		}
-		subject = NULL;
-	}
-	while (offset && isspace(buf[offset-1]))
+	while (offset && isspace((*buf_p)[offset-1]))
 		offset--;
+
+	ALLOC_GROW(*buf_p, *space_p, offset + 20);
+	buf = *buf_p;
+
 	/* Make sure there is an EOLN for the non-oneline case */
 	if (fmt != CMIT_FMT_ONELINE)
 		buf[offset++] = '\n';
+
 	/*
-	 * make sure there is another EOLN to separate the headers from whatever
-	 * body the caller appends if we haven't already written a body
+	 * The caller may append additional body text in e-mail
+	 * format.  Make sure we did not strip the blank line
+	 * between the header and the body.
 	 */
-	if (fmt == CMIT_FMT_EMAIL && !body)
+	if (fmt == CMIT_FMT_EMAIL && offset <= beginning_of_body)
 		buf[offset++] = '\n';
 	buf[offset] = '\0';
-
 	free(reencoded);
 	return offset;
 }
-- 
1.5.2.1.1021.g1c0b0
