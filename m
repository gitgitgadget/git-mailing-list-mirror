From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Find size of SHA1 object without inflating everything.
Date: Thu, 02 Jun 2005 09:49:08 -0700
Message-ID: <7vpsv47lh7.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 18:48:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddspz-00036c-Bx
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 18:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFBQta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 12:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFBQta
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 12:49:30 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34690 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261194AbVFBQtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 12:49:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602164910.ZKVV20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 12:49:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 01 Jun 2005 11:38:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds sha1_file_size() helper function and uses it in the
rename/copy similarity estimator.  The helper function handles
deltified object as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus, this also uses the new helper you wrote.

 cache.h     |    2 +-
 diff.c      |   11 +++++---
 sha1_file.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -159,7 +159,7 @@ extern int write_sha1_file(void *buf, un
 extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 extern int sha1_delta_base(const unsigned char *, unsigned char *);
-
+extern int sha1_file_size(const unsigned char *, unsigned long *);
 
 /* Read a tree into the cache */
 extern int read_tree(void *buffer, unsigned long size, int stage);
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -333,7 +333,6 @@ int diff_populate_filespec(struct diff_f
 		close(fd);
 	}
 	else {
-		/* We cannot do size only for SHA1 blobs */
 		char type[20];
 		struct sha1_size_cache *e;
 
@@ -343,11 +342,13 @@ int diff_populate_filespec(struct diff_f
 				s->size = e->size;
 				return 0;
 			}
+			if (!sha1_file_size(s->sha1, &s->size))
+				locate_size_cache(s->sha1, s->size);
+		}
+		else {
+			s->data = read_sha1_file(s->sha1, type, &s->size);
+			s->should_free = 1;
 		}
-		s->data = read_sha1_file(s->sha1, type, &s->size);
-		s->should_free = 1;
-		if (s->data && size_only)
-			locate_size_cache(s->sha1, s->size);
 	}
 	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -387,6 +387,84 @@ int sha1_delta_base(const unsigned char 
 	return status;
 }
 
+int sha1_file_size(const unsigned char *sha1, unsigned long *sizep)
+{
+	unsigned long mapsize, size;
+	void *map;
+	char type[20];
+	char buffer[200];
+	z_stream stream;
+	int ret, bytes, status;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (!map)
+		return 0;
+	ret = unpack_sha1_header(&stream, map, mapsize, buffer,
+				 sizeof(buffer));
+	status = -1;
+
+	if (ret < Z_OK || sscanf(buffer, "%10s %lu", type, &size) != 2)
+		goto out;
+	if (strcmp(type, "delta")) {
+		*sizep = size;
+		status = 0;
+		goto out;
+	}
+
+	/* We are dealing with delta object.  Inflated, the first 20
+	 * bytes hold the base object SHA1, and delta data follows
+	 * immediately after it.
+	 */
+	bytes = strlen(buffer) + 1;
+	if (size < bytes + 6 + 20)
+		goto out; /* the smallest delta size is 6 bytes */
+
+	memmove(buffer, buffer + bytes, stream.total_out - bytes);
+	bytes = stream.total_out - bytes;
+	if (bytes < sizeof(buffer) && ret == Z_OK) {
+		stream.next_out = buffer + bytes;
+		stream.avail_out = sizeof(buffer) - bytes;
+		while (inflate(&stream, Z_FINISH) == Z_OK)
+			; /* nothing */
+	}
+
+	/* We have read initial part of the delta, which starts at
+	 * buffer+20.  Borrow code from patch-delta to read the
+	 * result size.
+	 */
+	{
+		const unsigned char *data = buffer + 20;
+		unsigned char cmd;
+		int i;
+
+		/* Skip over the source size; we are not interested in
+		 * it and we cannot verify it because we do not want
+		 * to read the base object.
+		 */
+		cmd = *data++;
+		while (cmd) {
+			if (cmd & 1)
+				data++;
+			cmd >>= 1;
+		}
+		/* Read the result size */
+		size = i = 0;
+		cmd = *data++;
+		while (cmd) {
+			if (cmd & 1)
+				size |= *data++ << i;
+			i += 8;
+			cmd >>= 1;
+		}
+		*sizep = size;
+	}
+	status = 0;
+ out:
+	inflateEnd(&stream);
+	munmap(map, mapsize);
+	return status;
+}
+
 void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
------------

