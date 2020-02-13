Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4072EC3F68F
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2240720848
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgBMCQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:16:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:42054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729348AbgBMCQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:16:34 -0500
Received: (qmail 9796 invoked by uid 109); 13 Feb 2020 02:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:15:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8546 invoked by uid 111); 13 Feb 2020 02:25:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:25:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:16:33 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/13] pack-bitmap: fix leak of haves/wants object lists
Message-ID: <20200213021633.GB1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we do a bitmap-aware revision traversal, we create an object_list
for each of the "haves" and "wants" tips. After creating the result
bitmaps these are no longer needed or used, but we never free the list
memory.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c      | 9 +++++++++
 object.h      | 2 ++
 pack-bitmap.c | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/object.c b/object.c
index 142ef69399..4d11949b38 100644
--- a/object.c
+++ b/object.c
@@ -307,6 +307,15 @@ int object_list_contains(struct object_list *list, struct object *obj)
 	return 0;
 }
 
+void object_list_free(struct object_list **list)
+{
+	while (*list) {
+		struct object_list *p = *list;
+		*list = p->next;
+		free(p);
+	}
+}
+
 /*
  * A zero-length string to which object_array_entry::name can be
  * initialized without requiring a malloc/free.
diff --git a/object.h b/object.h
index 25f5ab3d54..2dbabfca0a 100644
--- a/object.h
+++ b/object.h
@@ -151,6 +151,8 @@ struct object_list *object_list_insert(struct object *item,
 
 int object_list_contains(struct object_list *list, struct object *obj);
 
+void object_list_free(struct object_list **list);
+
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9ca356ee29..6c06099dc7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -787,10 +787,15 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	bitmap_git->result = wants_bitmap;
 	bitmap_git->haves = haves_bitmap;
 
+	object_list_free(&wants);
+	object_list_free(&haves);
+
 	return bitmap_git;
 
 cleanup:
 	free_bitmap_index(bitmap_git);
+	object_list_free(&wants);
+	object_list_free(&haves);
 	return NULL;
 }
 
-- 
2.25.0.785.g49bcbe7794

