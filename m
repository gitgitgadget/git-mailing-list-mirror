From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Thu,  1 Aug 2013 22:36:33 -0700
Message-ID: <1375421793-32224-1-git-send-email-drafnel@gmail.com>
References: <CA+sFfMdJgQaEBx_FsYPz1rC3--jknnb4Zwr+FOaL+9gNe4xwyw@mail.gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, spearce@spearce.org,
	sunshine@sunshineco.com, bcasey@nvidia.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 02 07:37:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V583E-0005LW-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 07:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab3HBFhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 01:37:15 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62996 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3HBFhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 01:37:14 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so273829pad.18
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ITCAwvcPNEiRTSsH03dDdzFo7RoWpck0dymYQLByg2M=;
        b=cMPotRe0tCFi/Q9eklMbRK+ATRMQY5voUPXKWZ/iQ+/jwebTgQODdF5M5n/D5twJ2r
         Vv5OVkmi0K74UROzz0tWq2Xr9zO1wLrJigDbJNLuHW+r47YnZu9/jVb24l3Yf0wd4rft
         vFjngyefveUIIJxNttjdtAydt8VxVNbnpYZmwnROOjEhMGyN2564un3BtunyG8SeBTyM
         N9p6eQUZV4GI3djKPYuXx4holzHIDyP4EIAtjMomiKV/Kglgg2MNW/trgVBabnwsojss
         7ms5GFXjiF4b8qtlRVa0LiB/OGx+gRL6RbGlDgXiJM3bl7ZTGJaCpIycA9ZK/hTH4tvA
         rQbg==
X-Received: by 10.66.122.131 with SMTP id ls3mr8546842pab.2.1375421833194;
        Thu, 01 Aug 2013 22:37:13 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPSA id om2sm7976028pbc.30.2013.08.01.22.37.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 22:37:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <CA+sFfMdJgQaEBx_FsYPz1rC3--jknnb4Zwr+FOaL+9gNe4xwyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231516>

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
verify that these packed refs exist exceeds the file descriptor
limit.  If the refs are loose, then upload-pack will read each ref
from the object database (if the object is in a pack, allocating one
or more mmap windows for it) in order to peel tags and advertise the
underlying object.  But when the refs are packed and peeled,
upload-pack will use the peeled sha1 in the packed-refs file and
will not need to read from the pack files, so no mmap windows will
be allocated and just like with receive-pack, unuse_one_window()
will never select these opened packs to close.

When we have file descriptor pressure, we just need to find an open
pack to close.  We can leave the existing mmap windows open.  If
additional windows need to be mapped into the pack file, it will be
reopened when necessary.  If the pack file has been rewritten in the
mean time, open_packed_git_1() should notice when it compares the file
size or the pack's sha1 checksum to what was previously read from the
pack index, and reject it.

Let's introduce a new function close_one_pack() designed specifically
for this purpose to search for and close the least-recently-used pack,
where LRU is defined as (in order of preference):

   * pack with oldest mtime and no allocated mmap windows
   * pack with the least-recently-used windows, i.e. the pack
     with the oldest most-recently-used window, where none of
     the windows are in use
   * pack with the least-recently-used windows

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

Here's the version that leaves the mmap windows open after closing
the pack file descriptor.

-Brandon

 sha1_file.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..263cf71 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -673,6 +673,83 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
+/*
+ * The LRU pack is the one with the oldest MRU window, preferring packs
+ * with no used windows, or the oldest mtime if it has no windows allocated.
+ */
+static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struct pack_window **mru_w, int *accept_windows_inuse)
+{
+	struct pack_window *w, *this_mru_w;
+	int has_windows_inuse = 0;
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
+		/*
+		 * Reject this pack if any of its windows are in use,
+		 * but the previously selected pack did not have any
+		 * inuse windows.  Otherwise, record that this pack
+		 * has windows in use.
+		 */
+		if (w->inuse_cnt) {
+			if (*accept_windows_inuse)
+				has_windows_inuse = 1;
+			else
+				return;
+		}
+
+		if (w->last_used > this_mru_w->last_used)
+			this_mru_w = w;
+
+		/*
+		 * Reject this pack if it has windows that have been
+		 * used more recently than the previously selected pack.
+		 * If the previously selected pack had windows inuse and
+		 * we have not encountered a window in this pack that is
+		 * inuse, skip this check since we prefer a pack with no
+		 * inuse windows to one that has inuse windows.
+		 */
+		if (*mru_w && *accept_windows_inuse == has_windows_inuse &&
+		    this_mru_w->last_used > (*mru_w)->last_used)
+			return;
+	}
+
+	/*
+	 * Select this pack.
+	 */
+	*mru_w = this_mru_w;
+	*lru_p = p;
+	*accept_windows_inuse = has_windows_inuse;
+}
+
+static int close_one_pack(void)
+{
+	struct packed_git *p, *lru_p = NULL;
+	struct pack_window *mru_w = NULL;
+	int accept_windows_inuse = 1;
+
+	for (p = packed_git; p; p = p->next) {
+		if (p->pack_fd == -1)
+			continue;
+		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
+	}
+
+	if (lru_p) {
+		close(lru_p->pack_fd);
+		pack_open_fds--;
+		lru_p->pack_fd = -1;
+		return 1;
+	}
+
+	return 0;
+}
+
 void unuse_pack(struct pack_window **w_cursor)
 {
 	struct pack_window *w = *w_cursor;
@@ -768,7 +845,7 @@ static int open_packed_git_1(struct packed_git *p)
 			pack_max_fds = 1;
 	}
 
-	while (pack_max_fds <= pack_open_fds && unuse_one_window(NULL, -1))
+	while (pack_max_fds <= pack_open_fds && close_one_pack())
 		; /* nothing */
 
 	p->pack_fd = git_open_noatime(p->pack_name);
-- 
1.8.1.1.252.gdb33759
