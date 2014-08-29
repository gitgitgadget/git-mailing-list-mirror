From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] index-pack: fix race condition with duplicate bases
Date: Fri, 29 Aug 2014 16:57:47 -0400
Message-ID: <20140829205746.GA7060@peff.net>
References: <20140829205538.GD29456@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:57:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNTF5-0001Kf-0f
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbaH2U5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 16:57:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:33417 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751081AbaH2U5t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 16:57:49 -0400
Received: (qmail 4679 invoked by uid 102); 29 Aug 2014 20:57:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 15:57:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 16:57:47 -0400
Content-Disposition: inline
In-Reply-To: <20140829205538.GD29456@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256193>

When we are resolving deltas in an indexed pack, we do it by
first selecting a potential base (either one stored in full
in the pack, or one created by resolving another delta), and
then resolving any deltas that use that base.  When we
resolve a particular delta, we flip its "real_type" field
from OBJ_{REF,OFS}_DELTA to whatever the real type is.

We assume that traversing the objects this way will visit
each delta only once. This is correct for most packs; we
visit the delta only when we process its base, and each
object (and thus each base) appears only once. However, if a
base object appears multiple times in the pack, we will try
to resolve any deltas based on it once for each instance.

We can detect this case by noting that a delta we are about
to resolve has already had its real_type field flipped, and
we already do so with an assert().  However, if multiple
threads are in use, we may race with another thread on
comparing and flipping the field. We need to synchronize the
access.

The right mechanism for doing this is a compare-and-swap (we
atomically "claim" the delta for our own and find out
whether our claim was successful). We can implement this
in C by using a pthread mutex to protect the operation. This
is not the fastest way of doing a compare-and-swap; many
processors provide instructions for this, and gcc and other
compilers provide builtins to access them. However, some
experiments showed that lock contention does not cause a
significant slowdown here. Adding c-a-s support for many
compilers would increase the maintenance burden (and we
would still end up including the pthread version as a
fallback).

Note that we only need to touch the OBJ_REF_DELTA codepath
here. An OBJ_OFS_DELTA object points to its base using an
offset, and therefore has only one base, even if another
copy of that base object appears in the pack (we do still
touch it briefly because the setting of real_type is
factored out of resolve_data).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5568a5b..eebf1a8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -112,6 +112,10 @@ static pthread_mutex_t deepest_delta_mutex;
 #define deepest_delta_lock()	lock_mutex(&deepest_delta_mutex)
 #define deepest_delta_unlock()	unlock_mutex(&deepest_delta_mutex)
 
+static pthread_mutex_t type_cas_mutex;
+#define type_cas_lock()		lock_mutex(&type_cas_mutex)
+#define type_cas_unlock()	unlock_mutex(&type_cas_mutex)
+
 static pthread_key_t key;
 
 static inline void lock_mutex(pthread_mutex_t *mutex)
@@ -135,6 +139,7 @@ static void init_thread(void)
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
+	pthread_mutex_init(&type_cas_mutex, NULL);
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
@@ -157,6 +162,7 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
+	pthread_mutex_destroy(&type_cas_mutex);
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
 	for (i = 0; i < nr_threads; i++)
@@ -862,7 +868,6 @@ static void resolve_delta(struct object_entry *delta_obj,
 {
 	void *base_data, *delta_data;
 
-	delta_obj->real_type = base->obj->real_type;
 	if (show_stat) {
 		delta_obj->delta_depth = base->obj->delta_depth + 1;
 		deepest_delta_lock();
@@ -888,6 +893,26 @@ static void resolve_delta(struct object_entry *delta_obj,
 	counter_unlock();
 }
 
+/*
+ * Standard boolean compare-and-swap: atomically check whether "*type" is
+ * "want"; if so, swap in "set" and return true. Otherwise, leave it untouched
+ * and return false.
+ */
+static int compare_and_swap_type(enum object_type *type,
+				 enum object_type want,
+				 enum object_type set)
+{
+	enum object_type old;
+
+	type_cas_lock();
+	old = *type;
+	if (old == want)
+		*type = set;
+	type_cas_unlock();
+
+	return old == want;
+}
+
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
@@ -915,7 +940,10 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 		struct object_entry *child = objects + deltas[base->ref_first].obj_no;
 		struct base_data *result = alloc_base_data();
 
-		assert(child->real_type == OBJ_REF_DELTA);
+		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
+					   base->obj->real_type))
+			die("BUG: child->real_type != OBJ_REF_DELTA");
+
 		resolve_delta(child, base, result);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
@@ -929,6 +957,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 		struct base_data *result = alloc_base_data();
 
 		assert(child->real_type == OBJ_OFS_DELTA);
+		child->real_type = base->obj->real_type;
 		resolve_delta(child, base, result);
 		if (base->ofs_first == base->ofs_last)
 			free_base_data(base);
-- 
2.1.0.346.ga0367b9
