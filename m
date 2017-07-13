Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB7F202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdGMRfg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:11019 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752525AbdGMRff (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:35 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A4127844EA;
        Thu, 13 Jul 2017 13:35:34 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F1AA1844E5;
        Thu, 13 Jul 2017 13:35:33 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 06/19] list-objects-filters: add use-sparse-checkout filter
Date:   Thu, 13 Jul 2017 17:34:46 +0000
Message-Id: <20170713173459.3559-7-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a filter for traverse_commit_list_filtered() to omit the
blobs that would not be needed by a sparse checkout using the
given sparse-checkout spec.

This filter will be used in a future commit by rev-list and
pack-objects for partial/narrow clone/fetch.

A future enhancement should be able to also omit tree objects
not needed by such a sparse checkout, but that is not currently
supported.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 list-objects-filters.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
 list-objects-filters.h |  16 +++++
 2 files changed, 195 insertions(+)

diff --git a/list-objects-filters.c b/list-objects-filters.c
index f04d70e..cacf645 100644
--- a/list-objects-filters.c
+++ b/list-objects-filters.c
@@ -180,3 +180,182 @@ void traverse_commit_list_omit_large_blobs(
 
 	oidset2_clear(&d.omits);
 }
+
+/*
+ * A filter driven by a sparse-checkout specification to only
+ * include blobs that a sparse checkout would populate.
+ *
+ * The sparse-checkout spec is loaded from the blob with the
+ * given OID (rather than .git/info/sparse-checkout) because
+ * the repo may be bare.
+ */
+struct frame {
+	int defval;
+	int child_prov_omit : 1;
+};
+
+struct filter_use_sparse_data {
+	struct oidset2 omits;
+	struct exclude_list el;
+
+	size_t nr, alloc;
+	struct frame *array_frame;
+};
+
+static list_objects_filter_result filter_use_sparse(
+	list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_use_sparse_data *filter_data = filter_data_;
+	int64_t object_length = -1;
+	int val, dtype;
+	unsigned long s;
+	enum object_type t;
+	struct frame *frame;
+
+	switch (filter_type) {
+	default:
+		die("unkown filter_type");
+		return LOFR_ZERO;
+
+	case LOFT_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		dtype = DT_DIR;
+		val = is_excluded_from_list(pathname, strlen(pathname),
+					    filename, &dtype, &filter_data->el);
+		if (val < 0)
+			val = filter_data->array_frame[filter_data->nr].defval;
+
+		ALLOC_GROW(filter_data->array_frame, filter_data->nr + 1,
+			   filter_data->alloc);
+		filter_data->nr++;
+		filter_data->array_frame[filter_data->nr].defval = val;
+		filter_data->array_frame[filter_data->nr].child_prov_omit = 0;
+
+		/*
+		 * A directory with this tree OID may appear in multiple
+		 * places in the tree. (Think of a directory move, with
+		 * no other changes.)  And with a different pathname, the
+		 * is_excluded...() results for this directory and items
+		 * contained within it may be different.  So we cannot
+		 * mark it SEEN (yet), since that will prevent process_tree()
+		 * from revisiting this tree object with other pathnames.
+		 *
+		 * Only SHOW the tree object the first time we visit this
+		 * tree object.
+		 *
+		 * We always show all tree objects.  A future optimization
+		 * may want to attempt to narrow this.
+		 */
+		if (obj->flags & FILTER_REVISIT)
+			return LOFR_ZERO;
+		obj->flags |= FILTER_REVISIT;
+		return LOFR_SHOW;
+
+	case LOFT_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		assert(filter_data->nr > 0);
+
+		frame = &filter_data->array_frame[filter_data->nr];
+		filter_data->nr--;
+
+		/*
+		 * Tell our parent directory if any of our children were
+		 * provisionally omitted.
+		 */
+		filter_data->array_frame[filter_data->nr].child_prov_omit |=
+			frame->child_prov_omit;
+
+		/*
+		 * If there are NO provisionally omitted child objects (ALL child
+		 * objects in this folder were INCLUDED), then we can mark the
+		 * folder as SEEN (so we will not have to revisit it again).
+		 */
+		if (!frame->child_prov_omit)
+			return LOFR_MARK_SEEN;
+		return LOFR_ZERO;
+
+	case LOFT_BLOB:
+		assert(obj->type == OBJ_BLOB);
+		assert((obj->flags & SEEN) == 0);
+
+		frame = &filter_data->array_frame[filter_data->nr];
+
+		/*
+		 * If we previously provisionally omitted this blob because
+		 * its pathname was not in the sparse-checkout AND this
+		 * reference to the blob has the same pathname, we can avoid
+		 * repeating the exclusion logic on this pathname and just
+		 * continue to provisionally omit it.
+		 */
+		if (obj->flags & FILTER_REVISIT) {
+			struct oidset2_entry *entry_prev;
+			entry_prev = oidset2_get(&filter_data->omits, &obj->oid);
+			if (entry_prev && !strcmp(pathname, entry_prev->pathname)) {
+				frame->child_prov_omit = 1;
+				return LOFR_ZERO;
+			}
+		}
+
+		dtype = DT_REG;
+		val = is_excluded_from_list(pathname, strlen(pathname),
+					    filename, &dtype, &filter_data->el);
+		if (val < 0)
+			val = frame->defval;
+		if (val > 0)
+			return LOFR_MARK_SEEN | LOFR_SHOW;
+
+		t = sha1_object_info(obj->oid.hash, &s);
+		assert(t == OBJ_BLOB);
+		object_length = (int64_t)((uint64_t)(s));
+
+		/*
+		 * Provisionally omit it.  We've already established that
+		 * this pathname is not in the sparse-checkout specification,
+		 * so we WANT to omit this blob.  However, a pathname elsewhere
+		 * in the tree may also reference this same blob, so we cannot
+		 * reject it yet.  Leave the LOFR_ bits unset so that if the
+		 * blob appears again in the traversal, we will be asked again.
+		 *
+		 * The pathname we associate with this omit is just the first
+		 * one we saw for this blob.  Other instances of this blob may
+		 * have other pathnames and that is fine.  We just use it for
+		 * perf because most of the time, the blob will be in the same
+		 * place as we walk the commits.
+		 */
+		oidset2_insert(&filter_data->omits, &obj->oid, object_length,
+			       pathname);
+		obj->flags |= FILTER_REVISIT;
+		frame->child_prov_omit = 1;
+		return LOFR_ZERO;
+	}
+}
+
+void traverse_commit_list_use_sparse(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *ctx_data,
+	struct object_id *oid)
+{
+	struct filter_use_sparse_data d;
+
+	memset(&d, 0, sizeof(d));
+	if (add_excludes_from_blob_to_list(oid, NULL, 0, &d.el) < 0)
+		die("filter_use_sparse could not load specification");
+	ALLOC_GROW(d.array_frame, d.nr + 1, d.alloc);
+	d.array_frame[d.nr].defval = 0; /* default to include */
+	d.array_frame[d.nr].child_prov_omit = 0;
+
+	traverse_commit_list_filtered(revs, show_commit, show_object, ctx_data,
+				      filter_use_sparse, &d);
+
+	if (print_omitted_object)
+		oidset2_foreach(&d.omits, print_omitted_object, ctx_data);
+
+	oidset2_clear(&d.omits);
+}
diff --git a/list-objects-filters.h b/list-objects-filters.h
index 32b2833..52e507b 100644
--- a/list-objects-filters.h
+++ b/list-objects-filters.h
@@ -26,4 +26,20 @@ void traverse_commit_list_omit_large_blobs(
 	void *ctx_data,
 	int64_t large_byte_limit);
 
+/*
+ * A filter driven by a sparse-checkout specification to only
+ * include blobs that a sparse checkout would populate.
+ *
+ * The sparse-checkout spec is loaded from the blob with the
+ * given OID (rather than .git/info/sparse-checkout) because
+ * the repo may be bare.
+ */
+void traverse_commit_list_use_sparse(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *ctx_data,
+	struct object_id *oid);
+
 #endif /* LIST_OBJECTS_FILTERS_H */
-- 
2.9.3

