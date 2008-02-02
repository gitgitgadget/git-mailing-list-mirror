From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 08/11] Use new decompress_all() helper in git
Date: Sat,  2 Feb 2008 12:35:53 +0100
Message-ID: <1201952156-6764-8-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-6-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-7-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:38:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGhl-0000Z5-8G
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbYBBLhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756578AbYBBLhL
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:37:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313AbYBBLg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R0iU27Laj9DwEouLui26Gk0ELkIK3tSfuW0ecCwXv50=;
        b=AQGnebWQk9LrFXAwi+uRhl7++U51j0cmiXpqVJzhbqxRfWLoLTamrOnZYeyGCve9VSooqbYIHuDKAzR5BSpynlv96zAi5JoZbfTzTIiaJEviLLeTNkS0AKYwNcmheeBTBxcjECpqa47q1RbpyKRGPUV+D03Amk10smNhTLFySAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iKOxBOc7j7XeanFiDZlq5K+LfvM7ORCBO570IzpZ2tZpVYt7nKMkYtDcvWNCskgOUywn3ih9tmLnxo4+u9iR783tJS+OLhPoVlqUs/1Avu8NsY8t4Hs/xevOI5DINVwff4v6PiUAESPU9n7vj+kQuxuYZXFM93QaeQPD0b5zp+I=
Received: by 10.86.1.1 with SMTP id 1mr4292340fga.2.1201952216325;
        Sat, 02 Feb 2008 03:36:56 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.54
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:55 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-7-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72271>

Only in two places is possible to really simplify
deflate code with the all_in_one decompress_all()

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-apply.c |   23 +++++++++--------------
 index-pack.c    |   30 +++++++-----------------------
 2 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 30d86f2..fa589e6 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -8,6 +8,7 @@
  */
 #include "cache.h"
 #include "cache-tree.h"
+#include "compress.h"
 #include "quote.h"
 #include "blob.h"
 #include "delta.h"
@@ -1105,23 +1106,17 @@ static inline int metadata_changes(struct patch *patch)
 static char *inflate_it(const void *data, unsigned long size,
 			unsigned long inflated_size)
 {
-	z_stream stream;
-	void *out;
-	int st;
+	unsigned char *out;
+	unsigned long out_size;
 
-	memset(&stream, 0, sizeof(stream));
+	out = xmalloc(inflated_size);
+	out_size = decompress_all((unsigned char *)data, size, out, inflated_size);
 
-	stream.next_in = (unsigned char *)data;
-	stream.avail_in = size;
-	stream.next_out = out = xmalloc(inflated_size);
-	stream.avail_out = inflated_size;
-	inflateInit(&stream);
-	st = inflate(&stream, Z_FINISH);
-	if ((st != Z_STREAM_END) || stream.total_out != inflated_size) {
+	if (out_size != inflated_size) {
 		free(out);
 		return NULL;
 	}
-	return out;
+	return (char *)out;
 }
 
 static struct fragment *parse_binary_hunk(char **buf_p,
diff --git a/index-pack.c b/index-pack.c
index 880088e..30d7837 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -169,24 +169,18 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 	z_stream stream;
 	void *buf = xmalloc(size);
 
-	memset(&stream, 0, sizeof(stream));
-	stream.next_out = buf;
-	stream.avail_out = size;
-	stream.next_in = fill(1);
-	stream.avail_in = input_len;
-	inflateInit(&stream);
+	decompress_alloc(&stream);
+	decompress_into(&stream, buf, size);
 
 	for (;;) {
-		int ret = inflate(&stream, 0);
+		int ret = decompress_next_from(&stream, fill(1), input_len, Z_NO_FLUSH);
 		use(input_len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK)
-			bad_object(offset, "inflate returned %d", ret);
-		stream.next_in = fill(1);
-		stream.avail_in = input_len;
+			bad_object(offset, "decompress returned %d", ret);
 	}
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	return buf;
 }
 
@@ -261,8 +255,6 @@ static void *get_data_from_pack(struct object_entry *obj)
 	unsigned long len = obj[1].idx.offset - from;
 	unsigned long rdy = 0;
 	unsigned char *src, *data;
-	z_stream stream;
-	int st;
 
 	src = xmalloc(len);
 	data = src;
@@ -273,16 +265,8 @@ static void *get_data_from_pack(struct object_entry *obj)
 		rdy += n;
 	} while (rdy < len);
 	data = xmalloc(obj->size);
-	memset(&stream, 0, sizeof(stream));
-	stream.next_out = data;
-	stream.avail_out = obj->size;
-	stream.next_in = src;
-	stream.avail_in = len;
-	inflateInit(&stream);
-	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
-	inflateEnd(&stream);
-	if (st != Z_STREAM_END || stream.total_out != obj->size)
-		die("serious inflate inconsistency");
+	if (decompress_all(src, len, data, obj->size) != obj->size)
+		die("serious decompress inconsistency");
 	free(src);
 	return data;
 }
-- 
1.5.4.rc4.39.g524a
