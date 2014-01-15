From: Jeff King <peff@peff.net>
Subject: [PATCH] do not discard revindex when re-preparing packfiles
Date: Wed, 15 Jan 2014 06:17:48 -0500
Message-ID: <20140115111746.GA8872@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OTq-0001E3-IP
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbaAOLRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:17:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:32802 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751170AbaAOLRu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 06:17:50 -0500
Received: (qmail 17120 invoked by uid 102); 15 Jan 2014 11:17:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 05:17:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 06:17:48 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240458>

When an object lookup fails, we re-read the objects/pack
directory to pick up any new packfiles that may have been
created since our last read. We also discard any pack
revindex structs we've allocated.

The discarding is a problem for the pack-bitmap code, which keeps
a pointer to the revindex for the bitmapped pack. After the
discard, the pointer is invalid, and we may read free()d
memory.

Other revindex users do not keep a bare pointer to the
revindex; instead, they always access it through
revindex_for_pack(), which lazily builds the revindex. So
one solution is to teach the pack-bitmap code a similar
trick. It would be slightly less efficient, but probably not
all that noticeable.

However, it turns out this discarding is not actually
necessary. When we call reprepare_packed_git, we do not
throw away our old pack list. We keep the existing entries,
and only add in new ones. So there is no safety problem; we
will still have the pack struct that matches each revindex.
The packfile itself may go away, of course, but we are
already prepared to handle that, and it may happen outside
of reprepare_packed_git anyway.

Throwing away the revindex may save some RAM if the pack
never gets reused (about 12 bytes per object). But it also
wastes some CPU time (to regenerate the index) if the pack
does get reused. It's hard to say which is more valuable,
but in either case, it happens very rarely (only when we
race with a simultaneous repack). Just leaving the revindex
in place is simple and safe both for current and future
code.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of jk/pack-bitmap.

 pack-revindex.c | 11 -----------
 pack-revindex.h |  1 -
 sha1_file.c     |  1 -
 3 files changed, 13 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 0bb13b1..5bd7c61 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -245,14 +245,3 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 
 	return pridx->revindex + pos;
 }
-
-void discard_revindex(void)
-{
-	if (pack_revindex_hashsz) {
-		int i;
-		for (i = 0; i < pack_revindex_hashsz; i++)
-			free(pack_revindex[i].revindex);
-		free(pack_revindex);
-		pack_revindex_hashsz = 0;
-	}
-}
diff --git a/pack-revindex.h b/pack-revindex.h
index 866ca9c..d737f98 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -15,6 +15,5 @@ struct pack_revindex *revindex_for_pack(struct packed_git *p);
 int find_revindex_position(struct pack_revindex *pridx, off_t ofs);
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
-void discard_revindex(void);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index df89b57..45f9bb4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1279,7 +1279,6 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	discard_revindex();
 	prepare_packed_git_run_once = 0;
 	prepare_packed_git();
 }
-- 
1.8.5.2.500.g8060133
