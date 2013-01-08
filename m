From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/10] mailmap: simplify map_user() interface
Date: Mon,  7 Jan 2013 16:10:15 -0800
Message-ID: <1357603821-8647-5-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMme-0006ZE-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab3AHAKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756151Ab3AHAKh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 779F3B7AF;
	Mon,  7 Jan 2013 19:10:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=s7Wg
	Jq0JD0Z4ZeEcQhYmh+RUFsk=; b=vsK5kfplZB5zHZNBe5BESXruqHRJwUrJHhCF
	/trYvGeCcYMO/C9/oP2oMQn72MB4l+L+bCcaOOyI159UHwlkgUv+c5lIYzzzvg6+
	R2/MWZWg6Oq173UluObJx1CM8+XMzwRrLaYwdwGiR5nZLK/Gjx//OSd6L7rLCjsw
	Iyaeb10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	VLtuMcW/mcufJZ1+GciYJ4j8a6/IEzBXkBN67KFKhKMzyw9ObgWvYT5EGGMp1gnA
	Q8YI/iSaiJ16I3U4cu8RYdF5u+O9rtOb9rltSpqWwTg3OoLev+NUXqigwkDmB7MP
	016uY51HXviTTONyo9jv7RIqo3RLtMvhiByj+QQbkhQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AAA9B7AE;
	Mon,  7 Jan 2013 19:10:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39A6DB7AD; Mon,  7 Jan 2013
 19:10:32 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D12BA864-5927-11E2-AC43-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212926>

From: Antoine Pelisse <apelisse@gmail.com>

Simplify map_user(), mostly to avoid copies of string buffers. It
also simplifies caller functions.

map_user() directly receive pointers and length from the commit buffer
as mail and name. If mapping of the user and mail can be done, the
pointer is updated to a new location. Lengths are also updated if
necessary.

The caller of map_user() can then copy the new email and name if
necessary.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c    | 156 +++++++++++++++++++++++++++--------------------------
 builtin/shortlog.c |  32 +++++------
 mailmap.c          |  43 +++++++--------
 mailmap.h          |   4 +-
 pretty.c           |  35 +++++-------
 5 files changed, 126 insertions(+), 144 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index dd4aff9..86450e3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1321,31 +1321,31 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
  * Information on commits, used for output.
  */
 struct commit_info {
-	const char *author;
-	const char *author_mail;
+	struct strbuf author;
+	struct strbuf author_mail;
 	unsigned long author_time;
-	const char *author_tz;
+	struct strbuf author_tz;
 
 	/* filled only when asked for details */
-	const char *committer;
-	const char *committer_mail;
+	struct strbuf committer;
+	struct strbuf committer_mail;
 	unsigned long committer_time;
-	const char *committer_tz;
+	struct strbuf committer_tz;
 
-	const char *summary;
+	struct strbuf summary;
 };
 
 /*
  * Parse author/committer line in the commit object buffer
  */
 static void get_ac_line(const char *inbuf, const char *what,
-			int person_len, char *person,
-			int mail_len, char *mail,
-			unsigned long *time, const char **tz)
+	struct strbuf *name, struct strbuf *mail,
+	unsigned long *time, struct strbuf *tz)
 {
 	struct ident_split ident;
-	int len, tzlen, maillen, namelen;
-	char *tmp, *endp, *mailpos;
+	size_t len, maillen, namelen;
+	char *tmp, *endp;
+	const char *namebuf, *mailbuf;
 
 	tmp = strstr(inbuf, what);
 	if (!tmp)
@@ -1356,51 +1356,61 @@ static void get_ac_line(const char *inbuf, const char *what,
 		len = strlen(tmp);
 	else
 		len = endp - tmp;
-	if (person_len <= len)
-		goto error_out;
 
 	if (split_ident_line(&ident, tmp, len)) {
 	error_out:
 		/* Ugh */
-		*tz = "(unknown)";
-		strcpy(person, *tz);
-		strcpy(mail, *tz);
+		tmp = "(unknown)";
+		strbuf_addstr(name, tmp);
+		strbuf_addstr(mail, tmp);
+		strbuf_addstr(tz, tmp);
 		*time = 0;
 		return;
 	}
 
 	namelen = ident.name_end - ident.name_begin;
-	memcpy(person, ident.name_begin, namelen);
-	person[namelen] = 0;
+	namebuf = ident.name_begin;
 
-	maillen = ident.mail_end - ident.mail_begin + 2;
-	memcpy(mail, ident.mail_begin - 1, maillen);
-	mail[maillen] = 0;
+	maillen = ident.mail_end - ident.mail_begin;
+	mailbuf = ident.mail_begin;
 
 	*time = strtoul(ident.date_begin, NULL, 10);
 
-	tzlen = ident.tz_end - ident.tz_begin;
-
-	/* Place tz at the end of person */
-	*tz = tmp = person + person_len - (tzlen + 1);
-	memcpy(tmp, ident.tz_begin, tzlen);
-	tmp[tzlen] = 0;
-
-	if (!mailmap.nr)
-		return;
+	len = ident.tz_end - ident.tz_begin;
+	strbuf_add(tz, ident.tz_begin, len);
 
 	/*
 	 * Now, convert both name and e-mail using mailmap
 	 */
-	if (map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
-		/* Add a trailing '>' to email, since map_user returns plain emails
-		   Note: It already has '<', since we replace from mail+1 */
-		mailpos = memchr(mail, '\0', mail_len);
-		if (mailpos && mailpos-mail < mail_len - 1) {
-			*mailpos = '>';
-			*(mailpos+1) = '\0';
-		}
-	}
+	map_user(&mailmap, &mailbuf, &maillen,
+		 &namebuf, &namelen);
+
+	strbuf_addf(mail, "<%.*s>", (int)maillen, mailbuf);
+	strbuf_add(name, namebuf, namelen);
+}
+
+static void commit_info_init(struct commit_info *ci)
+{
+
+	strbuf_init(&ci->author, 0);
+	strbuf_init(&ci->author_mail, 0);
+	strbuf_init(&ci->author_tz, 0);
+	strbuf_init(&ci->committer, 0);
+	strbuf_init(&ci->committer_mail, 0);
+	strbuf_init(&ci->committer_tz, 0);
+	strbuf_init(&ci->summary, 0);
+}
+
+static void commit_info_destroy(struct commit_info *ci)
+{
+
+	strbuf_release(&ci->author);
+	strbuf_release(&ci->author_mail);
+	strbuf_release(&ci->author_tz);
+	strbuf_release(&ci->committer);
+	strbuf_release(&ci->committer_mail);
+	strbuf_release(&ci->committer_tz);
+	strbuf_release(&ci->summary);
 }
 
 static void get_commit_info(struct commit *commit,
@@ -1410,11 +1420,8 @@ static void get_commit_info(struct commit *commit,
 	int len;
 	const char *subject, *encoding;
 	char *reencoded, *message;
-	static char author_name[1024];
-	static char author_mail[1024];
-	static char committer_name[1024];
-	static char committer_mail[1024];
-	static char summary_buf[1024];
+
+	commit_info_init(ret);
 
 	/*
 	 * We've operated without save_commit_buffer, so
@@ -1432,11 +1439,8 @@ static void get_commit_info(struct commit *commit,
 	encoding = get_log_output_encoding();
 	reencoded = logmsg_reencode(commit, encoding);
 	message   = reencoded ? reencoded : commit->buffer;
-	ret->author = author_name;
-	ret->author_mail = author_mail;
 	get_ac_line(message, "\nauthor ",
-		    sizeof(author_name), author_name,
-		    sizeof(author_mail), author_mail,
+		    &ret->author, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
 
 	if (!detailed) {
@@ -1444,21 +1448,16 @@ static void get_commit_info(struct commit *commit,
 		return;
 	}
 
-	ret->committer = committer_name;
-	ret->committer_mail = committer_mail;
 	get_ac_line(message, "\ncommitter ",
-		    sizeof(committer_name), committer_name,
-		    sizeof(committer_mail), committer_mail,
+		    &ret->committer, &ret->committer_mail,
 		    &ret->committer_time, &ret->committer_tz);
 
-	ret->summary = summary_buf;
 	len = find_commit_subject(message, &subject);
-	if (len && len < sizeof(summary_buf)) {
-		memcpy(summary_buf, subject, len);
-		summary_buf[len] = 0;
-	} else {
-		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
-	}
+	if (len)
+		strbuf_add(&ret->summary, subject, len);
+	else
+		strbuf_addf(&ret->summary, "(%s)", sha1_to_hex(commit->object.sha1));
+
 	free(reencoded);
 }
 
@@ -1487,15 +1486,15 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 
 	suspect->commit->object.flags |= METAINFO_SHOWN;
 	get_commit_info(suspect->commit, &ci, 1);
-	printf("author %s\n", ci.author);
-	printf("author-mail %s\n", ci.author_mail);
+	printf("author %s\n", ci.author.buf);
+	printf("author-mail %s\n", ci.author_mail.buf);
 	printf("author-time %lu\n", ci.author_time);
-	printf("author-tz %s\n", ci.author_tz);
-	printf("committer %s\n", ci.committer);
-	printf("committer-mail %s\n", ci.committer_mail);
+	printf("author-tz %s\n", ci.author_tz.buf);
+	printf("committer %s\n", ci.committer.buf);
+	printf("committer-mail %s\n", ci.committer_mail.buf);
 	printf("committer-time %lu\n", ci.committer_time);
-	printf("committer-tz %s\n", ci.committer_tz);
-	printf("summary %s\n", ci.summary);
+	printf("committer-tz %s\n", ci.committer_tz.buf);
+	printf("summary %s\n", ci.summary.buf);
 	if (suspect->commit->object.flags & UNINTERESTING)
 		printf("boundary\n");
 	if (suspect->previous) {
@@ -1503,6 +1502,9 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 		printf("previous %s ", sha1_to_hex(prev->commit->object.sha1));
 		write_name_quoted(prev->path, stdout, '\n');
 	}
+
+	commit_info_destroy(&ci);
+
 	return 1;
 }
 
@@ -1689,11 +1691,11 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
-				name = ci.author_mail;
+				name = ci.author_mail.buf;
 			else
-				name = ci.author;
+				name = ci.author.buf;
 			printf("\t(%10s\t%10s\t%d)", name,
-			       format_time(ci.author_time, ci.author_tz,
+			       format_time(ci.author_time, ci.author_tz.buf,
 					   show_raw_time),
 			       ent->lno + 1 + cnt);
 		} else {
@@ -1712,14 +1714,14 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 				const char *name;
 				int pad;
 				if (opt & OUTPUT_SHOW_EMAIL)
-					name = ci.author_mail;
+					name = ci.author_mail.buf;
 				else
-					name = ci.author;
+					name = ci.author.buf;
 				pad = longest_author - utf8_strwidth(name);
 				printf(" (%s%*s %10s",
 				       name, pad, "",
 				       format_time(ci.author_time,
-						   ci.author_tz,
+						   ci.author_tz.buf,
 						   show_raw_time));
 			}
 			printf(" %*d) ",
@@ -1734,6 +1736,8 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 
 	if (sb->final_buf_size && cp[-1] != '\n')
 		putchar('\n');
+
+	commit_info_destroy(&ci);
 }
 
 static void output(struct scoreboard *sb, int option)
@@ -1858,9 +1862,9 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
 			if (*option & OUTPUT_SHOW_EMAIL)
-				num = utf8_strwidth(ci.author_mail);
+				num = utf8_strwidth(ci.author_mail.buf);
 			else
-				num = utf8_strwidth(ci.author);
+				num = utf8_strwidth(ci.author.buf);
 			if (longest_author < num)
 				longest_author = num;
 		}
@@ -1872,6 +1876,8 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			longest_dst_lines = num;
 		if (largest_score < ent_score(sb, e))
 			largest_score = ent_score(sb, e);
+
+		commit_info_destroy(&ci);
 	}
 	max_orig_digits = decimal_width(longest_src_lines);
 	max_digits = decimal_width(longest_dst_lines);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 03c6cd7..1eeed0f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -36,36 +36,28 @@ static void insert_one_record(struct shortlog *log,
 	const char *dot3 = log->common_repo_prefix;
 	char *buffer, *p;
 	struct string_list_item *item;
-	char namebuf[1024];
-	char emailbuf[1024];
-	size_t len;
+	const char *mailbuf, *namebuf;
+	size_t namelen, maillen;
 	const char *eol;
 	struct strbuf subject = STRBUF_INIT;
+	struct strbuf namemailbuf = STRBUF_INIT;
 	struct ident_split ident;
 
 	if (split_ident_line(&ident, author, strlen(author)))
 		return;
 
-	/* copy author name to namebuf, to support matching on both name and email */
-	len = ident.name_end - ident.name_begin;
-	memcpy(namebuf, ident.name_begin, len);
-	namebuf[len] = 0;
+	namebuf = ident.name_begin;
+	mailbuf = ident.mail_begin;
+	namelen = ident.name_end - ident.name_begin;
+	maillen = ident.mail_end - ident.mail_begin;
 
-	/* copy email name to emailbuf, to allow email replacement as well */
-	len = ident.mail_end - ident.mail_begin;
-	memcpy(emailbuf, ident.mail_begin, len);
-	emailbuf[len] = 0;
+	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+	strbuf_add(&namemailbuf, namebuf, namelen);
 
-	map_user(&log->mailmap, emailbuf, sizeof(emailbuf), namebuf, sizeof(namebuf));
-	len = strlen(namebuf);
+	if (log->email)
+		strbuf_addf(&namemailbuf, " <%.*s>", (int)maillen, mailbuf);
 
-	if (log->email) {
-		size_t room = sizeof(namebuf) - len - 1;
-		int maillen = strlen(emailbuf);
-		snprintf(namebuf + len, room, " <%.*s>", maillen, emailbuf);
-	}
-
-	item = string_list_insert(&log->list, namebuf);
+	item = string_list_insert(&log->list, namemailbuf.buf);
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct string_list));
 
diff --git a/mailmap.c b/mailmap.c
index 1a0b769..5ba5c37 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -226,50 +226,43 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 }
 
 int map_user(struct string_list *map,
-	     char *email, int maxlen_email, char *name, int maxlen_name)
+			 const char **email, size_t *emaillen,
+			 const char **name, size_t *namelen)
 {
-	char *end_of_email;
 	struct string_list_item *item;
 	struct mailmap_entry *me;
-	size_t maillen;
-
-	/* figure out space requirement for email */
-	end_of_email = strchr(email, '>');
-	if (!end_of_email) {
-		/* email passed in might not be wrapped in <>, but end with a \0 */
-		end_of_email = memchr(email, '\0', maxlen_email);
-		if (!end_of_email)
-			return 0;
-	}
-
-	maillen = end_of_email - email;
 
-	debug_mm("map_user: map '%s' <%.*s>\n", name, maillen, email);
+	debug_mm("map_user: map '%.*s' <%.*s>\n",
+		 *name, *namelen, *emaillen, *email);
 
-	item = lookup_prefix(map, email, maillen);
+	item = lookup_prefix(map, *email, *emaillen);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
 			/* The item has multiple items, so we'll look up on name too */
 			/* If the name is not found, we choose the simple entry      */
-			struct string_list_item *subitem = string_list_lookup(&me->namemap, name);
+			struct string_list_item *subitem;
+			subitem = lookup_prefix(&me->namemap, *name, *namelen);
 			if (subitem)
 				item = subitem;
 		}
 	}
 	if (item != NULL) {
 		struct mailmap_info *mi = (struct mailmap_info *)item->util;
-		if (mi->name == NULL && (mi->email == NULL || maxlen_email == 0)) {
+		if (mi->name == NULL && mi->email == NULL) {
 			debug_mm("map_user:  -- (no simple mapping)\n");
 			return 0;
 		}
-		if (maxlen_email && mi->email)
-			strlcpy(email, mi->email, maxlen_email);
-		else
-			*end_of_email = '\0';
-		if (maxlen_name && mi->name)
-			strlcpy(name, mi->name, maxlen_name);
-		debug_mm("map_user:  to '%s' <%s>\n", name, mi->email ? mi->email : "");
+		if (mi->email) {
+				*email = mi->email;
+				*emaillen = strlen(*email);
+		}
+		if (mi->name) {
+				*name = mi->name;
+				*namelen = strlen(*name);
+		}
+		debug_mm("map_user:  to '%.*s' <.*%s>\n", *namelen, *name,
+				 *emaillen, *email);
 		return 1;
 	}
 	debug_mm("map_user:  --\n");
diff --git a/mailmap.h b/mailmap.h
index d5c3664..ed7c93b 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -4,7 +4,7 @@
 int read_mailmap(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
 
-int map_user(struct string_list *mailmap,
-	     char *email, int maxlen_email, char *name, int maxlen_name);
+int map_user(struct string_list *map,
+			 const char **email, size_t *emaillen, const char **name, size_t *namelen);
 
 #endif
diff --git a/pretty.c b/pretty.c
index 350d1df..dffcade 100644
--- a/pretty.c
+++ b/pretty.c
@@ -593,7 +593,8 @@ char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static int mailmap_name(char *email, int email_len, char *name, int name_len)
+static int mailmap_name(const char **email, size_t *email_len,
+			const char **name, size_t *name_len)
 {
 	static struct string_list *mail_map;
 	if (!mail_map) {
@@ -610,36 +611,26 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	const int placeholder_len = 2;
 	int tz;
 	unsigned long date = 0;
-	char person_name[1024];
-	char person_mail[1024];
 	struct ident_split s;
-	const char *name_start, *name_end, *mail_start, *mail_end;
+	const char *name, *mail;
+	size_t maillen, namelen;
 
 	if (split_ident_line(&s, msg, len) < 0)
 		goto skip;
 
-	name_start = s.name_begin;
-	name_end = s.name_end;
-	mail_start = s.mail_begin;
-	mail_end = s.mail_end;
-
-	if (part == 'N' || part == 'E') { /* mailmap lookup */
-		snprintf(person_name, sizeof(person_name), "%.*s",
-			 (int)(name_end - name_start), name_start);
-		snprintf(person_mail, sizeof(person_mail), "%.*s",
-			 (int)(mail_end - mail_start), mail_start);
-		mailmap_name(person_mail, sizeof(person_mail), person_name, sizeof(person_name));
-		name_start = person_name;
-		name_end = name_start + strlen(person_name);
-		mail_start = person_mail;
-		mail_end = mail_start +  strlen(person_mail);
-	}
+	name = s.name_begin;
+	namelen = s.name_end - s.name_begin;
+	mail = s.mail_begin;
+	maillen = s.mail_end - s.mail_begin;
+
+	if (part == 'N' || part == 'E') /* mailmap lookup */
+		mailmap_name(&mail, &maillen, &name, &namelen);
 	if (part == 'n' || part == 'N') {	/* name */
-		strbuf_add(sb, name_start, name_end-name_start);
+		strbuf_add(sb, name, namelen);
 		return placeholder_len;
 	}
 	if (part == 'e' || part == 'E') {	/* email */
-		strbuf_add(sb, mail_start, mail_end-mail_start);
+		strbuf_add(sb, mail, maillen);
 		return placeholder_len;
 	}
 
-- 
1.8.1.304.gf036638
