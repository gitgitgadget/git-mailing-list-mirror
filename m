From: Jeff King <peff@peff.net>
Subject: [PATCH] sha1_file: squelch "packfile cannot be accessed" warnings
Date: Mon, 30 Mar 2015 20:47:38 -0400
Message-ID: <20150331004738.GA24431@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 02:48:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YckLK-00023m-D8
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 02:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbbCaArm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 20:47:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:40088 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753526AbbCaArl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 20:47:41 -0400
Received: (qmail 26602 invoked by uid 102); 31 Mar 2015 00:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 19:47:41 -0500
Received: (qmail 18734 invoked by uid 107); 31 Mar 2015 00:47:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 20:47:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 20:47:38 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266494>

When we find an object in a packfile index, we make sure we
can still open the packfile itself (or that it is already
open), as it might have been deleted by a simultaneous
repack. If we can't access the packfile, we print a warning
for the user and tell the caller that we don't have the
object (we can then look in other packfiles, or find a loose
version, before giving up).

The warning we print to the user isn't really accomplishing
anything, and it is potentially confusing to users. In the
normal case, it is complete noise; we find the object
elsewhere, and the user does not have to care that we racily
saw a packfile index that became stale. It didn't affect the
operation at all.

A possibly more interesting case is when we later can't find
the object, and report failure to the user. In this case the
warning could be considered a clue toward that ultimate
failure. But it's not really a useful clue in practice. We
wouldn't even print it consistently (since we are racing
with another process, we might not even see the .idx file,
or we might win the race and open the packfile, completing
the operation).

This patch drops the warning entirely (not only from the
fill_pack_entry site, but also from an identical use in
pack-objects). If we did find the warning interesting in the
error case, we could stuff it away and reveal it to the user
when we later die() due to the broken object. But that
complexity just isn't worth it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 4 +---
 sha1_file.c            | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c3a7516..c067107 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -961,10 +961,8 @@ static int want_object_in_pack(const unsigned char *sha1,
 		off_t offset = find_pack_entry_one(sha1, p);
 		if (offset) {
 			if (!*found_pack) {
-				if (!is_pack_valid(p)) {
-					warning("packfile %s cannot be accessed", p->pack_name);
+				if (!is_pack_valid(p))
 					continue;
-				}
 				*found_offset = offset;
 				*found_pack = p;
 			}
diff --git a/sha1_file.c b/sha1_file.c
index 88f06ba..0b0d07e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2473,10 +2473,8 @@ static int fill_pack_entry(const unsigned char *sha1,
 	 * answer, as it may have been deleted since the index was
 	 * loaded!
 	 */
-	if (!is_pack_valid(p)) {
-		warning("packfile %s cannot be accessed", p->pack_name);
+	if (!is_pack_valid(p))
 		return 0;
-	}
 	e->offset = offset;
 	e->p = p;
 	hashcpy(e->sha1, sha1);
-- 
2.4.0.rc0.363.gf9f328b
