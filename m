From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] commit-queue: LIFO or priority queue of commits
Date: Thu,  6 Jun 2013 22:11:11 -0700
Message-ID: <1370581872-31580-3-git-send-email-gitster@pobox.com>
References: <7vfvwuww39.fsf@alter.siamese.dyndns.org>
 <1370581872-31580-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 07:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkoxR-0000Ef-Lb
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 07:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab3FGFLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 01:11:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab3FGFLT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 01:11:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 349CF20C39;
	Fri,  7 Jun 2013 05:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=85sf
	c+6p1XgboT6hbhUI0oDxzbk=; b=Klz+aJ7zpriNTnemRFa10+PJ7xZ6ceDVAYnL
	2bKPOpzs9jqPwagwYt/DpT1uiEmegeATSs6yKD96pnq3tF01rXlviBNd2yvebFt/
	+P+8R7yho+K8ducYsFCGJ5rAdxYUHbHBxTweSRPAfbk/P6eD59YKb2EHpNzK8YfR
	kBT1ogc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZC6kNEuo01jWuMPHhwhkHrD23B9GxuF/oHq6JtDkm7JTYuNnUFKTQnQW317zv+Ix
	Ea6WHRGwaOgYnBlcl8I/GO2RUhN1pSr0BXTKYNKSnPlf+OHGEqbYnoSet6mKVU2F
	EMQH4gemFmvBySlVh0Jc4zgyIn/uHSNVmcyDw2eAdc8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C66820C38;
	Fri,  7 Jun 2013 05:11:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4476520C37;
	Fri,  7 Jun 2013 05:11:18 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-451-gb703ddf
In-Reply-To: <1370581872-31580-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AF6A110A-CF30-11E2-A78B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226593>

Traditionally we used a singly linked list of commits to hold a set
of in-flight commits while traversing history.  The most typical use
of the list is to insert commit that is newly discovered in it, keep
it sorted by commit timestamp, pick up the newest one from the list,
and keep digging.  The cost of keeping the singly linked list sorted
is nontrivial, and this typical use pattern better matches a priority
queue.

Introduce a commit-queue structure, that can be used either as a
LIFO stack, or a priority queue.  This will be used in the next
patch to hold in-flight commits during sort-in-topological-order.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile       |  2 ++
 commit-queue.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-queue.h | 31 +++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 commit-queue.c
 create mode 100644 commit-queue.h

diff --git a/Makefile b/Makefile
index 598d631..3cf55e9 100644
--- a/Makefile
+++ b/Makefile
@@ -634,6 +634,7 @@ LIB_H += cache.h
 LIB_H += color.h
 LIB_H += column.h
 LIB_H += commit.h
+LIB_H += commit-queue.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
@@ -757,6 +758,7 @@ LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
+LIB_OBJS += commit-queue.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
diff --git a/commit-queue.c b/commit-queue.c
new file mode 100644
index 0000000..77d4b02
--- /dev/null
+++ b/commit-queue.c
@@ -0,0 +1,71 @@
+#include "cache.h"
+#include "commit.h"
+#include "commit-queue.h"
+
+void clear_commit_queue(struct commit_queue *queue)
+{
+	free(queue->array);
+	queue->nr = 0;
+	queue->alloc = 0;
+	queue->array = NULL;
+}
+
+void commit_queue_put(struct commit_queue *queue, struct commit *commit)
+{
+	commit_compare_fn compare = queue->compare;
+	int ix, parent;
+
+	/* Append at the end */
+	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
+	queue->array[queue->nr++] = commit;
+	if (!compare)
+		return; /* LIFO */
+
+	/* Bubble up the new one */
+	for (ix = queue->nr - 1; ix; ix = parent) {
+		parent = (ix - 1) / 2;
+		if (compare(queue->array[parent], queue->array[ix],
+			    queue->cb_data) < 0)
+			break;
+
+		commit = queue->array[parent];
+		queue->array[parent] = queue->array[ix];
+		queue->array[ix] = commit;
+	}
+}
+
+struct commit *commit_queue_get(struct commit_queue *queue)
+{
+	struct commit *result, *swap;
+	int ix, child;
+	commit_compare_fn compare = queue->compare;
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
+			    queue->cb_data) < 0)
+			break;
+
+		swap = queue->array[child];
+		queue->array[child] = queue->array[ix];
+		queue->array[ix] = swap;
+	}
+	return result;
+}
diff --git a/commit-queue.h b/commit-queue.h
new file mode 100644
index 0000000..7c5dc4c
--- /dev/null
+++ b/commit-queue.h
@@ -0,0 +1,31 @@
+#ifndef COMMIT_QUEUE_H
+#define COMMIT_QUEUE_H
+
+/*
+ * Compare two commits; the third parameter is cb_data in the
+ * commit_queue structure.
+ */
+typedef int (*commit_compare_fn)(struct commit *, struct commit *, void *);
+
+struct commit_queue {
+	commit_compare_fn compare;
+	void *cb_data;
+	int alloc, nr;
+	struct commit **array;
+};
+
+/*
+ * Add the commit to the queue
+ */
+extern void commit_queue_put(struct commit_queue *, struct commit *);
+
+/*
+ * Extract the commit that compares the smallest out of the queue,
+ * or NULL.  If compare function is NULL, the queue acts as a LIFO
+ * stack.
+ */
+extern struct commit *commit_queue_get(struct commit_queue *);
+
+extern void clear_commit_queue(struct commit_queue *);
+
+#endif /* COMMIT_QUEUE_H */
-- 
1.8.3-451-gb703ddf
