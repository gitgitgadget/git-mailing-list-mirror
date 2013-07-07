From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 04/22] read-cache: Re-read index if index file changed
Date: Sun,  7 Jul 2013 10:11:42 +0200
Message-ID: <1373184720-29767-5-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5e-0005xI-BP
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab3GGIMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:12:55 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:39078 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab3GGIMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:37 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so2187341eek.0
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+gGWBAkEN92ae3zJloYlmAIMyZ6N7n/xAXh9irNMPak=;
        b=Ys2TK2EsF6cHWsQLyBGOwT2D6xH/fD9GWEGUEVwywKVlQGCcxOHGS2P0hDx1UPKXxH
         hwZL6Gw8tJQQZ51290WMab9gRk6UktUkQQGc2jZpunPjm5rSGS3jiZC6JlCr/ldncvEL
         BcDN4ReOeSMtFjIPVuglWOrcZMjGSS4/ofwLCOGS7xSKt2IDWu2MMueZyJkybAZT7yNk
         yeQCX2QetoNxOJnreE/JsQflPM52ztj8q33mx0S7jpaF7ZJepfwC3S10NZ5Nh7BnUMoO
         KR30SC0mNwKYV/vd0UVGBr4be8xCAlDAFCFyPUqb3S/5GkzUOulvY0/I8Veed5x0HHnx
         UH8w==
X-Received: by 10.14.176.199 with SMTP id b47mr19533142eem.117.1373184756493;
        Sun, 07 Jul 2013 01:12:36 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id e44sm30691616eeh.11.2013.07.07.01.12.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229738>

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
