From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 04/16] Modify write functions to prepare for other index formats
Date: Thu,  2 Aug 2012 13:01:54 +0200
Message-ID: <1343905326-23790-5-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBS-00056m-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab2HBLDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64744 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab2HBLC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:02:58 -0400
Received: by eaac11 with SMTP id c11so838708eaa.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dqcoiosURuji+P1IV+jr7b//jmga2M9OzgZcgTY/wWg=;
        b=pZvwEmV8KDuAN/G4/NvKF+Bd/1YLy+MgHYosL6cciDgsXelJuUyYLat6mXStXYitXN
         AhxKkVx51Z8hul2Gc+YctHbWG6u3pP7JdGsQNkm2+uNVvY40SUYB95zwkznjwHVW4jtc
         Z1tmCqApGb5sFGZ+yEHlhHBDtthBO0g2NyzNLWQauxZKBOg8HDEg93iIR3hmCPdg/WGI
         uInrZ/tRK6mvjOPUX6UyaghA1VabxGOcGS4A0tc1XvbptX1goPuswHrpvfnvF4PYh+YL
         QHVDKduJrI+G/v9XLQcPU9M2Uy0T5UQKJjM5KyGmAbCf1g8qXwYvv90EPByVLPzgvC8w
         dZmw==
Received: by 10.14.204.197 with SMTP id h45mr1225286eeo.8.1343905377289;
        Thu, 02 Aug 2012 04:02:57 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id g46sm16303274eep.15.2012.08.02.04.02.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:02:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202756>

Modify the write_index function to add the possibility to add
other index formats, that are written in a different way. Also
mark all functions, which shall only be used with v2-v4 as v2
functions.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 6a0af35..1c804e1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1581,7 +1581,7 @@ static int ce_write_flush(git_SHA_CTX *context, int fd)
 	return 0;
 }
 
-static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
+static int ce_write_v2(git_SHA_CTX *context, int fd, void *data, unsigned int len)
 {
 	while (len) {
 		unsigned int buffered = write_buffer_len;
@@ -1603,13 +1603,13 @@ static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
 	return 0;
 }
 
-static int write_index_ext_header(git_SHA_CTX *context, int fd,
+static int write_index_ext_header_v2(git_SHA_CTX *context, int fd,
 				  unsigned int ext, unsigned int sz)
 {
 	ext = htonl(ext);
 	sz = htonl(sz);
-	return ((ce_write(context, fd, &ext, 4) < 0) ||
-		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
+	return ((ce_write_v2(context, fd, &ext, 4) < 0) ||
+		(ce_write_v2(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
 
 static int ce_flush(git_SHA_CTX *context, int fd)
@@ -1634,7 +1634,7 @@ static int ce_flush(git_SHA_CTX *context, int fd)
 	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
 }
 
-static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
+static void ce_smudge_racily_clean_entry_v2(struct cache_entry *ce)
 {
 	/*
 	 * The only thing we care about in this function is to smudge the
@@ -1715,7 +1715,7 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
+static int ce_write_entry_v2(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 			  struct strbuf *previous_name)
 {
 	int size;
@@ -1755,7 +1755,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 			      ce->name + common, ce_namelen(ce) - common);
 	}
 
-	result = ce_write(c, fd, ondisk, size);
+	result = ce_write_v2(c, fd, ondisk, size);
 	free(ondisk);
 	return result;
 }
@@ -1785,7 +1785,7 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
-int write_index(struct index_state *istate, int newfd)
+int write_index_v2(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_version_header hdr;
@@ -1819,9 +1819,9 @@ int write_index(struct index_state *istate, int newfd)
 	hdr_v2.hdr_entries = htonl(entries - removed);
 
 	git_SHA1_Init(&c);
-	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
+	if (ce_write_v2(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
-	if (ce_write(&c, newfd, &hdr_v2, sizeof(hdr_v2)) < 0)
+	if (ce_write_v2(&c, newfd, &hdr_v2, sizeof(hdr_v2)) < 0)
 		return -1;
 
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
@@ -1830,8 +1830,8 @@ int write_index(struct index_state *istate, int newfd)
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
-			ce_smudge_racily_clean_entry(ce);
-		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
+			ce_smudge_racily_clean_entry_v2(ce);
+		if (ce_write_entry_v2(&c, newfd, ce, previous_name) < 0)
 			return -1;
 	}
 	strbuf_release(&previous_name_buf);
@@ -1841,8 +1841,8 @@ int write_index(struct index_state *istate, int newfd)
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header_v2(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
+			|| ce_write_v2(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -1851,9 +1851,9 @@ int write_index(struct index_state *istate, int newfd)
 		struct strbuf sb = STRBUF_INIT;
 
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+		err = write_index_ext_header_v2(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+			|| ce_write_v2(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -1866,6 +1866,14 @@ int write_index(struct index_state *istate, int newfd)
 	return 0;
 }
 
+int write_index(struct index_state *istate, int newfd)
+{
+	if (!istate->version)
+		istate->version = INDEX_FORMAT_DEFAULT;
+
+	return write_index_v2(istate, newfd);
+}
+
 /*
  * Read the index file that is potentially unmerged into given
  * index_state, dropping any unmerged entries.  Returns true if
-- 
1.7.10.886.gdf6792c.dirty
