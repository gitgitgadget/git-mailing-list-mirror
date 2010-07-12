From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v3 03/13] add the basic data structure for line level 
	history
Date: Mon, 12 Jul 2010 22:16:35 +0800
Message-ID: <AANLkTim5m2vG3ZiveRcRIGLVszu9mFruTJ2B_6lsqkGH@mail.gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<1278829141-11900-3-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 12 16:16:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYJoJ-0004zp-FT
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 16:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab0GLOQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 10:16:38 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51107 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab0GLOQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 10:16:37 -0400
Received: by gxk23 with SMTP id 23so2491053gxk.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=nyTvw4QiMm6VIp36H+hvm8TgnMD8tcD96Mfg6K3vicQ=;
        b=tnkpzatpWqbe5mZQ1l3h0HEh19hnAY1U1uq/Lyt0WpuWZGDgx5xyfVtmY9S+FamiYu
         VKmg06208shrgzUeqzlRFsnxaeF9ktH8+pUmb2DQim+8ZHY76RZHWBTZoBXpGxHsqyFT
         DucY+hF7NiHuWYQqt2SZGMQtvXJCC5f5BbFHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ybid8K/4XjnX+q2/5izvB+w1gcTeNOtbcRLAJITBoJ6/f+fNqUEi+AFuUGKdN1uIOv
         eErnQuxyYtsXaL6Xani9UDbGv3dnU8TslhjM72+n74I2QdKs3tew5Ywm2yrohFaGiBjV
         1fZ5tb7DcIPD9A3O76TrHL8tBvKty9TNDbgho=
Received: by 10.224.60.19 with SMTP id n19mr2799097qah.248.1278944195997; Mon, 
	12 Jul 2010 07:16:35 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Mon, 12 Jul 2010 07:16:35 -0700 (PDT)
In-Reply-To: <1278829141-11900-3-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150814>

Hi Junio,

    I have make a revised version of this patch to fix a bug of it.
That's that I declare a 'unsigned long *ends;" but allocate memory
using "xmalloc(size*sizeof(int))" for it. And this new patch fix it.

-------------------------------------------------------------------------
From 7608bb8d67126b6d9d5436f00e8743ac0600db6f Mon Sep 17 00:00:00 2001
From: Bo Yang <struggleyb.nku@gmail.com>
Date: Fri, 25 Jun 2010 19:37:32 -0700
Subject: [PATCH v3 revised 03/13] add the basic data structure for
line level history

'struct diff_line_range' is the main data structure to store
the user interesting line range. There is one 'diff_line_range'
for each file, and there are multiple 'struct range' in each
'diff_line_range'. In this way, we support multiple ranges.

Within 'struct range', there are multiple 'struct print_range'
which represent a diff chunk.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Makefile   |    2 +
 diffcore.h |    1 +
 line.c     |  456 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h     |  122 ++++++++++++++++
 revision.c |    6 +
 revision.h |    8 +-
 6 files changed, 593 insertions(+), 2 deletions(-)
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
index 491bea0..13d8e93 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -23,6 +23,7 @@
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */

 struct userdiff_driver;
+struct diff_options;

 struct diff_filespec {
 	unsigned char sha1[20];
diff --git a/line.c b/line.c
new file mode 100644
index 0000000..2f82fd8
--- /dev/null
+++ b/line.c
@@ -0,0 +1,456 @@
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
+		struct diff_line_range *next = r->next;
+		DIFF_LINE_RANGE_CLEAR(r);
+		free(r);
+		r = next;
+	}
+}
+
+static struct object *verify_commit(struct rev_info *revs)
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
+	if (commit == NULL)
+		die("No commit specified?");
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
+	return;
+error:
+	die("There is no path %s in the commit", r->spec->path);
+}
+
+static void fill_line_ends(struct diff_filespec *spec, long *lines,
+	unsigned long **line_ends)
+{
+	int num = 0, size = 50;
+	long cur = 0;
+	unsigned long *ends = NULL;
+	char *data = NULL;
+
+	if (diff_populate_filespec(spec, 0))
+		die("Cannot read blob %s", sha1_to_hex(spec->sha1));
+
+	ends = xmalloc(size * sizeof(*ends));
+	ends[cur++] = -1;
+	data = spec->data;
+	while (num < spec->size) {
+		if (data[num] == '\n' || num == spec->size - 1) {
+			ALLOC_GROW(ends, (cur + 1), size);
+			ends[cur++] = num;
+		}
+		num++;
+	}
+
+	/* shrink the array to fit the elements */
+	ends = xrealloc(ends, cur * sizeof(*ends));
+	*lines = cur;
+	*line_ends = ends;
+}
+
+static const char *nth_line(struct diff_filespec *spec, int line,
+		long lines, unsigned long *line_ends)
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
+			     long lines, unsigned long *line_ends,
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
+static void parse_range(long lines, unsigned long *line_ends,
+		struct range *r, struct diff_filespec *spec)
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
+	struct range *old_range = NULL;
+	long lines = 0;
+	unsigned long *ends = NULL;
+
+	while (r) {
+		struct diff_filespec *spec = r->spec;
+		int num = r->nr;
+		assert(spec);
+		fill_blob_sha1(commit, r);
+		old_range = r->ranges;
+		r->ranges = NULL;
+		r->nr = r->alloc = 0;
+		fill_line_ends(spec, &lines, &ends);
+		for (i = 0; i < num; i++) {
+			parse_range(lines, ends, old_range + i, spec);
+			diff_line_range_insert(r, old_range[i].arg,
+				old_range[i].start, old_range[i].end);
+		}
+
+		free(ends);
+		ends = NULL;
+
+		r = r->next;
+		free(old_range);
+	}
+}
+
+/*
+ * Insert a new line range into a diff_line_range struct, and keep the
+ * r->ranges sorted by their starting line number.
+ */
+struct range *diff_line_range_insert(struct diff_line_range *r, const
char *arg,
+				int start, int end)
+{
+	int i = 0;
+	struct range *rs = r->ranges;
+	int left_extend = 0, right_extend = 0;
+
+	assert(r != NULL);
+	assert(start <= end);
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
+	r->next = NULL;
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
+		struct diff_line_range *ptwo;
+		two = other;
+		ptwo = other;
+		while (two) {
+			if (!strcmp(one->spec->path, two->spec->path)) {
+				int i = 0;
+				for (; i < two->nr; i++) {
+					diff_line_range_insert(one, NULL,
+						two->ranges[i].start,
+						two->ranges[i].end);
+				}
+				if (two == other) {
+					other = other->next;
+				} else {
+					ptwo->next = two->next;
+				}
+				DIFF_LINE_RANGE_CLEAR(two);
+				free(two);
+				two = NULL;
+
+				break;
+			}
+
+			ptwo = two;
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
+void add_line_range(struct rev_info *revs, struct commit *commit,
struct diff_line_range *r)
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
+struct diff_line_range *lookup_line_range(struct rev_info *revs,
struct commit *commit)
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
+	commit = (struct commit *)verify_commit(rev);
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
+extern struct range *diff_line_range_insert(struct diff_line_range
*r, const char *arg,
+				int start, int end);
+extern void diff_line_range_append(struct diff_line_range *r, const char *arg);
+
+extern void diff_line_range_clear(struct diff_line_range *r);
+
+extern struct diff_line_range *diff_line_range_merge(struct
diff_line_range *out,
+	struct diff_line_range *other);
+
+extern void setup_line(struct rev_info *rev, struct diff_line_range *r);
+
+extern void add_line_range(struct rev_info *revs, struct commit
*commit, struct diff_line_range *r);
+
+extern struct diff_line_range *lookup_line_range(struct rev_info
*revs, struct commit *commit);
+
+#endif
diff --git a/revision.c b/revision.c
index 7e82efd..63f37ea 100644
--- a/revision.c
+++ b/revision.c
@@ -1637,6 +1637,12 @@ int setup_revisions(int argc, const char
**argv, struct rev_info *revs, struct s
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
index 36fdf22..55836e0 100644
--- a/revision.h
+++ b/revision.h
@@ -14,7 +14,8 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define ALL_REV_FLAGS	((1u<<9)-1)
+#define RANGE_UPDATE	(1u<<9) /* for line level traverse */
+#define ALL_REV_FLAGS	((1u<<10)-1)

 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -68,7 +69,8 @@ struct rev_info {
 			cherry_pick:1,
 			bisect:1,
 			ancestry_path:1,
-			first_parent_only:1;
+			first_parent_only:1,
+			line:1;

 	/* Diff flags */
 	unsigned int	diff:1,
@@ -137,6 +139,8 @@ struct rev_info {
 	/* commit counts */
 	int count_left;
 	int count_right;
+	/* line-level intersting range */
+	struct decoration line_range;
 };

 #define REV_TREE_SAME		0
-- 
1.7.0.2.273.gc2413.dirty
