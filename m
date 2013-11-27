From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 04/24] read-cache: Re-read index if index file changed
Date: Wed, 27 Nov 2013 13:00:39 +0100
Message-ID: <1385553659-9928-5-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldoO-0001kc-Ul
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab3K0MBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:39 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:60660 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab3K0MBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:37 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so5281996lab.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dlmITBcbx2tGtYpykkfzkEnu5iee7udQFG1HrsMc6VE=;
        b=09uF56NuW9Mgrddp3LO3S+Z0dlL1XPKkGYvt5qkGhu8bDGwDrWSAaeyo3Bx+LLPljZ
         Xf95xeOvSA52ivN3yUrY4ICXf6ROw7r0Wask/wNkX/YhIgEC2hgHhOAHIHUdbTbH1Nfs
         wEsHU2Vw7bSwKWZsQ7r0JS7ZGGA3naB6rzIc0vNtGfQEoZV1WiwTcvcTv9Ac3vHHfx9A
         0gMPJDPCBVtgh4eXdmyPc66qEdTAh1woBsAtpaAgf07qRLZOybhYVn8LxqaRkpcysxMT
         wwL6Xc2n4Dwkzfs+e7K1lsKG7vK30wcxKm229Xml5p1MVvQA3xnQM0mK9UUjazEHl5Ch
         2AwA==
X-Received: by 10.112.52.33 with SMTP id q1mr1293587lbo.30.1385553696012;
        Wed, 27 Nov 2013 04:01:36 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id qj3sm45465861lbb.1.2013.11.27.04.01.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:34 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238418>

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
index e081084..51be1bb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1294,8 +1294,8 @@ int read_index(struct index_state *istate)
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
@@ -1307,43 +1307,46 @@ int read_index_from(struct index_state *istate, const char *path)
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
+		if (!err && istate->ops->verify_hdr(mmap, mmap_size) < 0)
+			err = 1;
 
-	if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
-		goto unmap;
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+		if (!err && istate->ops->read_index(istate, mmap, mmap_size) < 0)
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
1.8.4.2
