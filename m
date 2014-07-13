From: Jeff King <peff@peff.net>
Subject: [PATCH v2 6/8] alloc: factor out commit index
Date: Sun, 13 Jul 2014 02:42:08 -0400
Message-ID: <20140713064208.GF4852@sigill.intra.peff.net>
References: <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:42:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DUE-00009x-94
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbaGMGmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:42:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:32942 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752817AbaGMGmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:42:10 -0400
Received: (qmail 30948 invoked by uid 102); 13 Jul 2014 06:42:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:42:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:42:08 -0400
Content-Disposition: inline
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253441>

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
index fd2e32d..12afadf 100644
--- a/alloc.c
+++ b/alloc.c
@@ -82,12 +82,17 @@ void *alloc_object_node(void)
 
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
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
-	c->index = commit_count++;
+	c->index = alloc_commit_index();
 	return c;
 }
 
diff --git a/cache.h b/cache.h
index 44aa439..ba68e11 100644
--- a/cache.h
+++ b/cache.h
@@ -1380,6 +1380,7 @@ extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
+extern unsigned int alloc_commit_index(void);
 
 /* trace.c */
 __attribute__((format (printf, 1, 2)))
-- 
2.0.0.566.gfe3e6b2
