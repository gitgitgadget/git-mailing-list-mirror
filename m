From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 03/12] add the basic data structure for line level history
Date: Sat, 26 Jun 2010 06:27:28 -0700
Message-ID: <1277558857-23103-4-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:28:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVQX-0007lB-R6
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab0FZN17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:27:59 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36015 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454Ab0FZN15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:27:57 -0400
Received: by pxi8 with SMTP id 8so1126863pxi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bnRLH49MxQftF88eEY+CGf4PaPLfcIiiVhbDEUnMyZY=;
        b=BaP3kr02eeiwv28lbfc2ID4Lraf0R/TZ1vjuXid3CsBdIYpd5SQH5MCsEWH4+GfwXG
         ArIoWmLiQQnxooK2r7J0iR9Mce0ghiMErselgD+Ww031Ztvv8miAOWB7/+YutI19wn0l
         Yizc7S33NVZPB+b943nJwCsP/KMeb9lYYXXn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MDcUhJ/ZetGFe8zCgztYEd7y0y7XEuuuM1NtbqwCPIGKzgPOfzcP8evCddnG+DyVRN
         inXjOinj8n9wtDUvlGm/O/TCR2sIFiKHDAN2PTm4Zcf9nQDApv+la5tqgM3ziPUApH7W
         jinsgrPX/hw2mwkgFXp91MOoYntT9309TVp+c=
Received: by 10.142.250.30 with SMTP id x30mr1368238wfh.180.1277558875918;
        Sat, 26 Jun 2010 06:27:55 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.27.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:27:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149745>

'struct diff_line_range' is the main data structure to store
the user interesting line range. There is one 'diff_line_range'
for each file, and there are multiple 'struct range' in each
'diff_line_range'. In this way, we support multiple ranges.

Within 'struct range', there are multiple 'struct print_range'
which represent a diff chunk.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Makefile   |    2 +
 diffcore.h |    3 +
 line.c     |  453 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h     |  122 ++++++++++++++++
 revision.c |   13 ++-
 revision.h |    9 +-
 6 files changed, 597 insertions(+), 5 deletions(-)
 create mode 100644 line.c
 create mode 100644 line.h

diff --git a/Makefile b/Makefile
index 1fadd43..0183a21 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,7 @@ LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += help.h
 LIB_H += levenshtein.h
+LIB_H += line.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
@@ -582,6 +583,7 @@ LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
 LIB_OBJS += levenshtein.o
+LIB_OBJS += line.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
diff --git a/diffcore.h b/diffcore.h
index 491bea0..06a6934 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -23,6 +23,7 @@
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
 struct userdiff_driver;
+struct diff_options;
 
 struct diff_filespec {
 	unsigned char sha1[20];
@@ -51,6 +52,8 @@ struct diff_filespec {
 	int is_binary;
 };
 
+#define FILESPEC_VALID(f) (f)->sha1_valid
+
 extern struct diff_filespec *alloc_filespec(const char *);
 extern void free_filespec(struct diff_filespec *);
 extern void fill_filespec(struct diff_filespec *, const unsigned char *,
diff --git a/line.c b/line.c
new file mode 100644
index 0000000..7b7f3f3
--- /dev/null
+++ b/line.c
@@ -0,0 +1,453 @@
+#include "line.h"
+#include "cache.h"
+#include "tag.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "diff.h"
+#include "decorate.h"
+#include "revision.h"
+#include "xdiff-interface.h"
+#include "strbuf.h"
+#include "log-tree.h"
+
+static void cleanup(struct diff_line_range *r)
+{
+	while (r) {
+		struct diff_line_range *tmp = r->next;
+		DIFF_LINE_RANGE_CLEAR(r);
+		free(r);
+		r = tmp;
+	}
+}
+
+static struct object *find_commit(struct rev_info *revs)
+{
+	struct object *commit = NULL;
+	const char *name = NULL;
+	int i;
+
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (obj->flags & UNINTERESTING)
+			continue;
+		while (obj->type == OBJ_TAG)
+			obj = deref_tag(obj, NULL, 0);
+		if (obj->type != OBJ_COMMIT)
+			die("Non commit %s?", revs->pending.objects[i].name);
+		if (commit)
+			die("More than one commit to dig from: %s and %s?",
+			    revs->pending.objects[i].name, name);
+		commit = obj;
+		name = revs->pending.objects[i].name;
+	}
+
+	return commit;
+}
+
+static void fill_blob_sha1(struct commit *commit, struct diff_line_range *r)
+{
+	unsigned mode;
+	unsigned char sha1[20];
+
+	while (r) {
+		if (get_tree_entry(commit->object.sha1, r->spec->path,
+			sha1, &mode))
+			goto error;
+		fill_filespec(r->spec, sha1, mode);
+		r = r->next;
+	}
+
+	return ;
+error:
+	die("There is no path %s in the commit", r->spec->path);
+}
+
+static void make_line_log_file(struct diff_filespec *spec, int *lines, int **line_ends)
+{
+	int num = 0, size = 50, cur = 0;
+	int *ends = NULL;
+	char *data = NULL;
+
+	if (diff_populate_filespec(spec, 0))
+		die("Cannot read blob %s", sha1_to_hex(spec->sha1));
+
+	ends = xmalloc(size * sizeof(int));
+	ends[cur++] = -1;
+	data = spec->data;
+	while (num < spec->size) {
+		if (data[num] == '\n' || num == spec->size - 1) {
+			if (cur >= size) {
+				size = size * 2;
+				ends = xrealloc(ends, size * sizeof(int));
+			}
+			ends[cur++] = num;
+		}
+		num ++;
+	}
+
+	/* shrink the array to fit the elements */
+	ends = xrealloc(ends, cur * sizeof(int));
+	*lines = cur;
+	*line_ends = ends;
+}
+
+static const char *nth_line(struct diff_filespec *spec, int line, int lines, int *line_ends)
+{
+	assert(line < lines);
+	assert(spec && spec->data);
+
+	return (char *)spec->data + line_ends[line] + 1;
+}
+
+/*
+ * copied from blame.c, indeed, we can even to use this to test
+ * whether line log works. :)
+ */
+static const char *parse_loc(const char *spec, struct diff_filespec *file,
+			     int lines, int *line_ends,
+			     long begin, long *ret)
+{
+	char *term;
+	const char *line;
+	long num;
+	int reg_error;
+	regex_t regexp;
+	regmatch_t match[1];
+
+	/* Allow "-L <something>,+20" to mean starting at <something>
+	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
+	 * <something>.
+	 */
+	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
+		num = strtol(spec + 1, &term, 10);
+		if (term != spec + 1) {
+			if (spec[0] == '-')
+				num = 0 - num;
+			if (0 < num)
+				*ret = begin + num - 2;
+			else if (!num)
+				*ret = begin;
+			else
+				*ret = begin + num;
+			return term;
+		}
+		return spec;
+	}
+	num = strtol(spec, &term, 10);
+	if (term != spec) {
+		*ret = num;
+		return term;
+	}
+	if (spec[0] != '/')
+		return spec;
+
+	/* it could be a regexp of form /.../ */
+	for (term = (char *) spec + 1; *term && *term != '/'; term++) {
+		if (*term == '\\')
+			term++;
+	}
+	if (*term != '/')
+		return spec;
+
+	/* try [spec+1 .. term-1] as regexp */
+	*term = 0;
+	begin--; /* input is in human terms */
+	line = nth_line(file, begin, lines, line_ends);
+
+	if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
+	    !(reg_error = regexec(&regexp, line, 1, match, 0))) {
+		const char *cp = line + match[0].rm_so;
+		const char *nline;
+
+		while (begin++ < lines) {
+			nline = nth_line(file, begin, lines, line_ends);
+			if (line <= cp && cp < nline)
+				break;
+			line = nline;
+		}
+		*ret = begin;
+		regfree(&regexp);
+		*term++ = '/';
+		return term;
+	}
+	else {
+		char errbuf[1024];
+		regerror(reg_error, &regexp, errbuf, 1024);
+		die("-L parameter '%s': %s", spec + 1, errbuf);
+	}
+}
+
+static void parse_range(int lines, int *line_ends, struct range *r, struct diff_filespec *spec)
+{
+	const char *term;
+
+	term = parse_loc(r->arg, spec, lines, line_ends, 1, &r->start);
+	if (*term == ',') {
+		term = parse_loc(term + 1, spec, lines, line_ends,
+			r->start + 1, &r->end);
+		if (*term) {
+			die("-L parameter's argument should be <start>,<end>");
+		}
+	}
+
+	if (*term) {
+		die("-L parameter's argument should be <start>,<end>");
+	}
+
+	if (r->start > r->end) {
+		long tmp = r->start;
+		r->start = r->end;
+		r->end = tmp;
+	}
+
+	if (r->start < 1)
+		r->start = 1;
+	if (r->end >= lines)
+		r->end = lines - 1;
+}
+
+static void parse_lines(struct commit *commit, struct diff_line_range *r)
+{
+	int i;
+	struct range *rg = NULL;
+	int lines = 0;
+	int *ends = NULL;
+
+	while (r) {
+		struct diff_filespec *spec = r->spec;
+		int num = r->nr;
+		assert(spec);
+		fill_blob_sha1(commit, r);
+		rg = r->ranges;
+		r->ranges = NULL;
+		r->nr = r->alloc = 0;
+		make_line_log_file(spec, &lines, &ends);
+		for (i = 0; i < num; i++) {
+			parse_range(lines, ends, rg + i, spec);
+			diff_line_range_insert(r, rg[i].arg, rg[i].start, rg[i].end);
+		}
+
+		if (ends != NULL) {
+			free(ends);
+			ends = NULL;
+		}
+
+		r = r->next;
+		/* release the memory of old array */
+		free(rg);
+	}
+}
+
+/*
+ * Insert a new line range into a diff_line_range struct, and keep the
+ * r->ranges sorted by their starting line number.
+ */
+struct range *diff_line_range_insert(struct diff_line_range *r, const char *arg,
+				int start, int end)
+{
+	assert(r != NULL);
+	assert(start <= end);
+
+	int i = 0;
+	struct range *rs = r->ranges;
+	int left_extend = 0, right_extend = 0;
+
+	if (r->nr == 0 || rs[r->nr - 1].end < start - 1) {
+		DIFF_LINE_RANGE_GROW(r);
+		rs = r->ranges;
+		int num = r->nr - 1;
+		rs[num].arg = arg;
+		rs[num].start = start;
+		rs[num].end = end;
+		return rs + num;
+	}
+
+	for (; i < r->nr; i++) {
+		if (rs[i].end < start - 1)
+			continue;
+		if (rs[i].end == start - 1) {
+			rs[i].end = end;
+			right_extend = 1;
+			goto out;
+		}
+
+		assert(rs[i].end > start - 1);
+		if (rs[i].start <= start) {
+			if (rs[i].end < end) {
+				rs[i].end = end;
+				right_extend = 1;
+			}
+			goto out;
+		} else if (rs[i].start <= end + 1) {
+			rs[i].start = start;
+			left_extend = 1;
+			if (rs[i].end < end) {
+				rs[i].end = end;
+				right_extend = 1;
+			}
+			goto out;
+		} else {
+			int num = r->nr - i;
+			DIFF_LINE_RANGE_GROW(r);
+			rs = r->ranges;
+			memmove(rs + i + 1, rs + i, num * sizeof(struct range));
+			rs[i].arg = arg;
+			rs[i].start = start;
+			rs[i].end = end;
+			goto out;
+		}
+	}
+
+out:
+	assert(r->nr != i);
+	if (left_extend) {
+		int j = i;
+		for (; j > -1; j--) {
+			if (rs[j].end >= rs[i].start - 1)
+				if (rs[j].start < rs[i].start)
+					rs[i].start = rs[j].start;
+		}
+		memmove(rs + j + 1, rs + i, (r->nr - i) * sizeof(struct range));
+		r->nr -= i - j - 1;
+	}
+	if (right_extend) {
+		int j = i;
+		for (; j < r->nr; j++) {
+			if (rs[j].start <= rs[i].end + 1)
+				if (rs[j].end > rs[i].end)
+					rs[i].end = rs[j].end;
+		}
+		if (j < r->nr) {
+			memmove(rs + i + 1, rs + j, (r->nr - j) * sizeof(struct range));
+		}
+		r->nr -= j - i - 1;
+	}
+	assert(r->nr);
+
+	return rs + i;
+}
+
+void diff_line_range_clear(struct diff_line_range *r)
+{
+	int i = 0, zero = 0;
+
+	for (; i < r->nr; i++) {
+		struct range *rg = r->ranges + i;
+		RANGE_CLEAR(rg);
+	}
+
+	if (r->prev) {
+		zero = 0;
+		if (r->prev->count == 1) {
+			zero = 1;
+		}
+		free_filespec(r->prev);
+		if (zero)
+			r->prev = NULL;
+	}
+	if (r->spec) {
+		zero = 0;
+		if (r->spec->count == 1) {
+			zero = 1;
+		}
+		free_filespec(r->spec);
+		if (zero)
+			r->spec = NULL;
+	}
+
+	r->status = '\0';
+	r->alloc = r->nr = 0;
+
+	if (r->ranges)
+		free(r->ranges);
+	r->ranges = NULL;
+}
+
+void diff_line_range_append(struct diff_line_range *r, const char *arg)
+{
+	DIFF_LINE_RANGE_GROW(r);
+	r->ranges[r->nr - 1].arg = arg;
+}
+
+struct diff_line_range *diff_line_range_merge(struct diff_line_range *out,
+	struct diff_line_range *other)
+{
+	struct diff_line_range *one = out, *two = other;
+	struct diff_line_range *pone;
+
+	while (one) {
+		struct diff_line_range *prev;
+		two = other;
+		prev = other;
+		while (two) {
+			if (!strcmp(one->spec->path, two->spec->path)) {
+				int i = 0;
+				for (; i < two->nr; i++) {
+					diff_line_range_insert(one, NULL,
+						two->ranges[i].start,
+						two->ranges[i].end);
+				}
+				if (prev == other) {
+					other = other->next;
+				} else {
+					prev->next = two->next;
+				}
+				DIFF_LINE_RANGE_CLEAR(two);
+				free(two);
+				two = NULL;
+
+				break;
+			}
+
+			prev = two;
+			two = two->next;
+		}
+
+		pone = one;
+		one = one->next;
+	}
+	pone->next = other;
+
+	return out;
+}
+
+void add_line_range(struct rev_info *revs, struct commit *commit, struct diff_line_range *r)
+{
+	struct diff_line_range *ret = NULL;
+
+	if (r != NULL) {
+		ret = lookup_decoration(&revs->line_range, &commit->object);
+		if (ret != NULL) {
+			diff_line_range_merge(ret, r);
+		} else {
+			add_decoration(&revs->line_range, &commit->object, r);
+		}
+		commit->object.flags |= RANGE_UPDATE;
+	}
+}
+
+struct diff_line_range *lookup_line_range(struct rev_info *revs, struct commit *commit)
+{
+	struct diff_line_range *ret = NULL;
+
+	ret = lookup_decoration(&revs->line_range, &commit->object);
+	return ret;
+}
+
+void setup_line(struct rev_info *rev, struct diff_line_range *r)
+{
+	struct commit *commit = NULL;
+	struct diff_options *opt = &rev->diffopt;
+
+	commit = (struct commit *)find_commit(rev);
+	parse_lines(commit, r);
+
+	add_line_range(rev, commit, r);
+	/*
+	 * Note we support -M/-C to detect file rename
+	 */
+	opt->nr_paths = 0;
+	diff_tree_release_paths(opt);
+}
+
diff --git a/line.h b/line.h
new file mode 100644
index 0000000..a2f8545
--- /dev/null
+++ b/line.h
@@ -0,0 +1,122 @@
+#ifndef LINE_H
+#define LINE_H
+
+#include "diffcore.h"
+
+struct rev_info;
+struct commit;
+struct diff_line_range;
+struct diff_options;
+
+struct print_range {
+	int start, end;
+	int pstart, pend;
+	int line_added : 1;
+};
+
+struct print_pair {
+	int alloc, nr;
+	struct print_range *ranges;
+};
+
+#define PRINT_RANGE_INIT(r) \
+	do { \
+		(r)->line_added = 0; \
+	} while(0);
+
+#define PRINT_PAIR_INIT(p) \
+	do { \
+		(p)->alloc = (p)->nr = 0; \
+		(p)->ranges = NULL; \
+	} while(0);
+
+#define PRINT_PAIR_GROW(p) \
+	do { \
+		(p)->nr ++; \
+		ALLOC_GROW((p)->ranges, (p)->nr, (p)->alloc); \
+	} while (0);
+
+#define PRINT_PAIR_CLEAR(p) \
+	do { \
+		(p)->alloc = (p)->nr = 0; \
+		if ((p)->ranges) \
+			free((p)->ranges); \
+		(p)->ranges = NULL; \
+	} while(0);
+
+struct range {
+	const char *arg;	//The argument to specify this line range
+	long start, end;	//The start line number, inclusive
+	long pstart, pend;	//The end line number, inclusive
+	struct print_pair pair;
+			//The changed lines inside this range
+	unsigned int diff:1;
+};
+
+struct diff_line_range {
+	struct diff_filespec *prev;
+	struct diff_filespec *spec;
+	char status;
+	int alloc;
+	int nr;
+	struct range *ranges;
+	unsigned int	touch:1,
+			diff:1;
+	struct diff_line_range *next;
+};
+
+#define RANGE_INIT(r) \
+	do { \
+		(r)->arg = NULL; \
+		(r)->start = (r)->end = 0; \
+		(r)->pstart = (r)->pend = 0; \
+		PRINT_PAIR_INIT(&((r)->pair)); \
+		(r)->diff = 0; \
+	} while (0);
+
+#define RANGE_CLEAR(r) \
+	do { \
+		(r)->arg = NULL; \
+		(r)->start = (r)->end = 0; \
+		(r)->pstart = (r)->pend = 0; \
+		PRINT_PAIR_CLEAR(&r->pair); \
+		(r)->diff = 0; \
+	} while(0);
+
+#define DIFF_LINE_RANGE_INIT(r) \
+	do { \
+		(r)->prev = (r)->spec = NULL; \
+		(r)->status = '\0'; \
+		(r)->alloc = (r)->nr = 0; \
+		(r)->ranges = NULL; \
+		(r)->next = NULL; \
+		(r)->touch = 0; \
+		(r)->diff = 0; \
+	} while(0);
+
+#define DIFF_LINE_RANGE_GROW(r) \
+	do { \
+		(r)->nr ++; \
+		ALLOC_GROW((r)->ranges, (r)->nr, (r)->alloc); \
+		RANGE_INIT(((r)->ranges + (r)->nr - 1)); \
+	} while(0);
+
+#define DIFF_LINE_RANGE_CLEAR(r) \
+	diff_line_range_clear((r));
+
+extern struct range *diff_line_range_insert(struct diff_line_range *r, const char *arg,
+				int start, int end);
+extern void diff_line_range_append(struct diff_line_range *r, const char *arg);
+
+extern void diff_line_range_clear(struct diff_line_range *r);
+
+extern struct diff_line_range *diff_line_range_merge(struct diff_line_range *out,
+	struct diff_line_range *other);
+
+extern void setup_line(struct rev_info *rev, struct diff_line_range *r);
+
+extern void add_line_range(struct rev_info *revs, struct commit *commit, struct diff_line_range *r);
+
+extern struct diff_line_range *lookup_line_range(struct rev_info *revs, struct commit *commit);
+
+#endif
diff --git a/revision.c b/revision.c
index 7847921..3186e0e 100644
--- a/revision.c
+++ b/revision.c
@@ -1397,18 +1397,19 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	return 1;
 }
 
-void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
+int parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const struct option *options,
 			const char * const usagestr[])
 {
 	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
 				    &ctx->cpidx, ctx->out);
 	if (n <= 0) {
-		error("unknown option `%s'", ctx->argv[0]);
-		usage_with_options(usagestr, options);
+		return -1;
 	}
 	ctx->argv += n;
 	ctx->argc -= n;
+
+	return 0;
 }
 
 static int for_each_bad_bisect_ref(each_ref_fn fn, void *cb_data)
@@ -1631,6 +1632,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->combine_merges)
 		revs->ignore_merges = 0;
 	revs->diffopt.abbrev = revs->abbrev;
+
+	if (revs->line) {
+		revs->limited = 1;
+		revs->topo_order = 1;
+	}
+
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
diff --git a/revision.h b/revision.h
index 855464f..26c2ff5 100644
--- a/revision.h
+++ b/revision.h
@@ -14,6 +14,7 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
+#define RANGE_UPDATE	(1u<<9) /* for line level traverse */
 #define ALL_REV_FLAGS	((1u<<9)-1)
 
 #define DECORATE_SHORT_REFS	1
@@ -67,7 +68,8 @@ struct rev_info {
 			cherry_pick:1,
 			bisect:1,
 			ancestry_path:1,
-			first_parent_only:1;
+			first_parent_only:1,
+			line:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
@@ -132,6 +134,9 @@ struct rev_info {
 
 	/* notes-specific options: which refs to show */
 	struct display_notes_opt notes_opt;
+
+	/* line-level intersting range */
+	struct decoration line_range;
 };
 
 #define REV_TREE_SAME		0
@@ -150,7 +155,7 @@ struct setup_revision_opt {
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *);
-extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
+extern int parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 				 const struct option *options,
 				 const char * const usagestr[]);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
-- 
1.7.1.577.g36cf0.dirty
