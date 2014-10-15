From: Jeff King <peff@peff.net>
Subject: [PATCH v2 01/25] foreach_alt_odb: propagate return value from
 callback
Date: Wed, 15 Oct 2014 18:33:13 -0400
Message-ID: <20141015223312.GA25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:33:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeX8B-0003BM-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbaJOWdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:33:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:58913 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752178AbaJOWdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:33:15 -0400
Received: (qmail 2005 invoked by uid 102); 15 Oct 2014 22:33:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:33:15 -0500
Received: (qmail 27832 invoked by uid 107); 15 Oct 2014 22:33:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:33:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:33:13 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 5b86065..13fadb6 100644
--- a/cache.h
+++ b/cache.h
@@ -1125,7 +1125,7 @@ extern void prepare_alt_odb(void);
 extern void read_info_alternates(const char * relative_base, int depth);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
-extern void foreach_alt_odb(alt_odb_fn, void*);
+extern int foreach_alt_odb(alt_odb_fn, void*);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index 83f77f0..fa881bf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -413,14 +413,18 @@ void add_to_alternates_file(const char *reference)
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
+		r = fn(ent, cb);
+		if (r)
+			break;
+	}
+	return r;
 }
 
 void prepare_alt_odb(void)
-- 
2.1.2.596.g7379948
