From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] alloc: factor out commit index
Date: Fri, 11 Jul 2014 04:48:47 -0400
Message-ID: <20140711084847.GE5625@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5WVi-0004zG-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 10:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbaGKIsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 04:48:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:59967 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752492AbaGKIst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 04:48:49 -0400
Received: (qmail 18677 invoked by uid 102); 11 Jul 2014 08:48:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 03:48:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 04:48:47 -0400
Content-Disposition: inline
In-Reply-To: <20140711084141.GA5521@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253260>

We keep a static counter to set the commit index on newly
allocated objects. However, since we also need to set the
index on any_objects which are converted to commits, let's
make the counter available as a public function.

While we're moving it, let's make sure the counter is
allocated as an unsigned integer to match the index field in
"struct commit".

Signed-off-by: Jeff King <peff@peff.net>
---
 alloc.c | 9 +++++++--
 cache.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index fd5fcb7..21f3d81 100644
--- a/alloc.c
+++ b/alloc.c
@@ -64,11 +64,16 @@ DEFINE_ALLOCATOR(object, OBJ_NONE, union any_object)
 
 static struct alloc_state commit_state;
 
+unsigned int alloc_commit_index(void)
+{
+	static unsigned int count;
+	return count++;
+}
+
 void *alloc_commit_node(void)
 {
-	static int commit_count;
 	struct commit *c = alloc_node(&commit_state, OBJ_COMMIT, sizeof(struct commit));
-	c->index = commit_count++;
+	c->index = alloc_commit_index();
 	return c;
 }
 
diff --git a/cache.h b/cache.h
index df65231..42a5e86 100644
--- a/cache.h
+++ b/cache.h
@@ -1376,6 +1376,7 @@ extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
+extern unsigned int alloc_commit_index(void);
 
 /* trace.c */
 __attribute__((format (printf, 1, 2)))
-- 
2.0.0.566.gfe3e6b2
