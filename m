From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 04/16] Modify write functions to prepare for other index formats
Date: Sun,  5 Aug 2012 23:49:01 +0200
Message-ID: <1344203353-2819-5-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8jR-0002Kp-Iv
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab2HEVuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48892 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab2HEVtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:53 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so648690eaa.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XEEMD6+42QFa6xbw/Rvnt1QAHFq+ofMp2YVYmLKb5NA=;
        b=z2Lh11zVY8r0Gu3gdCZ3FhQmX78R+ejBT1AmFJkFkpDQN64hvOIxF1pVOWQg+07ZhJ
         hdh7JwDFsROPhD54HJBOGs0RLVrmTvQbsyCQ1fehfxdIT985VVIjb8xFLHMJzR6qbntx
         YGuNQ5UdXpbACYmyZ3t9vdIzrQSFbO12GaV4vRRNu3OFaihwDvrOuW9DtBRWYeV22TjW
         e1PJg7YnNbIThz+g88KdyXdfgrwwwh+Uva1YK4kGVt75vwDSc8S+b6FQCDYmDS7I+TaF
         V88Nh6O0q64WyK9LdxI4AQyfnRJawdzg1i7kxdBbM1SUyvqbswM/qDm5wMigSD/iAoUj
         AmEA==
Received: by 10.14.182.134 with SMTP id o6mr10348925eem.26.1344203393038;
        Sun, 05 Aug 2012 14:49:53 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id u47sm9875936eeo.9.2012.08.05.14.49.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202936>

Modify the write_index function to add the possibility to add
other index formats, that are written in a different way. Also
mark all functions, which shall only be used with v2-v4 as v2
functions.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 6e8991a..dceaa5c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1595,7 +1595,7 @@ static int ce_write_flush(git_SHA_CTX *context, int fd)
 	return 0;
 }
 
-static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
+static int ce_write_v2(git_SHA_CTX *context, int fd, void *data, unsigned int len)
 {
 	while (len) {
 		unsigned int buffered = write_buffer_len;
@@ -1617,13 +1617,13 @@ static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
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
@@ -1648,7 +1648,7 @@ static int ce_flush(git_SHA_CTX *context, int fd)
 	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
 }
 
-static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
+static void ce_smudge_racily_clean_entry_v2(struct cache_entry *ce)
 {
 	/*
 	 * The only thing we care about in this function is to smudge the
@@ -1729,7 +1729,7 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
+static int ce_write_entry_v2(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 			  struct strbuf *previous_name)
 {
 	int size;
@@ -1769,7 +1769,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 			      ce->name + common, ce_namelen(ce) - common);
 	}
 
-	result = ce_write(c, fd, ondisk, size);
+	result = ce_write_v2(c, fd, ondisk, size);
 	free(ondisk);
 	return result;
 }
@@ -1799,7 +1799,7 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
-int write_index(struct index_state *istate, int newfd)
+static int write_index_v2(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_version_header hdr;
@@ -1822,9 +1822,6 @@ int write_index(struct index_state *istate, int newfd)
 		}
 	}
 
-	if (!istate->version)
-		istate->version = INDEX_FORMAT_DEFAULT;
-
 	/* demote version 3 to version 2 when the latter suffices */
 	if (istate->version == 3 || istate->version == 2)
 		istate->version = extended ? 3 : 2;
@@ -1836,9 +1833,9 @@ int write_index(struct index_state *istate, int newfd)
 	hdr_v2.hdr_entries = htonl(entries - removed);
 
 	git_SHA1_Init(&c);
-	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
+	if (ce_write_v2(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
-	if (ce_write(&c, newfd, &hdr_v2, sizeof(hdr_v2)) < 0)
+	if (ce_write_v2(&c, newfd, &hdr_v2, sizeof(hdr_v2)) < 0)
 		return -1;
 
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
@@ -1847,8 +1844,8 @@ int write_index(struct index_state *istate, int newfd)
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
@@ -1858,8 +1855,8 @@ int write_index(struct index_state *istate, int newfd)
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header_v2(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
+			|| ce_write_v2(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -1868,9 +1865,9 @@ int write_index(struct index_state *istate, int newfd)
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
@@ -1883,6 +1880,14 @@ int write_index(struct index_state *istate, int newfd)
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
1.7.10.GIT
