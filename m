From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 02/22] read-cache: split index file version specific functionality
Date: Sun,  7 Jul 2013 10:11:40 +0200
Message-ID: <1373184720-29767-3-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5W-0005m8-4d
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab3GGIMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:12:51 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:38666 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab3GGIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:30 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so2136508eek.21
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GgbEcCAgnjhcnQAtqS5+wT0MdlM7p47I9NYTXt0zqQM=;
        b=kwNaP69CxkOuA28PylFONUHmkazB4JCSy52eiyux+v6faKmLXlNtcB0hJLNIjCQJAY
         BVNYme27+EtenZySI/pkjKIBBkZosctSd+ZKNZs7inQ3bRfj5EJezX/km0Ewb9NSBB4b
         lFyjQKpOTwuo9p4x7Ek20jumrY9L03NoZmnIffaL+WxsKgA7QqYk28Lyulnl7OsRkg86
         OrHW7FOgQlZpOt/qXF1WqIE9vGA31ER6OykiGuFBoWBbyFhClJ3CdQqrzoGuq1nTnBpE
         wf+oH90rr6x60YydeZ3nCxRbEW0M/GjtxzQ5qnAd5mUVqqVhF9c25k/8lUKXBCr5cyqv
         a20g==
X-Received: by 10.14.173.130 with SMTP id v2mr19753159eel.29.1373184749021;
        Sun, 07 Jul 2013 01:12:29 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id b3sm30703119eev.10.2013.07.07.01.12.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229734>

Split index file version specific functionality to their own functions,
to prepare for moving the index file version specific parts to their own
file.  This makes it easier to add a new index file format later.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h              |   5 +-
 read-cache.c         | 130 +++++++++++++++++++++++++++++++++------------------
 test-index-version.c |   2 +-
 3 files changed, 90 insertions(+), 47 deletions(-)

diff --git a/cache.h b/cache.h
index c288678..7af853b 100644
--- a/cache.h
+++ b/cache.h
@@ -100,9 +100,12 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
  */
 
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
-struct cache_header {
+struct cache_version_header {
 	unsigned int hdr_signature;
 	unsigned int hdr_version;
+};
+
+struct cache_header {
 	unsigned int hdr_entries;
 };
 
diff --git a/read-cache.c b/read-cache.c
index d5201f9..93947bf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1268,10 +1268,8 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr_version(struct cache_version_header *hdr, unsigned long size)
 {
-	git_SHA_CTX c;
-	unsigned char sha1[20];
 	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
@@ -1279,10 +1277,22 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+	return 0;
+}
+
+static int verify_hdr(void *mmap, unsigned long size)
+{
+	git_SHA_CTX c;
+	unsigned char sha1[20];
+
+	if (size < sizeof(struct cache_version_header)
+	    + sizeof(struct cache_header) + 20)
+		die("index file smaller than expected");
+
 	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, size - 20);
+	git_SHA1_Update(&c, mmap, size - 20);
 	git_SHA1_Final(sha1, &c);
-	if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
+	if (hashcmp(sha1, (unsigned char *)mmap + size - 20))
 		return error("bad index file sha1 signature");
 	return 0;
 }
@@ -1424,47 +1434,19 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
-/* remember to discard_cache() before reading a different cache! */
-int read_index_from(struct index_state *istate, const char *path)
+static int read_index_v2(struct index_state *istate, void *mmap, unsigned long mmap_size)
 {
-	int fd, i;
-	struct stat st;
+	int i;
 	unsigned long src_offset;
-	struct cache_header *hdr;
-	void *mmap;
-	size_t mmap_size;
+	struct cache_version_header *hdr;
+	struct cache_header *hdr_v2;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
-	if (istate->initialized)
-		return istate->cache_nr;
-
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
-	mmap_size = xsize_t(st.st_size);
-	if (mmap_size < sizeof(struct cache_header) + 20)
-		die("index file smaller than expected");
-
-	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (mmap == MAP_FAILED)
-		die_errno("unable to map index file");
-	close(fd);
-
 	hdr = mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
-		goto unmap;
+	hdr_v2 = (struct cache_header *)((char *)mmap + sizeof(*hdr));
 
 	istate->version = ntohl(hdr->hdr_version);
-	istate->cache_nr = ntohl(hdr->hdr_entries);
+	istate->cache_nr = ntohl(hdr_v2->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized = 1;
@@ -1474,7 +1456,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	else
 		previous_name = NULL;
 
-	src_offset = sizeof(*hdr);
+	src_offset = sizeof(*hdr) + sizeof(*hdr_v2);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
@@ -1487,8 +1469,6 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1508,6 +1488,58 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += 8;
 		src_offset += extsize;
 	}
+	return 0;
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
+	if (mmap_size < sizeof(struct cache_header) + 20)
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
+	if (verify_hdr(mmap, mmap_size) < 0)
+		goto unmap;
+
+	read_index_v2(istate, mmap, mmap_size);
+	istate->timestamp.sec = st.st_mtime;
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
@@ -1771,10 +1803,11 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
-int write_index(struct index_state *istate, int newfd)
+static int write_index_v2(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
-	struct cache_header hdr;
+	struct cache_version_header hdr;
+	struct cache_header hdr_v2;
 	int i, err, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
@@ -1804,11 +1837,13 @@ int write_index(struct index_state *istate, int newfd)
 
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
@@ -1854,6 +1889,11 @@ int write_index(struct index_state *istate, int newfd)
 	return 0;
 }
 
+int write_index(struct index_state *istate, int newfd)
+{
+	return write_index_v2(istate, newfd);
+}
+
 /*
  * Read the index file that is potentially unmerged into given
  * index_state, dropping any unmerged entries.  Returns true if
diff --git a/test-index-version.c b/test-index-version.c
index 05d4699..4c0386f 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -2,7 +2,7 @@
 
 int main(int argc, char **argv)
 {
-	struct cache_header hdr;
+	struct cache_version_header hdr;
 	int version;
 
 	memset(&hdr,0,sizeof(hdr));
-- 
1.8.3.453.g1dfc63d
