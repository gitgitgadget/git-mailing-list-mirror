From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [RFC] Make read_in_full() and write_in_full() consistent with xread() and xwrite()
Date: Sun, 27 Apr 2008 21:21:58 +0300
Message-ID: <20080427182158.GA29232@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:23:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqBWi-0003mb-Oa
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 20:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbYD0SWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 14:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757404AbYD0SWB
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 14:22:01 -0400
Received: from zakalwe.fi ([80.83.5.154]:47062 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757210AbYD0SWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 14:22:00 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 9E6742BC8E; Sun, 27 Apr 2008 21:21:58 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80474>

Requesting comments on the following patch.

xread() and xwrite() return ssize_t values as their native POSIX
counterparts. To be consistent, read_in_full() and write_in_full()
should also return ssize_t values.

Should we make file APIs more consistent?
---
 cache.h        |    4 ++--
 path.c         |    3 ++-
 refs.c         |    3 ++-
 write_or_die.c |    4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 3fcc283..5a28ddd 100644
--- a/cache.h
+++ b/cache.h
@@ -726,8 +726,8 @@ extern const char *git_log_output_encoding;
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
-extern int read_in_full(int fd, void *buf, size_t count);
-extern int write_in_full(int fd, const void *buf, size_t count);
+extern ssize_t read_in_full(int fd, void *buf, size_t count);
+extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
diff --git a/path.c b/path.c
index 2ae7cd9..b7c24a2 100644
--- a/path.c
+++ b/path.c
@@ -91,7 +91,8 @@ int validate_headref(const char *path)
 	struct stat st;
 	char *buf, buffer[256];
 	unsigned char sha1[20];
-	int len, fd;
+	int fd;
+	ssize_t len;
 
 	if (lstat(path, &st) < 0)
 		return -1;
diff --git a/refs.c b/refs.c
index 1b0050e..4db73ed 100644
--- a/refs.c
+++ b/refs.c
@@ -368,7 +368,8 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 
 const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag)
 {
-	int depth = MAXDEPTH, len;
+	int depth = MAXDEPTH;
+	ssize_t len;
 	char buffer[256];
 	static char ref_buffer[256];
 
diff --git a/write_or_die.c b/write_or_die.c
index e125e11..32f9914 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -40,7 +40,7 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 	}
 }
 
-int read_in_full(int fd, void *buf, size_t count)
+ssize_t read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
 	ssize_t total = 0;
@@ -57,7 +57,7 @@ int read_in_full(int fd, void *buf, size_t count)
 	return total;
 }
 
-int write_in_full(int fd, const void *buf, size_t count)
+ssize_t write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
 	ssize_t total = 0;
-- 
1.5.4.4
