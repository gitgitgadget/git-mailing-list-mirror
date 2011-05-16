From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/11] streaming: a new API to read from the object store
Date: Sun, 15 May 2011 17:30:26 -0700
Message-ID: <1305505831-31587-7-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLli2-00047D-Aw
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab1EPAat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab1EPAar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98E8B5F89
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lp6w
	JuwTIyB9P/C5dDXZnCfhnB0=; b=to49kBD3wMMbgd1UtKtqefyM3TfmxGugTwGv
	FSFh9DSjsCOvUpaccYw3GNM7eA90ih15vaWwRmUjP6a2Z9LdYZC6EHuoGbJCspNy
	k0VY9Z6vj1Y23lzPVgtebkKYa6fUrccGiu/RJMPcgzsNlgbECa4AESuL2f8VxTYk
	f1XtE/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=yTcep+
	QbTsAgZ0+O7i+5c3ZKp1EU8uYHWetj/gJAlYOiBBznQdqWA98K2S9Ol+JyF0Wkf1
	5xl6sVOMGxA3L4nQjVeBy84rFLH49xr75UBQk6CMnmSWm3ZsYh1T47kqy9zgeebA
	QmqEotmVneo8ZSS4dHJ7iVdYKD4o4GRcR/oAg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94D0E5F88
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB94A5F83 for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:32:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0A251A10-7F54-11E0-B1EE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173684>

Given an object name, use open_istream() to get a git_istream handle
that you can read_istream() from as if you are using read(2) to read
the contents of the object, and close it with close_istream() when
you are done.

Currently, we do not do anything fancy--it just calls read_sha1_file()
and keeps the contents in memory as a whole, and carve it out as you
request with read_istream().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile    |    2 +
 streaming.c |  196 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 streaming.h |   12 ++++
 3 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 streaming.c
 create mode 100644 streaming.h

diff --git a/Makefile b/Makefile
index 320ccc7..83bd539 100644
--- a/Makefile
+++ b/Makefile
@@ -552,6 +552,7 @@ LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
 LIB_H += strbuf.h
+LIB_H += streaming.h
 LIB_H += string-list.h
 LIB_H += submodule.h
 LIB_H += tag.h
@@ -657,6 +658,7 @@ LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += strbuf.o
+LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
diff --git a/streaming.c b/streaming.c
new file mode 100644
index 0000000..e03a374
--- /dev/null
+++ b/streaming.c
@@ -0,0 +1,196 @@
+#include "cache.h"
+#include "streaming.h"
+
+enum input_source {
+	stream_error = -1,
+	incore = 0,
+	loose = 1,
+	pack_non_delta = 2
+};
+
+typedef int (*open_istream_fn)(struct git_istream *,
+			       struct object_info *, const unsigned char *,
+			       enum object_type *, unsigned long *);
+typedef int (*close_istream_fn)(struct git_istream *);
+typedef ssize_t (*read_istream_fn)(struct git_istream *, char *, size_t);
+
+struct stream_vtbl {
+	close_istream_fn close;
+	read_istream_fn read;
+};
+
+#define open_method_decl(name) \
+	int open_istream_ ##name \
+	(struct git_istream *st, struct object_info *oi, \
+	 const unsigned char *sha1, \
+	 enum object_type *type, unsigned long *sz)
+
+#define close_method_decl(name) \
+	int close_istream_ ##name \
+	(struct git_istream *st)
+
+#define read_method_decl(name) \
+	ssize_t read_istream_ ##name \
+	(struct git_istream *st, char *buf, size_t sz)
+
+/* forward declaration */
+static open_method_decl(incore);
+static open_method_decl(loose);
+static open_method_decl(pack_non_delta);
+
+static open_istream_fn open_istream_tbl[] = {
+	open_istream_incore,
+	open_istream_loose,
+	open_istream_pack_non_delta,
+};
+
+struct git_istream {
+	enum input_source source;
+	const struct stream_vtbl *vtbl;
+	union {
+		struct {
+			char *buf; /* from read_object() */
+			unsigned long sz;
+			unsigned long read_ptr;
+		} incore;
+
+		struct {
+			int fd; /* open for reading */
+			/* NEEDSWORK: what else? */
+		} loose;
+
+		struct {
+			int fd; /* open for reading */
+			/* NEEDSWORK: what else? */
+		} in_pack;
+	} u;
+};
+
+int close_istream(struct git_istream *st)
+{
+	return st->vtbl->close(st);
+}
+
+ssize_t read_istream(struct git_istream *st, char *buf, size_t sz)
+{
+	return st->vtbl->read(st, buf, sz);
+}
+
+static enum input_source istream_source(const unsigned char *sha1,
+					enum object_type *type,
+					struct object_info *oi)
+{
+	unsigned long size;
+	int status;
+
+	oi->sizep = &size;
+	oi->want_deltainfo = 1;
+
+	status = sha1_object_info_extended(sha1, oi);
+	if (status < 0)
+		return stream_error;
+	*type = status;
+
+	switch (oi->whence) {
+	case OI_LOOSE:
+		return loose;
+	case OI_PACKED:
+		if (!oi->u.packed.delta && big_file_threshold <= size)
+			return pack_non_delta;
+		/* fallthru */
+	default:
+		return incore;
+	}
+}
+
+struct git_istream *open_istream(const unsigned char *sha1,
+				 enum object_type *type,
+				 unsigned long *sz)
+{
+	struct git_istream *st;
+	struct object_info oi;
+	const unsigned char *real = lookup_replace_object(sha1);
+	enum input_source src = istream_source(real, type, &oi);
+
+	if (src < 0)
+		return NULL;
+
+	st = xmalloc(sizeof(*st));
+	st->source = src;
+	if (open_istream_tbl[src](st, &oi, real, type, sz)) {
+		if (open_istream_incore(st, &oi, real, type, sz)) {
+			free(st);
+			st = NULL;
+		}
+	}
+	return st;
+}
+
+/*****************************************************************
+ *
+ * Loose object stream
+ *
+ *****************************************************************/
+
+static open_method_decl(loose)
+{
+	return -1; /* for now */
+}
+
+
+/*****************************************************************
+ *
+ * Non-delta packed object stream
+ *
+ *****************************************************************/
+
+static open_method_decl(pack_non_delta)
+{
+	return -1; /* for now */
+}
+
+
+/*****************************************************************
+ *
+ * In-core stream
+ *
+ *****************************************************************/
+
+static close_method_decl(incore)
+{
+	free(st->u.incore.buf);
+	return 0;
+}
+
+static read_method_decl(incore)
+{
+	size_t read_size = sz;
+	size_t remainder = st->u.incore.sz - st->u.incore.read_ptr;
+
+	if (remainder <= read_size)
+		read_size = remainder;
+	if (read_size) {
+		memcpy(buf, st->u.incore.buf + st->u.incore.read_ptr, read_size);
+		st->u.incore.read_ptr += read_size;
+	}
+	return read_size;
+}
+
+static struct stream_vtbl incore_vtbl = {
+	close_istream_incore,
+	read_istream_incore,
+};
+
+static open_method_decl(incore)
+{
+	st->u.incore.buf = read_sha1_file_extended(sha1, type, sz, 0);
+	st->u.incore.read_ptr = 0;
+	st->u.incore.sz = *sz;
+	st->vtbl = &incore_vtbl;
+
+	if (!st->u.incore.buf) {
+		free(st->u.incore.buf);
+		return -1;
+	}
+	return 0;
+}
diff --git a/streaming.h b/streaming.h
new file mode 100644
index 0000000..dff5e19
--- /dev/null
+++ b/streaming.h
@@ -0,0 +1,12 @@
+#ifndef STREAMING_H
+#define STREAMING_H 1
+#include "cache.h"
+
+/* opaque */
+struct git_istream;
+
+extern struct git_istream *open_istream(const unsigned char *, enum object_type *, unsigned long *);
+extern int close_istream(struct git_istream *);
+extern ssize_t read_istream(struct git_istream *, char *, size_t);
+
+#endif /* STREAMING_H */
-- 
1.7.5.1.365.g32b65
