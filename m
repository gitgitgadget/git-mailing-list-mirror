Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC77EE49AC
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 00:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjHTAfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Aug 2023 20:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjHTAe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2023 20:34:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85802B3A1F
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 16:55:31 -0700 (PDT)
Received: (qmail 26429 invoked by uid 109); 19 Aug 2023 23:55:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Aug 2023 23:55:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22938 invoked by uid 111); 19 Aug 2023 23:55:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Aug 2023 19:55:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 19 Aug 2023 19:55:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] hashmap: use expected signatures for comparison functions
Message-ID: <20230819235530.GB600744@coredump.intra.peff.net>
References: <20230819235123.GA600613@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230819235123.GA600613@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We prefer for callback functions to match the signature with which
they'll be called, rather than casting them to the correct type when
assigning function pointers. Even though casting often works in the real
world, it is a violation of the standard.

We did a mass conversion in 939af16eac (hashmap_cmp_fn takes
hashmap_entry params, 2019-10-06), but have grown a few new cases since
then. Because of the cast, the compiler does not complain. However, as
of clang-18, UBSan will catch these at run-time, and the case in
range-diff.c triggers when running t3206.

After seeing that one, I scanned the results of:

  git grep '_fn)[^(]' '*.c' | grep -v typedef

and found a similar case in compat/terminal.c (which presumably isn't
called in the test suite, since it doesn't trigger UBSan). There might
be other cases lurking if the cast is done using a typedef that doesn't
end in "_fn", but loosening it finds too many false positives. I also
looked for:

  git grep ' = ([a-z_]*) *[a-z]' '*.c'

to find assignments that cast, but nothing looked like a function.

The resulting code is unfortunately a little longer, but the bonus of
using container_of() is that we are no longer restricted to the
hashmap_entry being at the start of the struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/terminal.c | 10 ++++++----
 range-diff.c      | 11 +++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 83d95e8656..0afda730f2 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -479,10 +479,13 @@ struct escape_sequence_entry {
 };
 
 static int sequence_entry_cmp(const void *hashmap_cmp_fn_data UNUSED,
-			      const struct escape_sequence_entry *e1,
-			      const struct escape_sequence_entry *e2,
+			      const struct hashmap_entry *he1,
+			      const struct hashmap_entry *he2,
 			      const void *keydata)
 {
+	const struct escape_sequence_entry
+		*e1 = container_of(he1, const struct escape_sequence_entry, entry),
+		*e2 = container_of(he2, const struct escape_sequence_entry, entry);
 	return strcmp(e1->sequence, keydata ? keydata : e2->sequence);
 }
 
@@ -496,8 +499,7 @@ static int is_known_escape_sequence(const char *sequence)
 		struct strbuf buf = STRBUF_INIT;
 		char *p, *eol;
 
-		hashmap_init(&sequences, (hashmap_cmp_fn)sequence_entry_cmp,
-			     NULL, 0);
+		hashmap_init(&sequences, sequence_entry_cmp, NULL, 0);
 
 		strvec_pushl(&cp.args, "infocmp", "-L", "-1", NULL);
 		if (pipe_command(&cp, NULL, 0, &buf, 0, NULL, 0))
diff --git a/range-diff.c b/range-diff.c
index 2e86063491..ca5493984a 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -230,16 +230,19 @@ static int read_patches(const char *range, struct string_list *list,
 }
 
 static int patch_util_cmp(const void *cmp_data UNUSED,
-			  const struct patch_util *a,
-			  const struct patch_util *b,
-			  const char *keydata)
+			  const struct hashmap_entry *ha,
+			  const struct hashmap_entry *hb,
+			  const void *keydata)
 {
+	const struct patch_util
+		*a = container_of(ha, const struct patch_util, e),
+		*b = container_of(hb, const struct patch_util, e);
 	return strcmp(a->diff, keydata ? keydata : b->diff);
 }
 
 static void find_exact_matches(struct string_list *a, struct string_list *b)
 {
-	struct hashmap map = HASHMAP_INIT((hashmap_cmp_fn)patch_util_cmp, NULL);
+	struct hashmap map = HASHMAP_INIT(patch_util_cmp, NULL);
 	int i;
 
 	/* First, add the patches of a to a hash map */
-- 
2.42.0.rc2.418.g602d5859fc
