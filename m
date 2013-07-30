From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Mon, 29 Jul 2013 21:05:13 -0700
Message-ID: <1375157113-608-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gitster@pobox.com>, <spearce@spearce.org>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 06:05:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V41Bc-0004i1-Lo
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 06:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab3G3EFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 00:05:20 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2286 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab3G3EFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 00:05:18 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B51f73b7c0000>; Mon, 29 Jul 2013 21:05:16 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 29 Jul 2013 21:03:55 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 29 Jul 2013 21:03:55 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.298.1; Mon, 29 Jul 2013
 21:05:17 -0700
X-Mailer: git-send-email 1.8.3.1.440.gc2bf105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231347>

From: Brandon Casey <drafnel@gmail.com>

When the number of open packs exceeds pack_max_fds, unuse_one_window()
is called repeatedly to attempt to release the least-recently-used
pack windows, which, as a side-effect, will also close a pack file
after closing its last open window.  If a pack file has been opened,
but no windows have been allocated into it, it will never be selected
by unuse_one_window() and hence its file descriptor will not be
closed.  When this happens, git may exceed the number of file
descriptors permitted by the system.

This latter situation can occur in show-ref or receive-pack during ref
advertisement.  During ref advertisement, receive-pack will iterate
over every ref in the repository and advertise it to the client after
ensuring that the ref exists in the local repository.  If the ref is
located inside a pack, then the pack is opened to ensure that it
exists, but since the object is not actually read from the pack, no
mmap windows are allocated.  When the number of open packs exceeds
pack_max_fds, unuse_one_window() will not able to find any windows to
free and will not be able to close any packs.  Once the per-process
file descriptor limit is exceeded, receive-pack will produce a warning,
not an error, for each pack it cannot open, and will then most likely
fail with an error to spawn rev-list or index-pack like:

   error: cannot create standard input pipe for rev-list: Too many open files
   error: Could not run 'git rev-list'

This is not likely to occur during upload-pack since upload-pack
reads each object from the pack so that it can peel tags and
advertise the exposed object.  So during upload-pack, mmap windows
will be allocated for each pack that is opened and unuse_one_window()
will eventually be able to close unused packs after freeing all of
their windows.

When we have file descriptor pressure, in contrast to memory pressure,
we need to free all windows and close the pack file descriptor so that
a new pack can be opened.  Let's introduce a new function
close_one_pack() designed specifically for this purpose to search
for and close the least-recently-used pack, where LRU is defined as

   * pack with oldest mtime and no allocated mmap windows or
   * pack with the least-recently-used windows, i.e. the pack
     with the oldest most-recently-used window

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 sha1_file.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8e27db1..7731ab1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -682,6 +682,67 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
+/*
+ * The LRU pack is the one with the oldest MRU window or the oldest mtime
+ * if it has no windows allocated.
+ */
+static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struct pack_window **mru_w)
+{
+	struct pack_window *w, *this_mru_w;
+
+	/*
+	 * Reject this pack if it has windows and the previously selected
+	 * one does not.  If this pack does not have windows, reject
+	 * it if the pack file is newer than the previously selected one.
+	 */
+	if (*lru_p && !*mru_w && (p->windows || p->mtime > (*lru_p)->mtime))
+		return;
+
+	for (w = this_mru_w = p->windows; w; w = w->next) {
+		/* Reject this pack if any of its windows are in use */
+		if (w->inuse_cnt)
+			return;
+		/*
+		 * Reject this pack if it has windows that have been
+		 * used more recently than the previously selected pack.
+		 */
+		if (*mru_w && w->last_used > (*mru_w)->last_used)
+			return;
+		if (w->last_used > this_mru_w->last_used)
+			this_mru_w = w;
+	}
+
+	/*
+	 * Select this pack.
+	 */
+	*mru_w = this_mru_w;
+	*lru_p = p;
+}
+
+static int close_one_pack(void)
+{
+	struct packed_git *p, *lru_p = NULL;
+	struct pack_window *mru_w = NULL;
+
+	for (p = packed_git; p; p = p->next) {
+		if (p->pack_fd == -1)
+			continue;
+		find_lru_pack(p, &lru_p, &mru_w);
+	}
+
+	if (lru_p) {
+		close_pack_windows(lru_p);
+		close(lru_p->pack_fd);
+		pack_open_fds--;
+		lru_p->pack_fd = -1;
+		if (lru_p == last_found_pack)
+			last_found_pack = NULL;
+		return 1;
+	}
+
+	return 0;
+}
+
 void unuse_pack(struct pack_window **w_cursor)
 {
 	struct pack_window *w = *w_cursor;
@@ -777,7 +838,7 @@ static int open_packed_git_1(struct packed_git *p)
 			pack_max_fds = 1;
 	}
 
-	while (pack_max_fds <= pack_open_fds && unuse_one_window(NULL, -1))
+	while (pack_max_fds <= pack_open_fds && close_one_pack())
 		; /* nothing */
 
 	p->pack_fd = git_open_noatime(p->pack_name);
-- 
1.8.3.1.440.gc2bf105


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
