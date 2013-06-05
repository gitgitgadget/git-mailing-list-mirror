From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] list-objects: optimize "revs->blob_objects = 0" case
Date: Wed, 5 Jun 2013 18:40:05 -0400
Message-ID: <20130605224004.GC15607@sigill.intra.peff.net>
References: <20130605223551.GF8664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Harvey <iharvey@good.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 00:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkMNL-0006a6-KW
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 00:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241Ab3FEWkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 18:40:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:54346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3FEWkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 18:40:07 -0400
Received: (qmail 17012 invoked by uid 102); 5 Jun 2013 22:40:53 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 17:40:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 18:40:05 -0400
Content-Disposition: inline
In-Reply-To: <20130605223551.GF8664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226474>

If we are traversing trees during a "--objects"
traversal, we may skip blobs if the "blob_objects" field of
rev_info is not set. But we do so as the first thing in
process_blob(), only after we have actually created the
"struct blob" object, incurring a hash lookup. We can
optimize out this no-op call completely.

This does not actually affect any current code, as all of
the current traversals always set blob_objects when looking
at objects, anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects.c b/list-objects.c
index c8c3463..77e6ec5 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -116,7 +116,7 @@ static void process_tree(struct rev_info *revs,
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path,
 					cb_data);
-		else
+		else if (revs->blob_objects)
 			process_blob(revs,
 				     lookup_blob(entry.sha1),
 				     show, &me, entry.path,
-- 
1.8.3.rc2.14.g7eee6b3
