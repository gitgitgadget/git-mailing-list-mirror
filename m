From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sun, 25 Aug 2013 12:51:53 -0400
Message-ID: <20130825165153.GC21092@sigill.intra.peff.net>
References: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
 <1377424889-15399-1-git-send-email-apelisse@gmail.com>
 <20130825103041.GB12556@sigill.intra.peff.net>
 <CALWbr2zfpZYGri9aGL3DGhadnYF=0xx_h95ZjN7S4beoAES68A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 18:52:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDdYK-0002zS-0r
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 18:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab3HYQv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 12:51:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:57264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479Ab3HYQv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 12:51:56 -0400
Received: (qmail 14388 invoked by uid 102); 25 Aug 2013 16:51:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 25 Aug 2013 11:51:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 12:51:53 -0400
Content-Disposition: inline
In-Reply-To: <CALWbr2zfpZYGri9aGL3DGhadnYF=0xx_h95ZjN7S4beoAES68A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232961>

On Sun, Aug 25, 2013 at 03:37:24PM +0200, Antoine Pelisse wrote:

> So we would stop passing mailmap string_list along down to map_user(),
> and the mailmap file (or blob) would be read the first time it's
> needed, and stored in a static global variable in mailmap.c. I think
> I'm OK with that because I don't think it would make sense to have
> multiple instances of a mailmap string_list in the same git-command
> instance.

Exactly. Sample (largely untested) patch is below if you want to use it
as a starting point. There are probably a few additional cleanups on top
(e.g., "git log" understands "--mailmap", which should probably be
centralized to handle_revision_opt).

I'm on the fence. It doesn't actually save that many lines of code, and
I guess it's possible that somebody would want a custom mailmap in the
future. Even though you can't do it right now, all it would take is
exposing read_mailmap_file and read_mailmap_blob outside of mailmap.c.
Of course, it would be easy to expose map_user_from at the same time.

> Who would be responsible for deleting the string_list ? It would
> either be done in each command, or done through a atexit(3) registered
> function (but then, why would we even care about cleaning it up?).

Exactly. You would clean it up at exit, but the OS does it for you
already.

-Peff

---
 builtin/blame.c         |  7 +------
 builtin/check-mailmap.c | 12 ++++--------
 builtin/log.c           |  5 +----
 builtin/shortlog.c      |  7 ++-----
 commit.h                |  2 +-
 log-tree.c              |  2 +-
 mailmap.c               | 31 ++++++++++++++++++++++++++++---
 mailmap.h               |  7 +++----
 pretty.c                | 17 +++--------------
 revision.c              | 10 +++++-----
 revision.h              |  2 +-
 shortlog.h              |  2 --
 12 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 079dcd3..680adaf 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -48,8 +48,6 @@ static size_t blame_date_width;
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
 
-static struct string_list mailmap;
-
 #ifndef DEBUG
 #define DEBUG 0
 #endif
@@ -1394,8 +1392,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	/*
 	 * Now, convert both name and e-mail using mailmap
 	 */
-	map_user(&mailmap, &mailbuf, &maillen,
-		 &namebuf, &namelen);
+	map_user(&mailbuf, &maillen, &namebuf, &namelen);
 
 	strbuf_addf(mail, "<%.*s>", (int)maillen, mailbuf);
 	strbuf_add(name, namebuf, namelen);
@@ -2512,8 +2509,6 @@ parse_done:
 	sb.ent = ent;
 	sb.path = path;
 
-	read_mailmap(&mailmap, NULL);
-
 	if (!incremental)
 		setup_pager();
 
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 8f4d809..b3a13f4 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -14,7 +14,7 @@ static const struct option check_mailmap_options[] = {
 	OPT_END()
 };
 
-static void check_mailmap(struct string_list *mailmap, const char *contact)
+static void check_mailmap(const char *contact)
 {
 	const char *name, *mail;
 	size_t namelen, maillen;
@@ -28,7 +28,7 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 	mail = ident.mail_begin;
 	maillen = ident.mail_end - ident.mail_begin;
 
-	map_user(mailmap, &mail, &maillen, &name, &namelen);
+	map_user(&mail, &maillen, &name, &namelen);
 
 	if (namelen)
 		printf("%.*s ", (int)namelen, name);
@@ -38,7 +38,6 @@ int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct string_list mailmap = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, check_mailmap_options,
@@ -46,21 +45,18 @@ int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 	if (argc == 0 && !use_stdin)
 		die(_("no contacts specified"));
 
-	read_mailmap(&mailmap, NULL);
-
 	for (i = 0; i < argc; ++i)
-		check_mailmap(&mailmap, argv[i]);
+		check_mailmap(argv[i]);
 	maybe_flush_or_die(stdout, "stdout");
 
 	if (use_stdin) {
 		struct strbuf buf = STRBUF_INIT;
 		while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-			check_mailmap(&mailmap, buf.buf);
+			check_mailmap(buf.buf);
 			maybe_flush_or_die(stdout, "stdout");
 		}
 		strbuf_release(&buf);
 	}
 
-	clear_mailmap(&mailmap);
 	return 0;
 }
diff --git a/builtin/log.c b/builtin/log.c
index 2625f98..88ebd85 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -168,10 +168,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;
 
-	if (mailmap) {
-		rev->mailmap = xcalloc(1, sizeof(struct string_list));
-		read_mailmap(rev->mailmap, NULL);
-	}
+	rev->use_mailmap = mailmap;
 
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
 		/*
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1434f8f..22010b3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -31,7 +31,7 @@ static void insert_one_record(struct shortlog *log,
 			      const char *author,
 			      const char *oneline)
 {
-	const char *dot3 = log->common_repo_prefix;
+	const char *dot3 = mailmap_repo_abbrev();
 	char *buffer, *p;
 	struct string_list_item *item;
 	const char *mailbuf, *namebuf;
@@ -49,7 +49,7 @@ static void insert_one_record(struct shortlog *log,
 	namelen = ident.name_end - ident.name_begin;
 	maillen = ident.mail_end - ident.mail_begin;
 
-	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+	map_user(&mailbuf, &maillen, &namebuf, &namelen);
 	strbuf_add(&namemailbuf, namebuf, namelen);
 
 	if (log->email)
@@ -209,8 +209,6 @@ void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
 
-	read_mailmap(&log->mailmap, &log->common_repo_prefix);
-
 	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
@@ -323,5 +321,4 @@ void shortlog_output(struct shortlog *log)
 	strbuf_release(&sb);
 	log->list.strdup_strings = 1;
 	string_list_clear(&log->list, 1);
-	clear_mailmap(&log->mailmap);
 }
diff --git a/commit.h b/commit.h
index d912a9d..d391a53 100644
--- a/commit.h
+++ b/commit.h
@@ -94,7 +94,7 @@ struct pretty_print_context {
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
-	struct string_list *mailmap;
+	int use_mailmap;
 	int color;
 	struct ident_split *from_ident;
 
diff --git a/log-tree.c b/log-tree.c
index a49d8e8..ed77e61 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -615,7 +615,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
-	ctx.mailmap = opt->mailmap;
+	ctx.use_mailmap = opt->use_mailmap;
 	ctx.color = opt->diffopt.use_color;
 	ctx.output_encoding = get_log_output_encoding();
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
diff --git a/mailmap.c b/mailmap.c
index 44614fc..05540fa 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -13,6 +13,9 @@ const char *git_mailmap_blob;
 
 const char *git_mailmap_file;
 const char *git_mailmap_blob;
+static struct string_list the_mailmap;
+static char *repo_abbrev;
+static int initialized;
 
 struct mailmap_info {
 	char *name;
@@ -28,6 +31,15 @@ struct mailmap_entry {
 	struct string_list namemap;
 };
 
+static void init_mailmap(void)
+{
+	if (initialized)
+		return;
+
+	read_mailmap(&the_mailmap, &repo_abbrev);
+	initialized = 1;
+}
+
 static void free_mailmap_info(void *p, const char *s)
 {
 	struct mailmap_info *mi = (struct mailmap_info *)p;
@@ -311,9 +323,9 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 	return NULL;
 }
 
-int map_user(struct string_list *map,
-	     const char **email, size_t *emaillen,
-	     const char **name, size_t *namelen)
+static int map_user_from(struct string_list *map,
+			 const char **email, size_t *emaillen,
+			 const char **name, size_t *namelen)
 {
 	struct string_list_item *item;
 	struct mailmap_entry *me;
@@ -359,3 +371,16 @@ int map_user(struct string_list *map,
 	debug_mm("map_user:  --\n");
 	return 0;
 }
+
+int map_user(const char **email, size_t *emaillen,
+	     const char **name, size_t *namelen)
+{
+	init_mailmap();
+	return map_user_from(&the_mailmap, email, emaillen, name, namelen);
+}
+
+const char *mailmap_repo_abbrev(void)
+{
+	init_mailmap();
+	return repo_abbrev;
+}
diff --git a/mailmap.h b/mailmap.h
index ed7c93b..de52e63 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,10 +1,9 @@ void clear_mailmap(struct string_list *map);
 #ifndef MAILMAP_H
 #define MAILMAP_H
 
-int read_mailmap(struct string_list *map, char **repo_abbrev);
-void clear_mailmap(struct string_list *map);
+int map_user(const char **email, size_t *emaillen,
+	     const char **name, size_t *namelen);
 
-int map_user(struct string_list *map,
-			 const char **email, size_t *emaillen, const char **name, size_t *namelen);
+const char *mailmap_repo_abbrev(void);
 
 #endif
diff --git a/pretty.c b/pretty.c
index 74563c9..94a9628 100644
--- a/pretty.c
+++ b/pretty.c
@@ -428,8 +428,8 @@ void pp_user_info(struct pretty_print_context *pp,
 	namebuf = ident.name_begin;
 	namelen = ident.name_end - ident.name_begin;
 
-	if (pp->mailmap)
-		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+	if (pp->use_mailmap)
+		map_user(&mailbuf, &maillen, &namebuf, &namelen);
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
 		if (pp->from_ident) {
@@ -688,17 +688,6 @@ void logmsg_free(char *msg, const struct commit *commit)
 		free(msg);
 }
 
-static int mailmap_name(const char **email, size_t *email_len,
-			const char **name, size_t *name_len)
-{
-	static struct string_list *mail_map;
-	if (!mail_map) {
-		mail_map = xcalloc(1, sizeof(*mail_map));
-		read_mailmap(mail_map, NULL);
-	}
-	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
-}
-
 static size_t format_person_part(struct strbuf *sb, char part,
 				 const char *msg, int len, enum date_mode dmode)
 {
@@ -717,7 +706,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	maillen = s.mail_end - s.mail_begin;
 
 	if (part == 'N' || part == 'E') /* mailmap lookup */
-		mailmap_name(&mail, &maillen, &name, &namelen);
+		map_user(&mail, &maillen, &name, &namelen);
 	if (part == 'n' || part == 'N') {	/* name */
 		strbuf_add(sb, name, namelen);
 		return placeholder_len;
diff --git a/revision.c b/revision.c
index 84ccc05..5f96316 100644
--- a/revision.c
+++ b/revision.c
@@ -2661,7 +2661,7 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+static int commit_rewrite_person(struct strbuf *buf, const char *what)
 {
 	char *person, *endp;
 	size_t len, namelen, maillen;
@@ -2688,7 +2688,7 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 	name = ident.name_begin;
 	namelen = ident.name_end - ident.name_begin;
 
-	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
+	if (map_user(&mail, &maillen, &name, &namelen)) {
 		struct strbuf namemail = STRBUF_INIT;
 
 		strbuf_addf(&namemail, "%.*s <%.*s>",
@@ -2737,12 +2737,12 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (buf.len)
 		strbuf_addstr(&buf, message);
 
-	if (opt->grep_filter.header_list && opt->mailmap) {
+	if (opt->grep_filter.header_list && opt->use_mailmap) {
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
 
-		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
-		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
+		commit_rewrite_person(&buf, "\nauthor ");
+		commit_rewrite_person(&buf, "\ncommitter ");
 	}
 
 	/* Append "fake" message parts as needed */
diff --git a/revision.h b/revision.h
index 95859ba..a79817e 100644
--- a/revision.h
+++ b/revision.h
@@ -152,7 +152,7 @@ struct rev_info {
 	const char	*subject_prefix;
 	int		no_inline;
 	int		show_log_size;
-	struct string_list *mailmap;
+	int use_mailmap;
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
diff --git a/shortlog.h b/shortlog.h
index de4f86f..e6c3055 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -14,9 +14,7 @@ struct shortlog {
 	int user_format;
 	int abbrev;
 
-	char *common_repo_prefix;
 	int email;
-	struct string_list mailmap;
 };
 
 void shortlog_init(struct shortlog *log);
