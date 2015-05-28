From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] config.c: avoid xmmap error messages
Date: Thu, 28 May 2015 03:56:15 -0400
Message-ID: <20150528075614.GC23395@peff.net>
References: <20150528075142.GB3688@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:56:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxsfu-0000xw-Ih
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 09:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbbE1H4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 03:56:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:37107 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751844AbbE1H4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 03:56:17 -0400
Received: (qmail 15988 invoked by uid 102); 28 May 2015 07:56:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 02:56:17 -0500
Received: (qmail 14134 invoked by uid 107); 28 May 2015 07:56:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 03:56:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 03:56:15 -0400
Content-Disposition: inline
In-Reply-To: <20150528075142.GB3688@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270131>

The config-writing code uses xmmap to map the existing
config file, which will die if the map fails. This has two
downsides:

  1. The error message is not very helpful, as it lacks any
     context about the file we are mapping:

       $ mkdir foo
       $ git config --file=foo some.key value
       fatal: Out of memory? mmap failed: No such device

  2. We normally do not die in this code path; instead, we'd
     rather report the error and return an appropriate exit
     status (which is part of the public interface
     documented in git-config.1).

This patch introduces a "gentle" form of xmmap which lets us
produce our own error message. We do not want to use mmap
directly, because we would like to use the other
compatibility elements of xmmap (e.g., handling 0-length
maps portably).

The end result is:

    $ git.compile config --file=foo some.key value
    error: unable to mmap 'foo': No such device
    $ echo $?
    3

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c          | 11 +++++++++--
 git-compat-util.h |  1 +
 sha1_file.c       | 15 +++++++++++----
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 6917100..e7dc155 100644
--- a/config.c
+++ b/config.c
@@ -2053,8 +2053,15 @@ int git_config_set_multivar_in_file(const char *config_filename,
 
 		fstat(in_fd, &st);
 		contents_sz = xsize_t(st.st_size);
-		contents = xmmap(NULL, contents_sz, PROT_READ,
-			MAP_PRIVATE, in_fd, 0);
+		contents = xmmap_gently(NULL, contents_sz, PROT_READ,
+					MAP_PRIVATE, in_fd, 0);
+		if (contents == MAP_FAILED) {
+			error("unable to mmap '%s': %s",
+			      config_filename, strerror(errno));
+			ret = CONFIG_INVALID_FILE;
+			contents = NULL;
+			goto out_free;
+		}
 		close(in_fd);
 
 		if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 17584ad..0cc7ae8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -718,6 +718,7 @@ extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
 extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
diff --git a/sha1_file.c b/sha1_file.c
index ccc6dac..73e0bc0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -707,8 +707,8 @@ static void mmap_limit_check(size_t length)
 		    (uintmax_t)length, (uintmax_t)limit);
 }
 
-void *xmmap(void *start, size_t length,
-	int prot, int flags, int fd, off_t offset)
+void *xmmap_gently(void *start, size_t length,
+		  int prot, int flags, int fd, off_t offset)
 {
 	void *ret;
 
@@ -719,12 +719,19 @@ void *xmmap(void *start, size_t length,
 			return NULL;
 		release_pack_memory(length);
 		ret = mmap(start, length, prot, flags, fd, offset);
-		if (ret == MAP_FAILED)
-			die_errno("Out of memory? mmap failed");
 	}
 	return ret;
 }
 
+void *xmmap(void *start, size_t length,
+	int prot, int flags, int fd, off_t offset)
+{
+	void *ret = xmmap_gently(start, length, prot, flags, fd, offset);
+	if (ret == MAP_FAILED)
+			die_errno("Out of memory? mmap failed");
+	return ret;
+}
+
 void close_pack_windows(struct packed_git *p)
 {
 	while (p->windows) {
-- 
2.4.2.668.gc3b1ade.dirty
