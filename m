From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] downgrade "packfile cannot be accessed" errors to
 warnings
Date: Fri, 14 Oct 2011 14:04:16 -0400
Message-ID: <20111014180415.GB17412@sigill.intra.peff.net>
References: <20111014012320.GA4395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:04:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REm7M-0005Lg-No
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029Ab1JNSEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 14:04:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60710
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab1JNSEU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 14:04:20 -0400
Received: (qmail 12742 invoked by uid 107); 14 Oct 2011 18:04:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 14:04:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 14:04:16 -0400
Content-Disposition: inline
In-Reply-To: <20111014012320.GA4395@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183590>

These can happen if another process simultaneously prunes a
pack. But that is not usually an error condition, because a
properly-running prune should have repacked the object into
a new pack. So we will notice that the pack has disappeared
unexpectedly, print a message, try other packs (possibly
after re-scanning the list of packs), and find it in the new
pack.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Jeff King <peff@peff.net>
---
Repost with ack from Nicolas, and more obvious subject line. No changes
from earlier version in this thread.

 builtin/pack-objects.c |    2 +-
 sha1_file.c            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8681ccd..ba3705d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -805,7 +805,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		if (offset) {
 			if (!found_pack) {
 				if (!is_pack_valid(p)) {
-					error("packfile %s cannot be accessed", p->pack_name);
+					warning("packfile %s cannot be accessed", p->pack_name);
 					continue;
 				}
 				found_offset = offset;
diff --git a/sha1_file.c b/sha1_file.c
index a22c5b4..27f3b9b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2038,7 +2038,7 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 			 * was loaded!
 			 */
 			if (!is_pack_valid(p)) {
-				error("packfile %s cannot be accessed", p->pack_name);
+				warning("packfile %s cannot be accessed", p->pack_name);
 				goto next;
 			}
 			e->offset = offset;
-- 
1.7.6.4.37.g43b58b
