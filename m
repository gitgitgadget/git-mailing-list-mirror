From: Jeff King <peff@peff.net>
Subject: [PATCH v3 02/21] revindex: Export new APIs
Date: Thu, 14 Nov 2013 07:42:54 -0500
Message-ID: <20131114124254.GB10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwGC-0006kC-5B
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723Ab3KNMm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:42:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:39101 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753577Ab3KNMmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:42:55 -0500
Received: (qmail 11292 invoked by uid 102); 14 Nov 2013 12:42:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:42:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:42:54 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237826>

From: Vicent Marti <tanoku@gmail.com>

Allow users to efficiently lookup consecutive entries that are expected
to be found on the same revindex by exporting `find_revindex_position`:
this function takes a pointer to revindex itself, instead of looking up
the proper revindex for a given packfile on each call.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 pack-revindex.c | 38 +++++++++++++++++++++++++-------------
 pack-revindex.h |  8 ++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index b4d2b35..0bb13b1 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -16,11 +16,6 @@
  * get the object sha1 from the main index.
  */
 
-struct pack_revindex {
-	struct packed_git *p;
-	struct revindex_entry *revindex;
-};
-
 static struct pack_revindex *pack_revindex;
 static int pack_revindex_hashsz;
 
@@ -201,15 +196,14 @@ static void create_pack_revindex(struct pack_revindex *rix)
 	sort_revindex(rix->revindex, num_ent, p->pack_size);
 }
 
-struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
+struct pack_revindex *revindex_for_pack(struct packed_git *p)
 {
 	int num;
-	unsigned lo, hi;
 	struct pack_revindex *rix;
-	struct revindex_entry *revindex;
 
 	if (!pack_revindex_hashsz)
 		init_pack_revindex();
+
 	num = pack_revindex_ix(p);
 	if (num < 0)
 		die("internal error: pack revindex fubar");
@@ -217,21 +211,39 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 	rix = &pack_revindex[num];
 	if (!rix->revindex)
 		create_pack_revindex(rix);
-	revindex = rix->revindex;
 
-	lo = 0;
-	hi = p->num_objects + 1;
+	return rix;
+}
+
+int find_revindex_position(struct pack_revindex *pridx, off_t ofs)
+{
+	int lo = 0;
+	int hi = pridx->p->num_objects + 1;
+	struct revindex_entry *revindex = pridx->revindex;
+
 	do {
 		unsigned mi = lo + (hi - lo) / 2;
 		if (revindex[mi].offset == ofs) {
-			return revindex + mi;
+			return mi;
 		} else if (ofs < revindex[mi].offset)
 			hi = mi;
 		else
 			lo = mi + 1;
 	} while (lo < hi);
+
 	error("bad offset for revindex");
-	return NULL;
+	return -1;
+}
+
+struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
+{
+	struct pack_revindex *pridx = revindex_for_pack(p);
+	int pos = find_revindex_position(pridx, ofs);
+
+	if (pos < 0)
+		return NULL;
+
+	return pridx->revindex + pos;
 }
 
 void discard_revindex(void)
diff --git a/pack-revindex.h b/pack-revindex.h
index 8d5027a..866ca9c 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -6,6 +6,14 @@ struct revindex_entry {
 	unsigned int nr;
 };
 
+struct pack_revindex {
+	struct packed_git *p;
+	struct revindex_entry *revindex;
+};
+
+struct pack_revindex *revindex_for_pack(struct packed_git *p);
+int find_revindex_position(struct pack_revindex *pridx, off_t ofs);
+
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
 void discard_revindex(void);
 
-- 
1.8.5.rc0.443.g2df7f3f
