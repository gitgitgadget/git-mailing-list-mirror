Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBABC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB1E61241
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348193AbhIXSuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:50:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:54692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244064AbhIXSuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:50:25 -0400
Received: (qmail 19172 invoked by uid 109); 24 Sep 2021 18:48:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:48:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11222 invoked by uid 111); 24 Sep 2021 18:48:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:48:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:48:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 16/16] refs: drop "broken" flag from for_each_fullref_in()
Message-ID: <YU4dkMt6rWhmsOlq@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No callers pass in anything but "0" here. Likewise to our sibling
functions. Note that some of them ferry along the flag, but none of
their callers pass anything but "0" either.

Nor is anybody likely to change that. Callers which really want to see
all of the raw refs use for_each_rawref(). And anybody interested in
iterating a subset of the refs will likely be happy to use the
now-default behavior of showing broken refs, but omitting dangling
symlinks.

So we can get rid of this whole feature.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c |  4 ++--
 ls-refs.c           |  2 +-
 ref-filter.c        | 19 +++++++++----------
 refs.c              | 22 ++++++----------------
 refs.h              |  9 +++------
 revision.c          |  2 +-
 6 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 22c4e1a4ff..8480a59f57 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -863,8 +863,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_fullref_in("refs/bisect/bad", show_reference, NULL, 0);
-				for_each_fullref_in("refs/bisect/good", anti_reference, NULL, 0);
+				for_each_fullref_in("refs/bisect/bad", show_reference, NULL);
+				for_each_fullref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
diff --git a/ls-refs.c b/ls-refs.c
index be09568910..7fe9675d3c 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -171,7 +171,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	if (!data.prefixes.nr)
 		strvec_push(&data.prefixes, "");
 	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
-				     send_ref, &data, 0);
+				     send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
diff --git a/ref-filter.c b/ref-filter.c
index e59bb4cf9c..e15f0c4bac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2100,16 +2100,15 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
  */
 static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       each_ref_fn cb,
-				       void *cb_data,
-				       int broken)
+				       void *cb_data)
 {
 	if (!filter->match_as_path) {
 		/*
 		 * in this case, the patterns are applied after
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return for_each_fullref_in("", cb, cb_data, broken);
+		return for_each_fullref_in("", cb, cb_data);
 	}
 
 	if (filter->ignore_case) {
@@ -2118,16 +2117,16 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return for_each_fullref_in("", cb, cb_data, broken);
+		return for_each_fullref_in("", cb, cb_data);
 	}
 
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
-		return for_each_fullref_in("", cb, cb_data, broken);
+		return for_each_fullref_in("", cb, cb_data);
 	}
 
 	return for_each_fullref_in_prefixes(NULL, filter->name_patterns,
-					    cb, cb_data, broken);
+					    cb, cb_data);
 }
 
 /*
@@ -2425,13 +2424,13 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind == FILTER_REFS_BRANCHES)
-			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, 0);
+			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata);
 		else if (filter->kind == FILTER_REFS_REMOTES)
-			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, 0);
+			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata);
 		else if (filter->kind == FILTER_REFS_TAGS)
-			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, 0);
+			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata);
 		else if (filter->kind & FILTER_REFS_ALL)
-			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata, 0);
+			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(ref_filter_handler, &ref_cbdata);
 	}
diff --git a/refs.c b/refs.c
index d0f4e8726b..2be0d0f057 100644
--- a/refs.c
+++ b/refs.c
@@ -1522,25 +1522,16 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, fn, cb_data);
 }
 
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	enum do_for_each_ref_flags flag = 0;
-
-	if (broken)
-		flag = DO_FOR_EACH_INCLUDE_BROKEN;
 	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, fn, 0, flag, cb_data);
+			       prefix, fn, 0, 0, cb_data);
 }
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
-			     each_ref_fn fn, void *cb_data,
-			     unsigned int broken)
+			     each_ref_fn fn, void *cb_data)
 {
-	enum do_for_each_ref_flags flag = 0;
-
-	if (broken)
-		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
+	return do_for_each_ref(refs, prefix, fn, 0, 0, cb_data);
 }
 
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
@@ -1632,8 +1623,7 @@ static void find_longest_prefixes(struct string_list *out,
 
 int for_each_fullref_in_prefixes(const char *namespace,
 				 const char **patterns,
-				 each_ref_fn fn, void *cb_data,
-				 unsigned int broken)
+				 each_ref_fn fn, void *cb_data)
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
 	struct string_list_item *prefix;
@@ -1648,7 +1638,7 @@ int for_each_fullref_in_prefixes(const char *namespace,
 
 	for_each_string_list_item(prefix, &prefixes) {
 		strbuf_addstr(&buf, prefix->string);
-		ret = for_each_fullref_in(buf.buf, fn, cb_data, broken);
+		ret = for_each_fullref_in(buf.buf, fn, cb_data);
 		if (ret)
 			break;
 		strbuf_setlen(&buf, namespace_len);
diff --git a/refs.h b/refs.h
index 48970dfc7e..10e7696a64 100644
--- a/refs.h
+++ b/refs.h
@@ -342,10 +342,8 @@ int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
-			     each_ref_fn fn, void *cb_data,
-			     unsigned int broken);
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
-			unsigned int broken);
+			     each_ref_fn fn, void *cb_data);
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 
 /**
  * iterate all refs in "patterns" by partitioning patterns into disjoint sets
@@ -354,8 +352,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
  * callers should be prepared to ignore references that they did not ask for.
  */
 int for_each_fullref_in_prefixes(const char *namespace, const char **patterns,
-				 each_ref_fn fn, void *cb_data,
-				 unsigned int broken);
+				 each_ref_fn fn, void *cb_data);
 /**
  * iterate refs from the respective area.
  */
diff --git a/revision.c b/revision.c
index 0dabb5a0bc..b7a2baad0e 100644
--- a/revision.c
+++ b/revision.c
@@ -2548,7 +2548,7 @@ static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = refs_for_each_fullref_in(refs, bisect_refs.buf, fn, cb_data, 0);
+	status = refs_for_each_fullref_in(refs, bisect_refs.buf, fn, cb_data);
 	strbuf_release(&bisect_refs);
 	return status;
 }
-- 
2.33.0.1071.gb37e412355
