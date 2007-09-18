From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 00:00:51 +0200
Message-ID: <20070918224122.2B55D344AB3@madism.org>
References: <20070918223947.GB4535@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXllk-0007mW-Ds
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbXIRWlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756618AbXIRWla
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:41:30 -0400
Received: from pan.madism.org ([88.191.52.104]:54833 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbXIRWl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:41:27 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 73829208A9;
	Wed, 19 Sep 2007 00:41:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2B55D344AB3; Wed, 19 Sep 2007 00:41:22 +0200 (CEST)
In-Reply-To: <20070918223947.GB4535@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58650>

* quote_c_style works on a strbuf instead of a wild buffer.
* quote_c_style is now clever enough to not add double quotes if not needed.

* write_name_quoted inherits those advantages, but also take a different
  set of arguments. Now instead of asking for quotes or not, you pass a
  "terminator". If it's \0 then we assume you don't want to escape, else C
  escaping is performed. In any case, the terminator is also appended to the
  stream. It also no longer takes the prefix/prefix_len arguments, as it's
  seldomly used, and makes some optimizations harder.

* write_name_quotedpfx is created to work like write_name_quoted and take
  the prefix/prefix_len arguments.

Thanks to those API changes, diff.c has somehow lost weight, thanks to the
removal of functions that were wrappers around the old write_name_quoted
trying to give it a semantics like the new one, but performing a lot of
allocations for this goal. Now we always write directly to the stream, no
intermediate allocation is performed.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c          |   83 +++++--------
 builtin-blame.c          |    3 +-
 builtin-check-attr.c     |    2 +-
 builtin-checkout-index.c |    4 +-
 builtin-ls-files.c       |   13 +--
 builtin-ls-tree.c        |    6 +-
 combine-diff.c           |   16 +--
 diff.c                   |  303 +++++++++++++++++-----------------------------
 quote.c                  |  198 +++++++++++++++++-------------
 quote.h                  |    8 +-
 10 files changed, 268 insertions(+), 368 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index cffbe52..0328863 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -163,15 +163,14 @@ static void say_patch_name(FILE *output, const char *pre, struct patch *patch, c
 	fputs(pre, output);
 	if (patch->old_name && patch->new_name &&
 	    strcmp(patch->old_name, patch->new_name)) {
-		write_name_quoted(NULL, 0, patch->old_name, 1, output);
+		quote_c_style(patch->old_name, NULL, output, 0);
 		fputs(" => ", output);
-		write_name_quoted(NULL, 0, patch->new_name, 1, output);
-	}
-	else {
+		quote_c_style(patch->new_name, NULL, output, 0);
+	} else {
 		const char *n = patch->new_name;
 		if (!n)
 			n = patch->old_name;
-		write_name_quoted(NULL, 0, n, 1, output);
+		quote_c_style(n, NULL, output, 0);
 	}
 	fputs(post, output);
 }
@@ -1378,61 +1377,50 @@ static const char minuses[]= "--------------------------------------------------
 
 static void show_stats(struct patch *patch)
 {
-	const char *prefix = "";
-	char *name = patch->new_name;
-	char *qname = NULL;
-	int len, max, add, del, total;
-
-	if (!name)
-		name = patch->old_name;
+	struct strbuf qname;
+	char *cp = patch->new_name ? patch->new_name : patch->old_name;
+	int max, add, del;
 
-	if (0 < (len = quote_c_style(name, NULL, NULL, 0))) {
-		qname = xmalloc(len + 1);
-		quote_c_style(name, qname, NULL, 0);
-		name = qname;
-	}
+	strbuf_init(&qname, 0);
+	quote_c_style(cp, &qname, NULL, 0);
 
 	/*
 	 * "scale" the filename
 	 */
-	len = strlen(name);
 	max = max_len;
 	if (max > 50)
 		max = 50;
-	if (len > max) {
-		char *slash;
-		prefix = "...";
-		max -= 3;
-		name += len - max;
-		slash = strchr(name, '/');
-		if (slash)
-			name = slash;
+
+	if (qname.len > max) {
+		cp = strchr(qname.buf + qname.len + 3 - max, '/');
+		if (cp)
+			cp = qname.buf + qname.len + 3 - max;
+		strbuf_splice(&qname, 0, cp - qname.buf, "...", 3);
+	}
+
+	if (patch->is_binary) {
+		printf(" %-*s |  Bin\n", max, qname.buf);
+		strbuf_release(&qname);
+		return;
 	}
-	len = max;
+
+	printf(" %-*s |", max, qname.buf);
+	strbuf_release(&qname);
 
 	/*
 	 * scale the add/delete
 	 */
-	max = max_change;
-	if (max + len > 70)
-		max = 70 - len;
-
+	max = max + max_change > 70 ? 70 - max : max_change;
 	add = patch->lines_added;
 	del = patch->lines_deleted;
-	total = add + del;
 
 	if (max_change > 0) {
-		total = (total * max + max_change / 2) / max_change;
+		int total = ((add + del) * max + max_change / 2) / max_change;
 		add = (add * max + max_change / 2) / max_change;
 		del = total - add;
 	}
-	if (patch->is_binary)
-		printf(" %s%-*s |  Bin\n", prefix, len, name);
-	else
-		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
-		       len, name, patch->lines_added + patch->lines_deleted,
-		       add, pluses, del, minuses);
-	free(qname);
+	printf("%5d %.*s%.*s\n", patch->lines_added + patch->lines_deleted,
+		add, pluses, del, minuses);
 }
 
 static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
@@ -2197,11 +2185,7 @@ static void show_index_list(struct patch *list)
 			sha1_ptr = sha1;
 
 		printf("%06o %s	",patch->old_mode, sha1_to_hex(sha1_ptr));
-		if (line_termination && quote_c_style(name, NULL, NULL, 0))
-			quote_c_style(name, NULL, stdout, 0);
-		else
-			fputs(name, stdout);
-		putchar(line_termination);
+		write_name_quoted(name, stdout, line_termination);
 	}
 }
 
@@ -2227,13 +2211,8 @@ static void numstat_patch_list(struct patch *patch)
 		if (patch->is_binary)
 			printf("-\t-\t");
 		else
-			printf("%d\t%d\t",
-			       patch->lines_added, patch->lines_deleted);
-		if (line_termination && quote_c_style(name, NULL, NULL, 0))
-			quote_c_style(name, NULL, stdout, 0);
-		else
-			fputs(name, stdout);
-		putchar(line_termination);
+			printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
+		write_name_quoted(name, stdout, line_termination);
 	}
 }
 
diff --git a/builtin-blame.c b/builtin-blame.c
index e364b6c..16c0ca8 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1430,8 +1430,7 @@ static void get_commit_info(struct commit *commit,
 static void write_filename_info(const char *path)
 {
 	printf("filename ");
-	write_name_quoted(NULL, 0, path, 1, stdout);
-	putchar('\n');
+	write_name_quoted(path, stdout, '\n');
 }
 
 /*
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index d949733..6afdfa1 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -56,7 +56,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			else if (ATTR_UNSET(value))
 				value = "unspecified";
 
-			write_name_quoted("", 0, argv[i], 1, stdout);
+			quote_c_style(argv[i], NULL, stdout, 0);
 			printf(": %s: %s\n", argv[j+1], value);
 		}
 	}
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index e6264c4..70d619d 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -66,9 +66,7 @@ static void write_tempfile_record(const char *name, int prefix_length)
 		fputs(topath[checkout_stage], stdout);
 
 	putchar('\t');
-	write_name_quoted("", 0, name + prefix_length,
-		line_termination, stdout);
-	putchar(line_termination);
+	write_name_quoted(name + prefix_length, stdout, line_termination);
 
 	for (i = 0; i < 4; i++) {
 		topath[i][0] = 0;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 48dd3f7..2e6f43b 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -84,8 +84,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_name_quoted("", 0, ent->name + offset, line_terminator, stdout);
-	putchar(line_terminator);
+	write_name_quoted(ent->name + offset, stdout, line_terminator);
 }
 
 static void show_other_files(struct dir_struct *dir)
@@ -208,21 +207,15 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 
 	if (!show_stage) {
 		fputs(tag, stdout);
-		write_name_quoted("", 0, ce->name + offset,
-				  line_terminator, stdout);
-		putchar(line_terminator);
-	}
-	else {
+	} else {
 		printf("%s%06o %s %d\t",
 		       tag,
 		       ntohl(ce->ce_mode),
 		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
 				: sha1_to_hex(ce->sha1),
 		       ce_stage(ce));
-		write_name_quoted("", 0, ce->name + offset,
-				  line_terminator, stdout);
-		putchar(line_terminator);
 	}
+	write_name_quoted(ce->name + offset, stdout, line_terminator);
 }
 
 static void show_files(struct dir_struct *dir, const char *prefix)
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index cb4be4f..7abe333 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -112,10 +112,8 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 			       abbrev ? find_unique_abbrev(sha1, abbrev)
 			              : sha1_to_hex(sha1));
 	}
-	write_name_quoted(base + chomp_prefix, baselen - chomp_prefix,
-			  pathname,
-			  line_termination, stdout);
-	putchar(line_termination);
+	write_name_quotedpfx(base + chomp_prefix, baselen - chomp_prefix,
+			  pathname, stdout, line_termination);
 	return retval;
 }
 
diff --git a/combine-diff.c b/combine-diff.c
index ef62234..fe5a2a1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -650,10 +650,7 @@ static void dump_quoted_path(const char *prefix, const char *path,
 			     const char *c_meta, const char *c_reset)
 {
 	printf("%s%s", c_meta, prefix);
-	if (quote_c_style(path, NULL, NULL, 0))
-		quote_c_style(path, NULL, stdout, 0);
-	else
-		printf("%s", path);
+	quote_c_style(path, NULL, stdout, 0);
 	printf("%s\n", c_reset);
 }
 
@@ -900,16 +897,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		putchar(inter_name_termination);
 	}
 
-	if (line_termination) {
-		if (quote_c_style(p->path, NULL, NULL, 0))
-			quote_c_style(p->path, NULL, stdout, 0);
-		else
-			printf("%s", p->path);
-		putchar(line_termination);
-	}
-	else {
-		printf("%s%c", p->path, line_termination);
-	}
+	write_name_quoted(p->path, stdout, line_termination);
 }
 
 void show_combined_diff(struct combine_diff_path *p,
diff --git a/diff.c b/diff.c
index 2216d75..fb6d077 100644
--- a/diff.c
+++ b/diff.c
@@ -181,44 +181,23 @@ int git_diff_ui_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
-static char *quote_one(const char *str)
-{
-	int needlen;
-	char *xp;
-
-	if (!str)
-		return NULL;
-	needlen = quote_c_style(str, NULL, NULL, 0);
-	if (!needlen)
-		return xstrdup(str);
-	xp = xmalloc(needlen + 1);
-	quote_c_style(str, xp, NULL, 0);
-	return xp;
-}
-
 static char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
 	int need_two = quote_c_style(two, NULL, NULL, 1);
-	char *xp;
+	struct strbuf res;
 
+	strbuf_init(&res, 0);
 	if (need_one + need_two) {
-		if (!need_one) need_one = strlen(one);
-		if (!need_two) need_one = strlen(two);
-
-		xp = xmalloc(need_one + need_two + 3);
-		xp[0] = '"';
-		quote_c_style(one, xp + 1, NULL, 1);
-		quote_c_style(two, xp + need_one + 1, NULL, 1);
-		strcpy(xp + need_one + need_two + 1, "\"");
-		return xp;
+		strbuf_addch(&res, '"');
+		quote_c_style(one, &res, NULL, 1);
+		quote_c_style(two, &res, NULL, 1);
+		strbuf_addch(&res, '"');
+	} else {
+		strbuf_addstr(&res, one);
+		strbuf_addstr(&res, two);
 	}
-	need_one = strlen(one);
-	need_two = strlen(two);
-	xp = xmalloc(need_one + need_two + 1);
-	strcpy(xp, one);
-	strcpy(xp + need_one, two);
-	return xp;
+	return res.buf;
 }
 
 static const char *external_diff(void)
@@ -670,27 +649,20 @@ static char *pprint_rename(const char *a, const char *b)
 {
 	const char *old = a;
 	const char *new = b;
-	char *name = NULL;
+	struct strbuf name;
 	int pfx_length, sfx_length;
 	int len_a = strlen(a);
 	int len_b = strlen(b);
+	int a_midlen, b_midlen;
 	int qlen_a = quote_c_style(a, NULL, NULL, 0);
 	int qlen_b = quote_c_style(b, NULL, NULL, 0);
 
+	strbuf_init(&name, 0);
 	if (qlen_a || qlen_b) {
-		if (qlen_a) len_a = qlen_a;
-		if (qlen_b) len_b = qlen_b;
-		name = xmalloc( len_a + len_b + 5 );
-		if (qlen_a)
-			quote_c_style(a, name, NULL, 0);
-		else
-			memcpy(name, a, len_a);
-		memcpy(name + len_a, " => ", 4);
-		if (qlen_b)
-			quote_c_style(b, name + len_a + 4, NULL, 0);
-		else
-			memcpy(name + len_a + 4, b, len_b + 1);
-		return name;
+		quote_c_style(a, &name, NULL, 0);
+		strbuf_addstr(&name, " => ");
+		quote_c_style(b, &name, NULL, 0);
+		return name.buf;
 	}
 
 	/* Find common prefix */
@@ -719,24 +691,26 @@ static char *pprint_rename(const char *a, const char *b)
 	 * pfx{sfx-a => sfx-b}
 	 * name-a => name-b
 	 */
+	a_midlen = len_a - pfx_length - sfx_length;
+	b_midlen = len_b - pfx_length - sfx_length;
+	if (a_midlen < 0)
+		a_midlen = 0;
+	if (b_midlen < 0)
+		b_midlen = 0;
+
+	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
 	if (pfx_length + sfx_length) {
-		int a_midlen = len_a - pfx_length - sfx_length;
-		int b_midlen = len_b - pfx_length - sfx_length;
-		if (a_midlen < 0) a_midlen = 0;
-		if (b_midlen < 0) b_midlen = 0;
-
-		name = xmalloc(pfx_length + a_midlen + b_midlen + sfx_length + 7);
-		sprintf(name, "%.*s{%.*s => %.*s}%s",
-			pfx_length, a,
-			a_midlen, a + pfx_length,
-			b_midlen, b + pfx_length,
-			a + len_a - sfx_length);
+		strbuf_add(&name, a, pfx_length);
+		strbuf_addch(&name, '{');
 	}
-	else {
-		name = xmalloc(len_a + len_b + 5);
-		sprintf(name, "%s => %s", a, b);
+	strbuf_add(&name, a + pfx_length, a_midlen);
+	strbuf_addstr(&name, " => ");
+	strbuf_add(&name, b + pfx_length, b_midlen);
+	if (pfx_length + sfx_length) {
+		strbuf_addch(&name, '}');
+		strbuf_add(&name, a + len_a - sfx_length, sfx_length);
 	}
-	return name;
+	return name.buf;
 }
 
 struct diffstat_t {
@@ -849,12 +823,13 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		int change = file->added + file->deleted;
 
 		if (!file->is_renamed) {  /* renames are already quoted by pprint_rename */
-			len = quote_c_style(file->name, NULL, NULL, 0);
-			if (len) {
-				char *qname = xmalloc(len + 1);
-				quote_c_style(file->name, qname, NULL, 0);
+			struct strbuf buf;
+			strbuf_init(&buf, 0);
+			if (quote_c_style(file->name, &buf, NULL, 0)) {
 				free(file->name);
-				file->name = qname;
+				file->name = buf.buf;
+			} else {
+				strbuf_release(&buf);
 			}
 		}
 
@@ -992,12 +967,12 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", file->added, file->deleted);
-		if (options->line_termination && !file->is_renamed &&
-		    quote_c_style(file->name, NULL, NULL, 0))
-			quote_c_style(file->name, NULL, stdout, 0);
-		else
+		if (!file->is_renamed) {
+			write_name_quoted(file->name, stdout, options->line_termination);
+		} else {
 			fputs(file->name, stdout);
-		putchar(options->line_termination);
+			putchar(options->line_termination);
+		}
 	}
 }
 
@@ -1941,50 +1916,46 @@ static int similarity_index(struct diff_filepair *p)
 static void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *pgm = external_diff();
-	char msg[PATH_MAX*2+300], *xfrm_msg;
-	struct diff_filespec *one;
-	struct diff_filespec *two;
+	struct strbuf msg;
+	char *xfrm_msg;
+	struct diff_filespec *one = p->one;
+	struct diff_filespec *two = p->two;
 	const char *name;
 	const char *other;
-	char *name_munged, *other_munged;
 	int complete_rewrite = 0;
-	int len;
+
 
 	if (DIFF_PAIR_UNMERGED(p)) {
-		/* unmerged */
 		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, o, 0);
 		return;
 	}
 
-	name = p->one->path;
+	name  = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
-	name_munged = quote_one(name);
-	other_munged = quote_one(other);
-	one = p->one; two = p->two;
-
 	diff_fill_sha1_info(one);
 	diff_fill_sha1_info(two);
 
-	len = 0;
+	strbuf_init(&msg, PATH_MAX * 2 + 300);
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
-		len += snprintf(msg + len, sizeof(msg) - len,
-				"similarity index %d%%\n"
-				"copy from %s\n"
-				"copy to %s\n",
-				similarity_index(p), name_munged, other_munged);
+		strbuf_addf(&msg, "similarity index %d%%", similarity_index(p));
+		strbuf_addstr(&msg, "\ncopy from ");
+		quote_c_style(name, &msg, NULL, 0);
+		strbuf_addstr(&msg, "\ncopy to ");
+		quote_c_style(other, &msg, NULL, 0);
+		strbuf_addch(&msg, '\n');
 		break;
 	case DIFF_STATUS_RENAMED:
-		len += snprintf(msg + len, sizeof(msg) - len,
-				"similarity index %d%%\n"
-				"rename from %s\n"
-				"rename to %s\n",
-				similarity_index(p), name_munged, other_munged);
+		strbuf_addf(&msg, "similarity index %d%%", similarity_index(p));
+		strbuf_addstr(&msg, "\nrename from ");
+		quote_c_style(name, &msg, NULL, 0);
+		strbuf_addstr(&msg, "\nrename to ");
+		quote_c_style(other, &msg, NULL, 0);
+		strbuf_addch(&msg, '\n');
 		break;
 	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
-			len += snprintf(msg + len, sizeof(msg) - len,
-					"dissimilarity index %d%%\n",
+			strbuf_addf(&msg, "dissimilarity index %d%%\n",
 					similarity_index(p));
 			complete_rewrite = 1;
 			break;
@@ -2004,19 +1975,17 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
-		len += snprintf(msg + len, sizeof(msg) - len,
-				"index %.*s..%.*s",
+		strbuf_addf(&msg, "index %.*s..%.*s",
 				abbrev, sha1_to_hex(one->sha1),
 				abbrev, sha1_to_hex(two->sha1));
 		if (one->mode == two->mode)
-			len += snprintf(msg + len, sizeof(msg) - len,
-					" %06o", one->mode);
-		len += snprintf(msg + len, sizeof(msg) - len, "\n");
+			strbuf_addf(&msg, " %06o", one->mode);
+		strbuf_addch(&msg, '\n');
 	}
 
-	if (len)
-		msg[--len] = 0;
-	xfrm_msg = len ? msg : NULL;
+	if (msg.len)
+		strbuf_setlen(&msg, msg.len - 1);
+	xfrm_msg = msg.len ? msg.buf : NULL;
 
 	if (!pgm &&
 	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
@@ -2035,8 +2004,7 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		run_diff_cmd(pgm, name, other, one, two, xfrm_msg, o,
 			     complete_rewrite);
 
-	free(name_munged);
-	free(other_munged);
+	strbuf_release(&msg);
 }
 
 static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
@@ -2492,72 +2460,30 @@ const char *diff_unique_abbrev(const unsigned char *sha1, int len)
 	return sha1_to_hex(sha1);
 }
 
-static void diff_flush_raw(struct diff_filepair *p,
-			   struct diff_options *options)
+static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 {
-	int two_paths;
-	char status[10];
-	int abbrev = options->abbrev;
-	const char *path_one, *path_two;
-	int inter_name_termination = '\t';
-	int line_termination = options->line_termination;
-
-	if (!line_termination)
-		inter_name_termination = 0;
+	int line_termination = opt->line_termination;
+	int inter_name_termination = line_termination ? '\t' : '\0';
 
-	path_one = p->one->path;
-	path_two = p->two->path;
-	if (line_termination) {
-		path_one = quote_one(path_one);
-		path_two = quote_one(path_two);
+	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
+		printf(":%06o %06o %s ", p->one->mode, p->two->mode,
+		       diff_unique_abbrev(p->one->sha1, opt->abbrev));
+		printf("%s ", diff_unique_abbrev(p->two->sha1, opt->abbrev));
 	}
-
-	if (p->score)
-		sprintf(status, "%c%03d", p->status, similarity_index(p));
-	else {
-		status[0] = p->status;
-		status[1] = 0;
-	}
-	switch (p->status) {
-	case DIFF_STATUS_COPIED:
-	case DIFF_STATUS_RENAMED:
-		two_paths = 1;
-		break;
-	case DIFF_STATUS_ADDED:
-	case DIFF_STATUS_DELETED:
-		two_paths = 0;
-		break;
-	default:
-		two_paths = 0;
-		break;
-	}
-	if (!(options->output_format & DIFF_FORMAT_NAME_STATUS)) {
-		printf(":%06o %06o %s ",
-		       p->one->mode, p->two->mode,
-		       diff_unique_abbrev(p->one->sha1, abbrev));
-		printf("%s ",
-		       diff_unique_abbrev(p->two->sha1, abbrev));
+	if (p->score) {
+		printf("%c%03d%c", p->status, similarity_index(p),
+			   inter_name_termination);
+	} else {
+		printf("%c%c", p->status, inter_name_termination);
 	}
-	printf("%s%c%s", status, inter_name_termination,
-			two_paths || p->one->mode ?  path_one : path_two);
-	if (two_paths)
-		printf("%c%s", inter_name_termination, path_two);
-	putchar(line_termination);
-	if (path_one != p->one->path)
-		free((void*)path_one);
-	if (path_two != p->two->path)
-		free((void*)path_two);
-}
 
-static void diff_flush_name(struct diff_filepair *p, struct diff_options *opt)
-{
-	char *path = p->two->path;
-
-	if (opt->line_termination)
-		path = quote_one(p->two->path);
-	printf("%s%c", path, opt->line_termination);
-	if (p->two->path != path)
-		free(path);
+	if (p->status == DIFF_STATUS_COPIED || p->status == DIFF_STATUS_RENAMED) {
+		write_name_quoted(p->one->path, stdout, inter_name_termination);
+		write_name_quoted(p->two->path, stdout, line_termination);
+	} else {
+		const char *path = p->one->mode ? p->one->path : p->two->path;
+		write_name_quoted(path, stdout, line_termination);
+	}
 }
 
 int diff_unmodified_pair(struct diff_filepair *p)
@@ -2567,14 +2493,11 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	 * let transformers to produce diff_filepairs any way they want,
 	 * and filter and clean them up here before producing the output.
 	 */
-	struct diff_filespec *one, *two;
+	struct diff_filespec *one = p->one, *two = p->two;
 
 	if (DIFF_PAIR_UNMERGED(p))
 		return 0; /* unmerged is interesting */
 
-	one = p->one;
-	two = p->two;
-
 	/* deletion, addition, mode or type change
 	 * and rename are all interesting.
 	 */
@@ -2763,32 +2686,27 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 	else if (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))
 		diff_flush_raw(p, opt);
 	else if (fmt & DIFF_FORMAT_NAME)
-		diff_flush_name(p, opt);
+		write_name_quoted(p->two->path, stdout, opt->line_termination);
 }
 
 static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
 {
-	char *name = quote_one(fs->path);
 	if (fs->mode)
-		printf(" %s mode %06o %s\n", newdelete, fs->mode, name);
+		printf(" %s mode %06o ", newdelete, fs->mode);
 	else
-		printf(" %s %s\n", newdelete, name);
-	free(name);
+		printf(" %s ", newdelete);
+	write_name_quoted(fs->path, stdout, '\n');
 }
 
 
 static void show_mode_change(struct diff_filepair *p, int show_name)
 {
 	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
+		printf(" mode change %06o => %06o%c", p->one->mode, p->two->mode,
+			show_name ? ' ' : '\n');
 		if (show_name) {
-			char *name = quote_one(p->two->path);
-			printf(" mode change %06o => %06o %s\n",
-			       p->one->mode, p->two->mode, name);
-			free(name);
+			write_name_quoted(p->two->path, stdout, '\n');
 		}
-		else
-			printf(" mode change %06o => %06o\n",
-			       p->one->mode, p->two->mode);
 	}
 }
 
@@ -2818,12 +2736,11 @@ static void diff_summary(struct diff_filepair *p)
 		break;
 	default:
 		if (p->score) {
-			char *name = quote_one(p->two->path);
-			printf(" rewrite %s (%d%%)\n", name,
-			       similarity_index(p));
-			free(name);
-			show_mode_change(p, 0);
-		} else	show_mode_change(p, 1);
+			puts(" rewrite ");
+			write_name_quoted(p->two->path, stdout, ' ');
+			printf("(%d%%)\n", similarity_index(p));
+		}
+		show_mode_change(p, !p->score);
 		break;
 	}
 }
@@ -2837,14 +2754,14 @@ struct patch_id_t {
 static int remove_space(char *line, int len)
 {
 	int i;
-        char *dst = line;
-        unsigned char c;
+	char *dst = line;
+	unsigned char c;
 
-        for (i = 0; i < len; i++)
-                if (!isspace((c = line[i])))
-                        *dst++ = c;
+	for (i = 0; i < len; i++)
+		if (!isspace((c = line[i])))
+			*dst++ = c;
 
-        return dst - line;
+	return dst - line;
 }
 
 static void patch_id_consume(void *priv, char *line, unsigned long len)
diff --git a/quote.c b/quote.c
index 67c6527..a8a755a 100644
--- a/quote.c
+++ b/quote.c
@@ -114,83 +114,142 @@ char *sq_dequote(char *arg)
 	}
 }
 
+/* 1 means: quote as octal
+ * 0 means: quote as octal if (quote_path_fully)
+ * -1 means: never quote
+ * c: quote as "\\c"
+ */
+#define X8(x)   x, x, x, x, x, x, x, x
+#define X16(x)  X8(x), X8(x)
+static signed char const sq_lookup[256] = {
+	/*           0    1    2    3    4    5    6    7 */
+	/* 0x00 */   1,   1,   1,   1,   1,   1, 'a',   1,
+	/* 0x08 */ 'b', 't', 'n', 'v', 'f', 'r',   1,   1,
+	/* 0x10 */ X16(1),
+	/* 0x20 */  -1,  -1, '"',  -1,  -1,  -1,  -1,  -1,
+	/* 0x28 */ X16(-1), X16(-1), X16(-1),
+	/* 0x58 */  -1,  -1,  -1,  -1,'\\',  -1,  -1,  -1,
+	/* 0x60 */ X16(-1), X16(-1),
+	/* 0x80 */ /* set to 0 */
+};
+
+static inline int sq_must_quote(char c) {
+	return sq_lookup[(unsigned char)c] + quote_path_fully > 0;
+}
+
+/* returns the longest prefix not needing a quote up to maxlen if positive.
+   This stops at the first \0 because it's marked as a character needing an
+   escape */
+static size_t next_quote_pos(const char *s, ssize_t maxlen)
+{
+	size_t len;
+	if (maxlen < 0) {
+		for (len = 0; !sq_must_quote(s[len]); len++);
+	} else {
+		for (len = 0; len < maxlen && !sq_must_quote(s[len]); len++);
+	}
+	return len;
+}
+
 /*
  * C-style name quoting.
  *
- * Does one of three things:
- *
  * (1) if outbuf and outfp are both NULL, inspect the input name and
  *     counts the number of bytes that are needed to hold c_style
  *     quoted version of name, counting the double quotes around
  *     it but not terminating NUL, and returns it.  However, if name
  *     does not need c_style quoting, it returns 0.
  *
- * (2) if outbuf is not NULL, it must point at a buffer large enough
- *     to hold the c_style quoted version of name, enclosing double
- *     quotes, and terminating NUL.  Fills outbuf with c_style quoted
- *     version of name enclosed in double-quote pair.  Return value
- *     is undefined.
- *
- * (3) if outfp is not NULL, outputs c_style quoted version of name,
- *     but not enclosed in double-quote pair.  Return value is undefined.
+ * (2) if sb or fp are not NULL, it emits the c_style quoted version
+ *     of name, enclosed with double quotes if asked and needed only.
+ *     Return value is the same as in (1).
  */
-
-static int quote_c_style_counted(const char *name, int namelen,
-				 char *outbuf, FILE *outfp, int no_dq)
+static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
+                                    struct strbuf *sb, FILE *fp, int no_dq)
 {
 #undef EMIT
-#define EMIT(c) \
-	(outbuf ? (*outbuf++ = (c)) : outfp ? fputc(c, outfp) : (count++))
+#define EMIT(c)                                 \
+	do {                                        \
+		if (sb) strbuf_addch(sb, (c));          \
+		if (fp) fputc((c), fp);                 \
+		count++;                                \
+	} while (0)
+#define EMITBUF(s, l)                           \
+	do {                                        \
+		if (sb) strbuf_add(sb, (s), (l));       \
+		if (fp) fwrite((s), (l), 1, fp);        \
+		count += (l);                           \
+	} while (0)
+
+	size_t len, count = 0;
+	const char *p = name;
 
-#define EMITQ() EMIT('\\')
-
-	const char *sp;
-	unsigned char ch;
-	int count = 0, needquote = 0;
+	for (;;) {
+		int ch;
 
-	if (!no_dq)
-		EMIT('"');
-	for (sp = name; sp < name + namelen; sp++) {
-		ch = *sp;
-		if (!ch)
+		len = next_quote_pos(p, maxlen);
+		if (len == maxlen || !p[len])
 			break;
-		if ((ch < ' ') || (ch == '"') || (ch == '\\') ||
-		    (quote_path_fully && (ch >= 0177))) {
-			needquote = 1;
-			switch (ch) {
-			case '\a': EMITQ(); ch = 'a'; break;
-			case '\b': EMITQ(); ch = 'b'; break;
-			case '\f': EMITQ(); ch = 'f'; break;
-			case '\n': EMITQ(); ch = 'n'; break;
-			case '\r': EMITQ(); ch = 'r'; break;
-			case '\t': EMITQ(); ch = 't'; break;
-			case '\v': EMITQ(); ch = 'v'; break;
-
-			case '\\': /* fallthru */
-			case '"': EMITQ(); break;
-			default:
-				/* octal */
-				EMITQ();
-				EMIT(((ch >> 6) & 03) + '0');
-				EMIT(((ch >> 3) & 07) + '0');
-				ch = (ch & 07) + '0';
-				break;
-			}
+
+		if (!no_dq && p == name)
+			EMIT('"');
+
+		EMITBUF(p, len);
+		EMIT('\\');
+		p += len;
+		ch = (unsigned char)*p++;
+		if (sq_lookup[ch] >= ' ') {
+			EMIT(sq_lookup[ch]);
+		} else {
+			EMIT(((ch >> 6) & 03) + '0');
+			EMIT(((ch >> 3) & 07) + '0');
+			EMIT(((ch >> 0) & 07) + '0');
 		}
-		EMIT(ch);
 	}
+
+	EMITBUF(p, len);
+	if (p == name)   /* no ending quote needed */
+		return 0;
+
 	if (!no_dq)
 		EMIT('"');
-	if (outbuf)
-		*outbuf = 0;
+	return count;
+}
 
-	return needquote ? count : 0;
+size_t quote_c_style(const char *name, struct strbuf *sb, FILE *fp, int nodq)
+{
+	return quote_c_style_counted(name, -1, sb, fp, nodq);
 }
 
-int quote_c_style(const char *name, char *outbuf, FILE *outfp, int no_dq)
+void write_name_quoted(const char *name, FILE *fp, int terminator)
 {
-	int cnt = strlen(name);
-	return quote_c_style_counted(name, cnt, outbuf, outfp, no_dq);
+	if (terminator) {
+		quote_c_style(name, NULL, fp, 0);
+	} else {
+		fputs(name, fp);
+	}
+	fputc(terminator, fp);
+}
+
+extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
+                                 const char *name, FILE *fp, int terminator)
+{
+	int needquote = 0;
+
+	if (terminator) {
+		needquote = next_quote_pos(pfx, pfxlen) < pfxlen
+			|| name[next_quote_pos(name, -1)];
+	}
+	if (needquote) {
+		fputc('"', fp);
+		quote_c_style_counted(pfx, pfxlen, NULL, fp, 1);
+		quote_c_style(name, NULL, fp, 1);
+		fputc('"', fp);
+	} else {
+		fwrite(pfx, pfxlen, 1, fp);
+		fputs(name, fp);
+	}
+	fputc(terminator, fp);
 }
 
 /*
@@ -259,37 +318,6 @@ int unquote_c_style(struct strbuf *sb, const char *quoted, const char **endp)
 	return -1;
 }
 
-void write_name_quoted(const char *prefix, int prefix_len,
-		       const char *name, int quote, FILE *out)
-{
-	int needquote;
-
-	if (!quote) {
-	no_quote:
-		if (prefix_len)
-			fprintf(out, "%.*s", prefix_len, prefix);
-		fputs(name, out);
-		return;
-	}
-
-	needquote = 0;
-	if (prefix_len)
-		needquote = quote_c_style_counted(prefix, prefix_len,
-						  NULL, NULL, 0);
-	if (!needquote)
-		needquote = quote_c_style(name, NULL, NULL, 0);
-	if (needquote) {
-		fputc('"', out);
-		if (prefix_len)
-			quote_c_style_counted(prefix, prefix_len,
-					      NULL, out, 1);
-		quote_c_style(name, NULL, out, 1);
-		fputc('"', out);
-	}
-	else
-		goto no_quote;
-}
-
 /* quoting as a string literal for other languages */
 
 void perl_quote_print(FILE *stream, const char *src)
diff --git a/quote.h b/quote.h
index 6407c4d..4287990 100644
--- a/quote.h
+++ b/quote.h
@@ -41,11 +41,11 @@ extern void sq_quote_argv(struct strbuf *, const char **argv, int count,
 extern char *sq_dequote(char *);
 
 extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
-extern int quote_c_style(const char *name, char *outbuf, FILE *outfp,
-			 int nodq);
+extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
 
-extern void write_name_quoted(const char *prefix, int prefix_len,
-			      const char *name, int quote, FILE *out);
+extern void write_name_quoted(const char *name, FILE *, int terminator);
+extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
+                                 const char *name, FILE *, int terminator);
 
 /* quoting as a string literal for other languages */
 extern void perl_quote_print(FILE *stream, const char *src);
-- 
1.5.3.1
