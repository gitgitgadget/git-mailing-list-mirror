From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH RESEND] Avoid a useless prefix lookup in strbuf_expand()
Date: Sat,  2 Feb 2008 12:09:53 +0100
Message-ID: <1201950593-6119-1-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGHC-0001oh-Uw
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYBBLKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYBBLKm
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:10:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:25268 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYBBLKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:10:41 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1271369fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=tkEasAzViEZUBfdnbY0+tIvH9Px571OojLl108aM2Z8=;
        b=NF0EXty0KKID8vSeKqRz1WSvU0ke9dKmW0tagO2cxMsT6SVJg5+8dni7AuNpXAtppofUBsXL0epeYMMXIeX7frSkNumHvnI/twojV3cPyFwG+6XLMnuRvQrf4qtWJi+AEnxhprwVFxEBLpqTsdtzV6jJZwEkGmGffJofBcpe48c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qnlCPyKBSCTW9U0AIIlwCPlPWxFxCN8O5LQYX32UqV69RoMItGKZT0ZlPzVFozFCRmFMGJNAtkoXio5H9EqIv7dGXP8/Q/xCWRuY/2J781HNAHc2Eel3Gz+lyuil2wejlq77R75ztCbQngyNYiWLz77mSVyFuVoJzAc1ww1UTAE=
Received: by 10.86.81.14 with SMTP id e14mr4241435fgb.42.1201950638809;
        Sat, 02 Feb 2008 03:10:38 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6024906fga.9.2008.02.02.03.10.35
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:10:37 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72260>

Currently the --prett=format prefix is looked up in a
tight loop in strbuf_expand(), if prefix is found is then
used as argument for format_commit_item() that does another
search by a switch statement to select the proper operation.

Because the switch statement is already able to discard
unknown matches we don't need the prefix lookup before
to call format_commit_item()

This patch removes an useless loop in a very fast path,
used by, as example, by 'git log' with --pretty=format option

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This is the resend of an optimization patch rebased on
current next.

I resend now that branch is open again.

 pretty.c |  202 +++++++++++++++++++++++++++----------------------------------
 strbuf.c |   19 +++----
 strbuf.h |    4 +-
 3 files changed, 99 insertions(+), 126 deletions(-)

diff --git a/pretty.c b/pretty.c
index b987ff2..64ead65 100644
--- a/pretty.c
+++ b/pretty.c
@@ -282,16 +282,18 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static void format_person_part(struct strbuf *sb, char part,
+/* returns placeholder length or 0 if placeholder is not known */
+static size_t format_person_part(struct strbuf *sb, char part,
                                const char *msg, int len)
 {
-	int start, end, tz = 0;
-	unsigned long date;
+	int start, end, tz = 0, end_of_data;
+	unsigned long date = 0;
 	char *ep;
 
-	/* parse name */
+	/* advance 'end' to point to email start delimiter */
 	for (end = 0; end < len && msg[end] != '<'; end++)
 		; /* do nothing */
+
 	/*
 	 * If it does not even have a '<' and '>', that is
 	 * quite a bogus commit author and we discard it;
@@ -301,65 +303,72 @@ static void format_person_part(struct strbuf *sb, char part,
 	 * which means start (beginning of email address) must
 	 * be strictly below len.
 	 */
-	start = end + 1;
-	if (start >= len - 1)
-		return;
-	while (end > 0 && isspace(msg[end - 1]))
-		end--;
+	end_of_data = (end >= len - 1);
+
 	if (part == 'n') {	/* name */
-		strbuf_add(sb, msg, end);
-		return;
+		if (!end_of_data) {
+			while (end > 0 && isspace(msg[end - 1]))
+				end--;
+			strbuf_add(sb, msg, end);
+		}
+		return 2;
 	}
+	start = ++end; /* save email start position */
 
-	/* parse email */
-	for (end = start; end < len && msg[end] != '>'; end++)
+	/* advance 'end' to point to email end delimiter */
+	for ( ; end < len && msg[end] != '>'; end++)
 		; /* do nothing */
 
-	if (end >= len)
-		return;
+	end_of_data = (end >= len);
 
 	if (part == 'e') {	/* email */
-		strbuf_add(sb, msg + start, end - start);
-		return;
+		if (!end_of_data)
+			strbuf_add(sb, msg + start, end - start);
+		return 2;
 	}
-
-	/* parse date */
+	/* advance 'start' to point to date start delimiter */
 	for (start = end + 1; start < len && isspace(msg[start]); start++)
 		; /* do nothing */
-	if (start >= len)
-		return;
-	date = strtoul(msg + start, &ep, 10);
-	if (msg + start == ep)
-		return;
+
+	end_of_data = (start >= len);
+
+	if (!end_of_data)
+		date = strtoul(msg + start, &ep, 10);
 
 	if (part == 't') {	/* date, UNIX timestamp */
-		strbuf_add(sb, msg + start, ep - (msg + start));
-		return;
+		if (!end_of_data)
+			strbuf_add(sb, msg + start, ep - (msg + start));
+		return 2;
 	}
+	if (!end_of_data) {	/* parse tz */
+		for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
+			; /* do nothing */
 
-	/* parse tz */
-	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
-		; /* do nothing */
-	if (start + 1 < len) {
-		tz = strtoul(msg + start + 1, NULL, 10);
-		if (msg[start] == '-')
-			tz = -tz;
+		if (start + 1 < len) {
+			tz = strtoul(msg + start + 1, NULL, 10);
+			if (msg[start] == '-')
+				tz = -tz;
+		}
 	}
-
 	switch (part) {
-	case 'd':	/* date */
-		strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
-		return;
-	case 'D':	/* date, RFC2822 style */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
-		return;
-	case 'r':	/* date, relative */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
-		return;
-	case 'i':	/* date, ISO 8601 */
-		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
-		return;
-	}
+	case 'd': /* date */
+		if (!end_of_data)
+			strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
+		return 2;
+	case 'D': /* date, RFC2822 style */
+		if (!end_of_data)
+			strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
+		return 2;
+	case 'r': /* date, relative */
+		if (!end_of_data)
+			strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
+		return 2;
+	case 'i': /* date, ISO 8601 */
+		if (!end_of_data)
+			strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
+		return 2;
+	}
+	return 0; /* unknown placeholder */
 }
 
 struct chunk {
@@ -440,7 +449,7 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
-static void format_commit_item(struct strbuf *sb, const char *placeholder,
+static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
 	struct format_commit_context *c = context;
@@ -451,23 +460,23 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
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
 
 	/* these depend on the commit */
@@ -477,34 +486,34 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
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
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
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
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
-		return;
+		return 1;
 	case 'P':		/* parent hashes */
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
 		}
-		return;
+		return 1;
 	case 'p':		/* abbreviated parent hashes */
 		if (add_again(sb, &c->abbrev_parent_hashes))
-			return;
+			return 1;
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
@@ -513,14 +522,14 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
 		}
 		c->abbrev_parent_hashes.len = sb->len -
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
 
 	/* For the rest we have to parse the commit header. */
@@ -528,66 +537,33 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
 		parse_commit_header(c);
 
 	switch (placeholder[0]) {
-	case 's':
+	case 's':	/* subject */
 		strbuf_add(sb, msg + c->subject.off, c->subject.len);
-		return;
-	case 'a':
-		format_person_part(sb, placeholder[1],
+		return 1;
+	case 'a':	/* author ... */
+		return format_person_part(sb, placeholder[1],
 		                   msg + c->author.off, c->author.len);
-		return;
-	case 'c':
-		format_person_part(sb, placeholder[1],
+	case 'c':	/* committer ... */
+		return format_person_part(sb, placeholder[1],
 		                   msg + c->committer.off, c->committer.len);
-		return;
-	case 'e':
+	case 'e':	/* encoding */
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
-		return;
-	case 'b':
+		return 1;
+	case 'b':	/* body */
 		strbuf_addstr(sb, msg + c->body_off);
-		return;
+		return 1;
 	}
+	return 0;	/* unknown placeholder */
 }
 
 void format_commit_message(const struct commit *commit,
                            const void *format, struct strbuf *sb)
 {
-	const char *placeholders[] = {
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
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
-	strbuf_expand(sb, format, placeholders, format_commit_item, &context);
+	strbuf_expand(sb, format, format_commit_item, &context);
 }
 
 static void pp_header(enum cmit_fmt fmt,
diff --git a/strbuf.c b/strbuf.c
index 5efcfc8..32ab8e5 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -146,11 +146,12 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_expand(struct strbuf *sb, const char *format,
-                   const char **placeholders, expand_fn_t fn, void *context)
+void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
+                   void *context)
 {
 	for (;;) {
-		const char *percent, **p;
+		const char *percent;
+		size_t consumed;
 
 		percent = strchrnul(format, '%');
 		strbuf_add(sb, format, percent - format);
@@ -158,14 +159,10 @@ void strbuf_expand(struct strbuf *sb, const char *format,
 			break;
 		format = percent + 1;
 
-		for (p = placeholders; *p; p++) {
-			if (!prefixcmp(format, *p))
-				break;
-		}
-		if (*p) {
-			fn(sb, *p, context);
-			format += strlen(*p);
-		} else
+		consumed = fn(sb, format, context);
+		if (consumed)
+			format += consumed;
+		else
 			strbuf_addch(sb, '%');
 	}
 }
diff --git a/strbuf.h b/strbuf.h
index 36d61db..faec229 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -103,8 +103,8 @@ static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
 
-typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
-extern void strbuf_expand(struct strbuf *sb, const char *format, const char **placeholders, expand_fn_t fn, void *context);
+typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
+extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
 
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
-- 
1.5.4.rc4.39.g524a
