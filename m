From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 04/19] read-cache: Re-read index if index file changed
Date: Fri, 12 Jul 2013 19:26:49 +0200
Message-ID: <1373650024-3001-5-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh8Q-0002yC-RH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268Ab3GLR1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:27:54 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:54005 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:27:54 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so8781933pdj.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+gGWBAkEN92ae3zJloYlmAIMyZ6N7n/xAXh9irNMPak=;
        b=XSwB4WXe9mqVImqkuj/SP5Zx3gHpNOjiX17yNArxASWBHcjp5736H2Tv9tibxS4Hev
         Giu0AwMt62JZdgU1/zcad5qorrZoILqjVLSIi8vdZS3WzlFniwxKfyebUaQ4xcYkkZUR
         /h9/D+ylPbyuHVEDt1s9qOoOWS0J11nCTkJ+2v0fSqElloO1U8ShzZfx2TgX/MzZi+2y
         ZTBVk8mqRYX8vEUKvgnIBxo55IlLzaqbpgrS1Ucxy19X39KaxROgyz56x0kjhfvxfib9
         9ckngq20H6dDgyS/vHpSIhDh3scas70shrmaN2LIMMyaZ4RNQiEXnwMenHug6zkpR1Vv
         Zrgg==
X-Received: by 10.66.122.194 with SMTP id lu2mr43879014pab.125.1373650073262;
        Fri, 12 Jul 2013 10:27:53 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id bg3sm46374737pbb.44.2013.07.12.10.27.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:27:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230214>

Add the possibility of re-reading the index file, if it changed
while reading.

The index file might change during the read, causing outdated
information to be displayed. We check if the index file changed
by using its stat data as heuristic.

Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 91 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1e7ffc2..3e3a0e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1275,11 +1275,31 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
+static int index_changed(struct stat *st_old, struct stat *st_new)
+{
+	if (st_old->st_mtime != st_new->st_mtime ||
+#if !defined (__CYGWIN__)
+	    st_old->st_uid   != st_new->st_uid ||
+	    st_old->st_gid   != st_new->st_gid ||
+	    st_old->st_ino   != st_new->st_ino ||
+#endif
+#if USE_NSEC
+	    ST_MTIME_NSEC(*st_old) != ST_MTIME_NSEC(*st_new) ||
+#endif
+#if USE_STDEV
+	    st_old->st_dev != st_new->st_dev ||
+#endif
+	    st_old->st_size != st_new->st_size)
+		return 1;
+
+	return 0;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
-	int fd;
-	struct stat st;
+	int fd, err, i;
+	struct stat st_old, st_new;
 	struct cache_version_header *hdr;
 	void *mmap;
 	size_t mmap_size;
@@ -1291,41 +1311,44 @@ int read_index_from(struct index_state *istate, const char *path)
 	errno = ENOENT;
 	istate->timestamp.sec = 0;
 	istate->timestamp.nsec = 0;
+	for (i = 0; i < 50; i++) {
+		err = 0;
+		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				return 0;
+			die_errno("index file open failed");
+		}
 
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT)
-			return 0;
-		die_errno("index file open failed");
+		if (fstat(fd, &st_old))
+			die_errno("cannot stat the open index");
+
+		errno = EINVAL;
+		mmap_size = xsize_t(st_old.st_size);
+		mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		close(fd);
+		if (mmap == MAP_FAILED)
+			die_errno("unable to map index file");
+
+		hdr = mmap;
+		if (verify_hdr_version(istate, hdr, mmap_size) < 0)
+			err = 1;
+
+		if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
+			err = 1;
+
+		if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
+			err = 1;
+		istate->timestamp.sec = st_old.st_mtime;
+		istate->timestamp.nsec = ST_MTIME_NSEC(st_old);
+		if (lstat(path, &st_new))
+			die_errno("cannot stat the open index");
+
+		munmap(mmap, mmap_size);
+		if (!index_changed(&st_old, &st_new) && !err)
+			return istate->cache_nr;
 	}
 
-	if (fstat(fd, &st))
-		die_errno("cannot stat the open index");
-
-	errno = EINVAL;
-	mmap_size = xsize_t(st.st_size);
-	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	close(fd);
-	if (mmap == MAP_FAILED)
-		die_errno("unable to map index file");
-
-	hdr = mmap;
-	if (verify_hdr_version(istate, hdr, mmap_size) < 0)
-		goto unmap;
-
-	if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
-		goto unmap;
-
-	if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
-		goto unmap;
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
-
-	munmap(mmap, mmap_size);
-	return istate->cache_nr;
-
-unmap:
-	munmap(mmap, mmap_size);
 	die("index file corrupt");
 }
 
-- 
1.8.3.453.g1dfc63d
