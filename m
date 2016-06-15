From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 06/11] ref-filter: implement '--merged' and '--no-merged' options
Date: Thu, 25 Jun 2015 14:27:08 +0530
Message-ID: <1435222633-32007-6-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 10:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82yk-0000ZN-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbbFYI5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:57:46 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36517 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbFYI5n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:57:43 -0400
Received: by pdcu2 with SMTP id u2so49321612pdc.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=htIADNADBzzAWYCicg3aTf3z7IVUkB9/DS74u9LMc6g=;
        b=lEHMHcmVuEZdebwiZT4lifQ5V4Hm/FieFJIe7Z6EcrY3vVWFvK7tFbKe0w7KpDjUYs
         OJjfVs9/ORmttceIGesfa2U1/H7OO1ukNS+lm5hb+bB61WWIp/g7h4iguOoKHsr1H6HE
         yMdBu0OpW5ZxZ8AiWTrJNDsQZqNjsHGhCNDvai9/kXBrkQLDRYPyqucc+lWu8UYwyA9y
         ZR9N+zmPYXV4OrLr44Ay2SYmxLxyix0g1LABhhAT3iZ4JVeOWh3qvo5gZ1axezgchTzC
         QWYTBwz0iGWcATmq8Jtgb7rPieakbRfH7/G9Tq6/NzciWNjCkcroc/AoWFr+3cf35aTX
         lJow==
X-Received: by 10.68.65.6 with SMTP id t6mr19575285pbs.94.1435222662677;
        Thu, 25 Jun 2015 01:57:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id wa4sm29391000pab.17.2015.06.25.01.57.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 01:57:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272646>

In 'branch -l' we have '--merged' option which only lists refs (branches)
merged into the named commit and '--no-merged' option which only lists
refs (branches) not merged into the named commit. Implement these two
options in ref-filter.{c,h} so that other commands can benefit from this.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 ref-filter.h |  8 +++++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0c2d67c..2f20cb3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -9,6 +9,7 @@
 #include "tag.h"
 #include "quote.h"
 #include "ref-filter.h"
+#include "revision.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -889,6 +890,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
+	struct commit *commit = NULL;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -902,11 +904,23 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 
 	/*
+	 * A merge filter is applied on refs pointing to commits. Hence
+	 * obtain the commit using the 'oid' available and discard all
+	 * non-commits early. The actual filtering is done later.
+	 */
+	if (filter->merge_commit) {
+		commit = lookup_commit_reference_gently(oid->hash, 1);
+		if (!commit)
+			return 0;
+	}
+
+	/*
 	 * We do not open the object yet; sort may only need refname
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
 	ref = new_ref_array_item(refname, oid->hash, flag);
+	ref->commit = commit;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
@@ -932,6 +946,50 @@ void ref_array_clear(struct ref_array *array)
 	array->nr = array->alloc = 0;
 }
 
+static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
+{
+	struct rev_info revs;
+	int i, old_nr;
+	struct ref_filter *filter = ref_cbdata->filter;
+	struct ref_array *array = ref_cbdata->array;
+	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
+
+	init_revisions(&revs, NULL);
+
+	for (i = 0; i < array->nr; i++) {
+		struct ref_array_item *item = array->items[i];
+		add_pending_object(&revs, &item->commit->object, item->refname);
+		to_clear[i] = item->commit;
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
+	for (i = 0; i < old_nr; i++)
+		clear_commit_marks(to_clear[i], ALL_REV_FLAGS);
+	clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
+	free(to_clear);
+}
+
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
@@ -941,17 +999,24 @@ void ref_array_clear(struct ref_array *array)
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
 {
 	struct ref_filter_cbdata ref_cbdata;
+	int ret = 0;
 
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
+	/*  Simple per-ref filtering */
 	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
-		return for_each_rawref(ref_filter_handler, &ref_cbdata);
+		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
-		return for_each_ref(ref_filter_handler, &ref_cbdata);
-	else
+		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type)
 		die("filter_refs: invalid type");
-	return 0;
+
+	/*  Filters that need revision walking */
+	if (filter->merge_commit)
+		do_merge_filter(&ref_cbdata);
+
+	return ret;
 }
 
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
diff --git a/ref-filter.h b/ref-filter.h
index ad2902b..7241a1d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -31,6 +31,7 @@ struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
 	const char *symref;
+	struct commit *commit;
 	struct atom_value *value;
 	char refname[FLEX_ARRAY];
 };
@@ -43,6 +44,13 @@ struct ref_array {
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
2.4.4
