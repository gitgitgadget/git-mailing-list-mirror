From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 1/2] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Wed, 31 Jul 2013 12:51:36 -0700
Message-ID: <1375300297-6744-1-git-send-email-bcasey@nvidia.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gitster@pobox.com>, <peff@peff.net>, <spearce@spearce.org>,
	<sunshine@sunshineco.com>, Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 31 21:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4cRA-0005kq-AU
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab3GaTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:51:52 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17243 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab3GaTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:51:51 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
	id <B51f96acd0000>; Wed, 31 Jul 2013 12:51:41 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2013 12:50:25 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Wed, 31 Jul 2013 12:50:25 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.298.1; Wed, 31 Jul 2013
 12:51:50 -0700
X-Mailer: git-send-email 1.8.4.rc0.2.g6cf5c31
In-Reply-To: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231451>

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
pack_max_fds, unuse_one_window() will not be able to find any windows to
free and will not be able to close any packs.  Once the per-process
file descriptor limit is exceeded, receive-pack will produce a warning,
not an error, for each pack it cannot open, and will then most likely
fail with an error to spawn rev-list or index-pack like:

   error: cannot create standard input pipe for rev-list: Too many open files
   error: Could not run 'git rev-list'

This may also occur during upload-pack when refs are packed (in the
packed-refs file) and the number of packs that must be opened to
verify that these packed refs exist exceeds the file descriptor limit.
If the refs are loose, then upload-pack will read each ref from the
pack (allocating one or more mmap windows) so it can peel tags and
advertise the underlying object.  If the refs are packed and peeled,
then upload-pack will use the peeled sha1 in the packed-refs file and
will not need to read from the pack files, so no mmap windows will be
allocated and just like with receive-pack, unuse_one_window() will
never select these opened packs to close.

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

The commit message was updated to fix the grammatical error that Eric
Sunshine pointed out, and to correct the paragraph about upload-pack.

-Brandon

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
1.8.4.rc0.2.g6cf5c31


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
