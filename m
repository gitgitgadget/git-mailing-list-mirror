From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/1] sha1_file.c: Don't retain open fds on small packs
Date: Wed,  2 Mar 2011 10:01:54 -0800
Message-ID: <1299088914-3468-1-git-send-email-spearce@spearce.org>
References: <AANLkTik=FiwsQUg89MRXZX1-jR-fkF7uyJAimSXVSLvR@mail.gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:02:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuqNE-00089v-Da
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 19:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab1CBSB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 13:01:59 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62764 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007Ab1CBSB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 13:01:57 -0500
Received: by iyb26 with SMTP id 26so159315iyb.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 10:01:56 -0800 (PST)
Received: by 10.231.13.138 with SMTP id c10mr135173iba.97.1299088916762;
        Wed, 02 Mar 2011 10:01:56 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id gy41sm132337ibb.23.2011.03.02.10.01.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 10:01:55 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa7
In-Reply-To: <AANLkTik=FiwsQUg89MRXZX1-jR-fkF7uyJAimSXVSLvR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168329>

If a pack file is small enough that its entire contents fits within
one mmap window, mmap the file and then immediately close its file
descriptor.  This reduces the number of file descriptors that are
needed to read from repositories with many tiny pack files, such
as one that has received 1000 pushes (and created 1000 small pack
files) since its last repack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h       |    3 ++-
 fast-import.c |    1 +
 sha1_file.c   |   41 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 08a9022..1d362c4 100644
--- a/cache.h
+++ b/cache.h
@@ -914,7 +914,8 @@ extern struct packed_git {
 	time_t mtime;
 	int pack_fd;
 	unsigned pack_local:1,
-		 pack_keep:1;
+		 pack_keep:1,
+		 do_not_close:1;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
diff --git a/fast-import.c b/fast-import.c
index 3886a1b..4916a9d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -872,6 +872,7 @@ static void start_packfile(void)
 	p = xcalloc(1, sizeof(*p) + strlen(tmpfile) + 2);
 	strcpy(p->pack_name, tmpfile);
 	p->pack_fd = pack_fd;
+	p->do_not_close = 1;
 	pack_file = sha1fd(pack_fd, p->pack_name);
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
diff --git a/sha1_file.c b/sha1_file.c
index 7850c18..fbb178a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -597,7 +597,8 @@ static int unuse_one_window(struct packed_git *current, int keep_fd)
 			lru_l->next = lru_w->next;
 		else {
 			lru_p->windows = lru_w->next;
-			if (!lru_p->windows && lru_p->pack_fd != keep_fd) {
+			if (!lru_p->windows && lru_p->pack_fd != -1
+				&& lru_p->pack_fd != keep_fd) {
 				close(lru_p->pack_fd);
 				pack_open_fds--;
 				lru_p->pack_fd = -1;
@@ -813,14 +814,13 @@ unsigned char *use_pack(struct packed_git *p,
 {
 	struct pack_window *win = *w_cursor;
 
-	if (p->pack_fd == -1 && open_packed_git(p))
-		die("packfile %s cannot be accessed", p->pack_name);
-
 	/* Since packfiles end in a hash of their content and it's
 	 * pointless to ask for an offset into the middle of that
 	 * hash, and the in_window function above wouldn't match
 	 * don't allow an offset too close to the end of the file.
 	 */
+	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
+		die("packfile %s cannot be accessed", p->pack_name);
 	if (offset > (p->pack_size - 20))
 		die("offset beyond end of packfile (truncated pack?)");
 
@@ -834,6 +834,10 @@ unsigned char *use_pack(struct packed_git *p,
 		if (!win) {
 			size_t window_align = packed_git_window_size / 2;
 			off_t len;
+
+			if (p->pack_fd == -1 && open_packed_git(p))
+				die("packfile %s cannot be accessed", p->pack_name);
+
 			win = xcalloc(1, sizeof(*win));
 			win->offset = (offset / window_align) * window_align;
 			len = p->pack_size - win->offset;
@@ -851,6 +855,12 @@ unsigned char *use_pack(struct packed_git *p,
 				die("packfile %s cannot be mapped: %s",
 					p->pack_name,
 					strerror(errno));
+			if (!win->offset && win->len == p->pack_size
+				&& !p->do_not_close) {
+				close(p->pack_fd);
+				pack_open_fds--;
+				p->pack_fd = -1;
+			}
 			pack_mmap_calls++;
 			pack_open_windows++;
 			if (pack_mapped > peak_pack_mapped)
@@ -1951,6 +1961,27 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
+static int is_pack_valid(struct packed_git *p)
+{
+	/* An already open pack is known to be valid. */
+	if (p->pack_fd != -1)
+		return 1;
+
+	/* If the pack has one window completely covering the
+	 * file size, the pack is known to be valid even if
+	 * the descriptor is not currently open.
+	 */
+	if (p->windows) {
+		struct pack_window *w = p->windows;
+
+		if (!w->offset && w->len == p->pack_size)
+			return 1;
+	}
+
+	/* Force the pack to open to prove its valid. */
+	return !open_packed_git(p);
+}
+
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	static struct packed_git *last_found = (void *)1;
@@ -1980,7 +2011,7 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 			 * it may have been deleted since the index
 			 * was loaded!
 			 */
-			if (p->pack_fd == -1 && open_packed_git(p)) {
+			if (!is_pack_valid(p)) {
 				error("packfile %s cannot be accessed", p->pack_name);
 				goto next;
 			}
-- 
1.7.4.1.249.g4aa7
