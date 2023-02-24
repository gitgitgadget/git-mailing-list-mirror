Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDCAC677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBXGkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBXGjo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCDD61F19
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:32 -0800 (PST)
Received: (qmail 3696 invoked by uid 109); 24 Feb 2023 06:39:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31122 invoked by uid 111); 24 Feb 2023 06:39:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 15/21] notes: mark unused callback parameters
Message-ID: <Y/hbo9JJhD0WTarU@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

for_each_note() requires a callback, but not all callbacks need all of
the parameters. Likewise, init_notes() takes a callback to implement the
"combine" strategy, but the "ignore" variant obviously doesn't look at
its arguments at all. Mark unused parameters as appropriate to silence
compiler warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/notes.c |  5 +++--
 notes.c         | 11 ++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 80d9dfd25c..d5713a9fac 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -113,8 +113,9 @@ static void free_note_data(struct note_data *d)
 }
 
 static int list_each_note(const struct object_id *object_oid,
-		const struct object_id *note_oid, char *note_path,
-		void *cb_data)
+			  const struct object_id *note_oid,
+			  char *note_path UNUSED,
+			  void *cb_data UNUSED)
 {
 	printf("%s %s\n", oid_to_hex(note_oid), oid_to_hex(object_oid));
 	return 0;
diff --git a/notes.c b/notes.c
index f2805d51bb..20af123d91 100644
--- a/notes.c
+++ b/notes.c
@@ -752,7 +752,7 @@ static int write_each_non_note_until(const char *note_path,
 	return 0;
 }
 
-static int write_each_note(const struct object_id *object_oid,
+static int write_each_note(const struct object_id *object_oid UNUSED,
 		const struct object_id *note_oid, char *note_path,
 		void *cb_data)
 {
@@ -780,8 +780,9 @@ struct note_delete_list {
 };
 
 static int prune_notes_helper(const struct object_id *object_oid,
-		const struct object_id *note_oid, char *note_path,
-		void *cb_data)
+			      const struct object_id *note_oid UNUSED,
+			      char *note_path UNUSED,
+			      void *cb_data)
 {
 	struct note_delete_list **l = (struct note_delete_list **) cb_data;
 	struct note_delete_list *n;
@@ -848,8 +849,8 @@ int combine_notes_overwrite(struct object_id *cur_oid,
 	return 0;
 }
 
-int combine_notes_ignore(struct object_id *cur_oid,
-			 const struct object_id *new_oid)
+int combine_notes_ignore(struct object_id *cur_oid UNUSED,
+			 const struct object_id *new_oid UNUSED)
 {
 	return 0;
 }
-- 
2.39.2.981.g6157336f25

