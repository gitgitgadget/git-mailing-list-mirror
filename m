From: Jeff King <peff@peff.net>
Subject: [PATCH v2 09/25] reachable: mark index blobs as SEEN
Date: Wed, 15 Oct 2014 18:40:37 -0400
Message-ID: <20141015224037.GI25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXFM-0007fv-At
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbaJOWkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:40:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:58958 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbaJOWkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:40:39 -0400
Received: (qmail 2395 invoked by uid 102); 15 Oct 2014 22:40:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:40:39 -0500
Received: (qmail 28026 invoked by uid 107); 15 Oct 2014 22:40:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:40:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:40:37 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we mark all reachable objects for pruning, that
includes blobs mentioned by the index. However, we do not
mark these with the SEEN flag, as we do for objects that we
find by traversing (we also do not add them to the pending
list, but that is because there is nothing further to
traverse with them).

This doesn't cause any problems with prune, because it
checks only that the object exists in the global object
hash, and not its flags. However, let's mark these objects
to be consistent and avoid any later surprises.

Signed-off-by: Jeff King <peff@peff.net>
---
This code actually gets dropped later on in the series (when we teach
the revision machinery to look at index objects), so this could
technically be omitted. But it also keeps the minor behavior change
here by itself, where it is explained, instead of as a side effect of
the movement.

 reachable.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index 4e68cfa..d03f829 100644
--- a/reachable.c
+++ b/reachable.c
@@ -55,6 +55,8 @@ static void add_cache_refs(struct rev_info *revs)
 
 	read_cache();
 	for (i = 0; i < active_nr; i++) {
+		struct blob *blob;
+
 		/*
 		 * The index can contain blobs and GITLINKs, GITLINKs are hashes
 		 * that don't actually point to objects in the repository, it's
@@ -65,7 +67,10 @@ static void add_cache_refs(struct rev_info *revs)
 		if (S_ISGITLINK(active_cache[i]->ce_mode))
 			continue;
 
-		lookup_blob(active_cache[i]->sha1);
+		blob = lookup_blob(active_cache[i]->sha1);
+		if (blob)
+			blob->object.flags |= SEEN;
+
 		/*
 		 * We could add the blobs to the pending list, but quite
 		 * frankly, we don't care. Once we've looked them up, and
-- 
2.1.2.596.g7379948
