From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix up some fallout from "setup_git_directory()" cleanups
Date: Mon, 31 Jul 2006 14:56:44 -0700
Message-ID: <7v7j1t5tgj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607311311060.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 23:57:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7fkt-0002SR-Md
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 23:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWGaV4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 17:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWGaV4w
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 17:56:52 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38652 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751379AbWGaV4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 17:56:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731215645.EXOM2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 17:56:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607311311060.4168@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 31 Jul 2006 13:13:55 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24549>

Linus Torvalds <torvalds@osdl.org> writes:

> git-ls-files was broken by the setup_git_directory() calling changes, 
> because I had missed the fact that the "prefix" variable in that file was 
> static to the whole file, and unlike git-ls-tree (where I had fixed it 
> up), it ended up using two different variables with the same name 
> depending on what the scoping happened to be.

This would have been prevented if the rest of the sources were -Wshadow
clean.  I once tried to clean things up, but there are tons of
warnings in the current code [*1*].

Another thing that would help us is to have more tests that run
things from subdirectories.  Any takers?


[Footnote]

*1* They are mostly local variables masking unrelated system
    library function names.


This deletes more lines than it adds, but I am not sure if it is
worth it.

-- >8 --
Subject: [PATCH] -Wshadow

This renames local variables and parameters to avoid -Wshadow warnings.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 blame.c                 |    9 ++--
 builtin-apply.c         |   36 ++++++++--------
 builtin-diff.c          |    1 
 builtin-fmt-merge-msg.c |    8 ++--
 builtin-grep.c          |    2 -
 builtin-help.c          |    6 +--
 builtin-ls-files.c      |   10 ++---
 builtin-mailinfo.c      |  103 ++++++++++++++++++++++++-----------------------
 builtin-mv.c            |    6 +--
 builtin-prune.c         |    8 ++--
 builtin-push.c          |   10 ++---
 builtin-read-tree.c     |   78 ++++++++++++++++++------------------
 builtin-rev-list.c      |    8 ++--
 builtin-show-branch.c   |    9 ++--
 cache.h                 |    6 +--
 config.c                |    4 +-
 convert-objects.c       |   10 ++---
 daemon.c                |    2 -
 date.c                  |   30 +++++++-------
 delta.h                 |   12 +++--
 diff-delta.c            |   34 ++++++++--------
 fetch-clone.c           |   14 +++---
 fetch.c                 |    6 +--
 fsck-objects.c          |    1 
 git.c                   |    6 +--
 http-fetch.c            |   26 ++++++------
 http-push.c             |   28 ++++++-------
 merge-tree.c            |   18 ++++----
 pack-check.c            |    1 
 pack-objects.c          |   36 ++++++++--------
 path-list.c             |   24 +++++------
 revision.c              |    2 -
 setup.c                 |    2 -
 sha1_file.c             |   60 ++++++++++++++-------------
 tree-walk.c             |   10 ++---
 xdiff/xprepare.c        |    8 ++--
 36 files changed, 315 insertions(+), 319 deletions(-)

diff --git a/blame.c b/blame.c
index 76712b5..2e8bbe7 100644
--- a/blame.c
+++ b/blame.c
@@ -428,7 +428,6 @@ static void process_commits(struct rev_i
 	do {
 		struct commit_list *parents;
 		int num_parents;
-		struct util_info *util;
 
 		if (DEBUG)
 			printf("\nProcessing commit: %d %s\n", num_commits,
@@ -682,16 +681,16 @@ static void get_commit_info(struct commi
 	*tmp = 0;
 }
 
-static const char* format_time(unsigned long time, const char* tz_str,
+static const char* format_time(unsigned long unix_time, const char* tz_str,
 			       int show_raw_time)
 {
 	static char time_buf[128];
-	time_t t = time;
+	time_t t = unix_time;
 	int minutes, tz;
 	struct tm *tm;
 
 	if (show_raw_time) {
-		sprintf(time_buf, "%lu %s", time, tz_str);
+		sprintf(time_buf, "%lu %s", unix_time, tz_str);
 		return time_buf;
 	}
 
@@ -699,7 +698,7 @@ static const char* format_time(unsigned 
 	minutes = tz < 0 ? -tz : tz;
 	minutes = (minutes / 100)*60 + (minutes % 100);
 	minutes = tz < 0 ? -minutes : minutes;
-	t = time + minutes * 60;
+	t = unix_time + minutes * 60;
 	tm = gmtime(&t);
 
 	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", tm);
diff --git a/builtin-apply.c b/builtin-apply.c
index f8c6763..25454dd 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -199,7 +199,7 @@ static int name_terminate(const char *na
 	return 1;
 }
 
-static char * find_name(const char *line, char *def, int p_value, int terminate)
+static char * find_name(const char *line, char *def, int p_val, int terminate)
 {
 	int len;
 	const char *start = line;
@@ -212,12 +212,12 @@ static char * find_name(const char *line
 		name = unquote_c_style(line, NULL);
 		if (name) {
 			char *cp = name;
-			while (p_value) {
+			while (p_val) {
 				cp = strchr(name, '/');
 				if (!cp)
 					break;
 				cp++;
-				p_value--;
+				p_val--;
 			}
 			if (cp) {
 				/* name can later be freed, so we need
@@ -244,7 +244,7 @@ static char * find_name(const char *line
 				break;
 		}
 		line++;
-		if (c == '/' && !--p_value)
+		if (c == '/' && !--p_val)
 			start = line;
 	}
 	if (!start)
@@ -601,7 +601,7 @@ static char *git_header_name(char *line,
 		case '\t': case ' ':
 			second = name+len;
 			for (;;) {
-				char c = *second++;
+				c = *second++;
 				if (c == '\n')
 					return NULL;
 				if (c == '/')
@@ -1152,7 +1152,7 @@ static const char minuses[]= "----------
 
 static void show_stats(struct patch *patch)
 {
-	const char *prefix = "";
+	const char *leading = "";
 	char *name = patch->new_name;
 	char *qname = NULL;
 	int len, max, add, del, total;
@@ -1175,7 +1175,7 @@ static void show_stats(struct patch *pat
 		max = 50;
 	if (len > max) {
 		char *slash;
-		prefix = "...";
+		leading = "...";
 		max -= 3;
 		name += len - max;
 		slash = strchr(name, '/');
@@ -1201,9 +1201,9 @@ static void show_stats(struct patch *pat
 		del = total - add;
 	}
 	if (patch->is_binary)
-		printf(" %s%-*s |  Bin\n", prefix, len, name);
+		printf(" %s%-*s |  Bin\n", leading, len, name);
 	else
-		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
+		printf(" %s%-*s |%5d %.*s%.*s\n", leading,
 		       len, name, patch->lines_added + patch->lines_deleted,
 		       add, pluses, del, minuses);
 	if (qname)
@@ -1453,7 +1453,7 @@ static int apply_one_fragment(struct buf
 			offset = -1;
 		if (offset >= 0) {
 			int diff = newsize - oldsize;
-			unsigned long size = desc->size + diff;
+			unsigned long sz = desc->size + diff;
 			unsigned long alloc = desc->alloc;
 
 			/* Warn if it was necessary to reduce the number
@@ -1463,14 +1463,14 @@ static int apply_one_fragment(struct buf
 				fprintf(stderr, "Context reduced to (%ld/%ld) to apply fragment at %d\n",
 					leading, trailing, pos + lines);
 
-			if (size > alloc) {
-				alloc = size + 8192;
+			if (sz > alloc) {
+				alloc = sz + 8192;
 				desc->alloc = alloc;
 				buf = xrealloc(buf, alloc);
 				desc->buffer = buf;
 			}
-			desc->size = size;
-			memmove(buf + offset + newsize, buf + offset + oldsize, size - offset - newsize);
+			desc->size = sz;
+			memmove(buf + offset + newsize, buf + offset + oldsize, sz - offset - newsize);
 			memcpy(buf + offset, newlines, newsize);
 			offset = 0;
 
@@ -1827,13 +1827,13 @@ static int check_patch(struct patch *pat
 static int check_patch_list(struct patch *patch)
 {
 	struct patch *prev_patch = NULL;
-	int error = 0;
+	int err = 0;
 
 	for (prev_patch = NULL; patch ; patch = patch->next) {
-		error |= check_patch(patch, prev_patch);
+		err |= check_patch(patch, prev_patch);
 		prev_patch = patch;
 	}
-	return error;
+	return err;
 }
 
 static inline int is_null_sha1(const unsigned char *sha1)
@@ -2268,7 +2268,7 @@ static int git_apply_config(const char *
 }
 
 
-int cmd_apply(int argc, const char **argv, const char *prefix)
+int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 {
 	int i;
 	int read_stdin = 1;
diff --git a/builtin-diff.c b/builtin-diff.c
index 48d2fd0..44c39b0 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -263,7 +263,6 @@ int cmd_diff(int argc, const char **argv
 	 * default to HEAD by hand.  Eek.
 	 */
 	if (!rev.pending.nr) {
-		int i;
 		for (i = 1; i < argc; i++) {
 			const char *arg = argv[i];
 			if (!strcmp(arg, "--"))
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index c84224e..0c8d50d 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -138,7 +138,7 @@ static int handle_line(char *line)
 	}
 
 	if (!strcmp(".", src) || !strcmp(src, origin)) {
-		int len = strlen(origin);
+		len = strlen(origin);
 		if (origin[0] == '\'' && origin[len - 1] == '\'') {
 			char *new_origin = malloc(len - 1);
 			memcpy(new_origin, origin + 1, len - 2);
@@ -338,10 +338,10 @@ int cmd_fmt_merge_msg(int argc, char **a
 		printf(" into %s\n", current_branch);
 
 	if (merge_summary) {
-		struct commit *head;
+		struct commit *head_commit;
 		struct rev_info rev;
 
-		head = lookup_commit(head_sha1);
+		head_commit = lookup_commit(head_sha1);
 		init_revisions(&rev, prefix);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
@@ -349,7 +349,7 @@ int cmd_fmt_merge_msg(int argc, char **a
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.list[i], origins.payload[i],
-					head, &rev, limit);
+				 head_commit, &rev, limit);
 	}
 
 	/* No cleanup yet; is standalone anyway */
diff --git a/builtin-grep.c b/builtin-grep.c
index 69b7c48..64cb1eb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -783,7 +783,7 @@ static int external_grep(struct grep_opt
 			continue;
 		name = ce->name;
 		if (name[0] == '-') {
-			int len = ce_namelen(ce);
+			len = ce_namelen(ce);
 			name = xmalloc(len + 3);
 			memcpy(name, "./", 2);
 			memcpy(name + 2, ce->name, len + 1);
diff --git a/builtin-help.c b/builtin-help.c
index bb0b03f..f86a7c7 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -77,7 +77,7 @@ static int cmdname_compare(const void *a
 	return strcmp(a->name, b->name);
 }
 
-static void pretty_print_string_list(struct cmdname **cmdname, int longest)
+static void pretty_print_string_list(struct cmdname **name, int longest)
 {
 	int cols = 1, rows;
 	int space = longest + 1; /* min 1 SP between words */
@@ -88,7 +88,7 @@ static void pretty_print_string_list(str
 		cols = max_cols / space;
 	rows = (cmdname_cnt + cols - 1) / cols;
 
-	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
+	qsort(name, cmdname_cnt, sizeof(*name), cmdname_compare);
 
 	for (i = 0; i < rows; i++) {
 		printf("  ");
@@ -100,7 +100,7 @@ static void pretty_print_string_list(str
 				break;
 			if (j == cols-1 || n + rows >= cmdname_cnt)
 				size = 1;
-			printf("%-*s", size, cmdname[n]->name);
+			printf("%-*s", size, name[n]->name);
 		}
 		putchar('\n');
 	}
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 11386c4..17ec3d2 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -40,7 +40,7 @@ static const char *tag_modified = "";
  * Match a pathspec against a filename. The first "len" characters
  * are the common prefix
  */
-static int match(const char **spec, char *ps_matched,
+static int match(const char **spec, char *matched,
 		 const char *filename, int len)
 {
 	const char *m;
@@ -60,12 +60,12 @@ static int match(const char **spec, char
 		}
 		if (!fnmatch(m + len, filename + len, 0))
 			goto matched;
-		if (ps_matched)
-			ps_matched++;
+		if (matched)
+			matched++;
 		continue;
 	matched:
-		if (ps_matched)
-			*ps_matched = 1;
+		if (matched)
+			*matched = 1;
 		return 1;
 	}
 	return 0;
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 24a4fc6..612f8cf 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -18,16 +18,16 @@ static FILE *cmitmsg, *patchfile, *fin, 
 
 static int keep_subject = 0;
 static const char *metainfo_charset = NULL;
-static char line[1000];
-static char date[1000];
-static char name[1000];
-static char email[1000];
-static char subject[1000];
+static char line_buf[1000];
+static char date_buf[1000];
+static char name_buf[1000];
+static char email_buf[1000];
+static char subject_buf[1000];
 
 static enum  {
 	TE_DONTCARE, TE_QP, TE_BASE64,
 } transfer_encoding;
-static char charset[256];
+static char charset_buf[256];
 
 static char multipart_boundary[1000];
 static int multipart_boundary_len;
@@ -51,7 +51,7 @@ static int bogus_from(char *line)
 	/* This is fallback, so do not bother if we already have an
 	 * e-mail address.
 	 */
-	if (*email)
+	if (*email_buf)
 		return 0;
 
 	bra = strchr(line, '<');
@@ -61,15 +61,15 @@ static int bogus_from(char *line)
 	if (!ket)
 		return 0;
 
-	for (dst = email, cp = bra+1; cp < ket; )
+	for (dst = email_buf, cp = bra+1; cp < ket; )
 		*dst++ = *cp++;
 	*dst = 0;
 	for (cp = line; isspace(*cp); cp++)
 		;
 	for (bra--; isspace(*bra); bra--)
 		*bra = 0;
-	cp = sanity_check(cp, email);
-	strcpy(name, cp);
+	cp = sanity_check(cp, email_buf);
+	strcpy(name_buf, cp);
 	return 1;
 }
 
@@ -87,7 +87,7 @@ static int handle_from(char *in_line)
 	/*
 	 * If we already have one email, don't take any confusing lines
 	 */
-	if (*email && strchr(at+1, '@'))
+	if (*email_buf && strchr(at+1, '@'))
 		return 0;
 
 	/* Pick up the string around '@', possibly delimited with <>
@@ -103,7 +103,7 @@ static int handle_from(char *in_line)
 		}
 		at--;
 	}
-	dst = email;
+	dst = email_buf;
 	for (;;) {
 		unsigned char c = *at;
 		if (!c || c == '>' || isspace(c)) {
@@ -140,20 +140,20 @@ static int handle_from(char *in_line)
 		}
 		at++;
 	}
-	at = sanity_check(at, email);
-	strcpy(name, at);
+	at = sanity_check(at, email_buf);
+	strcpy(name_buf, at);
 	return 1;
 }
 
 static int handle_date(char *line)
 {
-	strcpy(date, line);
+	strcpy(date_buf, line);
 	return 0;
 }
 
 static int handle_subject(char *line)
 {
-	strcpy(subject, line);
+	strcpy(subject_buf, line);
 	return 0;
 }
 
@@ -194,11 +194,11 @@ static int handle_subcontent_type(char *
 		fprintf(stderr, "Not handling nested multipart message.\n");
 		exit(1);
 	}
-	slurp_attr(line, "charset=", charset);
-	if (*charset) {
+	slurp_attr(line, "charset=", charset_buf);
+	if (*charset_buf) {
 		int i, c;
-		for (i = 0; (c = charset[i]) != 0; i++)
-			charset[i] = tolower(c);
+		for (i = 0; (c = charset_buf[i]) != 0; i++)
+			charset_buf[i] = tolower(c);
 	}
 	return 0;
 }
@@ -210,7 +210,7 @@ static int handle_content_type(char *lin
 		memcpy(multipart_boundary, "--", 2);
 		multipart_boundary_len = strlen(multipart_boundary);
 	}
-	slurp_attr(line, "charset=", charset);
+	slurp_attr(line, "charset=", charset_buf);
 	return 0;
 }
 
@@ -300,7 +300,7 @@ static char *cleanup_subject(char *subje
 		return subject;
 	for (;;) {
 		char *p;
-		int len, remove;
+		int len, strip_len;
 		switch (*subject) {
 		case 'r': case 'R':
 			if (!memcmp("e:", subject+1, 2)) {
@@ -319,8 +319,8 @@ static char *cleanup_subject(char *subje
 				continue;
 			}
 			len = strlen(p);
-			remove = p - subject;
-			if (remove <= len *2) {
+			strip_len = p - subject;
+			if (strip_len <= len *2) {
 				subject = p+1;
 				continue;
 			}
@@ -659,14 +659,14 @@ static void handle_info(void)
 {
 	char *sub;
 
-	sub = cleanup_subject(subject);
-	cleanup_space(name);
-	cleanup_space(date);
-	cleanup_space(email);
+	sub = cleanup_subject(subject_buf);
+	cleanup_space(name_buf);
+	cleanup_space(date_buf);
+	cleanup_space(email_buf);
 	cleanup_space(sub);
 
 	fprintf(fout, "Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n\n",
-	       name, email, sub, date);
+	       name_buf, email_buf, sub, date_buf);
 }
 
 /* We are inside message body and have read line[] already.
@@ -677,11 +677,12 @@ static int handle_commit_msg(int *seen)
 	if (!cmitmsg)
 		return 0;
 	do {
-		if (!memcmp("diff -", line, 6) ||
-		    !memcmp("---", line, 3) ||
-		    !memcmp("Index: ", line, 7))
+		if (!memcmp("diff -", line_buf, 6) ||
+		    !memcmp("---", line_buf, 3) ||
+		    !memcmp("Index: ", line_buf, 7))
 			break;
-		if ((multipart_boundary[0] && is_multipart_boundary(line))) {
+		if ((multipart_boundary[0] &&
+		     is_multipart_boundary(line_buf))) {
 			/* We come here when the first part had only
 			 * the commit message without any patch.  We
 			 * pretend we have not seen this line yet, and
@@ -693,16 +694,16 @@ static int handle_commit_msg(int *seen)
 		/* Unwrap transfer encoding and optionally
 		 * normalize the log message to UTF-8.
 		 */
-		decode_transfer_encoding(line);
+		decode_transfer_encoding(line_buf);
 		if (metainfo_charset)
-			convert_to_utf8(line, charset);
+			convert_to_utf8(line_buf, charset_buf);
 
-		handle_inbody_header(seen, line);
+		handle_inbody_header(seen, line_buf);
 		if (!(*seen & SEEN_PREFIX))
 			continue;
 
-		fputs(line, cmitmsg);
-	} while (fgets(line, sizeof(line), fin) != NULL);
+		fputs(line_buf, cmitmsg);
+	} while (fgets(line_buf, sizeof(line_buf), fin) != NULL);
 	fclose(cmitmsg);
 	cmitmsg = NULL;
 	return 0;
@@ -714,16 +715,16 @@ static int handle_commit_msg(int *seen)
 static void handle_patch(void)
 {
 	do {
-		if (multipart_boundary[0] && is_multipart_boundary(line))
+		if (multipart_boundary[0] && is_multipart_boundary(line_buf))
 			break;
 		/* Only unwrap transfer encoding but otherwise do not
 		 * do anything.  We do *NOT* want UTF-8 conversion
 		 * here; we are dealing with the user payload.
 		 */
-		decode_transfer_encoding(line);
-		fputs(line, patchfile);
+		decode_transfer_encoding(line_buf);
+		fputs(line_buf, patchfile);
 		patch_lines++;
-	} while (fgets(line, sizeof(line), fin) != NULL);
+	} while (fgets(line_buf, sizeof(line_buf), fin) != NULL);
 }
 
 /* multipart boundary and transfer encoding are set up for us, and we
@@ -736,10 +737,10 @@ static int handle_multipart_one_part(int
 {
 	int n = 0;
 
-	while (fgets(line, sizeof(line), fin) != NULL) {
+	while (fgets(line_buf, sizeof(line_buf), fin) != NULL) {
 	again:
 		n++;
-		if (is_multipart_boundary(line))
+		if (is_multipart_boundary(line_buf))
 			break;
 		if (handle_commit_msg(seen))
 			goto again;
@@ -757,8 +758,8 @@ static void handle_multipart_body(void)
 	int part_num = 0;
 
 	/* Skip up to the first boundary */
-	while (fgets(line, sizeof(line), fin) != NULL)
-		if (is_multipart_boundary(line)) {
+	while (fgets(line_buf, sizeof(line_buf), fin) != NULL)
+		if (is_multipart_boundary(line_buf)) {
 			part_num = 1;
 			break;
 		}
@@ -766,16 +767,16 @@ static void handle_multipart_body(void)
 		return;
 	/* We are on boundary line.  Start slurping the subhead. */
 	while (1) {
-		int hdr = read_one_header_line(line, sizeof(line), fin);
+		int hdr = read_one_header_line(line_buf, sizeof(line_buf), fin);
 		if (!hdr) {
 			if (handle_multipart_one_part(&seen) < 0)
 				return;
 			/* Reset per part headers */
 			transfer_encoding = TE_DONTCARE;
-			charset[0] = 0;
+			charset_buf[0] = 0;
 		}
 		else
-			check_subheader_line(line);
+			check_subheader_line(line_buf);
 	}
 	fclose(patchfile);
 	if (!patch_lines) {
@@ -818,7 +819,7 @@ int mailinfo(FILE *in, FILE *out, int ks
 		return -1;
 	}
 	while (1) {
-		int hdr = read_one_header_line(line, sizeof(line), fin);
+		int hdr = read_one_header_line(line_buf, sizeof(line_buf), fin);
 		if (!hdr) {
 			if (multipart_boundary[0])
 				handle_multipart_body();
@@ -827,7 +828,7 @@ int mailinfo(FILE *in, FILE *out, int ks
 			handle_info();
 			break;
 		}
-		check_header_line(line);
+		check_header_line(line_buf);
 	}
 
 	return 0;
diff --git a/builtin-mv.c b/builtin-mv.c
index 62ae937..fdaf051 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -267,10 +267,10 @@ next:
 	} else {
 		for (i = 0; i < changed.nr; i++) {
 			const char *path = changed.items[i].path;
-			int i = cache_name_pos(path, strlen(path));
-			struct cache_entry *ce = active_cache[i];
+			int pos = cache_name_pos(path, strlen(path));
+			struct cache_entry *ce = active_cache[pos];
 
-			if (i < 0)
+			if (pos < 0)
 				die ("Huh? Cache entry for %s unknown?", path);
 			refresh_cache_entry(ce, 0);
 		}
diff --git a/builtin-prune.c b/builtin-prune.c
index 6a86eb5..717e5dd 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -143,19 +143,19 @@ static void process_tag(struct tag *tag,
 	add_object(tag->tagged, p, NULL, name);
 }
 
-static void walk_commit_list(struct rev_info *revs)
+static void walk_commit_list(struct rev_info *rev)
 {
 	int i;
 	struct commit *commit;
 	struct object_array objects = { 0, 0, NULL };
 
 	/* Walk all commits, process their trees */
-	while ((commit = get_revision(revs)) != NULL)
+	while ((commit = get_revision(rev)) != NULL)
 		process_tree(commit->tree, &objects, NULL, "");
 
 	/* Then walk all the pending objects, recursively processing them too */
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object_array_entry *pending = revs->pending.objects + i;
+	for (i = 0; i < rev->pending.nr; i++) {
+		struct object_array_entry *pending = rev->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		if (obj->type == OBJ_TAG) {
diff --git a/builtin-push.c b/builtin-push.c
index a824171..e768923 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -234,7 +234,7 @@ static int do_push(const char *repo)
 	common_argc = argc;
 
 	for (i = 0; i < n; i++) {
-		int error;
+		int err;
 		int dest_argc = common_argc;
 		int dest_refspec_nr = refspec_nr;
 		const char **dest_refspec = refspec;
@@ -250,10 +250,10 @@ static int do_push(const char *repo)
 		while (dest_refspec_nr--)
 			argv[dest_argc++] = *dest_refspec++;
 		argv[dest_argc] = NULL;
-		error = run_command_v(argc, argv);
-		if (!error)
+		err = run_command_v(argc, argv);
+		if (!err)
 			continue;
-		switch (error) {
+		switch (err) {
 		case -ERR_RUN_COMMAND_FORK:
 			die("unable to fork for %s", sender);
 		case -ERR_RUN_COMMAND_EXEC:
@@ -264,7 +264,7 @@ static int do_push(const char *repo)
 		case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
 			die("%s died with strange error", sender);
 		default:
-			return -error;
+			return -err;
 		}
 	}
 	return 0;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 49c10bf..7fb0bbc 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -483,9 +483,9 @@ static void verify_absent(const char *pa
 		    "would be %s by merge.", path, action);
 }
 
-static int merged_entry(struct cache_entry *merge, struct cache_entry *old)
+static int merged_entry(struct cache_entry *result, struct cache_entry *old)
 {
-	merge->ce_flags |= htons(CE_UPDATE);
+	result->ce_flags |= htons(CE_UPDATE);
 	if (old) {
 		/*
 		 * See if we can re-use the old CE directly?
@@ -494,20 +494,20 @@ static int merged_entry(struct cache_ent
 		 * This also removes the UPDATE flag on
 		 * a match.
 		 */
-		if (same(old, merge)) {
-			*merge = *old;
+		if (same(old, result)) {
+			*result = *old;
 		} else {
 			verify_uptodate(old);
 			invalidate_ce_path(old);
 		}
 	}
 	else {
-		verify_absent(merge->name, "overwritten");
-		invalidate_ce_path(merge);
+		verify_absent(result->name, "overwritten");
+		invalidate_ce_path(result);
 	}
 
-	merge->ce_flags &= ~htons(CE_STAGEMASK);
-	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	result->ce_flags &= ~htons(CE_STAGEMASK);
+	add_cache_entry(result, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	return 1;
 }
 
@@ -547,7 +547,7 @@ #endif
 
 static int threeway_merge(struct cache_entry **stages)
 {
-	struct cache_entry *index;
+	struct cache_entry *cached;
 	struct cache_entry *head; 
 	struct cache_entry *remote = stages[head_idx + 1];
 	int count;
@@ -572,7 +572,7 @@ static int threeway_merge(struct cache_e
 		}
 	}
 
-	index = stages[0];
+	cached = stages[0];
 	head = stages[head_idx];
 
 	if (head == &df_conflict_entry) {
@@ -585,8 +585,8 @@ static int threeway_merge(struct cache_e
 		remote = NULL;
 	}
 
-	if (!path && index)
-		path = index->name;
+	if (!path && cached)
+		path = cached->name;
 	if (!path && head)
 		path = head->name;
 	if (!path && remote)
@@ -612,25 +612,25 @@ static int threeway_merge(struct cache_e
 	 */
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
-		if (index && !same(index, remote) && !same(index, head))
-			reject_merge(index);
-		return merged_entry(remote, index);
+		if (cached && !same(cached, remote) && !same(cached, head))
+			reject_merge(cached);
+		return merged_entry(remote, cached);
 	}
 	/*
 	 * If we have an entry in the index cache, then we want to
 	 * make sure that it matches head.
 	 */
-	if (index && !same(index, head)) {
-		reject_merge(index);
+	if (cached && !same(cached, head)) {
+		reject_merge(cached);
 	}
 
 	if (head) {
 		/* #5ALT, #15 */
 		if (same(head, remote))
-			return merged_entry(head, index);
+			return merged_entry(head, cached);
 		/* #13, #3ALT */
 		if (!df_conflict_remote && remote_match && !head_match)
-			return merged_entry(head, index);
+			return merged_entry(head, cached);
 	}
 
 	/* #1 */
@@ -650,8 +650,8 @@ static int threeway_merge(struct cache_e
 		if ((head_deleted && remote_deleted) ||
 		    (head_deleted && remote && remote_match) ||
 		    (remote_deleted && head && head_match)) {
-			if (index)
-				return deleted_entry(index, index);
+			if (cached)
+				return deleted_entry(cached, cached);
 			else if (path)
 				verify_absent(path, "removed");
 			return 0;
@@ -660,7 +660,7 @@ static int threeway_merge(struct cache_e
 		 * Added in both, identically.
 		 */
 		if (no_anc_exists && head && remote && same(head, remote))
-			return merged_entry(head, index);
+			return merged_entry(head, cached);
 
 	}
 
@@ -668,8 +668,8 @@ static int threeway_merge(struct cache_e
 	 * up-to-date to avoid the files getting overwritten with
 	 * conflict resolution files. 
 	 */
-	if (index) {
-		verify_uptodate(index);
+	if (cached) {
+		verify_uptodate(cached);
 	}
 	else if (path)
 		verify_absent(path, "overwritten");
@@ -870,7 +870,7 @@ static const char read_tree_usage[] = "g
 
 static struct lock_file lock_file;
 
-int cmd_read_tree(int argc, const char **argv, const char *prefix)
+int cmd_read_tree(int argc, const char **argv, const char *pfx)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
@@ -921,9 +921,9 @@ int cmd_read_tree(int argc, const char *
 		 * given subdirectory.
 		 */
 		if (!strncmp(arg, "--prefix=", 9)) {
-			if (stage || merge || prefix)
+			if (stage || merge || pfx)
 				usage(read_tree_usage);
-			prefix = arg + 9;
+			pfx = arg + 9;
 			merge = 1;
 			stage = 1;
 			if (read_cache_unmerged())
@@ -936,7 +936,7 @@ int cmd_read_tree(int argc, const char *
 		 * correspond to them.
 		 */
 		if (!strcmp(arg, "--reset")) {
-			if (stage || merge || prefix)
+			if (stage || merge || pfx)
 				usage(read_tree_usage);
 			reset = 1;
 			merge = 1;
@@ -957,7 +957,7 @@ int cmd_read_tree(int argc, const char *
 
 		/* "-m" stands for "merge", meaning we start in stage 1 */
 		if (!strcmp(arg, "-m")) {
-			if (stage || merge || prefix)
+			if (stage || merge || pfx)
 				usage(read_tree_usage);
 			if (read_cache_unmerged())
 				die("you need to resolve your current index first");
@@ -979,23 +979,23 @@ int cmd_read_tree(int argc, const char *
 	if ((update||index_only) && !merge)
 		usage(read_tree_usage);
 
-	if (prefix) {
-		int pfxlen = strlen(prefix);
+	if (pfx) {
+		int pfxlen = strlen(pfx);
 		int pos;
-		if (prefix[pfxlen-1] != '/')
+		if (pfx[pfxlen-1] != '/')
 			die("prefix must end with /");
 		if (stage != 2)
 			die("binding merge takes only one tree");
-		pos = cache_name_pos(prefix, pfxlen);
+		pos = cache_name_pos(pfx, pfxlen);
 		if (0 <= pos)
 			die("corrupt index file");
 		pos = -pos-1;
 		if (pos < active_nr &&
-		    !strncmp(active_cache[pos]->name, prefix, pfxlen))
-			die("subdirectory '%s' already exists.", prefix);
-		pos = cache_name_pos(prefix, pfxlen-1);
+		    !strncmp(active_cache[pos]->name, pfx, pfxlen))
+			die("subdirectory '%s' already exists.", pfx);
+		pos = cache_name_pos(pfx, pfxlen-1);
 		if (0 <= pos)
-			die("file '%.*s' already exists.", pfxlen-1, prefix);
+			die("file '%.*s' already exists.", pfxlen-1, pfx);
 	}
 
 	if (merge) {
@@ -1003,7 +1003,7 @@ int cmd_read_tree(int argc, const char *
 			die("just how do you expect me to merge %d trees?", stage-1);
 		switch (stage - 1) {
 		case 1:
-			fn = prefix ? bind_merge : oneway_merge;
+			fn = pfx ? bind_merge : oneway_merge;
 			break;
 		case 2:
 			fn = twoway_merge;
@@ -1029,7 +1029,7 @@ int cmd_read_tree(int argc, const char *
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
 	 */
-	if (trees && trees->item && !prefix && (!merge || (stage == 2))) {
+	if (trees && trees->item && !pfx && (!merge || (stage == 2))) {
 		cache_tree_free(&active_cache_tree);
 		prime_cache_tree();
 	}
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 0dee173..5223504 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -151,18 +151,18 @@ static void process_tree(struct tree *tr
 	tree->buffer = NULL;
 }
 
-static void show_commit_list(struct rev_info *revs)
+static void show_commit_list(struct rev_info *rev)
 {
 	int i;
 	struct commit *commit;
 	struct object_array objects = { 0, 0, NULL };
 
-	while ((commit = get_revision(revs)) != NULL) {
+	while ((commit = get_revision(rev)) != NULL) {
 		process_tree(commit->tree, &objects, NULL, "");
 		show_commit(commit);
 	}
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object_array_entry *pending = revs->pending.objects + i;
+	for (i = 0; i < rev->pending.nr; i++) {
+		struct object_array_entry *pending = rev->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 2a1b848..8bcf4e3 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -475,7 +475,7 @@ static int show_merge_base(struct commit
 
 static int show_independent(struct commit **rev,
 			    int num_rev,
-			    char **ref_name,
+			    char **unused_ref_name,
 			    unsigned int *rev_mask)
 {
 	int i;
@@ -752,9 +752,10 @@ int cmd_show_branch(int ac, const char *
 	all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
 
 	while (seen) {
-		struct commit *commit = pop_one_commit(&seen);
-		int this_flag = commit->object.flags;
-		int is_merge_point = ((this_flag & all_revs) == all_revs);
+		int this_flag, is_merge_point;
+		commit = pop_one_commit(&seen);
+		this_flag = commit->object.flags;
+		is_merge_point = ((this_flag & all_revs) == all_revs);
 
 		shown_merge_point |= is_merge_point;
 
diff --git a/cache.h b/cache.h
index c575b8a..eb9a403 100644
--- a/cache.h
+++ b/cache.h
@@ -240,7 +240,7 @@ extern int check_sha1_signature(const un
 extern int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 			      size_t bufsize, size_t *bufposn);
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
-extern int move_temp_to_file(const char *tmpfile, char *filename);
+extern int move_temp_to_file(const char *tmp_file, char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
@@ -268,8 +268,8 @@ extern void *read_object_with_reference(
 					unsigned long *size,
 					unsigned char *sha1_ret);
 
-const char *show_date(unsigned long time, int timezone);
-const char *show_rfc2822_date(unsigned long time, int timezone);
+const char *show_date(unsigned long unix_time, int time_zone);
+const char *show_rfc2822_date(unsigned long unix_time, int time_zone);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
diff --git a/config.c b/config.c
index 0ac6aeb..49c993e 100644
--- a/config.c
+++ b/config.c
@@ -148,7 +148,7 @@ static int get_extended_base_var(char *n
 	name[baselen++] = '.';
 
 	for (;;) {
-		int c = get_next_char();
+		c = get_next_char();
 		if (c == '\n')
 			return -1;
 		if (c == '"')
@@ -618,7 +618,7 @@ int git_config_set_multivar(const char* 
 	} else{
 		struct stat st;
 		char* contents;
-		int i, copy_begin, copy_end, new_line = 0;
+		int copy_begin, copy_end, new_line = 0;
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
diff --git a/convert-objects.c b/convert-objects.c
index ebea8e4..9b92560 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -183,15 +183,15 @@ static unsigned long parse_oldstyle_date
 				return mktime(&tm);
 			buf = next;
 		} else {
-			const char **p = timezones;
+			const char **tzp = timezones;
 			while (isspace(*buf))
 				buf++;
-			while (*p) {
-				if (!memcmp(buf, *p, strlen(*p))) {
-					buf += strlen(*p);
+			while (*tzp) {
+				if (!memcmp(buf, *tzp, strlen(*tzp))) {
+					buf += strlen(*tzp);
 					break;
 				}
-				p++;
+				tzp++;
 			}
 		}
 		fmt++;
diff --git a/daemon.c b/daemon.c
index 810837f..ff21a43 100644
--- a/daemon.c
+++ b/daemon.c
@@ -630,8 +630,6 @@ static int service_loop(int socknum, int
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
-		int i;
-
 		if (poll(pfd, socknum, -1) < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
diff --git a/date.c b/date.c
index 66be23a..c792a90 100644
--- a/date.c
+++ b/date.c
@@ -42,7 +42,7 @@ static const char *weekday_names[] = {
  * thing, which means that tz -0100 is passed in as the integer -100,
  * even though it means "sixty minutes off"
  */
-static struct tm *time_to_tm(unsigned long time, int tz)
+static struct tm *time_to_tm(unsigned long unix_time, int tz)
 {
 	time_t t;
 	int minutes;
@@ -50,16 +50,16 @@ static struct tm *time_to_tm(unsigned lo
 	minutes = tz < 0 ? -tz : tz;
 	minutes = (minutes / 100)*60 + (minutes % 100);
 	minutes = tz < 0 ? -minutes : minutes;
-	t = time + minutes * 60;
+	t = unix_time + minutes * 60;
 	return gmtime(&t);
 }
 
-const char *show_date(unsigned long time, int tz)
+const char *show_date(unsigned long unix_time, int tz)
 {
 	struct tm *tm;
 	static char timebuf[200];
 
-	tm = time_to_tm(time, tz);
+	tm = time_to_tm(unix_time, tz);
 	if (!tm)
 		return NULL;
 	sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d %+05d",
@@ -71,12 +71,12 @@ const char *show_date(unsigned long time
 	return timebuf;
 }
 
-const char *show_rfc2822_date(unsigned long time, int tz)
+const char *show_rfc2822_date(unsigned long unix_time, int tz)
 {
 	struct tm *tm;
 	static char timebuf[200];
 
-	tm = time_to_tm(time, tz);
+	tm = time_to_tm(unix_time, tz);
 	if (!tm)
 		return NULL;
 	sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
@@ -335,8 +335,8 @@ static int match_digit(const char *date,
 	 * Seconds since 1970? We trigger on that for anything after Jan 1, 2000
 	 */
 	if (num > 946684800) {
-		time_t time = num;
-		if (gmtime_r(&time, tm)) {
+		time_t unix_time = num;
+		if (gmtime_r(&unix_time, tm)) {
 			*tm_gmt = 1;
 			return end - date;
 		}
@@ -632,13 +632,13 @@ static const char *approxidate_alpha(con
 	for (i = 0; i < 7; i++) {
 		int match = match_string(date, weekday_names[i]);
 		if (match >= 3) {
-			int diff, n = *num -1;
+			int diff, wk = *num -1;
 			*num = 0;
 
 			diff = tm->tm_wday - i;
 			if (diff <= 0)
-				n++;
-			diff += 7*n;
+				wk++;
+			diff += 7*wk;
 
 			update_tm(tm, diff * 24 * 60 * 60);
 			return end;
@@ -646,13 +646,13 @@ static const char *approxidate_alpha(con
 	}
 
 	if (match_string(date, "months") >= 5) {
-		int n = tm->tm_mon - *num;
+		int mo = tm->tm_mon - *num;
 		*num = 0;
-		while (n < 0) {
-			n += 12;
+		while (mo < 0) {
+			mo += 12;
 			tm->tm_year--;
 		}
-		tm->tm_mon = n;
+		tm->tm_mon = mo;
 		return end;
 	}
 
diff --git a/delta.h b/delta.h
index 7b3f86d..ae8cc47 100644
--- a/delta.h
+++ b/delta.h
@@ -21,7 +21,7 @@ create_delta_index(const void *buf, unsi
  *
  * Given pointer must be what create_delta_index() returned, or NULL.
  */
-extern void free_delta_index(struct delta_index *index);
+extern void free_delta_index(struct delta_index *);
 
 /*
  * create_delta: create a delta from given index for the given buffer
@@ -34,7 +34,7 @@ extern void free_delta_index(struct delt
  * must be freed by the caller.
  */
 extern void *
-create_delta(const struct delta_index *index,
+create_delta(const struct delta_index *,
 	     const void *buf, unsigned long bufsize,
 	     unsigned long *delta_size, unsigned long max_delta_size);
 
@@ -51,11 +51,11 @@ diff_delta(const void *src_buf, unsigned
 	   const void *trg_buf, unsigned long trg_bufsize,
 	   unsigned long *delta_size, unsigned long max_delta_size)
 {
-	struct delta_index *index = create_delta_index(src_buf, src_bufsize);
-	if (index) {
-		void *delta = create_delta(index, trg_buf, trg_bufsize,
+	struct delta_index *delta_index = create_delta_index(src_buf, src_bufsize);
+	if (delta_index) {
+		void *delta = create_delta(delta_index, trg_buf, trg_bufsize,
 					   delta_size, max_delta_size);
-		free_delta_index(index);
+		free_delta_index(delta_index);
 		return delta;
 	}
 	return NULL;
diff --git a/diff-delta.c b/diff-delta.c
index 7da9205..dbefc2b 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -139,7 +139,7 @@ struct delta_index * create_delta_index(
 {
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
-	struct delta_index *index;
+	struct delta_index *delta_index;
 	struct index_entry *entry, **hash;
 	void *mem;
 	unsigned long memsize;
@@ -157,27 +157,27 @@ struct delta_index * create_delta_index(
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*index) +
+	memsize = sizeof(*delta_index) +
 		  sizeof(*hash) * hsize +
 		  sizeof(*entry) * entries;
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
-	index = mem;
-	mem = index + 1;
+	delta_index = mem;
+	mem = delta_index + 1;
 	hash = mem;
 	mem = hash + hsize;
 	entry = mem;
 
-	index->src_buf = buf;
-	index->src_size = bufsize;
-	index->hash_mask = hmask;
+	delta_index->src_buf = buf;
+	delta_index->src_size = bufsize;
+	delta_index->hash_mask = hmask;
 	memset(hash, 0, hsize * sizeof(*hash));
 
 	/* allocate an array to count hash entries */
 	hash_count = calloc(hsize, sizeof(*hash_count));
 	if (!hash_count) {
-		free(index);
+		free(delta_index);
 		return NULL;
 	}
 
@@ -230,12 +230,12 @@ struct delta_index * create_delta_index(
 	}
 	free(hash_count);
 
-	return index;
+	return delta_index;
 }
 
-void free_delta_index(struct delta_index *index)
+void free_delta_index(struct delta_index *delta_index)
 {
-	free(index);
+	free(delta_index);
 }
 
 /*
@@ -245,7 +245,7 @@ void free_delta_index(struct delta_index
 #define MAX_OP_SIZE	(5 + 5 + 1 + RABIN_WINDOW + 7)
 
 void *
-create_delta(const struct delta_index *index,
+create_delta(const struct delta_index *delta_index,
 	     const void *trg_buf, unsigned long trg_size,
 	     unsigned long *delta_size, unsigned long max_size)
 {
@@ -266,7 +266,7 @@ create_delta(const struct delta_index *i
 		return NULL;
 
 	/* store reference buffer size */
-	i = index->src_size;
+	i = delta_index->src_size;
 	while (i >= 0x80) {
 		out[outpos++] = i | 0x80;
 		i >>= 7;
@@ -281,8 +281,8 @@ create_delta(const struct delta_index *i
 	}
 	out[outpos++] = i;
 
-	ref_data = index->src_buf;
-	ref_top = ref_data + index->src_size;
+	ref_data = delta_index->src_buf;
+	ref_top = ref_data + delta_index->src_size;
 	data = trg_buf;
 	top = (const unsigned char *) trg_buf + trg_size;
 
@@ -299,8 +299,8 @@ create_delta(const struct delta_index *i
 		struct index_entry *entry;
 		val ^= U[data[-RABIN_WINDOW]];
 		val = ((val << 8) | *data) ^ T[val >> RABIN_SHIFT];
-		i = val & index->hash_mask;
-		for (entry = index->hash[i]; entry; entry = entry->next) {
+		i = val & delta_index->hash_mask;
+		for (entry = delta_index->hash[i]; entry; entry = entry->next) {
 			const unsigned char *ref = entry->ptr;
 			const unsigned char *src = data;
 			unsigned int ref_size = ref_top - ref;
diff --git a/fetch-clone.c b/fetch-clone.c
index 81d1371..7eab54e 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -208,7 +208,7 @@ #define usec_to_binarymsec(x) ((int)(x) 
 
 int receive_keep_pack(int xd[2], const char *me, int quiet, int sideband)
 {
-	char tmpfile[PATH_MAX];
+	char tmp_file[PATH_MAX];
 	int ofd, ifd, fd[2];
 	unsigned long total;
 	static struct timeval prev_tv;
@@ -222,11 +222,11 @@ int receive_keep_pack(int xd[2], const c
 	setup_sideband(sideband, me, fd, xd);
 
 	ifd = fd[0];
-	snprintf(tmpfile, sizeof(tmpfile),
+	snprintf(tmp_file, sizeof(tmp_file),
 		 "%s/pack/tmp-XXXXXX", get_object_directory());
-	ofd = mkstemp(tmpfile);
+	ofd = mkstemp(tmp_file);
 	if (ofd < 0)
-		return error("unable to create temporary file %s", tmpfile);
+		return error("unable to create temporary file %s", tmp_file);
 
 	gettimeofday(&prev_tv, NULL);
 	total = 0;
@@ -242,7 +242,7 @@ int receive_keep_pack(int xd[2], const c
 			if (errno != EINTR && errno != EAGAIN) {
 				error("error reading pack (%s)", strerror(errno));
 				close(ofd);
-				unlink(tmpfile);
+				unlink(tmp_file);
 				return -1;
 			}
 			sz = 0;
@@ -254,7 +254,7 @@ int receive_keep_pack(int xd[2], const c
 				error("error writing pack (%s)",
 				      strerror(errno));
 				close(ofd);
-				unlink(tmpfile);
+				unlink(tmp_file);
 				return -1;
 			}
 			pos += wsz;
@@ -295,5 +295,5 @@ int receive_keep_pack(int xd[2], const c
 		}
 	}
 	close(ofd);
-	return finish_pack(tmpfile, me);
+	return finish_pack(tmp_file, me);
 }
diff --git a/fetch.c b/fetch.c
index aeb6bf2..d9cc155 100644
--- a/fetch.c
+++ b/fetch.c
@@ -48,9 +48,9 @@ static int process_tree(struct tree *tre
 		struct object *obj = NULL;
 
 		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(entry.sha1);
-			if (tree)
-				obj = &tree->object;
+			struct tree *subtree = lookup_tree(entry.sha1);
+			if (subtree)
+				obj = &subtree->object;
 		}
 		else {
 			struct blob *blob = lookup_blob(entry.sha1);
diff --git a/fsck-objects.c b/fsck-objects.c
index e167f41..8432f5b 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -579,7 +579,6 @@ int main(int argc, char **argv)
 	}
 
 	if (keep_cache_objects) {
-		int i;
 		read_cache();
 		for (i = 0; i < active_nr; i++) {
 			struct blob *blob = lookup_blob(active_cache[i]->sha1);
diff --git a/git.c b/git.c
index 7321d6c..876cdee 100644
--- a/git.c
+++ b/git.c
@@ -278,11 +278,11 @@ static void handle_internal_command(int 
 		if (p->prefix)
 			prefix = setup_git_directory();
 		if (getenv("GIT_TRACE")) {
-			int i;
+			int j;
 			fprintf(stderr, "trace: built-in: git");
-			for (i = 0; i < argc; ++i) {
+			for (j = 0; j < argc; j++) {
 				fputc(' ', stderr);
-				sq_quote_print(stderr, argv[i]);
+				sq_quote_print(stderr, argv[j]);
 			}
 			putc('\n', stderr);
 			fflush(stderr);
diff --git a/http-fetch.c b/http-fetch.c
index 1aad39b..b8a2ee4 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -425,7 +425,7 @@ static int fetch_index(struct alt_base *
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char *url;
-	char tmpfile[PATH_MAX];
+	char tmp_file[PATH_MAX];
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
@@ -444,8 +444,8 @@ static int fetch_index(struct alt_base *
 	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
 
 	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
+	snprintf(tmp_file, sizeof(tmp_file), "%s.temp", filename);
+	indexfile = fopen(tmp_file, "a");
 	if (!indexfile)
 		return error("Unable to open local file %s for pack index",
 			     filename);
@@ -485,7 +485,7 @@ static int fetch_index(struct alt_base *
 
 	fclose(indexfile);
 
-	return move_temp_to_file(tmpfile, filename);
+	return move_temp_to_file(tmp_file, filename);
 }
 
 static int setup_index(struct alt_base *repo, unsigned char *sha1)
@@ -966,7 +966,7 @@ static int fetch_pack(struct alt_base *r
 	struct packed_git **lst;
 	FILE *packfile;
 	char *filename;
-	char tmpfile[PATH_MAX];
+	char tmp_file[PATH_MAX];
 	int ret;
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
@@ -993,8 +993,8 @@ static int fetch_pack(struct alt_base *r
 		repo->base, sha1_to_hex(target->sha1));
 
 	filename = sha1_pack_name(target->sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	packfile = fopen(tmpfile, "a");
+	snprintf(tmp_file, sizeof(tmp_file), "%s.temp", filename);
+	packfile = fopen(tmp_file, "a");
 	if (!packfile)
 		return error("Unable to open local file %s for pack",
 			     filename);
@@ -1034,7 +1034,7 @@ static int fetch_pack(struct alt_base *r
 
 	fclose(packfile);
 
-	ret = move_temp_to_file(tmpfile, filename);
+	ret = move_temp_to_file(tmp_file, filename);
 	if (ret)
 		return ret;
 
@@ -1185,15 +1185,15 @@ static char *quote_ref_url(const char *b
 int fetch_ref(char *ref, unsigned char *sha1)
 {
         char *url;
-        char hex[42];
+        char ref_hex[42];
         struct buffer buffer;
 	const char *base = alt->base;
 	struct active_request_slot *slot;
 	struct slot_results results;
         buffer.size = 41;
         buffer.posn = 0;
-        buffer.buffer = hex;
-        hex[41] = '\0';
+        buffer.buffer = ref_hex;
+        ref_hex[41] = '\0';
 
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
@@ -1211,8 +1211,8 @@ int fetch_ref(char *ref, unsigned char *
 		return error("Unable to start request");
 	}
 
-        hex[40] = '\0';
-        get_sha1_hex(hex, sha1);
+        ref_hex[40] = '\0';
+        get_sha1_hex(ref_hex, sha1);
         return 0;
 }
 
diff --git a/http-push.c b/http-push.c
index 4021e7d..6bfba58 100644
--- a/http-push.c
+++ b/http-push.c
@@ -908,7 +908,7 @@ static int fetch_index(unsigned char *sh
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char *url;
-	char tmpfile[PATH_MAX];
+	char tmp_file[PATH_MAX];
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
@@ -944,8 +944,8 @@ static int fetch_index(unsigned char *sh
 	sprintf(url, "%sobjects/pack/pack-%s.idx", remote->url, hex);
 
 	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
+	snprintf(tmp_file, sizeof(tmp_file), "%s.temp", filename);
+	indexfile = fopen(tmp_file, "a");
 	if (!indexfile)
 		return error("Unable to open local file %s for pack index",
 			     filename);
@@ -990,7 +990,7 @@ static int fetch_index(unsigned char *sh
 	free(url);
 	fclose(indexfile);
 
-	return move_temp_to_file(tmpfile, filename);
+	return move_temp_to_file(tmp_file, filename);
 }
 
 static int setup_index(unsigned char *sha1)
@@ -1123,15 +1123,15 @@ static char *quote_ref_url(const char *b
 int fetch_ref(char *ref, unsigned char *sha1)
 {
         char *url;
-        char hex[42];
+        char ref_hex[42];
         struct buffer buffer;
 	char *base = remote->url;
 	struct active_request_slot *slot;
 	struct slot_results results;
         buffer.size = 41;
         buffer.posn = 0;
-        buffer.buffer = hex;
-        hex[41] = '\0';
+        buffer.buffer = ref_hex;
+        ref_hex[41] = '\0';
 
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
@@ -1149,17 +1149,17 @@ int fetch_ref(char *ref, unsigned char *
 		return error("Unable to start request");
 	}
 
-        hex[40] = '\0';
-        get_sha1_hex(hex, sha1);
+        ref_hex[40] = '\0';
+        get_sha1_hex(ref_hex, sha1);
         return 0;
 }
 
-static void one_remote_object(const char *hex)
+static void one_remote_object(const char *hex_name)
 {
 	unsigned char sha1[20];
 	struct object *obj;
 
-	if (get_sha1_hex(hex, sha1) != 0)
+	if (get_sha1_hex(hex_name, sha1) != 0)
 		return;
 
 	obj = lookup_object(sha1);
@@ -1614,11 +1614,11 @@ static void remote_ls(const char *path, 
 static void get_remote_object_list(unsigned char parent)
 {
 	char path[] = "objects/XX/";
-	static const char hex[] = "0123456789abcdef";
+	static const char lc_hex[] = "0123456789abcdef";
 	unsigned int val = parent;
 
-	path[8] = hex[val >> 4];
-	path[9] = hex[val & 0xf];
+	path[8] = lc_hex[val >> 4];
+	path[9] = lc_hex[val & 0xf];
 	remote_dir_exists[val] = 0;
 	remote_ls(path, (PROCESS_FILES | PROCESS_DIRS),
 		  process_ls_object, &val);
diff --git a/merge-tree.c b/merge-tree.c
index 7cf00be..cd932a1 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -128,10 +128,10 @@ static void show_result_list(struct merg
 {
 	printf("%s\n", explanation(entry));
 	do {
-		struct merge_list *link = entry->link;
+		struct merge_list *lnk = entry->link;
 		static const char *desc[4] = { "result", "base", "our", "their" };
 		printf("  %-6s %o %s %s\n", desc[entry->stage], entry->mode, sha1_to_hex(entry->blob->object.sha1), entry->path);
-		entry = link;
+		entry = lnk;
 	} while (entry);
 }
 
@@ -168,7 +168,7 @@ static struct merge_list *create_entry(u
 	return res;
 }
 
-static void resolve(const char *base, struct name_entry *branch1, struct name_entry *result)
+static void resolve(const char *base, struct name_entry *branch1, struct name_entry *res)
 {
 	struct merge_list *orig, *final;
 	const char *path;
@@ -177,9 +177,9 @@ static void resolve(const char *base, st
 	if (!branch1)
 		return;
 
-	path = strdup(mkpath("%s%s", base, result->path));
+	path = strdup(mkpath("%s%s", base, res->path));
 	orig = create_entry(2, branch1->mode, branch1->sha1, path);
-	final = create_entry(0, result->mode, result->sha1, path);
+	final = create_entry(0, res->mode, res->sha1, path);
 
 	final->link = orig;
 
@@ -226,7 +226,7 @@ static int unresolved_directory(const ch
 static struct merge_list *link_entry(unsigned stage, const char *base, struct name_entry *n, struct merge_list *entry)
 {
 	const char *path;
-	struct merge_list *link;
+	struct merge_list *lnk;
 
 	if (!n->mode)
 		return entry;
@@ -234,9 +234,9 @@ static struct merge_list *link_entry(uns
 		path = entry->path;
 	else
 		path = strdup(mkpath("%s%s", base, n->path));
-	link = create_entry(stage, n->mode, n->sha1, path);
-	link->link = entry;
-	return link;
+	lnk = create_entry(stage, n->mode, n->sha1, path);
+	lnk->link = entry;
+	return lnk;
 }
 
 static void unresolved(const char *base, struct name_entry n[3])
diff --git a/pack-check.c b/pack-check.c
index 3a62e1b..2188382 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -41,7 +41,6 @@ static int verify_packfile(struct packed
 	 * we do not do scan-streaming check on the pack file.
 	 */
 	for (i = err = 0; i < nr_objects; i++) {
-		unsigned char sha1[20];
 		struct pack_entry e;
 		void *data;
 		char type[20];
diff --git a/pack-objects.c b/pack-objects.c
index 861c7f0..f13dc74 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -153,11 +153,11 @@ static void prepare_pack_revindex(struct
 	struct packed_git *p = rix->p;
 	int num_ent = num_packed_objects(p);
 	int i;
-	void *index = p->index_base + 256;
+	void *idx = p->index_base + 256;
 
 	rix->revindex = xmalloc(sizeof(unsigned long) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
-		unsigned int hl = *((unsigned int *)((char *) index + 24*i));
+		unsigned int hl = *((unsigned int *)((char *) idx + 24*i));
 		rix->revindex[i] = ntohl(hl);
 	}
 	/* This knows the pack format -- the 20-byte trailer
@@ -682,18 +682,18 @@ static void add_pbase_object(struct tree
 		}
 		if (!strcmp(type, tree_type)) {
 			struct tree_desc sub;
-			struct pbase_tree_cache *tree;
+			struct pbase_tree_cache *subtree;
 			const char *down = name+cmplen+1;
 			int downlen = name_cmp_len(down);
 
-			tree = pbase_tree_get(entry.sha1);
-			if (!tree)
+			subtree = pbase_tree_get(entry.sha1);
+			if (!subtree)
 				return;
-			sub.buf = tree->tree_data;
-			sub.size = tree->tree_size;
+			sub.buf = subtree->tree_data;
+			sub.size = subtree->tree_size;
 
 			add_pbase_object(&sub, down, downlen, fullname);
-			pbase_tree_put(tree);
+			pbase_tree_put(subtree);
 		}
 	}
 }
@@ -1058,10 +1058,10 @@ static void progress_interval(int signum
 	progress_update = 1;
 }
 
-static void find_deltas(struct object_entry **list, int window, int depth)
+static void find_deltas(struct object_entry **list, int win, int depth)
 {
 	int i, idx;
-	unsigned int array_size = window * sizeof(struct unpacked);
+	unsigned int array_size = win * sizeof(struct unpacked);
 	struct unpacked *array = xmalloc(array_size);
 	unsigned processed = 0;
 	unsigned last_percent = 999;
@@ -1104,12 +1104,12 @@ static void find_deltas(struct object_en
 		n->data = NULL;
 		n->entry = entry;
 
-		j = window;
+		j = win;
 		while (--j > 0) {
 			unsigned int other_idx = idx + j;
 			struct unpacked *m;
-			if (other_idx >= window)
-				other_idx -= window;
+			if (other_idx >= win)
+				other_idx -= win;
 			m = array + other_idx;
 			if (!m->entry)
 				break;
@@ -1124,26 +1124,26 @@ static void find_deltas(struct object_en
 			continue;
 
 		idx++;
-		if (idx >= window)
+		if (idx >= win)
 			idx = 0;
 	}
 
 	if (progress)
 		fputc('\n', stderr);
 
-	for (i = 0; i < window; ++i) {
+	for (i = 0; i < win; ++i) {
 		free_delta_index(array[i].index);
 		free(array[i].data);
 	}
 	free(array);
 }
 
-static void prepare_pack(int window, int depth)
+static void prepare_pack(int win, int depth)
 {
 	get_object_details();
 	sorted_by_type = create_sorted_list(type_size_sort);
-	if (window && depth)
-		find_deltas(sorted_by_type, window+1, depth);
+	if (win && depth)
+		find_deltas(sorted_by_type, win+1, depth);
 }
 
 static int reuse_cached_pack(unsigned char *sha1, int pack_to_stdout)
diff --git a/path-list.c b/path-list.c
index f15a10d..38aac10 100644
--- a/path-list.c
+++ b/path-list.c
@@ -30,36 +30,36 @@ static int get_entry_index(const struct 
 static int add_entry(struct path_list *list, const char *path)
 {
 	int exact_match;
-	int index = get_entry_index(list, path, &exact_match);
+	int idx = get_entry_index(list, path, &exact_match);
 
 	if (exact_match)
-		return -1 - index;
+		return -1 - idx;
 
 	if (list->nr + 1 >= list->alloc) {
 		list->alloc += 32;
 		list->items = xrealloc(list->items, list->alloc
 				* sizeof(struct path_list_item));
 	}
-	if (index < list->nr)
-		memmove(list->items + index + 1, list->items + index,
-				(list->nr - index)
+	if (idx < list->nr)
+		memmove(list->items + idx + 1, list->items + idx,
+				(list->nr - idx)
 				* sizeof(struct path_list_item));
-	list->items[index].path = list->strdup_paths ?
+	list->items[idx].path = list->strdup_paths ?
 		strdup(path) : (char *)path;
-	list->items[index].util = NULL;
+	list->items[idx].util = NULL;
 	list->nr++;
 
-	return index;
+	return idx;
 }
 
 struct path_list_item *path_list_insert(const char *path, struct path_list *list)
 {
-	int index = add_entry(list, path);
+	int idx = add_entry(list, path);
 
-	if (index < 0)
-		index = 1 - index;
+	if (idx < 0)
+		idx = 1 - idx;
 
-	return list->items + index;
+	return list->items + idx;
 }
 
 int path_list_has_path(const struct path_list *list, const char *path)
diff --git a/revision.c b/revision.c
index a58257a..225913b 100644
--- a/revision.c
+++ b/revision.c
@@ -82,7 +82,7 @@ void mark_parents_uninteresting(struct c
 	struct commit_list *parents = commit->parents;
 
 	while (parents) {
-		struct commit *commit = parents->item;
+		commit = parents->item;
 		if (!(commit->object.flags & UNINTERESTING)) {
 			commit->object.flags |= UNINTERESTING;
 
diff --git a/setup.c b/setup.c
index 358e139..62d77df 100644
--- a/setup.c
+++ b/setup.c
@@ -162,7 +162,7 @@ const char *setup_git_directory_gently(i
 	 */
 	if (getenv(GIT_DIR_ENVIRONMENT)) {
 		char path[PATH_MAX];
-		int len = strlen(getenv(GIT_DIR_ENVIRONMENT));
+		len = strlen(getenv(GIT_DIR_ENVIRONMENT));
 		if (sizeof(path) - 40 < len)
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
 		memcpy(path, getenv(GIT_DIR_ENVIRONMENT), len);
diff --git a/sha1_file.c b/sha1_file.c
index 43bc2ea..08ddf7a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -382,7 +382,7 @@ static int check_packed_git_idx(const ch
 				void **idx_map_)
 {
 	void *idx_map;
-	unsigned int *index;
+	unsigned int *idx;
 	unsigned long idx_size;
 	int nr, i;
 	int fd = open(path, O_RDONLY);
@@ -399,7 +399,7 @@ static int check_packed_git_idx(const ch
 	if (idx_map == MAP_FAILED)
 		return -1;
 
-	index = idx_map;
+	idx = idx_map;
 	*idx_map_ = idx_map;
 	*idx_size_ = idx_size;
 
@@ -408,7 +408,7 @@ static int check_packed_git_idx(const ch
 		return error("index file too small");
 	nr = 0;
 	for (i = 0; i < 256; i++) {
-		unsigned int n = ntohl(index[i]);
+		unsigned int n = ntohl(idx[i]);
 		if (n < nr)
 			return error("non-monotonic index");
 		nr = n;
@@ -689,7 +689,7 @@ static int unpack_sha1_header(z_stream *
 	unsigned char c;
 	unsigned int word, bits;
 	unsigned long size;
-	static const char *typename[8] = {
+	static const char *type_check[8] = {
 		NULL,	/* OBJ_EXT */
 		"commit", "tree", "blob", "tag",
 		NULL, NULL, NULL
@@ -716,7 +716,7 @@ static int unpack_sha1_header(z_stream *
 
 	c = *map++;
 	mapsize--;
-	type = typename[(c >> 4) & 7];
+	type = type_check[(c >> 4) & 7];
 	if (!type)
 		return -1;
 
@@ -1180,10 +1180,10 @@ int num_packed_objects(const struct pack
 int nth_packed_object_sha1(const struct packed_git *p, int n,
 			   unsigned char* sha1)
 {
-	void *index = p->index_base + 256;
+	void *idx = p->index_base + 256;
 	if (n < 0 || num_packed_objects(p) <= n)
 		return -1;
-	memcpy(sha1, (char *) index + (24 * n) + 4, 20);
+	memcpy(sha1, (char *) idx + (24 * n) + 4, 20);
 	return 0;
 }
 
@@ -1193,13 +1193,13 @@ int find_pack_entry_one(const unsigned c
 	unsigned int *level1_ofs = p->index_base;
 	int hi = ntohl(level1_ofs[*sha1]);
 	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
-	void *index = p->index_base + 256;
+	void *idx = p->index_base + 256;
 
 	do {
 		int mi = (lo + hi) / 2;
-		int cmp = memcmp((char *) index + (24 * mi) + 4, sha1, 20);
+		int cmp = memcmp((char *) idx + (24 * mi) + 4, sha1, 20);
 		if (!cmp) {
-			e->offset = ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
+			e->offset = ntohl(*((unsigned int *) ((char *) idx + (24 * mi))));
 			memcpy(e->sha1, sha1, 20);
 			e->p = p;
 			return 1;
@@ -1376,12 +1376,12 @@ char *write_sha1_file_prepare(void *buf,
  *
  * Returns the errno on failure, 0 on success.
  */
-static int link_temp_to_file(const char *tmpfile, char *filename)
+static int link_temp_to_file(const char *tmp_file, char *filename)
 {
 	int ret;
 	char *dir;
 
-	if (!link(tmpfile, filename))
+	if (!link(tmp_file, filename))
 		return 0;
 
 	/*
@@ -1399,7 +1399,7 @@ static int link_temp_to_file(const char 
 		if (adjust_shared_perm(filename))
 			return -2;
 		*dir = '/';
-		if (!link(tmpfile, filename))
+		if (!link(tmp_file, filename))
 			return 0;
 		ret = errno;
 	}
@@ -1409,9 +1409,9 @@ static int link_temp_to_file(const char 
 /*
  * Move the just written object into its final resting place
  */
-int move_temp_to_file(const char *tmpfile, char *filename)
+int move_temp_to_file(const char *tmp_file, char *filename)
 {
-	int ret = link_temp_to_file(tmpfile, filename);
+	int ret = link_temp_to_file(tmp_file, filename);
 
 	/*
 	 * Coda hack - coda doesn't like cross-directory links,
@@ -1425,11 +1425,11 @@ int move_temp_to_file(const char *tmpfil
 	 * left to unlink.
 	 */
 	if (ret && ret != EEXIST) {
-		if (!rename(tmpfile, filename))
+		if (!rename(tmp_file, filename))
 			return 0;
 		ret = errno;
 	}
-	unlink(tmpfile);
+	unlink(tmp_file);
 	if (ret) {
 		if (ret != EEXIST) {
 			fprintf(stderr, "unable to write sha1 filename %s: %s\n", filename, strerror(ret));
@@ -1510,7 +1510,7 @@ int write_sha1_file(void *buf, unsigned 
 	z_stream stream;
 	unsigned char sha1[20];
 	char *filename;
-	static char tmpfile[PATH_MAX];
+	static char tmp_file[PATH_MAX];
 	unsigned char hdr[50];
 	int fd, hdrlen;
 
@@ -1537,11 +1537,11 @@ int write_sha1_file(void *buf, unsigned 
 		return -1;
 	}
 
-	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+	snprintf(tmp_file, sizeof(tmp_file), "%s/obj_XXXXXX", get_object_directory());
 
-	fd = mkstemp(tmpfile);
+	fd = mkstemp(tmp_file);
 	if (fd < 0) {
-		fprintf(stderr, "unable to create temporary sha1 filename %s: %s\n", tmpfile, strerror(errno));
+		fprintf(stderr, "unable to create temporary sha1 filename %s: %s\n", tmp_file, strerror(errno));
 		return -1;
 	}
 
@@ -1574,7 +1574,7 @@ int write_sha1_file(void *buf, unsigned 
 	close(fd);
 	free(compressed);
 
-	return move_temp_to_file(tmpfile, filename);
+	return move_temp_to_file(tmp_file, filename);
 }
 
 /*
@@ -1646,7 +1646,7 @@ int write_sha1_to_fd(int fd, const unsig
 int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 		       size_t bufsize, size_t *bufposn)
 {
-	char tmpfile[PATH_MAX];
+	char tmp_file[PATH_MAX];
 	int local;
 	z_stream stream;
 	unsigned char real_sha1[20];
@@ -1654,12 +1654,12 @@ int write_sha1_from_fd(const unsigned ch
 	int ret;
 	SHA_CTX c;
 
-	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+	snprintf(tmp_file, sizeof(tmp_file), "%s/obj_XXXXXX", get_object_directory());
 
-	local = mkstemp(tmpfile);
+	local = mkstemp(tmp_file);
 	if (local < 0)
 		return error("Couldn't open %s for %s",
-			     tmpfile, sha1_to_hex(sha1));
+			     tmp_file, sha1_to_hex(sha1));
 
 	memset(&stream, 0, sizeof(stream));
 
@@ -1690,7 +1690,7 @@ int write_sha1_from_fd(const unsigned ch
 		size = read(fd, buffer + *bufposn, bufsize - *bufposn);
 		if (size <= 0) {
 			close(local);
-			unlink(tmpfile);
+			unlink(tmp_file);
 			if (!size)
 				return error("Connection closed?");
 			perror("Reading from connection");
@@ -1703,15 +1703,15 @@ int write_sha1_from_fd(const unsigned ch
 	close(local);
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
-		unlink(tmpfile);
+		unlink(tmp_file);
 		return error("File %s corrupted", sha1_to_hex(sha1));
 	}
 	if (memcmp(sha1, real_sha1, 20)) {
-		unlink(tmpfile);
+		unlink(tmp_file);
 		return error("File %s has bad hash", sha1_to_hex(sha1));
 	}
 
-	return move_temp_to_file(tmpfile, sha1_file_name(sha1));
+	return move_temp_to_file(tmp_file, sha1_file_name(sha1));
 }
 
 int has_pack_index(const unsigned char *sha1)
diff --git a/tree-walk.c b/tree-walk.c
index 3f83e98..9033c94 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -113,7 +113,7 @@ void traverse_trees(int n, struct tree_d
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 
 	for (;;) {
-		struct name_entry entry[3];
+		struct name_entry ent[3];
 		unsigned long mask = 0;
 		int i, last;
 
@@ -121,9 +121,9 @@ void traverse_trees(int n, struct tree_d
 		for (i = 0; i < n; i++) {
 			if (!t[i].size)
 				continue;
-			entry_extract(t+i, entry+i);
+			entry_extract(t+i, ent+i);
 			if (last >= 0) {
-				int cmp = entry_compare(entry+i, entry+last);
+				int cmp = entry_compare(ent+i, ent+last);
 
 				/*
 				 * Is the new name bigger than the old one?
@@ -153,9 +153,9 @@ void traverse_trees(int n, struct tree_d
 				update_tree_entry(t+i);
 				continue;
 			}
-			entry_clear(entry + i);
+			entry_clear(ent + i);
 		}
-		callback(n, mask, entry, base);
+		callback(n, mask, ent, base);
 	}
 	free(entry);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 1be7b31..4fa55bd 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -145,7 +145,7 @@ static int xdl_prepare_ctx(mmfile_t *mf,
 	xrecord_t **rhash;
 	unsigned long *ha;
 	char *rchg;
-	long *rindex;
+	long *r_idx;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0) {
 
@@ -220,7 +220,7 @@ static int xdl_prepare_ctx(mmfile_t *mf,
 	}
 	memset(rchg, 0, (nrec + 2) * sizeof(char));
 
-	if (!(rindex = (long *) xdl_malloc((nrec + 1) * sizeof(long)))) {
+	if (!(r_idx = (long *) xdl_malloc((nrec + 1) * sizeof(long)))) {
 
 		xdl_free(rchg);
 		xdl_free(rhash);
@@ -230,7 +230,7 @@ static int xdl_prepare_ctx(mmfile_t *mf,
 	}
 	if (!(ha = (unsigned long *) xdl_malloc((nrec + 1) * sizeof(unsigned long)))) {
 
-		xdl_free(rindex);
+		xdl_free(r_idx);
 		xdl_free(rchg);
 		xdl_free(rhash);
 		xdl_free(recs);
@@ -243,7 +243,7 @@ static int xdl_prepare_ctx(mmfile_t *mf,
 	xdf->hbits = hbits;
 	xdf->rhash = rhash;
 	xdf->rchg = rchg + 1;
-	xdf->rindex = rindex;
+	xdf->rindex = r_idx;
 	xdf->nreff = 0;
 	xdf->ha = ha;
 	xdf->dstart = 0;
-- 
1.4.2.rc2.gfbfdd
