From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Remove unused arguments from index_fd()
Date: Sun, 17 Apr 2005 03:31:00 -0700
Message-ID: <7vu0m5wv8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 12:28:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN70L-0008L8-9K
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 12:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVDQKba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 06:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVDQKba
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 06:31:30 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:15356 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261247AbVDQKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 06:31:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417103101.GVGE2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 06:31:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The function index_fd() in update-cache.c takes 5 arguments, but
two is not necessary and one that is a pointer to a structure
really needs to be a pointer to one member of that structure.
This patch cleans it up.

Also it removes printf() apparently left after initial
debugging.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 update-cache.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

update-cache.c: 5afecd1a4fd90d2505753ce2d5044d780fe69a7f
--- update-cache.c
+++ update-cache.c	2005-04-17 03:22:39.000000000 -0700
@@ -14,13 +14,13 @@
  */
 static int allow_add = 0, allow_remove = 0;
 
-static int index_fd(const char *path, int namelen, struct cache_entry *ce, int fd, struct stat *st)
+static int index_fd(unsigned char *sha1, int fd, struct stat *st)
 {
 	z_stream stream;
 	unsigned long size = st->st_size;
-	int max_out_bytes = namelen + size + 200;
+	int max_out_bytes = size + 200;
 	void *out = malloc(max_out_bytes);
-	void *metadata = malloc(namelen + 200);
+	void *metadata = malloc(200);
 	void *in;
 	SHA_CTX c;
 
@@ -56,9 +56,9 @@
 	
 	SHA1_Init(&c);
 	SHA1_Update(&c, out, stream.total_out);
-	SHA1_Final(ce->sha1, &c);
+	SHA1_Final(sha1, &c);
 
-	return write_sha1_buffer(ce->sha1, out, stream.total_out);
+	return write_sha1_buffer(sha1, out, stream.total_out);
 }
 
 /*
@@ -109,7 +109,7 @@
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	ce->ce_flags = htons(namelen);
 
-	if (index_fd(path, namelen, ce, fd, &st) < 0)
+	if (index_fd(ce->sha1, fd, &st) < 0)
 		return -1;
 
 	return add_cache_entry(ce, allow_add);
@@ -244,13 +244,10 @@
 
 	if (sscanf(arg1, "%o", &mode) != 1)
 		return -1;
-	printf("got mode %o\n", mode);
 	if (get_sha1_hex(arg2, sha1))
 		return -1;
-	printf("got sha1 %s\n", sha1_to_hex(sha1));
 	if (!verify_path(arg3))
 		return -1;
-	printf("got path %s\n", arg3);
 
 	len = strlen(arg3);
 	size = cache_entry_size(len);

