From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
Date: Wed, 26 Mar 2014 03:23:29 -0400
Message-ID: <20140326072329.GE32193@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>, Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 08:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiBX-0006F8-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbaCZHXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:23:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:47398 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752695AbaCZHXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:23:31 -0400
Received: (qmail 14596 invoked by uid 102); 26 Mar 2014 07:23:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 02:23:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 03:23:29 -0400
Content-Disposition: inline
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245166>

When we do a bitmap walk, we save the result, which
represents (WANTs & ~HAVEs); i.e., every object we care
about visiting in our walk. However, we throw away the
haves bitmap, which can sometimes be useful, too. Save it
and provide an access function so code which has performed a
walk can query it.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 21 ++++++++++++++++++++-
 pack-bitmap.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index a31e529..f7d417b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -86,6 +86,9 @@ static struct bitmap_index {
 	/* Bitmap result of the last performed walk */
 	struct bitmap *result;
 
+	/* "have" bitmap from the last performed walk */
+	struct bitmap *haves;
+
 	/* Version of the bitmap index */
 	unsigned int version;
 
@@ -769,8 +772,8 @@ int prepare_bitmap_walk(struct rev_info *revs)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
 
 	bitmap_git.result = wants_bitmap;
+	bitmap_git.haves = haves_bitmap;
 
-	bitmap_free(haves_bitmap);
 	return 0;
 }
 
@@ -1097,3 +1100,19 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 	bitmap_free(rebuild);
 	return 0;
 }
+
+int bitmap_have(const unsigned char *sha1)
+{
+	int pos;
+
+	if (!bitmap_git.loaded)
+		return 0; /* no bitmap loaded */
+	if (!bitmap_git.haves)
+		return 0; /* walk had no "haves" */
+
+	pos = bitmap_position_packfile(sha1);
+	if (pos < 0)
+		return 0;
+
+	return bitmap_get(bitmap_git.haves, pos);
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8b7f4e9..a63ee6b 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -49,6 +49,8 @@ int prepare_bitmap_walk(struct rev_info *revs);
 int reuse_partial_packfile_from_bitmap(struct packed_git **packfile, uint32_t *entries, off_t *up_to);
 int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bitmaps, int show_progress);
 
+int bitmap_have(const unsigned char *sha1);
+
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
 void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);
-- 
1.9.1.601.g7ec968e
