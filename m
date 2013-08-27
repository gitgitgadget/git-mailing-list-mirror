From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 20/23] pack index v3
Date: Tue, 27 Aug 2013 00:26:04 -0400
Message-ID: <1377577567-27655-21-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArr-0007MP-3l
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3H0E0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab3H0E0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:34 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600F6B9O5GV90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 2303A2DA05FA	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:30 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233057>

This is a minor change over pack index v2.  Since pack v4 already contains
the sorted SHA1 table, it is therefore ommitted from the index file.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 pack-write.c    |  6 +++++-
 packv4-create.c | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index ca9e63b..631007e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -87,6 +87,8 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
 	index_version = need_large_offset(last_obj_offset, opts) ? 2 : opts->version;
+	if (index_version < opts->version)
+		index_version = opts->version;
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -127,7 +129,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 			uint32_t offset = htonl(obj->offset);
 			sha1write(f, &offset, 4);
 		}
-		sha1write(f, obj->sha1, 20);
+		/* Pack v4 (using index v3) carries the SHA1 table already */
+		if (index_version < 3)
+			sha1write(f, obj->sha1, 20);
 		git_SHA1_Update(&ctx, obj->sha1, 20);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && !hashcmp(list[-2]->sha1, obj->sha1)))
diff --git a/packv4-create.c b/packv4-create.c
index 63dc3d2..bb171c5 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -1007,8 +1007,10 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	struct packed_git *p;
 	struct sha1file *f;
 	struct pack_idx_entry *objs, **p_objs;
+	struct pack_idx_option idx_opts;
 	unsigned i, nr_objects;
 	off_t written = 0;
+	unsigned char pack_sha1[20];
 
 	p = open_pack(src_pack);
 	if (!p)
@@ -1034,11 +1036,17 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	for (i = 0; i < nr_objects; i++) {
 		off_t obj_pos = written;
 		struct pack_idx_entry *obj = p_objs[i];
+		crc32_begin(f);
 		written += packv4_write_object(f, p, obj);
 		obj->offset = obj_pos;
+		obj->crc32 = crc32_end(f);
 	}
 
-	sha1close(f, NULL, CSUM_CLOSE | CSUM_FSYNC);
+	sha1close(f, pack_sha1, CSUM_CLOSE | CSUM_FSYNC);
+
+	reset_pack_idx_option(&idx_opts);
+	idx_opts.version = 3;
+	write_idx_file(dst_pack, p_objs, nr_objects, &idx_opts, pack_sha1);
 }
 
 static int git_pack_config(const char *k, const char *v, void *cb)
-- 
1.8.4.22.g54757b7
