From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] Add memory pool library
Date: Thu, 10 Jun 2010 15:09:44 +0200
Message-ID: <1276175389-6185-2-git-send-email-artagnon@gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 15:09:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhVf-0002fq-HH
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 15:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab0FJNI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 09:08:59 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:61012 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0FJNI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 09:08:57 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so80476ewy.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=frwfCn3Q5ybABA1A4y9case5PGV4dUjJG7dqOrLuHs4=;
        b=xPDgcJPBpuVs9IhyjossMLCuDUDCD6FTS4fHeT7zhmOVzxVzVG8HTo9+mvzU3Mffts
         PJNRlrOA7PzsVhZ0Ku60xkNDYDI9UJGJ52Y1b+5oETSFObvxHRSe8iG60JUQs+CmZa4E
         jd9pbCs8Oh+KA2PkpTxMgK3xRPQ+yYCP/e/1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wpzGgOiGuZEMIo0WEKTv0EurFy/rWY0zTnyK3Kg/fGnAVqmtLZR42DGl30lIw59d6w
         SBXtRDsx87KhG/7r5xh7Ps4k2cmjwO412URliOquN0VeeRoQ2d8z+V6YfoA7I3yHSd7+
         xBDTsDc3/CgrRaIaeAKtMsMA3zA+/bCVaK5Ns=
Received: by 10.213.11.12 with SMTP id r12mr2299601ebr.57.1276175336270;
        Thu, 10 Jun 2010 06:08:56 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm4824218ewy.2.2010.06.10.06.08.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 06:08:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148867>

From: David Barr <david.barr@cordelta.com>

Add a memory pool library implemented using cpp macros. The library
provides macros that can be used to create a type-specific memory pool
API.

The memory pool library is distinguished from the existing specialized
allocators in alloc.c by using a contiguous block for all allocations.
This means that on one hand, long-lived pointers have to be written as
offsets, since the base address changes as the pool grows, but on the
other hand, the entire pool can be easily written to the file system.
This allows the memory pool to persist between runs of an application.

For svn-fe, such a facility is useful because each svn revision can
copy trees and files from any previous revision.  Therefore the
relevant information for all revisions has to persist somehow to
support incremental runs.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/obj_pool.h |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/obj_pool.h

diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
new file mode 100644
index 0000000..29417b3
--- /dev/null
+++ b/vcs-svn/obj_pool.h
@@ -0,0 +1,90 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#ifndef OBJ_POOL_H_
+#define OBJ_POOL_H_
+
+#include "git-compat-util.h"
+
+/*
+ * The obj_pool_gen() macro generates a type-specific memory pool
+ * implementation.
+ *
+ * Arguments:
+ *
+ *   pre              : Prefix for generated functions (ex: string_).
+ *   obj_t            : Type for treap data structure (ex: char).
+ *   intial_capacity  : The initial size of the memory pool (ex: 4096).
+ *
+ */
+#define obj_pool_gen(pre, obj_t, initial_capacity) \
+static struct { \
+	uint32_t committed; \
+	uint32_t size; \
+	uint32_t capacity; \
+	obj_t *base; \
+	FILE *file; \
+} pre##_pool = { 0, 0, 0, NULL, NULL}; \
+static void pre##_init(void) \
+{ \
+	struct stat st; \
+	pre##_pool.file = fopen(#pre ".bin", "a+"); \
+	rewind(pre##_pool.file); \
+	fstat(fileno(pre##_pool.file), &st); \
+	pre##_pool.size = st.st_size / sizeof(obj_t); \
+	pre##_pool.committed = pre##_pool.size; \
+	pre##_pool.capacity = pre##_pool.size * 2; \
+	if (pre##_pool.capacity < initial_capacity) \
+		pre##_pool.capacity = initial_capacity; \
+	pre##_pool.base = malloc(pre##_pool.capacity * sizeof(obj_t)); \
+	fread(pre##_pool.base, sizeof(obj_t), pre##_pool.size, pre##_pool.file); \
+} \
+static uint32_t pre##_alloc(uint32_t count) \
+{ \
+	uint32_t offset; \
+	if (pre##_pool.size + count > pre##_pool.capacity) { \
+		while (pre##_pool.size + count > pre##_pool.capacity) \
+			if (pre##_pool.capacity) \
+				pre##_pool.capacity *= 2; \
+			else \
+				pre##_pool.capacity = initial_capacity; \
+		pre##_pool.base = realloc(pre##_pool.base, \
+					pre##_pool.capacity * sizeof(obj_t)); \
+	} \
+	offset = pre##_pool.size; \
+	pre##_pool.size += count; \
+	return offset; \
+} \
+static void pre##_free(uint32_t count) \
+{ \
+	pre##_pool.size -= count; \
+} \
+static uint32_t pre##_offset(obj_t *obj) \
+{ \
+	return obj == NULL ? ~0 : obj - pre##_pool.base; \
+} \
+static obj_t *pre##_pointer(uint32_t offset) \
+{ \
+	return offset >= pre##_pool.size ? NULL : &pre##_pool.base[offset]; \
+} \
+static void pre##_commit(void) \
+{ \
+	pre##_pool.committed += fwrite(pre##_pool.base + pre##_pool.committed, \
+		sizeof(obj_t), pre##_pool.size - pre##_pool.committed, \
+		pre##_pool.file); \
+} \
+static void pre##_reset(void) \
+{ \
+	if (pre##_pool.base) { \
+		free(pre##_pool.base); \
+		fclose(pre##_pool.file); \
+	} \
+	pre##_pool.base = NULL; \
+	pre##_pool.size = 0; \
+	pre##_pool.capacity = 0; \
+	pre##_pool.file = NULL; \
+}
+
+#endif
-- 
1.7.1
