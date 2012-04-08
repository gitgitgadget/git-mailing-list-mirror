From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] add mergesort() for linked lists
Date: Sun, 08 Apr 2012 22:32:38 +0200
Message-ID: <4F81F5E6.2070609@lsrfire.ath.cx>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net> <4F7780C3.2050408@lsrfire.ath.cx> <7vpqbm56pf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 22:33:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGynE-0008Ss-Qz
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 22:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab2DHUcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 16:32:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:34594 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab2DHUco (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 16:32:44 -0400
Received: from [192.168.2.105] (p4FFDBD03.dip.t-dialin.net [79.253.189.3])
	by india601.server4you.de (Postfix) with ESMTPSA id EDCA42F8094;
	Sun,  8 Apr 2012 22:32:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7vpqbm56pf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195005>

Am 05.04.2012 21:17, schrieb Junio C Hamano:
> After seeing "I wrote it myself due to NIH", it strikes me a bit odd that
> you still used "start from bunch of singleton sublist, elongating twice
> per round as we go" structure from the original.

It's just becasue the dumb bottom-up approach is the most simple way to
implement merge sort.

> I wonder if it would be an improvement if you structured the loop so that:
> 
>   (1) the first sublist 'p' grabs as many elements in the ascending order
>       as you find;
> 
>   (2) the second sublist 'q' begins at the end of the first sublist and
>       grabs as many elements in the ascending order;
> 
>   (3) 'p' and 'q' are merge-sorted into the result list;
> 
>   (4) if your two sublists did not cover "list" in its entirety, process
>       the remainder (i.e. where the second sublist stopped because of an
>       unordered element) by going back to step (1); and
> 
>   (5) if you did not need to jump back to step (1) from step (4), then you
>       had only two sublists (or less), so the result is sorted.  Otherwise,
>       the result now has fewer ascending sublists than the original, so go
>       back to (1) and iterate.
> 
> If the input is in a random order, this may end up doing the same number
> of iterations as the original, but if the input is mostly sorted, wouldn't
> it allow us to take advantage of the fact by starting with a longer
> sublist in the earlier rounds?

This optimization speeds up the pre-sorted case but slows down the case of
a reversed pre-sorted list because we have to determine the length of the
sublists each time, while the dumb implementation already knows it.  I
didn't measure a significant difference for Jeff's test case.  Here's my
attempt at an implementation, for reference.

---
 mergesort.c |   61 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/mergesort.c b/mergesort.c
index c0f1874..3a61b9b 100644
--- a/mergesort.c
+++ b/mergesort.c
@@ -8,12 +8,37 @@ struct mergesort_sublist {
 	unsigned long len;
 };
 
-static void *get_nth_next(void *list, unsigned long n,
-			  void *(*get_next_fn)(const void *))
+static unsigned long run_length(const void *list,
+				struct mergesort_sublist *next_list,
+				void *(*get_next_fn)(const void *),
+				int (*compare_fn)(const void *, const void *))
 {
-	while (n-- && list)
-		list = get_next_fn(list);
-	return list;
+	unsigned long len = 1;
+
+	if (!list)
+		return 0;
+	for (;;) {
+		void *next = get_next_fn(list);
+
+		if (!next || compare_fn(list, next) > 0) {
+			if (next_list)
+				next_list->ptr = next;
+			break;
+		}
+		list = next;
+		len++;
+	}
+	return len;
+}
+
+static void set_next_pair(struct mergesort_sublist *p,
+			  struct mergesort_sublist *q, void *list,
+			  void *(*get_next_fn)(const void *),
+			  int (*compare_fn)(const void *, const void *))
+{
+	p->ptr = list;
+	p->len = run_length(p->ptr, q, get_next_fn, compare_fn);
+	q->len = q->ptr ? run_length(q->ptr, NULL, get_next_fn, compare_fn) : 0;
 }
 
 static void *pop_item(struct mergesort_sublist *l,
@@ -30,24 +55,16 @@ void *mergesort(void *list,
 		void (*set_next_fn)(void *, void *),
 		int (*compare_fn)(const void *, const void *))
 {
-	unsigned long l;
-
 	if (!list)
 		return NULL;
-	for (l = 1; ; l *= 2) {
+	for (;;) {
 		void *curr;
 		struct mergesort_sublist p, q;
 
-		p.ptr = list;
-		q.ptr = get_nth_next(p.ptr, l, get_next_fn);
+		set_next_pair(&p, &q, list, get_next_fn, compare_fn);
 		if (!q.ptr)
 			break;
-		p.len = q.len = l;
-
-		if (compare_fn(p.ptr, q.ptr) > 0)
-			list = curr = pop_item(&q, get_next_fn);
-		else
-			list = curr = pop_item(&p, get_next_fn);
+		list = curr = pop_item(&q, get_next_fn);
 
 		while (p.ptr) {
 			while (p.len || q.len) {
@@ -63,10 +80,14 @@ void *mergesort(void *list,
 					curr = pop_item(&p, get_next_fn);
 				set_next_fn(prev, curr);
 			}
-			p.ptr = q.ptr;
-			p.len = l;
-			q.ptr = get_nth_next(p.ptr, l, get_next_fn);
-			q.len = q.ptr ? l : 0;
+
+			set_next_pair(&p, &q, q.ptr, get_next_fn, compare_fn);
+			if (q.ptr) {
+				void *prev = curr;
+
+				curr = pop_item(&q, get_next_fn);
+				set_next_fn(prev, curr);
+			}
 
 		}
 		set_next_fn(curr, NULL);
-- 
1.7.10
