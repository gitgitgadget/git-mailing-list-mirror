From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 07/24] read-cache: Re-read index if index file changed
Date: Sun, 18 Aug 2013 21:41:56 +0200
Message-ID: <1376854933-31241-8-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xq-0003q6-8V
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab3HRTs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:28 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56151 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:27 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so594015wiw.17
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Az2EyVYuoUk5zfREHedF84zGmGJ2sxDJ0FoZSfXa7E=;
        b=ttqvITVYoqydj2AHuW0vuTrEemZ3yRAYlozwK4xymp5KSV//8ePcEUogL2fZSygznQ
         s8QQmL7KpXe2YY9MAt/ds0p47PcanYvVXoiR/f+sdOIh5E9T0y6sEJ1RxKpeewDyQiml
         puNFBH1sBZvyrNMudFplYoeSzYgfMMkfk2at3zj55UGyj6NBc3cQ9gUB9Oq19dLdB4J6
         Ha6i8xld1XR7O5F5vzvuXvkOPvwsvJE3rbcR305ObtGsetCaduR/IxBvp5hbW4ihJgA1
         10Mi/TZAtoTY1Hu1x8LsQ+yX4NSx82WhASMtvqXLCf/wvKA3LagyvwAVjVA61b8eUcvE
         EBUg==
X-Received: by 10.180.90.106 with SMTP id bv10mr5071112wib.65.1376855306735;
        Sun, 18 Aug 2013 12:48:26 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id hb2sm13379815wib.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232494>

Add the possibility of re-reading the index file, if it changed
while reading.

The index file might change during the read, causing outdated
information to be displayed. We check if the index file changed
by using its stat data as heuristic.

Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 65 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index aa17ce7..2d12601 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1296,8 +1296,8 @@ int read_index(struct index_state *istate)
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
-	int fd;
-	struct stat st;
+	int fd, err, i;
+	struct stat_validity sv;
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
@@ -1309,43 +1309,46 @@ int read_index_from(struct index_state *istate, const char *path)
 	errno = ENOENT;
 	istate->timestamp.sec = 0;
 	istate->timestamp.nsec = 0;
-
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT) {
-			initialize_index(istate, 0);
-			return 0;
+	sv.sd = NULL;
+	for (i = 0; i < 50; i++) {
+		err = 0;
+		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			if (errno == ENOENT) {
+				initialize_index(istate, 0);
+				return 0;
+			}
+			die_errno("index file open failed");
 		}
-		die_errno("index file open failed");
-	}
 
-	if (fstat(fd, &st))
-		die_errno("cannot stat the open index");
+		stat_validity_update(&sv, fd);
+		if (!sv.sd)
+			die_errno("cannot stat the open index");
 
-	errno = EINVAL;
-	mmap_size = xsize_t(st.st_size);
-	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	close(fd);
-	if (mmap == MAP_FAILED)
-		die_errno("unable to map index file");
+		errno = EINVAL;
+		mmap_size = xsize_t(sv.sd->sd_size);
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
 
-	if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
-		goto unmap;
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+		if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
+			err = 1;
+		istate->timestamp.sec = sv.sd->sd_mtime.sec;
+		istate->timestamp.nsec = sv.sd->sd_mtime.nsec;
 
-	munmap(mmap, mmap_size);
-	return istate->cache_nr;
+		munmap(mmap, mmap_size);
+		if (stat_validity_check(&sv, path) && !err)
+			return istate->cache_nr;
+	}
 
-unmap:
-	munmap(mmap, mmap_size);
 	die("index file corrupt");
 }
 
-- 
1.8.3.4.1231.g9fbf354.dirty
