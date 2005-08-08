From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2/4] Plug memory leak in write_sha1_to_fd()
Date: Mon, 8 Aug 2005 22:45:36 +0400
Message-ID: <20050808184536.GC5789@procyon.home>
References: <20050808184332.GA5789@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 20:48:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Cdq-0000W3-PU
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 20:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVHHSq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 14:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVHHSq2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 14:46:28 -0400
Received: from mail.murom.net ([213.177.124.17]:45251 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932189AbVHHSq2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 14:46:28 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E2Cdn-00082n-4t; Mon, 08 Aug 2005 22:46:27 +0400
Received: by procyon.home (Postfix, from userid 500)
	id C0690E51111; Mon,  8 Aug 2005 22:45:36 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050808184332.GA5789@procyon.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Plug memory leak in write_sha1_to_fd()

If the object to write was packed, both its uncompressed and compressed
data were leaked.  If the object was not packed, its file was not unmapped.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 sha1_file.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

683b9e4bb090c115242392a1f1dc7b1a7c76c4be
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1297,8 +1297,11 @@ int write_sha1_to_fd(int fd, const unsig
 	ssize_t size;
 	unsigned long objsize;
 	int posn = 0;
-	void *buf = map_sha1_file_internal(sha1, &objsize);
+	void *map = map_sha1_file_internal(sha1, &objsize);
+	void *buf = map;
+	void *temp_obj = NULL;
 	z_stream stream;
+
 	if (!buf) {
 		unsigned char *unpacked;
 		unsigned long len;
@@ -1314,7 +1317,7 @@ int write_sha1_to_fd(int fd, const unsig
 		memset(&stream, 0, sizeof(stream));
 		deflateInit(&stream, Z_BEST_COMPRESSION);
 		size = deflateBound(&stream, len + hdrlen);
-		buf = xmalloc(size);
+		temp_obj = buf = xmalloc(size);
 
 		/* Compress it */
 		stream.next_out = buf;
@@ -1332,6 +1335,7 @@ int write_sha1_to_fd(int fd, const unsig
 		while (deflate(&stream, Z_FINISH) == Z_OK)
 			/* nothing */;
 		deflateEnd(&stream);
+		free(unpacked);
 		
 		objsize = stream.total_out;
 	}
@@ -1348,6 +1352,12 @@ int write_sha1_to_fd(int fd, const unsig
 		}
 		posn += size;
 	} while (posn < objsize);
+
+	if (map)
+		munmap(map, objsize);
+	if (temp_obj)
+		free(temp_obj);
+
 	return 0;
 }
 
