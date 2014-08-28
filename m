From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Thu, 28 Aug 2014 18:15:19 -0400
Message-ID: <20140828221518.GA18799@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
 <20140823111804.GA17335@peff.net>
 <53FB66D1.709@web.de>
 <20140828220821.GA31545@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:15:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN7yY-0003Nt-Ee
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 00:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbaH1WPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 18:15:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:32845 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752095AbaH1WPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 18:15:21 -0400
Received: (qmail 1489 invoked by uid 102); 28 Aug 2014 22:15:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 17:15:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 18:15:19 -0400
Content-Disposition: inline
In-Reply-To: <20140828220821.GA31545@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256128>

On Thu, Aug 28, 2014 at 06:08:21PM -0400, Jeff King wrote:

> So we need some kind of mutual exclusion so that only one thread
> proceeds with resolving the delta. The "real_type" check sort-of
> functions in that way (except of course it is not actually thread safe).

Here's a patch which implements that. Since I couldn't replicate the
original problem with helgrind, I am just guessing at whether it
properly fixes it (well, it is more than just a guess; I used my brain
to analyze it, but that is far from foolproof).

It uses a single lock. I did a best-of-five timing of "git index-pack
--verify" on the kernel repo, both before and after. The results ended
up quite similar (both about 57s), though the run-to-run numbers are all
over the place (up to about 65s in the worst case). So maybe it is not
so bad.

As I implemented, I realized that even with the mutex, I really was just
implementing compare_and_swap (and I wrote it that way to make it more
obvious). So if we wanted to, it would be trivial to replace the
"claim_delta" function with a true compare-and-swap instruction if the
compiler and processor support it.

---
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f7dc5b0..ed9e253 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -112,6 +112,10 @@ static pthread_mutex_t deepest_delta_mutex;
 #define deepest_delta_lock()	lock_mutex(&deepest_delta_mutex)
 #define deepest_delta_unlock()	unlock_mutex(&deepest_delta_mutex)
 
+static pthread_mutex_t object_entry_mutex;
+#define object_entry_lock()	lock_mutex(&object_entry_mutex)
+#define object_entry_unlock()	unlock_mutex(&object_entry_mutex)
+
 static pthread_key_t key;
 
 static inline void lock_mutex(pthread_mutex_t *mutex)
@@ -135,6 +139,7 @@ static void init_thread(void)
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
+	pthread_mutex_init(&object_entry_mutex, NULL);
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
@@ -157,6 +162,7 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
+	pthread_mutex_destroy(&object_entry_mutex);
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
@@ -888,6 +893,21 @@ static void resolve_delta(struct object_entry *delta_obj,
 	counter_unlock();
 }
 
+static int claim_delta(struct object_entry *delta_obj,
+		       enum object_type delta_type,
+		       enum object_type base_type)
+{
+	enum object_type old_type;
+
+	object_entry_lock();
+	old_type = delta_obj->real_type;
+	if (old_type == delta_type)
+		delta_obj->real_type = base_type;
+	object_entry_unlock();
+
+	return old_type == delta_type;
+}
+
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
@@ -914,7 +934,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 	if (base->ref_first <= base->ref_last) {
 		struct object_entry *child = objects + deltas[base->ref_first].obj_no;
 
-		if (child->real_type == OBJ_REF_DELTA) {
+		if (claim_delta(child, OBJ_REF_DELTA, base->obj->real_type)) {
 			struct base_data *result = alloc_base_data();
 
 			resolve_delta(child, base, result);
@@ -930,7 +950,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 	if (base->ofs_first <= base->ofs_last) {
 		struct object_entry *child = objects + deltas[base->ofs_first].obj_no;
 
-		if (child->real_type == OBJ_OFS_DELTA) {
+		if (claim_delta(child, OBJ_OFS_DELTA, base->obj->real_type)) {
 			struct base_data *result = alloc_base_data();
 
 			resolve_delta(child, base, result);
