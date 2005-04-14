From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] git-pasky-0.4
Date: Thu, 14 Apr 2005 11:33:33 +0100
Message-ID: <20050414113333.A3904@flint.arm.linux.org.uk>
References: <20050414001938.GR25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 12:30:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM1cK-0008HY-BX
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 12:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDNKdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 06:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDNKdu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 06:33:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15889 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261475AbVDNKdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 06:33:37 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DM1fC-0005Uj-8P; Thu, 14 Apr 2005 11:33:34 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DM1fB-0001Ta-80; Thu, 14 Apr 2005 11:33:33 +0100
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050414001938.GR25711@pasky.ji.cz>; from pasky@ucw.cz on Thu, Apr 14, 2005 at 02:19:38AM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2005 at 02:19:38AM +0200, Petr Baudis wrote:
>   I'm happy to announce git-pasky-0.4, my set of scripts upon Linus
> Torvald's git, which aims to provide a humanly usable interface, to a
> degree similar to a SCM tool.

Here's my updated patch, against latest git-pasky.  Now using
hton*/ntoh* directly rather than wrapping them.  Enjoy.

--- cache.h
+++ cache.h	Thu Apr 14 11:27:22 2005
@@ -14,6 +14,8 @@
 #include <openssl/sha.h>
 #include <zlib.h>
 
+#include <netinet/in.h>
+
 /*
  * Basic data structures for the directory cache
  *
@@ -67,7 +69,7 @@
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
-#define ce_size(ce) cache_entry_size((ce)->namelen)
+#define ce_size(ce) cache_entry_size(ntohs((ce)->namelen))
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
--- checkout-cache.c
+++ checkout-cache.c	Thu Apr 14 11:25:40 2005
@@ -77,7 +77,7 @@
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			ce->name, sha1_to_hex(ce->sha1));
 	}
-	fd = create_file(ce->name, ce->st_mode);
+	fd = create_file(ce->name, ntohl(ce->st_mode));
 	if (fd < 0) {
 		free(new);
 		return error("checkout-cache: unable to create %s (%s)",
--- read-cache.c
+++ read-cache.c	Thu Apr 14 11:25:40 2005
@@ -288,27 +288,34 @@
 	/* nsec seems unreliable - not all filesystems support it, so
 	 * as long as it is in the inode cache you get right nsec
 	 * but after it gets flushed, you get zero nsec. */
-	if (ce->mtime.sec  != (unsigned int)st->st_mtim.tv_sec
+#if 0
+	if (ntohl(ce->mtime.sec)  != (unsigned int)st->st_mtim.tv_sec
 #ifdef NSEC
-	    || ce->mtime.nsec != (unsigned int)st->st_mtim.tv_nsec
+	    || ntohl(ce->mtime.nsec) != (unsigned int)st->st_mtim.tv_nsec
 #endif
 	    )
 		changed |= MTIME_CHANGED;
-	if (ce->ctime.sec  != (unsigned int)st->st_ctim.tv_sec
+	if (ntohl(ce->ctime.sec)  != (unsigned int)st->st_ctim.tv_sec
 #ifdef NSEC
-	    || ce->ctime.nsec != (unsigned int)st->st_ctim.tv_nsec
+	    || ntohl(ce->ctime.nsec) != (unsigned int)st->st_ctim.tv_nsec
 #endif
 	    )
 		changed |= CTIME_CHANGED;
-	if (ce->st_uid != (unsigned int)st->st_uid ||
-	    ce->st_gid != (unsigned int)st->st_gid)
+#else
+	if (ntohl(ce->mtime.sec)  != (unsigned int)st->st_mtime)
+		changed |= MTIME_CHANGED;
+	if (ntohl(ce->ctime.sec)  != (unsigned int)st->st_ctime)
+		changed |= CTIME_CHANGED;
+#endif
+	if (ntohl(ce->st_uid) != (unsigned int)st->st_uid ||
+	    ntohl(ce->st_gid) != (unsigned int)st->st_gid)
 		changed |= OWNER_CHANGED;
-	if (ce->st_mode != (unsigned int)st->st_mode)
+	if (ntohl(ce->st_mode) != (unsigned int)st->st_mode)
 		changed |= MODE_CHANGED;
-	if (ce->st_dev != (unsigned int)st->st_dev ||
-	    ce->st_ino != (unsigned int)st->st_ino)
+	if (ntohl(ce->st_dev) != (unsigned int)st->st_dev ||
+	    ntohl(ce->st_ino) != (unsigned int)st->st_ino)
 		changed |= INODE_CHANGED;
-	if (ce->st_size != (unsigned int)st->st_size)
+	if (ntohl(ce->st_size) != (unsigned int)st->st_size)
 		changed |= DATA_CHANGED;
 	return changed;
 }
@@ -337,7 +344,7 @@
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = active_cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ce->namelen);
+		int cmp = cache_name_compare(name, namelen, ce->name, ntohs(ce->namelen));
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -364,7 +371,7 @@
 {
 	int pos;
 
-	pos = cache_name_pos(ce->name, ce->namelen);
+	pos = cache_name_pos(ce->name, ntohs(ce->namelen));
 
 	/* existing match? Just replace it */
 	if (pos >= 0) {
@@ -395,9 +402,9 @@
 	SHA_CTX c;
 	unsigned char sha1[20];
 
-	if (hdr->signature != CACHE_SIGNATURE)
+	if (hdr->signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
-	if (hdr->version != 1)
+	if (hdr->version != htonl(1))
 		return error("bad version");
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, offsetof(struct cache_header, sha1));
@@ -445,12 +452,12 @@
 	if (verify_hdr(hdr, size) < 0)
 		goto unmap;
 
-	active_nr = hdr->entries;
+	active_nr = ntohl(hdr->entries);
 	active_alloc = alloc_nr(active_nr);
 	active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
 
 	offset = sizeof(*hdr);
-	for (i = 0; i < hdr->entries; i++) {
+	for (i = 0; i < ntohl(hdr->entries); i++) {
 		struct cache_entry *ce = map + offset;
 		offset = offset + ce_size(ce);
 		active_cache[i] = ce;
@@ -469,9 +476,9 @@
 	struct cache_header hdr;
 	int i;
 
-	hdr.signature = CACHE_SIGNATURE;
-	hdr.version = 1;
-	hdr.entries = entries;
+	hdr.signature = htonl(CACHE_SIGNATURE);
+	hdr.version = htonl(1);
+	hdr.entries = htonl(entries);
 
 	SHA1_Init(&c);
 	SHA1_Update(&c, &hdr, offsetof(struct cache_header, sha1));
--- read-tree.c
+++ read-tree.c	Thu Apr 14 11:25:11 2005
@@ -13,8 +13,8 @@
 
 	memset(ce, 0, size);
 
-	ce->st_mode = mode;
-	ce->namelen = baselen + len;
+	ce->st_mode = htonl(mode);
+	ce->namelen = htons(baselen + len);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	memcpy(ce->sha1, sha1, 20);
--- show-diff.c
+++ show-diff.c	Thu Apr 14 11:25:28 2005
@@ -90,7 +90,7 @@
 		changed = cache_match_stat(ce, &st);
 		if (!changed)
 			continue;
-		printf("%.*s:  ", ce->namelen, ce->name);
+		printf("%.*s:  ", ntohs(ce->namelen), ce->name);
 		for (n = 0; n < 20; n++)
 			printf("%02x", ce->sha1[n]);
 		printf("\n");
--- update-cache.c
+++ update-cache.c	Thu Apr 14 11:30:07 2005
@@ -68,18 +68,18 @@
  */
 static void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
-	ce->ctime.sec = st->st_ctime;
+	ce->ctime.sec = htonl(st->st_ctime);
 #ifdef NSEC
-	ce->ctime.nsec = st->st_ctim.tv_nsec;
+	ce->ctime.nsec = htonl(st->st_ctim.tv_nsec);
 #endif
-	ce->mtime.sec = st->st_mtime;
+	ce->mtime.sec = htonl(st->st_mtime);
 #ifdef NSEC
-	ce->mtime.nsec = st->st_mtim.tv_nsec;
+	ce->mtime.nsec = htonl(st->st_mtim.tv_nsec);
 #endif
-	ce->st_dev = st->st_dev;
-	ce->st_ino = st->st_ino;
-	ce->st_uid = st->st_uid;
-	ce->st_gid = st->st_gid;
+	ce->st_dev = htonl(st->st_dev);
+	ce->st_ino = htonl(st->st_ino);
+	ce->st_uid = htonl(st->st_uid);
+	ce->st_gid = htonl(st->st_gid);
 }
 
 static int add_file_to_cache(char *path)
@@ -107,9 +107,9 @@
 	memset(ce, 0, size);
 	memcpy(ce->name, path, namelen);
 	fill_stat_cache_info(ce, &st);
-	ce->st_mode = st.st_mode;
-	ce->st_size = st.st_size;
-	ce->namelen = namelen;
+	ce->st_mode = htonl(st.st_mode);
+	ce->st_size = htonl(st.st_size);
+	ce->namelen = htons(namelen);
 
 	if (index_fd(path, namelen, ce, fd, &st) < 0)
 		return -1;
@@ -190,7 +190,7 @@
 	updated = malloc(size);
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
-	updated->st_size = st.st_size;
+	updated->st_size = htonl(st.st_size);
 	return updated;
 }
 
--- write-tree.c
+++ write-tree.c	Thu Apr 14 11:25:40 2005
@@ -45,7 +45,7 @@
 	do {
 		struct cache_entry *ce = cachep[nr];
 		const char *pathname = ce->name, *filename, *dirname;
-		int pathlen = ce->namelen, entrylen;
+		int pathlen = ntohs(ce->namelen), entrylen;
 		unsigned char *sha1;
 		unsigned int mode;
 
@@ -54,7 +54,7 @@
 			break;
 
 		sha1 = ce->sha1;
-		mode = ce->st_mode;
+		mode = ntohl(ce->st_mode);
 
 		/* Do we have _further_ subdirectories? */
 		filename = pathname + baselen;

-- 
Russell King

