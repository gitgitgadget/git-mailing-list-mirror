From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 5/9] ref-filter: implement '--merged' and '--no-merged' options
Date: Sun,  7 Jun 2015 01:34:08 +0530
Message-ID: <1433621052-5588-5-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKd-0002Lu-2Q
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbbFFUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:35 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:34664 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbbFFUEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:31 -0400
Received: by pdbht2 with SMTP id ht2so13524805pdb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1CESnaZn1Ngu6p31OYH1v/Kpa9ONCuTEusDYbcvCSKU=;
        b=x0H/XAzTrEoy0UBMkD+jiKyca9So7s/6MR31vEGBNdiy36dwCKfQREoDmIyEiLdf2N
         guIKUB8P+MxFOGOw5x8aSgbPL54JhF6N69U31KCEsyAnFfjj943LDj2rKzjnJrh5RXTh
         U7kCI3Wtex9VrFvXMoJhqhirI+1h78z0tOBgCU8WfSzR/d5rn7qXPMRnFiG+MqlSIkAk
         VyL4UWtXraD6MsoTJ/DOaKYnRLWMMZy9xLusTaFln66JFDJ3fc21dezKzomG61kPJmB3
         Pb6f7kkkoO378JClI36TyhDkFcXrHJc985uQp+X70hIU6DpAI4PmPBl0z/wti4vkD7Bf
         ENYQ==
X-Received: by 10.68.161.4 with SMTP id xo4mr16406765pbb.65.1433621070702;
        Sat, 06 Jun 2015 13:04:30 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270948>

In 'branch -l' we have '--merged' option which only lists refs (branches)
merged into the named commit and '--no-merged' option which only lists
refs (branches) not merged into the named commit will be listed. Implement
these two options in ref-filter.{c,h} so that other commands can benefit
from this.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 ref-filter.h |  8 ++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 456b0fa..2be9df2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -9,6 +9,7 @@
 #include "tag.h"
 #include "quote.h"
 #include "ref-filter.h"
+#include "revision.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -888,6 +889,7 @@ int ref_filter_handler(const char *refname, const struct object_id *oid, int fla
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = &ref_cbdata->filter;
 	struct ref_array_item *ref;
+	struct commit *commit = NULL;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -900,12 +902,19 @@ int ref_filter_handler(const char *refname, const struct object_id *oid, int fla
 	if (!match_points_at(&filter->points_at, oid->hash, refname))
 		return 0;
 
+	if(filter->merge_commit) {
+		commit = lookup_commit_reference_gently(sha1, 1);
+		if (!commit)
+			return 0;
+	}
+
 	/*
 	 * We do not open the object yet; sort may only need refname
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
 	ref = new_ref_array_item(refname, oid->hash, flag);
+	ref->commit = commit;
 
 	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
 	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
@@ -931,6 +940,50 @@ void ref_array_clear(struct ref_array *array)
 	array->nr = array->alloc = 0;
 }
 
+static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
+{
+	struct rev_info revs;
+	int i, old_nr;
+	struct ref_filter *filter = &ref_cbdata->filter;
+	struct ref_array *array = &ref_cbdata->array;
+	struct commit_list *p, *to_clear = NULL;
+
+	init_revisions(&revs, NULL);
+
+	for (i = 0; i < array->nr; i++) {
+		struct ref_array_item *item = array->items[i];
+		add_pending_object(&revs, &item->commit->object, item->refname);
+		commit_list_insert(item->commit, &to_clear);
+	}
+
+	filter->merge_commit->object.flags |= UNINTERESTING;
+	add_pending_object(&revs, &filter->merge_commit->object, "");
+
+	revs.limited = 1;
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+
+	old_nr = array->nr;
+	array->nr = 0;
+
+	for (i = 0; i < old_nr; i++) {
+		struct ref_array_item *item = array->items[i];
+		struct commit *commit = item->commit;
+
+		int is_merged = !!(commit->object.flags & UNINTERESTING);
+
+		if (is_merged == (filter->merge == REF_FILTER_MERGED_INCLUDE))
+			array->items[array->nr++] = array->items[i];
+		else
+			free_array_item(item);
+	}
+
+	for (p = to_clear; p; p = p->next)
+		clear_commit_marks(p->item, ALL_REV_FLAGS);
+	clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
+	free_commit_list(to_clear);
+}
+
 /*
  * API for filtering a set of refs. The refs are provided and iterated
  * over using the for_each_ref_fn(). The refs are stored into and filtered
@@ -938,7 +991,13 @@ void ref_array_clear(struct ref_array *array)
  */
 int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data)
 {
-	return for_each_ref_fn(ref_filter_handler, data);
+	int ret;
+
+	ret = for_each_ref_fn(ref_filter_handler, data);
+	if (data->filter.merge_commit)
+		do_merge_filter(data);
+
+	return ret;
 }
 
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
diff --git a/ref-filter.h b/ref-filter.h
index a8980e7..622b942 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -28,6 +28,7 @@ struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
 	char *symref;
+	struct commit *commit;
 	struct atom_value *value;
 	char refname[FLEX_ARRAY];
 };
@@ -40,6 +41,13 @@ struct ref_array {
 struct ref_filter {
 	const char **name_patterns;
 	struct sha1_array points_at;
+
+	enum {
+		REF_FILTER_MERGED_NONE = 0,
+		REF_FILTER_MERGED_INCLUDE,
+		REF_FILTER_MERGED_OMIT
+	} merge;
+	struct commit *merge_commit;
 };
 
 struct ref_filter_cbdata {
-- 
2.4.2
