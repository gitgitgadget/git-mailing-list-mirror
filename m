From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Mon, 10 Jun 2013 14:15:57 -0400
Message-ID: <20130610181557.GA2084@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-3-git-send-email-gitster@pobox.com>
 <20130610052500.GD3621@sigill.intra.peff.net>
 <7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:16:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6dW-0007vx-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493Ab3FJSQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:16:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:47024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494Ab3FJSQC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:16:02 -0400
Received: (qmail 23597 invoked by uid 102); 10 Jun 2013 18:16:52 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 13:16:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 14:15:57 -0400
Content-Disposition: inline
In-Reply-To: <7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227338>

On Mon, Jun 10, 2013 at 12:21:00AM -0700, Junio C Hamano wrote:

> > It may be worth looking again for other places to use this over
> > commit_list, but even the caller you are introducing here justifies its
> > presence.
> 
> The next candidate is paint-down-to-common, probably.

Yeah, I don't think I looked at that at all last time (mostly because it
only large as the graph gets wide, which is typically acceptable for
us). But it should be easy to do.

> > Also, I wrote some basic tests to cover the priority queue as a unit. I
> > can rebase them on your commit if you are interested.
> 
> It would be great.

Squashable patch is below.

> > Is it worth making this "struct commit *" a void pointer, and handling
> > arbitrary items in our priority queue? The compare function should be
> > the only thing that dereferences them.
> >  
> > I do not have any non-commit priority queue use in mind, but I do not
> > think it adds any complexity in this case.
> 
> I didn't either (and still I don't think of one), but I agree that
> the implementation can be reused for pq of any type, as long as it
> is a pointer to struct.

I converted this to a void pointer in my patch below, simply because it
makes it easier to write a test-queue that operates on ints. Due to
implicit casting, it should work for the most part without changing the
calling code unless you have a caller that does something like:

  commit_queue_get(&q)->date

or similar. I didn't change the name, either. It may be silly to call it
"commit_queue" still since it is now more general. I simply called mine
"queue" (I wanted "pqueue", but that conflicted with globals defined by
OpenSSL; yours is a more general queue anyway, so maybe that is a good
name).

> >> +	/* Bubble up the new one */
> >> +	for (ix = queue->nr - 1; ix; ix = parent) {
> >> +		parent = (ix - 1) / 2;
> >> +		if (compare(queue->array[parent], queue->array[ix],
> >> +			    queue->cb_data) < 0)
> >> +			break;
> >
> > In my implementation, I stopped on "compare() <= 0". It is late and my
> > mind is fuzzy, but I recall that heaps are never stable with respect to
> > insertion order, so I don't think it would matter.
> 
> It would matter in the sense that we cannot replace linked-list, if
> the caller wants stability.  It is more like "we cannot do anything
> about it" than "it would not matter".

Right. I meant "I do not think it matters if you do <= or < here, as we
are not stable anyway". Doing "<= 0" stops the heapify operation sooner,
though I doubt it matters in practice (it is not an algorithmic
complexity change, but just that you can sometimes quit early).

I think it is the same situation in your "push down", too, where you can
quit when the parent is equal to the largest child.

> We can make each queue element a pair of <pointer to payload,
> insertion counter>, and tiebreak using the insertion order, if the
> callers want the same stability as linked-list implementation, but
> I tend to think it really matters.

Yes, I think that is the usual solution.

Here's the patch with the tests, meant to be squashed into your 2/4. As
I mentioned above, you may want to further tweak the name, which would
require fixing up the rebase patches on top.

If you don't want to do the "s/struct commit/void/" change now, we can
probably just have test-queue stuff the ints into commit pointers.

The tests themselves are not extremely extensive, but at least let you
check that you implemented the heap correctly. :)

---
 .gitignore       |  1 +
 Makefile         |  1 +
 commit-queue.c   |  6 ++---
 commit-queue.h   |  8 +++---
 t/t0009-queue.sh | 50 +++++++++++++++++++++++++++++++++++
 test-queue.c     | 39 +++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6669bf0..8670e6d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -193,6 +193,7 @@
 /test-regex
 /test-revision-walking
 /test-run-command
+/test-queue
 /test-sha1
 /test-sigchain
 /test-string-list
diff --git a/Makefile b/Makefile
index 3cf55e9..c957637 100644
--- a/Makefile
+++ b/Makefile
@@ -552,6 +552,7 @@ TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-queue
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
diff --git a/commit-queue.c b/commit-queue.c
index 77d4b02..04acf23 100644
--- a/commit-queue.c
+++ b/commit-queue.c
@@ -10,7 +10,7 @@ void clear_commit_queue(struct commit_queue *queue)
 	queue->array = NULL;
 }
 
-void commit_queue_put(struct commit_queue *queue, struct commit *commit)
+void commit_queue_put(struct commit_queue *queue, void *commit)
 {
 	commit_compare_fn compare = queue->compare;
 	int ix, parent;
@@ -34,9 +34,9 @@ struct commit *commit_queue_get(struct commit_queue *queue)
 	}
 }
 
-struct commit *commit_queue_get(struct commit_queue *queue)
+void *commit_queue_get(struct commit_queue *queue)
 {
-	struct commit *result, *swap;
+	void *result, *swap;
 	int ix, child;
 	commit_compare_fn compare = queue->compare;
 
diff --git a/commit-queue.h b/commit-queue.h
index 7c5dc4c..ef8fb87 100644
--- a/commit-queue.h
+++ b/commit-queue.h
@@ -5,26 +5,26 @@ extern void commit_queue_put(struct commit_queue *, struct commit *);
  * Compare two commits; the third parameter is cb_data in the
  * commit_queue structure.
  */
-typedef int (*commit_compare_fn)(struct commit *, struct commit *, void *);
+typedef int (*commit_compare_fn)(void *, void *, void *);
 
 struct commit_queue {
 	commit_compare_fn compare;
 	void *cb_data;
 	int alloc, nr;
-	struct commit **array;
+	void **array;
 };
 
 /*
  * Add the commit to the queue
  */
-extern void commit_queue_put(struct commit_queue *, struct commit *);
+extern void commit_queue_put(struct commit_queue *, void *);
 
 /*
  * Extract the commit that compares the smallest out of the queue,
  * or NULL.  If compare function is NULL, the queue acts as a LIFO
  * stack.
  */
-extern struct commit *commit_queue_get(struct commit_queue *);
+extern void *commit_queue_get(struct commit_queue *);
 
 extern void clear_commit_queue(struct commit_queue *);
 
diff --git a/t/t0009-queue.sh b/t/t0009-queue.sh
new file mode 100755
index 0000000..186df01
--- /dev/null
+++ b/t/t0009-queue.sh
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
+	test-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
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
+	test-queue 6 2 4 get 5 3 get get 1 dump >actual &&
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
+	test-queue 1 2 get get get 1 2 get get get >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/test-queue.c b/test-queue.c
new file mode 100644
index 0000000..7743775
--- /dev/null
+++ b/test-queue.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "commit-queue.h"
+
+static int intcmp(void *va, void *vb, void *data)
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
+	struct commit_queue pq = { intcmp };
+
+	while (*++argv) {
+		if (!strcmp(*argv, "get"))
+			show(commit_queue_get(&pq));
+		else if (!strcmp(*argv, "dump")) {
+			int *v;
+			while ((v = commit_queue_get(&pq)))
+			       show(v);
+		}
+		else {
+			int *v = malloc(sizeof(*v));
+			*v = atoi(*argv);
+			commit_queue_put(&pq, v);
+		}
+	}
+
+	return 0;
+}
