From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 1/4] diffcore-order: Export generic ordering interface
Date: Mon, 20 Jan 2014 20:20:38 +0400
Message-ID: <0fb4f53ca93de6ec8f6f11e9fbbe6199ea900f2c.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 17:34:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Ho1-0003B2-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 17:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbaATQe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 11:34:26 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60902 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbaATQeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 11:34:23 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1W5HZ2-0007Vg-Pq; Mon, 20 Jan 2014 20:19:04 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1W5Hax-0001Pw-28; Mon, 20 Jan 2014 20:21:03 +0400
X-Mailer: git-send-email 1.9.rc0.143.g6fd479e
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240715>

At present, diffcore_order() interface is to accept only queue of
`struct diff_filepair`.

In the next patches, we'll need to order `struct combine_diff_path` by path,
so let's first rework diffcore-order to also provide generic low-level
interface for ordering arbitrary objects, provided they have path accessors.

The new interface is:

    - `struct obj_order`    for describing objects to ordering routine, and
    - order_objects()       for actually doing the ordering work.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 diffcore-order.c | 53 +++++++++++++++++++++++++++++++++++------------------
 diffcore.h       | 15 +++++++++++++++
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/diffcore-order.c b/diffcore-order.c
index fe7f1f4..327a93e 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -57,11 +57,7 @@ static void prepare_order(const char *orderfile)
 	}
 }
 
-struct pair_order {
-	struct diff_filepair *pair;
-	int orig_order;
-	int order;
-};
+
 
 static int match_order(const char *path)
 {
@@ -84,35 +80,56 @@ static int match_order(const char *path)
 	return order_cnt;
 }
 
-static int compare_pair_order(const void *a_, const void *b_)
+static int compare_objs_order(const void *a_, const void *b_)
 {
-	struct pair_order const *a, *b;
-	a = (struct pair_order const *)a_;
-	b = (struct pair_order const *)b_;
+	struct obj_order const *a, *b;
+	a = (struct obj_order const *)a_;
+	b = (struct obj_order const *)b_;
 	if (a->order != b->order)
 		return a->order - b->order;
 	return a->orig_order - b->orig_order;
 }
 
+
+void order_objects(const char *orderfile, obj_path_fn_t obj_path,
+			struct obj_order *objs, int nr)
+{
+	int i;
+
+	if (!nr)
+		return;
+
+	prepare_order(orderfile);
+	for (i = 0; i < nr; i++) {
+		objs[i].orig_order = i;
+		objs[i].order = match_order(obj_path(objs[i].obj));
+	}
+	qsort(objs, nr, sizeof(*objs), compare_objs_order);
+}
+
+
+static const char *pair_pathtwo(void *obj)
+{
+	struct diff_filepair *pair = (struct diff_filepair *)obj;
+
+	return pair->two->path;
+}
+
 void diffcore_order(const char *orderfile)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct pair_order *o;
+	struct obj_order *o;
 	int i;
 
 	if (!q->nr)
 		return;
 
 	o = xmalloc(sizeof(*o) * q->nr);
-	prepare_order(orderfile);
-	for (i = 0; i < q->nr; i++) {
-		o[i].pair = q->queue[i];
-		o[i].orig_order = i;
-		o[i].order = match_order(o[i].pair->two->path);
-	}
-	qsort(o, q->nr, sizeof(*o), compare_pair_order);
 	for (i = 0; i < q->nr; i++)
-		q->queue[i] = o[i].pair;
+		o[i].obj = q->queue[i];
+	order_objects(orderfile, pair_pathtwo, o, q->nr);
+	for (i = 0; i < q->nr; i++)
+		q->queue[i] = o[i].obj;
 	free(o);
 	return;
 }
diff --git a/diffcore.h b/diffcore.h
index 1c16c85..1fd00fc 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -111,6 +111,21 @@ extern void diffcore_merge_broken(void);
 extern void diffcore_pickaxe(struct diff_options *);
 extern void diffcore_order(const char *orderfile);
 
+/* low-level interface to diffcore_order */
+struct obj_order {
+	void *obj;	/* setup by caller */
+
+	/* setup/used by order_objects() */
+	int orig_order;
+	int order;
+};
+
+typedef const char *(*obj_path_fn_t)(void *obj);
+
+void order_objects(const char *orderfile, obj_path_fn_t obj_path,
+			struct obj_order *objs, int nr);
+
+
 #define DIFF_DEBUG 0
 #if DIFF_DEBUG
 void diff_debug_filespec(struct diff_filespec *, int, const char *);
-- 
1.9.rc0.143.g6fd479e
