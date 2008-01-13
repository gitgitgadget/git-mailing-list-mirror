From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 1/3] Convert compress helpers to use an extended z_stream
Date: Sun, 13 Jan 2008 14:24:36 +0100
Message-ID: <1200230678-18188-1-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 14:25:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE2qT-0001OI-Qs
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 14:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYAMNZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 08:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYAMNZS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 08:25:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:1748 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbYAMNZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 08:25:16 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1860514fga.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 05:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=dmGkM8rgeSctmVPUZMHc4jUG/fb+uSdJ/Jj82/ObcHk=;
        b=JHxDTG+S4RfBMWtc782Q5+s1l2tC6N/1JLNnjgMvTT8fMp8+X0l+lktEGObYKS3Ej4AzzFs/8OpuoPN2ucktJU4j9ws5ry6lnUuy2K9GyTMUtg+Durix4UdZfzkfdZrDydxDeX6hQq4Qqj8T+IG4FdzCKm3/B8JAMkmQSG4DyEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sIYmwakrImLT97GmDP39TlZlnsnjoyK7p21ZUxEdyFY/vKvTq/NP10YDsLCT5nAFi5GKsVlnlBRrWa9Dl8/FqLx1efvv8Mk6rJzJq4iBxJbNO6m4vh59qWjE+gcuyZLabQ8LSzlxX6iuWfz01yKIC3gxFxD7uuRPwGfDTBOQLQo=
Received: by 10.86.77.5 with SMTP id z5mr5116867fga.41.1200230714300;
        Sun, 13 Jan 2008 05:25:14 -0800 (PST)
Received: from localhost.localdomain ( [151.70.79.87])
        by mx.google.com with ESMTPS id g11sm3987662gve.15.2008.01.13.05.25.11
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 05:25:13 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.98.g58cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70382>

Instead of passing as argument to compress/decompress
helpers the zlib native z_stream create a new extended
one called ext_stream and use this instead.

This will allow us to associate the specified compress
algorithm on a 'per stream' base.

The patch aims to be as less intrusive as possible
so that ext_stream is really a (slightly) extended
z_stream and includes a z_stream member.

Choice to use a z_stream variable instead of a z_stream*
pointer as member is to avoid a xmalloc when a local
ext_stream variable is used.

This patch just introduces ext_stream and modifies the
helpers to cope with that. Next patch will rename z_stream
to ext_stream across the sources. Tough this patch will
not compile without the next I splitted the two for easing
the review: the interesting part is here, the next is
just renaming.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

The patch series apply above my last one sent yesterday.

This patch series is intended more as a RFC then to
be applied.

While the previous series introduced a cleanup, this one
extends the compress/decompress helpers framwork to support
different compress backends.

The compress backends are associated to each z_stream, it means
I can have multiple z_stream working with different backends at
the same time.

The rationale for this low level link instead of setting the chosen
comrpess library, say, at repository level, is that pulling/pushing
packs on the net must continue to work with zlib so to not break
things and also that, as Junio pointed out, today we don't
unpackage and repackage the objects that arrive with a git-pull,
but store the incoming pack as is.

So we can have different packs compressed with different backends
in the same repo. To allow this the compression algorithm info should
be linked at the z_stream level. Note that this is _almost_ trasparent
to the user.


Finally this is the first patch series sent with send-mail, so to try
to overcome the lines wrapping damage of my mailer.

BTW it took more time to setup send-mail and send the patches then to
write them! ;-)


 compress.c |   64 ++++++++++++++++++++++++++++++------------------------------
 compress.h |   52 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/compress.c b/compress.c
index f73cf2c..b28c389 100644
--- a/compress.c
+++ b/compress.c
@@ -5,46 +5,46 @@
  *     Compression helpers
  */
 
-unsigned long compress_alloc(z_stream *stream, int level, unsigned long size)
+unsigned long compress_alloc(ext_stream *stream, int level, unsigned long size)
 {
 	memset(stream, 0, sizeof(*stream));
-	deflateInit(stream, level);
-	return deflateBound(stream, size);
+	deflateInit(&stream->z, level);
+	return deflateBound(&stream->z, size);
 }
 
-int compress_start(z_stream *stream,
+int compress_start(ext_stream *stream,
                    unsigned char *in, unsigned long in_size,
                    unsigned char *out, unsigned long out_size)
 {
-	stream->next_out = out;
-	stream->avail_out = out_size;
-	stream->next_in = in;
-	stream->avail_in = in_size;
+	stream->z.next_out = out;
+	stream->z.avail_out = out_size;
+	stream->z.next_in = in;
+	stream->z.avail_in = in_size;
 	return Z_OK;
 }
 
-int compress_next(z_stream *stream, int flush)
+int compress_next(ext_stream *stream, int flush)
 {
 	int result;
 
 	do {
-		result = deflate(stream, flush);
+		result = deflate(&stream->z, flush);
 	} while (result == Z_OK);
 
 	return result;
 }
 
-unsigned long compress_free(z_stream *stream)
+unsigned long compress_free(ext_stream *stream)
 {
-	deflateEnd(stream);
-	return stream->total_out;
+	deflateEnd(&stream->z);
+	return stream->z.total_out;
 }
 
 unsigned long compress_all(int level, unsigned char *in,
                            unsigned long in_size, unsigned char **out)
 {
 	unsigned long out_size;
-	z_stream stream;
+	ext_stream stream;
 
 	out_size = compress_alloc(&stream, level, in_size);
 	*out = xmalloc(out_size);
@@ -65,47 +65,47 @@ unsigned long compress_all(int level, unsigned char *in,
  *     Decompression helpers
  */
 
-int decompress_alloc(z_stream *stream)
+int decompress_alloc(ext_stream *stream)
 {
 	memset(stream, 0, sizeof(*stream));
-	return inflateInit(stream);
+	return inflateInit(&stream->z);
 }
 
-int decompress_from(z_stream *stream, unsigned char *in, unsigned long in_size)
+int decompress_from(ext_stream *stream, unsigned char *in, unsigned long in_size)
 {
-	stream->next_in = in;
-	stream->avail_in = in_size;
+	stream->z.next_in = in;
+	stream->z.avail_in = in_size;
 	return Z_OK;
 }
 
-int decompress_into(z_stream *stream, unsigned char *out, unsigned long out_size)
+int decompress_into(ext_stream *stream, unsigned char *out, unsigned long out_size)
 {
-	stream->next_out = out;
-	stream->avail_out = out_size;
+	stream->z.next_out = out;
+	stream->z.avail_out = out_size;
 	return Z_OK;
 }
 
-int decompress_next(z_stream *stream, int flush)
+int decompress_next(ext_stream *stream, int flush)
 {
-	return inflate(stream, flush);
+	return inflate(&stream->z, flush);
 }
 
-int decompress_next_from(z_stream *stream, unsigned char *in, unsigned long in_size, int flush)
+int decompress_next_from(ext_stream *stream, unsigned char *in, unsigned long in_size, int flush)
 {
 	decompress_from(stream, in, in_size);
-	return inflate(stream, flush);
+	return inflate(&stream->z, flush);
 }
 
-int decompress_next_into(z_stream *stream, unsigned char *out, unsigned long out_size, int flush)
+int decompress_next_into(ext_stream *stream, unsigned char *out, unsigned long out_size, int flush)
 {
 	decompress_into(stream, out, out_size);
-	return inflate(stream, flush);
+	return inflate(&stream->z, flush);
 }
 
-unsigned long decompress_free(z_stream *stream)
+unsigned long decompress_free(ext_stream *stream)
 {
-	inflateEnd(stream);
-	return stream->total_out;
+	inflateEnd(&stream->z);
+	return stream->z.total_out;
 }
 
 unsigned long decompress_all(unsigned char *in, unsigned long in_size,
@@ -113,7 +113,7 @@ unsigned long decompress_all(unsigned char *in, unsigned long in_size,
 {
 /* caller should check for return value != 0 */
 
-	z_stream stream;
+	ext_stream stream;
 	int st;
 
 	if (decompress_alloc(&stream) != Z_OK)
diff --git a/compress.h b/compress.h
index a81d006..d1de31f 100644
--- a/compress.h
+++ b/compress.h
@@ -1,25 +1,55 @@
 #ifndef COMPRESS_H
 #define COMPRESS_H
 
-extern unsigned long compress_alloc(z_stream *stream, int level, unsigned long size);
-extern int compress_start(z_stream *stream, unsigned char *in, unsigned long in_size,
+/* Any compress/decompress engine must implement all the
+ * below functions that are modeled after the zlib ones.
+ */
+typedef int (*deflateInit_fn_t)(z_stream *stream, int level);
+typedef int (*deflate_fn_t)(z_stream *stream, int flush);
+typedef int (*deflateEnd_fn_t)(z_stream *stream);
+typedef unsigned long (*deflateBound_fn_t)(z_stream *stream, unsigned long size);
+
+typedef int (*inflateInit_fn_t)(z_stream *stream);
+typedef int (*inflate_fn_t)(z_stream *stream, int flush);
+typedef int (*inflateEnd_fn_t)(z_stream *stream);
+
+
+/* Extended struct used instead of the zlib native to
+ * call the compress/decompress helpers. It's just a
+ * thin extension of the zlib native one.
+ */
+typedef struct ext_stream_s {
+	z_stream z; /* defined in zlib.h to store stream state */
+
+	/* pointers to low level compress library functions */
+	deflateInit_fn_t  deflateInit_fn;
+	deflate_fn_t      deflate_fn;
+	deflateEnd_fn_t   deflateEnd_fn;
+	deflateBound_fn_t deflateBound_fn;
+	inflateInit_fn_t  inflateInit_fn;
+	inflate_fn_t      inflate_fn;
+	inflateEnd_fn_t   inflateEnd_fn;
+} ext_stream;
+
+extern unsigned long compress_alloc(ext_stream *stream, int level, unsigned long size);
+extern int compress_start(ext_stream *stream, unsigned char *in, unsigned long in_size,
                            unsigned char *out, unsigned long out_size);
-extern int compress_next(z_stream *stream, int flush);
-extern unsigned long compress_free(z_stream *stream);
+extern int compress_next(ext_stream *stream, int flush);
+extern unsigned long compress_free(ext_stream *stream);
 extern unsigned long compress_all(int level, unsigned char *in, unsigned long in_size,
                                   unsigned char **out);
 
 
-extern int decompress_alloc(z_stream *stream);
+extern int decompress_alloc(ext_stream *stream);
 
-extern int decompress_from(z_stream *stream, unsigned char *in, unsigned long in_size);
-extern int decompress_into(z_stream *stream, unsigned char *out, unsigned long out_size);
+extern int decompress_from(ext_stream *stream, unsigned char *in, unsigned long in_size);
+extern int decompress_into(ext_stream *stream, unsigned char *out, unsigned long out_size);
 
-extern int decompress_next(z_stream *stream, int flush);
-extern int decompress_next_from(z_stream *stream, unsigned char *in, unsigned long in_size, int flush);
-extern int decompress_next_into(z_stream *stream, unsigned char *out, unsigned long out_size, int flush);
+extern int decompress_next(ext_stream *stream, int flush);
+extern int decompress_next_from(ext_stream *stream, unsigned char *in, unsigned long in_size, int flush);
+extern int decompress_next_into(ext_stream *stream, unsigned char *out, unsigned long out_size, int flush);
 
-extern unsigned long decompress_free(z_stream *stream);
+extern unsigned long decompress_free(ext_stream *stream);
 
 extern unsigned long decompress_all(unsigned char *in, unsigned long in_size,
                                     unsigned char *out, unsigned long out_size);
-- 
1.5.4.rc2.98.g58cd2
