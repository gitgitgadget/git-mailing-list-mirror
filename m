From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 3/3] Abstract out zlib
Date: Sun, 13 Jan 2008 14:24:38 +0100
Message-ID: <1200230678-18188-3-git-send-email-mcostalba@gmail.com>
References: <1200230678-18188-1-git-send-email-mcostalba@gmail.com>
 <1200230678-18188-2-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 14:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE2qV-0001OI-Ic
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 14:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYAMNZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 08:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYAMNZX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 08:25:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:1748 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbYAMNZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 08:25:20 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1860514fga.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 05:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=34jdoDfxq6PLpaVbDsSMXKpiA/9eyUnBlhm++xO1z5Q=;
        b=flMqLqlKXg+cAWA7KUCBc2KpPYUcU9h/EccflJcJIz82cRgjtwdAhs2daoLwPugxr8q8yUKoFfhSweYR8+aMdpLoVFDtfN9yYMKDvlsOgrSiqro8YV8p+yg0s+mw4TqVpcmBIoAshV0U57Zo48fBM3vewCncG0wOcKMlbZAT88I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eB136jEjqJyH4i4tnsyps8ztYDEu8GjWwJEF11yI0s/9wRR36bXol7FOXQVcdrsae5n8DqadiCIqnxsuVbLbBURiRroGXsgPY9+MVaCHoN/7x4FnRHuZ8w3KGQKWnZSiE/EAZVpK7tCsU8ps3eT38V2m0ctixV0ObT6z6hKe1OY=
Received: by 10.86.26.11 with SMTP id 11mr5124546fgz.37.1200230719417;
        Sun, 13 Jan 2008 05:25:19 -0800 (PST)
Received: from localhost.localdomain ( [151.70.79.87])
        by mx.google.com with ESMTPS id g11sm3987662gve.15.2008.01.13.05.25.17
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 05:25:18 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.98.g58cd2
In-Reply-To: <1200230678-18188-2-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70381>

Finally remove the hardcoded link between
compression helpers and zlib.

Association bewteen a stream and the compression library
is done at stream init time through a set of function
pointers. Library choice is based on compression level
parameter passed to compress_alloc(), this allow us to
stay 100% back compatible with current code.

Patch also adds the the necessary zlib engine plugin,
this turns out to be trivial since we have modeled
everything around zlib.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 compress.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 compress.h |    6 ++++++
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/compress.c b/compress.c
index b28c389..09a5df0 100644
--- a/compress.c
+++ b/compress.c
@@ -1,6 +1,41 @@
 #include "cache.h"
 #include "compress.h"
 
+/* Default zlib engine plugin definition
+ *
+ * Because everything is modeled after zlib the
+ * corresponding engine wrappers here are trivial
+ */
+static int zlib_deflateInit(z_stream *s, int l) { return deflateInit(s, l); }
+static int zlib_deflate(z_stream *s, int f) { return deflate(s, f); }
+static int zlib_deflateEnd(z_stream *s) { return deflateEnd(s); }
+static unsigned long zlib_deflateBound(z_stream *s, unsigned long sz) { return deflateBound(s, sz); }
+
+static int zlib_inflateInit(z_stream *s) { return inflateInit(s); }
+static int zlib_inflate(z_stream *s, int f) { return inflate(s, f); }
+static int zlib_inflateEnd(z_stream *s) { return inflateEnd(s); }
+
+
+/* link the stream to the compression library functions */
+static int register_engine(ext_stream *stream, int level)
+{
+	switch (level) {
+	case LZO_COMPRESSION:
+		die ("LZO compression still not implemented");
+		break;
+	default: /* assumed to be zlib */
+		stream->deflateInit_fn  = zlib_deflateInit;
+		stream->deflate_fn      = zlib_deflate;
+		stream->deflateEnd_fn   = zlib_deflateEnd;
+		stream->deflateBound_fn = zlib_deflateBound;
+		stream->inflateInit_fn  = zlib_inflateInit;
+		stream->inflate_fn      = zlib_inflate;
+		stream->inflateEnd_fn   = zlib_inflateEnd;
+		break;
+	};
+	return Z_OK;
+}
+
 /*
  *     Compression helpers
  */
@@ -8,8 +43,9 @@
 unsigned long compress_alloc(ext_stream *stream, int level, unsigned long size)
 {
 	memset(stream, 0, sizeof(*stream));
-	deflateInit(&stream->z, level);
-	return deflateBound(&stream->z, size);
+	register_engine(stream, level);
+	stream->deflateInit_fn(&stream->z, level);
+	return stream->deflateBound_fn(&stream->z, size);
 }
 
 int compress_start(ext_stream *stream,
@@ -28,7 +64,7 @@ int compress_next(ext_stream *stream, int flush)
 	int result;
 
 	do {
-		result = deflate(&stream->z, flush);
+		result = stream->deflate_fn(&stream->z, flush);
 	} while (result == Z_OK);
 
 	return result;
@@ -36,7 +72,7 @@ int compress_next(ext_stream *stream, int flush)
 
 unsigned long compress_free(ext_stream *stream)
 {
-	deflateEnd(&stream->z);
+	stream->deflateEnd_fn(&stream->z);
 	return stream->z.total_out;
 }
 
@@ -68,7 +104,8 @@ unsigned long compress_all(int level, unsigned char *in,
 int decompress_alloc(ext_stream *stream)
 {
 	memset(stream, 0, sizeof(*stream));
-	return inflateInit(&stream->z);
+	register_engine(stream, Z_DEFAULT_COMPRESSION); // FIXME for now zlib assumed
+	return stream->inflateInit_fn(&stream->z);
 }
 
 int decompress_from(ext_stream *stream, unsigned char *in, unsigned long in_size)
@@ -87,24 +124,24 @@ int decompress_into(ext_stream *stream, unsigned char *out, unsigned long out_si
 
 int decompress_next(ext_stream *stream, int flush)
 {
-	return inflate(&stream->z, flush);
+	return stream->inflate_fn(&stream->z, flush);
 }
 
 int decompress_next_from(ext_stream *stream, unsigned char *in, unsigned long in_size, int flush)
 {
 	decompress_from(stream, in, in_size);
-	return inflate(&stream->z, flush);
+	return stream->inflate_fn(&stream->z, flush);
 }
 
 int decompress_next_into(ext_stream *stream, unsigned char *out, unsigned long out_size, int flush)
 {
 	decompress_into(stream, out, out_size);
-	return inflate(&stream->z, flush);
+	return stream->inflate_fn(&stream->z, flush);
 }
 
 unsigned long decompress_free(ext_stream *stream)
 {
-	inflateEnd(&stream->z);
+	stream->inflateEnd_fn(&stream->z);
 	return stream->z.total_out;
 }
 
diff --git a/compress.h b/compress.h
index d1de31f..151234a 100644
--- a/compress.h
+++ b/compress.h
@@ -1,6 +1,12 @@
 #ifndef COMPRESS_H
 #define COMPRESS_H
 
+/* Add here custom compression levels. First 0-9
+ * and -1 are reserved values used by zlib
+ */
+#define LZO_COMPRESSION 99
+
+
 /* Any compress/decompress engine must implement all the
  * below functions that are modeled after the zlib ones.
  */
-- 
1.5.4.rc2.98.g58cd2
