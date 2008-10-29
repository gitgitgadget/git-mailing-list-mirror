From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/9] make unpack_object_header() non fatal
Date: Wed, 29 Oct 2008 19:02:46 -0400
Message-ID: <1225321372-6570-4-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
 <1225321372-6570-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:05:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6t-0004tU-0i
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbYJ2XD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758137AbYJ2XDY
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352AbYJ2XDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:22 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99423>

It is possible to have pack corruption in the object header.  Currently
unpack_object_header() simply die() on them instead of letting the caller
deal with that gracefully.

So let's have unpack_object_header() return an error instead, and find
a better name for unpack_object_header_gently() in that context.  All
callers of unpack_object_header() are ready for it.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 +-
 cache.h                |    2 +-
 sha1_file.c            |   20 +++++++++++---------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d4c721b..9e249c9 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1002,7 +1002,7 @@ static void check_object(struct object_entry *entry)
 		 * We want in_pack_type even if we do not reuse delta
 		 * since non-delta representations could still be reused.
 		 */
-		used = unpack_object_header_gently(buf, avail,
+		used = unpack_object_header_buffer(buf, avail,
 						   &entry->in_pack_type,
 						   &entry->size);
 
diff --git a/cache.h b/cache.h
index a3c77f0..1a9edf3 100644
--- a/cache.h
+++ b/cache.h
@@ -751,7 +751,7 @@ extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 extern int matches_pack_name(struct packed_git *p, const char *name);
diff --git a/sha1_file.c b/sha1_file.c
index e57949b..7698177 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1110,7 +1110,8 @@ static int legacy_loose_object(unsigned char *map)
 		return 0;
 }
 
-unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep)
+unsigned long unpack_object_header_buffer(const unsigned char *buf,
+		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
 	unsigned shift;
 	unsigned char c;
@@ -1122,10 +1123,10 @@ unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned lon
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
-		if (len <= used)
-			return 0;
-		if (sizeof(long) * 8 <= shift)
+		if (len <= used || sizeof(long) * 8 <= shift) {
+			error("bad object header");
 			return 0;
+		}
 		c = buf[used++];
 		size += (c & 0x7f) << shift;
 		shift += 7;
@@ -1164,7 +1165,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	 * really worth it and we don't write it any longer.  But we
 	 * can still read it.
 	 */
-	used = unpack_object_header_gently(map, mapsize, &type, &size);
+	used = unpack_object_header_buffer(map, mapsize, &type, &size);
 	if (!used || !valid_loose_object_type[type])
 		return -1;
 	map += used;
@@ -1411,10 +1412,11 @@ static int unpack_object_header(struct packed_git *p,
 	 * insane, so we know won't exceed what we have been given.
 	 */
 	base = use_pack(p, w_curs, *curpos, &left);
-	used = unpack_object_header_gently(base, left, &type, sizep);
-	if (!used)
-		die("object offset outside of pack file");
-	*curpos += used;
+	used = unpack_object_header_buffer(base, left, &type, sizep);
+	if (!used) {
+		type = OBJ_BAD;
+	} else
+		*curpos += used;
 
 	return type;
 }
-- 
1.6.0.3.757.g01be.dirty
