From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 07/11] Introduce stream decompress helpers
Date: Sat,  2 Feb 2008 12:35:52 +0100
Message-ID: <1201952156-6764-7-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-6-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:38:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGhk-0000Z5-In
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbYBBLhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756664AbYBBLhH
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:37:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273AbYBBLgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:54 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EL1OxN2sdRtwR+oURLkowhZISfQQ6TBQJifJJS7ncZY=;
        b=FHlNqK1PmwjmjRzThLd/cqrMNV6u0JvyT7gLl3Bqu5FOiV1DOcju9FVfUH0hvnBXJET6ontpCg2wrqsyf9FtPLvh3yeRxC1/AbSyhkk+IPM9munOQNEYzgTmdusWLExsjiYEv/cM8loHnm/4/dv8eY73yBOw/HQWPtzyoFYFSPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hny2F2KJu/stb5/in5neExzxhClpF7H26mSh+PuBJxjch+bBwH1PYueVxrewxCX9BRhdPQQfR1/ycsSXXT3TCLdq0/rdeBSLbD6Li+19dzwzohAnBuRBmep7KBHTjEFajzh9fVALMsrLlffOSQ+OEnr6i7xA7kyY41gvgZKPrLI=
Received: by 10.86.84.5 with SMTP id h5mr4260627fgb.49.1201952214198;
        Sat, 02 Feb 2008 03:36:54 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.52
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:53 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-6-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72272>

Decompressing turns out to be more difficult then
comrpessing.

Helpers are more because more are the way
zlib deflate() is used in git.

This patch just introduces the helpers,
still no code change.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 compress.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 compress.h |   17 ++++++++++++-
 2 files changed, 97 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index 0d0b9d9..cf9d5ca 100644
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
@@ -55,3 +59,80 @@ unsigned long compress_all(int level, unsigned char *in,
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
+int decompress_into(z_stream *stream, unsigned char *out, unsigned long out_size)
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
+int decompress_next_from(z_stream *stream, unsigned char *in, unsigned long in_size, int flush)
+{
+	decompress_from(stream, in, in_size);
+	return inflate(stream, flush);
+}
+
+int decompress_next_into(z_stream *stream, unsigned char *out, unsigned long out_size, int flush)
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
index d73c365..30cc80f 100644
--- a/compress.h
+++ b/compress.h
@@ -6,7 +6,22 @@ extern int compress_start(z_stream *stream, unsigned char *in, unsigned long in_
                            unsigned char *out, unsigned long out_size);
 extern int compress_next(z_stream *stream, int flush);
 extern unsigned long compress_free(z_stream *stream);
-extern unsigned long compress_all(int level, unsigned char *data, unsigned long size,
+extern unsigned long compress_all(int level, unsigned char *in, unsigned long in_size,
                                   unsigned char **out);
 
+
+extern int decompress_alloc(z_stream *stream);
+
+extern int decompress_from(z_stream *stream, unsigned char *in, unsigned long in_size);
+extern int decompress_into(z_stream *stream, unsigned char *out, unsigned long out_size);
+
+extern int decompress_next(z_stream *stream, int flush);
+extern int decompress_next_from(z_stream *stream, unsigned char *in, unsigned long in_size, int flush);
+extern int decompress_next_into(z_stream *stream, unsigned char *out, unsigned long out_size, int flush);
+
+extern unsigned long decompress_free(z_stream *stream);
+
+extern unsigned long decompress_all(unsigned char *in, unsigned long in_size,
+                                    unsigned char *out, unsigned long out_size);
+
 #endif
-- 
1.5.4.rc4.39.g524a
