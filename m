From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Add BASE index extension.
Date: Thu, 29 Mar 2007 01:23:10 -0700
Message-ID: <7vmz1w4fwx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 10:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWpuj-000473-Kg
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbXC2IXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbXC2IXR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:23:17 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63755 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXC2IXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:23:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329082311.QRYT27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 04:23:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gYPA1W0091kojtg0000000; Thu, 29 Mar 2007 04:23:11 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43414>

With this patch, there now is a place to store one object name
in the index as an optional "BASE".  The intended use is to
store the commit object name that the index is based on, so that
we can detect cases where a third-party updates the branch head of
the currently checked out branch, e.g. with "git push".

There currently is nobody that sets the value nor uses it.  That
is the topic of the subsequent ones in the series.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 cache.h      |    2 ++
 read-cache.c |   19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 384b260..def5d4a 100644
--- a/cache.h
+++ b/cache.h
@@ -128,6 +128,8 @@ static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned in
 extern struct cache_entry **active_cache;
 extern unsigned int active_nr, active_alloc, active_cache_changed;
 extern struct cache_tree *active_cache_tree;
+extern unsigned char active_cache_base[20];
+extern int active_cache_base_valid;
 extern int cache_errno;
 
 enum object_type {
diff --git a/read-cache.c b/read-cache.c
index 6339a27..221fc61 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -17,12 +17,15 @@
 
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
+#define CACHE_EXT_BASE 0x42415345	/* "BASE" */
 
 struct cache_entry **active_cache;
 static time_t index_file_timestamp;
 unsigned int active_nr, active_alloc, active_cache_changed;
 
 struct cache_tree *active_cache_tree;
+unsigned char active_cache_base[20];
+int active_cache_base_valid;
 
 int cache_errno;
 
@@ -760,6 +763,11 @@ static int read_index_extension(const char *ext, void *data, unsigned long sz)
 	case CACHE_EXT_TREE:
 		active_cache_tree = cache_tree_read(data, sz);
 		break;
+	case CACHE_EXT_BASE:
+		if (sz != 40 || get_sha1_hex(data, active_cache_base))
+			return error("malformed base commit recorded in index");
+		active_cache_base_valid = 1;
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -814,6 +822,7 @@ int read_cache_from(const char *path)
 	active_nr = ntohl(hdr->hdr_entries);
 	active_alloc = alloc_nr(active_nr);
 	active_cache = xcalloc(active_alloc, sizeof(struct cache_entry *));
+	active_cache_base_valid = 0;
 
 	offset = sizeof(*hdr);
 	for (i = 0; i < active_nr; i++) {
@@ -851,7 +860,7 @@ int discard_cache(void)
 {
 	int ret;
 
-	active_nr = active_cache_changed = 0;
+	active_cache_base_valid = active_nr = active_cache_changed = 0;
 	index_file_timestamp = 0;
 	cache_tree_free(&active_cache_tree);
 	if (cache_mmap == NULL)
@@ -1019,5 +1028,13 @@ int write_cache(int newfd, struct cache_entry **cache, int entries)
 			return -1;
 		}
 	}
+	if (active_cache_base_valid) {
+		char *hex = sha1_to_hex(active_cache_base);
+		unsigned int len = 40;
+		if (write_index_ext_header(&c, newfd, CACHE_EXT_BASE, len) ||
+		    ce_write(&c, newfd, hex, len))
+			return -1;
+	}
+
 	return ce_flush(&c, newfd);
 }
-- 
1.5.1.rc3.1.ga429d
