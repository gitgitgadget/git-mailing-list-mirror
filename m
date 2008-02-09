From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH TAKE 2] Avoid a useless prefix lookup in strbuf_expand()
Date: Sat,  9 Feb 2008 15:40:19 +0100
Message-ID: <1202568019-20200-1-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 09 15:41:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNqtx-000062-GF
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 15:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYBIOlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 09:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbYBIOlM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 09:41:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:53897 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbYBIOlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 09:41:11 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3201993fga.17
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Otu8t77HlTBKMKvlHqXAtad8Pd9maOwyPf8zRKLXsdk=;
        b=qxw2UuHBF4qNSikIbxuRNYHA04r5wnioSjJgZrpywUSyNaG/h4yTN12QBPDqEw/6ZUEdFjspxqH7pLbuKsCPQWafxBQoDdqHjXr/3EYmsdXpamOMgFJrzPwQ2jfhfPKtiWACpfSxvIi+JWaSU9uyQSxLvp7X0jLuoqgW6hq/Fpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AionF8Be2dGi8graETG6uYw1oa8KLNidGLTJOs6ZmWIJVTy7qXXRB5eIzfS/qzTmCnTfxX2JM81DHbpgwXall4qkFvPE+EMTFzQup5giJ9cm7TO1iuDAnJC1oj8EmPgQHnKutN8E0bEZ8TAHEVQURysr9NUr27+J1GgeqcQxQ68=
Received: by 10.86.52.1 with SMTP id z1mr12929349fgz.52.1202568067606;
        Sat, 09 Feb 2008 06:41:07 -0800 (PST)
Received: from localhost.localdomain ( [151.70.103.62])
        by mx.google.com with ESMTPS id 3sm15338294fge.7.2008.02.09.06.41.04
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 06:41:06 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1220.g1a838
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73233>

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

New patch with Junio suggestions included.

Apply above 'next' branch


 pretty.c |  167 ++++++++++++++++++++++++++-----------------------------------
 strbuf.c |   19 +++----
 strbuf.h |    4 +-
 3 files changed, 81 insertions(+), 109 deletions(-)

diff --git a/pretty.c b/pretty.c
index b987ff2..aed32f2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -282,59 +282,57 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static void format_person_part(struct strbuf *sb, char part,
+static size_t format_person_part(struct strbuf *sb, char part,
                                const char *msg, int len)
 {
+	const int placeholder_len = 2; /* currently all placeholders have same length */
 	int start, end, tz = 0;
-	unsigned long date;
+	unsigned long date = 0;
 	char *ep;
 
-	/* parse name */
+	/* advance 'end' to point to email start delimiter */
 	for (end = 0; end < len && msg[end] != '<'; end++)
 		; /* do nothing */
-	/*
-	 * If it does not even have a '<' and '>', that is
-	 * quite a bogus commit author and we discard it;
-	 * this is in line with add_user_info() that is used
-	 * in the normal codepath.  When end points at the '<'
-	 * that we found, it should have matching '>' later,
-	 * which means start (beginning of email address) must
-	 * be strictly below len.
+
+	/* When end points at the '<' that we found, it should have
+	 * matching '>' later, which means 'end' must be strictly
+	 * below len - 1.
 	 */
-	start = end + 1;
-	if (start >= len - 1)
-		return;
-	while (end > 0 && isspace(msg[end - 1]))
-		end--;
+	if (end >= len - 2)
+		goto skip;
+
 	if (part == 'n') {	/* name */
+		while (end > 0 && isspace(msg[end - 1]))
+			end--;
 		strbuf_add(sb, msg, end);
-		return;
+		return placeholder_len;
 	}
+	start = ++end; /* save email start position */
 
-	/* parse email */
-	for (end = start; end < len && msg[end] != '>'; end++)
+	/* advance 'end' to point to email end delimiter */
+	for ( ; end < len && msg[end] != '>'; end++)
 		; /* do nothing */
 
 	if (end >= len)
-		return;
+		goto skip;
 
 	if (part == 'e') {	/* email */
 		strbuf_add(sb, msg + start, end - start);
-		return;
+		return placeholder_len;
 	}
 
-	/* parse date */
+	/* advance 'start' to point to date start delimiter */
 	for (start = end + 1; start < len && isspace(msg[start]); start++)
 		; /* do nothing */
 	if (start >= len)
-		return;
+		goto skip;
 	date = strtoul(msg + start, &ep, 10);
 	if (msg + start == ep)
-		return;
+		goto skip;
 
 	if (part == 't') {	/* date, UNIX timestamp */
 		strbuf_add(sb, msg + start, ep - (msg + start));
-		return;
+		return placeholder_len;
 	}
 
 	/* parse tz */
@@ -349,17 +347,27 @@ static void format_person_part(struct strbuf *sb, char part,
 	switch (part) {
 	case 'd':	/* date */
 		strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
-		return;
+		return placeholder_len;
 	case 'D':	/* date, RFC2822 style */
 		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
-		return;
+		return placeholder_len;
 	case 'r':	/* date, relative */
 		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
-		return;
+		return placeholder_len;
 	case 'i':	/* date, ISO 8601 */
 		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
-		return;
+		return placeholder_len;
 	}
+
+skip:
+	/* bougus commit, 'sb' cannot be updated, but
+	 * still we need to compute a valid return value.
+	 */
+	if (   part == 'n' || part == 'e' || part == 't' || part == 'd'
+	    || part == 'D' || part == 'r' || part == 'i')
+		return placeholder_len;
+
+	return 0; /* unknown placeholder */
 }
 
 struct chunk {
@@ -440,7 +448,7 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
-static void format_commit_item(struct strbuf *sb, const char *placeholder,
+static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
 	struct format_commit_context *c = context;
@@ -451,23 +459,23 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
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
@@ -477,34 +485,34 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
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
@@ -513,14 +521,14 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
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
@@ -528,66 +536,33 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
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
1.5.4.1220.g1a838
