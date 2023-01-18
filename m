Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B8C38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjARUo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjARUoW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:44:22 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF65FD6B
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:44:13 -0800 (PST)
Received: (qmail 3380 invoked by uid 109); 18 Jan 2023 20:44:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 20:44:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25002 invoked by uid 111); 18 Jan 2023 20:44:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 15:44:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 15:44:12 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 6/6] hash-object: use fsck for object checks
Message-ID: <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since c879daa237 (Make hash-object more robust against malformed
objects, 2011-02-05), we've done some rudimentary checks against objects
we're about to write by running them through our usual parsers for
trees, commits, and tags.

These parsers catch some problems, but they are not nearly as careful as
the fsck functions (which make sense; the parsers are designed to be
fast and forgiving, bailing only when the input is unintelligible). We
are better off doing the more thorough fsck checks when writing objects.
Doing so at write time is much better than writing garbage only to find
out later (after building more history atop it!) that fsck complains
about it, or hosts with transfer.fsckObjects reject it.

This is obviously going to be a user-visible behavior change, and the
test changes earlier in this series show the scope of the impact. But
I'd argue that this is OK:

  - the documentation for hash-object is already vague about which
    checks we might do, saying that --literally will allow "any
    garbage[...] which might not otherwise pass standard object parsing
    or git-fsck checks". So we are already covered under the documented
    behavior.

  - users don't generally run hash-object anyway. There are a lot of
    spots in the tests that needed to be updated because creating
    garbage objects is something that Git's tests disproportionately do.

  - it's hard to imagine anyone thinking the new behavior is worse. Any
    object we reject would be a potential problem down the road for the
    user. And if they really want to create garbage, --literally is
    already the escape hatch they need.

Note that the change here is actually in index_mem(), which handles the
HASH_FORMAT_CHECK flag passed by hash-object. That flag is also used by
"git-replace --edit" to sanity-check the result. Covering that with more
thorough checks likewise seems like a good thing.

Besides being more thorough, there are a few other bonuses:

  - we get rid of some questionable stack allocations of object structs.
    These don't seem to currently cause any problems in practice, but
    they subtly violate some of the assumptions made by the rest of the
    code (e.g., the "struct commit" we put on the stack and
    zero-initialize will not have a proper index from
    alloc_comit_index().

  - likewise, those parsed object structs are the source of some small
    memory leaks

  - the resulting messages are much better. For example:

      [before]
      $ echo 'tree 123' | git hash-object -t commit --stdin
      error: bogus commit object 0000000000000000000000000000000000000000
      fatal: corrupt commit

      [after]
      $ echo 'tree 123' | git.compile hash-object -t commit --stdin
      error: object fails fsck: badTreeSha1: invalid 'tree' line format - bad sha1
      fatal: refusing to create malformed object

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c          | 55 ++++++++++++++++++------------------------
 t/t1007-hash-object.sh | 11 +++++++++
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/object-file.c b/object-file.c
index 80a0cd3b35..5c96384803 100644
--- a/object-file.c
+++ b/object-file.c
@@ -33,6 +33,7 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "submodule.h"
+#include "fsck.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -2298,32 +2299,21 @@ int repo_has_object_file(struct repository *r,
 	return repo_has_object_file_with_flags(r, oid, 0);
 }
 
-static void check_tree(const void *buf, size_t size)
-{
-	struct tree_desc desc;
-	struct name_entry entry;
-
-	init_tree_desc(&desc, buf, size);
-	while (tree_entry(&desc, &entry))
-		/* do nothing
-		 * tree_entry() will die() on malformed entries */
-		;
-}
-
-static void check_commit(const void *buf, size_t size)
-{
-	struct commit c;
-	memset(&c, 0, sizeof(c));
-	if (parse_commit_buffer(the_repository, &c, buf, size, 0))
-		die(_("corrupt commit"));
-}
-
-static void check_tag(const void *buf, size_t size)
-{
-	struct tag t;
-	memset(&t, 0, sizeof(t));
-	if (parse_tag_buffer(the_repository, &t, buf, size))
-		die(_("corrupt tag"));
+/*
+ * We can't use the normal fsck_error_function() for index_mem(),
+ * because we don't yet have a valid oid for it to report. Instead,
+ * report the minimal fsck error here, and rely on the caller to
+ * give more context.
+ */
+static int hash_format_check_report(struct fsck_options *opts,
+				     const struct object_id *oid,
+				     enum object_type object_type,
+				     enum fsck_msg_type msg_type,
+				     enum fsck_msg_id msg_id,
+				     const char *message)
+{
+	error(_("object fails fsck: %s"), message);
+	return 1;
 }
 
 static int index_mem(struct index_state *istate,
@@ -2350,12 +2340,13 @@ static int index_mem(struct index_state *istate,
 		}
 	}
 	if (flags & HASH_FORMAT_CHECK) {
-		if (type == OBJ_TREE)
-			check_tree(buf, size);
-		if (type == OBJ_COMMIT)
-			check_commit(buf, size);
-		if (type == OBJ_TAG)
-			check_tag(buf, size);
+		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
+
+		opts.strict = 1;
+		opts.error_func = hash_format_check_report;
+		if (fsck_buffer(null_oid(), type, buf, size, &opts))
+			die(_("refusing to create malformed object"));
+		fsck_finish(&opts);
 	}
 
 	if (write_object)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 2d2148d8fa..ac3d173767 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -222,6 +222,17 @@ test_expect_success 'empty filename in tree' '
 	grep "empty filename in tree entry" err
 '
 
+test_expect_success 'duplicate filename in tree' '
+	hex_oid=$(echo foo | git hash-object --stdin -w) &&
+	bin_oid=$(echo $hex_oid | hex2oct) &&
+	{
+		printf "100644 file\0$bin_oid" &&
+		printf "100644 file\0$bin_oid"
+	} >tree-with-duplicate-filename &&
+	test_must_fail git hash-object -t tree tree-with-duplicate-filename 2>err &&
+	grep "duplicateEntries" err
+'
+
 test_expect_success 'corrupt commit' '
 	test_must_fail git hash-object -t commit --stdin </dev/null
 '
-- 
2.39.1.616.gd06fca9e99
