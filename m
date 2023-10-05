Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0249BE92FC6
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJEV3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJEV3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:29:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9F9E
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:29:03 -0700 (PDT)
Received: (qmail 27243 invoked by uid 109); 5 Oct 2023 21:29:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 21:29:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29425 invoked by uid 111); 5 Oct 2023 21:29:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 17:29:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 17:29:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] decorate: add clear_decoration() function
Message-ID: <20231005212902.GA986467@coredump.intra.peff.net>
References: <20231005212802.GA982892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005212802.GA982892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's not currently any way to free the resources associated with a
decoration struct. As a result, we have several memory leaks which
cannot easily be plugged.

Let's add a "clear" function and make use of it in the example code of
t9004. This removes the only leak from that script, so we can mark it as
passing the leak sanitizer.

Curiously this leak is found only when running SANITIZE=leak with clang,
but not with gcc.  But it is a bog-standard leak: we allocate some
memory in a local variable struct, and then exit main() without
releasing it. I'm not sure why gcc doesn't find it. After this
patch, both compilers report it as leak-free.

Note that the clear function takes a callback to free the individual
entries. That's not needed for our example (which is just decorating
with ints), but will be for real callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 decorate.c                       | 15 +++++++++++++++
 decorate.h                       | 10 ++++++++++
 t/helper/test-example-decorate.c |  2 ++
 t/t9004-example.sh               |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/decorate.c b/decorate.c
index a5c43c0c14..69aeb142b4 100644
--- a/decorate.c
+++ b/decorate.c
@@ -81,3 +81,18 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
 			j = 0;
 	}
 }
+
+void clear_decoration(struct decoration *n, void (*free_cb)(void *))
+{
+	if (free_cb) {
+		unsigned int i;
+		for (i = 0; i < n->size; i++) {
+			void *d = n->entries[i].decoration;
+			if (d)
+				free_cb(d);
+		}
+	}
+
+	FREE_AND_NULL(n->entries);
+	n->size = n->nr = 0;
+}
diff --git a/decorate.h b/decorate.h
index ee43dee1f0..cdeb17c9df 100644
--- a/decorate.h
+++ b/decorate.h
@@ -58,4 +58,14 @@ void *add_decoration(struct decoration *n, const struct object *obj, void *decor
  */
 void *lookup_decoration(struct decoration *n, const struct object *obj);
 
+/*
+ * Clear all decoration entries, releasing any memory used by the structure.
+ * If free_cb is not NULL, it is called for every decoration value currently
+ * stored.
+ *
+ * After clearing, the decoration struct can be used again. The "name" field is
+ * retained.
+ */
+void clear_decoration(struct decoration *n, void (*free_cb)(void *));
+
 #endif
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index 2ed910adaa..8f59f6be4c 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -72,5 +72,7 @@ int cmd__example_decorate(int argc UNUSED, const char **argv UNUSED)
 	if (objects_noticed != 2)
 		BUG("should have 2 objects");
 
+	clear_decoration(&n, NULL);
+
 	return 0;
 }
diff --git a/t/t9004-example.sh b/t/t9004-example.sh
index 7e8894a4a7..590aab0304 100755
--- a/t/t9004-example.sh
+++ b/t/t9004-example.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check that example code compiles and runs'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'decorate' '
-- 
2.42.0.836.g4b88bf80c5

