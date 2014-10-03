From: Jeff King <peff@peff.net>
Subject: [PATCH 14/16] pack-objects: refactor unpack-unreachable expiration
 check
Date: Fri, 3 Oct 2014 16:39:44 -0400
Message-ID: <20141003203944.GN16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:39:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9dn-0005y2-7R
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbaJCUjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:39:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:54872 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753313AbaJCUjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:39:46 -0400
Received: (qmail 3562 invoked by uid 102); 3 Oct 2014 20:39:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:39:46 -0500
Received: (qmail 15246 invoked by uid 107); 3 Oct 2014 20:39:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:39:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257867>

When we are loosening unreachable packed objects, we do not
bother to process objects that would simply be pruned
immediately anyway. The "would be pruned" check is a simple
comparison, but is about to get more complicated. Let's pull
it out into a separate function.

Note that this is slightly less efficient than the original,
which avoided even opening old packs, since no object in
them could pass the current check, which cares only about
the pack mtime.  But the new rules will depend on the exact
object, so we need to perform the check even for old packs.

Note also that we fix a minor buglet when the pack mtime is
exactly the same as the expiration time. The prune code
considers that worth pruning, whereas our check here
considered it worth keeping. This wasn't a big deal. Besides
being unlikely to happen, the result was simply that the
object was loosened and then pruned, missing the
optimization. Still, we can easily fix it while we are here.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d391934..2fe2ab0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2407,6 +2407,16 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 	return 0;
 }
 
+static int loosened_object_can_be_discarded(const unsigned char *sha1,
+					    unsigned long mtime)
+{
+	if (!unpack_unreachable_expiration)
+		return 0;
+	if (mtime > unpack_unreachable_expiration)
+		return 0;
+	return 1;
+}
+
 static void loosen_unused_packed_objects(struct rev_info *revs)
 {
 	struct packed_git *p;
@@ -2417,17 +2427,14 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 		if (!p->pack_local || p->pack_keep)
 			continue;
 
-		if (unpack_unreachable_expiration &&
-		    p->mtime < unpack_unreachable_expiration)
-			continue;
-
 		if (open_pack_index(p))
 			die("cannot open pack index");
 
 		for (i = 0; i < p->num_objects; i++) {
 			sha1 = nth_packed_object_sha1(p, i);
 			if (!packlist_find(&to_pack, sha1, NULL) &&
-				!has_sha1_pack_kept_or_nonlocal(sha1))
+			    !has_sha1_pack_kept_or_nonlocal(sha1) &&
+			    !loosened_object_can_be_discarded(sha1, p->mtime))
 				if (force_object_loose(sha1, p->mtime))
 					die("unable to force loose object");
 		}
-- 
2.1.1.566.gdb1f904
