From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Rename read_pipe() with read_fd() and make its buffer nul-terminated.
Date: Wed, 18 Jul 2007 09:08:58 +0200
Message-ID: <469DBC8A.6090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:09:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB3eo-0003Hy-2n
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 09:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbXGRHJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 03:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbXGRHJG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 03:09:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:56323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbXGRHJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 03:09:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so234154ugf
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 00:09:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=JJWtM/RQAXPr4EKw6kKZ5mkdJhxwi+osVybvbjivCB8vYJuKXoIm4fPZ11xQN34SjsGqjJ6WQa4CU4scijsBPSNTSfAl1+PAp/ZLeCnqzvvpliCE6l1XhFI1KRI2lxhjUuvnDRn5RJaQ7iZ8tQh9q9gcCc2Ifq+DjyMvXMRGUhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=uNpXr0BXur3AHNTpV3jb3zk5kML2IYpSHIxpHc8LxSkDSlpYbU9qu2oL713oZZxQqfMxGBkT6nOo1W2Z79IbmUgt1DOWf6A0ovaUgGIHgs0LScm5JD7vioyEoIftbL3N+NVn5Iu1Be9swC5m1uPPbz3BOSqGJodVWuQoQ046fLQ=
Received: by 10.67.29.7 with SMTP id g7mr119560ugj.1184742543460;
        Wed, 18 Jul 2007 00:09:03 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id o55sm2274613uga.2007.07.18.00.09.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jul 2007 00:09:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52835>

The new name is closer to the purpose of the function.

The other change just makes things easier for callers needing a
NUL-terminated buffer.

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
 sha1_file.c          |   17 ++++++++++++++---
 4 files changed, 19 insertions(+), 6 deletions(-)

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
index 328c1ad..ec9b43d 100644
--- a/cache.h
+++ b/cache.h
@@ -265,7 +265,7 @@ extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat
 extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, int);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
-extern int read_pipe(int fd, char** return_buf, unsigned long* return_size);
+extern int read_fd(int fd, char** return_buf, unsigned long* return_size);
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
index 1efd9ae..563ec07 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2304,27 +2304,38 @@ int has_sha1_file(const unsigned char *sha1)
  *
  * returns 0 if anything went fine and -1 otherwise
  *
+ * The buffer is always NUL-terminated, not including it in returned size.
+ *
  * NOTE: both buf and size may change, but even when -1 is returned
  * you still have to free() it yourself.
  */
-int read_pipe(int fd, char** return_buf, unsigned long* return_size)
+int read_fd(int fd, char** return_buf, unsigned long* return_size)
 {
 	char* buf = *return_buf;
 	unsigned long size = *return_size;
 	ssize_t iret;
 	unsigned long off = 0;

+	if (!buf || size <= 1) {
+		size = alloc_nr(size);
+		buf = xrealloc(buf, size);
+	}
+
 	do {
 		iret = xread(fd, buf + off, size - off);
 		if (iret > 0) {
 			off += iret;
 			if (off == size) {
-				size *= 2;
+				size = alloc_nr(size);
 				buf = xrealloc(buf, size);
 			}
 		}
 	} while (iret > 0);

+	if (off == size)
+		buf = xrealloc(buf, size + 1);
+	buf[off] = '\0';
+
 	*return_buf = buf;
 	*return_size = off;

@@ -2339,7 +2350,7 @@ int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
 	char *buf = xmalloc(size);
 	int ret;

-	if (read_pipe(fd, &buf, &size)) {
+	if (read_fd(fd, &buf, &size)) {
 		free(buf);
 		return -1;
 	}
-- 
1.5.0
