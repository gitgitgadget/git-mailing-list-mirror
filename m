Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6C31F461
	for <e@80x24.org>; Thu, 27 Jun 2019 21:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfF0VZN (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 17:25:13 -0400
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:55244 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbfF0VZN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jun 2019 17:25:13 -0400
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-02v.sys.comcast.net with ESMTP
        id gbXshN9XYkHCigbtIhpuLA; Thu, 27 Jun 2019 21:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1561670712;
        bh=m+PE5TLdSqJ+vc+ayYAn9EEj4UmqNt4arGHmNh61Vkg=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=umHDbmo8+WI3KcQ0vkENjwqY1RIfFTpZZZn+0uboYzfuiQkT0uRTTRSHIlSkkIyPl
         AS/Nwj0rDkI2oSr1ZuHm7FpEQh2WU1K5uepxe0YPhnF/fwwgqEM+15R0ifT4ghfWPQ
         hHjytXahR84l+eYX4IV0N18KyXYXJQBt8KUCl9Ry9gE/RjX1KZSV1jk6QnwnqzxWF9
         BpPkhZAlEilUQGGqr+/2fkuT8hS4EynCcKP83TG3JEO9fj4J3LI69+HQozRxS4jKay
         nDRn/zyWg5ObRF1ZMAW26FXYblbVdQcgThtrzsnF/OWWIEYR+pD0F2oS6jitg7z5LO
         Z5l5tsIutjS4w==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:5954:f056:f8d3:3ba7])
        by resomta-po-16v.sys.comcast.net with ESMTPSA
        id gbt3hkeOhDs3ngbt7hUyaH; Thu, 27 Jun 2019 21:25:10 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 27 Jun 2019 14:24:57 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH v4 10/10] list-objects-filter-options: make parser void
Message-ID: <20190627212457.GD54617@comcast.net>
References: <2f7566f697be759614a04c1277194f974bdcd662.1560558910.git.matvore@google.com>
 <20190622004631.251573-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622004631.251573-1-jonathantanmy@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 05:46:31PM -0700, Jonathan Tan wrote:
> > This function always returns 0, so make it return void instead.
> 
> And...patches 7-10 look straightforward and good to me.
> 
> In summary, I don't think any changes need to be made to all 10 patches
> other than textual ones (commit messages, documentation, and function
> names).

Great. I feel much better about the comments and commit messages now. I
am about to send a roll-up (v5). Here is the interdiff which catches
your comments and Dscho's comment about strbuf_addstr:

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d9c8da5b70..9e64832a5e 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -139,22 +139,21 @@ static int parse_combine_subfilter(
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
 	size_t sub;
 	int result = 0;
 
 	if (!subspecs[0]) {
-		strbuf_addf(errbuf,
-			    _("expected something after combine:"));
+		strbuf_addstr(errbuf, _("expected something after combine:"));
 		result = 1;
 		goto cleanup;
 	}
 
 	for (sub = 0; subspecs[sub] && !result; sub++) {
 		if (subspecs[sub + 1]) {
 			/*
 			 * This is not the last subspec. Remove trailing "+" so
 			 * we can parse it.
 			 */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 6b99f707e4..d664264d65 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -38,23 +38,33 @@ struct filter {
 	enum list_objects_filter_result (*filter_object_fn)(
 		struct repository *r,
 		enum list_objects_filter_situation filter_situation,
 		struct object *obj,
 		const char *pathname,
 		const char *filename,
 		struct oidset *omits,
 		void *filter_data);
 
 	/*
-	 * Optional. If this function is supplied and the filter needs to
-	 * collect omits, then this function is called once before free_fn is
-	 * called.
+	 * Optional. If this function is supplied and the filter needs
+	 * to collect omits, then this function is called once before
+	 * free_fn is called.
+	 *
+	 * This is required because the following two conditions hold:
+	 *
+	 *   a. A tree filter can add and remove objects as an object
+	 *      graph is traversed.
+	 *   b. A combine filter's omit set is the union of all its
+	 *      subfilters, which may include tree: filters.
+	 *
+	 * As such, the omits sets must be separate sets, and can only
+	 * be unioned after the traversal is completed.
 	 */
 	void (*finalize_omits_fn)(struct oidset *omits, void *filter_data);
 
 	void (*free_fn)(void *filter_data);
 
 	void *filter_data;
 
 	/* If non-NULL, the filter collects a list of the omitted OIDs here. */
 	struct oidset *omits;
 };
@@ -485,54 +495,46 @@ static void filter_sparse_oid__init(
 	filter->filter_object_fn = filter_sparse;
 	filter->free_fn = filter_sparse_free;
 }
 
 /* A filter which only shows objects shown by all sub-filters. */
 struct combine_filter_data {
 	struct subfilter *sub;
 	size_t nr;
 };
 
-static int should_delegate(enum list_objects_filter_situation filter_situation,
-			   struct object *obj,
-			   struct subfilter *sub)
-{
-	if (!sub->is_skipping_tree)
-		return 1;
-	if (filter_situation == LOFS_END_TREE &&
-		oideq(&obj->oid, &sub->skip_tree)) {
-		sub->is_skipping_tree = 0;
-		return 1;
-	}
-	return 0;
-}
-
 static enum list_objects_filter_result process_subfilter(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
 	struct subfilter *sub)
 {
 	enum list_objects_filter_result result;
 
 	/*
-	 * Check should_delegate before oidset_contains so that
-	 * is_skipping_tree gets unset even when the object is marked as seen.
-	 * As of this writing, no filter uses LOFR_MARK_SEEN on trees that also
-	 * uses LOFR_SKIP_TREE, so the ordering is only theoretically
-	 * important. Be cautious if you change the order of the below checks
-	 * and more filters have been added!
+	 * Check and update is_skipping_tree before oidset_contains so
+	 * that is_skipping_tree gets unset even when the object is
+	 * marked as seen.  As of this writing, no filter uses
+	 * LOFR_MARK_SEEN on trees that also uses LOFR_SKIP_TREE, so the
+	 * ordering is only theoretically important. Be cautious if you
+	 * change the order of the below checks and more filters have
+	 * been added!
 	 */
-	if (!should_delegate(filter_situation, obj, sub))
-		return LOFR_ZERO;
+	if (sub->is_skipping_tree) {
+		if (filter_situation == LOFS_END_TREE &&
+		    oideq(&obj->oid, &sub->skip_tree))
+			sub->is_skipping_tree = 0;
+		else
+			return LOFR_ZERO;
+	}
 	if (oidset_contains(&sub->seen, &obj->oid))
 		return LOFR_ZERO;
 
 	result = list_objects_filter__filter_object(
 		r, filter_situation, obj, pathname, filename, sub->filter);
 
 	if (result & LOFR_MARK_SEEN)
 		oidset_insert(&sub->seen, &obj->oid);
 
 	if (result & LOFR_SKIP_TREE) {
@@ -673,22 +675,23 @@ enum list_objects_filter_result list_objects_filter__filter_object(
 	const char *pathname,
 	const char *filename,
 	struct filter *filter)
 {
 	if (filter && (obj->flags & NOT_USER_GIVEN))
 		return filter->filter_object_fn(r, filter_situation, obj,
 						pathname, filename,
 						filter->omits,
 						filter->filter_data);
 	/*
-	 * No filter is active or user gave object explicitly. Choose default
-	 * behavior based on filter situation.
+	 * No filter is active or user gave object explicitly. In this case,
+	 * always show the object (except when LOFS_END_TREE, since this tree
+	 * had already been shown when LOFS_BEGIN_TREE).
 	 */
 	if (filter_situation == LOFS_END_TREE)
 		return 0;
 	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
 
 void list_objects_filter__free(struct filter *filter)
 {
 	if (!filter)
 		return;
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 6908954266..cfd784e203 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -55,32 +55,41 @@ enum list_objects_filter_result {
 };
 
 enum list_objects_filter_situation {
 	LOFS_BEGIN_TREE,
 	LOFS_END_TREE,
 	LOFS_BLOB
 };
 
 struct filter;
 
-/* Constructor for the set of defined list-objects filters. */
+/*
+ * Constructor for the set of defined list-objects filters.
+ * The `omitted` set is optional. It is populated with objects that the
+ * filter excludes. This set should not be considered finalized until
+ * after list_objects_filter__free is called on the returned `struct
+ * filter *`.
+ */
 struct filter *list_objects_filter__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options);
 
 /*
  * Lets `filter` decide how to handle the `obj`. If `filter` is NULL, this
  * function behaves as expected if no filter is configured: all objects are
  * included.
  */
 enum list_objects_filter_result list_objects_filter__filter_object(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
 	struct filter *filter);
 
-/* Destroys `filter`. Does nothing if `filter` is null. */
+/*
+ * Destroys `filter` and finalizes the `omitted` set, if present. Does
+ * nothing if `filter` is null.
+ */
 void list_objects_filter__free(struct filter *filter);
 
 #endif /* LIST_OBJECTS_FILTER_H */
