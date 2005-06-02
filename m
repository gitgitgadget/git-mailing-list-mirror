From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Find size of SHA1 object without inflating everything.
Date: Thu, 02 Jun 2005 15:20:54 -0700
Message-ID: <7voeao1juh.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
	<7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506020959250.1876@ppc970.osdl.org>
	<7v3bs07fmu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0506021713330.17354@localhost.localdomain>
	<Pine.LNX.4.63.0506021733520.17354@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 00:21:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddy21-0002sY-6p
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 00:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVFBWWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 18:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFBWWH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 18:22:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55708 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261445AbVFBWVB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 18:21:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602222054.VICW8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 18:20:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0506021733520.17354@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 02 Jun 2005 17:36:37 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds sha1_file_size() helper function and uses it in the
rename/copy similarity estimator.  The helper function handles
deltified object as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Thanks and credits goes to Nico for suggesting not to
*** use unpack_sha1_rest().

 cache.h     |    1 +
 diff.c      |   11 ++++++-----
 sha1_file.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -154,6 +154,7 @@ extern void * map_sha1_file(const unsign
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
 extern int parse_sha1_header(char *hdr, char *type, unsigned long *sizep);
 extern int sha1_delta_base(const unsigned char *, unsigned char *);
+extern int sha1_file_size(const unsigned char *, unsigned long *);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
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
@@ -432,6 +432,66 @@ int sha1_delta_base(const unsigned char 
 	return ret;
 }
 
+int sha1_file_size(const unsigned char *sha1, unsigned long *sizep)
+{
+	int ret, status;
+	unsigned long mapsize, size;
+	void *map;
+	z_stream stream;
+	char hdr[64], type[20];
+	const unsigned char *data;
+	unsigned char cmd;
+	int i;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (!map)
+		return -1;
+	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
+	status = -1;
+	if (ret < Z_OK || parse_sha1_header(hdr, type, &size) < 0)
+		goto out;
+	if (strcmp(type, "delta")) {
+		*sizep = size;
+		status = 0;
+		goto out;
+	}
+
+	/* We are dealing with a delta object.  Inflated, the first
+	 * 20 bytes hold the base object SHA1, and delta data follows
+	 * immediately after it.
+	 *
+	 * The initial part of the delta starts at delta_data_head +
+	 * 20.  Borrow code from patch-delta to read the result size.
+	 */
+	data = hdr + strlen(hdr) + 1 + 20;
+
+	/* Skip over the source size; we are not interested in
+	 * it and we cannot verify it because we do not want
+	 * to read the base object.
+	 */
+	cmd = *data++;
+	while (cmd) {
+		if (cmd & 1)
+			data++;
+		cmd >>= 1;
+	}
+	/* Read the result size */
+	size = i = 0;
+	cmd = *data++;
+	while (cmd) {
+		if (cmd & 1)
+			size |= *data++ << i;
+		i += 8;
+		cmd >>= 1;
+	}
+	*sizep = size;
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

