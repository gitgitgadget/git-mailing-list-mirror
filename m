From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 1/7] Use split_ident_line to parse author and committer
Date: Sat, 15 Dec 2012 19:05:48 +0100
Message-ID: <1355594754-27589-2-git-send-email-apelisse@gmail.com>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw81-00011g-0V
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab2LOSGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:06 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63999 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab2LOSGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:04 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1888840wgb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yKi+oPwsTgavfNX6JH0A9Fq+3bVC6YlqF2pwXCW4TZY=;
        b=kpE7cgaLFT3XhEdAX999J0V5EBckYEb9wv7RlWdWSjSTrPwGpTG8Rw7nKx4HWjIrk0
         tYKki96j052whOg6zEvGxhJ6B+TBMJGcT+OSwDIbwy0PSNXekl47dhm+n+Tzz7pgKMO9
         MVtoauQHH+YEfTzMVnGyOOAcGO6QmKCP2wcq3FzpZcjmV0Ao83j8HSdjr8+eqRkahX5Q
         jxdzz1Tc+cVFDMhVCRnpL19sILZ0l0B2/G+7kDWRC+beF+ZgMlvmBucGi4fYatc78z35
         JIRH6Cnjt8m4BTx1XzzhDEbnW88WEcn3GX+hxsJG+t/SzRYQ0L35lL99my1gmwC3wN5Q
         1cYw==
Received: by 10.194.20.4 with SMTP id j4mr4956329wje.54.1355594763365;
        Sat, 15 Dec 2012 10:06:03 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:02 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211543>

Currently blame.c::get_acline, pretty.c::pp_user_info() and
shortlog.c::insert_one_record are parsing author name, email, time and
tz themselves.

Use ident.c::split_ident_line for better code reuse.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/blame.c    |   59 +++++++++++++++++++---------------------------------
 builtin/shortlog.c |   36 +++++++++-----------------------
 pretty.c           |   35 ++++++++++++++++++-------------
 3 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cfae569..dd4aff9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1343,8 +1343,9 @@ static void get_ac_line(const char *inbuf, const char *what,
 			int mail_len, char *mail,
 			unsigned long *time, const char **tz)
 {
-	int len, tzlen, maillen;
-	char *tmp, *endp, *timepos, *mailpos;
+	struct ident_split ident;
+	int len, tzlen, maillen, namelen;
+	char *tmp, *endp, *mailpos;
 
 	tmp = strstr(inbuf, what);
 	if (!tmp)
@@ -1355,7 +1356,10 @@ static void get_ac_line(const char *inbuf, const char *what,
 		len = strlen(tmp);
 	else
 		len = endp - tmp;
-	if (person_len <= len) {
+	if (person_len <= len)
+		goto error_out;
+
+	if (split_ident_line(&ident, tmp, len)) {
 	error_out:
 		/* Ugh */
 		*tz = "(unknown)";
@@ -1364,47 +1368,26 @@ static void get_ac_line(const char *inbuf, const char *what,
 		*time = 0;
 		return;
 	}
-	memcpy(person, tmp, len);
 
-	tmp = person;
-	tmp += len;
-	*tmp = 0;
-	while (person < tmp && *tmp != ' ')
-		tmp--;
-	if (tmp <= person)
-		goto error_out;
-	*tz = tmp+1;
-	tzlen = (person+len)-(tmp+1);
+	namelen = ident.name_end - ident.name_begin;
+	memcpy(person, ident.name_begin, namelen);
+	person[namelen] = 0;
 
-	*tmp = 0;
-	while (person < tmp && *tmp != ' ')
-		tmp--;
-	if (tmp <= person)
-		goto error_out;
-	*time = strtoul(tmp, NULL, 10);
-	timepos = tmp;
+	maillen = ident.mail_end - ident.mail_begin + 2;
+	memcpy(mail, ident.mail_begin - 1, maillen);
+	mail[maillen] = 0;
 
-	*tmp = 0;
-	while (person < tmp && !(*tmp == ' ' && tmp[1] == '<'))
-		tmp--;
-	if (tmp <= person)
-		return;
-	mailpos = tmp + 1;
-	*tmp = 0;
-	maillen = timepos - tmp;
-	memcpy(mail, mailpos, maillen);
+	*time = strtoul(ident.date_begin, NULL, 10);
 
-	if (!mailmap.nr)
-		return;
+	tzlen = ident.tz_end - ident.tz_begin;
 
-	/*
-	 * mailmap expansion may make the name longer.
-	 * make room by pushing stuff down.
-	 */
-	tmp = person + person_len - (tzlen + 1);
-	memmove(tmp, *tz, tzlen);
+	/* Place tz at the end of person */
+	*tz = tmp = person + person_len - (tzlen + 1);
+	memcpy(tmp, ident.tz_begin, tzlen);
 	tmp[tzlen] = 0;
-	*tz = tmp;
+
+	if (!mailmap.nr)
+		return;
 
 	/*
 	 * Now, convert both name and e-mail using mailmap
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index b316cf3..03c6cd7 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -40,40 +40,24 @@ static void insert_one_record(struct shortlog *log,
 	char emailbuf[1024];
 	size_t len;
 	const char *eol;
-	const char *boemail, *eoemail;
 	struct strbuf subject = STRBUF_INIT;
+	struct ident_split ident;
 
-	boemail = strchr(author, '<');
-	if (!boemail)
-		return;
-	eoemail = strchr(boemail, '>');
-	if (!eoemail)
+	if (split_ident_line(&ident, author, strlen(author)))
 		return;
 
 	/* copy author name to namebuf, to support matching on both name and email */
-	memcpy(namebuf, author, boemail - author);
-	len = boemail - author;
-	while (len > 0 && isspace(namebuf[len-1]))
-		len--;
+	len = ident.name_end - ident.name_begin;
+	memcpy(namebuf, ident.name_begin, len);
 	namebuf[len] = 0;
 
 	/* copy email name to emailbuf, to allow email replacement as well */
-	memcpy(emailbuf, boemail+1, eoemail - boemail);
-	emailbuf[eoemail - boemail - 1] = 0;
-
-	if (!map_user(&log->mailmap, emailbuf, sizeof(emailbuf), namebuf, sizeof(namebuf))) {
-		while (author < boemail && isspace(*author))
-			author++;
-		for (len = 0;
-		     len < sizeof(namebuf) - 1 && author + len < boemail;
-		     len++)
-			namebuf[len] = author[len];
-		while (0 < len && isspace(namebuf[len-1]))
-			len--;
-		namebuf[len] = '\0';
-	}
-	else
-		len = strlen(namebuf);
+	len = ident.mail_end - ident.mail_begin;
+	memcpy(emailbuf, ident.mail_begin, len);
+	emailbuf[len] = 0;
+
+	map_user(&log->mailmap, emailbuf, sizeof(emailbuf), namebuf, sizeof(namebuf));
+	len = strlen(namebuf);
 
 	if (log->email) {
 		size_t room = sizeof(namebuf) - len - 1;
diff --git a/pretty.c b/pretty.c
index 5bdc2e7..350d1df 100644
--- a/pretty.c
+++ b/pretty.c
@@ -387,29 +387,36 @@ void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
+	struct ident_split ident;
+	int linelen, namelen;
+	char *line_end, *date;
 	int max_length = 78; /* per rfc2822 */
-	char *date;
-	int namelen;
 	unsigned long time;
 	int tz;
 
 	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
-	date = strchr(line, '>');
-	if (!date)
+
+	line_end = strchr(line, '\n');
+	if (!line_end) {
+		line_end = strchr(line, '\0');
+		if (!line_end)
+			return;
+	}
+
+	linelen = ++line_end - line;
+	if (split_ident_line(&ident, line, linelen))
 		return;
-	namelen = ++date - line;
-	time = strtoul(date, &date, 10);
+
+	namelen = ident.mail_end - ident.name_begin + 1;
+	time = strtoul(ident.date_begin, &date, 10);
 	tz = strtol(date, NULL, 10);
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
-		char *name_tail = strchr(line, '<');
 		int display_name_length;
-		if (!name_tail)
-			return;
-		while (line < name_tail && isspace(name_tail[-1]))
-			name_tail--;
-		display_name_length = name_tail - line;
+
+		display_name_length = ident.name_end - ident.name_begin;
+
 		strbuf_addstr(sb, "From: ");
 		if (needs_rfc2047_encoding(line, display_name_length, RFC2047_ADDRESS)) {
 			add_rfc2047(sb, line, display_name_length,
@@ -427,10 +434,10 @@ void pp_user_info(const struct pretty_print_context *pp,
 		}
 		if (namelen - display_name_length + last_line_length(sb) > max_length) {
 			strbuf_addch(sb, '\n');
-			if (!isspace(name_tail[0]))
+			if (!isspace(ident.name_end[0]))
 				strbuf_addch(sb, ' ');
 		}
-		strbuf_add(sb, name_tail, namelen - display_name_length);
+		strbuf_add(sb, ident.name_end, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
 	} else {
 		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
-- 
1.7.9.5
