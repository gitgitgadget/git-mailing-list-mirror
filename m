From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/3] git-pack-objects: cache small deltas between big objects
Date: Mon, 28 May 2007 23:20:58 +0200
Message-ID: <11803872591103-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 23:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsmeR-00048V-Nd
	for gcvg-git@gmane.org; Mon, 28 May 2007 23:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbXE1VVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbXE1VVH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 17:21:07 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59443 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbXE1VVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 17:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id A340D7C16AB2;
	Mon, 28 May 2007 23:21:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93RyktbRotmR; Mon, 28 May 2007 23:21:00 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 04AA77C16AAE; Mon, 28 May 2007 23:21:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48645>

Creating deltas between big blobs is a CPU and memory intensive task.
In the writing phase, all (not reused) deltas are redone.

This patch adds support for caching deltas from the deltifing phase, so
that that the writing phase is faster.

The caching is limited to small deltas to avoid increasing memory usage very much.
The implemented limit is (memory needed to create the delta)/1024.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
The patch is an improved version of the last patch. I added a limit
for the cache size. It's only configureable by git-config, as 
builtin-back-objects (git-repack) has already enough options.

The patch applies on top of next.

 Documentation/config.txt |    5 +++
 builtin-pack-objects.c   |   69 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d8f03d..83cc4cd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,11 @@ pack.compression::
 	slowest.  If not set,  defaults to core.compression.  If that is
 	not set,  defaults to -1.
 
+pack.deltaCacheSize::
+	The maxium memory in bytes used for caching deltas in 
+	gitlink:git-pack-objects[1]. 	
+	A value of 0 means no limit. Defaults to 0.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 17627b3..85e08dc 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -36,6 +36,7 @@ struct object_entry {
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
 					     */
+	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
@@ -76,6 +77,9 @@ static struct progress progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
 
+static unsigned long delta_cache_size = 0;
+static unsigned long max_delta_cache_size = 0;
+
 /*
  * The object names in objects array are hashed with this hashtable,
  * to help looking up the entry by object name.
@@ -405,24 +409,31 @@ static unsigned long write_object(struct sha1file *f,
 		z_stream stream;
 		unsigned long maxsize;
 		void *out;
-		buf = read_sha1_file(entry->sha1, &type, &size);
-		if (!buf)
-			die("unable to read %s", sha1_to_hex(entry->sha1));
-		if (size != entry->size)
-			die("object %s size inconsistency (%lu vs %lu)",
-			    sha1_to_hex(entry->sha1), size, entry->size);
-		if (usable_delta) {
-			buf = delta_against(buf, size, entry);
+		if (entry->delta_data && usable_delta) {
+			buf = entry->delta_data;
 			size = entry->delta_size;
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		} else {
-			/*
-			 * recover real object type in case
-			 * check_object() wanted to re-use a delta,
-			 * but we couldn't since base was in previous split pack
-			 */
-			obj_type = type;
+			buf = read_sha1_file(entry->sha1, &type, &size);
+			if (!buf)
+				die("unable to read %s", sha1_to_hex(entry->sha1));
+			if (size != entry->size)
+				die("object %s size inconsistency (%lu vs %lu)",
+				    sha1_to_hex(entry->sha1), size, entry->size);
+			if (usable_delta) {
+				buf = delta_against(buf, size, entry);
+				size = entry->delta_size;
+				obj_type = (allow_ofs_delta && entry->delta->offset) ?
+					OBJ_OFS_DELTA : OBJ_REF_DELTA;
+			} else {
+				/*
+				 * recover real object type in case
+				 * check_object() wanted to re-use a delta,
+				 * but we couldn't since base was in previous split pack
+				 */
+				obj_type = type;
+			}
 		}
 		/* compress the data to store and put compressed length in datalen */
 		memset(&stream, 0, sizeof(stream));
@@ -1385,6 +1396,20 @@ struct unpacked {
 	struct delta_index *index;
 };
 
+static int delta_cacheable (struct unpacked *trg, struct unpacked *src,
+			    unsigned long src_size, unsigned long trg_size,
+			    unsigned long delta_size)
+{
+	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
+		return 0;
+
+	/* cache delta, if objects are large enough compared to delta size */
+	if ((src_size >> 20) + (trg_size >> 21) > (delta_size >> 10))
+		return 1;
+
+	return 0;
+}
+
 /*
  * We search for deltas _backwards_ in a list sorted by type and
  * by size, so that we see progressively smaller and smaller files.
@@ -1466,10 +1491,20 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (!delta_buf)
 		return 0;
 
+	if (trg_entry->delta_data) {
+		delta_cache_size -= trg_entry->delta_size;
+		free (trg_entry->delta_data);
+	}
+	trg_entry->delta_data = 0;
 	trg_entry->delta = src_entry;
 	trg_entry->delta_size = delta_size;
 	trg_entry->depth = src_entry->depth + 1;
-	free(delta_buf);
+
+	if (delta_cacheable (src, trg, src_size, trg_size, delta_size)) {
+		trg_entry->delta_data = realloc(delta_buf, delta_size);
+		delta_cache_size += trg_entry->delta_size;
+	} else
+		free(delta_buf);
 	return 1;
 }
 
@@ -1615,6 +1650,10 @@ static int git_pack_config(const char *k, const char *v)
 		pack_compression_seen = 1;
 		return 0;
 	}
+	if(!strcmp(k, "pack.deltacachesize")) {
+		max_delta_cache_size = git_config_int(k, v);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
 
-- 
1.5.2.846.g9a144
