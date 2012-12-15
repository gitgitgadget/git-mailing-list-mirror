From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 3/7] mailmap: Simplify map_user() interface
Date: Sat, 15 Dec 2012 19:05:50 +0100
Message-ID: <1355594754-27589-4-git-send-email-apelisse@gmail.com>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw8F-0001Hn-8t
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab2LOSGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:12 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:43803 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab2LOSGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:06 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so2050183wey.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CSp8JNWxXqfujPxB/UaXGp5fPs9T+zHC0fyC0BLgWTY=;
        b=018v3iUOivobZSRTPU0m7GDMrTz9b9VG7xLTm1N1o+kIyV4zLm8/LMNtreJ1JdXZ1g
         39AgPNxuTE1OZnszNQME7GGfJYTfv/IVuqdVx8q/v1cMHONfdlI4pgOGaMKRUozDuvr3
         H923mHgW+4p22H552KfiE32NI1Gpn4Q+lrLGzk4gniUEnB301GLRGNLdYm2/5sZlVfz1
         kfNl6GWuhHVa2pq+/VlfV3eua0JChEQx24eh8IughOqOSjwnhBJTQ4DWD1rL0sQuDDw/
         WyUOlU4qqgVpAbnxUaxmSpEw9cWmD5+C4u/irUUFnxP9xBds4raIyuMwiQjfunoSloaG
         GSfA==
Received: by 10.194.177.199 with SMTP id cs7mr9328331wjc.41.1355594765254;
        Sat, 15 Dec 2012 10:06:05 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:04 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211546>

mailmap.c::map_user() is simplified to take two strbuf parameters
instead of statically allocated buffers.

The buffers are still modified in-place, when mapping is required.

It actually makes things easier for callers:
 - Caller must prepare the call by copying author name and email in
 strbuf (instead of copying in static buffer)
 - Caller can easily manipulate the buffer afterward.
 - Caller doesn't have to call strlen() to calculate the size of the
 new string.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/blame.c    |  164 +++++++++++++++++++++++++++-------------------------
 builtin/shortlog.c |   31 ++++------
 mailmap.c          |   51 ++++++++--------
 mailmap.h          |    4 +-
 pretty.c           |   40 ++++++-------
 5 files changed, 139 insertions(+), 151 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index dd4aff9..8586850 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1321,31 +1321,30 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
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
+			struct strbuf *name, struct strbuf *mail,
+			unsigned long *time, struct strbuf *tz)
 {
 	struct ident_split ident;
-	int len, tzlen, maillen, namelen;
-	char *tmp, *endp, *mailpos;
+	int len;
+	char *tmp, *endp;
 
 	tmp = strstr(inbuf, what);
 	if (!tmp)
@@ -1356,51 +1355,61 @@ static void get_ac_line(const char *inbuf, const char *what,
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
 
-	namelen = ident.name_end - ident.name_begin;
-	memcpy(person, ident.name_begin, namelen);
-	person[namelen] = 0;
+	len = ident.name_end - ident.name_begin;
+	strbuf_add(name, ident.name_begin, len);
 
-	maillen = ident.mail_end - ident.mail_begin + 2;
-	memcpy(mail, ident.mail_begin - 1, maillen);
-	mail[maillen] = 0;
+	len = ident.mail_end - ident.mail_begin;
+	strbuf_add(mail, ident.mail_begin, len);
 
 	*time = strtoul(ident.date_begin, NULL, 10);
 
-	tzlen = ident.tz_end - ident.tz_begin;
+	len = ident.tz_end - ident.tz_begin;
+	strbuf_add(tz, ident.tz_begin, len);
 
-	/* Place tz at the end of person */
-	*tz = tmp = person + person_len - (tzlen + 1);
-	memcpy(tmp, ident.tz_begin, tzlen);
-	tmp[tzlen] = 0;
-
-	if (!mailmap.nr)
-		return;
-
-	/*
+        /*
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
+	if (mailmap.nr)
+		map_user(&mailmap, mail, name);
+
+	strbuf_insert(mail, 0, "<", 1);
+	strbuf_addch(mail, '>');
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
@@ -1410,11 +1419,8 @@ static void get_commit_info(struct commit *commit,
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
@@ -1432,11 +1438,7 @@ static void get_commit_info(struct commit *commit,
 	encoding = get_log_output_encoding();
 	reencoded = logmsg_reencode(commit, encoding);
 	message   = reencoded ? reencoded : commit->buffer;
-	ret->author = author_name;
-	ret->author_mail = author_mail;
-	get_ac_line(message, "\nauthor ",
-		    sizeof(author_name), author_name,
-		    sizeof(author_mail), author_mail,
+	get_ac_line(message, "\nauthor ", &ret->author, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
 
 	if (!detailed) {
@@ -1444,21 +1446,16 @@ static void get_commit_info(struct commit *commit,
 		return;
 	}
 
-	ret->committer = committer_name;
-	ret->committer_mail = committer_mail;
-	get_ac_line(message, "\ncommitter ",
-		    sizeof(committer_name), committer_name,
-		    sizeof(committer_mail), committer_mail,
-		    &ret->committer_time, &ret->committer_tz);
+	get_ac_line(message, "\ncommitter ", &ret->committer,
+		    &ret->committer_mail, &ret->committer_time,
+		    &ret->committer_tz);
 
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
 
@@ -1487,15 +1484,15 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 
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
@@ -1503,6 +1500,9 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 		printf("previous %s ", sha1_to_hex(prev->commit->object.sha1));
 		write_name_quoted(prev->path, stdout, '\n');
 	}
+
+	commit_info_destroy(&ci);
+
 	return 1;
 }
 
@@ -1689,11 +1689,11 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
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
@@ -1712,14 +1712,14 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
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
@@ -1734,6 +1734,8 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 
 	if (sb->final_buf_size && cp[-1] != '\n')
 		putchar('\n');
+
+	commit_info_destroy(&ci);
 }
 
 static void output(struct scoreboard *sb, int option)
@@ -1858,9 +1860,9 @@ static void find_alignment(struct scoreboard *sb, int *option)
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
@@ -1872,6 +1874,8 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			longest_dst_lines = num;
 		if (largest_score < ent_score(sb, e))
 			largest_score = ent_score(sb, e);
+
+		commit_info_destroy(&ci);
 	}
 	max_orig_digits = decimal_width(longest_src_lines);
 	max_digits = decimal_width(longest_dst_lines);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 03c6cd7..20e8599 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -36,39 +36,30 @@ static void insert_one_record(struct shortlog *log,
 	const char *dot3 = log->common_repo_prefix;
 	char *buffer, *p;
 	struct string_list_item *item;
-	char namebuf[1024];
-	char emailbuf[1024];
-	size_t len;
 	const char *eol;
 	struct strbuf subject = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf mail = STRBUF_INIT;
 	struct ident_split ident;
 
 	if (split_ident_line(&ident, author, strlen(author)))
 		return;
 
-	/* copy author name to namebuf, to support matching on both name and email */
-	len = ident.name_end - ident.name_begin;
-	memcpy(namebuf, ident.name_begin, len);
-	namebuf[len] = 0;
+	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
 
-	/* copy email name to emailbuf, to allow email replacement as well */
-	len = ident.mail_end - ident.mail_begin;
-	memcpy(emailbuf, ident.mail_begin, len);
-	emailbuf[len] = 0;
+	map_user(&log->mailmap, &mail, &name);
 
-	map_user(&log->mailmap, emailbuf, sizeof(emailbuf), namebuf, sizeof(namebuf));
-	len = strlen(namebuf);
+	if (log->email)
+		strbuf_addf(&name, " <%s>", mail.buf);
 
-	if (log->email) {
-		size_t room = sizeof(namebuf) - len - 1;
-		int maillen = strlen(emailbuf);
-		snprintf(namebuf + len, room, " <%.*s>", maillen, emailbuf);
-	}
-
-	item = string_list_insert(&log->list, namebuf);
+	item = string_list_insert(&log->list, name.buf);
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct string_list));
 
+	strbuf_release(&name);
+	strbuf_release(&mail);
+
 	/* Skip any leading whitespace, including any blank lines. */
 	while (*oneline && isspace(*oneline))
 		oneline++;
diff --git a/mailmap.c b/mailmap.c
index 3bc6491..d5bffc6 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -187,57 +187,52 @@ void clear_mailmap(struct string_list *map)
 	debug_mm("mailmap: cleared\n");
 }
 
-int map_user(struct string_list *map,
-	     char *email, int maxlen_email, char *name, int maxlen_name)
+int map_user(struct string_list *map, struct strbuf *mail, struct strbuf *name)
 {
-	char *end_of_email;
+
 	struct string_list_item *item;
 	struct mailmap_entry *me;
-	struct strbuf mailbuf = STRBUF_INIT;
+	struct strbuf lowermail = STRBUF_INIT;
 	int i;
 
-	/* figure out space requirement for email */
-	end_of_email = strchr(email, '>');
-	if (!end_of_email) {
-		/* email passed in might not be wrapped in <>, but end with a \0 */
-		end_of_email = memchr(email, '\0', maxlen_email);
-		if (!end_of_email)
-			return 0;
-	}
-
 	/* downcase the email address */
-	strbuf_grow(&mailbuf, end_of_email - email);
-	for (i = 0; i < end_of_email - email; i++)
-		strbuf_addch(&mailbuf, tolower(email[i]));
+	strbuf_grow(&lowermail, mail->len);
+	for (i = 0; i < mail->len; i++)
+		strbuf_addch(&lowermail, tolower(mail->buf[i]));
 
-	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf.buf);
-	item = string_list_lookup(map, mailbuf.buf);
+	debug_mm("map_user: map '%s' <%s>\n", name->buf, lowermail.buf);
+	item = string_list_lookup(map, lowermail.buf);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
 			/* The item has multiple items, so we'll look up on name too */
 			/* If the name is not found, we choose the simple entry      */
-			struct string_list_item *subitem = string_list_lookup(&me->namemap, name);
+			struct string_list_item *subitem = string_list_lookup(&me->namemap, name->buf);
 			if (subitem)
 				item = subitem;
 		}
 	}
-	strbuf_release(&mailbuf);
+	strbuf_release(&lowermail);
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
+			strbuf_reset(mail);
+			strbuf_addstr(mail, mi->email);
+		}
+
+		if (mi->name) {
+			strbuf_reset(name);
+			strbuf_addstr(name, mi->name);
+		}
+
+		debug_mm("map_user:  to '%s' <%s>\n", name->buf, mi->email ? mi->email : "");
 		return 1;
 	}
+
 	debug_mm("map_user:  --\n");
 	return 0;
 }
diff --git a/mailmap.h b/mailmap.h
index d5c3664..88dca51 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -4,7 +4,5 @@
 int read_mailmap(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
 
-int map_user(struct string_list *mailmap,
-	     char *email, int maxlen_email, char *name, int maxlen_name);
-
+int map_user(struct string_list *map, struct strbuf *name, struct strbuf *mail);
 #endif
diff --git a/pretty.c b/pretty.c
index 350d1df..d05c675 100644
--- a/pretty.c
+++ b/pretty.c
@@ -593,14 +593,14 @@ char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static int mailmap_name(char *email, int email_len, char *name, int name_len)
+static int mailmap_name(struct strbuf *mail, struct strbuf *name)
 {
 	static struct string_list *mail_map;
 	if (!mail_map) {
 		mail_map = xcalloc(1, sizeof(*mail_map));
 		read_mailmap(mail_map, NULL);
 	}
-	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
+	return mail_map->nr && map_user(mail_map, mail, name);
 }
 
 static size_t format_person_part(struct strbuf *sb, char part,
@@ -610,39 +610,39 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	const int placeholder_len = 2;
 	int tz;
 	unsigned long date = 0;
-	char person_name[1024];
-	char person_mail[1024];
+	struct strbuf person_name = STRBUF_INIT;
+	struct strbuf person_mail = STRBUF_INIT;
 	struct ident_split s;
-	const char *name_start, *name_end, *mail_start, *mail_end;
 
 	if (split_ident_line(&s, msg, len) < 0)
 		goto skip;
 
-	name_start = s.name_begin;
-	name_end = s.name_end;
-	mail_start = s.mail_begin;
-	mail_end = s.mail_end;
+	strbuf_add(&person_name, s.name_begin, (int)(s.name_end - s.name_begin));
+	strbuf_add(&person_mail, s.mail_begin, (int)(s.mail_end - s.mail_begin));
 
 	if (part == 'N' || part == 'E') { /* mailmap lookup */
-		snprintf(person_name, sizeof(person_name), "%.*s",
-			 (int)(name_end - name_start), name_start);
-		snprintf(person_mail, sizeof(person_mail), "%.*s",
-			 (int)(mail_end - mail_start), mail_start);
-		mailmap_name(person_mail, sizeof(person_mail), person_name, sizeof(person_name));
-		name_start = person_name;
-		name_end = name_start + strlen(person_name);
-		mail_start = person_mail;
-		mail_end = mail_start +  strlen(person_mail);
+		mailmap_name(&person_mail, &person_name);
 	}
 	if (part == 'n' || part == 'N') {	/* name */
-		strbuf_add(sb, name_start, name_end-name_start);
+		strbuf_addbuf(sb, &person_name);
+
+		strbuf_release(&person_name);
+		strbuf_release(&person_mail);
+
 		return placeholder_len;
 	}
 	if (part == 'e' || part == 'E') {	/* email */
-		strbuf_add(sb, mail_start, mail_end-mail_start);
+		strbuf_addbuf(sb, &person_mail);
+
+		strbuf_release(&person_name);
+		strbuf_release(&person_mail);
+
 		return placeholder_len;
 	}
 
+	strbuf_release(&person_name);
+	strbuf_release(&person_mail);
+
 	if (!s.date_begin)
 		goto skip;
 
-- 
1.7.9.5
