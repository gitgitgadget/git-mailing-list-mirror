Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA6C4167B
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiLMLMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiLMLLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:11:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728511E3C5
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:11:11 -0800 (PST)
Received: (qmail 14461 invoked by uid 109); 13 Dec 2022 11:11:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:11:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4285 invoked by uid 111); 13 Dec 2022 11:11:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:11:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:11:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/9] ls-refs: use repository parameter to iterate refs
Message-ID: <Y5hdzjlboJrsnvKK@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ls_refs() function (for the v2 protocol command of the same name)
takes a repository parameter (like all v2 commands), but ignores it. It
should use it to access the refs.

This isn't a bug in practice, since we only call this function when
serving upload-pack from the main repository. But it's an awkward
gotcha, and it causes -Wunused-parameter to complain.

The main reason we don't use the repository parameter is that the ref
iteration interface we call doesn't have a "refs_" variant that takes a
ref_store. However we can easily add one. In fact, since there is only
one other caller (in ref-filter.c), there is no need to maintain the
non-repository wrapper; that caller can just use the_repository. It's
still a long way from consistently using a repository object, but it's
one small step in the right direction.

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c    | 5 +++--
 ref-filter.c | 5 +++--
 refs.c       | 9 +++++----
 refs.h       | 6 ++++--
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index fb6769742c..697d4beb8d 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -194,8 +194,9 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	send_possibly_unborn_head(&data);
 	if (!data.prefixes.nr)
 		strvec_push(&data.prefixes, "");
-	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
-				     send_ref, &data);
+	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
+					  get_git_namespace(), data.prefixes.v,
+					  send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
diff --git a/ref-filter.c b/ref-filter.c
index 9dc2cd1451..971303683b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2128,8 +2128,9 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_in("", cb, cb_data);
 	}
 
-	return for_each_fullref_in_prefixes(NULL, filter->name_patterns,
-					    cb, cb_data);
+	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
+						 NULL, filter->name_patterns,
+						 cb, cb_data);
 }
 
 /*
diff --git a/refs.c b/refs.c
index 2c7e88b190..e31dbcda59 100644
--- a/refs.c
+++ b/refs.c
@@ -1723,9 +1723,10 @@ static void find_longest_prefixes(struct string_list *out,
 	strbuf_release(&prefix);
 }
 
-int for_each_fullref_in_prefixes(const char *namespace,
-				 const char **patterns,
-				 each_ref_fn fn, void *cb_data)
+int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
+				      const char *namespace,
+				      const char **patterns,
+				      each_ref_fn fn, void *cb_data)
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
 	struct string_list_item *prefix;
@@ -1740,7 +1741,7 @@ int for_each_fullref_in_prefixes(const char *namespace,
 
 	for_each_string_list_item(prefix, &prefixes) {
 		strbuf_addstr(&buf, prefix->string);
-		ret = for_each_fullref_in(buf.buf, fn, cb_data);
+		ret = refs_for_each_fullref_in(ref_store, buf.buf, fn, cb_data);
 		if (ret)
 			break;
 		strbuf_setlen(&buf, namespace_len);
diff --git a/refs.h b/refs.h
index 3266fd8f57..935cdd1ece 100644
--- a/refs.h
+++ b/refs.h
@@ -354,8 +354,10 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
  *
  * callers should be prepared to ignore references that they did not ask for.
  */
-int for_each_fullref_in_prefixes(const char *namespace, const char **patterns,
-				 each_ref_fn fn, void *cb_data);
+int refs_for_each_fullref_in_prefixes(struct ref_store *refs,
+				      const char *namespace, const char **patterns,
+				      each_ref_fn fn, void *cb_data);
+
 /**
  * iterate refs from the respective area.
  */
-- 
2.39.0.546.g5ea984bc66

