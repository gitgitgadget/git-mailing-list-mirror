From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Fri, 30 Jun 2006 16:43:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 16:44:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKDY-0003QT-B3
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 16:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWF3Onc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 10:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWF3Onc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 10:43:32 -0400
Received: from mail.gmx.de ([213.165.64.21]:58853 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750801AbWF3Onb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 10:43:31 -0400
Received: (qmail invoked by alias); 30 Jun 2006 14:43:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 30 Jun 2006 16:43:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <fork0@t-online.de>
In-Reply-To: <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22989>


These functions will be useful for the inbuilt merge-recursive.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 cache.h      |    2 ++
 read-cache.c |   57 +++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 8719939..a5343db 100644
--- a/cache.h
+++ b/cache.h
@@ -142,7 +142,9 @@ #define alloc_nr(x) (((x)+16)*3/2)
 
 /* Initialize and use the cache information */
 extern int read_cache(void);
+extern int read_cache_from(const char *path);
 extern int write_cache(int newfd, struct cache_entry **cache, int entries);
+extern int discard_cache(void);
 extern int verify_path(const char *path);
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
diff --git a/read-cache.c b/read-cache.c
index 3c32aae..04d2ec7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -24,6 +24,9 @@ unsigned int active_nr = 0, active_alloc
 
 struct cache_tree *active_cache_tree = NULL;
 
+static void *cache_mmap = NULL;
+static size_t cache_mmap_size = 0;
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -729,39 +732,43 @@ static int read_index_extension(const ch
 
 int read_cache(void)
 {
+	return read_cache_from(get_index_file());
+}
+
+/* remember to discard_cache() before reading a different cache! */
+int read_cache_from(const char *path)
+{
 	int fd, i;
 	struct stat st;
-	unsigned long size, offset;
-	void *map;
+	unsigned long offset;
 	struct cache_header *hdr;
 
 	errno = EBUSY;
-	if (active_cache)
+	if (cache_mmap)
 		return active_nr;
 
 	errno = ENOENT;
 	index_file_timestamp = 0;
-	fd = open(get_index_file(), O_RDONLY);
+	fd = open(path, O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
 		die("index file open failed (%s)", strerror(errno));
 	}
 
-	size = 0; // avoid gcc warning
-	map = MAP_FAILED;
+	cache_mmap = MAP_FAILED;
 	if (!fstat(fd, &st)) {
-		size = st.st_size;
+		cache_mmap_size = st.st_size;
 		errno = EINVAL;
-		if (size >= sizeof(struct cache_header) + 20)
-			map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		if (cache_mmap_size >= sizeof(struct cache_header) + 20)
+			cache_mmap = mmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	}
 	close(fd);
-	if (map == MAP_FAILED)
+	if (cache_mmap == MAP_FAILED)
 		die("index file mmap failed (%s)", strerror(errno));
 
-	hdr = map;
-	if (verify_hdr(hdr, size) < 0)
+	hdr = cache_mmap;
+	if (verify_hdr(hdr, cache_mmap_size) < 0)
 		goto unmap;
 
 	active_nr = ntohl(hdr->hdr_entries);
@@ -770,12 +777,12 @@ int read_cache(void)
 
 	offset = sizeof(*hdr);
 	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = (struct cache_entry *) ((char *) map + offset);
+		struct cache_entry *ce = (struct cache_entry *) ((char *) cache_mmap + offset);
 		offset = offset + ce_size(ce);
 		active_cache[i] = ce;
 	}
 	index_file_timestamp = st.st_mtime;
-	while (offset <= size - 20 - 8) {
+	while (offset <= cache_mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
 		 * sections, each of which is prefixed with
@@ -783,10 +790,10 @@ int read_cache(void)
 		 * in 4-byte network byte order.
 		 */
 		unsigned long extsize;
-		memcpy(&extsize, (char *) map + offset + 4, 4);
+		memcpy(&extsize, (char *) cache_mmap + offset + 4, 4);
 		extsize = ntohl(extsize);
-		if (read_index_extension(((const char *) map) + offset,
-					 (char *) map + offset + 8,
+		if (read_index_extension(((const char *) cache_mmap) + offset,
+					 (char *) cache_mmap + offset + 8,
 					 extsize) < 0)
 			goto unmap;
 		offset += 8;
@@ -795,11 +802,25 @@ int read_cache(void)
 	return active_nr;
 
 unmap:
-	munmap(map, size);
+	munmap(cache_mmap, cache_mmap_size);
 	errno = EINVAL;
 	die("index file corrupt");
 }
 
+int discard_cache()
+{
+	int ret;
+	
+	if (cache_mmap == NULL)
+		return 0;
+	ret = munmap(cache_mmap, cache_mmap_size);
+	cache_mmap = NULL;
+	cache_mmap_size = 0;
+	active_nr = active_cache_changed = 0;
+	/* no need to throw away allocated active_cache */
+	return ret;
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
-- 
1.4.1.rc1.gb2d14
