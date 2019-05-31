Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0A11F462
	for <e@80x24.org>; Fri, 31 May 2019 18:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfEaSqP (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:46:15 -0400
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:46900 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbfEaSqP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 14:46:15 -0400
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id WiTahmD6Ad4wBWmXdhgZmG; Fri, 31 May 2019 18:46:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1559328373;
        bh=lCg9KRqk02wCraqyNMWDWs0viuqF86zQSARmTxs+Ick=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=m5Rm8e+qTjHmapc5kvbm0Fk7b/ts0jp/PjV2cA46QM22EZlNELUfB318TyteVmv2v
         c0qIqmYiSribfLOp3D8oTZHEn1l6xsUGwQh7qKvPBRAK3aF45uf3ZC2uCfIylX2AiT
         f3+hauelrVv8FnS0weAK9ZgruE853HSpwCE72eN0vqPNVzLubhIeIPKI+9orimY/aE
         6i14IP5j+R2iwK1oPRuVBSQ33vszmWi1GGHMuKj/0jMZ5LFm9lD25V0S+y+uPvmQhZ
         Qsb36qjBQjO1M2iYliUGLFpBATUrFBbZwMBH/YfVjL+1YX0nkcdLKXmpGvoPZnjIDP
         Nm21cLLlVhVCA==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a4f1:9a8c:7e29:36eb])
        by resomta-po-19v.sys.comcast.net with ESMTPSA
        id WmXWhOnmpmPHJWmXdhWW1U; Fri, 31 May 2019 18:46:13 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Fri, 31 May 2019 11:46:06 -0700
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     matvore@google.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH] list-objects-filter: correct usage of ALLOC_GROW
Message-ID: <20190531184606.GA29730@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the sparse filter data, array_frame array is used in a way such that
nr is the index of the last element. Fix this so that nr is actually the
number of elements in the array.

The filter_sparse_free function also has an unaddressed TODO to free the
memory associated with the sparse filter data. Address that TODO and fix
the memory leak.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index ee449de3f7..19158cc712 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -348,28 +348,30 @@ static enum list_objects_filter_result filter_sparse(
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
 		dtype = DT_DIR;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
 					    r->index);
-		if (val < 0)
-			val = filter_data->array_frame[filter_data->nr].defval;
+		if (val < 0) {
+			val = filter_data->array_frame[filter_data->nr - 1]
+				.defval;
+		}
 
 		ALLOC_GROW(filter_data->array_frame, filter_data->nr + 1,
 			   filter_data->alloc);
-		filter_data->nr++;
 		filter_data->array_frame[filter_data->nr].defval = val;
 		filter_data->array_frame[filter_data->nr].child_prov_omit = 0;
+		filter_data->nr++;
 
 		/*
 		 * A directory with this tree OID may appear in multiple
 		 * places in the tree. (Think of a directory move or copy,
 		 * with no other changes, so the OID is the same, but the
 		 * full pathnames of objects within this directory are new
 		 * and may match is_excluded() patterns differently.)
 		 * So we cannot mark this directory as SEEN (yet), since
 		 * that will prevent process_tree() from revisiting this
 		 * tree object with other pathname prefixes.
@@ -380,46 +382,45 @@ static enum list_objects_filter_result filter_sparse(
 		 * We always show all tree objects.  A future optimization
 		 * may want to attempt to narrow this.
 		 */
 		if (obj->flags & FILTER_SHOWN_BUT_REVISIT)
 			return LOFR_ZERO;
 		obj->flags |= FILTER_SHOWN_BUT_REVISIT;
 		return LOFR_DO_SHOW;
 
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
-		assert(filter_data->nr > 0);
+		assert(filter_data->nr > 1);
 
-		frame = &filter_data->array_frame[filter_data->nr];
-		filter_data->nr--;
+		frame = &filter_data->array_frame[--filter_data->nr];
 
 		/*
 		 * Tell our parent directory if any of our children were
 		 * provisionally omitted.
 		 */
-		filter_data->array_frame[filter_data->nr].child_prov_omit |=
+		filter_data->array_frame[filter_data->nr - 1].child_prov_omit |=
 			frame->child_prov_omit;
 
 		/*
 		 * If there are NO provisionally omitted child objects (ALL child
 		 * objects in this folder were INCLUDED), then we can mark the
 		 * folder as SEEN (so we will not have to revisit it again).
 		 */
 		if (!frame->child_prov_omit)
 			return LOFR_MARK_SEEN;
 		return LOFR_ZERO;
 
 	case LOFS_BLOB:
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		frame = &filter_data->array_frame[filter_data->nr];
+		frame = &filter_data->array_frame[filter_data->nr - 1];
 
 		dtype = DT_REG;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
 					    r->index);
 		if (val < 0)
 			val = frame->defval;
 		if (val > 0) {
 			if (filter_data->omits)
 				oidset_remove(filter_data->omits, &obj->oid);
@@ -446,39 +447,40 @@ static enum list_objects_filter_result filter_sparse(
 		 */
 		frame->child_prov_omit = 1;
 		return LOFR_ZERO;
 	}
 }
 
 
 static void filter_sparse_free(void *filter_data)
 {
 	struct filter_sparse_data *d = filter_data;
-	/* TODO free contents of 'd' */
+	free(d->array_frame);
 	free(d);
 }
 
 static void *filter_sparse_oid__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	filter_object_fn *filter_fn,
 	filter_free_fn *filter_free_fn)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
 	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
 					   NULL, 0, &d->el) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
+	d->nr++;
 
 	*filter_fn = filter_sparse;
 	*filter_free_fn = filter_sparse_free;
 	return d;
 }
 
 static void *filter_sparse_path__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	filter_object_fn *filter_fn,
@@ -486,20 +488,21 @@ static void *filter_sparse_path__init(
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
 	if (add_excludes_from_file_to_list(filter_options->sparse_path_value,
 					   NULL, 0, &d->el, NULL) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
+	d->nr++;
 
 	*filter_fn = filter_sparse;
 	*filter_free_fn = filter_sparse_free;
 	return d;
 }
 
 typedef void *(*filter_init_fn)(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	filter_object_fn *filter_fn,
-- 
2.17.1

