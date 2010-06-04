From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] Add memory pool library
Date: Fri,  4 Jun 2010 15:41:06 +0200
Message-ID: <1275658871-1473-2-git-send-email-artagnon@gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:40:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKX80-0005cL-B5
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab0FDNjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:39:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:30837 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab0FDNjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:39:48 -0400
Received: by ey-out-2122.google.com with SMTP id 25so102964eya.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ERqLA3deU4ZLU3skxClpVdIdDyhrCDZmLr6VIkOKBv8=;
        b=oq2RYB/V/OP2gnP5JEMxGx56+qiCyD7tEu5Heq6lwBQzEbyBe8EpQNedC+WTElq9SX
         dszxslgXoh1FtjI8OzTvFrL46Tke/aYP9E8/aY6zq7kT0afl3kPbh2YlCy8UOrEaeRBz
         BDgvmlWkQeyhEAvq+56bVsT0OVFIxKLFJ5lEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lcWT4tFdBTWqzhEBQ1rHUxss2Qv5aCHIYizlKHhYt6mNHxBrbthghgi0S8ltHOp5eJ
         kt7/qyYLj8CVSlkX3uWuw5lZLvXQy2LNjC//4+rGXS8BCsTH9h5zZOINW7xbIBiIapFw
         /4PgvfpYjgStmOglQMrzi8l2oybEaPqj9Vebk=
Received: by 10.213.34.77 with SMTP id k13mr7915337ebd.88.1275658786365;
        Fri, 04 Jun 2010 06:39:46 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm740155ewy.14.2010.06.04.06.39.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:39:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148410>

From: David Barr <david.barr@cordelta.com>

Add a memory pool library implemented using cpp macros. The library
provides macros that can be used to create a type-specific memory pool
API.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/obj_pool.h |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/obj_pool.h

diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
new file mode 100644
index 0000000..84c8321
--- /dev/null
+++ b/vcs-svn/obj_pool.h
@@ -0,0 +1,98 @@
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
+	uint32_t size; \
+	uint32_t capacity; \
+	obj_t *base; \
+        FILE *file; \
+} pre##_pool = { 0, 0, NULL, NULL}; \
+static void pre##_init(void) \
+{ \
+	struct stat st; \
+	size_t ps = sysconf (_SC_PAGESIZE); \
+	/* Touch binary file before opening read/write */ \
+	pre##_pool.file = fopen(#pre ".bin", "a"); \
+	fclose(pre##_pool.file); \
+	/* Open, check size, compute capacity */ \
+	pre##_pool.file = fopen(#pre ".bin", "r+"); \
+	fstat(fileno(pre##_pool.file), &st); \
+	pre##_pool.size = st.st_size / sizeof(obj_t); \
+	pre##_pool.capacity = ((st.st_size + ps - 1) & ~(ps - 1)) / sizeof(obj_t); \
+	if (pre##_pool.capacity < initial_capacity) \
+		pre##_pool.capacity = initial_capacity; \
+	/* Truncate to calculated capacity and map to VM */ \
+	ftruncate(fileno(pre##_pool.file), pre##_pool.capacity * sizeof(obj_t)); \
+	pre##_pool.base = mmap(0, pre##_pool.capacity * sizeof(obj_t), \
+				PROT_READ | PROT_WRITE, MAP_SHARED, \
+				fileno(pre##_pool.file), 0); \
+} \
+static uint32_t pre##_alloc(uint32_t count) \
+{ \
+	uint32_t offset; \
+	if (pre##_pool.size + count > pre##_pool.capacity) { \
+		if (NULL == pre##_pool.base) \
+			pre##_init(); \
+		fsync(fileno(pre##_pool.file)); \
+		munmap(pre##_pool.base, \
+			pre##_pool.capacity * sizeof(obj_t)); \
+		pre##_pool.base = NULL; \
+		while (pre##_pool.size + count > pre##_pool.capacity) \
+			if (pre##_pool.capacity) \
+				pre##_pool.capacity *= 2; \
+			else \
+				pre##_pool.capacity = initial_capacity; \
+		ftruncate(fileno(pre##_pool.file), \
+				pre##_pool.capacity * sizeof(obj_t)); \
+		pre##_pool.base = \
+			mmap(0, pre##_pool.capacity * sizeof(obj_t), \
+				PROT_READ | PROT_WRITE, MAP_SHARED, \
+				fileno(pre##_pool.file), 0); \
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
+static void pre##_reset(void) \
+{ \
+	if (pre##_pool.base) { \
+		fsync(fileno(pre##_pool.file)); \
+		munmap(pre##_pool.base, \
+			pre##_pool.capacity * sizeof(obj_t)); \
+		ftruncate(fileno(pre##_pool.file), \
+				pre##_pool.size * sizeof(obj_t)); \
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
