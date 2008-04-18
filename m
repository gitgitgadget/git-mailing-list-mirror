From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/8] Add a lockfile function to append to a file
Date: Thu, 17 Apr 2008 20:02:31 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804171950140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 02:03:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jme4f-0003DR-Qt
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 02:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbYDRACi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 20:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbYDRACi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 20:02:38 -0400
Received: from iabervon.org ([66.92.72.58]:49927 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462AbYDRACh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 20:02:37 -0400
Received: (qmail 7367 invoked by uid 1000); 18 Apr 2008 00:02:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2008 00:02:31 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79855>

This takes care of copying the original contents into the replacement
file after the lock is held, so that concurrent additions can't miss
each other's changes.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
How about this? Also doesn't leak a fd and catches trying to append to a 
file you can't read. Should I worry about mmap failing after the open?

 cache.h    |    1 +
 lockfile.c |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 50b28fa..8d066bf 100644
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
index 663f18f..f1b5416 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -160,6 +160,29 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on
 	return fd;
 }
 
+int hold_lock_file_for_append(struct lock_file *lk, const char *path, int die_on_error)
+{
+	int fd = lock_file(lk, path);
+	struct stat st;
+	if (fd < 0) {
+		if (die_on_error)
+			die("unable to create '%s.lock': %s",
+			    path, strerror(errno));
+	} else if (!stat(path, &st)) {
+		int orig_fd = open(path, O_RDONLY);
+		size_t mmap_size = xsize_t(st.st_size);
+		void *mmap;
+		if (orig_fd < 0)
+			die("unable to read %s to append to it", path);
+		mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE,
+				   orig_fd, 0);
+		write_or_die(fd, mmap, mmap_size);
+		munmap(mmap, mmap_size);
+		close(orig_fd);
+	}
+	return fd;
+}
+
 int close_lock_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
-- 
1.5.4.3.610.gea6cd
