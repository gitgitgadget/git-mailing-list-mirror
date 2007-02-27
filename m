From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Use OBJ_NONE to mean we don't have an object.
Date: Tue, 27 Feb 2007 10:00:46 -0500
Message-ID: <20070227150046.GB3242@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9BB-0000mq-KT
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933484AbXB0Und (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933108AbXB0Und
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:43:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45634 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933484AbXB0Unc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:43:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HM3oo-0005PX-PY; Tue, 27 Feb 2007 10:00:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5CD1C20FBAE; Tue, 27 Feb 2007 10:00:46 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40797>

Rather than returning -1 (which is not a valid object_type value)
from sha1_object_info we now return OBJ_NONE.  Practically speaking
there is no logic change in this patch, its just a cleanup to ensure
the return value is always within object_type.

The type OBJ_NONE is already used in a few locations to mean "don't
got that object", as OBJ_NONE = 0 and standard initializations like
xcalloc will automatically prefill OBJ_NONE.  This change is just
continuing with that existing tradition.

I'm planning on taking advantage of this cleanup later on in the
pack version 4 changes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-cat-file.c     |    2 +-
 builtin-commit-tree.c  |    2 +-
 builtin-pack-objects.c |    4 ++--
 cache.h                |    2 +-
 diff.c                 |    2 +-
 fast-import.c          |    2 +-
 mktree.c               |    2 +-
 sha1_file.c            |   42 ++++++++++++++++++++++++++----------------
 8 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index d61d3d5..cb0d288 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -120,7 +120,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	case 'p':
 		type = sha1_object_info(sha1, NULL);
-		if (type < 0)
+		if (type == OBJ_NONE)
 			die("Not a valid object name %s", argv[2]);
 
 		/* custom pretty-print here */
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 4a8d8d8..ed47804 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -48,7 +48,7 @@ static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
 static void check_valid(unsigned char *sha1, enum object_type expect)
 {
 	enum object_type type = sha1_object_info(sha1, NULL);
-	if (type < 0)
+	if (type == OBJ_NONE)
 		die("%s is not a valid object", sha1_to_hex(sha1));
 	if (type != expect)
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8cf24f4..273255e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -859,7 +859,7 @@ static void add_pbase_object(struct tree_desc *tree,
 		if (entry.pathlen != cmplen ||
 		    memcmp(entry.path, name, cmplen) ||
 		    !has_sha1_file(entry.sha1) ||
-		    (type = sha1_object_info(entry.sha1, &size)) < 0)
+		    (type = sha1_object_info(entry.sha1, &size)) == OBJ_NONE)
 			continue;
 		if (name[cmplen] != '/') {
 			unsigned hash = name_hash(fullname);
@@ -1061,7 +1061,7 @@ static void check_object(struct object_entry *entry)
 	}
 
 	entry->type = sha1_object_info(entry->sha1, &entry->size);
-	if (entry->type < 0)
+	if (entry->type == OBJ_NONE)
 		die("unable to get type of object %s",
 		    sha1_to_hex(entry->sha1));
 }
diff --git a/cache.h b/cache.h
index 0117b7e..6223ed1 100644
--- a/cache.h
+++ b/cache.h
@@ -275,7 +275,7 @@ enum object_type {
 };
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern int sha1_object_info(const unsigned char *, unsigned long *);
+extern enum object_type sha1_object_info(const unsigned char *, unsigned long *);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
 extern int hash_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1);
diff --git a/diff.c b/diff.c
index f033eb0..5479602 100644
--- a/diff.c
+++ b/diff.c
@@ -1440,7 +1440,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 				return 0;
 			}
 			type = sha1_object_info(s->sha1, &s->size);
-			if (type < 0)
+			if (type == OBJ_NONE)
 				locate_size_cache(s->sha1, 0, s->size);
 		}
 		else {
diff --git a/fast-import.c b/fast-import.c
index 65e99c2..aa4be8a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1628,7 +1628,7 @@ static void file_change_m(struct branch *b)
 				command_buf.buf, typename(oe->type));
 	} else {
 		enum object_type type = sha1_object_info(sha1, NULL);
-		if (type < 0)
+		if (type == OBJ_NONE)
 			die("Blob not found: %s", command_buf.buf);
 		if (type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
diff --git a/mktree.c b/mktree.c
index d86dde8..742b445 100644
--- a/mktree.c
+++ b/mktree.c
@@ -116,7 +116,7 @@ int main(int ac, char **av)
 		    get_sha1_hex(ntr + 1, sha1))
 			die("input format error: %s", sb.buf);
 		type = sha1_object_info(sha1, NULL);
-		if (type < 0)
+		if (type == OBJ_NONE)
 			die("object %s unavailable", sha1_to_hex(sha1));
 		*ntr++ = 0; /* now at the beginning of SHA1 */
 		if (type != type_from_string(ptr))
diff --git a/sha1_file.c b/sha1_file.c
index 136e79b..4399a9c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1085,10 +1085,11 @@ static unsigned long get_delta_base(struct packed_git *p,
 }
 
 /* forward declaration for a mutually recursive function */
-static int packed_object_info(struct packed_git *p, unsigned long offset,
-			      unsigned long *sizep);
+static enum object_type packed_object_info(struct packed_git *p,
+	unsigned long offset,
+	unsigned long *sizep);
 
-static int packed_delta_info(struct packed_git *p,
+static enum object_type packed_delta_info(struct packed_git *p,
 			     struct pack_window **w_curs,
 			     unsigned long curpos,
 			     enum object_type type,
@@ -1215,8 +1216,9 @@ const char *packed_object_info_detail(struct packed_git *p,
 	}
 }
 
-static int packed_object_info(struct packed_git *p, unsigned long obj_offset,
-			      unsigned long *sizep)
+static enum object_type packed_object_info(struct packed_git *p,
+	unsigned long obj_offset,
+	unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size, curpos = obj_offset;
@@ -1438,30 +1440,38 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 	
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *sizep)
+static enum object_type sha1_loose_object_info(
+	const unsigned char *sha1,
+	unsigned long *sizep)
 {
-	int status;
+	enum object_type type;
 	unsigned long mapsize, size;
 	void *map;
 	z_stream stream;
 	char hdr[32];
 
 	map = map_sha1_file(sha1, &mapsize);
-	if (!map)
-		return error("unable to find %s", sha1_to_hex(sha1));
-	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
-		status = error("unable to unpack %s header",
-			       sha1_to_hex(sha1));
-	else if ((status = parse_sha1_header(hdr, &size)) < 0)
-		status = error("unable to parse %s header", sha1_to_hex(sha1));
+	if (!map) {
+		error("unable to find %s", sha1_to_hex(sha1));
+		return OBJ_NONE;
+	}
+	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+		error("unable to unpack %s header", sha1_to_hex(sha1));
+		type = OBJ_NONE;
+	}
+	else if ((type = parse_sha1_header(hdr, &size)) < 0) {
+		error("unable to parse %s header", sha1_to_hex(sha1));
+		type = OBJ_NONE;
+	}
 	else if (sizep)
 		*sizep = size;
 	inflateEnd(&stream);
 	munmap(map, mapsize);
-	return status;
+	return type;
 }
 
-int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+enum object_type sha1_object_info(const unsigned char *sha1,
+	unsigned long *sizep)
 {
 	struct pack_entry e;
 
-- 
1.5.0.2.775.g1a500
