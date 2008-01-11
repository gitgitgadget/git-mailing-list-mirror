From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 1/5] Introduce stream compress helpers (v2 and complete)
Date: Fri, 11 Jan 2008 08:35:45 +0100
Message-ID: <e5bfff550801102335j2681b9c6p8eca731c7df2bc67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:36:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDER6-0006pX-E9
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbYAKHft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYAKHfs
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:35:48 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:34167 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbYAKHfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:35:47 -0500
Received: by rv-out-0910.google.com with SMTP id k20so850608rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=XNZT1pNNYaerWPMdZdc1JJQvuXjy92mGbYEPO3oH+Uo=;
        b=GyIbI4I6/OZdDvHQERYIYlUyZdqKvlfp6Qf1hdtEhG6q2Ih1wLmzSj6Vu3eoNZ64NVqvFWwqB+DpAESwa+yEPhP6f7rGOs3H/Ypu3/BajU5E7d8t5RFibWVWU70dCCPOiORgbOSDqecdHMdQ+JvfOoCU+scStNhuhRcoXj3KPwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Le+dCGlQk2xfvCooz6OhpxYrSzDoYPEHwJdY+YcwDZ3oenx/PpptOJKIWGNSlO37oPMwAvowQU/ovGbXYw4LThZLXM3pXcdQJTnFcTu2bvS3hiWpnOsmUEplxD3sbj3kLnrhHRhgCIMBcwIVRl4SXIc8Gre3kQEBAERyU8UGpkc=
Received: by 10.141.20.7 with SMTP id x7mr1799754rvi.82.1200036945077;
        Thu, 10 Jan 2008 23:35:45 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 23:35:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70129>

When decompressing a zlib stream use this
helpers instead of calling low level zlib
function.

This patch introduces the necessary framework,
still no code change.

This is the first step in generalizing compress and
decompress functions avoiding zlib directly calls.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This is the full compress cleanup series, no more open coded
zlib compress calls are around anymore

New in this version is:

- Renaming according to Linus suggestions
- Added of a compress_free() that seems to suit nicely
- git is zlib compress functions free now


Next step will be decompress helpers


 Makefile   |    4 ++--
 compress.c |   58 ++++++++++++++++++++++++++++++++++++
 compress.h |   12 ++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
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
index 0000000..be771a9
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
index 0000000..16b0147
--- /dev/null
+++ b/compress.h
@@ -0,0 +1,12 @@
+#ifndef COMPRESS_H
+#define COMPRESS_H
+
+extern unsigned long compress_alloc(z_stream *stream, int level,
unsigned long size);
+extern int compress_start(z_stream *stream, unsigned char *in,
unsigned long in_size,
+                           unsigned char *out, unsigned long out_size);
+extern int compress_next(z_stream *stream, int flush);
+extern unsigned long compress_free(z_stream *stream);
+extern unsigned long compress_all(int level, unsigned char *data,
unsigned long size,
+                                  unsigned char **out);
+
+#endif
-- 
1.5.4.rc2.89.g1b3f-dirty
