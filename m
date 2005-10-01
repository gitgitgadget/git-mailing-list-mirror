From: Dan Aloni <da-x@monatomic.org>
Subject: [PATCH] Fix git+ssh's indefinite halts during long fetches
Date: Sat, 1 Oct 2005 21:39:42 +0300
Message-ID: <20051001183942.GA2099@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 01 20:37:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELmDV-0002fL-FG
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 20:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJASf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 14:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVJASf5
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 14:35:57 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:6329 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1750767AbVJASf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 14:35:56 -0400
Received: from bzq-82-80-223-232.red.bezeqint.net
	([82.80.223.232]:55675 helo=callisto.yi.org ident=karrde)
	by noname.neutralserver.com with esmtpa (Exim 4.52)
	id 1ELmDC-0000aS-P2; Sat, 01 Oct 2005 13:35:56 -0500
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9600>

The problem with the old implementation is that the socket input buffers
get full and then both ends halt waiting for each other. This take cares
of it, by buffering at the fetching side while still trying to send. It's
quite hackish but does the work (I managed to locally fetch the kernel with
its ~85000 objects that sum up to 250MB).

Signed-off-by: Dan Aloni <da-x@monatomic.org>

---
commit 958b0c00525fb63276430783dccb18316cec73c9
tree 4003cf1069e9ac4bbb8aade512047dd41a466ae2
parent 60fb5b2c4d9e26204f480f8a18ae1ff0051a6440
author Dan Aloni <da-x@monatomic.org> Sat, 01 Oct 2005 21:38:25 +0300
committer Dan Aloni <da-x@monatomic.org> Sat, 01 Oct 2005 21:38:25 +0300

 cache.h     |   18 +++++++-
 sha1_file.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 ssh-fetch.c |   76 ++++++++++++++++++++++++-----------
 3 files changed, 174 insertions(+), 49 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -214,8 +214,22 @@ extern int check_sha1_signature(const un
 /* Read a tree into the cache */
 extern int read_tree(void *buffer, unsigned long size, int stage, const char **paths);
 
-extern int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
-			      size_t bufsize, size_t *bufposn);
+struct input_segment {
+	unsigned char *buffer;
+	size_t size;
+
+	struct input_segment *next;
+	struct input_segment *prev;
+};
+
+struct input_buffer {
+	struct input_segment *first;
+	struct input_segment *last;
+};
+
+extern int read_input_buffers(int block, int fd_in, struct input_buffer *inputbuffer);
+extern int write_sha1_from_fd(const unsigned char *sha1, int fd, struct input_buffer *inputbuffer);
+
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
 
 extern int has_sha1_pack(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1413,11 +1413,88 @@ int write_sha1_to_fd(int fd, const unsig
 	return 0;
 }
 
-int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
-		       size_t bufsize, size_t *bufposn)
+int cut_last_input_segment(struct input_buffer *inputbuffer, struct input_segment *segment, size_t size_left)
 {
-	char *filename = sha1_file_name(sha1);
+	if (size_left) {
+		memmove(segment->buffer, segment->buffer + segment->size - size_left, size_left);
+		segment->size = size_left;
+		return 1;
+	}
+	
+	if (segment == inputbuffer->first) 
+		inputbuffer->first = NULL;
+
+	free(segment->buffer);
+	segment = segment->prev;
+	free(inputbuffer->last);
+	inputbuffer->last = segment;
+	return 0;
+}
+
+int read_input_buffers(int block, int fd_in, struct input_buffer *inputbuffer)
+{
+	unsigned long old_flags = 0;
+	size_t bufsize;
+	int readsize;
+	struct input_segment *segment;
+	int ret = 0;
+	unsigned char *buf;
+
+	if (!block) {
+		old_flags = fcntl(fd_in, F_GETFL);
+		fcntl(fd_in, F_SETFL, old_flags | O_NONBLOCK);
+	}
+
+	do {
+		bufsize = 0x10000;
+		buf = malloc(bufsize);
+		if (!buf) {
+			ret = -1;
+			break;
+		}
+		
+		readsize = read(fd_in, buf, bufsize);
+		if (readsize <= 0) {
+			free(buf);
+			if (readsize == 0) {
+				ret = -1;
+			}
+			break;
+		}
+			
+		buf = realloc(buf, readsize);
+		segment = (typeof(segment))(malloc(sizeof(*segment)));
+		if (!segment) {
+			free(buf);
+			ret = -1;
+			break;
+		}
+
+		segment->size = readsize;
+		segment->buffer = buf;
+		segment->next = inputbuffer->first;
+		segment->prev = NULL;
+
+		if (inputbuffer->first == NULL) {
+			inputbuffer->last = segment;
+		} else {
+			inputbuffer->first->prev = segment;
+		}
+		inputbuffer->first = segment;
+	} while (!block);
+
+	if (!block) {
+		fcntl(fd_in, F_SETFL, old_flags);
+	}
+
+	return ret;
+}
 
+extern int write_sha1_from_fd(const unsigned char *sha1, int fd, struct input_buffer *inputbuffer)
+{
+	char *filename = sha1_file_name(sha1);
+	int read_result_byte = 0;
+	signed char result_byte;
 	int local;
 	z_stream stream;
 	unsigned char real_sha1[20];
@@ -1437,10 +1514,20 @@ int write_sha1_from_fd(const unsigned ch
 	SHA1_Init(&c);
 
 	do {
-		ssize_t size;
-		if (*bufposn) {
-			stream.avail_in = *bufposn;
-			stream.next_in = (unsigned char *) buffer;
+		struct input_segment *segment = inputbuffer->last;
+		if (segment) {
+			if (!read_result_byte) {
+				int more_to_read;
+				result_byte = segment->buffer[0];
+				read_result_byte = 1;
+
+				more_to_read = cut_last_input_segment(inputbuffer, segment, segment->size - 1);
+				if (!more_to_read)
+					continue;
+			}
+
+			stream.avail_in = segment->size;
+			stream.next_in = segment->buffer;
 			do {
 				stream.next_out = discard;
 				stream.avail_out = sizeof(discard);
@@ -1448,23 +1535,19 @@ int write_sha1_from_fd(const unsigned ch
 				SHA1_Update(&c, discard, sizeof(discard) -
 					    stream.avail_out);
 			} while (stream.avail_in && ret == Z_OK);
-			write(local, buffer, *bufposn - stream.avail_in);
-			memmove(buffer, buffer + *bufposn - stream.avail_in,
-				stream.avail_in);
-			*bufposn = stream.avail_in;
-			if (ret != Z_OK)
-				break;
-		}
-		size = read(fd, buffer + *bufposn, bufsize - *bufposn);
-		if (size <= 0) {
-			close(local);
-			unlink(filename);
-			if (!size)
+
+			write(local, segment->buffer, segment->size - stream.avail_in);
+			cut_last_input_segment(inputbuffer, segment, stream.avail_in);
+ 			if (ret != Z_OK)
+ 				break;
+		} else {
+			ret = read_input_buffers(1, fd, inputbuffer);
+			if (ret) {
+				close(local);
+				unlink(filename);
 				return error("Connection closed?");
-			perror("Reading from connection");
-			return -1;
-		}
-		*bufposn += size;
+			}
+ 		}
 	} while (1);
 	inflateEnd(&stream);
 
diff --git a/ssh-fetch.c b/ssh-fetch.c
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -14,57 +14,85 @@
 #include "fetch.h"
 #include "refs.h"
 
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+
 static int fd_in;
 static int fd_out;
 
 static unsigned char remote_version = 0;
 static unsigned char local_version = 1;
+static struct input_buffer inputbuffer = {NULL, };
 
-static ssize_t force_write(int fd, void *buffer, size_t length)
+static ssize_t force_write(void *buffer, size_t length)
 {
+	fd_set rfds, wfds;
 	ssize_t ret = 0;
+	int retval;
+	struct timeval tv;
+
+	FD_ZERO(&rfds);
+	FD_ZERO(&wfds);
+	FD_SET(fd_in, &rfds);
+	FD_SET(fd_out, &wfds);
+
 	while (ret < length) {
-		ssize_t size = write(fd, buffer + ret, length - ret);
-		if (size < 0) {
-			return size;
+		tv.tv_sec = 1;
+		tv.tv_usec = 0;
+		
+		retval = select(FD_SETSIZE, &rfds, &wfds, NULL, &tv);
+		if (!retval)
+			continue;
+
+		if (FD_ISSET(fd_in, &rfds)) {
+			read_input_buffers(0, fd_in, &inputbuffer);
+			continue;
 		}
-		if (size == 0) {
-			return ret;
+
+		if (FD_ISSET(fd_out, &wfds)) {
+			ssize_t size;
+			unsigned long old_flags = 0;
+
+			old_flags = fcntl(fd_out, F_GETFL);
+			fcntl(fd_out, F_SETFL, old_flags | O_NONBLOCK);
+			size = write(fd_out, buffer + ret, length - ret);
+			fcntl(fd_out, F_SETFL, old_flags);
+			
+			if (size < 0) {
+				return size;
+			}
+			if (size == 0) {
+				return ret;
+			}		
+	
+			ret += size;
 		}
-		ret += size;
 	}
+
 	return ret;
 }
 
 void prefetch(unsigned char *sha1)
 {
 	char type = 'o';
-	force_write(fd_out, &type, 1);
-	force_write(fd_out, sha1, 20);
+	read_input_buffers(0, fd_in, &inputbuffer);
+	force_write(&type, 1);
+	force_write(sha1, 20);
 	//memcpy(requested + 20 * prefetches++, sha1, 20);
 }
 
-static char conn_buf[4096];
-static size_t conn_buf_posn = 0;
-
 int fetch(unsigned char *sha1)
 {
 	int ret;
-	signed char remote;
 
-	if (conn_buf_posn) {
-		remote = conn_buf[0];
-		memmove(conn_buf, conn_buf + 1, --conn_buf_posn);
-	} else {
-		if (read(fd_in, &remote, 1) < 1)
-			return -1;
-	}
-	//fprintf(stderr, "Got %d\n", remote);
-	if (remote < 0)
-		return remote;
-	ret = write_sha1_from_fd(sha1, fd_in, conn_buf, 4096, &conn_buf_posn);
+	read_input_buffers(0, fd_in, &inputbuffer);
+	ret = write_sha1_from_fd(sha1, fd_in, &inputbuffer);
 	if (!ret)
 		pull_say("got %s\n", sha1_to_hex(sha1));
+
 	return ret;
 }
 

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
