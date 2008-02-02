From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 01/11] Introduce stream compress helpers
Date: Sat,  2 Feb 2008 12:35:46 +0100
Message-ID: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:37:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGgZ-0000Gr-Ld
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbYBBLgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbYBBLgn
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:36:43 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYBBLgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:42 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=9j3wkmQ3yBzl5+vPxfrHMWWbus5g18IaKeFIbL/N30g=;
        b=C6oFjJkZVO2bI2JpVJ95OCrzsJxN6gjsy8hbUj+qEDNPuPZQEHGpuhHzedN3Po4gigfwcQOQcywpalDD4mKycybED4NyBIzPGZY5gDY5mUczrve6IRWl0KjlGDvEpdUqzPdXSt+FFM31VHilZiU/eWNHJykY2eWC99vd1NqeI1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l24T6VsrmVNkOroUacFMIfJjCqb56RiZVkFlbPBR0zxv1rKQ8LtMvOYIjDtkPlnbDFgd/2lfiADjQvb/uV2k6+J3QBi8V4NwFJMHpE6O3vd/H/lso+iV49aF9TLENPftRWyWsgTEYSigHAA/ONcg10LEaacrvGtCtnNGjVnqggg=
Received: by 10.86.95.20 with SMTP id s20mr644905fgb.6.1201952200577;
        Sat, 02 Feb 2008 03:36:40 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.38
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:39 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72262>

When decompressing a zlib stream use this
helpers instead of calling low level zlib
function.

This patch introduces the necessary framework,
still no code change.

This is the first step in generalizing compress and
decompress functions avoiding zlib directly calls.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 Makefile   |    4 ++--
 compress.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 compress.h |   12 ++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 compress.c
 create mode 100644 compress.h

diff --git a/Makefile b/Makefile
index 91a460f..f70f995 100644
--- a/Makefile
+++ b/Makefile
@@ -292,7 +292,7 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
-	archive.h blob.h cache.h cache-tree.h commit.h csum-file.h delta.h grep.h \
+	archive.h blob.h cache.h cache-tree.h commit.h compress.h csum-file.h delta.h grep.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
@@ -305,7 +305,7 @@ DIFF_OBJS = \
 	diffcore-delta.o log-tree.o
 
 LIB_OBJS = \
-	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
+	blob.o commit.o compress.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o \
 	pretty.o interpolate.o hash.o \
 	lockfile.o \
diff --git a/compress.c b/compress.c
new file mode 100644
index 0000000..f6986c3
--- /dev/null
+++ b/compress.c
@@ -0,0 +1,58 @@
+#include "cache.h"
+#include "compress.h"
+
+unsigned long compress_alloc(z_stream *stream, int level, unsigned long size)
+{
+	memset(stream, 0, sizeof(*stream));
+	deflateInit(stream, level);
+	return deflateBound(stream, size);
+}
+
+int compress_start(z_stream *stream,
+                   unsigned char *in, unsigned long in_size,
+                   unsigned char *out, unsigned long out_size)
+{
+	stream->next_out = (out ? out : xmalloc(out_size));
+	stream->avail_out = out_size;
+	stream->next_in = in;
+	stream->avail_in = in_size;
+	return Z_OK;
+}
+
+int compress_next(z_stream *stream, int flush)
+{
+	int result;
+
+	do {
+		result = deflate(stream, flush);
+	} while (result == Z_OK);
+
+	return result;
+}
+
+unsigned long compress_free(z_stream *stream)
+{
+	deflateEnd(stream);
+	return stream->total_out;
+}
+
+unsigned long compress_all(int level, unsigned char *data,
+                           unsigned long size, unsigned char **out)
+{
+	int bound, result;
+	z_stream stream;
+
+	bound = compress_alloc(&stream, level, size);
+	compress_start(&stream, data, size, NULL, bound);
+
+	*out = stream.next_out;
+	result = compress_next(&stream, Z_FINISH);
+
+	if (result != Z_STREAM_END) {
+		compress_free(&stream);
+		free(*out);
+		*out = NULL;
+		return 0;
+	}
+	return compress_free(&stream);
+}
diff --git a/compress.h b/compress.h
new file mode 100644
index 0000000..d73c365
--- /dev/null
+++ b/compress.h
@@ -0,0 +1,12 @@
+#ifndef COMPRESS_H
+#define COMPRESS_H
+
+extern unsigned long compress_alloc(z_stream *stream, int level, unsigned long size);
+extern int compress_start(z_stream *stream, unsigned char *in, unsigned long in_size,
+                           unsigned char *out, unsigned long out_size);
+extern int compress_next(z_stream *stream, int flush);
+extern unsigned long compress_free(z_stream *stream);
+extern unsigned long compress_all(int level, unsigned char *data, unsigned long size,
+                                  unsigned char **out);
+
+#endif
-- 
1.5.4.rc4.39.g524a
