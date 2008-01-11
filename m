From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 3/6] Use new decompress_all() helper in git
Date: Fri, 11 Jan 2008 19:56:17 +0100
Message-ID: <e5bfff550801111056v3b214442sf21e7eb6cc4da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP3f-0002Ok-4T
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761268AbYAKS4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761244AbYAKS4T
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:56:19 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:34218 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761201AbYAKS4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:56:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1021169rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 10:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vzjoQEWFjnW51XYdLiNKKjqQVxv7ekwvVXdfJGzVkDQ=;
        b=nfMfVZThd9Y+j2Di7CEPbImjYVah0MthrDXUeegbL8euN2QvkNmqdsYKDYjr4SE2b3HlWuGD5lGLTjnJd6V4Hsmwr9DcIJHWXG8LmG7GczFeJsx92SxEWqae6ZXq9R/CB7p4edlo8pLqAawfRtqlEDkNMtN7xtRzoU9MeTJadqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oXNoiPo3PRX1MGr33ZG0TtnC88+i5zi2TXw9fluE5a8csAf8GYRda/FfwKG0hIeTD2KS4I+FXthEjRfDGEbvc/4cTGPhF0bwT6V/yolfM74yDDZCxSQ2ucj26cTWHDrt6v0pFDlgl6eqWudbuDn5CEBQDNXAIUxJbrfmbesevn0=
Received: by 10.140.164.1 with SMTP id m1mr2222141rve.69.1200077777384;
        Fri, 11 Jan 2008 10:56:17 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 10:56:17 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70187>

Only in two places is possible to really simplify
deflate code with the all_in_one decompress_all()

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-apply.c |   23 +++++++++--------------
 index-pack.c    |   30 +++++++-----------------------
 2 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index d57bb6e..6dd2b8c 100644
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
@@ -1105,23 +1106,17 @@ static inline int metadata_changes(struct
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
@@ -169,24 +169,18 @@ static void *unpack_entry_data(unsigned long offset,
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

@@ -261,8 +255,6 @@ static void *get_data_from_pack(struct object_entry
 	unsigned long len = obj[1].idx.offset - from;
 	unsigned long rdy = 0;
 	unsigned char *src, *data;
-	z_stream stream;
-	int st;

 	src = xmalloc(len);
 	data = src;
@@ -273,16 +265,8 @@ static void *get_data_from_pack(struct object_entry
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
1.5.4.rc2.90.gf158-dirty
