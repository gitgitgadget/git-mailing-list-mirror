From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 01/16] Modify cache_header to prepare for other index formats
Date: Thu,  2 Aug 2012 13:01:51 +0200
Message-ID: <1343905326-23790-2-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:04:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtCC-0005eb-CN
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab2HBLCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:02:55 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44602 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab2HBLCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:02:54 -0400
Received: by eeil10 with SMTP id l10so2331146eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jJV//y4iTF+f8UsFEnY7z183b+2/kZn4tVw67ok2Aes=;
        b=R1ZNuC+gbRGIgc9AhQsytIll4ejylOgTDqbeH7mvL+uxV6j/Zo7eFcSECVFxPV8xcs
         eikHFAAJ70Ljx97TdXjWcfVnGBgKST45CvvC6OwLS7EIowY7lIXCAAduCtkJ23lcEJul
         klbO76dUfGEHBQiurrbltXYNwE7WjvP4b337fu0Z6vjDiIIfkWvGZiQNGDRU/RvOlLVw
         L5KrZsN0CBp5hHlbbzxBvP7VZVHBXSdhZ+SaCmrZ5JiAhwuKKb/PXNDH4ROnlRMwnXfX
         bz2R93qrZDrdsDL3rbmlpurScBQSnyg5jvx0DPD/K8NRdxFEZ2a8RHS7YWZs/nj12Y3g
         cOfA==
Received: by 10.14.202.5 with SMTP id c5mr11054470eeo.43.1343905373395;
        Thu, 02 Aug 2012 04:02:53 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id w5sm16466561eeo.1.2012.08.02.04.02.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:02:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202764>

Modify the cache_header such that other index file formats
can be added and reusing the common part of each index format.

The signature and version have to be present in every
version of the index file format, to check if it can be read
by a specific version of git, while other entries (eg. number
of entries for index v2/3/4) can be different from one file
format to another. Therefore it is split to its own struct.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h              |  5 ++++-
 read-cache.c         | 20 +++++++++++++-------
 test-index-version.c |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 6e9a243..d4028ef 100644
--- a/cache.h
+++ b/cache.h
@@ -99,9 +99,12 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
  */
 
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
-struct cache_header {
+struct cache_version_header {
 	unsigned int hdr_signature;
 	unsigned int hdr_version;
+};
+
+struct cache_header_v2 {
 	unsigned int hdr_entries;
 };
 
diff --git a/read-cache.c b/read-cache.c
index ab00d02..c44b5f7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1247,7 +1247,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(struct cache_version_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
@@ -1409,7 +1409,8 @@ int read_index_from(struct index_state *istate, const char *path)
 	int fd, i;
 	struct stat st;
 	unsigned long src_offset;
-	struct cache_header *hdr;
+	struct cache_version_header *hdr;
+	struct cache_header_v2 *hdr_v2;
 	void *mmap;
 	size_t mmap_size;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
@@ -1433,7 +1434,7 @@ int read_index_from(struct index_state *istate, const char *path)
 
 	errno = EINVAL;
 	mmap_size = xsize_t(st.st_size);
-	if (mmap_size < sizeof(struct cache_header) + 20)
+	if (mmap_size < sizeof(struct cache_version_header) + 20)
 		die("index file smaller than expected");
 
 	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
@@ -1442,11 +1443,13 @@ int read_index_from(struct index_state *istate, const char *path)
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
@@ -1456,7 +1459,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	else
 		previous_name = NULL;
 
-	src_offset = sizeof(*hdr);
+	src_offset = sizeof(*hdr) + sizeof(*hdr_v2);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
@@ -1757,7 +1760,8 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
-	struct cache_header hdr;
+	struct cache_version_header hdr;
+	struct cache_header_v2 hdr_v2;
 	int i, err, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
@@ -1787,11 +1791,13 @@ int write_index(struct index_state *istate, int newfd)
 
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
index bfaad9e..f21372a 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -2,7 +2,7 @@
 
 int main(int argc, const char **argv)
 {
-	struct cache_header hdr;
+	struct cache_version_header hdr;
 	int version;
 
 	memset(&hdr,0,sizeof(hdr));
-- 
1.7.10.886.gdf6792c.dirty
