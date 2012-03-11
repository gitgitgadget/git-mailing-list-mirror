From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/(3/4)] ident.c: add split_ident_line() to parse formatted
 ident line
Date: Sun, 11 Mar 2012 04:09:25 -0700
Message-ID: <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com> <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 12:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6geb-00044N-57
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab2CKLJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:09:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab2CKLJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:09:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CD9F6E4C;
	Sun, 11 Mar 2012 07:09:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O5ELXQoxQgJ4gHQvgwWUyPX3xJo=; b=ah0XFf
	aDrNxSPuYbjvejTL09oiCGr3PTPsDkh1hsbKrBb2rX3pC6jEP1os1c+s3Zlf9GGD
	Y/QTg/FlItyUzz50KHh84XQbf/uN1vgqG4Sd8hNHUXDA8SWRBEf0lFR2xP38ZjqM
	2EV46qHH/GBzOCla9D1SAHVcMChTXffIBAb1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iTXt6TIfeboAHkvHGo2pRk70FCLFJN3T
	piWMAThhtkwfNn1I2GZLY8TW+oYwjlyK3ekwUw6q5KcUIT/QINPZc5wIYNiyeIrX
	TtJGeKtR3YTbE7995HMbAV0BbnjxRDSOSxgYfjX+dQZ7p6xIZAXQbwPTmWNRp1Sk
	Cg4O/UOK/8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63A7E6E4B;
	Sun, 11 Mar 2012 07:09:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F6DF6E4A; Sun, 11 Mar 2012
 07:09:26 -0400 (EDT)
In-Reply-To: <7v62ebz9c0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Mar 2012 04:05:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA5B3A84-6B6A-11E1-89F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192804>

The commit formatting logic format_person_part() in pretty.c
implements the logic to split an author/committer ident line into
its parts, intermixed with logic to compute its output using these
piece it computes.

Separate the former out to a helper function split_ident_line() so
that other codepath can use the same logic, and rewrite the function
using the helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The second shared change between the two approaches.

 cache.h  |   16 +++++++++++++++
 ident.c  |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pretty.c |   64 ++++++++++++++++++----------------------------------------
 3 files changed, 104 insertions(+), 44 deletions(-)

diff --git a/cache.h b/cache.h
index 3a8e125..7c42eca 100644
--- a/cache.h
+++ b/cache.h
@@ -928,6 +928,22 @@ extern const char *fmt_name(const char *name, const char *email);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 
+struct ident_split {
+	const char *name_begin;
+	const char *name_end;
+	const char *mail_begin;
+	const char *mail_end;
+	const char *date_begin;
+	const char *date_end;
+	const char *tz_begin;
+	const char *tz_end;
+};
+/*
+ * Signals an success with 0, but time part of the result may be NULL
+ * if the input lacks timestamp and zone
+ */
+extern int split_ident_line(struct ident_split *, const char *, int);
+
 struct checkout {
 	const char *base_dir;
 	int base_dir_len;
diff --git a/ident.c b/ident.c
index f619619..87c697c 100644
--- a/ident.c
+++ b/ident.c
@@ -220,6 +220,74 @@ static int copy(char *buf, size_t size, int offset, const char *src)
 	return offset;
 }
 
+/*
+ * Reverse of fmt_ident(); given an ident line, split the fields
+ * to allow the caller to parse it.
+ * Signal a success by returning 0, but date/tz fields of the result
+ * can still be NULL if the input line only has the name/email part
+ * (e.g. reading from a reflog entry).
+ */
+int split_ident_line(struct ident_split *split, const char *line, int len)
+{
+	const char *cp;
+	size_t span;
+	int status = -1;
+
+	memset(split, 0, sizeof(*split));
+
+	split->name_begin = line;
+	for (cp = line; *cp && cp < line + len; cp++)
+		if (*cp == '<') {
+			split->mail_begin = cp + 1;
+			break;
+		}
+	if (!split->mail_begin)
+		return status;
+
+	for (cp = split->mail_begin - 2; line < cp; cp--)
+		if (!isspace(*cp)) {
+			split->name_end = cp + 1;
+			break;
+		}
+	if (!split->name_end)
+		return status;
+
+	for (cp = split->mail_begin; cp < line + len; cp++)
+		if (*cp == '>') {
+			split->mail_end = cp;
+			break;
+		}
+	if (!split->mail_end)
+		return status;
+
+	for (cp = split->mail_end + 1; cp < line + len && isspace(*cp); cp++)
+		;
+	if (line + len <= cp)
+		goto person_only;
+	split->date_begin = cp;
+	span = strspn(cp, "0123456789");
+	if (!span)
+		goto person_only;
+	split->date_end = split->date_begin + span;
+	for (cp = split->date_end; cp < line + len && isspace(*cp); cp++)
+		;
+	if (line + len <= cp || (*cp != '+' && *cp != '-'))
+		goto person_only;
+	split->tz_begin = cp;
+	span = strspn(cp + 1, "0123456789");
+	if (!span)
+		goto person_only;
+	split->tz_end = split->tz_begin + 1 + span;
+	return 0;
+
+person_only:
+	split->date_begin = NULL;
+	split->date_end = NULL;
+	split->tz_begin = NULL;
+	split->tz_end = NULL;
+	return 0;
+}
+
 static const char *env_hint =
 "\n"
 "*** Please tell me who you are.\n"
diff --git a/pretty.c b/pretty.c
index 8688b8f..f2dee30 100644
--- a/pretty.c
+++ b/pretty.c
@@ -531,41 +531,24 @@ static size_t format_person_part(struct strbuf *sb, char part,
 {
 	/* currently all placeholders have same length */
 	const int placeholder_len = 2;
-	int start, end, tz = 0;
+	int tz;
 	unsigned long date = 0;
-	char *ep;
-	const char *name_start, *name_end, *mail_start, *mail_end, *msg_end = msg+len;
 	char person_name[1024];
 	char person_mail[1024];
+	struct ident_split s;
+	const char *name_start, *name_end, *mail_start, *mail_end;
 
-	/* advance 'end' to point to email start delimiter */
-	for (end = 0; end < len && msg[end] != '<'; end++)
-		; /* do nothing */
-
-	/*
-	 * When end points at the '<' that we found, it should have
-	 * matching '>' later, which means 'end' must be strictly
-	 * below len - 1.
-	 */
-	if (end >= len - 2)
+	if (split_ident_line(&s, msg, len) < 0)
 		goto skip;
 
-	/* Seek for both name and email part */
-	name_start = msg;
-	name_end = msg+end;
-	while (name_end > name_start && isspace(*(name_end-1)))
-		name_end--;
-	mail_start = msg+end+1;
-	mail_end = mail_start;
-	while (mail_end < msg_end && *mail_end != '>')
-		mail_end++;
-	if (mail_end == msg_end)
-		goto skip;
-	end = mail_end-msg;
+	name_start = s.name_begin;
+	name_end = s.name_end;
+	mail_start = s.mail_begin;
+	mail_end = s.mail_end;
 
 	if (part == 'N' || part == 'E') { /* mailmap lookup */
-		strlcpy(person_name, name_start, name_end-name_start+1);
-		strlcpy(person_mail, mail_start, mail_end-mail_start+1);
+		strlcpy(person_name, name_start, name_end - name_start + 1);
+		strlcpy(person_mail, mail_start, mail_end - mail_start + 1);
 		mailmap_name(person_mail, sizeof(person_mail), person_name, sizeof(person_name));
 		name_start = person_name;
 		name_end = name_start + strlen(person_name);
@@ -581,28 +564,20 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		return placeholder_len;
 	}
 
-	/* advance 'start' to point to date start delimiter */
-	for (start = end + 1; start < len && isspace(msg[start]); start++)
-		; /* do nothing */
-	if (start >= len)
-		goto skip;
-	date = strtoul(msg + start, &ep, 10);
-	if (msg + start == ep)
+	if (!s.date_begin)
 		goto skip;
 
+	date = strtoul(s.date_begin, NULL, 10);
+
 	if (part == 't') {	/* date, UNIX timestamp */
-		strbuf_add(sb, msg + start, ep - (msg + start));
+		strbuf_add(sb, s.date_begin, s.date_end - s.date_begin);
 		return placeholder_len;
 	}
 
 	/* parse tz */
-	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
-		; /* do nothing */
-	if (start + 1 < len) {
-		tz = strtoul(msg + start + 1, NULL, 10);
-		if (msg[start] == '-')
-			tz = -tz;
-	}
+	tz = strtoul(s.tz_begin + 1, NULL, 10);
+	if (*s.tz_begin == '-')
+		tz = -tz;
 
 	switch (part) {
 	case 'd':	/* date */
@@ -621,8 +596,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 
 skip:
 	/*
-	 * bogus commit, 'sb' cannot be updated, but we still need to
-	 * compute a valid return value.
+	 * reading from either a bogus commit, or a reflog entry with
+	 * %gn, %ge, etc.; 'sb' cannot be updated, but we still need
+	 * to compute a valid return value.
 	 */
 	if (part == 'n' || part == 'e' || part == 't' || part == 'd'
 	    || part == 'D' || part == 'r' || part == 'i')
-- 
1.7.10.rc0.33.g8866af
