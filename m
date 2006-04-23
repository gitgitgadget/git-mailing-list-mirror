From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] read-cache/write-cache: optionally return cache checksum SHA1.
Date: Sun, 23 Apr 2006 16:52:08 -0700
Message-ID: <7vodyretp3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 01:52:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXoNC-0006F5-P7
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 01:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWDWXwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 19:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWDWXwK
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 19:52:10 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2259 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751460AbWDWXwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 19:52:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060423235208.WTNB17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 19:52:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19074>

read_cache_1() and write_cache_1() takes an extra parameter
*sha1 that returns the checksum of the index file when non-NULL.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is a low-impact small preparation for the following
   three, which is an interesting optimization.

 cache.h      |    5 ++++-
 read-cache.c |   35 +++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 9 deletions(-)

c2a742f3ac14e93704c917e4d9b08881d6032281
diff --git a/cache.h b/cache.h
index 69801b0..8c9947e 100644
--- a/cache.h
+++ b/cache.h
@@ -138,8 +138,11 @@ extern const char *prefix_filename(const
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /* Initialize and use the cache information */
+extern int read_cache_1(unsigned char *);
+extern int write_cache_1(int, struct cache_entry **, int, unsigned char *);
 extern int read_cache(void);
-extern int write_cache(int newfd, struct cache_entry **cache, int entries);
+extern int write_cache(int, struct cache_entry **, int);
+
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/read-cache.c b/read-cache.c
index f97f92d..50e094e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -496,10 +496,12 @@ int add_cache_entry(struct cache_entry *
 	return 0;
 }
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(struct cache_header *hdr, unsigned long size, unsigned char *sha1)
 {
 	SHA_CTX c;
-	unsigned char sha1[20];
+	unsigned char sha1_buf[20];
+	if (!sha1)
+		sha1 = sha1_buf;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
@@ -513,7 +515,7 @@ static int verify_hdr(struct cache_heade
 	return 0;
 }
 
-int read_cache(void)
+int read_cache_1(unsigned char *cache_sha1)
 {
 	int fd, i;
 	struct stat st;
@@ -547,7 +549,7 @@ int read_cache(void)
 		die("index file mmap failed (%s)", strerror(errno));
 
 	hdr = map;
-	if (verify_hdr(hdr, size) < 0)
+	if (verify_hdr(hdr, size, cache_sha1) < 0)
 		goto unmap;
 
 	active_nr = ntohl(hdr->hdr_entries);
@@ -595,7 +597,7 @@ static int ce_write(SHA_CTX *context, in
  	return 0;
 }
 
-static int ce_flush(SHA_CTX *context, int fd)
+static int ce_flush(SHA_CTX *context, int fd, unsigned char *sha1)
 {
 	unsigned int left = write_buffer_len;
 
@@ -612,7 +614,8 @@ static int ce_flush(SHA_CTX *context, in
 	}
 
 	/* Append the SHA1 signature at the end */
-	SHA1_Final(write_buffer + left, context);
+	SHA1_Final(sha1, context);
+	memcpy(write_buffer + left, sha1, 20);
 	left += 20;
 	if (write(fd, write_buffer, left) != left)
 		return -1;
@@ -663,11 +666,14 @@ static void ce_smudge_racily_clean_entry
 	}
 }
 
-int write_cache(int newfd, struct cache_entry **cache, int entries)
+int write_cache_1(int newfd, struct cache_entry **cache, int entries,
+		  unsigned char *cache_sha1)
 {
 	SHA_CTX c;
 	struct cache_header hdr;
 	int i, removed;
+	int status;
+	unsigned char sha1[20];
 
 	for (i = removed = 0; i < entries; i++)
 		if (!cache[i]->ce_mode)
@@ -691,5 +697,18 @@ int write_cache(int newfd, struct cache_
 		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
 			return -1;
 	}
-	return ce_flush(&c, newfd);
+	status = ce_flush(&c, newfd, sha1);
+	if (cache_sha1)
+		memcpy(cache_sha1, sha1, 20);
+	return status;
+}
+
+int read_cache(void)
+{
+	return read_cache_1(NULL);
+}
+
+int write_cache(int newfd, struct cache_entry **cache, int entries)
+{
+	return write_cache_1(newfd, cache, entries, NULL);
 }
-- 
1.3.0.g623a
