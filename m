From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] xread/xwrite: do not worry about EINTR at calling sites.
Date: Mon, 19 Dec 2005 16:55:40 -0800
Message-ID: <7vvexkpoxf.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vhd95h02o.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512191142410.4827@g5.osdl.org>
	<43A732C9.2060509@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 01:56:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoVnC-0001jG-Ia
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 01:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVLTAzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 19:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVLTAzm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 19:55:42 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20707 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbVLTAzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 19:55:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051220005412.FUGU17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 19:54:12 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43A732C9.2060509@zytor.com> (H. Peter Anvin's message of "Mon,
	19 Dec 2005 14:23:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13841>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Linus Torvalds wrote:
>> On Mon, 19 Dec 2005, Junio C Hamano wrote:
>>
>>>I was looking at "git grep -n EAGAIN" output and found that many
>>>places check "errno == EAGAIN" without checking "errno ==
>>>EINTR", both for read(2) and write(2).
>> I suspect it's mostly in my code. It's a stupid quirk of mine.
>> You might as well delete those thing, but yes, if you want to
>> replace them with testing both EAGAIN and EINTR, go right ahead.
>>
>
> It might be that some of those should either be replaced by fwrite/fread 
> or there should be a generic wrapper (usually called xwrite/xread).

Good idea.  Something like this I suppose....

-- >8 --
We had errno==EINTR check after read(2)/write(2) sprinkled all
over the places, always doing continue.  Consolidate them into
xread()/xwrite() wrapper routines.

Credits for suggestion goes to HPA -- bugs are mine.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 apply.c           |   23 ++++++-----------------
 cat-file.c        |    4 +---
 copy.c            |   19 +++++++------------
 csum-file.c       |    4 +---
 git-compat-util.h |   22 ++++++++++++++++++++++
 mktag.c           |    9 ++-------
 pkt-line.c        |   11 +++--------
 tar-tree.c        |    4 +---
 unpack-objects.c  |   13 +++----------
 9 files changed, 46 insertions(+), 63 deletions(-)

7c59f627268cd446fc7e1df9847dd1e2178072da
diff --git a/apply.c b/apply.c
index 1742ab2..d5e7bfd 100644
--- a/apply.c
+++ b/apply.c
@@ -84,14 +84,11 @@ static void *read_patch_file(int fd, uns
 			buffer = xrealloc(buffer, alloc);
 			nr = alloc - size;
 		}
-		nr = read(fd, buffer + size, nr);
+		nr = xread(fd, buffer + size, nr);
 		if (!nr)
 			break;
-		if (nr < 0) {
-			if (errno == EAGAIN)
-				continue;
+		if (nr < 0)
 			die("git-apply: read returned %s", strerror(errno));
-		}
 		size += nr;
 	}
 	*sizep = size;
@@ -1006,13 +1003,8 @@ static int read_old_data(struct stat *st
 			return error("unable to open %s", path);
 		got = 0;
 		for (;;) {
-			int ret = read(fd, buf + got, size - got);
-			if (ret < 0) {
-				if (errno == EAGAIN)
-					continue;
-				break;
-			}
-			if (!ret)
+			int ret = xread(fd, buf + got, size - got);
+			if (ret <= 0)
 				break;
 			got += ret;
 		}
@@ -1600,12 +1592,9 @@ static int try_create_file(const char *p
 	if (fd < 0)
 		return -1;
 	while (size) {
-		int written = write(fd, buf, size);
-		if (written < 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
+		int written = xwrite(fd, buf, size);
+		if (written < 0)
 			die("writing file %s: %s", path, strerror(errno));
-		}
 		if (!written)
 			die("out of space writing file %s", path);
 		buf += written;
diff --git a/cat-file.c b/cat-file.c
index 7594108..96d66b4 100644
--- a/cat-file.c
+++ b/cat-file.c
@@ -55,10 +55,8 @@ int main(int argc, char **argv)
 		die("git-cat-file %s: bad file", argv[2]);
 
 	while (size > 0) {
-		long ret = write(1, buf, size);
+		long ret = xwrite(1, buf, size);
 		if (ret < 0) {
-			if (errno == EAGAIN)
-				continue;
 			/* Ignore epipe */
 			if (errno == EPIPE)
 				break;
diff --git a/copy.c b/copy.c
index e1cd5d0..7100eed 100644
--- a/copy.c
+++ b/copy.c
@@ -6,32 +6,27 @@ int copy_fd(int ifd, int ofd)
 		int len;
 		char buffer[8192];
 		char *buf = buffer;
-		len = read(ifd, buffer, sizeof(buffer));
+		len = xread(ifd, buffer, sizeof(buffer));
 		if (!len)
 			break;
 		if (len < 0) {
 			int read_error;
-			if (errno == EAGAIN)
-				continue;
 			read_error = errno;
 			close(ifd);
 			return error("copy-fd: read returned %s",
 				     strerror(read_error));
 		}
-		while (1) {
-			int written = write(ofd, buf, len);
+		while (len) {
+			int written = xwrite(ofd, buf, len);
 			if (written > 0) {
 				buf += written;
 				len -= written;
-				if (!len)
-					break;
 			}
-			if (!written)
+			else if (!written)
 				return error("copy-fd: write returned 0");
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
-			return error("copy-fd: write returned %s",
-				     strerror(errno));
+			else
+				return error("copy-fd: write returned %s",
+					     strerror(errno));
 		}
 	}
 	close(ifd);
diff --git a/csum-file.c b/csum-file.c
index c66b9eb..5f9249a 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -15,7 +15,7 @@ static int sha1flush(struct sha1file *f,
 	void *buf = f->buffer;
 
 	for (;;) {
-		int ret = write(f->fd, buf, count);
+		int ret = xwrite(f->fd, buf, count);
 		if (ret > 0) {
 			buf += ret;
 			count -= ret;
@@ -25,8 +25,6 @@ static int sha1flush(struct sha1file *f,
 		}
 		if (!ret)
 			die("sha1 file '%s' write error. Out of diskspace", f->name);
-		if (errno == EAGAIN || errno == EINTR)
-			continue;
 		die("sha1 file '%s' write error (%s)", f->name, strerror(errno));
 	}
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index ead0ede..0c98c99 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -84,6 +84,28 @@ static inline void *xcalloc(size_t nmemb
 	return ret;
 }
 
+static inline ssize_t xread(int fd, void *buf, size_t len)
+{
+	ssize_t nr;
+	while (1) {
+		nr = read(fd, buf, len);
+		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+			continue;
+		return nr;
+	}
+}
+
+static inline ssize_t xwrite(int fd, const void *buf, size_t len)
+{
+	ssize_t nr;
+	while (1) {
+		nr = write(fd, buf, len);
+		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+			continue;
+		return nr;
+	}
+}
+
 /* Sane ctype - no locale, and works with signed chars */
 #undef isspace
 #undef isdigit
diff --git a/mktag.c b/mktag.c
index 97e270a..fc6a9bf 100644
--- a/mktag.c
+++ b/mktag.c
@@ -116,14 +116,9 @@ int main(int argc, char **argv)
 	// Read the signature
 	size = 0;
 	for (;;) {
-		int ret = read(0, buffer + size, MAXSIZE - size);
-		if (!ret)
+		int ret = xread(0, buffer + size, MAXSIZE - size);
+		if (ret <= 0)
 			break;
-		if (ret < 0) {
-			if (errno == EAGAIN)
-				continue;
-			break;
-		}
 		size += ret;
 	}
 
diff --git a/pkt-line.c b/pkt-line.c
index 6947304..bb3bab0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -19,7 +19,7 @@
 static void safe_write(int fd, const void *buf, unsigned n)
 {
 	while (n) {
-		int ret = write(fd, buf, n);
+		int ret = xwrite(fd, buf, n);
 		if (ret > 0) {
 			buf += ret;
 			n -= ret;
@@ -27,8 +27,6 @@ static void safe_write(int fd, const voi
 		}
 		if (!ret)
 			die("write error (disk full?)");
-		if (errno == EAGAIN || errno == EINTR)
-			continue;
 		die("write error (%s)", strerror(errno));
 	}
 }
@@ -68,12 +66,9 @@ static void safe_read(int fd, void *buff
 	int n = 0;
 
 	while (n < size) {
-		int ret = read(fd, buffer + n, size - n);
-		if (ret < 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
+		int ret = xread(fd, buffer + n, size - n);
+		if (ret < 0)
 			die("read error (%s)", strerror(errno));
-		}
 		if (!ret)
 			die("unexpected EOF");
 		n += ret;
diff --git a/tar-tree.c b/tar-tree.c
index bacb23a..96bd143 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -34,10 +34,8 @@ struct path_prefix {
 static void reliable_write(void *buf, unsigned long size)
 {
 	while (size > 0) {
-		long ret = write(1, buf, size);
+		long ret = xwrite(1, buf, size);
 		if (ret < 0) {
-			if (errno == EAGAIN)
-				continue;
 			if (errno == EPIPE)
 				exit(0);
 			die("git-tar-tree: %s", strerror(errno));
diff --git a/unpack-objects.c b/unpack-objects.c
index cfd61ae..5c5cb12 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -31,12 +31,10 @@ static void * fill(int min)
 		offset = 0;
 	}
 	do {
-		int ret = read(0, buffer + len, sizeof(buffer) - len);
+		int ret = xread(0, buffer + len, sizeof(buffer) - len);
 		if (ret <= 0) {
 			if (!ret)
 				die("early EOF");
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
 			die("read error on input: %s", strerror(errno));
 		}
 		len += ret;
@@ -299,14 +297,9 @@ int main(int argc, char **argv)
 
 	/* Write the last part of the buffer to stdout */
 	while (len) {
-		int ret = write(1, buffer + offset, len);
-		if (!ret)
-			break;
-		if (ret < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
+		int ret = xwrite(1, buffer + offset, len);
+		if (ret <= 0)
 			break;
-		}
 		len -= ret;
 		offset += ret;
 	}
-- 
0.99.9.GIT
