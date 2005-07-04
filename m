From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Use MAP_FAILED instead of double cast
Date: Sun, 03 Jul 2005 23:05:31 -0400
Message-ID: <1120446331.1265.30.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 04 05:06:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpHHc-0001aJ-Tk
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 05:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVGDDFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 23:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGDDFq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 23:05:46 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:19682
	"HELO roinet.com") by vger.kernel.org with SMTP id S261205AbVGDDFc
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 23:05:32 -0400
Received: (qmail 4819 invoked from network); 4 Jul 2005 03:05:31 -0000
Received: from mtproxy.roinet.com (HELO dv) (192.168.1.1)
  by roinet.com with SMTP; 4 Jul 2005 03:05:31 -0000
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

I have found some really ugly code to used to check the result of
mmap():

if (-1 == (int)(long)map)
	return;

Double cast almost always indicates that something fishy is going on.
Indeed, mmap() could (in theory) return 0xffffffff on a 64-bit platform,
and that would be misinterpreted as a failure.

There is a preprocessor symbol MAP_FAILED that should be used instead.
It's used already in some places, so let's use it consistently.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/diffcore-order.c b/diffcore-order.c
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -28,7 +28,7 @@ static void prepare_order(const char *or
 	}
 	map = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (-1 == (int)(long)map)
+	if (map == MAP_FAILED)
 		return;
 	endp = map + st.st_size;
 	for (pass = 0; pass < 2; pass++) {
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -54,7 +54,7 @@ int fetch(unsigned char *sha1)
 		}
 		map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, ifd, 0);
 		close(ifd);
-		if (-1 == (int)(long)map) {
+		if (map == MAP_FAILED) {
 			fprintf(stderr, "cannot mmap %s\n", filename);
 			return -1;
 		}
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -376,7 +376,7 @@ int read_cache(void)
 			map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	}
 	close(fd);
-	if (-1 == (int)(long)map)
+	if (map == MAP_FAILED)
 		return error("mmap failed");
 
 	hdr = map;
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -507,7 +507,7 @@ static void *map_sha1_file_internal(cons
 	}
 	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (-1 == (int)(long)map)
+	if (map == MAP_FAILED)
 		return NULL;
 	*size = st.st_size;
 	return map;
@@ -1293,7 +1293,7 @@ int index_fd(unsigned char *sha1, int fd
 	if (size)
 		buf = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if ((int)(long)buf == -1)
+	if (buf == MAP_FAILED)
 		return -1;
 
 	ret = write_sha1_file(buf, size, "blob", sha1);


-- 
Regards,
Pavel Roskin
