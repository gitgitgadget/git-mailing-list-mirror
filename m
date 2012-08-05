From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 01/16] Modify cache_header to prepare for other index formats
Date: Sun,  5 Aug 2012 23:48:58 +0200
Message-ID: <1344203353-2819-2-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8ij-0001n4-N9
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab2HEVuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48892 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab2HEVtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:50 -0400
Received: by eaac11 with SMTP id c11so648690eaa.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EBuIp/4/smLfQ1GcIQrD46KSVnh/S6g9lCi4o6TlcHQ=;
        b=dcpAG9jVH719sLz0NEm7ENojncntLEEF1IkDQbCv1gQ50UwCQ9tQ8XYnkY87ujaoly
         rpJKC6Vqkk0tEFFKNOUymT65RQ23kQXTo7qLKVWt8UHE1c3ClftzHEoe54HPhg7z8quT
         sqfvgcHlUD2vifSGCr99qBaTUePvZ6HL3bevAxbQx+oHEWln5SPk9naUmdB1El10rIgQ
         9oX9BoTC5Pvt8dqGJKXEavWO/yCtbfAU1X9a4J30kZZ3XRY88XCH2Qdlwr4z7/JzOF8v
         yL7BphiS27vQ8QDXygSi6xddX4P8L4Lfm/wDyY61O9YbdTsGYLx6DYe4VAVMvtulUTdd
         jWoA==
Received: by 10.14.202.69 with SMTP id c45mr10485980eeo.4.1344203388597;
        Sun, 05 Aug 2012 14:49:48 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id a48sm2783486eeo.1.2012.08.05.14.49.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202924>

Modify the cache_header such that other index file formats
can be added and reusing the common part of each index format.

The signature and version have to be present in every
version of the index file format, to check if it can be read
by a specific version of git, while other entries (eg. number
of entries for index v2/3/4) can be different from one file
format to another. Therefore it is split to its own struct.

The structs are also moved to read-cache.c, since they are
not used in any other place except test-index-version, where
cache_version_header is redefined.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h              |    8 --------
 read-cache.c         |   32 +++++++++++++++++++++++++-------
 test-index-version.c |    7 ++++++-
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 67f28b4..9bfc9f3 100644
--- a/cache.h
+++ b/cache.h
@@ -94,16 +94,8 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
  */
 #define DEFAULT_GIT_PORT 9418
 
-/*
- * Basic data structures for the directory cache
- */
 
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
-struct cache_header {
-	unsigned int hdr_signature;
-	unsigned int hdr_version;
-	unsigned int hdr_entries;
-};
 
 #define INDEX_FORMAT_LB 2
 #define INDEX_FORMAT_UB 4
diff --git a/read-cache.c b/read-cache.c
index 2f8159f..5d61d92 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1198,6 +1198,18 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 #define INDEX_FORMAT_DEFAULT 3
 
 /*
+ * Basic data structures for the directory cache
+ */
+struct cache_version_header {
+	unsigned int hdr_signature;
+	unsigned int hdr_version;
+};
+
+struct cache_header_v2 {
+	unsigned int hdr_entries;
+};
+
+/*
  * dev/ino/uid/gid/size are also just tracked to the low 32 bits
  * Again - this is just a (very strong in practice) heuristic that
  * the inode hasn't changed.
@@ -1247,7 +1259,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(struct cache_version_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
@@ -1409,7 +1421,8 @@ int read_index_from(struct index_state *istate, const char *path)
 	int fd, i;
 	struct stat st;
 	unsigned long src_offset;
-	struct cache_header *hdr;
+	struct cache_version_header *hdr;
+	struct cache_header_v2 *hdr_v2;
 	void *mmap;
 	size_t mmap_size;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
@@ -1433,7 +1446,7 @@ int read_index_from(struct index_state *istate, const char *path)
 
 	errno = EINVAL;
 	mmap_size = xsize_t(st.st_size);
-	if (mmap_size < sizeof(struct cache_header) + 20)
+	if (mmap_size < sizeof(struct cache_version_header) + 20)
 		die("index file smaller than expected");
 
 	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
@@ -1442,11 +1455,13 @@ int read_index_from(struct index_state *istate, const char *path)
 		die_errno("unable to map index file");
 
 	hdr = mmap;
+	hdr_v2 =  mmap + sizeof(*hdr);
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
+	hdr_v2 = mmap + sizeof(*hdr);
 	istate->version = ntohl(hdr->hdr_version);
-	istate->cache_nr = ntohl(hdr->hdr_entries);
+	istate->cache_nr = ntohl(hdr_v2->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
 	istate->initialized = 1;
@@ -1456,7 +1471,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	else
 		previous_name = NULL;
 
-	src_offset = sizeof(*hdr);
+	src_offset = sizeof(*hdr) + sizeof(*hdr_v2);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
@@ -1757,7 +1772,8 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
-	struct cache_header hdr;
+	struct cache_version_header hdr;
+	struct cache_header_v2 hdr_v2;
 	int i, err, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
@@ -1787,11 +1803,13 @@ int write_index(struct index_state *istate, int newfd)
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(hdr_version);
-	hdr.hdr_entries = htonl(entries - removed);
+	hdr_v2.hdr_entries = htonl(entries - removed);
 
 	git_SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
+	if (ce_write(&c, newfd, &hdr_v2, sizeof(hdr_v2)) < 0)
+		return -1;
 
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 	for (i = 0; i < entries; i++) {
diff --git a/test-index-version.c b/test-index-version.c
index bfaad9e..3899a2f 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -1,8 +1,13 @@
 #include "cache.h"
 
+struct cache_version_header {
+	unsigned int hdr_signature;
+	unsigned int hdr_version;
+};
+
 int main(int argc, const char **argv)
 {
-	struct cache_header hdr;
+	struct cache_version_header hdr;
 	int version;
 
 	memset(&hdr,0,sizeof(hdr));
-- 
1.7.10.GIT
