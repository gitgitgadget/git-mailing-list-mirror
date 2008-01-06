From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Avoid a useless prefix lookup in strbuf_expand()
Date: Sun, 6 Jan 2008 01:10:01 +0100
Message-ID: <e5bfff550801051610l3086ee7yccd8c23b8249a817@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_36803_19798465.1199578201680"
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 01:10:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBJ66-0007Ah-Fa
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 01:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbYAFAKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 19:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbYAFAKL
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 19:10:11 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:22459 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbYAFAKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 19:10:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6605249rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=8giFFgTMKBDhxA8pyqRqfrv1I/6PFveDl6k8Se5wcqs=;
        b=m4imccgckkjisUA7UaRTOsUc2BTpd+/fcVonhPYWAiTo9hKJc5uylQjbTpj+aiHCEIen4Z5g7gepnPnk8yCZlXztyy3eEMU/UZC8b9Xn71NJksYG/XeFQlBBLT+uIr8mcURDTbfzWZkhMwWt50mbpq6uSdjQtcWR0Hsq+Lp8keI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=vSw9bHQ+tZ1xE4ZqDF9GL3JeKBVFLUC8IRJXRKS5eVuEXAWDyf9+hRIpQX1XKckxF3vuO/Sv7iwu5VilL+vIlpark7vfSpNNtAu6iDP1IEfhu3bWymvO+idQLCeVkrjc6dkVa9TMDrVH0mLwaAyrowerBRDGNbu8T3q3t10ydUw=
Received: by 10.140.192.9 with SMTP id p9mr9733792rvf.103.1199578201688;
        Sat, 05 Jan 2008 16:10:01 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 5 Jan 2008 16:10:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69695>

------=_Part_36803_19798465.1199578201680
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Currently the --prett=format prefix is looked up in a
tight loop in strbuf_expand(), if found is passed as parameter
to format_commit_item() that does another search using a
switch statement to select the proper operation according to
the kind of prefix.

Because the switch statement is already able to discard unknown
matches we don't need the prefix lookup before to call format_commit_item()

This patch removes an useless loop in a very fasth path,
used by, as example, by 'git log' with --pretty=format option

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---


To apply on top of "[PATCH] Fix an off by one bug in pretty.c"


I send also as attached file because I thing my mailer will
word wrap this one.


pretty.c |  228 +++++++++++++++++++++++++++++--------------------------------
 strbuf.c |   19 ++---
 strbuf.h |    4 +-
 3 files changed, 118 insertions(+), 133 deletions(-)

diff --git a/pretty.c b/pretty.c
index 3ce5e6f..5132b1f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -282,76 +282,93 @@ static char *logmsg_reencode(const struct
 	return out;
 }

-static void format_person_part(struct strbuf *sb, char part,
-                               const char *msg, int len)
+static int parse_tz(char *ep, const char *msg, int len) {
+
+	int tz = 0, start = ep - msg + 1;
+
+	for ( ;start < len && isspace(msg[start]); start++)
+		; /* do nothing */
+
+	if (start + 1 < len) {
+		tz = strtoul(msg + start + 1, NULL, 10);
+		if (msg[start] == '-')
+			tz = -tz;
+	}
+	return tz;
+}
+
+static size_t format_person_part(struct strbuf *sb, char part,
+                                 const char *msg, int len)
 {
-	int start, end, tz = 0;
-	unsigned long date;
+	int start, end, tz = 0, date_valid;
+	unsigned long date = 0;
 	char *ep;

-	/* parse name */
+	/* advance 'end' to point to name end delimiter */
 	for (end = 0; end < len && msg[end] != '<'; end++)
 		; /* do nothing */
-	start = end + 1;
-	while (end > 0 && isspace(msg[end - 1]))
-		end--;
-	if (part == 'n') {	/* name */
+
+	if (part == 'n') { /* name */
+		while (end > 0 && isspace(msg[end - 1]))
+			end--;
+
 		strbuf_add(sb, msg, end);
-		return;
+		return 2;
 	}
+	start = ++end; /* save email start delimiter */

-	if (start >= len)
-		return;
-
-	/* parse email */
-	for (end = start; end < len && msg[end] != '>'; end++)
+	/* advance 'end' to point to email end delimiter */
+	for ( ; end < len && msg[end] != '>'; end++)
 		; /* do nothing */

-	if (end >= len)
-		return;
-
-	if (part == 'e') {	/* email */
-		strbuf_add(sb, msg + start, end - start);
-		return;
+	if (part == 'e') { /* email */
+		if (end - start > 0)
+			strbuf_add(sb, msg + start, end - start);
+		return 2;
 	}

-	/* parse date */
+	/* advance 'start' to point to date start delimiter */
 	for (start = end + 1; start < len && isspace(msg[start]); start++)
 		; /* do nothing */
-	if (start >= len)
-		return;
-	date = strtoul(msg + start, &ep, 10);
-	if (msg + start == ep)
-		return;

-	if (part == 't') {	/* date, UNIX timestamp */
-		strbuf_add(sb, msg + start, ep - (msg + start));
-		return;
-	}
+	date_valid = start < len;

-	/* parse tz */
-	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
-		; /* do nothing */
-	if (start + 1 < len) {
-		tz = strtoul(msg + start + 1, NULL, 10);
-		if (msg[start] == '-')
-			tz = -tz;
+	if (date_valid)
+		date = strtoul(msg + start, &ep, 10);
+
+	if (part == 't') { /* date, UNIX timestamp */
+		if (date_valid && msg + start != ep)
+			strbuf_add(sb, msg + start, ep - (msg + start));
+		return 2;
 	}

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
+	case 'd': /* date */
+		if (date_valid) {
+			tz = parse_tz(ep, msg, len);
+			strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
+		}
+		return 2;
+	case 'D': /* date, RFC2822 style */
+		if (date_valid) {
+			tz = parse_tz(ep, msg, len);
+			strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
+		}
+		return 2;
+	case 'r': /* date, relative */
+		if (date_valid) {
+			tz = parse_tz(ep, msg, len);
+			strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
+		}
+		return 2;
+	case 'i': /* date, ISO 8601 */
+		if (date_valid) {
+			tz = parse_tz(ep, msg, len);
+			strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
+		}
+		return 2;
 	}
+	return 0; /* unknown person part */
 }

 struct chunk {
@@ -432,8 +449,8 @@ static void parse_commit_header(struct format_
 	context->commit_header_parsed = 1;
 }

-static void format_commit_item(struct strbuf *sb, const char *placeholder,
-                               void *context)
+static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
+                                 void *context)
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
@@ -443,23 +460,23 @@ static void format_commit_item(struct strbuf *sb,
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
@@ -469,34 +486,34 @@ static void format_commit_item(struct strbuf *sb,
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
@@ -505,14 +522,14 @@ static void format_commit_item(struct strbuf
*sb, const char *placeholder,
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
@@ -520,66 +537,37 @@ static void format_commit_item(struct strbuf *sb,
 		parse_commit_header(c);

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
+		return format_person_part(sb, placeholder[1],
+		                       msg + c->author.off,
+		                       c->author.len);
+
+	case 'c':		/* committer ... */
+		return format_person_part(sb, placeholder[1],
+		                       msg + c->committer.off,
+		                       c->committer.len);
+
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
@@ -146,11 +146,12 @@ void strbuf_addf(struct strbuf *sb,
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
@@ -158,14 +159,10 @@ void strbuf_expand(struct strbuf *sb,
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
@@ -103,8 +103,8 @@ static inline void strbuf_addbuf(struct strbuf *sb,
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);

-typedef void (*expand_fn_t) (struct strbuf *sb, const char
*placeholder, void *context);
-extern void strbuf_expand(struct strbuf *sb, const char *format,
const char **placeholders, expand_fn_t fn, void *context);
+typedef size_t (*expand_fn_t) (struct strbuf *sb, const char
*placeholder, void *context);
+extern void strbuf_expand(struct strbuf *sb, const char *format,
expand_fn_t fn, void *context);

 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);

------=_Part_36803_19798465.1199578201680
Content-Type: text/plain; name=avoid_prefix_lookup.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fb2tp3lu0
Content-Disposition: attachment; filename=avoid_prefix_lookup.txt

U3ViamVjdDogW1BBVENIXSBBdm9pZCBhIHVzZWxlc3MgcHJlZml4IGxvb2t1cCBpbiBzdHJidWZf
ZXhwYW5kKCkKCkN1cnJlbnRseSB0aGUgLS1wcmV0dD1mb3JtYXQgcHJlZml4IGlzIGxvb2tlZCB1
cCBpbiBhCnRpZ2h0IGxvb3AgaW4gc3RyYnVmX2V4cGFuZCgpLCBpZiBmb3VuZCBpcyBwYXNzZWQg
YXMgcGFyYW1ldGVyCnRvIGZvcm1hdF9jb21taXRfaXRlbSgpIHRoYXQgZG9lcyBhbm90aGVyIHNl
YXJjaCB1c2luZyBhCnN3aXRjaCBzdGF0ZW1lbnQgdG8gc2VsZWN0IHRoZSBwcm9wZXIgb3BlcmF0
aW9uIGFjY29yZGluZyB0bwp0aGUga2luZCBvZiBwcmVmaXguCgpCZWNhdXNlIHRoZSBzd2l0Y2gg
c3RhdGVtZW50IGlzIGFscmVhZHkgYWJsZSB0byBkaXNjYXJkIHVua25vd24KbWF0Y2hlcyB3ZSBk
b24ndCBuZWVkIHRoZSBwcmVmaXggbG9va3VwIGJlZm9yZSB0byBjYWxsIGZvcm1hdF9jb21taXRf
aXRlbSgpCgpUaGlzIHBhdGNoIHJlbW92ZXMgYW4gdXNlbGVzcyBsb29wIGluIGEgdmVyeSBmYXN0
aCBwYXRoLAp1c2VkIGJ5LCBhcyBleGFtcGxlLCBieSAnZ2l0IGxvZycgd2l0aCAtLXByZXR0eT1m
b3JtYXQgb3B0aW9uCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBDb3N0YWxiYSA8bWNvc3RhbGJhQGdt
YWlsLmNvbT4KLS0tCgoKVG8gYXBwbHkgb24gdG9wIG9mICJbUEFUQ0hdIEZpeCBhbiBvZmYgYnkg
b25lIGJ1ZyBpbiBwcmV0dHkuYyIKCgpwcmV0dHkuYyB8ICAyMjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogc3RyYnVmLmMgfCAg
IDE5ICsrLS0tCiBzdHJidWYuaCB8ICAgIDQgKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTE4IGluc2Vy
dGlvbnMoKyksIDEzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wcmV0dHkuYyBiL3ByZXR0
eS5jCmluZGV4IDNjZTVlNmYuLjUxMzJiMWYgMTAwNjQ0Ci0tLSBhL3ByZXR0eS5jCisrKyBiL3By
ZXR0eS5jCkBAIC0yODIsNzYgKzI4Miw5MyBAQCBzdGF0aWMgY2hhciAqbG9nbXNnX3JlZW5jb2Rl
KGNvbnN0IHN0cnVjdCAKIAlyZXR1cm4gb3V0OwogfQogCi1zdGF0aWMgdm9pZCBmb3JtYXRfcGVy
c29uX3BhcnQoc3RydWN0IHN0cmJ1ZiAqc2IsIGNoYXIgcGFydCwKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCBjaGFyICptc2csIGludCBsZW4pCitzdGF0aWMgaW50IHBhcnNl
X3R6KGNoYXIgKmVwLCBjb25zdCBjaGFyICptc2csIGludCBsZW4pIHsKKworCWludCB0eiA9IDAs
IHN0YXJ0ID0gZXAgLSBtc2cgKyAxOworCisJZm9yICggO3N0YXJ0IDwgbGVuICYmIGlzc3BhY2Uo
bXNnW3N0YXJ0XSk7IHN0YXJ0KyspCisJCTsgLyogZG8gbm90aGluZyAqLworCisJaWYgKHN0YXJ0
ICsgMSA8IGxlbikgeworCQl0eiA9IHN0cnRvdWwobXNnICsgc3RhcnQgKyAxLCBOVUxMLCAxMCk7
CisJCWlmIChtc2dbc3RhcnRdID09ICctJykKKwkJCXR6ID0gLXR6OworCX0KKwlyZXR1cm4gdHo7
Cit9CisKK3N0YXRpYyBzaXplX3QgZm9ybWF0X3BlcnNvbl9wYXJ0KHN0cnVjdCBzdHJidWYgKnNi
LCBjaGFyIHBhcnQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFy
ICptc2csIGludCBsZW4pCiB7Ci0JaW50IHN0YXJ0LCBlbmQsIHR6ID0gMDsKLQl1bnNpZ25lZCBs
b25nIGRhdGU7CisJaW50IHN0YXJ0LCBlbmQsIHR6ID0gMCwgZGF0ZV92YWxpZDsKKwl1bnNpZ25l
ZCBsb25nIGRhdGUgPSAwOwogCWNoYXIgKmVwOwogCi0JLyogcGFyc2UgbmFtZSAqLworCS8qIGFk
dmFuY2UgJ2VuZCcgdG8gcG9pbnQgdG8gbmFtZSBlbmQgZGVsaW1pdGVyICovCiAJZm9yIChlbmQg
PSAwOyBlbmQgPCBsZW4gJiYgbXNnW2VuZF0gIT0gJzwnOyBlbmQrKykKIAkJOyAvKiBkbyBub3Ro
aW5nICovCi0Jc3RhcnQgPSBlbmQgKyAxOwotCXdoaWxlIChlbmQgPiAwICYmIGlzc3BhY2UobXNn
W2VuZCAtIDFdKSkKLQkJZW5kLS07Ci0JaWYgKHBhcnQgPT0gJ24nKSB7CS8qIG5hbWUgKi8KKwor
CWlmIChwYXJ0ID09ICduJykgeyAvKiBuYW1lICovCisJCXdoaWxlIChlbmQgPiAwICYmIGlzc3Bh
Y2UobXNnW2VuZCAtIDFdKSkKKwkJCWVuZC0tOworCiAJCXN0cmJ1Zl9hZGQoc2IsIG1zZywgZW5k
KTsKLQkJcmV0dXJuOworCQlyZXR1cm4gMjsKIAl9CisJc3RhcnQgPSArK2VuZDsgLyogc2F2ZSBl
bWFpbCBzdGFydCBkZWxpbWl0ZXIgKi8KIAotCWlmIChzdGFydCA+PSBsZW4pCi0JCXJldHVybjsK
LQotCS8qIHBhcnNlIGVtYWlsICovCi0JZm9yIChlbmQgPSBzdGFydDsgZW5kIDwgbGVuICYmIG1z
Z1tlbmRdICE9ICc+JzsgZW5kKyspCisJLyogYWR2YW5jZSAnZW5kJyB0byBwb2ludCB0byBlbWFp
bCBlbmQgZGVsaW1pdGVyICovCisJZm9yICggOyBlbmQgPCBsZW4gJiYgbXNnW2VuZF0gIT0gJz4n
OyBlbmQrKykKIAkJOyAvKiBkbyBub3RoaW5nICovCiAKLQlpZiAoZW5kID49IGxlbikKLQkJcmV0
dXJuOwotCi0JaWYgKHBhcnQgPT0gJ2UnKSB7CS8qIGVtYWlsICovCi0JCXN0cmJ1Zl9hZGQoc2Is
IG1zZyArIHN0YXJ0LCBlbmQgLSBzdGFydCk7Ci0JCXJldHVybjsKKwlpZiAocGFydCA9PSAnZScp
IHsgLyogZW1haWwgKi8KKwkJaWYgKGVuZCAtIHN0YXJ0ID4gMCkKKwkJCXN0cmJ1Zl9hZGQoc2Is
IG1zZyArIHN0YXJ0LCBlbmQgLSBzdGFydCk7CisJCXJldHVybiAyOwogCX0KIAotCS8qIHBhcnNl
IGRhdGUgKi8KKwkvKiBhZHZhbmNlICdzdGFydCcgdG8gcG9pbnQgdG8gZGF0ZSBzdGFydCBkZWxp
bWl0ZXIgKi8KIAlmb3IgKHN0YXJ0ID0gZW5kICsgMTsgc3RhcnQgPCBsZW4gJiYgaXNzcGFjZSht
c2dbc3RhcnRdKTsgc3RhcnQrKykKIAkJOyAvKiBkbyBub3RoaW5nICovCi0JaWYgKHN0YXJ0ID49
IGxlbikKLQkJcmV0dXJuOwotCWRhdGUgPSBzdHJ0b3VsKG1zZyArIHN0YXJ0LCAmZXAsIDEwKTsK
LQlpZiAobXNnICsgc3RhcnQgPT0gZXApCi0JCXJldHVybjsKIAotCWlmIChwYXJ0ID09ICd0Jykg
ewkvKiBkYXRlLCBVTklYIHRpbWVzdGFtcCAqLwotCQlzdHJidWZfYWRkKHNiLCBtc2cgKyBzdGFy
dCwgZXAgLSAobXNnICsgc3RhcnQpKTsKLQkJcmV0dXJuOwotCX0KKwlkYXRlX3ZhbGlkID0gc3Rh
cnQgPCBsZW47CiAKLQkvKiBwYXJzZSB0eiAqLwotCWZvciAoc3RhcnQgPSBlcCAtIG1zZyArIDE7
IHN0YXJ0IDwgbGVuICYmIGlzc3BhY2UobXNnW3N0YXJ0XSk7IHN0YXJ0KyspCi0JCTsgLyogZG8g
bm90aGluZyAqLwotCWlmIChzdGFydCArIDEgPCBsZW4pIHsKLQkJdHogPSBzdHJ0b3VsKG1zZyAr
IHN0YXJ0ICsgMSwgTlVMTCwgMTApOwotCQlpZiAobXNnW3N0YXJ0XSA9PSAnLScpCi0JCQl0eiA9
IC10ejsKKwlpZiAoZGF0ZV92YWxpZCkKKwkJZGF0ZSA9IHN0cnRvdWwobXNnICsgc3RhcnQsICZl
cCwgMTApOworCisJaWYgKHBhcnQgPT0gJ3QnKSB7IC8qIGRhdGUsIFVOSVggdGltZXN0YW1wICov
CisJCWlmIChkYXRlX3ZhbGlkICYmIG1zZyArIHN0YXJ0ICE9IGVwKQorCQkJc3RyYnVmX2FkZChz
YiwgbXNnICsgc3RhcnQsIGVwIC0gKG1zZyArIHN0YXJ0KSk7CisJCXJldHVybiAyOwogCX0KIAog
CXN3aXRjaCAocGFydCkgewotCWNhc2UgJ2QnOgkvKiBkYXRlICovCi0JCXN0cmJ1Zl9hZGRzdHIo
c2IsIHNob3dfZGF0ZShkYXRlLCB0eiwgREFURV9OT1JNQUwpKTsKLQkJcmV0dXJuOwotCWNhc2Ug
J0QnOgkvKiBkYXRlLCBSRkMyODIyIHN0eWxlICovCi0JCXN0cmJ1Zl9hZGRzdHIoc2IsIHNob3df
ZGF0ZShkYXRlLCB0eiwgREFURV9SRkMyODIyKSk7Ci0JCXJldHVybjsKLQljYXNlICdyJzoJLyog
ZGF0ZSwgcmVsYXRpdmUgKi8KLQkJc3RyYnVmX2FkZHN0cihzYiwgc2hvd19kYXRlKGRhdGUsIHR6
LCBEQVRFX1JFTEFUSVZFKSk7Ci0JCXJldHVybjsKLQljYXNlICdpJzoJLyogZGF0ZSwgSVNPIDg2
MDEgKi8KLQkJc3RyYnVmX2FkZHN0cihzYiwgc2hvd19kYXRlKGRhdGUsIHR6LCBEQVRFX0lTTzg2
MDEpKTsKLQkJcmV0dXJuOworCWNhc2UgJ2QnOiAvKiBkYXRlICovCisJCWlmIChkYXRlX3ZhbGlk
KSB7CisJCQl0eiA9IHBhcnNlX3R6KGVwLCBtc2csIGxlbik7CisJCQlzdHJidWZfYWRkc3RyKHNi
LCBzaG93X2RhdGUoZGF0ZSwgdHosIERBVEVfTk9STUFMKSk7CisJCX0KKwkJcmV0dXJuIDI7CisJ
Y2FzZSAnRCc6IC8qIGRhdGUsIFJGQzI4MjIgc3R5bGUgKi8KKwkJaWYgKGRhdGVfdmFsaWQpIHsK
KwkJCXR6ID0gcGFyc2VfdHooZXAsIG1zZywgbGVuKTsKKwkJCXN0cmJ1Zl9hZGRzdHIoc2IsIHNo
b3dfZGF0ZShkYXRlLCB0eiwgREFURV9SRkMyODIyKSk7CisJCX0KKwkJcmV0dXJuIDI7CisJY2Fz
ZSAncic6IC8qIGRhdGUsIHJlbGF0aXZlICovCisJCWlmIChkYXRlX3ZhbGlkKSB7CisJCQl0eiA9
IHBhcnNlX3R6KGVwLCBtc2csIGxlbik7CisJCQlzdHJidWZfYWRkc3RyKHNiLCBzaG93X2RhdGUo
ZGF0ZSwgdHosIERBVEVfUkVMQVRJVkUpKTsKKwkJfQorCQlyZXR1cm4gMjsKKwljYXNlICdpJzog
LyogZGF0ZSwgSVNPIDg2MDEgKi8KKwkJaWYgKGRhdGVfdmFsaWQpIHsKKwkJCXR6ID0gcGFyc2Vf
dHooZXAsIG1zZywgbGVuKTsKKwkJCXN0cmJ1Zl9hZGRzdHIoc2IsIHNob3dfZGF0ZShkYXRlLCB0
eiwgREFURV9JU084NjAxKSk7CisJCX0KKwkJcmV0dXJuIDI7CiAJfQorCXJldHVybiAwOyAvKiB1
bmtub3duIHBlcnNvbiBwYXJ0ICovCiB9CiAKIHN0cnVjdCBjaHVuayB7CkBAIC00MzIsOCArNDQ5
LDggQEAgc3RhdGljIHZvaWQgcGFyc2VfY29tbWl0X2hlYWRlcihzdHJ1Y3QgZm9ybWF0XwogCWNv
bnRleHQtPmNvbW1pdF9oZWFkZXJfcGFyc2VkID0gMTsKIH0KIAotc3RhdGljIHZvaWQgZm9ybWF0
X2NvbW1pdF9pdGVtKHN0cnVjdCBzdHJidWYgKnNiLCBjb25zdCBjaGFyICpwbGFjZWhvbGRlciwK
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpjb250ZXh0KQorc3RhdGljIHNp
emVfdCBmb3JtYXRfY29tbWl0X2l0ZW0oc3RydWN0IHN0cmJ1ZiAqc2IsIGNvbnN0IGNoYXIgKnBs
YWNlaG9sZGVyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqY29udGV4
dCkKIHsKIAlzdHJ1Y3QgZm9ybWF0X2NvbW1pdF9jb250ZXh0ICpjID0gY29udGV4dDsKIAljb25z
dCBzdHJ1Y3QgY29tbWl0ICpjb21taXQgPSBjLT5jb21taXQ7CkBAIC00NDMsMjMgKzQ2MCwyMyBA
QCBzdGF0aWMgdm9pZCBmb3JtYXRfY29tbWl0X2l0ZW0oc3RydWN0IHN0cmJ1ZiAqc2IsIAogCS8q
IHRoZXNlIGFyZSBpbmRlcGVuZGVudCBvZiB0aGUgY29tbWl0ICovCiAJc3dpdGNoIChwbGFjZWhv
bGRlclswXSkgewogCWNhc2UgJ0MnOgotCQlzd2l0Y2ggKHBsYWNlaG9sZGVyWzNdKSB7Ci0JCWNh
c2UgJ2QnOgkvKiByZWQgKi8KKwkJaWYgKCFwcmVmaXhjbXAocGxhY2Vob2xkZXIgKyAxLCAicmVk
IikpIHsKIAkJCXN0cmJ1Zl9hZGRzdHIoc2IsICJcMDMzWzMxbSIpOwotCQkJcmV0dXJuOwotCQlj
YXNlICdlJzoJLyogZ3JlZW4gKi8KKwkJCXJldHVybiA0OworCQl9IGVsc2UgaWYgKCFwcmVmaXhj
bXAocGxhY2Vob2xkZXIgKyAxLCAiZ3JlZW4iKSkgewogCQkJc3RyYnVmX2FkZHN0cihzYiwgIlww
MzNbMzJtIik7Ci0JCQlyZXR1cm47Ci0JCWNhc2UgJ3UnOgkvKiBibHVlICovCisJCQlyZXR1cm4g
NjsKKwkJfSBlbHNlIGlmICghcHJlZml4Y21wKHBsYWNlaG9sZGVyICsgMSwgImJsdWUiKSkgewog
CQkJc3RyYnVmX2FkZHN0cihzYiwgIlwwMzNbMzRtIik7Ci0JCQlyZXR1cm47Ci0JCWNhc2UgJ3Mn
OgkvKiByZXNldCBjb2xvciAqLworCQkJcmV0dXJuIDU7CisJCX0gZWxzZSBpZiAoIXByZWZpeGNt
cChwbGFjZWhvbGRlciArIDEsICJyZXNldCIpKSB7CiAJCQlzdHJidWZfYWRkc3RyKHNiLCAiXDAz
M1ttIik7Ci0JCQlyZXR1cm47Ci0JCX0KKwkJCXJldHVybiA2OworCQl9IGVsc2UKKwkJCXJldHVy
biAwOwogCWNhc2UgJ24nOgkJLyogbmV3bGluZSAqLwogCQlzdHJidWZfYWRkY2goc2IsICdcbicp
OwotCQlyZXR1cm47CisJCXJldHVybiAxOwogCX0KIAogCS8qIHRoZXNlIGRlcGVuZCBvbiB0aGUg
Y29tbWl0ICovCkBAIC00NjksMzQgKzQ4NiwzNCBAQCBzdGF0aWMgdm9pZCBmb3JtYXRfY29tbWl0
X2l0ZW0oc3RydWN0IHN0cmJ1ZiAqc2IsIAogCXN3aXRjaCAocGxhY2Vob2xkZXJbMF0pIHsKIAlj
YXNlICdIJzoJCS8qIGNvbW1pdCBoYXNoICovCiAJCXN0cmJ1Zl9hZGRzdHIoc2IsIHNoYTFfdG9f
aGV4KGNvbW1pdC0+b2JqZWN0LnNoYTEpKTsKLQkJcmV0dXJuOworCQlyZXR1cm4gMTsKIAljYXNl
ICdoJzoJCS8qIGFiYnJldmlhdGVkIGNvbW1pdCBoYXNoICovCiAJCWlmIChhZGRfYWdhaW4oc2Is
ICZjLT5hYmJyZXZfY29tbWl0X2hhc2gpKQotCQkJcmV0dXJuOworCQkJcmV0dXJuIDE7CiAJCXN0
cmJ1Zl9hZGRzdHIoc2IsIGZpbmRfdW5pcXVlX2FiYnJldihjb21taXQtPm9iamVjdC5zaGExLAog
CQkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgREVGQVVMVF9BQkJSRVYpKTsK
IAkJYy0+YWJicmV2X2NvbW1pdF9oYXNoLmxlbiA9IHNiLT5sZW4gLSBjLT5hYmJyZXZfY29tbWl0
X2hhc2gub2ZmOwotCQlyZXR1cm47CisJCXJldHVybiAxOwogCWNhc2UgJ1QnOgkJLyogdHJlZSBo
YXNoICovCiAJCXN0cmJ1Zl9hZGRzdHIoc2IsIHNoYTFfdG9faGV4KGNvbW1pdC0+dHJlZS0+b2Jq
ZWN0LnNoYTEpKTsKLQkJcmV0dXJuOworCQlyZXR1cm4gMTsKIAljYXNlICd0JzoJCS8qIGFiYnJl
dmlhdGVkIHRyZWUgaGFzaCAqLwogCQlpZiAoYWRkX2FnYWluKHNiLCAmYy0+YWJicmV2X3RyZWVf
aGFzaCkpCi0JCQlyZXR1cm47CisJCQlyZXR1cm4gMTsKIAkJc3RyYnVmX2FkZHN0cihzYiwgZmlu
ZF91bmlxdWVfYWJicmV2KGNvbW1pdC0+dHJlZS0+b2JqZWN0LnNoYTEsCiAJCSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBERUZBVUxUX0FCQlJFVikpOwogCQljLT5hYmJyZXZf
dHJlZV9oYXNoLmxlbiA9IHNiLT5sZW4gLSBjLT5hYmJyZXZfdHJlZV9oYXNoLm9mZjsKLQkJcmV0
dXJuOworCQlyZXR1cm4gMTsKIAljYXNlICdQJzoJCS8qIHBhcmVudCBoYXNoZXMgKi8KIAkJZm9y
IChwID0gY29tbWl0LT5wYXJlbnRzOyBwOyBwID0gcC0+bmV4dCkgewogCQkJaWYgKHAgIT0gY29t
bWl0LT5wYXJlbnRzKQogCQkJCXN0cmJ1Zl9hZGRjaChzYiwgJyAnKTsKIAkJCXN0cmJ1Zl9hZGRz
dHIoc2IsIHNoYTFfdG9faGV4KHAtPml0ZW0tPm9iamVjdC5zaGExKSk7CiAJCX0KLQkJcmV0dXJu
OworCQlyZXR1cm4gMTsKIAljYXNlICdwJzoJCS8qIGFiYnJldmlhdGVkIHBhcmVudCBoYXNoZXMg
Ki8KIAkJaWYgKGFkZF9hZ2FpbihzYiwgJmMtPmFiYnJldl9wYXJlbnRfaGFzaGVzKSkKLQkJCXJl
dHVybjsKKwkJCXJldHVybiAxOwogCQlmb3IgKHAgPSBjb21taXQtPnBhcmVudHM7IHA7IHAgPSBw
LT5uZXh0KSB7CiAJCQlpZiAocCAhPSBjb21taXQtPnBhcmVudHMpCiAJCQkJc3RyYnVmX2FkZGNo
KHNiLCAnICcpOwpAQCAtNTA1LDE0ICs1MjIsMTQgQEAgc3RhdGljIHZvaWQgZm9ybWF0X2NvbW1p
dF9pdGVtKHN0cnVjdCBzdHJidWYgKnNiLCBjb25zdCBjaGFyICpwbGFjZWhvbGRlciwKIAkJfQog
CQljLT5hYmJyZXZfcGFyZW50X2hhc2hlcy5sZW4gPSBzYi0+bGVuIC0KIAkJICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYy0+YWJicmV2X3BhcmVudF9oYXNoZXMub2ZmOwotCQlyZXR1cm47
CisJCXJldHVybiAxOwogCWNhc2UgJ20nOgkJLyogbGVmdC9yaWdodC9ib3R0b20gKi8KIAkJc3Ry
YnVmX2FkZGNoKHNiLCAoY29tbWl0LT5vYmplY3QuZmxhZ3MgJiBCT1VOREFSWSkKIAkJICAgICAg
ICAgICAgICAgICA/ICctJwogCQkgICAgICAgICAgICAgICAgIDogKGNvbW1pdC0+b2JqZWN0LmZs
YWdzICYgU1lNTUVUUklDX0xFRlQpCiAJCSAgICAgICAgICAgICAgICAgPyAnPCcKIAkJICAgICAg
ICAgICAgICAgICA6ICc+Jyk7Ci0JCXJldHVybjsKKwkJcmV0dXJuIDE7CiAJfQogCiAJLyogRm9y
IHRoZSByZXN0IHdlIGhhdmUgdG8gcGFyc2UgdGhlIGNvbW1pdCBoZWFkZXIuICovCkBAIC01MjAs
NjYgKzUzNywzNyBAQCBzdGF0aWMgdm9pZCBmb3JtYXRfY29tbWl0X2l0ZW0oc3RydWN0IHN0cmJ1
ZiAqc2IsCiAJCXBhcnNlX2NvbW1pdF9oZWFkZXIoYyk7CiAKIAlzd2l0Y2ggKHBsYWNlaG9sZGVy
WzBdKSB7Ci0JY2FzZSAncyc6CisJY2FzZSAncyc6CQkvKiBzdWJqZWN0ICovCiAJCXN0cmJ1Zl9h
ZGQoc2IsIG1zZyArIGMtPnN1YmplY3Qub2ZmLCBjLT5zdWJqZWN0Lmxlbik7Ci0JCXJldHVybjsK
LQljYXNlICdhJzoKLQkJZm9ybWF0X3BlcnNvbl9wYXJ0KHNiLCBwbGFjZWhvbGRlclsxXSwKLQkJ
ICAgICAgICAgICAgICAgICAgIG1zZyArIGMtPmF1dGhvci5vZmYsIGMtPmF1dGhvci5sZW4pOwot
CQlyZXR1cm47Ci0JY2FzZSAnYyc6Ci0JCWZvcm1hdF9wZXJzb25fcGFydChzYiwgcGxhY2Vob2xk
ZXJbMV0sCi0JCSAgICAgICAgICAgICAgICAgICBtc2cgKyBjLT5jb21taXR0ZXIub2ZmLCBjLT5j
b21taXR0ZXIubGVuKTsKLQkJcmV0dXJuOwotCWNhc2UgJ2UnOgorCQlyZXR1cm4gMTsKKwljYXNl
ICdhJzoJCS8qIGF1dGhvciAuLi4gKi8KKwkJcmV0dXJuIGZvcm1hdF9wZXJzb25fcGFydChzYiwg
cGxhY2Vob2xkZXJbMV0sCisJCSAgICAgICAgICAgICAgICAgICAgICAgbXNnICsgYy0+YXV0aG9y
Lm9mZiwKKwkJICAgICAgICAgICAgICAgICAgICAgICBjLT5hdXRob3IubGVuKTsKKworCWNhc2Ug
J2MnOgkJLyogY29tbWl0dGVyIC4uLiAqLworCQlyZXR1cm4gZm9ybWF0X3BlcnNvbl9wYXJ0KHNi
LCBwbGFjZWhvbGRlclsxXSwKKwkJICAgICAgICAgICAgICAgICAgICAgICBtc2cgKyBjLT5jb21t
aXR0ZXIub2ZmLAorCQkgICAgICAgICAgICAgICAgICAgICAgIGMtPmNvbW1pdHRlci5sZW4pOwor
CisJY2FzZSAnZSc6CQkvKiBlbmNvZGluZyAqLwogCQlzdHJidWZfYWRkKHNiLCBtc2cgKyBjLT5l
bmNvZGluZy5vZmYsIGMtPmVuY29kaW5nLmxlbik7Ci0JCXJldHVybjsKLQljYXNlICdiJzoKKwkJ
cmV0dXJuIDE7CisJY2FzZSAnYic6CQkvKiBib2R5ICovCiAJCXN0cmJ1Zl9hZGRzdHIoc2IsIG1z
ZyArIGMtPmJvZHlfb2ZmKTsKLQkJcmV0dXJuOworCQlyZXR1cm4gMTsKIAl9CisJcmV0dXJuIDA7
CQkvKiB1bmtub3duIHBsYWNlaG9sZGVyICovCiB9CiAKIHZvaWQgZm9ybWF0X2NvbW1pdF9tZXNz
YWdlKGNvbnN0IHN0cnVjdCBjb21taXQgKmNvbW1pdCwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IHZvaWQgKmZvcm1hdCwgc3RydWN0IHN0cmJ1ZiAqc2IpCiB7Ci0JY29uc3QgY2hh
ciAqcGxhY2Vob2xkZXJzW10gPSB7Ci0JCSJIIiwJCS8qIGNvbW1pdCBoYXNoICovCi0JCSJoIiwJ
CS8qIGFiYnJldmlhdGVkIGNvbW1pdCBoYXNoICovCi0JCSJUIiwJCS8qIHRyZWUgaGFzaCAqLwot
CQkidCIsCQkvKiBhYmJyZXZpYXRlZCB0cmVlIGhhc2ggKi8KLQkJIlAiLAkJLyogcGFyZW50IGhh
c2hlcyAqLwotCQkicCIsCQkvKiBhYmJyZXZpYXRlZCBwYXJlbnQgaGFzaGVzICovCi0JCSJhbiIs
CQkvKiBhdXRob3IgbmFtZSAqLwotCQkiYWUiLAkJLyogYXV0aG9yIGVtYWlsICovCi0JCSJhZCIs
CQkvKiBhdXRob3IgZGF0ZSAqLwotCQkiYUQiLAkJLyogYXV0aG9yIGRhdGUsIFJGQzI4MjIgc3R5
bGUgKi8KLQkJImFyIiwJCS8qIGF1dGhvciBkYXRlLCByZWxhdGl2ZSAqLwotCQkiYXQiLAkJLyog
YXV0aG9yIGRhdGUsIFVOSVggdGltZXN0YW1wICovCi0JCSJhaSIsCQkvKiBhdXRob3IgZGF0ZSwg
SVNPIDg2MDEgKi8KLQkJImNuIiwJCS8qIGNvbW1pdHRlciBuYW1lICovCi0JCSJjZSIsCQkvKiBj
b21taXR0ZXIgZW1haWwgKi8KLQkJImNkIiwJCS8qIGNvbW1pdHRlciBkYXRlICovCi0JCSJjRCIs
CQkvKiBjb21taXR0ZXIgZGF0ZSwgUkZDMjgyMiBzdHlsZSAqLwotCQkiY3IiLAkJLyogY29tbWl0
dGVyIGRhdGUsIHJlbGF0aXZlICovCi0JCSJjdCIsCQkvKiBjb21taXR0ZXIgZGF0ZSwgVU5JWCB0
aW1lc3RhbXAgKi8KLQkJImNpIiwJCS8qIGNvbW1pdHRlciBkYXRlLCBJU08gODYwMSAqLwotCQki
ZSIsCQkvKiBlbmNvZGluZyAqLwotCQkicyIsCQkvKiBzdWJqZWN0ICovCi0JCSJiIiwJCS8qIGJv
ZHkgKi8KLQkJIkNyZWQiLAkJLyogcmVkICovCi0JCSJDZ3JlZW4iLAkvKiBncmVlbiAqLwotCQki
Q2JsdWUiLAkvKiBibHVlICovCi0JCSJDcmVzZXQiLAkvKiByZXNldCBjb2xvciAqLwotCQkibiIs
CQkvKiBuZXdsaW5lICovCi0JCSJtIiwJCS8qIGxlZnQvcmlnaHQvYm90dG9tICovCi0JCU5VTEwK
LQl9OwogCXN0cnVjdCBmb3JtYXRfY29tbWl0X2NvbnRleHQgY29udGV4dDsKIAogCW1lbXNldCgm
Y29udGV4dCwgMCwgc2l6ZW9mKGNvbnRleHQpKTsKIAljb250ZXh0LmNvbW1pdCA9IGNvbW1pdDsK
LQlzdHJidWZfZXhwYW5kKHNiLCBmb3JtYXQsIHBsYWNlaG9sZGVycywgZm9ybWF0X2NvbW1pdF9p
dGVtLCAmY29udGV4dCk7CisJc3RyYnVmX2V4cGFuZChzYiwgZm9ybWF0LCBmb3JtYXRfY29tbWl0
X2l0ZW0sICZjb250ZXh0KTsKIH0KIAogc3RhdGljIHZvaWQgcHBfaGVhZGVyKGVudW0gY21pdF9m
bXQgZm10LApkaWZmIC0tZ2l0IGEvc3RyYnVmLmMgYi9zdHJidWYuYwppbmRleCA1ZWZjZmM4Li4z
MmFiOGU1IDEwMDY0NAotLS0gYS9zdHJidWYuYworKysgYi9zdHJidWYuYwpAQCAtMTQ2LDExICsx
NDYsMTIgQEAgdm9pZCBzdHJidWZfYWRkZihzdHJ1Y3Qgc3RyYnVmICpzYiwgCiAJc3RyYnVmX3Nl
dGxlbihzYiwgc2ItPmxlbiArIGxlbik7CiB9CiAKLXZvaWQgc3RyYnVmX2V4cGFuZChzdHJ1Y3Qg
c3RyYnVmICpzYiwgY29uc3QgY2hhciAqZm9ybWF0LAotICAgICAgICAgICAgICAgICAgIGNvbnN0
IGNoYXIgKipwbGFjZWhvbGRlcnMsIGV4cGFuZF9mbl90IGZuLCB2b2lkICpjb250ZXh0KQordm9p
ZCBzdHJidWZfZXhwYW5kKHN0cnVjdCBzdHJidWYgKnNiLCBjb25zdCBjaGFyICpmb3JtYXQsIGV4
cGFuZF9mbl90IGZuLAorICAgICAgICAgICAgICAgICAgIHZvaWQgKmNvbnRleHQpCiB7CiAJZm9y
ICg7OykgewotCQljb25zdCBjaGFyICpwZXJjZW50LCAqKnA7CisJCWNvbnN0IGNoYXIgKnBlcmNl
bnQ7CisJCXNpemVfdCBjb25zdW1lZDsKIAogCQlwZXJjZW50ID0gc3RyY2hybnVsKGZvcm1hdCwg
JyUnKTsKIAkJc3RyYnVmX2FkZChzYiwgZm9ybWF0LCBwZXJjZW50IC0gZm9ybWF0KTsKQEAgLTE1
OCwxNCArMTU5LDEwIEBAIHZvaWQgc3RyYnVmX2V4cGFuZChzdHJ1Y3Qgc3RyYnVmICpzYiwgCiAJ
CQlicmVhazsKIAkJZm9ybWF0ID0gcGVyY2VudCArIDE7CiAKLQkJZm9yIChwID0gcGxhY2Vob2xk
ZXJzOyAqcDsgcCsrKSB7Ci0JCQlpZiAoIXByZWZpeGNtcChmb3JtYXQsICpwKSkKLQkJCQlicmVh
azsKLQkJfQotCQlpZiAoKnApIHsKLQkJCWZuKHNiLCAqcCwgY29udGV4dCk7Ci0JCQlmb3JtYXQg
Kz0gc3RybGVuKCpwKTsKLQkJfSBlbHNlCisJCWNvbnN1bWVkID0gZm4oc2IsIGZvcm1hdCwgY29u
dGV4dCk7CisJCWlmIChjb25zdW1lZCkKKwkJCWZvcm1hdCArPSBjb25zdW1lZDsKKwkJZWxzZQog
CQkJc3RyYnVmX2FkZGNoKHNiLCAnJScpOwogCX0KIH0KZGlmZiAtLWdpdCBhL3N0cmJ1Zi5oIGIv
c3RyYnVmLmgKaW5kZXggMzZkNjFkYi4uZmFlYzIyOSAxMDA2NDQKLS0tIGEvc3RyYnVmLmgKKysr
IGIvc3RyYnVmLmgKQEAgLTEwMyw4ICsxMDMsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc3RyYnVm
X2FkZGJ1ZihzdHJ1Y3Qgc3RyYnVmICpzYiwgCiB9CiBleHRlcm4gdm9pZCBzdHJidWZfYWRkZHVw
KHN0cnVjdCBzdHJidWYgKnNiLCBzaXplX3QgcG9zLCBzaXplX3QgbGVuKTsKIAotdHlwZWRlZiB2
b2lkICgqZXhwYW5kX2ZuX3QpIChzdHJ1Y3Qgc3RyYnVmICpzYiwgY29uc3QgY2hhciAqcGxhY2Vo
b2xkZXIsIHZvaWQgKmNvbnRleHQpOwotZXh0ZXJuIHZvaWQgc3RyYnVmX2V4cGFuZChzdHJ1Y3Qg
c3RyYnVmICpzYiwgY29uc3QgY2hhciAqZm9ybWF0LCBjb25zdCBjaGFyICoqcGxhY2Vob2xkZXJz
LCBleHBhbmRfZm5fdCBmbiwgdm9pZCAqY29udGV4dCk7Cit0eXBlZGVmIHNpemVfdCAoKmV4cGFu
ZF9mbl90KSAoc3RydWN0IHN0cmJ1ZiAqc2IsIGNvbnN0IGNoYXIgKnBsYWNlaG9sZGVyLCB2b2lk
ICpjb250ZXh0KTsKK2V4dGVybiB2b2lkIHN0cmJ1Zl9leHBhbmQoc3RydWN0IHN0cmJ1ZiAqc2Is
IGNvbnN0IGNoYXIgKmZvcm1hdCwgZXhwYW5kX2ZuX3QgZm4sIHZvaWQgKmNvbnRleHQpOwogCiBf
X2F0dHJpYnV0ZV9fKChmb3JtYXQocHJpbnRmLDIsMykpKQogZXh0ZXJuIHZvaWQgc3RyYnVmX2Fk
ZGYoc3RydWN0IHN0cmJ1ZiAqc2IsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKTsK
------=_Part_36803_19798465.1199578201680--
