From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/10] Use split_ident_line to parse author and committer
Date: Mon,  7 Jan 2013 16:10:13 -0800
Message-ID: <1357603821-8647-3-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmR-0006Eh-UM
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab3AHAKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab3AHAK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78C10B7A7;
	Mon,  7 Jan 2013 19:10:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ezki
	XxiIy/JXLnSOsqzSpQTEby8=; b=TXXm2HnnEj7TXJC9I+K5nAc3So4gUQCG0Tof
	piTFpBxHJludIyxoRecNtQqV2DbwhRUM3KXPA5TzPVHesSIIT8Q25NyrWhfG4vpQ
	dGsgYiUWcvjjD5jocZCD6/JUS9J7Opx+UWuXtmpm7p7q4dhDUeBrgK2McgHiOE9B
	+Dq7ms4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	V0CGEcIji8uHfLf0y6/ZIa2x6wIoQCsx6tTdVCbgWVKJqk6fmzeZc92vmb1O7b13
	HgEO0WdYurvMQEIMgaqT+k9kqaZSWk8jxkxXDYod1je2mIMwhUr9M7A0PT40XpTp
	+kCji7voUnDYOH/ddFfdZMZUY+ZW7SCqK4jZumJ52HI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B6FCB7A5;
	Mon,  7 Jan 2013 19:10:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73C90B7A3; Mon,  7 Jan 2013
 19:10:27 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CE554F78-5927-11E2-BAAC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212923>

From: Antoine Pelisse <apelisse@gmail.com>

Currently blame.c::get_acline(), pretty.c::pp_user_info() and
shortlog.c::insert_one_record() are parsing author name, email, time
and tz themselves.

Use ident.c::split_ident_line() for better code reuse.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c    | 59 +++++++++++++++++++-----------------------------------
 builtin/shortlog.c | 36 +++++++++------------------------
 pretty.c           | 35 +++++++++++++++++++-------------
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
1.8.1.304.gf036638
