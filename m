From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Add a lockfile function to append to a file
Date: Sun, 9 Mar 2008 18:46:35 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091842030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 23:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYUIX-0001d2-5O
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 23:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYCIWqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 18:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbYCIWqi
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 18:46:38 -0400
Received: from iabervon.org ([66.92.72.58]:47972 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbYCIWqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 18:46:37 -0400
Received: (qmail 19084 invoked by uid 1000); 9 Mar 2008 22:46:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 22:46:35 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76677>

This takes care of copying the original contents into the replacement
file after the lock is held, so that concurrent additions can't miss
each other's changes.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
These two together replace [PATCH 5/11] from my earlier series; the 
lockfile API turned out not to have anything for O_APPEND (for the simple 
reason that it always creates a new replacement file). But appending is an 
obvious logical operation to support internally, especially since it 
actually has a clear semantics by itself for avoiding races.

 cache.h    |    1 +
 lockfile.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 2a1e7ec..4a113b0 100644
--- a/cache.h
+++ b/cache.h
@@ -391,6 +391,7 @@ struct lock_file {
 	char filename[PATH_MAX];
 };
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
+extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
diff --git a/lockfile.c b/lockfile.c
index 663f18f..95fd3d1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -160,6 +160,23 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on
 	return fd;
 }
 
+int hold_lock_file_for_append(struct lock_file *lk, const char *path, int die_on_error)
+{
+	int fd = lock_file(lk, path);
+	struct stat st;
+	if (!stat(path, &st)) {
+		int orig_fd = open(path, O_RDONLY);
+		size_t mmap_size = xsize_t(st.st_size);
+		void *mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE,
+				   orig_fd, 0);
+		write_or_die(fd, mmap, mmap_size);
+		munmap(mmap, mmap_size);
+	}
+	if (fd < 0 && die_on_error)
+		die("unable to create '%s.lock': %s", path, strerror(errno));
+	return fd;
+}
+
 int close_lock_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
-- 
1.5.4.3.610.gea6cd
