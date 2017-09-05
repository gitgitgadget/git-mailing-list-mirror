Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A199208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdIEMPE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:15:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:15:02 -0400
Received: (qmail 31386 invoked by uid 109); 5 Sep 2017 12:15:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:15:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12370 invoked by uid 111); 5 Sep 2017 12:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:15:00 -0400
Date:   Tue, 5 Sep 2017 08:15:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 15/20] tempfile: use list.h for linked list
Message-ID: <20170905121500.sl5vvgnguux4mtn5@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tempfile API keeps to-be-cleaned tempfiles in a
singly-linked list and never removes items from the list.  A
future patch would like to start removing items, but removal
from a singly linked list is O(n), as we have to walk the
list to find the predecessor element. This means that a
process which takes "n" simultaneous lockfiles (for example,
an atomic transaction on "n" refs) may end up quadratic in
"n".

Before we start allowing items to be removed, it would be
nice to have a way to cover this case in linear time.

The simplest solution is to make an assumption about the
order in which tempfiles are added and removed from the
list. If both operations iterate over the tempfiles in the
same order, then by putting new items at the end of the list
our removal search will always find its items at the
beginning of the list. And indeed, that would work for the
case of refs. But it creates a hidden dependency between
unrelated parts of the code. If anybody changes the ref code
(or if we add a new caller that opens multiple simultaneous
tempfiles) they may unknowingly introduce a performance
regression.

Another solution is to use a better data structure. A
doubly-linked list works fine, and we already have an
implementation in list.h. But there's one snag: the elements
of "struct tempfile" are all marked as "volatile", since a
signal handler may interrupt us and iterate over the list at
any moment (even if we were in the middle of adding a new
entry).

We can declare a "volatile struct list_head", but we can't
actually use it with the normal list functions. The compiler
complains about passing a pointer-to-volatile via a regular
pointer argument. And rightfully so, as the sub-function
would potentially need different code to deal with the
volatile case.

That leaves us with a few options:

  1. Drop the "volatile" modifier for the list items.

     This is probably a bad idea. I checked the assembly
     output from "gcc -O2", and the "volatile" really does
     impact the order in which it updates memory.

  2. Use macros instead of inline functions. The irony here
     is that list.h is entirely implemented as trivial
     inline functions. So we basically are already
     generating custom code for each call. But sadly there's no
     way in C to declare the inline function to take a more
     generic type.

     We could do so by switching the inline functions to
     macros, but it does make the end result harder to read.
     And it doesn't fully solve the problem (for instance,
     the declaration of list_head needs to change so that
     its "prev" and "next" pointers point to other volatile
     structs).

  3. Don't use list.h, and just make our own ad-hoc
     doubly-linked list. It's not that much code to
     implement the basics that we need here. But if we're
     going to do so, why not add the few extra lines
     required to model it after the actual list.h interface?
     We can even reuse a few of the macro helpers.

So this patch takes option 3, but actually implements a
parallel "volatile list" interface in list.h, where it could
potentially be reused by other code. This implements just
enough for tempfile.c's use, though we could easily port
other functions later if need be.

Signed-off-by: Jeff King <peff@peff.net>
---
 list.h     | 38 ++++++++++++++++++++++++++++++++++++++
 tempfile.c | 13 +++++++------
 tempfile.h |  4 +++-
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/list.h b/list.h
index a226a870dc..eb601192f4 100644
--- a/list.h
+++ b/list.h
@@ -163,4 +163,42 @@ static inline void list_replace_init(struct list_head *old,
 	INIT_LIST_HEAD(old);
 }
 
+/*
+ * This is exactly the same as a normal list_head, except that it can be
+ * declared volatile (e.g., if you have a list that may be accessed from signal
+ * handlers).
+ */
+struct volatile_list_head {
+	volatile struct volatile_list_head *next, *prev;
+};
+
+#define VOLATILE_LIST_HEAD(name) \
+	volatile struct volatile_list_head name = { &(name), &(name) }
+
+static inline void __volatile_list_del(volatile struct volatile_list_head *prev,
+				       volatile struct volatile_list_head *next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+static inline void volatile_list_del(volatile struct volatile_list_head *elem)
+{
+	__volatile_list_del(elem->prev, elem->next);
+}
+
+static inline int volatile_list_empty(volatile struct volatile_list_head *head)
+{
+	return head == head->next;
+}
+
+static inline void volatile_list_add(volatile struct volatile_list_head *newp,
+				     volatile struct volatile_list_head *head)
+{
+	head->next->prev = newp;
+	newp->next = head->next;
+	newp->prev = head;
+	head->next = newp;
+}
+
 #endif /* LIST_H */
diff --git a/tempfile.c b/tempfile.c
index e655e28477..11bda824cf 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -55,14 +55,16 @@
 #include "tempfile.h"
 #include "sigchain.h"
 
-static struct tempfile *volatile tempfile_list;
+static VOLATILE_LIST_HEAD(tempfile_list);
 
 static void remove_tempfiles(int in_signal_handler)
 {
 	pid_t me = getpid();
-	struct tempfile *volatile p;
+	volatile struct volatile_list_head *pos;
+
+	list_for_each(pos, &tempfile_list) {
+		struct tempfile *p = list_entry(pos, struct tempfile, list);
 
-	for (p = tempfile_list; p; p = p->next) {
 		if (!is_tempfile_active(p) || p->owner != me)
 			continue;
 
@@ -95,7 +97,7 @@ static void remove_tempfiles_on_signal(int signo)
  */
 static void prepare_tempfile_object(struct tempfile *tempfile)
 {
-	if (!tempfile_list) {
+	if (volatile_list_empty(&tempfile_list)) {
 		/* One-time initialization */
 		sigchain_push_common(remove_tempfiles_on_signal);
 		atexit(remove_tempfiles_on_exit);
@@ -110,8 +112,7 @@ static void prepare_tempfile_object(struct tempfile *tempfile)
 		tempfile->active = 0;
 		tempfile->owner = 0;
 		strbuf_init(&tempfile->filename, 0);
-		tempfile->next = tempfile_list;
-		tempfile_list = tempfile;
+		volatile_list_add(&tempfile->list, &tempfile_list);
 		tempfile->on_list = 1;
 	} else if (tempfile->filename.len) {
 		/* This shouldn't happen, but better safe than sorry. */
diff --git a/tempfile.h b/tempfile.h
index d30663182d..2ee24f4380 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -1,6 +1,8 @@
 #ifndef TEMPFILE_H
 #define TEMPFILE_H
 
+#include "list.h"
+
 /*
  * Handle temporary files.
  *
@@ -81,7 +83,7 @@
  */
 
 struct tempfile {
-	struct tempfile *volatile next;
+	volatile struct volatile_list_head list;
 	volatile sig_atomic_t active;
 	volatile int fd;
 	FILE *volatile fp;
-- 
2.14.1.721.gc5bc1565f1

