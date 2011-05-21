From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/12] streaming: a new API to read from the object store
Date: Fri, 20 May 2011 23:56:29 -0700
Message-ID: <1305960995-25738-7-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg82-0006Cg-6X
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab1EUG5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:57:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1EUG53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:57:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD4265DC4
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wBBQ
	k+AssabSw19cCcKdaDEf40k=; b=FdCqYjn/46Ib9Tg6ONPSPN7lZL5ZAi3BRp62
	6sZvel/8GMMiSviupzDOcb+3gpyrpwEctnuUsD45OSJr9HTwDoelGVg00pE/rv+A
	OjI5qLugbZbVfAURbhY+Sc5YcQ4/yLO/vsbJKx2R+FkWE6j75eV4ATreyQ8ErstW
	ch3FDcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=d9igp+
	MiLoz5mkdVhP+8x8yYaD3FBLcpb+z/XXPq9+U4hxtoDaUOCxiAhpBW/S25LYMFxk
	/Fb5qkhxxwkuyKQoO+jm2+uWbeoLFa+jYxNSDhEEwe6RLk3ZV6DcwRkX3MGDDdLZ
	3NudWC+2RyUD6dybP0YKuKSRTAtEWZeTg1qVw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C950D5DC3
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B36D45DC2 for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:59:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E335931C-8377-11E0-9DC1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174100>

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
 streaming.c |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 streaming.h |   15 +++++
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
index 0000000..13cbce7
--- /dev/null
+++ b/streaming.c
@@ -0,0 +1,193 @@
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
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
+			       struct object_info *,
+			       const unsigned char *,
+			       enum object_type *);
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
+	 enum object_type *type)
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
+	const struct stream_vtbl *vtbl;
+	unsigned long size; /* inflated size of full object */
+
+	union {
+		struct {
+			char *buf; /* from read_object() */
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
+	status = sha1_object_info_extended(sha1, oi);
+	if (status < 0)
+		return stream_error;
+	*type = status;
+
+	switch (oi->whence) {
+	case OI_LOOSE:
+		return loose;
+	case OI_PACKED:
+		if (!oi->u.packed.is_delta && big_file_threshold <= size)
+			return pack_non_delta;
+		/* fallthru */
+	default:
+		return incore;
+	}
+}
+
+struct git_istream *open_istream(const unsigned char *sha1,
+				 enum object_type *type,
+				 unsigned long *size)
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
+	if (open_istream_tbl[src](st, &oi, real, type)) {
+		if (open_istream_incore(st, &oi, real, type)) {
+			free(st);
+			return NULL;
+		}
+	}
+	*size = st->size;
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
+	size_t remainder = st->size - st->u.incore.read_ptr;
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
+	st->u.incore.buf = read_sha1_file_extended(sha1, type, &st->size, 0);
+	st->u.incore.read_ptr = 0;
+	st->vtbl = &incore_vtbl;
+
+	return st->u.incore.buf ? 0 : -1;
+}
diff --git a/streaming.h b/streaming.h
new file mode 100644
index 0000000..18cbe68
--- /dev/null
+++ b/streaming.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
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
1.7.5.2.369.g8fc017
