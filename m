From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Use fixed-size integers for .idx file I/O
Date: Wed, 17 Jan 2007 23:24:27 -0800
Message-ID: <7vd55col04.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Jan 18 08:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7RdQ-00067u-6F
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 08:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXARHY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 02:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXARHY3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 02:24:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40868 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbXARHY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 02:24:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070118072428.WPNZ18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jan 2007 02:24:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id CXPZ1W00K1kojtg0000000; Thu, 18 Jan 2007 02:23:34 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37063>

This attempts to finish what Simon started in the previous commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I do not think this should have any platform dependent impact
   as long as 1/2 is Ok, but for completeness's sake here it is.

 builtin-pack-objects.c |    6 +++---
 cache.h                |    2 +-
 sha1_file.c            |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 42dd8c8..3824ee3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -569,7 +569,7 @@ static void write_index_file(void)
 					sha1_to_hex(object_list_sha1), "idx");
 	struct object_entry **list = sorted_by_sha;
 	struct object_entry **last = list + nr_result;
-	unsigned int array[256];
+	uint32_t array[256];
 
 	/*
 	 * Write the first-level table (the list is sorted,
@@ -587,7 +587,7 @@ static void write_index_file(void)
 		array[i] = htonl(next - sorted_by_sha);
 		list = next;
 	}
-	sha1write(f, array, 256 * sizeof(int));
+	sha1write(f, array, 256 * 4);
 
 	/*
 	 * Write the actual SHA1 entries..
@@ -595,7 +595,7 @@ static void write_index_file(void)
 	list = sorted_by_sha;
 	for (i = 0; i < nr_result; i++) {
 		struct object_entry *entry = *list++;
-		unsigned int offset = htonl(entry->offset);
+		uint32_t offset = htonl(entry->offset);
 		sha1write(f, &offset, 4);
 		sha1write(f, entry->sha1, 20);
 	}
diff --git a/cache.h b/cache.h
index fda3f8e..e6e19bd 100644
--- a/cache.h
+++ b/cache.h
@@ -351,7 +351,7 @@ struct pack_window {
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
-	unsigned int *index_base;
+	uint32_t *index_base;
 	off_t index_size;
 	off_t pack_size;
 	int pack_fd;
diff --git a/sha1_file.c b/sha1_file.c
index 0b70545..3025440 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -435,7 +435,7 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 				void **idx_map_)
 {
 	void *idx_map;
-	unsigned int *index;
+	uint32_t *index;
 	unsigned long idx_size;
 	int nr, i;
 	int fd = open(path, O_RDONLY);
@@ -1351,7 +1351,7 @@ int nth_packed_object_sha1(const struct packed_git *p, int n,
 unsigned long find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
-	unsigned int *level1_ofs = p->index_base;
+	uint32_t *level1_ofs = p->index_base;
 	int hi = ntohl(level1_ofs[*sha1]);
 	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
 	void *index = p->index_base + 256;
@@ -1360,7 +1360,7 @@ unsigned long find_pack_entry_one(const unsigned char *sha1,
 		int mi = (lo + hi) / 2;
 		int cmp = hashcmp((unsigned char *)index + (24 * mi) + 4, sha1);
 		if (!cmp)
-			return ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
+			return ntohl(*((uint32_t *)((char *)index + (24 * mi))));
 		if (cmp > 0)
 			hi = mi;
 		else
-- 
1.5.0.rc1.g05cf8
