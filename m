From: Jeff King <peff@peff.net>
Subject: [PATCH 01/16] foreach_alt_odb: propagate return value from callback
Date: Fri, 3 Oct 2014 16:21:04 -0400
Message-ID: <20141003202104.GA16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:21:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9Lk-0006QB-3S
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbaJCUVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:21:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:54806 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754475AbaJCUVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:21:06 -0400
Received: (qmail 2655 invoked by uid 102); 3 Oct 2014 20:21:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:21:06 -0500
Received: (qmail 14894 invoked by uid 107); 3 Oct 2014 20:21:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:21:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:21:04 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257851>

We check the return value of the callback and stop iterating
if it is non-zero. However, we do not make the non-zero
return value available to the caller, so they have no way of
knowing whether the operation succeeded or not (technically
they can keep their own error flag in the callback data, but
that is unlike our other for_each functions).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  2 +-
 sha1_file.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 8206039..cd16e25 100644
--- a/cache.h
+++ b/cache.h
@@ -1143,7 +1143,7 @@ extern void prepare_alt_odb(void);
 extern void read_info_alternates(const char * relative_base, int depth);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
-extern void foreach_alt_odb(alt_odb_fn, void*);
+extern int foreach_alt_odb(alt_odb_fn, void*);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index c08c0cb..bae1c15 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -412,14 +412,18 @@ void add_to_alternates_file(const char *reference)
 		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
 }
 
-void foreach_alt_odb(alt_odb_fn fn, void *cb)
+int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
+	int r = 0;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next)
-		if (fn(ent, cb))
-			return;
+	for (ent = alt_odb_list; ent; ent = ent->next) {
+		int r = fn(ent, cb);
+		if (r)
+			break;
+	}
+	return r;
 }
 
 void prepare_alt_odb(void)
-- 
2.1.1.566.gdb1f904
