From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Avoid unnecessarily inflating and interpreting delta
Date: Thu, 30 Jun 2005 17:13:07 -0700
Message-ID: <7vwtobz8mk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 02:06:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do92h-0005vB-LV
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 02:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVGAANa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 20:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbVGAANa
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 20:13:30 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:6126 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S263128AbVGAANO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 20:13:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050701001308.QZOJ18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 20:13:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This teaches packed_delta_info() that it only needs to look at
the type of the base object to figure out both type and size of
a deltified object.  This saves quite a many calls to inflate()
when dealing with a deep delta chain.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cat-file.c  |    3 ++
 sha1_file.c |   77 +++++++++++++++++++++++++++++++----------------------------
 2 files changed, 43 insertions(+), 37 deletions(-)

f0792cd64bd42cde6706dc2c039e7b6901547169
diff --git a/cat-file.c b/cat-file.c
--- a/cat-file.c
+++ b/cat-file.c
@@ -16,7 +16,8 @@ int main(int argc, char **argv)
 		usage("git-cat-file [-t | -s | tagname] <sha1>");
 
 	if (!strcmp("-t", argv[1]) || !strcmp("-s", argv[1])) {
-		if (!sha1_object_info(sha1, type, &size)) {
+		if (!sha1_object_info(sha1, type,
+				      argv[1][1] == 's' ? &size : NULL)) {
 			switch (argv[1][1]) {
 			case 't':
 				printf("%s\n", type);
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -624,41 +624,49 @@ static int packed_delta_info(unsigned ch
 			     char *type,
 			     unsigned long *sizep)
 {
-	const unsigned char *data;
-	unsigned char delta_head[64];
-	unsigned long result_size, base_size, verify_base_size;
-	z_stream stream;
-	int st;
-
 	if (left < 20)
 		die("truncated pack file");
-	if (sha1_object_info(base_sha1, type, &base_size))
-		die("cannot get info for delta-pack base");
 
-	memset(&stream, 0, sizeof(stream));
+	/* We choose to only get the type of the base object and
+	 * ignore potentially corrupt pack file that expects the delta
+	 * based on a base with a wrong size.  This saves tons of
+	 * inflate() calls.
+	 */
 
-	data = stream.next_in = base_sha1 + 20;
-	stream.avail_in = left - 20;
-	stream.next_out = delta_head;
-	stream.avail_out = sizeof(delta_head);
+	if (sha1_object_info(base_sha1, type, NULL))
+		die("cannot get info for delta-pack base");
 
-	inflateInit(&stream);
-	st = inflate(&stream, Z_FINISH);
-	inflateEnd(&stream);
-	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head))
-		die("delta data unpack-initial failed");
+	if (sizep) {
+		const unsigned char *data;
+		unsigned char delta_head[64];
+		unsigned long result_size;
+		z_stream stream;
+		int st;
+
+		memset(&stream, 0, sizeof(stream));
+
+		data = stream.next_in = base_sha1 + 20;
+		stream.avail_in = left - 20;
+		stream.next_out = delta_head;
+		stream.avail_out = sizeof(delta_head);
+
+		inflateInit(&stream);
+		st = inflate(&stream, Z_FINISH);
+		inflateEnd(&stream);
+		if ((st != Z_STREAM_END) &&
+		    stream.total_out != sizeof(delta_head))
+			die("delta data unpack-initial failed");
 
-	/* Examine the initial part of the delta to figure out
-	 * the result size.  Verify the base size while we are at it.
-	 */
-	data = delta_head;
-	verify_base_size = get_delta_hdr_size(&data);
-	if (verify_base_size != base_size)
-		die("delta base size mismatch");
+		/* Examine the initial part of the delta to figure out
+		 * the result size.
+		 */
+		data = delta_head;
+		get_delta_hdr_size(&data); /* ignore base size */
 
-	/* Read the result size */
-	result_size = get_delta_hdr_size(&data);
-	*sizep = result_size;
+		/* Read the result size */
+		result_size = get_delta_hdr_size(&data);
+		*sizep = result_size;
+	}
 	return 0;
 }
 
@@ -726,7 +734,8 @@ static int packed_object_info(struct pac
 	default:
 		die("corrupted pack file");
 	}
-	*sizep = size;
+	if (sizep)
+		*sizep = size;
 	unuse_packed_git(p);
 	return 0;
 }
@@ -915,12 +924,7 @@ int sha1_object_info(const unsigned char
 
 		if (!find_pack_entry(sha1, &e))
 			return error("unable to find %s", sha1_to_hex(sha1));
-		if (!packed_object_info(&e, type, sizep))
-			return 0;
-		/* sheesh */
-		map = unpack_entry(&e, type, sizep);
-		free(map);
-		return (map == NULL) ? 0 : -1;
+		return packed_object_info(&e, type, sizep);
 	}
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
@@ -929,7 +933,8 @@ int sha1_object_info(const unsigned char
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else {
 		status = 0;
-		*sizep = size;
+		if (sizep)
+			*sizep = size;
 	}
 	inflateEnd(&stream);
 	munmap(map, mapsize);
------------
