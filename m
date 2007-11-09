From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 04/11] Allow pooled nodes to be recycled back onto a free list
Date: Fri, 9 Nov 2007 06:06:19 -0500
Message-ID: <20071109110619.GD19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRhH-0007XS-It
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbXKILG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbXKILG1
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34092 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbXKILGX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:23 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRgo-0003CI-BL; Fri, 09 Nov 2007 06:06:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B951B20FBAE; Fri,  9 Nov 2007 06:06:19 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64160>

In some cases and for some node types a caller may have used one of
our allocated nodes for some temporary usage and then wants to return
it back to the available free list.  We now define a function that
will thread the object onto the front of a free list, which will be
used only after the current block has been exhausted.

We hold off on looking at the free list until we are sure the current
block is empty.  This saves about 1000 tests of the (usually empty)
free list per block.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 alloc.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index aa429ec..5737a73 100644
--- a/alloc.c
+++ b/alloc.c
@@ -26,6 +26,7 @@ struct node_block
 struct node_pool
 {
 	struct node_block *block_list;
+	void *free_list;
 	char *base;
 	size_t nr;
 };
@@ -38,15 +39,22 @@ struct node_pool
 
 static void report(const char* name, struct node_pool *p, size_t sz)
 {
-	unsigned int count = 0;
+	unsigned int count = 0, free = 0;
 	struct node_block *b;
+	void **f;
 
 	for (b = p->block_list; b; b = b->next)
 		count += BLOCKING;
+	for (f = p->free_list; f; f = *f)
+		free++;
+	free += p->nr;
 	count -= p->nr;
 
 	sz = (count * sz) >> 10;
-	fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, sz);
+	fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)", name, count, sz);
+	if (free)
+		fprintf(stderr, ", %8u on free list", free);
+	fputc('\n', stderr);
 }
 
 #undef SZ_FMT
@@ -59,6 +67,12 @@ void *alloc_##name##_node(void)					\
 								\
 	if (!name##_pool.nr) {					\
 		struct node_block *b;				\
+		if (name##_pool.free_list) {			\
+			ret = name##_pool.free_list;		\
+			name##_pool.free_list = *((void**)ret);	\
+			memset(ret, 0, sizeof(t));		\
+			return ret;				\
+		}						\
 		b = xmalloc(sizeof(*b) + BLOCKING * sizeof(t));	\
 		b->next = name##_pool.block_list;		\
 		name##_pool.block_list = b;			\
@@ -71,6 +85,11 @@ void *alloc_##name##_node(void)					\
 	memset(ret, 0, sizeof(t));				\
 	return ret;						\
 }								\
+void free_##name##_node(void *n)				\
+{								\
+	*((void**)n) = name##_pool.free_list;			\
+	name##_pool.free_list = n;				\
+}								\
 static void report_##name(void)					\
 {								\
 	report(#name, &name##_pool, sizeof(t));			\
-- 
1.5.3.5.1622.g41d10
