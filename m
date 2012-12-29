From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sat, 29 Dec 2012 04:48:17 -0500
Message-ID: <20121229094816.GA23396@sigill.intra.peff.net>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
 <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net>
 <20121229090558.GA31291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 11:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TotN5-0001IS-PW
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 11:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab2L2Jsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 04:48:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38708 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab2L2Jsa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 04:48:30 -0500
Received: (qmail 28247 invoked by uid 107); 29 Dec 2012 09:49:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 04:49:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 04:48:17 -0500
Content-Disposition: inline
In-Reply-To: <20121229090558.GA31291@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212301>

On Sat, Dec 29, 2012 at 04:05:58AM -0500, Jeff King wrote:

> On Sat, Dec 29, 2012 at 12:27:47AM -0500, Jeff King wrote:
> 
> > > I think I tried the partial decompression for commit header and it did
> > > not help much (or I misremember it, not so sure).
> > 
> > I'll see if I can dig up the reference, as it was something I was going
> > to look at next.
> 
> I tried the simple patch below, but it actually made things slower!  I'm
> assuming it is because the streaming setup is not micro-optimized very
> well. A custom read_sha1_until_blank_line() could probably do better.

Something like the patch below, which does speed things up. But not
nearly as much as I'd hoped:

  [before]
  $ best-of-five git rev-list --count --all
  real    0m4.197s
  user    0m4.112s
  sys     0m0.072s

  [after]
  $ best-of-five git rev-list --count --all
  real    0m3.782s
  user    0m3.708s
  sys     0m0.064s

Only about a 10% speedup (versus ~75% with uncompressed commits).

---
diff --git a/cache.h b/cache.h
index 18fdd18..a494d3b 100644
--- a/cache.h
+++ b/cache.h
@@ -724,6 +724,7 @@ int offset_1st_component(const char *path);
 
 /* object replacement */
 #define READ_SHA1_FILE_REPLACE 1
+#define READ_SHA1_FILE_HEADER 2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1059,7 +1060,7 @@ extern int is_pack_valid(struct packed_git *);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
+extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *, int);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
diff --git a/commit.c b/commit.c
index e8eb0ae..0a088dc 100644
--- a/commit.c
+++ b/commit.c
@@ -312,12 +312,13 @@ int parse_commit(struct commit *item)
 	void *buffer;
 	unsigned long size;
 	int ret;
+	int flags = save_commit_buffer ? 0 : READ_SHA1_FILE_HEADER;
 
 	if (!item)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, &type, &size);
+	buffer = read_sha1_file_extended(item->object.sha1, &type, &size, flags);
 	if (!buffer)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
diff --git a/fast-import.c b/fast-import.c
index c2a814e..a140d57 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1303,7 +1303,7 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size = pack_size + 20;
 	}
-	return unpack_entry(p, oe->idx.offset, &type, sizep);
+	return unpack_entry(p, oe->idx.offset, &type, sizep, 0);
 }
 
 static const char *get_mode(const char *str, uint16_t *modep)
diff --git a/pack-check.c b/pack-check.c
index 63a595c..e4a43c0 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -116,7 +116,7 @@ static int verify_packfile(struct packed_git *p,
 					    sha1_to_hex(entries[i].sha1),
 					    p->pack_name, (uintmax_t)offset);
 		}
-		data = unpack_entry(p, entries[i].offset, &type, &size);
+		data = unpack_entry(p, entries[i].offset, &type, &size, 0);
 		if (!data)
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    sha1_to_hex(entries[i].sha1), p->pack_name,
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..1f1f31a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1469,16 +1469,19 @@ static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type
 	return *hdr ? -1 : type_from_string(type);
 }
 
-static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
+static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1, int stop_at_blank)
 {
 	int ret;
 	git_zstream stream;
-	char hdr[8192];
+	char hdr[512];
 
 	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
 	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
 		return NULL;
-
+	if (stop_at_blank && strstr(hdr, "\n\n")) {
+		*size = strlen(hdr);
+		return xstrdup(hdr);
+	}
 	return unpack_sha1_rest(&stream, hdr, *size, sha1);
 }
 
@@ -1667,8 +1670,11 @@ static void *unpack_compressed_entry(struct packed_git *p,
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
-				    unsigned long size)
+				    unsigned long *sizep,
+				    int stop_at_blank)
 {
+	static const int chunk_size = 256;
+	unsigned long size = *sizep;
 	int st;
 	git_zstream stream;
 	unsigned char *buffer, *in;
@@ -1676,15 +1682,27 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	buffer = xmallocz(size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size + 1;
+
+	if (stop_at_blank)
+		stream.avail_out = chunk_size;
+	else
+		stream.avail_out = size + 1;
 
 	git_inflate_init(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (!stream.avail_out)
-			break; /* the payload is larger than it should be */
+		if (!stream.avail_out) {
+			if (!stop_at_blank)
+				break; /* the payload is larger than it should be */
+			if (memmem(buffer, chunk_size, "\n\n", 2)) {
+				git_inflate_end(&stream);
+				*sizep = chunk_size;
+				return buffer;
+			}
+			stream.avail_out = size + 1 - chunk_size;
+		}
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
@@ -1731,7 +1749,8 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 }
 
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
-	unsigned long *base_size, enum object_type *type, int keep_cache)
+	unsigned long *base_size, enum object_type *type, int keep_cache,
+	int stop_at_blank)
 {
 	void *ret;
 	unsigned long hash = pack_entry_hash(p, base_offset);
@@ -1739,9 +1758,9 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 
 	ret = ent->data;
 	if (!ret || ent->p != p || ent->base_offset != base_offset)
-		return unpack_entry(p, base_offset, type, base_size);
+		return unpack_entry(p, base_offset, type, base_size, stop_at_blank);
 
-	if (!keep_cache) {
+	if (!stop_at_blank && !keep_cache) {
 		ent->data = NULL;
 		ent->lru.next->prev = ent->lru.prev;
 		ent->lru.prev->next = ent->lru.next;
@@ -1810,7 +1829,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size);
+			 unsigned long *size, int stop_at_blank);
 
 static void *unpack_delta_entry(struct packed_git *p,
 				struct pack_window **w_curs,
@@ -1832,7 +1851,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 		return NULL;
 	}
 	unuse_pack(w_curs);
-	base = cache_or_unpack_entry(p, base_offset, &base_size, type, 0);
+	base = cache_or_unpack_entry(p, base_offset, &base_size, type, 0, 0);
 	if (!base) {
 		/*
 		 * We're probably in deep shit, but let's try to fetch
@@ -1851,12 +1870,12 @@ static void *unpack_delta_entry(struct packed_git *p,
 		      sha1_to_hex(base_sha1), (uintmax_t)base_offset,
 		      p->pack_name);
 		mark_bad_packed_object(p, base_sha1);
-		base = read_object(base_sha1, type, &base_size);
+		base = read_object(base_sha1, type, &base_size, 0);
 		if (!base)
 			return NULL;
 	}
 
-	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
+	delta_data = unpack_compressed_entry(p, w_curs, curpos, &delta_size, 0);
 	if (!delta_data) {
 		error("failed to unpack compressed delta "
 		      "at offset %"PRIuMAX" from %s",
@@ -1895,7 +1914,8 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 int do_check_packed_object_crc;
 
 void *unpack_entry(struct packed_git *p, off_t obj_offset,
-		   enum object_type *type, unsigned long *sizep)
+		   enum object_type *type, unsigned long *sizep,
+		   int stop_at_blank)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
@@ -1929,7 +1949,8 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		data = unpack_compressed_entry(p, &w_curs, curpos, *sizep);
+		data = unpack_compressed_entry(p, &w_curs, curpos, sizep,
+					       stop_at_blank);
 		break;
 	default:
 		data = NULL;
@@ -2208,14 +2229,15 @@ static void *read_packed_sha1(const unsigned char *sha1,
 }
 
 static void *read_packed_sha1(const unsigned char *sha1,
-			      enum object_type *type, unsigned long *size)
+			      enum object_type *type, unsigned long *size,
+			      int stop_at_blank)
 {
 	struct pack_entry e;
 	void *data;
 
 	if (!find_pack_entry(sha1, &e))
 		return NULL;
-	data = cache_or_unpack_entry(e.p, e.offset, size, type, 1);
+	data = cache_or_unpack_entry(e.p, e.offset, size, type, 1, stop_at_blank);
 	if (!data) {
 		/*
 		 * We're probably in deep shit, but let's try to fetch
@@ -2226,7 +2248,7 @@ static void *read_packed_sha1(const unsigned char *sha1,
 		error("failed to read object %s at offset %"PRIuMAX" from %s",
 		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
 		mark_bad_packed_object(e.p, sha1);
-		data = read_object(sha1, type, size);
+		data = read_object(sha1, type, size, stop_at_blank);
 	}
 	return data;
 }
@@ -2255,7 +2277,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size)
+			 unsigned long *size, int stop_at_blank)
 {
 	unsigned long mapsize;
 	void *map, *buf;
@@ -2268,17 +2290,18 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 		return xmemdupz(co->buf, co->size);
 	}
 
-	buf = read_packed_sha1(sha1, type, size);
+	buf = read_packed_sha1(sha1, type, size, stop_at_blank);
 	if (buf)
 		return buf;
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
+		buf = unpack_sha1_file(map, mapsize, type, size, sha1,
+				       stop_at_blank);
 		munmap(map, mapsize);
 		return buf;
 	}
 	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	return read_packed_sha1(sha1, type, size, stop_at_blank);
 }
 
 /*
@@ -2296,9 +2319,10 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	const struct packed_git *p;
 	const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
 		? lookup_replace_object(sha1) : sha1;
+	int stop_at_blank = !!(flag & READ_SHA1_FILE_HEADER);
 
 	errno = 0;
-	data = read_object(repl, type, size);
+	data = read_object(repl, type, size, stop_at_blank);
 	if (data)
 		return data;
 
@@ -2597,7 +2621,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 
 	if (has_loose_object(sha1))
 		return 0;
-	buf = read_packed_sha1(sha1, &type, &len);
+	buf = read_packed_sha1(sha1, &type, &len, 0);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
