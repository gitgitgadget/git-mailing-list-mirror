From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 02/16] Modify read functions to prepare for other index formats
Date: Thu,  2 Aug 2012 13:01:52 +0200
Message-ID: <1343905326-23790-3-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBE-00050c-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab2HBLC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:02:56 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40752 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:02:55 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so2331137eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=j19SrDu/YPj/eqpgAePM7pMsPg5cVJNeH//5TYlsHlo=;
        b=wFBn+pUyoG4HqMEQknX+/eUa+fP7tNhgbEdjKGY+zemzR5ZJxRWAhVcjBxrFisET2N
         lWIRotUbg/xRlBfyB2zOg/sn4lWZEpU/mSMcqGAXUiWSzvQ8hHuBSJ51H+si8yvE9vau
         iNC1zPG3UvZNP2AdXo0yh+gZ69/XW13dyWgesQaQEJKvlWdYluXA7VDVKpEVDrZj+Lkd
         FiKwZuXwzBl6O5YPJ3VITWn+j7Vq6ervUuwvMhSWp+MhH14wom67tJ+w7fxhfYjMCFCC
         pfslvjsSpaeaKmz5OGgYrWfsYH7fPD2FubfndGCLSLkoHHr13rVTfTJqzFMqLM4EYy4U
         XOsw==
Received: by 10.14.181.137 with SMTP id l9mr26199754eem.28.1343905374722;
        Thu, 02 Aug 2012 04:02:54 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id w3sm16460948eep.2.2012.08.02.04.02.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:02:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202751>

Modify the read_index_from function, splitting it up into
one function that stays the same for every index format,
doing the basic operations such as verifying the header,
and a function which is specific for each index version,
which does the real reading of the index.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |   1 +
 read-cache.c | 108 +++++++++++++++++++++++++++++++++++------------------------
 2 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/cache.h b/cache.h
index d4028ef..3aa70d8 100644
--- a/cache.h
+++ b/cache.h
@@ -435,6 +435,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const char **pathspec);
+extern void read_index_v2(struct index_state *, void *mmap, int);
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
diff --git a/read-cache.c b/read-cache.c
index c44b5f7..3d83f05 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1247,10 +1247,8 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr(struct cache_version_header *hdr, unsigned long size)
+static int verify_hdr_version(struct cache_version_header *hdr, unsigned long size)
 {
-	git_SHA_CTX c;
-	unsigned char sha1[20];
 	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
@@ -1258,6 +1256,14 @@ static int verify_hdr(struct cache_version_header *hdr, unsigned long size)
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < 2 || 4 < hdr_version)
 		return error("bad index version %d", hdr_version);
+	return 0;
+}
+
+static int verify_hdr_v2(struct cache_version_header *hdr, unsigned long size)
+{
+	git_SHA_CTX c;
+	unsigned char sha1[20];
+
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
@@ -1403,50 +1409,15 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
-/* remember to discard_cache() before reading a different cache! */
-int read_index_from(struct index_state *istate, const char *path)
+void read_index_v2(struct index_state *istate, void *mmap, int mmap_size)
 {
-	int fd, i;
-	struct stat st;
+	int i;
 	unsigned long src_offset;
 	struct cache_version_header *hdr;
 	struct cache_header_v2 *hdr_v2;
-	void *mmap;
-	size_t mmap_size;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
-	errno = EBUSY;
-	if (istate->initialized)
-		return istate->cache_nr;
-
-	errno = ENOENT;
-	istate->timestamp.sec = 0;
-	istate->timestamp.nsec = 0;
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT)
-			return 0;
-		die_errno("index file open failed");
-	}
-
-	if (fstat(fd, &st))
-		die_errno("cannot stat the open index");
-
-	errno = EINVAL;
-	mmap_size = xsize_t(st.st_size);
-	if (mmap_size < sizeof(struct cache_version_header) + 20)
-		die("index file smaller than expected");
-
-	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	close(fd);
-	if (mmap == MAP_FAILED)
-		die_errno("unable to map index file");
-
 	hdr = mmap;
-	hdr_v2 =  mmap + sizeof(*hdr);
-	if (verify_hdr(hdr, mmap_size) < 0)
-		goto unmap;
-
 	hdr_v2 = mmap + sizeof(*hdr);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr_v2->hdr_entries);
@@ -1472,8 +1443,6 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1493,12 +1462,65 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += 8;
 		src_offset += extsize;
 	}
+	return;
+unmap:
+	munmap(mmap, mmap_size);
+	die("index file corrupt");
+}
+
+/* remember to discard_cache() before reading a different cache! */
+int read_index_from(struct index_state *istate, const char *path)
+{
+	int fd;
+	struct stat st;
+	struct cache_version_header *hdr;
+	void *mmap;
+	size_t mmap_size;
+
+	errno = EBUSY;
+	if (istate->initialized)
+		return istate->cache_nr;
+
+	errno = ENOENT;
+	istate->timestamp.sec = 0;
+	istate->timestamp.nsec = 0;
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			return 0;
+		die_errno("index file open failed");
+	}
+
+	if (fstat(fd, &st))
+		die_errno("cannot stat the open index");
+
+	errno = EINVAL;
+	mmap_size = xsize_t(st.st_size);
+	if (mmap_size < sizeof(struct cache_version_header) + 20)
+		die("index file smaller than expected");
+
+	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (mmap == MAP_FAILED)
+		die_errno("unable to map index file");
+
+	hdr = mmap;
+	if (verify_hdr_version(hdr, mmap_size) < 0)
+		goto unmap;
+
+	if (verify_hdr_v2(hdr, mmap_size) < 0)
+		goto unmap;
+
+	read_index_v2(istate, mmap, mmap_size);
+
+	istate->timestamp.sec = st.st_mtime;
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
 unmap:
 	munmap(mmap, mmap_size);
-	errno = EINVAL;
 	die("index file corrupt");
 }
 
-- 
1.7.10.886.gdf6792c.dirty
