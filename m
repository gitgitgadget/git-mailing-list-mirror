From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] add mergesort() for linked lists
Date: Sun, 01 Apr 2012 00:10:11 +0200
Message-ID: <4F7780C3.2050408@lsrfire.ath.cx>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 00:11:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE6Vk-0006ld-Dy
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 00:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab2CaWKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 18:10:30 -0400
Received: from india601.server4you.de ([85.25.151.105]:33716 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab2CaWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 18:10:28 -0400
Received: from [192.168.2.105] (p4FFD98B5.dip.t-dialin.net [79.253.152.181])
	by india601.server4you.de (Postfix) with ESMTPSA id C358C2F8038;
	Sun,  1 Apr 2012 00:10:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120330094052.GB12298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194467>

This adds a generic bottom-up mergesort implementation for singly linked
lists.  It was inspired by Simon Tatham's webpage on the topic[1], but
not so much by his implementation -- for no good reason, really, just a
case of NIH.

[1] http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.html

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
As you can guess from the patch, I just love function pointers. :)  It
may be interesting to know how much overhead they add, but in the test
case you described (a ref for each revision of git.git) the call to
mergesort (wired up in patch 3) only contributes less than 1% of the cost
according to callgrind, including its callees.

WARNING!  This is fresh code, and while the algorithm is simple, it's
possible that I was still somehow able to sneak in a bug.

 .gitignore       |    1 +
 Makefile         |    3 +++
 mergesort.c      |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mergesort.h      |    9 +++++++
 test-mergesort.c |   52 +++++++++++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+)
 create mode 100644 mergesort.c
 create mode 100644 mergesort.h
 create mode 100644 test-mergesort.c

diff --git a/.gitignore b/.gitignore
index 87fcc5f..225656a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -180,6 +180,7 @@
 /test-index-version
 /test-line-buffer
 /test-match-trees
+/test-mergesort
 /test-mktemp
 /test-parse-options
 /test-path-utils
diff --git a/Makefile b/Makefile
index be1957a..b04d6ec 100644
--- a/Makefile
+++ b/Makefile
@@ -480,6 +480,7 @@ TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
+TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
@@ -590,6 +591,7 @@ LIB_H += log-tree.h
 LIB_H += mailmap.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
+LIB_H += mergesort.h
 LIB_H += notes.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
@@ -694,6 +696,7 @@ LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += mergesort.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/mergesort.c b/mergesort.c
new file mode 100644
index 0000000..c0f1874
--- /dev/null
+++ b/mergesort.c
@@ -0,0 +1,75 @@
+#include "cache.h"
+#include "mergesort.h"
+
+#include "commit.h"
+
+struct mergesort_sublist {
+	void *ptr;
+	unsigned long len;
+};
+
+static void *get_nth_next(void *list, unsigned long n,
+			  void *(*get_next_fn)(const void *))
+{
+	while (n-- && list)
+		list = get_next_fn(list);
+	return list;
+}
+
+static void *pop_item(struct mergesort_sublist *l,
+		      void *(*get_next_fn)(const void *))
+{
+	void *p = l->ptr;
+	l->ptr = get_next_fn(l->ptr);
+	l->len = l->ptr ? (l->len - 1) : 0;
+	return p;
+}
+
+void *mergesort(void *list,
+		void *(*get_next_fn)(const void *),
+		void (*set_next_fn)(void *, void *),
+		int (*compare_fn)(const void *, const void *))
+{
+	unsigned long l;
+
+	if (!list)
+		return NULL;
+	for (l = 1; ; l *= 2) {
+		void *curr;
+		struct mergesort_sublist p, q;
+
+		p.ptr = list;
+		q.ptr = get_nth_next(p.ptr, l, get_next_fn);
+		if (!q.ptr)
+			break;
+		p.len = q.len = l;
+
+		if (compare_fn(p.ptr, q.ptr) > 0)
+			list = curr = pop_item(&q, get_next_fn);
+		else
+			list = curr = pop_item(&p, get_next_fn);
+
+		while (p.ptr) {
+			while (p.len || q.len) {
+				void *prev = curr;
+
+				if (!p.len)
+					curr = pop_item(&q, get_next_fn);
+				else if (!q.len)
+					curr = pop_item(&p, get_next_fn);
+				else if (compare_fn(p.ptr, q.ptr) > 0)
+					curr = pop_item(&q, get_next_fn);
+				else
+					curr = pop_item(&p, get_next_fn);
+				set_next_fn(prev, curr);
+			}
+			p.ptr = q.ptr;
+			p.len = l;
+			q.ptr = get_nth_next(p.ptr, l, get_next_fn);
+			q.len = q.ptr ? l : 0;
+
+		}
+		set_next_fn(curr, NULL);
+	}
+	return list;
+}
diff --git a/mergesort.h b/mergesort.h
new file mode 100644
index 0000000..d6e5f4a
--- /dev/null
+++ b/mergesort.h
@@ -0,0 +1,9 @@
+#ifndef MERGESORT_H
+#define MERGESORT_H
+
+void *mergesort(void *list,
+		void *(*get_next_fn)(const void *),
+		void (*set_next_fn)(void *, void *),
+		int (*compare_fn)(const void *, const void *));
+
+#endif
diff --git a/test-mergesort.c b/test-mergesort.c
new file mode 100644
index 0000000..02441ab
--- /dev/null
+++ b/test-mergesort.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "mergesort.h"
+
+struct line {
+	char *text;
+	struct line *next;
+};
+
+static void *get_next(const void *a)
+{
+	return ((const struct line *)a)->next;
+}
+
+static void set_next(void *a, void *b)
+{
+	((struct line *)a)->next = b;
+}
+
+static int compare_strings(const void *a, const void *b)
+{
+	const struct line *x = a, *y = b;
+	return strcmp(x->text, y->text);
+}
+
+int main(int argc, const char **argv)
+{
+	struct line *line, *p = NULL, *lines = NULL;
+	struct strbuf sb = STRBUF_INIT;
+
+	for (;;) {
+		if (strbuf_getwholeline_fd(&sb, 0, '\n'))
+			break;
+		line = xmalloc(sizeof(struct line));
+		line->text = strbuf_detach(&sb, NULL);
+		if (p) {
+			line->next = p->next;
+			p->next = line;
+		} else {
+			line->next = NULL;
+			lines = line;
+		}
+		p = line;
+	}
+
+	lines = mergesort(lines, get_next, set_next, compare_strings);
+
+	while (lines) {
+		printf("%s", lines->text);
+		lines = lines->next;
+	}
+	return 0;
+}
-- 
1.7.9.2
