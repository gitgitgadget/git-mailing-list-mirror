From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 02/16] Modify read functions to prepare for other index formats
Date: Sun,  5 Aug 2012 23:48:59 +0200
Message-ID: <1344203353-2819-3-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8jm-0002ZR-OO
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab2HEVum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51564 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab2HEVtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:51 -0400
Received: by eaac11 with SMTP id c11so648692eaa.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/ifudxFA2E43STl5sepfD9gAtokn9swupndAleAKIG8=;
        b=NuXHo7/T6YXqjQi93n7Is2nBhfSh3Tu6yALl3VyOVQ5Xyuti56QzV3RoYq3udsNTPP
         gwraSYbrMobaBM88Ww9W1uU58yRn89fl0iPvKXV7M4+IhAWlUokYJJRvp+TtyLLjoW3F
         Ic1qByzYfi3t1frJYLsGJGdgC0m4XR6VAOEPw8btFdi5ViOJtqWFTjprkKnsEJV8lkuW
         zQEkJZAiabrMWBQqU/O68qlueEA1rU+sow6GEKHf8gfbEPu28ClhTCQJvbX1M9FBCCU+
         3mSiEqBGQFq+I7tUJCr+rjboROXQ+A/WPZpssl+AQnmNk5Vpdt9AyZgAukNRNbMxfPYW
         I6Pw==
Received: by 10.14.2.5 with SMTP id 5mr10394268eee.33.1344203389978;
        Sun, 05 Aug 2012 14:49:49 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id 8sm42233279eeg.16.2012.08.05.14.49.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202938>

Modify the read_index_from function, splitting it up into
one function that stays the same for every index format,
doing the basic operations such as verifying the header,
and a function which is specific for each index version,
which does the real reading of the index.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c |  107 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 43 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5d61d92..24b5e02 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1259,10 +1259,8 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr(struct cache_version_header *hdr, unsigned long size)
+static int verify_hdr_version(struct cache_version_header *hdr, unsigned long size)
 {
-	git_SHA_CTX c;
-	unsigned char sha1[20];
 	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
@@ -1270,6 +1268,14 @@ static int verify_hdr(struct cache_version_header *hdr, unsigned long size)
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
@@ -1415,50 +1421,15 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
-/* remember to discard_cache() before reading a different cache! */
-int read_index_from(struct index_state *istate, const char *path)
+static void read_index_v2(struct index_state *istate, void *mmap, int mmap_size)
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
@@ -1484,8 +1455,6 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1505,12 +1474,64 @@ int read_index_from(struct index_state *istate, const char *path)
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
+	istate->timestamp.sec = st.st_mtime;
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+
+	close(fd);
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
 unmap:
 	munmap(mmap, mmap_size);
-	errno = EINVAL;
 	die("index file corrupt");
 }
 
-- 
1.7.10.GIT
