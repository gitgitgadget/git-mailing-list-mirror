From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 02/13] read-cache.c: Re-read index if index file changed
Date: Thu, 16 Aug 2012 11:58:38 +0200
Message-ID: <1345111129-6925-3-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrs-0000D2-76
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab2HPJ7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:14 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48153 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756131Ab2HPJ7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:12 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id C72744EF62; Thu, 16 Aug 2012 11:59:08 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the possibility of re-reading the index file, if it changed
while reading.

The index file might change during the read, causing outdated
information to be displayed. We check if the index file changed
by using its stat data as heuristic.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 87 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 27 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 6a8b4b1..cdd8480 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1170,11 +1170,34 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
+static int index_changed(struct stat st_old, struct stat st_new)
+{
+	int changed = 0;
+
+	if (st_old.st_mtime != st_new.st_mtime ||
+	    st_old.st_uid   != st_new.st_uid ||
+	    st_old.st_gid   != st_new.st_gid ||
+	    st_old.st_ino   != st_new.st_ino ||
+	    st_old.st_size  != st_new.st_size)
+		changed = 1;
+#ifdef USE_NSEC
+	if (ST_MTIME_NSEC(st_old) != ST_MTIME_NSEC(st_new))
+		changed = 1;
+#endif
+
+#ifdef USE_STDEV
+	if (st_old.st_dev != st_new.st_dev)
+		changed = 1;
+#endif
+
+	return changed;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
-	int fd;
-	struct stat st;
+	int fd, err, i = 0;
+	struct stat st_old, st_new;
 	struct cache_version_header *hdr;
 	void *mmap;
 	size_t mmap_size;
@@ -1186,38 +1209,48 @@ int read_index_from(struct index_state *istate, const char *path)
 	errno = ENOENT;
 	istate->timestamp.sec = 0;
 	istate->timestamp.nsec = 0;
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT)
-			return 0;
-		die_errno("index file open failed");
-	}
+	do {
+		err = 0;
+		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				return 0;
+			die_errno("index file open failed");
+		}
 
-	if (fstat(fd, &st))
-		die_errno("cannot stat the open index");
+		if (fstat(fd, &st_old))
+			die_errno("cannot stat the open index");
 
-	errno = EINVAL;
-	mmap_size = xsize_t(st.st_size);
-	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	close(fd);
-	if (mmap == MAP_FAILED)
-		die_errno("unable to map index file");
+		errno = EINVAL;
+		mmap_size = xsize_t(st_old.st_size);
+		mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		close(fd);
+		if (mmap == MAP_FAILED)
+			die_errno("unable to map index file");
 
-	hdr = mmap;
-	if (verify_hdr_version(istate, hdr, mmap_size) < 0)
-		goto unmap;
+		hdr = mmap;
+		if (verify_hdr_version(istate, hdr, mmap_size) < 0)
+			err = 1;
 
-	if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
-		goto unmap;
+		if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
+			err = 1;
 
-	istate->ops->read_index(istate, mmap, mmap_size);
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+		if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
+			err = 1;
+		istate->timestamp.sec = st_old.st_mtime;
+		istate->timestamp.nsec = ST_MTIME_NSEC(st_old);
+		if (lstat(path, &st_new))
+			die_errno("cannot stat the open index");
 
-	munmap(mmap, mmap_size);
-	return istate->cache_nr;
+		munmap(mmap, mmap_size);
+
+		if (!index_changed(st_old, st_new) && !err)
+			return istate->cache_nr;
+
+		usleep(10*1000);
+		i++;
+	} while ((err || index_changed(st_old, st_new)) && i < 50);
 
-unmap:
 	munmap(mmap, mmap_size);
 	die("index file corrupt");
 }
-- 
1.7.11.2
