From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] prio-queue: priority queue of pointers to structs
Date: Tue, 11 Jun 2013 15:19:07 -0700
Message-ID: <1370989149-28538-3-git-send-email-gitster@pobox.com>
References: <20130611063648.GB23650@sigill.intra.peff.net>
 <1370989149-28538-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:19:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWud-0007YZ-R5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757038Ab3FKWTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 18:19:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50392 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab3FKWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:19:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C62E2794B;
	Tue, 11 Jun 2013 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HIV9
	g4OBsXONhFYNQAd1fe99UKM=; b=tzUXcwQLQpMNpTGC59wPddyX7AuQvJ6Efk6o
	kdnbDuajy789hmRnV4GCfLta5oiRHn0drY2GR2ZYlgFdiM4zknoMIbH+UTDQCZCA
	hibWBu5UeQ7k9Z4ycpH4eA9kpPKUrcyLj/LYTH5jsH31O8bS8RdNc9gJpOj8YT/U
	boE7opw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ryYZgkKOT40C290QwADk5/lcjM/J4MQVx7zVSHHX6dalZRMZvmp/C908M6yEHPAI
	IKHPsR5BVXnRK2XLnAwTctcOGr402qgOb9onXfgHBwS/316TfZDIYtdIy/9MZPDI
	ZtB3hl+6G+/NlkTZl8g2XXud1jAArAQcA+MzzydEfHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 738332794A;
	Tue, 11 Jun 2013 22:19:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D7C727949;
	Tue, 11 Jun 2013 22:19:14 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-494-g51b8af5
In-Reply-To: <1370989149-28538-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F2F74E26-D2E4-11E2-B7AF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227546>

Traditionally we used a singly linked list of commits to hold a set
of in-flight commits while traversing history.  The most typical use
of the list is to add commits that are newly discovered to it, keep
the list sorted by commit timestamp, pick up the newest one from the
list, and keep digging.  The cost of keeping the singly linked list
sorted is nontrivial, and this typical use pattern better matches a
priority queue.

Introduce a prio-queue structure, that can be used either as a LIFO
stack, or a priority queue.  This will be used in the next patch to
hold in-flight commits during sort-in-topological-order.

Tests and the idea to make it usable for any "void *" pointers to
"things" are by Jeff King.  Bugs are mine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore            |  1 +
 Makefile              |  3 +++
 prio-queue.c          | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 prio-queue.h          | 45 ++++++++++++++++++++++++++++++++
 t/t0009-prio-queue.sh | 50 ++++++++++++++++++++++++++++++++++++
 test-prio-queue.c     | 39 ++++++++++++++++++++++++++++
 6 files changed, 209 insertions(+)
 create mode 100644 prio-queue.c
 create mode 100644 prio-queue.h
 create mode 100755 t/t0009-prio-queue.sh
 create mode 100644 test-prio-queue.c

diff --git a/.gitignore b/.gitignore
index 6669bf0..b753817 100644
--- a/.gitignore
+++ b/.gitignore
@@ -190,6 +190,7 @@
 /test-mktemp
 /test-parse-options
 /test-path-utils
+/test-prio-queue
 /test-regex
 /test-revision-walking
 /test-run-command
diff --git a/Makefile b/Makefile
index 598d631..0246194 100644
--- a/Makefile
+++ b/Makefile
@@ -552,6 +552,7 @@ TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
@@ -685,6 +686,7 @@ LIB_H += parse-options.h
 LIB_H += patch-ids.h
 LIB_H += pathspec.h
 LIB_H += pkt-line.h
+LIB_H += prio-queue.h
 LIB_H += progress.h
 LIB_H += prompt.h
 LIB_H += quote.h
@@ -824,6 +826,7 @@ LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
+LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
 LIB_OBJS += prompt.o
 LIB_OBJS += quote.o
diff --git a/prio-queue.c b/prio-queue.c
new file mode 100644
index 0000000..f2a4973
--- /dev/null
+++ b/prio-queue.c
@@ -0,0 +1,71 @@
+#include "cache.h"
+#include "commit.h"
+#include "prio-queue.h"
+
+void clear_prio_queue(struct prio_queue *queue)
+{
+	free(queue->array);
+	queue->nr = 0;
+	queue->alloc = 0;
+	queue->array = NULL;
+}
+
+void prio_queue_put(struct prio_queue *queue, void *thing)
+{
+	prio_queue_compare_fn compare = queue->compare;
+	int ix, parent;
+
+	/* Append at the end */
+	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
+	queue->array[queue->nr++] = thing;
+	if (!compare)
+		return; /* LIFO */
+
+	/* Bubble up the new one */
+	for (ix = queue->nr - 1; ix; ix = parent) {
+		parent = (ix - 1) / 2;
+		if (compare(queue->array[parent], queue->array[ix],
+			    queue->cb_data) <= 0)
+			break;
+
+		thing = queue->array[parent];
+		queue->array[parent] = queue->array[ix];
+		queue->array[ix] = thing;
+	}
+}
+
+void *prio_queue_get(struct prio_queue *queue)
+{
+	void *result, *swap;
+	int ix, child;
+	prio_queue_compare_fn compare = queue->compare;
+
+	if (!queue->nr)
+		return NULL;
+	if (!compare)
+		return queue->array[--queue->nr]; /* LIFO */
+
+	result = queue->array[0];
+	if (!--queue->nr)
+		return result;
+
+	queue->array[0] = queue->array[queue->nr];
+
+	/* Push down the one at the root */
+	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
+		child = ix * 2 + 1; /* left */
+		if ((child + 1 < queue->nr) &&
+		    (compare(queue->array[child], queue->array[child + 1],
+			     queue->cb_data) >= 0))
+			child++; /* use right child */
+
+		if (compare(queue->array[ix], queue->array[child],
+			    queue->cb_data) <= 0)
+			break;
+
+		swap = queue->array[child];
+		queue->array[child] = queue->array[ix];
+		queue->array[ix] = swap;
+	}
+	return result;
+}
diff --git a/prio-queue.h b/prio-queue.h
new file mode 100644
index 0000000..ed354a5
--- /dev/null
+++ b/prio-queue.h
@@ -0,0 +1,45 @@
+#ifndef PRIO_QUEUE_H
+#define PRIO_QUEUE_H
+
+/*
+ * A priority queue implementation, primarily for keeping track of
+ * commits in the 'date-order' so that we process them from new to old
+ * as they are discovered, but can be used to hold any pointer to
+ * struct.  The caller is responsible for supplying a function to
+ * compare two "things".
+ *
+ * Alternatively, this data structure can also be used as a LIFO stack
+ * by specifying NULL as the comparison function.
+ */
+
+/*
+ * Compare two "things", one and two; the third parameter is cb_data
+ * in the prio_queue structure.  The result is returned as a sign of
+ * the return value, being the same as the sign of the result of
+ * subtracting "two" from "one" (i.e. negative if "one" sorts earlier
+ * than "two").
+ */
+typedef int (*prio_queue_compare_fn)(const void *one, const void *two, void *cb_data);
+
+struct prio_queue {
+	prio_queue_compare_fn compare;
+	void *cb_data;
+	int alloc, nr;
+	void **array;
+};
+
+/*
+ * Add the "thing" to the queue.
+ */
+extern void prio_queue_put(struct prio_queue *, void *thing);
+
+/*
+ * Extract the "thing" that compares the smallest out of the queue,
+ * or NULL.  If compare function is NULL, the queue acts as a LIFO
+ * stack.
+ */
+extern void *prio_queue_get(struct prio_queue *);
+
+extern void clear_prio_queue(struct prio_queue *);
+
+#endif /* PRIO_QUEUE_H */
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
new file mode 100755
index 0000000..94045c3
--- /dev/null
+++ b/t/t0009-prio-queue.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='basic tests for priority queue implementation'
+. ./test-lib.sh
+
+cat >expect <<'EOF'
+1
+2
+3
+4
+5
+5
+6
+7
+8
+9
+10
+EOF
+test_expect_success 'basic ordering' '
+	test-prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+2
+3
+4
+1
+5
+6
+EOF
+test_expect_success 'mixed put and get' '
+	test-prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+1
+2
+NULL
+1
+2
+NULL
+EOF
+test_expect_success 'notice empty queue' '
+	test-prio-queue 1 2 get get get 1 2 get get get >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/test-prio-queue.c b/test-prio-queue.c
new file mode 100644
index 0000000..7be72f0
--- /dev/null
+++ b/test-prio-queue.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "prio-queue.h"
+
+static int intcmp(const void *va, const void *vb, void *data)
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
+	struct prio_queue pq = { intcmp };
+
+	while (*++argv) {
+		if (!strcmp(*argv, "get"))
+			show(prio_queue_get(&pq));
+		else if (!strcmp(*argv, "dump")) {
+			int *v;
+			while ((v = prio_queue_get(&pq)))
+			       show(v);
+		}
+		else {
+			int *v = malloc(sizeof(*v));
+			*v = atoi(*argv);
+			prio_queue_put(&pq, v);
+		}
+	}
+
+	return 0;
+}
-- 
1.8.3.1-494-g51b8af5
