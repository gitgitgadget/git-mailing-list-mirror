From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] basic priority queue implementation
Date: Thu, 19 May 2011 17:24:48 -0400
Message-ID: <20110519212448.GB29584@sigill.intra.peff.net>
References: <20110519212349.GA28589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAiI-0000pg-7T
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933396Ab1ESVYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:24:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47072
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455Ab1ESVYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:24:50 -0400
Received: (qmail 20753 invoked by uid 107); 19 May 2011 21:26:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:26:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:24:48 -0400
Content-Disposition: inline
In-Reply-To: <20110519212349.GA28589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174007>

This can provide better algorithmic complexity for some of
the date-sorted commit list uses, among other things.

The queue is stored as a heap, allowing O(log) insertion and
top-element removal, and O(1) peeking at the top element.
Current commit lists are sorted linked lists, giving O(1)
peeking and top-element removal, but O(n^2) insertion.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore       |    1 +
 Makefile         |    3 ++
 queue.c          |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 queue.h          |   17 +++++++++++++
 t/t0007-queue.sh |   50 ++++++++++++++++++++++++++++++++++++++
 test-queue.c     |   39 ++++++++++++++++++++++++++++++
 6 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 queue.c
 create mode 100644 queue.h
 create mode 100755 t/t0007-queue.sh
 create mode 100644 test-queue.c

diff --git a/.gitignore b/.gitignore
index 711fce7..179483a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -174,6 +174,7 @@
 /test-obj-pool
 /test-parse-options
 /test-path-utils
+/test-queue
 /test-run-command
 /test-sha1
 /test-sigchain
diff --git a/Makefile b/Makefile
index d09ee70..737b2d5 100644
--- a/Makefile
+++ b/Makefile
@@ -422,6 +422,7 @@ TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-queue
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
@@ -532,6 +533,7 @@ LIB_H += parse-options.h
 LIB_H += patch-ids.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
+LIB_H += queue.h
 LIB_H += quote.h
 LIB_H += reflog-walk.h
 LIB_H += refs.h
@@ -629,6 +631,7 @@ LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += progress.o
+LIB_OBJS += queue.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
diff --git a/queue.c b/queue.c
new file mode 100644
index 0000000..068b559
--- /dev/null
+++ b/queue.c
@@ -0,0 +1,70 @@
+#include "queue.h"
+#include "cache.h"
+
+static inline void queue_swap(struct queue *pq, unsigned i, unsigned j)
+{
+	void *tmp = pq->items[i];
+	pq->items[i] = pq->items[j];
+	pq->items[j] = tmp;
+}
+
+static void queue_heapify_up(struct queue *pq)
+{
+	unsigned i = pq->nr - 1;
+	while (i > 0) {
+		int parent = (i-1)/2;
+
+		if (pq->cmp(pq->items[i], pq->items[parent]) <= 0)
+			return;
+
+		queue_swap(pq, i, parent);
+		i = parent;
+	}
+}
+
+void queue_insert(struct queue *pq, void *item)
+{
+	ALLOC_GROW(pq->items, pq->nr + 1, pq->alloc);
+	pq->items[pq->nr++] = item;
+	queue_heapify_up(pq);
+}
+
+static void queue_heapify_down(struct queue *pq)
+{
+	unsigned i = 0;
+	while (1) {
+		int largest = i, left = 2*i + 1, right = 2*i + 2;
+
+		if (left < pq->nr &&
+		    pq->cmp(pq->items[left], pq->items[largest]) > 0)
+			largest = left;
+		if (right < pq->nr &&
+		    pq->cmp(pq->items[right], pq->items[largest]) > 0)
+			largest = right;
+
+		if (largest == i)
+			return;
+
+		queue_swap(pq, i, largest);
+		i = largest;
+	}
+}
+
+void *queue_peek(struct queue *pq)
+{
+	return pq->nr ? pq->items[0] : NULL;
+}
+
+void *queue_pop(struct queue *pq)
+{
+	void *ret;
+
+	if (!pq->nr)
+		return NULL;
+	ret = pq->items[0];
+
+	pq->items[0] = pq->items[--pq->nr];
+	queue_heapify_down(pq);
+
+	return ret;
+}
diff --git a/queue.h b/queue.h
new file mode 100644
index 0000000..fee5a51
--- /dev/null
+++ b/queue.h
@@ -0,0 +1,17 @@
+#ifndef QUEUE_H
+#define QUEUE_H
+
+typedef int (*queue_comparison_func_t)(const void *, const void *);
+
+struct queue {
+	queue_comparison_func_t cmp;
+	void **items;
+	unsigned nr;
+	unsigned alloc;
+};
+
+void queue_insert(struct queue *pq, void *item);
+void *queue_peek(struct queue *pq);
+void *queue_pop(struct queue *pq);
+
+#endif /* QUEUE_H */
diff --git a/t/t0007-queue.sh b/t/t0007-queue.sh
new file mode 100755
index 0000000..ee357bb
--- /dev/null
+++ b/t/t0007-queue.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='basic tests for priority queue implementation'
+. ./test-lib.sh
+
+cat >expect <<'EOF'
+10
+9
+8
+7
+6
+5
+5
+4
+3
+2
+1
+EOF
+test_expect_success 'basic ordering' '
+	test-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+3
+5
+4
+6
+2
+1
+EOF
+test_expect_success 'mixed insert and pop' '
+	test-queue 1 2 3 pop 4 5 pop pop 6 dump >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+2
+1
+NULL
+2
+1
+NULL
+EOF
+test_expect_success 'notice empty queue' '
+	test-queue 1 2 pop pop pop 1 2 pop pop pop >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/test-queue.c b/test-queue.c
new file mode 100644
index 0000000..a1e92e2
--- /dev/null
+++ b/test-queue.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "queue.h"
+
+static int intcmp(const void *va, const void *vb)
+{
+	const int *a = va, *b = vb;
+	return *a - *b;
+}
+
+static void show(int *v)
+{
+	if (!v)
+		printf("NULL\n");
+	else
+		printf("%d\n", *v);
+	free(v);
+}
+
+int main(int argc, char **argv)
+{
+	struct queue pq = { intcmp };
+
+	while (*++argv) {
+		if (!strcmp(*argv, "pop"))
+			show(queue_pop(&pq));
+		else if (!strcmp(*argv, "dump")) {
+			int *v;
+			while ((v = queue_pop(&pq)))
+			       show(v);
+		}
+		else {
+			int *v = malloc(sizeof(*v));
+			*v = atoi(*argv);
+			queue_insert(&pq, v);
+		}
+	}
+
+	return 0;
+}
-- 
1.7.5.8.ga95ab
