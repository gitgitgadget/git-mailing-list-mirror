From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 10/11] Convert builtin-pack/unpack
Date: Sat,  2 Feb 2008 12:35:55 +0100
Message-ID: <1201952156-6764-10-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-6-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-7-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-8-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-9-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:38:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGhm-0000Z5-IE
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877AbYBBLhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756768AbYBBLhS
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:37:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbYBBLhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:37:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=z29f5IuJwcUMqab2u4VmID3Zm51nnAugYv/v/BOZcBU=;
        b=FlnSXg6eyjBR+/9atTqHYYVC7MtrpsIG7/zXKx6NT9RSlYNHW2EQtBVENHgbS75hthL0aDRN9KMp9Qvm+kpoi5gqdRRMqaFVabIisBzJwieVwNxA4yxSX3P5/RKyXJeim0aJHYELKNSPOnZRRvybY2dDvsveypsDvc0I7yN0164=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YELWiwX7sPW3rJWbyODUB1N46TLz3isG3GZvpVGmg5C7q5NdBT4db71UCgCSHrtSKa5F8sYnW/lWPu90FrVilCZ+84a/QrKtEkQjbimgYn2d/f7ES+Ig8GqVxUetb1RYOvAoQ3+IRfvWnwfee4jPVd+56MPbQ6OFKQ3kFMG6o/w=
Received: by 10.86.82.16 with SMTP id f16mr4251897fgb.60.1201952220365;
        Sat, 02 Feb 2008 03:37:00 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.58
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:59 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-9-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72267>

In this case decompression helper conversion is
quite similar and not too complex, so they go
togheter.

Also in index-pack.c pass correct arguments
to decompress_next_from().

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-pack-objects.c   |   14 ++++++--------
 builtin-unpack-objects.c |   22 +++++++++-------------
 index-pack.c             |    4 +++-
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 991a30f..43614ce 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -302,19 +302,17 @@ static int check_pack_inflate(struct packed_git *p,
 {
 	z_stream stream;
 	unsigned char fakebuf[4096], *in;
+	unsigned int in_size = 0;
 	int st;
 
-	memset(&stream, 0, sizeof(stream));
-	inflateInit(&stream);
+	decompress_alloc(&stream);
 	do {
-		in = use_pack(p, w_curs, offset, &stream.avail_in);
-		stream.next_in = in;
-		stream.next_out = fakebuf;
-		stream.avail_out = sizeof(fakebuf);
-		st = inflate(&stream, Z_FINISH);
+		decompress_into(&stream, fakebuf, sizeof(fakebuf));
+		in = use_pack(p, w_curs, offset, &in_size);
+		st = decompress_next_from(&stream, in, in_size, Z_FINISH);
 		offset += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	return (st == Z_STREAM_END &&
 		stream.total_out == expect &&
 		stream.total_in == len) ? 0 : -1;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 1e51865..c996560 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "compress.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
@@ -61,23 +62,20 @@ static void use(int bytes)
 static void *get_data(unsigned long size)
 {
 	z_stream stream;
-	void *buf = xmalloc(size);
+	unsigned char *buf = xmalloc(size);;
 
-	memset(&stream, 0, sizeof(stream));
-
-	stream.next_out = buf;
-	stream.avail_out = size;
-	stream.next_in = fill(1);
-	stream.avail_in = len;
-	inflateInit(&stream);
+	decompress_alloc(&stream);
+	decompress_into(&stream, buf, size);
 
 	for (;;) {
-		int ret = inflate(&stream, 0);
+		/* fill() modifies len, so be sure is evaluated as first */
+		void* tmp = fill(1);
+		int ret = decompress_next_from(&stream, tmp, len, Z_NO_FLUSH);
 		use(len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK) {
-			error("inflate returned %d\n", ret);
+			error("decompress returned %d\n", ret);
 			free(buf);
 			buf = NULL;
 			if (!recover)
@@ -85,10 +83,8 @@ static void *get_data(unsigned long size)
 			has_errors = 1;
 			break;
 		}
-		stream.next_in = fill(1);
-		stream.avail_in = len;
 	}
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	return buf;
 }
 
diff --git a/index-pack.c b/index-pack.c
index 30d7837..929de39 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -173,7 +173,9 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 	decompress_into(&stream, buf, size);
 
 	for (;;) {
-		int ret = decompress_next_from(&stream, fill(1), input_len, Z_NO_FLUSH);
+		/* fill() modifies len, so be sure is evaluated as first */
+		void* tmp = fill(1);
+		int ret = decompress_next_from(&stream, tmp, input_len, Z_NO_FLUSH);
 		use(input_len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
-- 
1.5.4.rc4.39.g524a
