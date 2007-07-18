From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Rename read_pipe() with read_fd() and make its buffer nul-terminated.
Date: Wed, 18 Jul 2007 20:31:03 +0200
Message-ID: <469E5C67.3090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 20:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBEJ2-0002Bv-Sx
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 20:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058AbXGRSbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 14:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbXGRSbU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 14:31:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59673 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583AbXGRSbT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 14:31:19 -0400
Received: by ug-out-1314.google.com with SMTP id j3so299899ugf
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 11:31:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=rdemsTreZTP1SC0XMRfkoos/L6XOpEIkwdWvCQmqqkp0w0l99pHyLcAObOjfYiWCTIVDwVpmWSiWLtJaLEOCXXZTc2ddDmJKZY7PyUrsIlUW4oku31y1xNW+YOCeZUHO80ddn6v18UcjDJnHV+4QsPlEIeFgHZbBZ273ZVpfIBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=PT8oJjlcNx8RORPQtnvLSzbEUByTxVmk5EehjUu1zqDAOF9CJ3rROY2jMoIxBfZ4O8xdGNkNU5vBpLjbnkM/l4Wk8nhqIEl+xBcU8fid8OaHaCezVCYBvdUeRnR7XARyXz6kSTA0uaEQiKHMhHPCPdMLcXiga0AgQng5/P5PBCQ=
Received: by 10.67.118.20 with SMTP id v20mr502939ugm.1184783478165;
        Wed, 18 Jul 2007 11:31:18 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id v58sm2588752ugv.2007.07.18.11.31.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jul 2007 11:31:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52889>

The new name is closer to the purpose of the function.

A NUL-terminated buffer makes things easier when callers need that.
Since the function returns only the memory written with data,
almost always allocating more space than needed because final
size is unknown, an extra NUL terminating the buffer is harmless.
It is not included in the returned size, so the function
remains working as before.

Also, now the function allows the buffer passed to be NULL at first,
and alloc_nr is now used for growing the buffer, instead size=*2.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 builtin-stripspace.c |    4 +++-
 cache.h              |    2 +-
 mktag.c              |    2 +-
 sha1_file.c          |   21 +++++++++++++++------
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 0c970aa..5571687 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -79,8 +79,10 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)

 	size = 1024;
 	buffer = xmalloc(size);
-	if (read_pipe(0, &buffer, &size))
+	if (read_fd(0, &buffer, &size)) {
+		free(buffer);
 		die("could not read the input");
+	}

 	size = stripspace(buffer, size, 0);
 	write_or_die(1, buffer, size);
diff --git a/cache.h b/cache.h
index 328c1ad..53801b8 100644
--- a/cache.h
+++ b/cache.h
@@ -265,7 +265,7 @@ extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat
 extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, int);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
-extern int read_pipe(int fd, char** return_buf, unsigned long* return_size);
+extern int read_fd(int fd, char **return_buf, unsigned long *return_size);
 extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
diff --git a/mktag.c b/mktag.c
index b82e377..38acd5a 100644
--- a/mktag.c
+++ b/mktag.c
@@ -120,7 +120,7 @@ int main(int argc, char **argv)

 	setup_git_directory();

-	if (read_pipe(0, &buffer, &size)) {
+	if (read_fd(0, &buffer, &size)) {
 		free(buffer);
 		die("could not read from stdin");
 	}
diff --git a/sha1_file.c b/sha1_file.c
index 1efd9ae..aca741b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2304,27 +2304,36 @@ int has_sha1_file(const unsigned char *sha1)
  *
  * returns 0 if anything went fine and -1 otherwise
  *
+ * The buffer is always NUL-terminated, not including it in returned size.
+ *
  * NOTE: both buf and size may change, but even when -1 is returned
  * you still have to free() it yourself.
  */
-int read_pipe(int fd, char** return_buf, unsigned long* return_size)
+int read_fd(int fd, char **return_buf, unsigned long *return_size)
 {
-	char* buf = *return_buf;
+	char *buf = *return_buf;
 	unsigned long size = *return_size;
 	ssize_t iret;
 	unsigned long off = 0;

+	if (!buf || size <= 1) {
+		size = 1024;
+		buf = xrealloc(buf, size);
+	}
+
 	do {
-		iret = xread(fd, buf + off, size - off);
+		iret = xread(fd, buf + off, (size - 1) - off);
 		if (iret > 0) {
 			off += iret;
-			if (off == size) {
-				size *= 2;
+			if (off == size - 1) {
+				size = alloc_nr(size);
 				buf = xrealloc(buf, size);
 			}
 		}
 	} while (iret > 0);

+	buf[off] = '\0';
+
 	*return_buf = buf;
 	*return_size = off;

@@ -2339,7 +2348,7 @@ int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
 	char *buf = xmalloc(size);
 	int ret;

-	if (read_pipe(fd, &buf, &size)) {
+	if (read_fd(fd, &buf, &size)) {
 		free(buf);
 		return -1;
 	}
-- 
1.5.0
