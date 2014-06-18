From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] ident_split: store begin/end pairs on their own struct
Date: Wed, 18 Jun 2014 16:31:33 -0400
Message-ID: <20140618203133.GD23896@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:31:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMWH-0001Mg-4A
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbaFRUbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:31:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:47009 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754874AbaFRUbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:31:35 -0400
Received: (qmail 777 invoked by uid 102); 18 Jun 2014 20:31:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:31:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:31:33 -0400
Content-Disposition: inline
In-Reply-To: <20140618201944.GA23238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252060>

When we parse an ident line, we end up with several fields,
each with a begin/end pointer into the buffer, like:

  const char *name_begin;
  const char *name_end;

There is nothing except the field names to indicate that
they are paired. This makes it annoying to write helper
functions for dealing with the sub-fields, as you have to
pass both sides. Instead, let's move them into a single
struct "name", with fields "begin" and "end". This will be
stored identically, but can be passed as a unit.

We have to do a mechanical update of "s/_/./" at each point
of use, but other than that, the fields should behave
identically.

Signed-off-by: Jeff King <peff@peff.net>
---
Suggestions welcome on the name "pointer_pair".

While writing this series, I also noticed that it would be more
convenient to have a pointer/len combination rather than two pointers.
You can convert between them, of course, but I found I was always
converting the other way.

I left it this way because it makes the mass-update mechanical (and
because now that I can pass the pair as a unit, I don't have to write
the same "ident->name_begin, ident->name_end - ident->name_begin" pair
over and over).

 builtin/blame.c         | 16 +++++++-------
 builtin/check-mailmap.c |  8 +++----
 builtin/commit.c        | 26 +++++++++++-----------
 builtin/shortlog.c      |  8 +++----
 cache.h                 | 17 ++++++++-------
 commit.c                |  6 +++---
 ident.c                 | 57 +++++++++++++++++++++++--------------------------
 log-tree.c              |  2 +-
 pretty.c                | 36 +++++++++++++++----------------
 revision.c              | 12 +++++------
 10 files changed, 93 insertions(+), 95 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 53f43ab..6e6dddb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1599,19 +1599,19 @@ static void get_ac_line(const char *inbuf, const char *what,
 		return;
 	}
 
-	namelen = ident.name_end - ident.name_begin;
-	namebuf = ident.name_begin;
+	namelen = ident.name.end - ident.name.begin;
+	namebuf = ident.name.begin;
 
-	maillen = ident.mail_end - ident.mail_begin;
-	mailbuf = ident.mail_begin;
+	maillen = ident.mail.end - ident.mail.begin;
+	mailbuf = ident.mail.begin;
 
-	if (ident.date_begin && ident.date_end)
-		*time = strtoul(ident.date_begin, NULL, 10);
+	if (ident.date.begin && ident.date.end)
+		*time = strtoul(ident.date.begin, NULL, 10);
 	else
 		*time = 0;
 
-	if (ident.tz_begin && ident.tz_end)
-		strbuf_add(tz, ident.tz_begin, ident.tz_end - ident.tz_begin);
+	if (ident.tz.begin && ident.tz.end)
+		strbuf_add(tz, ident.tz.begin, ident.tz.end - ident.tz.begin);
 	else
 		strbuf_addstr(tz, "(unknown)");
 
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 8f4d809..65dcbc6 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -23,10 +23,10 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 	if (split_ident_line(&ident, contact, strlen(contact)))
 		die(_("unable to parse contact: %s"), contact);
 
-	name = ident.name_begin;
-	namelen = ident.name_end - ident.name_begin;
-	mail = ident.mail_begin;
-	maillen = ident.mail_end - ident.mail_begin;
+	name = ident.name.begin;
+	namelen = ident.name.end - ident.name.begin;
+	mail = ident.mail.begin;
+	maillen = ident.mail.end - ident.mail.begin;
 
 	map_user(mailmap, &mail, &maillen, &name, &namelen);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 84cec9a..047cc76 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -514,14 +514,14 @@ static void export_one(const char *var, const char *s, const char *e, int hack)
 
 static int sane_ident_split(struct ident_split *person)
 {
-	if (!person->name_begin || !person->name_end ||
-	    person->name_begin == person->name_end)
+	if (!person->name.begin || !person->name.end ||
+	    person->name.begin == person->name.end)
 		return 0; /* no human readable name */
-	if (!person->mail_begin || !person->mail_end ||
-	    person->mail_begin == person->mail_end)
+	if (!person->mail.begin || !person->mail.end ||
+	    person->mail.begin == person->mail.end)
 		return 0; /* no usable mail */
-	if (!person->date_begin || !person->date_end ||
-	    !person->tz_begin || !person->tz_end)
+	if (!person->date.begin || !person->date.end ||
+	    !person->tz.begin || !person->tz.end)
 		return 0;
 	return 1;
 }
@@ -602,9 +602,9 @@ static void determine_author_info(struct strbuf *author_ident)
 	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
 	if (!split_ident_line(&author, author_ident->buf, author_ident->len) &&
 	    sane_ident_split(&author)) {
-		export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
-		export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
-		export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
+		export_one("GIT_AUTHOR_NAME", author.name.begin, author.name.end, 0);
+		export_one("GIT_AUTHOR_EMAIL", author.mail.begin, author.mail.end, 0);
+		export_one("GIT_AUTHOR_DATE", author.date.begin, author.tz.end, '@');
 	}
 }
 
@@ -861,8 +861,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				_("%s"
 				"Author:    %.*s <%.*s>"),
 				ident_shown++ ? "" : "\n",
-				(int)(ai.name_end - ai.name_begin), ai.name_begin,
-				(int)(ai.mail_end - ai.mail_begin), ai.mail_begin);
+				(int)(ai.name.end - ai.name.begin), ai.name.begin,
+				(int)(ai.mail.end - ai.mail.begin), ai.mail.begin);
 
 		if (author_date_is_interesting())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -876,8 +876,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				_("%s"
 				"Committer: %.*s <%.*s>"),
 				ident_shown++ ? "" : "\n",
-				(int)(ci.name_end - ci.name_begin), ci.name_begin,
-				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
+				(int)(ci.name.end - ci.name.begin), ci.name.begin,
+				(int)(ci.mail.end - ci.mail.begin), ci.mail.begin);
 
 		if (ident_shown)
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 4b7e536..e4ddfea 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -44,10 +44,10 @@ static void insert_one_record(struct shortlog *log,
 	if (split_ident_line(&ident, author, strlen(author)))
 		return;
 
-	namebuf = ident.name_begin;
-	mailbuf = ident.mail_begin;
-	namelen = ident.name_end - ident.name_begin;
-	maillen = ident.mail_end - ident.mail_begin;
+	namebuf = ident.name.begin;
+	mailbuf = ident.mail.begin;
+	namelen = ident.name.end - ident.name.begin;
+	maillen = ident.mail.end - ident.mail.begin;
 
 	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 	strbuf_add(&namemailbuf, namebuf, namelen);
diff --git a/cache.h b/cache.h
index cbe1935..5255661 100644
--- a/cache.h
+++ b/cache.h
@@ -1045,15 +1045,16 @@ extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int git_ident_config(const char *, const char *, void *);
 
+struct pointer_pair {
+	const char *begin;
+	const char *end;
+};
+
 struct ident_split {
-	const char *name_begin;
-	const char *name_end;
-	const char *mail_begin;
-	const char *mail_end;
-	const char *date_begin;
-	const char *date_end;
-	const char *tz_begin;
-	const char *tz_end;
+	struct pointer_pair name;
+	struct pointer_pair mail;
+	struct pointer_pair date;
+	struct pointer_pair tz;
 };
 /*
  * Signals an success with 0, but time part of the result may be NULL
diff --git a/commit.c b/commit.c
index c33431c..dcf8dce 100644
--- a/commit.c
+++ b/commit.c
@@ -617,11 +617,11 @@ static void record_author_date(struct author_date_slab *author_date,
 	if (!ident_line)
 		goto fail_exit; /* no author line */
 	if (split_ident_line(&ident, ident_line, ident_len) ||
-	    !ident.date_begin || !ident.date_end)
+	    !ident.date.begin || !ident.date.end)
 		goto fail_exit; /* malformed "author" line */
 
-	date = strtoul(ident.date_begin, &date_end, 10);
-	if (date_end != ident.date_end)
+	date = strtoul(ident.date.begin, &date_end, 10);
+	if (date_end != ident.date.end)
 		goto fail_exit; /* malformed date */
 	*(author_date_slab_at(author_date, commit)) = date;
 
diff --git a/ident.c b/ident.c
index 1d9b6e7..570fda7 100644
--- a/ident.c
+++ b/ident.c
@@ -206,42 +206,42 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 
 	memset(split, 0, sizeof(*split));
 
-	split->name_begin = line;
+	split->name.begin = line;
 	for (cp = line; *cp && cp < line + len; cp++)
 		if (*cp == '<') {
-			split->mail_begin = cp + 1;
+			split->mail.begin = cp + 1;
 			break;
 		}
-	if (!split->mail_begin)
+	if (!split->mail.begin)
 		return status;
 
-	for (cp = split->mail_begin - 2; line <= cp; cp--)
+	for (cp = split->mail.begin - 2; line <= cp; cp--)
 		if (!isspace(*cp)) {
-			split->name_end = cp + 1;
+			split->name.end = cp + 1;
 			break;
 		}
-	if (!split->name_end) {
+	if (!split->name.end) {
 		/* no human readable name */
-		split->name_end = split->name_begin;
+		split->name.end = split->name.begin;
 	}
 
-	for (cp = split->mail_begin; cp < line + len; cp++)
+	for (cp = split->mail.begin; cp < line + len; cp++)
 		if (*cp == '>') {
-			split->mail_end = cp;
+			split->mail.end = cp;
 			break;
 		}
-	if (!split->mail_end)
+	if (!split->mail.end)
 		return status;
 
 	/*
 	 * Look from the end-of-line to find the trailing ">" of the mail
-	 * address, even though we should already know it as split->mail_end.
+	 * address, even though we should already know it as split->mail.end.
 	 * This can help in cases of broken idents with an extra ">" somewhere
 	 * in the email address.  Note that we are assuming the timestamp will
 	 * never have a ">" in it.
 	 *
 	 * Note that we will always find some ">" before going off the front of
-	 * the string, because will always hit the split->mail_end closing
+	 * the string, because will always hit the split->mail.end closing
 	 * bracket.
 	 */
 	for (cp = line + len - 1; *cp != '>'; cp--)
@@ -251,27 +251,27 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 		;
 	if (line + len <= cp)
 		goto person_only;
-	split->date_begin = cp;
+	split->date.begin = cp;
 	span = strspn(cp, "0123456789");
 	if (!span)
 		goto person_only;
-	split->date_end = split->date_begin + span;
-	for (cp = split->date_end; cp < line + len && isspace(*cp); cp++)
+	split->date.end = split->date.begin + span;
+	for (cp = split->date.end; cp < line + len && isspace(*cp); cp++)
 		;
 	if (line + len <= cp || (*cp != '+' && *cp != '-'))
 		goto person_only;
-	split->tz_begin = cp;
+	split->tz.begin = cp;
 	span = strspn(cp + 1, "0123456789");
 	if (!span)
 		goto person_only;
-	split->tz_end = split->tz_begin + 1 + span;
+	split->tz.end = split->tz.begin + 1 + span;
 	return 0;
 
 person_only:
-	split->date_begin = NULL;
-	split->date_end = NULL;
-	split->tz_begin = NULL;
-	split->tz_end = NULL;
+	split->date.begin = NULL;
+	split->date.end = NULL;
+	split->tz.begin = NULL;
+	split->tz.end = NULL;
 	return 0;
 }
 
@@ -417,15 +417,14 @@ int git_ident_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static int buf_cmp(const char *a_begin, const char *a_end,
-		   const char *b_begin, const char *b_end)
+static int buf_cmp(const struct pointer_pair *a, const struct pointer_pair *b)
 {
-	int a_len = a_end - a_begin;
-	int b_len = b_end - b_begin;
+	int a_len = a->end - a->begin;
+	int b_len = b->end - b->begin;
 	int min = a_len < b_len ? a_len : b_len;
 	int cmp;
 
-	cmp = memcmp(a_begin, b_begin, min);
+	cmp = memcmp(a->begin, b->begin, min);
 	if (cmp)
 		return cmp;
 
@@ -437,11 +436,9 @@ int ident_cmp(const struct ident_split *a,
 {
 	int cmp;
 
-	cmp = buf_cmp(a->mail_begin, a->mail_end,
-		      b->mail_begin, b->mail_end);
+	cmp = buf_cmp(&a->mail, &b->mail);
 	if (cmp)
 		return cmp;
 
-	return buf_cmp(a->name_begin, a->name_end,
-		       b->name_begin, b->name_end);
+	return buf_cmp(&a->name, &b->name);
 }
diff --git a/log-tree.c b/log-tree.c
index 4447021..385f07f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -620,7 +620,7 @@ void show_log(struct rev_info *opt)
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
 	ctx.output_encoding = get_log_output_encoding();
-	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
+	if (opt->from_ident.mail.begin && opt->from_ident.name.begin)
 		ctx.from_ident = &opt->from_ident;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
diff --git a/pretty.c b/pretty.c
index 6081750..83ef5b7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -399,13 +399,13 @@ const char *show_ident_date(const struct ident_split *ident,
 	unsigned long date = 0;
 	long tz = 0;
 
-	if (ident->date_begin && ident->date_end)
-		date = strtoul(ident->date_begin, NULL, 10);
+	if (ident->date.begin && ident->date.end)
+		date = strtoul(ident->date.begin, NULL, 10);
 	if (date_overflows(date))
 		date = 0;
 	else {
-		if (ident->tz_begin && ident->tz_end)
-			tz = strtol(ident->tz_begin, NULL, 10);
+		if (ident->tz.begin && ident->tz.end)
+			tz = strtol(ident->tz.begin, NULL, 10);
 		if (tz >= INT_MAX || tz <= INT_MIN)
 			tz = 0;
 	}
@@ -429,10 +429,10 @@ void pp_user_info(struct pretty_print_context *pp,
 	if (split_ident_line(&ident, line, line_end - line))
 		return;
 
-	mailbuf = ident.mail_begin;
-	maillen = ident.mail_end - ident.mail_begin;
-	namebuf = ident.name_begin;
-	namelen = ident.name_end - ident.name_begin;
+	mailbuf = ident.mail.begin;
+	maillen = ident.mail.end - ident.mail.begin;
+	namebuf = ident.name.begin;
+	namelen = ident.name.end - ident.name.begin;
 
 	if (pp->mailmap)
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
@@ -449,10 +449,10 @@ void pp_user_info(struct pretty_print_context *pp,
 			string_list_append(&pp->in_body_headers,
 					   strbuf_detach(&buf, NULL));
 
-			mailbuf = pp->from_ident->mail_begin;
-			maillen = pp->from_ident->mail_end - mailbuf;
-			namebuf = pp->from_ident->name_begin;
-			namelen = pp->from_ident->name_end - namebuf;
+			mailbuf = pp->from_ident->mail.begin;
+			maillen = pp->from_ident->mail.end - mailbuf;
+			namebuf = pp->from_ident->name.begin;
+			namelen = pp->from_ident->name.end - namebuf;
 		}
 
 		strbuf_addstr(sb, "From: ");
@@ -677,10 +677,10 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	if (split_ident_line(&s, msg, len) < 0)
 		goto skip;
 
-	name = s.name_begin;
-	namelen = s.name_end - s.name_begin;
-	mail = s.mail_begin;
-	maillen = s.mail_end - s.mail_begin;
+	name = s.name.begin;
+	namelen = s.name.end - s.name.begin;
+	mail = s.mail.begin;
+	maillen = s.mail.end - s.mail.begin;
 
 	if (part == 'N' || part == 'E') /* mailmap lookup */
 		mailmap_name(&mail, &maillen, &name, &namelen);
@@ -693,11 +693,11 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		return placeholder_len;
 	}
 
-	if (!s.date_begin)
+	if (!s.date.begin)
 		goto skip;
 
 	if (part == 't') {	/* date, UNIX timestamp */
-		strbuf_add(sb, s.date_begin, s.date_end - s.date_begin);
+		strbuf_add(sb, s.date.begin, s.date.end - s.date.begin);
 		return placeholder_len;
 	}
 
diff --git a/revision.c b/revision.c
index 9d628c6..c5fbaf8 100644
--- a/revision.c
+++ b/revision.c
@@ -2762,10 +2762,10 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 	if (split_ident_line(&ident, person, len))
 		return 0;
 
-	mail = ident.mail_begin;
-	maillen = ident.mail_end - ident.mail_begin;
-	name = ident.name_begin;
-	namelen = ident.name_end - ident.name_begin;
+	mail = ident.mail.begin;
+	maillen = ident.mail.end - ident.mail.begin;
+	name = ident.name.begin;
+	namelen = ident.name.end - ident.name.begin;
 
 	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
 		struct strbuf namemail = STRBUF_INIT;
@@ -2773,8 +2773,8 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 		strbuf_addf(&namemail, "%.*s <%.*s>",
 			    (int)namelen, name, (int)maillen, mail);
 
-		strbuf_splice(buf, ident.name_begin - buf->buf,
-			      ident.mail_end - ident.name_begin + 1,
+		strbuf_splice(buf, ident.name.begin - buf->buf,
+			      ident.mail.end - ident.name.begin + 1,
 			      namemail.buf, namemail.len);
 
 		strbuf_release(&namemail);
-- 
2.0.0.566.gfe3e6b2
