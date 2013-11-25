From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 21:04:08 +0100
Message-ID: <89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
References: <878uwc2r7c.fsf@thomasrast.ch>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2OZ-00025f-B4
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab3KYUE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:04:28 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:56408 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757117Ab3KYUE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:04:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 4F5024D658F;
	Mon, 25 Nov 2013 21:04:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JoKunn9dupHc; Mon, 25 Nov 2013 21:04:15 +0100 (CET)
Received: from linux-a99i.v.cablecom.net (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 833234D64DE;
	Mon, 25 Nov 2013 21:04:14 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.355.g6969a19
In-Reply-To: <878uwc2r7c.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238336>

This shuts up compiler warnings about unused functions.  No such
warnings are currently triggered, but if someone were to actually use
init_NAME_with_stride() as documented, they would get a warning about
init_NAME() being unused.

While there, write a comment about why we need two declarations of the
same variable.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

Here's a version that has a fat comment instead of the removal.

Also, since I was rerolling anyway I put a reason why we need this.
In the original motivation I actually created more functions
afterwards, which made it more convincing, but the problem already
exists.


 commit-slab.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index d77aaea..21d54f1 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -45,8 +45,8 @@ struct slabname {							\
 };									\
 static int stat_ ##slabname## realloc;					\
 									\
-static void init_ ##slabname## _with_stride(struct slabname *s,		\
-					    unsigned stride)		\
+static inline void init_ ##slabname## _with_stride(struct slabname *s,	\
+						   unsigned stride)	\
 {									\
 	unsigned int elem_size;						\
 	if (!stride)							\
@@ -58,12 +58,12 @@ struct slabname {							\
 	s->slab = NULL;							\
 }									\
 									\
-static void init_ ##slabname(struct slabname *s)			\
+static inline void init_ ##slabname(struct slabname *s)			\
 {									\
 	init_ ##slabname## _with_stride(s, 1);				\
 }									\
 									\
-static void clear_ ##slabname(struct slabname *s)			\
+static inline void clear_ ##slabname(struct slabname *s)		\
 {									\
 	int i;								\
 	for (i = 0; i < s->slab_count; i++)				\
@@ -73,8 +73,8 @@ struct slabname {							\
 	s->slab = NULL;							\
 }									\
 									\
-static elemtype *slabname## _at(struct slabname *s,			\
-				const struct commit *c)			\
+static inline elemtype *slabname## _at(struct slabname *s,		\
+				       const struct commit *c)		\
 {									\
 	int nth_slab, nth_slot;						\
 									\
@@ -98,4 +98,16 @@ struct slabname {							\
 									\
 static int stat_ ##slabname## realloc
 
+/*
+ * Note that this seemingly redundant second declaration is required
+ * to allow a terminating semicolon, which makes instantiations look
+ * like function declarations.  I.e., the expansion of
+ *
+ *    define_commit_slab(indegree, int);
+ *
+ * ends in 'static int stat_indegreerealloc;'.  This would otherwise
+ * be a syntax error according (at least) to ISO C.  It's hard to
+ * catch because GCC silently parses it by default.
+ */
+
 #endif /* COMMIT_SLAB_H */
-- 
1.8.5.rc2.355.g6969a19
