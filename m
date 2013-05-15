From: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC 2/2] quote.c: remove path_relative, use relative_path instead
Date: Wed, 15 May 2013 23:18:39 +0800
Message-ID: <8c7a22b9ef2515e22975f819b24841cac4fba8f5.1368630636.git.worldhello.net@gmail.com>
References: <cover.1368630636.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 15 17:19:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcdU7-0006cb-6Q
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759288Ab3EOPTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:19:13 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:38814 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758243Ab3EOPTM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:19:12 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so1464636pbc.35
        for <git@vger.kernel.org>; Wed, 15 May 2013 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=H0tL7bM5cJvlonao59JYvYmda/hr5wPTOEgTtbE3RNM=;
        b=SfcucE/xL0AEzrWNp7stzlP3AtOGQoI+cByqxdKbGmM+9m8ooXGVcf6evkPXWxCsyF
         uWKNf9vuPbOxS6Zb8M9S6ZYU6NRSiP8xbVxFUBaGPbdKetduY56U15EgsP68U6GxKK3E
         gIx0smOh6XKTncEDrlCq+LmZNVXEdfgjQ1kZpY3mE3mgVKObVeNYldKDMbSqzJ39XLHs
         wcBrujsnvSdJ96oxFjYL5DH4sg9FH5gcdbhugOwTuoSl57qwXrTdtdIkwscfH2GlU5B5
         CC3+lZHMxjreuCshNXHCjL46bejnSHlD6MCW9bywkwskyVrzwY6e2GaBm943GWiAhuRY
         STFg==
X-Received: by 10.68.131.195 with SMTP id oo3mr15296266pbb.143.1368631151818;
        Wed, 15 May 2013 08:19:11 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id iy2sm3161860pbb.31.2013.05.15.08.19.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 08:19:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.404.ga32c147
In-Reply-To: <cover.1368630636.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368630636.git.worldhello.net@gmail.com>
References: <7vvc6ldtx7.fsf@alter.siamese.dyndns.org> <cover.1368630636.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224416>

Since there is a enhanced version of relative_path() in path.c,
remove duplicate counterpart path_relative() in quote.c.

Also refactor related functions, remove unnecessary arguments:
len and/or prefix_len.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c    | 18 +++++++-------
 builtin/grep.c     |  4 +--
 builtin/ls-files.c | 13 +++++-----
 quote.c            | 71 ++++--------------------------------------------------
 quote.h            |  7 +++---
 wt-status.c        | 17 ++++++-------
 6 files changed, 33 insertions(+), 97 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..a93c3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -56,7 +56,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
 			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
 		if (!quiet) {
-			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			quote_path_relative(path->buf, &quoted, prefix);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
 					quoted.buf);
 		}
@@ -70,7 +70,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		/* an empty dir could be removed even if it is unreadble */
 		res = dry_run ? 0 : rmdir(path->buf);
 		if (res) {
-			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			quote_path_relative(path->buf, &quoted, prefix);
 			warning(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 		}
@@ -94,7 +94,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
 			if (gone) {
-				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				quote_path_relative(path->buf, &quoted, prefix);
 				string_list_append(&dels, quoted.buf);
 			} else
 				*dir_gone = 0;
@@ -102,10 +102,10 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		} else {
 			res = dry_run ? 0 : unlink(path->buf);
 			if (!res) {
-				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				quote_path_relative(path->buf, &quoted, prefix);
 				string_list_append(&dels, quoted.buf);
 			} else {
-				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				quote_path_relative(path->buf, &quoted, prefix);
 				warning(_(msg_warn_remove_failed), quoted.buf);
 				*dir_gone = 0;
 				ret = 1;
@@ -127,7 +127,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		if (!res)
 			*dir_gone = 1;
 		else {
-			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			quote_path_relative(path->buf, &quoted, prefix);
 			warning(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 			ret = 1;
@@ -262,7 +262,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
 					errors++;
 				if (gone && !quiet) {
-					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
+					qname = quote_path_relative(directory.buf, &buf, prefix);
 					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 				}
 			}
@@ -272,11 +272,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				continue;
 			res = dry_run ? 0 : unlink(ent->name);
 			if (res) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(ent->name, &buf, prefix);
 				warning(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(ent->name, &buf, prefix);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
diff --git a/builtin/grep.c b/builtin/grep.c
index 159e65..b5222 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -286,7 +286,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
+		quote_path_relative(filename + tree_name_len, &pathbuf,
 				    opt->prefix);
 		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
 	} else {
@@ -318,7 +318,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct strbuf buf = STRBUF_INIT;
 
 	if (opt->relative && opt->prefix_length)
-		quote_path_relative(filename, -1, &buf, opt->prefix);
+		quote_path_relative(filename, &buf, opt->prefix);
 	else
 		strbuf_addstr(&buf, filename);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 220207..bb563 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,10 +46,9 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_name(const char* name, size_t len)
+static void write_name(const char* name)
 {
-	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
-			line_terminator);
+	write_name_quoted_relative(name, prefix, stdout, line_terminator);
 }
 
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
@@ -63,7 +62,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_name(ent->name, ent->len);
+	write_name(ent->name);
 }
 
 static void show_other_files(struct dir_struct *dir)
@@ -163,7 +162,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name, ce_namelen(ce));
+	write_name(ce->name);
 	if (debug_mode) {
 		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
 		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
@@ -196,7 +195,7 @@ static void show_ru_info(void)
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 			       find_unique_abbrev(ui->sha1[i], abbrev),
 			       i + 1);
-			write_name(path, len);
+			write_name(path);
 		}
 	}
 }
@@ -389,7 +388,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, const char
 		if (found_dup)
 			continue;
 
-		name = quote_path_relative(pathspec[num], -1, &sb, prefix);
+		name = quote_path_relative(pathspec[num], &sb, prefix);
 		error("pathspec '%s' did not match any file(s) known to git.",
 		      name);
 		errors++;
diff --git a/quote.c b/quote.c
index 91122..97c57 100644
--- a/quote.c
+++ b/quote.c
@@ -312,81 +312,20 @@ void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
-static const char *path_relative(const char *in, int len,
-				 struct strbuf *sb, const char *prefix,
-				 int prefix_len);
-
-void write_name_quoted_relative(const char *name, size_t len,
-				const char *prefix, size_t prefix_len,
+void write_name_quoted_relative(const char *name, const char *prefix,
 				FILE *fp, int terminator)
 {
-	struct strbuf sb = STRBUF_INIT;
-
-	name = path_relative(name, len, &sb, prefix, prefix_len);
+	name = relative_path(name, prefix);
 	write_name_quoted(name, fp, terminator);
-
-	strbuf_release(&sb);
-}
-
-/*
- * Give path as relative to prefix.
- *
- * The strbuf may or may not be used, so do not assume it contains the
- * returned path.
- */
-static const char *path_relative(const char *in, int len,
-				 struct strbuf *sb, const char *prefix,
-				 int prefix_len)
-{
-	int off, i;
-
-	if (len < 0)
-		len = strlen(in);
-	if (prefix_len < 0) {
-		if (prefix)
-			prefix_len = strlen(prefix);
-		else
-			prefix_len = 0;
-	}
-
-	off = 0;
-	i = 0;
-	while (i < prefix_len && i < len && prefix[i] == in[i]) {
-		if (prefix[i] == '/')
-			off = i + 1;
-		i++;
-	}
-	in += off;
-	len -= off;
-
-	if (i >= prefix_len)
-		return in;
-
-	strbuf_reset(sb);
-	strbuf_grow(sb, len);
-
-	while (i < prefix_len) {
-		if (prefix[i] == '/')
-			strbuf_addstr(sb, "../");
-		i++;
-	}
-	strbuf_add(sb, in, len);
-
-	return sb->buf;
 }
 
 /* quote path as relative to the given prefix */
-char *quote_path_relative(const char *in, int len,
-			  struct strbuf *out, const char *prefix)
+char *quote_path_relative(const char *in, struct strbuf *out,
+			  const char *prefix)
 {
-	struct strbuf sb = STRBUF_INIT;
-	const char *rel = path_relative(in, len, &sb, prefix, -1);
+	const char *rel = relative_path(in, prefix);
 	strbuf_reset(out);
 	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
-	strbuf_release(&sb);
-
-	if (!out->len)
-		strbuf_addstr(out, "./");
 
 	return out->buf;
 }
diff --git a/quote.h b/quote.h
index 13315..27022 100644
--- a/quote.h
+++ b/quote.h
@@ -60,12 +60,11 @@ extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 extern void write_name_quoted(const char *name, FILE *, int terminator);
 extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
                                  const char *name, FILE *, int terminator);
-extern void write_name_quoted_relative(const char *name, size_t len,
-		const char *prefix, size_t prefix_len,
-		FILE *fp, int terminator);
+extern void write_name_quoted_relative(const char *name, const char *prefix,
+				       FILE *fp, int terminator);
 
 /* quote path as relative to the given prefix */
-extern char *quote_path_relative(const char *in, int len,
+extern char *quote_path_relative(const char *in,
 			  struct strbuf *out, const char *prefix);
 
 /* quoting as a string literal for other languages */
diff --git a/wt-status.c b/wt-status.c
index bf84a..002ac 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -243,7 +243,7 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
 	struct strbuf onebuf = STRBUF_INIT;
 	const char *one, *how = _("bug");
 
-	one = quote_path(it->string, -1, &onebuf, s->prefix);
+	one = quote_path(it->string, &onebuf, s->prefix);
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	switch (d->stagemask) {
 	case 1: how = _("both deleted:"); break;
@@ -297,8 +297,8 @@ static void wt_status_print_change_data(struct wt_status *s,
 		    change_type);
 	}
 
-	one = quote_path(one_name, -1, &onebuf, s->prefix);
-	two = quote_path(two_name, -1, &twobuf, s->prefix);
+	one = quote_path(one_name, &onebuf, s->prefix);
+	two = quote_path(two_name, &twobuf, s->prefix);
 
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	switch (status) {
@@ -706,8 +706,7 @@ static void wt_status_print_other(struct wt_status *s,
 		struct string_list_item *it;
 		const char *path;
 		it = &(l->items[i]);
-		path = quote_path(it->string, strlen(it->string),
-				  &buf, s->prefix);
+		path = quote_path(it->string, &buf, s->prefix);
 		if (column_active(s->colopts)) {
 			string_list_append(&output, path);
 			continue;
@@ -1289,7 +1288,7 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		one = quote_path(it->string, &onebuf, s->prefix);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
@@ -1317,7 +1316,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		if (d->head_path) {
-			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
+			one = quote_path(d->head_path, &onebuf, s->prefix);
 			if (*one != '"' && strchr(one, ' ') != NULL) {
 				putchar('"');
 				strbuf_addch(&onebuf, '"');
@@ -1326,7 +1325,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 			printf("%s -> ", one);
 			strbuf_release(&onebuf);
 		}
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		one = quote_path(it->string, &onebuf, s->prefix);
 		if (*one != '"' && strchr(one, ' ') != NULL) {
 			putchar('"');
 			strbuf_addch(&onebuf, '"');
@@ -1345,7 +1344,7 @@ static void wt_shortstatus_other(struct string_list_item *it,
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		one = quote_path(it->string, &onebuf, s->prefix);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
-- 
1.8.3.rc1.404.ga32c147
