From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 02/19] read-cache: split index file version specific functionality
Date: Fri, 12 Jul 2013 19:26:47 +0200
Message-ID: <1373650024-3001-3-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh87-0002ko-5x
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933258Ab3GLR1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:27:35 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:54655 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:27:34 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so9238819pac.12
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GgbEcCAgnjhcnQAtqS5+wT0MdlM7p47I9NYTXt0zqQM=;
        b=p9mfqQZMRoNK4wS+yb0j2/66+fF9Rvzs+bFYuuSR940rIMf+6h2n0zlFhKl7EHz6Jf
         4EVbh00Khx0junGx4IKE0QoYTAHpIT5/HosWg3bCg8MkB25ShHesqagXhfTwEzFzk4tS
         7KXKh94f6lE2CItGwlCKRZ7qQEopZ23J8oj2Y5hJic+2nc3TVpcbqrRZViuG2loLI37c
         pV4X665VVHuQPzjNBQNhOlGC6Ri2jPXENCZvZyv12ozwW4ywNYvrwdXdGUnDJOP0JStv
         wmf+Nwi5BClsAY0ikHNh23nkZHJ8lMyhp5ECWrEI0c9mmqn7ajgOFs46dArbMK+qHI30
         5LYw==
X-Received: by 10.66.182.166 with SMTP id ef6mr43484155pac.35.1373650053879;
        Fri, 12 Jul 2013 10:27:33 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id b4sm46370811pba.45.2013.07.12.10.27.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:27:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230212>

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
