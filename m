From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 03/24] read-cache: split index file version specific functionality
Date: Sun, 18 Aug 2013 21:41:52 +0200
Message-ID: <1376854933-31241-4-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xW-0003br-TB
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab3HRTsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:15 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38452 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:13 -0400
Received: by mail-wi0-f179.google.com with SMTP id hr7so2348225wib.6
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2DuslJp4eZYjmcOsEsZXLuArgjjiIE1itrqQ1TgcUDQ=;
        b=Erq0sZZoyJqDaGNhDnbCQdJ3xHZQqgNy9EjV9iCpatXlRtMnOiox2Ijom4yjjL9HXQ
         SKs8TpU5mdf6e0wE7F7nCGCs7F0nNcRHS8b4OLtZ32fcA4UORBecJwkzepnMJ2SqARNL
         k2A6RWIVJNevasilIUI3um/UflOiZhQhlkDim8G6AAnM4mp0k/Q3QYktqDpc1ZL7rS2n
         KvmsHmnf3k+YRyvZvmxthz0Ud03RcLsq0MOUT/NfNdLoddQ0fNyc7/YxYbTATW0LazZh
         Szne5a+mNG+U/MstOUXFlgIpftPbgAodVm5VcLP1Jqilv+YIVXkROOOc9xLdvmdK/+UZ
         b+mQ==
X-Received: by 10.180.160.203 with SMTP id xm11mr3239791wib.17.1376855291837;
        Sun, 18 Aug 2013 12:48:11 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id fu13sm11771675wic.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232491>

Split index file version specific functionality to their own functions,
to prepare for moving the index file version specific parts to their own
file.  This makes it easier to add a new index file format later.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 114 ++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 40 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0df5b31..de0bbcd 100644
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
@@ -1855,6 +1884,11 @@ int write_index(struct index_state *istate, int newfd)
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
1.8.3.4.1231.g9fbf354.dirty
