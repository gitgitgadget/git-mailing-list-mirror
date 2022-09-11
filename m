Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E7FECAAA1
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 05:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIKFDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 01:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIKFDd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 01:03:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6AE3055C
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 22:03:32 -0700 (PDT)
Received: (qmail 18263 invoked by uid 109); 11 Sep 2022 05:03:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 05:03:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31558 invoked by uid 111); 11 Sep 2022 05:03:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 01:03:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 01:03:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 4/4] list-objects-filter: convert filter_spec to a strbuf
Message-ID: <Yx1sI8cjU/SWUKVy@coredump.intra.peff.net>
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, the filter_spec field was just a string pointer. In
cf9ceb5a12 (list-objects-filter-options: make filter_spec a string_list,
2019-06-27) it became a string_list, but that commit notes:

    A strbuf would seem to be a more natural choice for this object, but
    it unfortunately requires initialization besides just zero'ing out
    the memory.  This results in all container structs, and all
    containers of those structs, etc., to also require initialization.
    Initializing them all would be more cumbersome that simply using a
    string_list, which behaves properly when its contents are zero'd.

Now that we've changed the struct to require non-zero initialization
anyway (ironically, because string_list also needed non-zero
initialization to avoid leaks), we can now convert to that more natural
type.

This makes the list_objects_filter_spec() function much less awkward, as
it had to collapse the string_list to a single-entry list on the fly.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects-filter-options.c | 51 +++++++++++++----------------------
 list-objects-filter-options.h |  4 +--
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 56a1933a50..d46ce4acc4 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -202,10 +202,10 @@ static int allow_unencoded(char ch)
 static void filter_spec_append_urlencode(
 	struct list_objects_filter_options *filter, const char *raw)
 {
-	struct strbuf buf = STRBUF_INIT;
-	strbuf_addstr_urlencode(&buf, raw, allow_unencoded);
-	trace_printf("Add to combine filter-spec: %s\n", buf.buf);
-	string_list_append_nodup(&filter->filter_spec, strbuf_detach(&buf, NULL));
+	size_t orig_len = filter->filter_spec.len;
+	strbuf_addstr_urlencode(&filter->filter_spec, raw, allow_unencoded);
+	trace_printf("Add to combine filter-spec: %s\n",
+		     filter->filter_spec.buf + orig_len);
 }
 
 /*
@@ -229,15 +229,15 @@ static void transform_to_combine_type(
 	}
 	filter_options->sub_nr = 1;
 	filter_options->choice = LOFC_COMBINE;
-	string_list_append(&filter_options->filter_spec, "combine:");
+	strbuf_addstr(&filter_options->filter_spec, "combine:");
 	filter_spec_append_urlencode(
 		filter_options,
 		list_objects_filter_spec(&filter_options->sub[0]));
 	/*
 	 * We don't need the filter_spec strings for subfilter specs, only the
 	 * top level.
 	 */
-	string_list_clear(&filter_options->sub[0].filter_spec, /*free_util=*/0);
+	strbuf_release(&filter_options->sub[0].filter_spec);
 }
 
 void list_objects_filter_die_if_populated(
@@ -254,11 +254,11 @@ void parse_list_objects_filter(
 	struct strbuf errbuf = STRBUF_INIT;
 	int parse_error;
 
-	if (!filter_options->filter_spec.strdup_strings)
+	if (!filter_options->filter_spec.buf)
 		BUG("filter_options not properly initialized");
 
 	if (!filter_options->choice) {
-		string_list_append(&filter_options->filter_spec, arg);
+		strbuf_addstr(&filter_options->filter_spec, arg);
 
 		parse_error = gently_parse_list_objects_filter(
 			filter_options, arg, &errbuf);
@@ -269,7 +269,7 @@ void parse_list_objects_filter(
 		 */
 		transform_to_combine_type(filter_options);
 
-		string_list_append(&filter_options->filter_spec, "+");
+		strbuf_addch(&filter_options->filter_spec, '+');
 		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
@@ -300,31 +300,18 @@ int opt_parse_list_objects_filter(const struct option *opt,
 
 const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
 {
-	if (!filter->filter_spec.nr)
+	if (!filter->filter_spec.len)
 		BUG("no filter_spec available for this filter");
-	if (filter->filter_spec.nr != 1) {
-		struct strbuf concatted = STRBUF_INIT;
-		strbuf_add_separated_string_list(
-			&concatted, "", &filter->filter_spec);
-		string_list_clear(&filter->filter_spec, /*free_util=*/0);
-		string_list_append_nodup(
-			&filter->filter_spec, strbuf_detach(&concatted, NULL));
-	}
-
-	return filter->filter_spec.items[0].string;
+	return filter->filter_spec.buf;
 }
 
 const char *expand_list_objects_filter_spec(
 	struct list_objects_filter_options *filter)
 {
 	if (filter->choice == LOFC_BLOB_LIMIT) {
-		struct strbuf expanded_spec = STRBUF_INIT;
-		strbuf_addf(&expanded_spec, "blob:limit=%lu",
+		strbuf_release(&filter->filter_spec);
+		strbuf_addf(&filter->filter_spec, "blob:limit=%lu",
 			    filter->blob_limit_value);
-		string_list_clear(&filter->filter_spec, /*free_util=*/0);
-		string_list_append_nodup(
-			&filter->filter_spec,
-			strbuf_detach(&expanded_spec, NULL));
 	}
 
 	return list_objects_filter_spec(filter);
@@ -337,7 +324,7 @@ void list_objects_filter_release(
 
 	if (!filter_options)
 		return;
-	string_list_clear(&filter_options->filter_spec, /*free_util=*/0);
+	strbuf_release(&filter_options->filter_spec);
 	free(filter_options->sparse_oid_name);
 	for (sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
@@ -398,8 +385,8 @@ void partial_clone_get_default_filter_spec(
 	if (!promisor || !promisor->partial_clone_filter)
 		return;
 
-	string_list_append(&filter_options->filter_spec,
-			   promisor->partial_clone_filter);
+	strbuf_addstr(&filter_options->filter_spec,
+		      promisor->partial_clone_filter);
 	gently_parse_list_objects_filter(filter_options,
 					 promisor->partial_clone_filter,
 					 &errbuf);
@@ -411,14 +398,12 @@ void list_objects_filter_copy(
 	const struct list_objects_filter_options *src)
 {
 	int i;
-	struct string_list_item *item;
 
 	/* Copy everything. We will overwrite the pointers shortly. */
 	memcpy(dest, src, sizeof(struct list_objects_filter_options));
 
-	string_list_init_dup(&dest->filter_spec);
-	for_each_string_list_item(item, &src->filter_spec)
-		string_list_append(&dest->filter_spec, item->string);
+	strbuf_init(&dest->filter_spec, 0);
+	strbuf_addbuf(&dest->filter_spec, &src->filter_spec);
 	dest->sparse_oid_name = xstrdup_or_null(src->sparse_oid_name);
 
 	ALLOC_ARRAY(dest->sub, dest->sub_alloc);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 2720f7dba8..7eeadab2dd 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -35,7 +35,7 @@ struct list_objects_filter_options {
 	 * To get the raw filter spec given by the user, use the result of
 	 * list_objects_filter_spec().
 	 */
-	struct string_list filter_spec;
+	struct strbuf filter_spec;
 
 	/*
 	 * 'choice' is determined by parsing the filter-spec.  This indicates
@@ -69,7 +69,7 @@ struct list_objects_filter_options {
 	 */
 };
 
-#define LIST_OBJECTS_FILTER_INIT { .filter_spec = STRING_LIST_INIT_DUP }
+#define LIST_OBJECTS_FILTER_INIT { .filter_spec = STRBUF_INIT }
 void list_objects_filter_init(struct list_objects_filter_options *filter_options);
 
 /*
-- 
2.37.3.1242.g835d375f85
