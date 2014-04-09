From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v3] Verify index file before we opportunistically update it
Date: Thu, 10 Apr 2014 01:52:47 +0300
Message-ID: <1397083967-30401-1-git-send-email-yiannis.marangos@gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 00:59:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY1Sf-0008Ll-JB
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 00:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126AbaDIWxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 18:53:45 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:64856 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719AbaDIWxL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 18:53:11 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so2372033eek.40
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2xpN1H09sWtE6ZqXbFEZnoQbvHKaqEs+xxT+sOrpTnc=;
        b=l8rb899jxAJU2LQlRzkJg4ka0Q3C5vY+E2Bqs0GA4MVkKX70nqE3tT7+NTPPO8N4IQ
         bdL/a5ylWVm1mo1NCN7oDK2aMNZ/L54mNasw755Yidmz4N/Q1ZbMCoOKSe0GskwzdEh1
         FI647ejTpsdjKmm7AvloxBuOejmdUV+OBhuVDEXUIJUzmylDxdTO4hbfYA/fgEWVKI6s
         tkSV4EfHg2UKZmYdxq9Mq4JOaEQGFko3JxfdsaOKLzJiOC87dP3DFEX9VP1mV8m8NBxR
         Dzu8yU+5Uhne2V4DdmWiYEHhjFMSyYl117oQI6Bu/HjEnDwqc1J9axyqo2ejnX+0W3jg
         Shrg==
X-Received: by 10.14.48.2 with SMTP id u2mr10555742eeb.5.1397083988969;
        Wed, 09 Apr 2014 15:53:08 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id o4sm5401933eef.20.2014.04.09.15.53.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Apr 2014 15:53:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246003>

Before we proceed to "opportunistic update" we must verify that the
current index file is the same as the one that we read before. There
is a possible race if we don't do this:

  1. process A calls git-rebase

  2. process A applies 1st commit

  3. process B calls git-status

  4. process B reads index

  5. process A applies 2nd commit

  6. process B takes the lock, then overwrites process A's changes.

  7. process A applies 3rd commit

As an end result the 3rd commit will have a revert of the 2nd commit.

Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
---
 cache.h      |  3 +++
 read-cache.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 107ac61..76ce3d9 100644
--- a/cache.h
+++ b/cache.h
@@ -279,6 +279,7 @@ struct index_state {
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
+	unsigned char sha1[20];
 };
 
 extern struct index_state the_index;
@@ -456,6 +457,8 @@ extern int daemonize(void);
 	} while (0)
 
 /* Initialize and use the cache information */
+extern int verify_index_from(const struct index_state *, const char *path);
+extern int verify_index(const struct index_state *);
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
 extern int read_index_from(struct index_state *, const char *path);
diff --git a/read-cache.c b/read-cache.c
index ba13353..3604d8c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
+#include "git-compat-util.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1321,6 +1322,59 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	return 0;
 }
 
+/* This function verifies if index_state has the correct sha1 of an index file.
+ * Don't die if we have any other failure, just return 0. */
+int verify_index_from(const struct index_state *istate, const char *path)
+{
+	int fd;
+	struct stat st;
+	struct cache_header *hdr;
+	void *mmap_addr;
+	size_t mmap_size;
+
+	if (!istate->initialized)
+		return 0;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	if (fstat(fd, &st))
+		return 0;
+
+	/* file is too big */
+	if (st.st_size > (size_t)st.st_size)
+		return 0;
+
+	mmap_size = (size_t)st.st_size;
+	if (mmap_size < sizeof(struct cache_header) + 20)
+		return 0;
+
+	mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (mmap_addr == MAP_FAILED)
+		return 0;
+
+	hdr = mmap_addr;
+	if (verify_hdr(hdr, mmap_size) < 0)
+		goto unmap;
+
+	if (hashcmp(istate->sha1, (unsigned char *)hdr + mmap_size - 20))
+		goto unmap;
+
+	munmap(mmap_addr, mmap_size);
+	return 1;
+
+unmap:
+	munmap(mmap_addr, mmap_size);
+	return 0;
+}
+
+int verify_index(const struct index_state *istate)
+{
+	return verify_index_from(istate, get_index_file());
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1445,7 +1499,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	struct stat st;
 	unsigned long src_offset;
 	struct cache_header *hdr;
-	void *mmap;
+	void *mmap_addr;
 	size_t mmap_size;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
@@ -1468,15 +1522,16 @@ int read_index_from(struct index_state *istate, const char *path)
 	if (mmap_size < sizeof(struct cache_header) + 20)
 		die("index file smaller than expected");
 
-	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (mmap == MAP_FAILED)
+	mmap_addr = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (mmap_addr == MAP_FAILED)
 		die_errno("unable to map index file");
 	close(fd);
 
-	hdr = mmap;
+	hdr = mmap_addr;
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
+	hashcpy(istate->sha1, (unsigned char *)hdr + mmap_size - 20);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
@@ -1494,7 +1549,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		struct cache_entry *ce;
 		unsigned long consumed;
 
-		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		disk_ce = (struct ondisk_cache_entry *)((char *)mmap_addr + src_offset);
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
@@ -1512,21 +1567,21 @@ int read_index_from(struct index_state *istate, const char *path)
 		 * in 4-byte network byte order.
 		 */
 		uint32_t extsize;
-		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
+		memcpy(&extsize, (char *)mmap_addr + src_offset + 4, 4);
 		extsize = ntohl(extsize);
 		if (read_index_extension(istate,
-					 (const char *) mmap + src_offset,
-					 (char *) mmap + src_offset + 8,
+					 (const char *) mmap_addr + src_offset,
+					 (char *) mmap_addr + src_offset + 8,
 					 extsize) < 0)
 			goto unmap;
 		src_offset += 8;
 		src_offset += extsize;
 	}
-	munmap(mmap, mmap_size);
+	munmap(mmap_addr, mmap_size);
 	return istate->cache_nr;
 
 unmap:
-	munmap(mmap, mmap_size);
+	munmap(mmap_addr, mmap_size);
 	die("index file corrupt");
 }
 
@@ -1779,7 +1834,7 @@ static int has_racy_timestamp(struct index_state *istate)
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    !write_index(istate, lockfile->fd))
+	    verify_index(istate) && !write_index(istate, lockfile->fd))
 		commit_locked_index(lockfile);
 	else
 		rollback_lock_file(lockfile);
-- 
1.9.1
