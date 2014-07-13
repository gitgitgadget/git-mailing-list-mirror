From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/8] alloc: write out allocator definitions
Date: Sun, 13 Jul 2014 02:41:51 -0400
Message-ID: <20140713064150.GB4852@sigill.intra.peff.net>
References: <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:41:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DTx-0008MN-5u
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaGMGly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:41:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:32928 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752391AbaGMGlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:41:53 -0400
Received: (qmail 30902 invoked by uid 102); 13 Jul 2014 06:41:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:41:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:41:51 -0400
Content-Disposition: inline
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253438>

Because the allocator functions for tree, blobs, etc are all
very similar, we originally used a macro to avoid repeating
ourselves. Since the prior commit, though, the heavy lifting
is done by an inline helper function.  The macro does still
save us a few lines, but at some readability cost.  It
obfuscates the function definitions (and makes them hard to
find via grep).

Much worse, though, is the fact that it isn't used
consistently for all allocators. Somebody coming later may
be tempted to modify DEFINE_ALLOCATOR, but they would miss
alloc_commit_node, which is treated specially.

Let's just drop the macro and write everything out
explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
 alloc.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/alloc.c b/alloc.c
index d7c3605..03e458b 100644
--- a/alloc.c
+++ b/alloc.c
@@ -18,13 +18,6 @@
 
 #define BLOCKING 1024
 
-#define DEFINE_ALLOCATOR(name, type)				\
-static struct alloc_state name##_state;				\
-void *alloc_##name##_node(void)					\
-{								\
-	return alloc_node(&name##_state, sizeof(type));		\
-}
-
 union any_object {
 	struct object object;
 	struct blob blob;
@@ -55,10 +48,33 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 	return ret;
 }
 
-DEFINE_ALLOCATOR(blob, struct blob)
-DEFINE_ALLOCATOR(tree, struct tree)
-DEFINE_ALLOCATOR(tag, struct tag)
-DEFINE_ALLOCATOR(object, union any_object)
+static struct alloc_state blob_state;
+void *alloc_blob_node(void)
+{
+	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
+	return b;
+}
+
+static struct alloc_state tree_state;
+void *alloc_tree_node(void)
+{
+	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
+	return t;
+}
+
+static struct alloc_state tag_state;
+void *alloc_tag_node(void)
+{
+	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
+	return t;
+}
+
+static struct alloc_state object_state;
+void *alloc_object_node(void)
+{
+	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
+	return obj;
+}
 
 static struct alloc_state commit_state;
 
-- 
2.0.0.566.gfe3e6b2
