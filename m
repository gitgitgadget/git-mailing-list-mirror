From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 06/11] ref-filter: implement '--merged' and '--no-merged' options
Date: Thu, 25 Jun 2015 01:23:47 +0530
Message-ID: <1435175632-27803-6-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
 <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 21:54:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qkY-0007v3-VA
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbbFXTyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:54:19 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35418 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbbFXTyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:54:15 -0400
Received: by pdbci14 with SMTP id ci14so37062285pdb.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=htIADNADBzzAWYCicg3aTf3z7IVUkB9/DS74u9LMc6g=;
        b=aF1RuOx8MjO4DVCxPyZruZBNmcln4DFj4I9BygKhaEu2+8I2PIkPe70GR64hHJPTYt
         u9oYGbxyURGPrSstXK5wASVAmpPPxYE+J8DQCuRnJkXDAj8V3vnd8tnpMWrxw8wu18s1
         qpMaa8sf5UxPL6+VKo8k5e0KyC0NZMTOPDXMhgCc25HEu9IH214A+Iwvmf+rcvlqWZKu
         oDPK0VjwJn9fhbEGubVQLb0gbETmqS5708WWHdajZYomHkUuzgz5733cEI3TWsYKTb9H
         FBzdlSaohFlWBrG1GmqvL/D3e3cizZiHItVxdwWyfurGFjOkGbMelgvH1gGOrSN2a45X
         gGEQ==
X-Received: by 10.69.19.202 with SMTP id gw10mr47609841pbd.72.1435175655251;
        Wed, 24 Jun 2015 12:54:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id zx1sm27583483pbb.73.2015.06.24.12.54.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:54:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272595>

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
