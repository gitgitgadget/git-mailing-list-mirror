From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 02/11] Reorganize the object memory pools so we can release them
Date: Fri, 9 Nov 2007 06:06:13 -0500
Message-ID: <20071109110613.GB19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRhE-0007XS-Et
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbXKILGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXKILGR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34086 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbXKILGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:16 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRgh-0003Bs-Tw; Fri, 09 Nov 2007 06:06:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4F3CB20FBAE; Fri,  9 Nov 2007 06:06:13 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64155>

This changes the object memory allocators in alloc.c so that we
are storing all information about each allocator within a single
struct, rather than hiding it inside of the allocation function.
By keeping this state information in a struct we are better able to
organize a function that would release the allocated memory blocks
back to the system allocator.

Each block allocated via xmalloc() is chained together into a linked
list so we can free them when if we later need to.  A nice side
effect of this change is we can avoid the increment of the number
of allocations and instead compute this after the fact based upon
the number of blocks in the linked lists.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 alloc.c |   86 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/alloc.c b/alloc.c
index 216c23a..a61ae41 100644
--- a/alloc.c
+++ b/alloc.c
@@ -18,23 +18,62 @@
 
 #define BLOCKING 1024
 
-#define DEFINE_ALLOCATOR(name, type)				\
-static unsigned int name##_allocs;				\
+struct node_block
+{
+	struct node_block *next;
+};
+
+struct node_pool
+{
+	struct node_block *block_list;
+	char *base;
+	size_t nr;
+};
+
+#ifdef NO_C99_FORMAT
+#define SZ_FMT "%5u"
+#else
+#define SZ_FMT "%5zu"
+#endif
+
+static void report(const char* name, struct node_pool *p, size_t sz)
+{
+	unsigned int count = 0;
+	struct node_block *b;
+
+	for (b = p->block_list; b; b = b->next)
+		count += BLOCKING;
+	count -= p->nr;
+
+	sz = (count * sz) >> 10;
+	fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, sz);
+}
+
+#undef SZ_FMT
+
+#define DEFINE_ALLOCATOR(name, t)				\
+static struct node_pool name##_pool;				\
 void *alloc_##name##_node(void)					\
 {								\
-	static int nr;						\
-	static type *block;					\
 	void *ret;						\
 								\
-	if (!nr) {						\
-		nr = BLOCKING;					\
-		block = xmalloc(BLOCKING * sizeof(type));	\
+	if (!name##_pool.nr) {					\
+		struct node_block *b;				\
+		b = xmalloc(sizeof(*b) + BLOCKING * sizeof(t));	\
+		b->next = name##_pool.block_list;		\
+		name##_pool.block_list = b;			\
+		name##_pool.base = (char*)(b + 1);		\
+		name##_pool.nr = BLOCKING;			\
 	}							\
-	nr--;							\
-	name##_allocs++;					\
-	ret = block++;						\
-	memset(ret, 0, sizeof(type));				\
+	ret = name##_pool.base;					\
+	name##_pool.nr--;					\
+	name##_pool.base += sizeof(t);				\
+	memset(ret, 0, sizeof(t));				\
 	return ret;						\
+}								\
+static void report_##name(void)					\
+{								\
+	report(#name, &name##_pool, sizeof(t));			\
 }
 
 union any_object {
@@ -51,26 +90,11 @@ DEFINE_ALLOCATOR(commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
 DEFINE_ALLOCATOR(object, union any_object)
 
-#ifdef NO_C99_FORMAT
-#define SZ_FMT "%u"
-#else
-#define SZ_FMT "%zu"
-#endif
-
-static void report(const char* name, unsigned int count, size_t size)
-{
-    fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
-}
-
-#undef SZ_FMT
-
-#define REPORT(name)	\
-    report(#name, name##_allocs, name##_allocs*sizeof(struct name) >> 10)
-
 void alloc_report(void)
 {
-	REPORT(blob);
-	REPORT(tree);
-	REPORT(commit);
-	REPORT(tag);
+	report_blob();
+	report_tree();
+	report_commit();
+	report_tag();
+	report_object();
 }
-- 
1.5.3.5.1622.g41d10
