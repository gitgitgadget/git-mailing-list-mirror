From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] sha1_object_info_extended: provide delta base sha1s
Date: Sat, 21 Dec 2013 09:24:20 -0500
Message-ID: <20131221142419.GA29679@sigill.intra.peff.net>
References: <20131221142336.GA28649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuNTe-0005y6-Kn
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab3LUOYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:24:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:48533 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754262Ab3LUOYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:24:21 -0500
Received: (qmail 9257 invoked by uid 102); 21 Dec 2013 14:24:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:24:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:24:20 -0500
Content-Disposition: inline
In-Reply-To: <20131221142336.GA28649@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239621>

A caller of sha1_object_info_extended technically has enough
information to determine the base sha1 from the results of
the call. It knows the pack, offset, and delta type of the
object, which is sufficient to find the base.

However, the functions to do so are not publicly available,
and the code itself is intimate enough with the pack details
that it should be abstracted away. We could add a public
helper to allow callers to query the delta base separately,
but it is simpler and slightly more efficient to optionally
grab it along with the rest of the object_info data.

For cases where the object is not stored as a delta, we
write the null sha1 into the query field. A careful caller
could check "oi.whence == OI_PACKED && oi.u.packed.is_delta"
before looking at the base sha1, but using the null sha1
provides a simple alternative (and gives a better sanity
check for a non-careful caller than simply returning random
bytes).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  1 +
 sha1_file.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/cache.h b/cache.h
index ce377e1..67356db 100644
--- a/cache.h
+++ b/cache.h
@@ -1074,6 +1074,7 @@ struct object_info {
 	enum object_type *typep;
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
+	unsigned char *delta_base_sha1;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index daacc0c..4e8dd8b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1667,6 +1667,38 @@ static off_t get_delta_base(struct packed_git *p,
 	return base_offset;
 }
 
+/*
+ * Like get_delta_base above, but we return the sha1 instead of the pack
+ * offset. This means it is cheaper for REF deltas (we do not have to do
+ * the final object lookup), but more expensive for OFS deltas (we
+ * have to load the revidx to convert the offset back into a sha1).
+ */
+static const unsigned char *get_delta_base_sha1(struct packed_git *p,
+						struct pack_window **w_curs,
+						off_t curpos,
+						enum object_type type,
+						off_t delta_obj_offset)
+{
+	if (type == OBJ_REF_DELTA) {
+		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
+		return base;
+	} else if (type == OBJ_OFS_DELTA) {
+		struct revindex_entry *revidx;
+		off_t base_offset = get_delta_base(p, w_curs, &curpos,
+						   type, delta_obj_offset);
+
+		if (!base_offset)
+			return NULL;
+
+		revidx = find_pack_revindex(p, base_offset);
+		if (!revidx)
+			return NULL;
+
+		return nth_packed_object_sha1(p, revidx->nr);
+	} else
+		return NULL;
+}
+
 int unpack_object_header(struct packed_git *p,
 			 struct pack_window **w_curs,
 			 off_t *curpos,
@@ -1824,6 +1856,22 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 		}
 	}
 
+	if (oi->delta_base_sha1) {
+		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+			const unsigned char *base;
+
+			base = get_delta_base_sha1(p, &w_curs, curpos,
+						   type, obj_offset);
+			if (!base) {
+				type = OBJ_BAD;
+				goto out;
+			}
+
+			hashcpy(oi->delta_base_sha1, base);
+		} else
+			hashclr(oi->delta_base_sha1);
+	}
+
 out:
 	unuse_pack(&w_curs);
 	return type;
@@ -2407,6 +2455,9 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	git_zstream stream;
 	char hdr[32];
 
+	if (oi->delta_base_sha1)
+		hashclr(oi->delta_base_sha1);
+
 	/*
 	 * If we don't care about type or size, then we don't
 	 * need to look inside the object at all. Note that we
@@ -2457,6 +2508,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 			*(oi->sizep) = co->size;
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) = 0;
+		if (oi->delta_base_sha1)
+			hashclr(oi->delta_base_sha1);
 		oi->whence = OI_CACHED;
 		return 0;
 	}
-- 
1.8.5.1.399.g900e7cd
