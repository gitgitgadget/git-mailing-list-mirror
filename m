From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH 2/2] Don't close pack fd when free'ing pack windows
Date: Wed, 31 Jul 2013 12:51:37 -0700
Message-ID: <1375300297-6744-2-git-send-email-bcasey@nvidia.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
 <1375300297-6744-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gitster@pobox.com>, <peff@peff.net>, <spearce@spearce.org>,
	<sunshine@sunshineco.com>, Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 31 21:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4cRF-0005oS-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab3GaTv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:51:56 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14388 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab3GaTvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:51:55 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B51f96ad90000>; Wed, 31 Jul 2013 12:51:53 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2013 12:51:54 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Wed, 31 Jul 2013 12:51:54 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.298.1; Wed, 31 Jul 2013
 12:51:54 -0700
X-Mailer: git-send-email 1.8.4.rc0.2.g6cf5c31
In-Reply-To: <1375300297-6744-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231452>

From: Brandon Casey <drafnel@gmail.com>

Now that close_one_pack() has been introduced to handle file
descriptor pressure, it is not strictly necessary to close the
pack file descriptor in unuse_one_window() when we're under memory
pressure.

Jeff King provided a justification for leaving the pack file open:

   If you close packfile descriptors, you can run into racy situations
   where somebody else is repacking and deleting packs, and they go away
   while you are trying to access them. If you keep a descriptor open,
   you're fine; they last to the end of the process. If you don't, then
   they disappear from under you.

   For normal object access, this isn't that big a deal; we just rescan
   the packs and retry. But if you are packing yourself (e.g., because
   you are a pack-objects started by upload-pack for a clone or fetch),
   it's much harder to recover (and we print some warnings).

Let's do so (or uh, not do so).

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin/pack-objects.c |  2 +-
 git-compat-util.h      |  2 +-
 sha1_file.c            | 21 +++++++--------------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..4eb0521 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1809,7 +1809,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 static void try_to_free_from_threads(size_t size)
 {
 	read_lock();
-	release_pack_memory(size, -1);
+	release_pack_memory(size);
 	read_unlock();
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index cc4ba4d..29b1ee3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -517,7 +517,7 @@ int inet_pton(int af, const char *src, void *dst);
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 #endif
 
-extern void release_pack_memory(size_t, int);
+extern void release_pack_memory(size_t);
 
 typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
diff --git a/sha1_file.c b/sha1_file.c
index 7731ab1..d26121a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -614,7 +614,7 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct packed_git *current, int keep_fd)
+static int unuse_one_window(struct packed_git *current)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
@@ -628,15 +628,8 @@ static int unuse_one_window(struct packed_git *current, int keep_fd)
 		pack_mapped -= lru_w->len;
 		if (lru_l)
 			lru_l->next = lru_w->next;
-		else {
+		else
 			lru_p->windows = lru_w->next;
-			if (!lru_p->windows && lru_p->pack_fd != -1
-				&& lru_p->pack_fd != keep_fd) {
-				close(lru_p->pack_fd);
-				pack_open_fds--;
-				lru_p->pack_fd = -1;
-			}
-		}
 		free(lru_w);
 		pack_open_windows--;
 		return 1;
@@ -644,10 +637,10 @@ static int unuse_one_window(struct packed_git *current, int keep_fd)
 	return 0;
 }
 
-void release_pack_memory(size_t need, int fd)
+void release_pack_memory(size_t need)
 {
 	size_t cur = pack_mapped;
-	while (need >= (cur - pack_mapped) && unuse_one_window(NULL, fd))
+	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
 		; /* nothing */
 }
 
@@ -658,7 +651,7 @@ void *xmmap(void *start, size_t length,
 	if (ret == MAP_FAILED) {
 		if (!length)
 			return NULL;
-		release_pack_memory(length, fd);
+		release_pack_memory(length);
 		ret = mmap(start, length, prot, flags, fd, offset);
 		if (ret == MAP_FAILED)
 			die_errno("Out of memory? mmap failed");
@@ -954,7 +947,7 @@ unsigned char *use_pack(struct packed_git *p,
 			win->len = (size_t)len;
 			pack_mapped += win->len;
 			while (packed_git_limit < pack_mapped
-				&& unuse_one_window(p, p->pack_fd))
+				&& unuse_one_window(p))
 				; /* nothing */
 			win->base = xmmap(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,
@@ -1000,7 +993,7 @@ static struct packed_git *alloc_packed_git(int extra)
 
 static void try_to_free_pack_memory(size_t size)
 {
-	release_pack_memory(size, -1);
+	release_pack_memory(size);
 }
 
 struct packed_git *add_packed_git(const char *path, int path_len, int local)
-- 
1.8.4.rc0.2.g6cf5c31


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
