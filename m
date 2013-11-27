From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 02/24] read-cache: split index file version specific functionality
Date: Wed, 27 Nov 2013 13:00:37 +0100
Message-ID: <1385553659-9928-3-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldoH-0001gy-Sa
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab3K0MBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:33 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:37280 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab3K0MBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:30 -0500
Received: by mail-la0-f41.google.com with SMTP id eo20so5314841lab.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dOKH5VIyzvA3MVXWXpUPpYW7/vSRt0+hUYfq+MyqBeY=;
        b=zyLwg5qNQqRPSNCASszJNnERRy37tkYDl0Eq41QncNncKOi8Sh558Pkbl+Eu7b5Vtn
         Sn5CpFyw53h4ITppxpdBDfNC3VKhGuLoNaNqu8FoRVkYMMblbordPEJd/TvMpu7UaQF4
         5cEL7LOOpSP6mjwHouzbg4BG3czQgHsCVQHW0CFpVLc8g+BDrCMSHj6YhJ2+TcRJt2Ut
         /X5inp32rycVElkVO+QBrVkdOZYi4BArlPqN9z74lhu3f3sIWaTh5puq0U6mB84CDXVa
         7dBRe/46i/QzhES49/mML6HOMAHXBGZC2PsyX+U4hFvsEqK/zXxon9Z+4Owb7FvgW4iL
         WGFQ==
X-Received: by 10.112.154.129 with SMTP id vo1mr1292015lbb.31.1385553689211;
        Wed, 27 Nov 2013 04:01:29 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id m5sm54843666laj.4.2013.11.27.04.01.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:27 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238416>

Split index file version specific functionality to their own functions,
to prepare for moving the index file version specific parts to their own
file.  This makes it easier to add a new index file format later.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 114 ++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 40 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 33dd676..5a8f405 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1269,10 +1269,8 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr_version(struct cache_header *hdr, unsigned long size)
 {
-	git_SHA_CTX c;
-	unsigned char sha1[20];
 	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
@@ -1280,10 +1278,21 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
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
+	if (size < sizeof(struct cache_header) + 20)
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
@@ -1425,44 +1434,14 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
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
 	struct cache_header *hdr;
-	void *mmap;
-	size_t mmap_size;
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
 
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
@@ -1488,8 +1467,6 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1509,6 +1486,58 @@ int read_index_from(struct index_state *istate, const char *path)
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
+	struct cache_header *hdr;
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
 
@@ -1772,7 +1801,7 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
-int write_index(struct index_state *istate, int newfd)
+static int write_index_v2(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
@@ -1864,6 +1893,11 @@ int write_index(struct index_state *istate, int newfd)
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
-- 
1.8.4.2
