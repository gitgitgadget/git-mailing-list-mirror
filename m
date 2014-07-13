From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/8] alloc.c: remove the alloc_raw_commit_node() function
Date: Sun, 13 Jul 2014 02:41:41 -0400
Message-ID: <20140713064140.GA4852@sigill.intra.peff.net>
References: <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DTo-0008BG-6J
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbaGMGlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:41:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:32923 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752391AbaGMGln (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:41:43 -0400
Received: (qmail 30837 invoked by uid 102); 13 Jul 2014 06:41:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:41:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:41:41 -0400
Content-Disposition: inline
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253437>

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

In order to encapsulate the setting of the unique commit index, commit
969eba63 ("commit: push commit_index update into alloc_commit_node",
10-06-2014) introduced a (logically private) intermediary allocator
function. However, this function (alloc_raw_commit_node()) was declared
as a public function, which undermines its entire purpose.

Introduce an inline function, alloc_node(), which implements the main
logic of the allocator used by DEFINE_ALLOCATOR, and redefine the macro
in terms of the new function. In addition, use the new function in the
implementation of the alloc_commit_node() allocator, rather than the
intermediary allocator, which can now be removed.

Noticed by sparse ("symbol 'alloc_raw_commit_node' was not declared.
Should it be static?").

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Jeff King <peff@peff.net>
---
 alloc.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/alloc.c b/alloc.c
index eb22a45..d7c3605 100644
--- a/alloc.c
+++ b/alloc.c
@@ -19,22 +19,10 @@
 #define BLOCKING 1024
 
 #define DEFINE_ALLOCATOR(name, type)				\
-static unsigned int name##_allocs;				\
+static struct alloc_state name##_state;				\
 void *alloc_##name##_node(void)					\
 {								\
-	static int nr;						\
-	static type *block;					\
-	void *ret;						\
-								\
-	if (!nr) {						\
-		nr = BLOCKING;					\
-		block = xmalloc(BLOCKING * sizeof(type));	\
-	}							\
-	nr--;							\
-	name##_allocs++;					\
-	ret = block++;						\
-	memset(ret, 0, sizeof(type));				\
-	return ret;						\
+	return alloc_node(&name##_state, sizeof(type));		\
 }
 
 union any_object {
@@ -45,16 +33,39 @@ union any_object {
 	struct tag tag;
 };
 
+struct alloc_state {
+	int count; /* total number of nodes allocated */
+	int nr;    /* number of nodes left in current allocation */
+	void *p;   /* first free node in current allocation */
+};
+
+static inline void *alloc_node(struct alloc_state *s, size_t node_size)
+{
+	void *ret;
+
+	if (!s->nr) {
+		s->nr = BLOCKING;
+		s->p = xmalloc(BLOCKING * node_size);
+	}
+	s->nr--;
+	s->count++;
+	ret = s->p;
+	s->p = (char *)s->p + node_size;
+	memset(ret, 0, node_size);
+	return ret;
+}
+
 DEFINE_ALLOCATOR(blob, struct blob)
 DEFINE_ALLOCATOR(tree, struct tree)
-DEFINE_ALLOCATOR(raw_commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
 DEFINE_ALLOCATOR(object, union any_object)
 
+static struct alloc_state commit_state;
+
 void *alloc_commit_node(void)
 {
 	static int commit_count;
-	struct commit *c = alloc_raw_commit_node();
+	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->index = commit_count++;
 	return c;
 }
@@ -66,13 +77,13 @@ static void report(const char *name, unsigned int count, size_t size)
 }
 
 #define REPORT(name, type)	\
-    report(#name, name##_allocs, name##_allocs * sizeof(type) >> 10)
+    report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
 
 void alloc_report(void)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
-	REPORT(raw_commit, struct commit);
+	REPORT(commit, struct commit);
 	REPORT(tag, struct tag);
 	REPORT(object, union any_object);
 }
-- 
2.0.0.566.gfe3e6b2
