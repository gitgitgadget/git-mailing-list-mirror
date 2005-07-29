From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] mmap error handling
Date: Fri, 29 Jul 2005 10:49:14 -0400
Message-ID: <1122648554.3331.2.camel@dv>
References: <1122586842.17837.9.camel@dv>
	 <118833cc05072816294f80a829@mail.gmail.com>
	 <Pine.LNX.4.58.0507281725440.3307@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 29 16:50:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyWAx-0004rC-Vs
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 16:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVG2OtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVG2OtV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 10:49:21 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:2234 "HELO
	roinet.com") by vger.kernel.org with SMTP id S262600AbVG2OtT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 10:49:19 -0400
Received: (qmail 14377 invoked from network); 29 Jul 2005 14:49:16 -0000
Received: from corporate.roinet.com (HELO mail.roinet.com) (192.168.1.2)
  by roinet.com with SMTP; 29 Jul 2005 14:49:16 -0000
Received: by mail.roinet.com (Postfix, from userid 65534)
	id 2AD2945DF42; Fri, 29 Jul 2005 10:49:15 -0400 (EDT)
Received: from dv (unknown [192.168.1.1])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail.roinet.com (Postfix) with ESMTP id 8E62145DF18
	for <git@vger.kernel.org>; Fri, 29 Jul 2005 10:49:14 -0400 (EDT)
To: git <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507281725440.3307@g5.osdl.org>
X-Mailer: Evolution 2.3.5.1 (2.3.5.1-1) 
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on mail.roinet.com
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Linus!

On Thu, 2005-07-28 at 17:30 -0700, Linus Torvalds wrote:
> _always_ save the value of errno before doing any other calls. Even 
> successful calls are perfectly allowed to change errno.

OK.  Fixed patch below.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -377,8 +377,10 @@ int diff_populate_filespec(struct diff_f
 		if (fd < 0)
 			goto err_empty;
 		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
-		s->should_munmap = 1;
 		close(fd);
+		if (s->data == MAP_FAILED)
+			goto err_empty;
+		s->should_munmap = 1;
 	}
 	else {
 		char type[20];
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
@@ -392,7 +392,7 @@ int read_cache(void)
 		return (errno == ENOENT) ? 0 : error("open failed");
 
 	size = 0; // avoid gcc warning
-	map = (void *)-1;
+	map = MAP_FAILED;
 	if (!fstat(fd, &st)) {
 		size = st.st_size;
 		errno = EINVAL;
@@ -400,7 +400,7 @@ int read_cache(void)
 			map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	}
 	close(fd);
-	if (-1 == (int)(long)map)
+	if (map == MAP_FAILED)
 		return error("mmap failed");
 
 	hdr = map;
diff --git a/rev-cache.c b/rev-cache.c
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -212,11 +212,9 @@ int read_rev_cache(const char *path, FIL
 		return -1;
 	}
 	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED) {
-		close(fd);
-		return -1;
-	}
 	close(fd);
+	if (map == MAP_FAILED)
+		return -1;
 
 	memset(last_sha1, 0, 20);
 	ofs = 0;
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -518,7 +518,7 @@ static void *map_sha1_file_internal(cons
 	}
 	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (-1 == (int)(long)map)
+	if (map == MAP_FAILED)
 		return NULL;
 	*size = st.st_size;
 	return map;
@@ -1363,7 +1363,7 @@ int index_fd(unsigned char *sha1, int fd
 	if (size)
 		buf = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if ((int)(long)buf == -1)
+	if (buf == MAP_FAILED)
 		return -1;
 
 	if (!type)
diff --git a/test-delta.c b/test-delta.c
--- a/test-delta.c
+++ b/test-delta.c
@@ -41,6 +41,7 @@ int main(int argc, char *argv[])
 	from_buf = mmap(NULL, from_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (from_buf == MAP_FAILED) {
 		perror(argv[2]);
+		close(fd);
 		return 1;
 	}
 	close(fd);
@@ -54,6 +55,7 @@ int main(int argc, char *argv[])
 	data_buf = mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (data_buf == MAP_FAILED) {
 		perror(argv[3]);
+		close(fd);
 		return 1;
 	}
 	close(fd);
diff --git a/tools/mailsplit.c b/tools/mailsplit.c
--- a/tools/mailsplit.c
+++ b/tools/mailsplit.c
@@ -116,8 +116,9 @@ int main(int argc, char **argv)
 	}
 	size = st.st_size;
 	map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (-1 == (int)(long)map) {
+	if (map == MAP_FAILED) {
 		perror("mmap");
+		close(fd);
 		exit(1);
 	}
 	close(fd);


-- 
Regards,
Pavel Roskin
