From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 03/16] Modify match_stat_basic to prepare for other index formats
Date: Thu,  2 Aug 2012 13:01:53 +0200
Message-ID: <1343905326-23790-4-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBR-00056m-VE
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab2HBLC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:02:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54882 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:02:57 -0400
Received: by eaac11 with SMTP id c11so838702eaa.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IfoSwHYhhVmD5mwVNHo7ZfriR79zfZ0RWzk4TaIPxy0=;
        b=xss8vq8dS8DRs0AAGJ5PaScHYQBCw/Kr6OtmzAN01T8gbdRhHXN7G4DskV5IJqoRk6
         20HZEncY8GOQ+LSmMBQJ68zD/ip59Yxp3VnMlvXKh/aDiZYjzUHYhIgCusAxrNhuxG4j
         ghCvNuyKihndOrKhcFLaBLXHE1CfpuDw7q+WbV/Spg+doGAIQdHNcXK3g86u6Ea1QKu5
         UgLh2GNGuMxO6OKpo+JCmuiVVabdjpuO8ct5jEPga5pXWza/7XebIXOcLEsdc+4l0P5k
         ULKRt9g8ajLyjCkPJVHjC9QdV2B0eMuvgDS+B71JKw2sjwQjkzxCC07y64WiYu9kWTgh
         Hrdg==
Received: by 10.14.219.198 with SMTP id m46mr26112438eep.18.1343905375976;
        Thu, 02 Aug 2012 04:02:55 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id a41sm2337771eep.7.2012.08.02.04.02.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:02:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202753>

Modify match_stat_basic, into one function that handles the
general case, which is the same for all index formats, and
a function that handles the specific parts for each index
file version.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 77 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 3d83f05..6a0af35 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,38 +163,10 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
+static int ce_match_stat_basic_v2(struct cache_entry *ce,
+				struct stat *st,
+				int changed)
 {
-	unsigned int changed = 0;
-
-	if (ce->ce_flags & CE_REMOVE)
-		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
-
-	switch (ce->ce_mode & S_IFMT) {
-	case S_IFREG:
-		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
-		/* We consider only the owner x bit to be relevant for
-		 * "mode changes"
-		 */
-		if (trust_executable_bit &&
-		    (0100 & (ce->ce_mode ^ st->st_mode)))
-			changed |= MODE_CHANGED;
-		break;
-	case S_IFLNK:
-		if (!S_ISLNK(st->st_mode) &&
-		    (has_symlinks || !S_ISREG(st->st_mode)))
-			changed |= TYPE_CHANGED;
-		break;
-	case S_IFGITLINK:
-		/* We ignore most of the st_xxx fields for gitlinks */
-		if (!S_ISDIR(st->st_mode))
-			changed |= TYPE_CHANGED;
-		else if (ce_compare_gitlink(ce))
-			changed |= DATA_CHANGED;
-		return changed;
-	default:
-		die("internal error: ce_mode is %o", ce->ce_mode);
-	}
 	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
 	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
@@ -235,6 +207,43 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	return changed;
 }
 
+static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
+{
+	unsigned int changed = 0;
+
+	if (ce->ce_flags & CE_REMOVE)
+		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
+
+	switch (ce->ce_mode & S_IFMT) {
+	case S_IFREG:
+		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
+		/* We consider only the owner x bit to be relevant for
+		 * "mode changes"
+		 */
+		if (trust_executable_bit &&
+		    (0100 & (ce->ce_mode ^ st->st_mode)))
+			changed |= MODE_CHANGED;
+		break;
+	case S_IFLNK:
+		if (!S_ISLNK(st->st_mode) &&
+		    (has_symlinks || !S_ISREG(st->st_mode)))
+			changed |= TYPE_CHANGED;
+		break;
+	case S_IFGITLINK:
+		/* We ignore most of the st_xxx fields for gitlinks */
+		if (!S_ISDIR(st->st_mode))
+			changed |= TYPE_CHANGED;
+		else if (ce_compare_gitlink(ce))
+			changed |= DATA_CHANGED;
+		return changed;
+	default:
+		die("internal error: ce_mode is %o", ce->ce_mode);
+	}
+
+	changed = ce_match_stat_basic_v2(ce, st, changed);
+	return changed;
+}
+
 static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
@@ -1443,7 +1452,6 @@ void read_index_v2(struct index_state *istate, void *mmap, int mmap_size)
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
@@ -1500,7 +1508,6 @@ int read_index_from(struct index_state *istate, const char *path)
 		die("index file smaller than expected");
 
 	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	close(fd);
 	if (mmap == MAP_FAILED)
 		die_errno("unable to map index file");
 
@@ -1512,7 +1519,6 @@ int read_index_from(struct index_state *istate, const char *path)
 		goto unmap;
 
 	read_index_v2(istate, mmap, mmap_size);
-
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
@@ -1802,9 +1808,6 @@ int write_index(struct index_state *istate, int newfd)
 		}
 	}
 
-	if (!istate->version)
-		istate->version = INDEX_FORMAT_DEFAULT;
-
 	/* demote version 3 to version 2 when the latter suffices */
 	if (istate->version == 3 || istate->version == 2)
 		istate->version = extended ? 3 : 2;
-- 
1.7.10.886.gdf6792c.dirty
