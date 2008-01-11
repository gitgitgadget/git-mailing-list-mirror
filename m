From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 2/6] Introduce stream decompress helpers
Date: Fri, 11 Jan 2008 19:55:01 +0100
Message-ID: <e5bfff550801111055tae555c0sd666ddd05cee472d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:55:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP2U-0001yZ-D8
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760647AbYAKSzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758517AbYAKSzG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:55:06 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:31025 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbYAKSzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:55:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1020835rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 10:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=njb58H955TZ/lx3bctK5bcWxuBs9jwtZqZf8gwMo2GI=;
        b=FgrCUKQryFt/HbMRObldCvNxbc88gNwGVZxSu/M+kUb8JNMwZ9dxUiaB0NY9UHNC23ixd3HA34bE1GGdyVJYKrexUMDtRDUV6fuYEDdmJTK9yt0aSPqLtNX7Oh3WKe9mbiV6q3yn0LhI77SiPX6joJD4PyRXM2P/kfB9UI+Qzi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=xGdavBTk/EMPn+3wR6muHBo1agPZM+XD+BTTSqsgPY3uKZX+prZVg02RJrdL+qoPT1pT2W1PyJuTGzeYxZRreIRRhlgVwTaKd8NMtUCB7ShkmGyRyXTyjZjuIVQrIaEuaAIo3qyMtqXrIKxc0CPopJ3uSvJGBrw6vQtCTxbBpik=
Received: by 10.140.132.8 with SMTP id f8mr2207267rvd.198.1200077701141;
        Fri, 11 Jan 2008 10:55:01 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 10:55:01 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70186>

Decompressing turns out to be more difficult then
comrpessing.

Helpers are more because more are the way
zlib deflate() is used in git.

This patch just introduces the helpers,
still no code change.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This patch will probably be wrapped at the bottom lines
by the mailer (gmail), sorry in advance for this.

 compress.c |   81 ++++++++++++++++++++++++++++++++
 compress.h |   17 ++++++++++++-
 2 files changed, 97 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index a8f46d5..f73cf2c 100644
--- a/compress.c
+++ b/compress.c
@@ -1,6 +1,10 @@
 #include "cache.h"
 #include "compress.h"

+/*
+ *     Compression helpers
+ */
+
 unsigned long compress_alloc(z_stream *stream, int level, unsigned long size)
 {
 	memset(stream, 0, sizeof(*stream));
@@ -55,3 +59,80 @@ unsigned long compress_all(int level, unsigned
 	}
 	return compress_free(&stream);
 }
+
+
+/*
+ *     Decompression helpers
+ */
+
+int decompress_alloc(z_stream *stream)
+{
+	memset(stream, 0, sizeof(*stream));
+	return inflateInit(stream);
+}
+
+int decompress_from(z_stream *stream, unsigned char *in, unsigned long in_size)
+{
+	stream->next_in = in;
+	stream->avail_in = in_size;
+	return Z_OK;
+}
+
+int decompress_into(z_stream *stream, unsigned char *out, unsigned
long out_size)
+{
+	stream->next_out = out;
+	stream->avail_out = out_size;
+	return Z_OK;
+}
+
+int decompress_next(z_stream *stream, int flush)
+{
+	return inflate(stream, flush);
+}
+
+int decompress_next_from(z_stream *stream, unsigned char *in,
unsigned long in_size, int flush)
+{
+	decompress_from(stream, in, in_size);
+	return inflate(stream, flush);
+}
+
+int decompress_next_into(z_stream *stream, unsigned char *out,
unsigned long out_size, int flush)
+{
+	decompress_into(stream, out, out_size);
+	return inflate(stream, flush);
+}
+
+unsigned long decompress_free(z_stream *stream)
+{
+	inflateEnd(stream);
+	return stream->total_out;
+}
+
+unsigned long decompress_all(unsigned char *in, unsigned long in_size,
+                             unsigned char *out, unsigned long out_size)
+{
+/* caller should check for return value != 0 */
+
+	z_stream stream;
+	int st;
+
+	if (decompress_alloc(&stream) != Z_OK)
+		return 0;
+
+	if (   decompress_from(&stream, in, in_size) != Z_OK
+	    || decompress_into(&stream, out, out_size) != Z_OK)
+		goto fail;
+
+	do {
+		st = decompress_next(&stream, Z_FINISH);
+	} while (st == Z_OK);
+
+	if (st != Z_STREAM_END)
+		goto fail;
+
+	return decompress_free(&stream);
+
+fail:
+	decompress_free(&stream);
+	return 0;
+}
diff --git a/compress.h b/compress.h
index 16b0147..a81d006 100644
--- a/compress.h
+++ b/compress.h
@@ -6,7 +6,22 @@ extern int compress_start(z_stream *stream, unsigned char *in,
                            unsigned char *out, unsigned long out_size);
 extern int compress_next(z_stream *stream, int flush);
 extern unsigned long compress_free(z_stream *stream);
-extern unsigned long compress_all(int level, unsigned char *data,
unsigned long size,
+extern unsigned long compress_all(int level, unsigned char *in,
unsigned long in_size,
                                   unsigned char **out);

+
+extern int decompress_alloc(z_stream *stream);
+
+extern int decompress_from(z_stream *stream, unsigned char *in,
unsigned long in_size);
+extern int decompress_into(z_stream *stream, unsigned char *out,
unsigned long out_size);
+
+extern int decompress_next(z_stream *stream, int flush);
+extern int decompress_next_from(z_stream *stream, unsigned char *in,
unsigned long in_size, int flush);
+extern int decompress_next_into(z_stream *stream, unsigned char *out,
unsigned long out_size, int flush);
+
+extern unsigned long decompress_free(z_stream *stream);
+
+extern unsigned long decompress_all(unsigned char *in, unsigned long in_size,
+                                    unsigned char *out, unsigned long
out_size);
+
 #endif
-- 
1.5.4.rc2.90.gf158-dirty
