From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 1/5] Add zlib decompress helper functions
Date: Thu, 10 Jan 2008 22:04:46 +0100
Message-ID: <e5bfff550801101304m4f0b97baua6553c45772793b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4az-0006QN-TG
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbYAJVEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbYAJVEs
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:04:48 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:48408 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYAJVEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:04:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so701371rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=j4BF49gJAVTkrsMVhUM0V/Y2jG1/wjlPmo+/hXmRImo=;
        b=gAK83O/JAn1KQfH5aSa+D3y5t2zK/jTr8nXmv3psEC2qbXgExrH0bi6W+ijhwme1qmXeH0ttvW8nNhVVRFh/sGuHAfB/sjGLJvufbHawdbL3qOcQ9s9b1aSsHnzf+jvEGIXPKg6ycgNrHLlGGum3VpwVkNVpbQ+XO0QH7o1JWfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bu6ZEOivESU+pmjwOXOF+09esPiFQurVwPBFzm5Dvr2TDOJBA0F7iIt4srlbDMDswwRkvoVa4fvAyd16GzxijtpP/tVmcYakVnFM6CmLn4SpaMUE154uB8x5ngkA5RLuJ1AYOOC2bIPkt9Na+EEEy1skEfePyKT3qL8/7VUFbzg=
Received: by 10.140.180.13 with SMTP id c13mr1503821rvf.153.1199999086178;
        Thu, 10 Jan 2008 13:04:46 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 13:04:46 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70087>

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
 compress.c |   52 ++++++++++++++++++++++++++
 compress.h |   14 ++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 compress.c
 create mode 100644 compress.h

diff --git a/Makefile b/Makefile
index 21c80e6..89bd99d 100644
--- a/Makefile
+++ b/Makefile
@@ -288,7 +288,7 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a

 LIB_H = \
-	archive.h blob.h cache.h cache-tree.h commit.h csum-file.h delta.h grep.h \
+	archive.h blob.h cache.h cache-tree.h commit.h compress.h
csum-file.h delta.h grep.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
@@ -301,7 +301,7 @@ DIFF_OBJS = \
 	diffcore-delta.o log-tree.o

 LIB_OBJS = \
-	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
+	blob.o commit.o compress.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o \
 	pretty.o interpolate.o hash.o \
 	lockfile.o \
diff --git a/compress.c b/compress.c
new file mode 100644
index 0000000..f40e09c
--- /dev/null
+++ b/compress.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "compress.h"
+
+unsigned long z_deflate_init(z_stream *stream, int level, unsigned long size)
+{
+	memset(stream, 0, sizeof(*stream));
+	deflateInit(stream, level);
+	return deflateBound(stream, size);
+}
+
+int z_deflate_start(z_stream *stream, unsigned char *in, unsigned long in_size,
+                    unsigned char *out, unsigned long out_size)
+{
+	stream->next_out = (out ? out : xmalloc(out_size));
+	stream->avail_out = out_size;
+	stream->next_in = in;
+	stream->avail_in = in_size;
+	return Z_OK;
+}
+
+int z_deflate_next(z_stream *stream, int flush)
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
+unsigned long z_deflate_all(int level, unsigned char *data,
+                            unsigned long size, unsigned char **out)
+{
+	int bound, result;
+	z_stream stream;
+
+	bound = z_deflate_init(&stream, level, size);
+	z_deflate_start(&stream, data, size, NULL, bound);
+
+	*out = stream.next_out;
+	result = z_deflate_next(&stream, Z_FINISH);
+
+	if (result != Z_STREAM_END) {
+		deflateEnd(&stream);
+		free(*out);
+		*out = NULL;
+		return 0;
+	}
+	deflateEnd(&stream);
+	return stream.total_out;
+}
diff --git a/compress.h b/compress.h
new file mode 100644
index 0000000..926450c
--- /dev/null
+++ b/compress.h
@@ -0,0 +1,14 @@
+#ifndef COMPRESS_H
+#define COMPRESS_H
+
+extern unsigned long z_deflate_init(z_stream *stream, int level,
unsigned long size);
+
+extern int z_deflate_start(z_stream *stream, unsigned char *in,
unsigned long in_size,
+                           unsigned char *out, unsigned long out_size);
+
+extern int z_deflate_next(z_stream *stream, int flush);
+
+extern unsigned long z_deflate_all(int level, unsigned char *data,
+                                   unsigned long size, unsigned char **out);
+
+#endif
-- 
1.5.4.rc2.89.g1b3f
