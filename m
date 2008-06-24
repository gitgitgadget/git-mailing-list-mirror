From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/3] implement some resilience against pack corruptions
Date: Mon, 23 Jun 2008 21:23:39 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806232122180.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 03:24:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxGx-0004Li-Fh
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 03:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbYFXBXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 21:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYFXBXl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 21:23:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55362 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYFXBXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 21:23:40 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Y00M2A16RV2H0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Jun 2008 21:23:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85959>

We should be able to fall back to loose objects or alternative packs when
a pack becomes corrupted.  This is especially true when an object exists
in one pack only as a delta but its base object is corrupted.  Currently
there is no way to retrieve the former object even if the later is
available in another pack or loose.

This patch allows for a delta to be resolved (with a performance cost)
using a base object from a source other than the pack where that delta
is located.  Same thing for non-delta objects: rather than failing
outright, a search is made in other packs or used loose when the
currently active pack has it but corrupted.

Of course git will become extremely noisy with error messages when that
happens.  However, if the operation succeeds nevertheless, a simple
'git repack -a -f -d' will "fix" the corrupted repository given that all
corrupted objects have a good duplicate somewhere in the object store,
possibly manually copied from another source.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Yes I've been bitten by the corruption described above...

 cache.h     |    2 +
 sha1_file.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index a0688c6..8ad29e3 100644
--- a/cache.h
+++ b/cache.h
@@ -645,6 +645,8 @@ extern struct packed_git {
 	const void *index_data;
 	size_t index_size;
 	uint32_t num_objects;
+	uint32_t num_bad_objects;
+	unsigned char *bad_object_sha1;
 	int index_version;
 	time_t mtime;
 	int pack_fd;
diff --git a/sha1_file.c b/sha1_file.c
index fe4ee3e..ffd31c6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -818,6 +818,8 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	p->index_data = NULL;
 	p->index_size = 0;
 	p->num_objects = 0;
+	p->num_bad_objects = 0;
+	p->bad_object_sha1 = NULL;
 	p->pack_size = st.st_size;
 	p->next = NULL;
 	p->windows = NULL;
@@ -982,6 +984,18 @@ void reprepare_packed_git(void)
 	prepare_packed_git();
 }
 
+static void mark_bad_packed_object(struct packed_git *p,
+				   const unsigned char *sha1)
+{
+	unsigned i;
+	for (i = 0; i < p->num_bad_objects; i++)
+		if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+			return;
+	p->bad_object_sha1 = xrealloc(p->bad_object_sha1, 20 * (p->num_bad_objects + 1));
+	hashcpy(p->bad_object_sha1 + 20 * p->num_bad_objects, sha1);
+	p->num_bad_objects++;
+}
+
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
 	unsigned char real_sha1[20];
@@ -1300,20 +1314,17 @@ static off_t get_delta_base(struct packed_git *p,
 		while (c & 128) {
 			base_offset += 1;
 			if (!base_offset || MSB(base_offset, 7))
-				die("offset value overflow for delta base object");
+				return 0;  /* overflow */
 			c = base_info[used++];
 			base_offset = (base_offset << 7) + (c & 127);
 		}
 		base_offset = delta_obj_offset - base_offset;
 		if (base_offset >= delta_obj_offset)
-			die("delta base offset out of bound");
+			return 0;  /* out of bound */
 		*curpos += used;
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset = find_pack_entry_one(base_info, p);
-		if (!base_offset)
-			die("failed to find delta-pack base object %s",
-				sha1_to_hex(base_info));
 		*curpos += 20;
 	} else
 		die("I am totally screwed");
@@ -1406,6 +1417,9 @@ const char *packed_object_info_detail(struct packed_git *p,
 			return typename(type);
 		case OBJ_OFS_DELTA:
 			obj_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
+			if (!obj_offset)
+				die("pack %s contains bad delta base reference",
+				    p->pack_name, type);
 			if (*delta_chain_length == 0) {
 				revidx = find_pack_revindex(p, obj_offset);
 				hashcpy(base_sha1, nth_packed_object_sha1(p, revidx->nr));
@@ -1600,17 +1614,41 @@ static void *unpack_delta_entry(struct packed_git *p,
 	off_t base_offset;
 
 	base_offset = get_delta_base(p, w_curs, &curpos, *type, obj_offset);
+	if (!base_offset) {
+		error("failed to validate delta base reference "
+		      "at offset %"PRIuMAX" from %s",
+		      (uintmax_t)curpos, p->pack_name);
+		return NULL;
+	}
 	base = cache_or_unpack_entry(p, base_offset, &base_size, type, 0);
-	if (!base)
-		die("failed to read delta base object"
-		    " at %"PRIuMAX" from %s",
-		    (uintmax_t)base_offset, p->pack_name);
+	if (!base) {
+		/*
+		 * We're probably in deep shit, but let's try to fetch
+		 * the required base anyway from another pack or loose.
+		 * This is costly but should happen only in the presence
+		 * of a corrupted pack, and is better than failing outright.
+		 */
+		struct revindex_entry *revidx = find_pack_revindex(p, base_offset);
+		const unsigned char *base_sha1 =
+					nth_packed_object_sha1(p, revidx->nr);
+		error("failed to read delta base object %s"
+		      " at offset %"PRIuMAX" from %s",
+		      sha1_to_hex(base_sha1), (uintmax_t)base_offset,
+		      p->pack_name);
+		mark_bad_packed_object(p, base_sha1);
+		base = read_sha1_file(base_sha1, type, &base_size);
+		if (!base)
+			return NULL;
+	}
 
 	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
-	if (!delta_data)
-		die("failed to unpack compressed delta"
-		    " at %"PRIuMAX" from %s",
-		    (uintmax_t)curpos, p->pack_name);
+	if (!delta_data) {
+		error("failed to unpack compressed delta "
+		      "at offset %"PRIuMAX" from %s",
+		      (uintmax_t)curpos, p->pack_name);
+		free(base);
+		return NULL;
+	}
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
 			     sizep);
@@ -1642,7 +1680,9 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		data = unpack_compressed_entry(p, &w_curs, curpos, *sizep);
 		break;
 	default:
-		die("unknown object type %i in %s", *type, p->pack_name);
+		data = NULL;
+		error("unknown object type %i at offset %"PRIuMAX" in %s",
+		      *type, (uintmax_t)obj_offset, p->pack_name);
 	}
 	unuse_pack(&w_curs);
 	return data;
@@ -1788,6 +1828,13 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 				goto next;
 		}
 
+		if (p->num_bad_objects) {
+			unsigned i;
+			for (i = 0; i < p->num_bad_objects; i++)
+				if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+					goto next;
+		}
+
 		offset = find_pack_entry_one(sha1, p);
 		if (offset) {
 			/*
@@ -1872,11 +1919,24 @@ static void *read_packed_sha1(const unsigned char *sha1,
 			      enum object_type *type, unsigned long *size)
 {
 	struct pack_entry e;
+	void *data;
 
 	if (!find_pack_entry(sha1, &e, NULL))
 		return NULL;
-	else
-		return cache_or_unpack_entry(e.p, e.offset, size, type, 1);
+	data = cache_or_unpack_entry(e.p, e.offset, size, type, 1);
+	if (!data) {
+		/*
+		 * We're probably in deep shit, but let's try to fetch
+		 * the required object anyway from another pack or loose.
+		 * This should happen only in the presence of a corrupted
+		 * pack, and is better than failing outright.
+		 */
+		error("failed to read object %s at offset %"PRIuMAX" from %s",
+		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
+		mark_bad_packed_object(e.p, sha1);
+		data = read_sha1_file(sha1, type, size);
+	}
+	return data;
 }
 
 /*
-- 
1.5.6.GIT
