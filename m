From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 2/3] introduce generic similarity library
Date: Tue, 30 Oct 2007 00:24:07 -0400
Message-ID: <20071030042407.GB14954@sigill.intra.peff.net>
References: <20071030042118.GA14729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy C <andychup@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImieS-00078A-RR
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 05:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbXJ3EYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 00:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbXJ3EYM
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 00:24:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1283 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbXJ3EYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 00:24:11 -0400
Received: (qmail 29734 invoked by uid 111); 30 Oct 2007 04:24:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Oct 2007 00:24:08 -0400
Received: (qmail 14989 invoked by uid 1000); 30 Oct 2007 04:24:07 -0000
Content-Disposition: inline
In-Reply-To: <20071030042118.GA14729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62657>

This library attempts to find similarities among items
efficiently. It treats items as opaque pointers; callers are
responsible for providing an item along with its contents.

The algorithm is roughly:

  1. for each item, create a set of fingerprints for each
     chunk of the item (where each chunk is either delimited
     by a newline or is 64 characters, whichever is smaller
     -- this is the same fingerprint code from
     diffcore-delta.c). A hash stores a mapping of
     fingerprints to items, with each fingerprint having at
     most one 'source' item and one 'dest' item.

  2. for each fingerprint with a source and dest item,
     find the entry with key (source, dest) in a hash table
     and increment its value by the value of the fingerprint

  3. for each (source, dest) pair that had non-zero
     similarity, report the pair to the caller

The program test-similarity is a simple demonstration of the
code. It takes two list of files on stdin, with each file
separated by newlines and the two lists separated by a blank
line. It prints the similarity score of each non-zero pair
on stdout.

There are a few "interesting" design decisions, which should
probably be tweaked:

  - we store only one source and dest for each fingerprint
    item. We need to bound this list so that we don't get
    O(n^2) behavior for common fingerprints. This means that
    some files won't get "credit" for common fingerprints,
    which is probably OK, since those fingerprints are
    probably uninteresting. We could bound at some small
    number greater than one; one was chosen for speed and
    simplicity of implementation. We also don't store any
    overflow bit, so commonly used fingerprints will get
    assigned to whatever file is found with them last.

  - the similarity engine hands back absolute,
    non-normalized scores. That means that bigger items will
    have bigger scores, and the caller is responsible for
    normalizing. This also means that the engine cannot
    adjust normalization to account for chunks which are
    thrown out by the bounding mentioned above (i.e., if a
    file is 80 bytes, 64 of which are ignored as "common",
    then it can at most have 20% similarity (16/80) with
    another file. This means our normalized rename values
    (i.e., percentage similarity) will be lower than other
    algorithms.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore        |    1 +
 Makefile          |    4 +-
 similarity.c      |  152 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 similarity.h      |   24 ++++++++
 test-similarity.c |   54 +++++++++++++++++++
 5 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 similarity.c
 create mode 100644 similarity.h
 create mode 100644 test-similarity.c

diff --git a/.gitignore b/.gitignore
index 62afef2..8ce6026 100644
--- a/.gitignore
+++ b/.gitignore
@@ -155,6 +155,7 @@ test-dump-cache-tree
 test-genrandom
 test-match-trees
 test-sha1
+test-similarity
 common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 2e6fd8f..0568d0d 100644
--- a/Makefile
+++ b/Makefile
@@ -300,7 +300,7 @@ DIFF_OBJS = \
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o \
-	interpolate.o hash.o \
+	interpolate.o hash.o similarity.o \
 	lockfile.o \
 	patch-ids.o \
 	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
@@ -975,7 +975,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-similarity$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/similarity.c b/similarity.c
new file mode 100644
index 0000000..0bd135c
--- /dev/null
+++ b/similarity.c
@@ -0,0 +1,152 @@
+#include "cache.h"
+#include "similarity.h"
+
+struct fingerprint_entry {
+	void *src;
+	void *dst;
+	unsigned weight;
+};
+
+struct score_entry {
+	void *src;
+	void *dst;
+	unsigned score;
+	struct score_entry *next;
+};
+
+void similarity_init(struct similarity *s)
+{
+	init_hash(&s->fingerprints);
+	init_hash(&s->scores);
+}
+
+static int free_one_fingerprint(void *ve, void *data)
+{
+	struct fingerprint_entry *e = ve;
+	free(e);
+	return 0;
+}
+
+static int free_one_score(void *ve, void *data)
+{
+	struct score_entry *e = ve;
+	while (e) {
+		struct score_entry *next = e->next;
+		free(e);
+		e = next;
+	}
+	return 0;
+}
+
+void similarity_free(struct similarity *s)
+{
+	for_each_hash(&s->fingerprints, free_one_fingerprint, NULL);
+	free_hash(&s->fingerprints);
+	for_each_hash(&s->scores, free_one_score, NULL);
+	free_hash(&s->scores);
+}
+
+static void add_fingerprint(struct hash_table *h, unsigned int fp,
+		int type, void *data, unsigned weight)
+{
+	void **pos;
+	struct fingerprint_entry *e;
+
+	pos = insert_hash(fp, h);
+	if (!*pos) {
+		e = xmalloc(sizeof(*e));
+		e->weight = weight;
+		e->src = e->dst = NULL;
+		*pos = e;
+	}
+	else
+		e = *pos;
+
+	if (type == SIMILARITY_SOURCE)
+		e->src = data;
+	else
+		e->dst = data;
+}
+
+void similarity_add(struct similarity *sim, int type, void *data,
+		const char *buf, unsigned long sz, int is_text)
+{
+	int n;
+	unsigned int accum1, accum2, hashval;
+
+	n = 0;
+	accum1 = accum2 = 0;
+	while (sz) {
+		unsigned int c = *buf++;
+		unsigned int old_1 = accum1;
+		sz--;
+
+		/* Ignore CR in CRLF sequence if text */
+		if (!is_text && c == '\r' && sz && *buf == '\n')
+			continue;
+
+		accum1 = (accum1 << 7) ^ (accum2 >> 25);
+		accum2 = (accum2 << 7) ^ (old_1 >> 25);
+		accum1 += c;
+		if (++n < 64 && c != '\n')
+			continue;
+		hashval = accum1 + accum2 * 0x61;
+		add_fingerprint(&sim->fingerprints, hashval, type, data, n);
+		n = 0;
+		accum1 = accum2 = 0;
+	}
+}
+
+static unsigned hash_void_pair(void *a, void *b)
+{
+	return (unsigned)a + (unsigned)b;
+}
+
+static int score_one_entry(void *vfp, void *vsim)
+{
+	struct fingerprint_entry *fp = vfp;
+	struct similarity *sim = vsim;
+	struct score_entry *score;
+	void **pos;
+
+	if (!fp->src || !fp->dst)
+		return 0;
+
+	pos = insert_hash(hash_void_pair(fp->src, fp->dst), &sim->scores);
+	for (score = *pos; score; score = score->next) {
+		if (score->src == fp->src && score->dst == fp->dst) {
+			score->score += fp->weight;
+			return 0;
+		}
+	}
+
+	score = xmalloc(sizeof(*score));
+	score->src = fp->src;
+	score->dst = fp->dst;
+	score->score = fp->weight;
+	score->next = *pos;
+	*pos = score;
+
+	return 0;
+}
+
+void similarity_score(struct similarity *s)
+{
+	for_each_hash(&s->fingerprints, score_one_entry, s);
+}
+
+static int report_one_score(void *ve, void *vdata)
+{
+	struct score_entry *e;
+	void (*fn)(void *, void *, unsigned) = vdata;
+
+	for (e = ve; e; e = e->next)
+		fn(e->src, e->dst, e->score);
+	return 1;
+}
+
+void similarity_report(struct similarity *s,
+		void (*fn)(void *, void *, unsigned))
+{
+	for_each_hash(&s->scores, report_one_score, fn);
+}
diff --git a/similarity.h b/similarity.h
new file mode 100644
index 0000000..6409ab8
--- /dev/null
+++ b/similarity.h
@@ -0,0 +1,24 @@
+#ifndef SIMILARITY_H
+#define SIMILARITY_H
+
+#include "hash.h"
+
+#define SIMILARITY_SOURCE 0
+#define SIMILARITY_DEST   1
+
+struct similarity {
+	struct hash_table fingerprints;
+	struct hash_table scores;
+};
+
+void similarity_init(struct similarity *s);
+void similarity_free(struct similarity *s);
+
+void similarity_add(struct similarity *s, int type, void *data,
+		const char *buf, unsigned long sz, int is_text);
+
+void similarity_score(struct similarity *s);
+void similarity_report(struct similarity *s,
+		void (*fn)(void *, void *, unsigned));
+
+#endif /* SIMILARITY_H */
diff --git a/test-similarity.c b/test-similarity.c
new file mode 100644
index 0000000..5947420
--- /dev/null
+++ b/test-similarity.c
@@ -0,0 +1,54 @@
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include "git-compat-util.h"
+#include "similarity.h"
+#include "strbuf.h"
+#include "xdiff-interface.h"
+
+static void print_rename(void *vone, void *vtwo, unsigned score) {
+	const char *one = vone, *two = vtwo;
+	printf("%u %s -> %s\n", score, one, two);
+}
+
+static void add_file(struct similarity *sim, int type, const char *fn)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int len;
+
+	len = strbuf_read_file(&sb, fn, 0);
+	if (len < 0)
+		die("unable to read %s: %s\n", fn, strerror(errno));
+
+	similarity_add(sim, type, strdup(fn),
+			sb.buf, sb.len, buffer_is_binary(sb.buf, sb.len));
+
+	strbuf_release(&sb);
+}
+
+int main(int argc, char **argv)
+{
+	struct similarity sim;
+	struct strbuf line;
+
+	similarity_init(&sim);
+	strbuf_init(&line, 0);
+
+	while (strbuf_getline(&line, stdin, '\n') != EOF) {
+		if (!line.len)
+			break;
+		add_file(&sim, SIMILARITY_SOURCE, line.buf);
+	}
+	while (strbuf_getline(&line, stdin, '\n') != EOF)
+		add_file(&sim, SIMILARITY_DEST, line.buf);
+
+	strbuf_release(&line);
+
+	similarity_score(&sim);
+	similarity_report(&sim, print_rename);
+
+	similarity_free(&sim);
+
+	return 0;
+}
-- 
1.5.3.4
