Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BB7ECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 05:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIHFB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 01:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHFBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 01:01:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0A93513
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 22:01:24 -0700 (PDT)
Received: (qmail 24590 invoked by uid 109); 8 Sep 2022 05:01:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 05:01:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17927 invoked by uid 111); 8 Sep 2022 05:01:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 01:01:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 01:01:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 4/5] list_objects_filter_options: plug leak of filter_spec
 strings
Message-ID: <Yxl3I+3G15fDv0CG@coredump.intra.peff.net>
References: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The list_objects_filter_options struct contains a string_list to store
the filter_spec. Because we allow the options struct to be
zero-initialized by callers, the string_list's strdup_strings field is
generally not set.

Because we don't want to depend on the memory lifetimes of any strings
passed in to the list-objects API, everything we add to the string_list
is duplicated (either via xstrdup(), or via strbuf_detach()). So far so
good, but now we have a problem at cleanup time: when we clear the
list, the string_list API doesn't realize that it needs to free all of
those strings, and we leak them.

One option would be to set strdup_strings right before clearing the
list. But this is tricky for two reasons:

  1. There's one spot, in partial_clone_get_default_filter_spec(),
     that fails to duplicate its argument. We could fix that, but...

  2. We clear the list in a surprising number of places. As you might
     expect, we do so in list_objects_filter_release(). But we also
     clear and rewrite it in expand_list_objects_filter_spec(),
     list_objects_filter_spec(), and transform_to_combine_type().
     We'd have to put the same hack in all of those spots.

Instead, let's just set strdup_strings before adding anything. That lets
us drop the extra manual xstrdup() calls, fixes the spot mentioned
in (1) above that _should_ be duplicating, and future-proofs further
calls. We do have to switch the strbuf_detach() calls to use the nodup
form, but that's an easy change, and the resulting code more clearly
shows the expected ownership transfer.

This also resolves a weird inconsistency: when we make a deep copy with
list_objects_filter_copy(), it initializes the copy's filter_spec with
string_list_init_dup(). So the copy frees its string_list memory
correctly, but accidentally leaks the extra manual-xstrdup()'d strings!

There is one hiccup, though. In an ideal world, everyone would allocate
the list_objects_filter_options struct with an initializer which used
STRING_LIST_INIT_DUP under the hood. But there are a bunch of existing
callers which think that zero-initializing is good enough. We can leave
them as-is by noting that the list is always initially populated via
parse_list_objects_filter(). So we can just initialize the
strdup_strings flag there.

This is arguably a band-aid, but it works reliably. And it doesn't make
anything harder if we want to switch all the callers later to a new
LIST_OBJECTS_FILTER_INIT.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects-filter-options.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 41c41c9d45..6cc4eb8e1c 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -207,7 +207,7 @@ static void filter_spec_append_urlencode(
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addstr_urlencode(&buf, raw, allow_unencoded);
 	trace_printf("Add to combine filter-spec: %s\n", buf.buf);
-	string_list_append(&filter->filter_spec, strbuf_detach(&buf, NULL));
+	string_list_append_nodup(&filter->filter_spec, strbuf_detach(&buf, NULL));
 }
 
 /*
@@ -226,12 +226,13 @@ static void transform_to_combine_type(
 			xcalloc(initial_sub_alloc, sizeof(*sub_array));
 		sub_array[0] = *filter_options;
 		memset(filter_options, 0, sizeof(*filter_options));
+		string_list_init_dup(&filter_options->filter_spec);
 		filter_options->sub = sub_array;
 		filter_options->sub_alloc = initial_sub_alloc;
 	}
 	filter_options->sub_nr = 1;
 	filter_options->choice = LOFC_COMBINE;
-	string_list_append(&filter_options->filter_spec, xstrdup("combine:"));
+	string_list_append(&filter_options->filter_spec, "combine:");
 	filter_spec_append_urlencode(
 		filter_options,
 		list_objects_filter_spec(&filter_options->sub[0]));
@@ -256,8 +257,14 @@ void parse_list_objects_filter(
 	struct strbuf errbuf = STRBUF_INIT;
 	int parse_error;
 
+	if (!filter_options->filter_spec.strdup_strings) {
+		if (filter_options->filter_spec.nr)
+			BUG("unexpected non-allocated string in filter_spec");
+		filter_options->filter_spec.strdup_strings = 1;
+	}
+
 	if (!filter_options->choice) {
-		string_list_append(&filter_options->filter_spec, xstrdup(arg));
+		string_list_append(&filter_options->filter_spec, arg);
 
 		parse_error = gently_parse_list_objects_filter(
 			filter_options, arg, &errbuf);
@@ -268,7 +275,7 @@ void parse_list_objects_filter(
 		 */
 		transform_to_combine_type(filter_options);
 
-		string_list_append(&filter_options->filter_spec, xstrdup("+"));
+		string_list_append(&filter_options->filter_spec, "+");
 		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
@@ -306,7 +313,7 @@ const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
 		strbuf_add_separated_string_list(
 			&concatted, "", &filter->filter_spec);
 		string_list_clear(&filter->filter_spec, /*free_util=*/0);
-		string_list_append(
+		string_list_append_nodup(
 			&filter->filter_spec, strbuf_detach(&concatted, NULL));
 	}
 
@@ -321,7 +328,7 @@ const char *expand_list_objects_filter_spec(
 		strbuf_addf(&expanded_spec, "blob:limit=%lu",
 			    filter->blob_limit_value);
 		string_list_clear(&filter->filter_spec, /*free_util=*/0);
-		string_list_append(
+		string_list_append_nodup(
 			&filter->filter_spec,
 			strbuf_detach(&expanded_spec, NULL));
 	}
-- 
2.37.3.1139.g47294c03c7

