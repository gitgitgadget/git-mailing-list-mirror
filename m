From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] Add a memory pool library
Date: Sun, 23 May 2010 23:40:29 +0200
Message-ID: <1274650832-7411-5-git-send-email-artagnon@gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 23 23:39:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGItO-0004R9-LV
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab0EWVjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:39:21 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55476 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab0EWVjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:39:18 -0400
Received: by mail-ww0-f46.google.com with SMTP id 15so108108wwe.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=r8wofR0BoA5zciyM4JzgB+mIqRD+3lhq95SDm19xv0w=;
        b=kN461LmnQD/Z0Ldufkx8+SlzFvQWq1WKzUD8k9Tn4dkVc+VCrLnenFJ5vnfb1uXvEn
         Au5lVGPETmuP0GPvlIB/qGKwZEj+VYcOKHz4SqkUzhV/Z9HvJbuwAS/Ld2pL2NHhf4k5
         NScMtBQu62O47+q3biMEn8d25EqlpZ70su3gI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K///lQ4Ju90XSdy0q8m4Gded/Oq/btPbhTAK14xlzv5aazBp5MJf9K62AzldefmdJb
         ujLoXI6lWKWB+pKTYSVcJPOfSXOcyfFezlNj/TPOyePB3BQBhQkJ7LShqLYixwjM17A2
         WK7ahpTR0aNg6EUK67Xf9Dc5xR4M8SmLuF+UE=
Received: by 10.227.154.147 with SMTP id o19mr4462105wbw.112.1274650757472;
        Sun, 23 May 2010 14:39:17 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm1631990ewy.10.2010.05.23.14.39.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 14:39:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147589>

Add a memory pool library implemented using cpp macros. The macro can
be used to create a type-specific memory pool API. The memory nodes
themselves are stored in a treap, using macros in trp.h. Taken
directly from David Michael Barr's svn-dump-fast-export repository.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/obj_pool.h |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/obj_pool.h

diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
new file mode 100644
index 0000000..d8b0842
--- /dev/null
+++ b/vcs-svn/obj_pool.h
@@ -0,0 +1,61 @@
+#ifndef OBJ_POOL_H_
+#define OBJ_POOL_H_
+
+#include <stdint.h>
+#include <stdlib.h>
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
+#define obj_pool_gen(pre, obj_t, initial_capacity)                         \
+static struct {                                                            \
+    uint32_t size;                                                         \
+    uint32_t capacity;                                                     \
+    obj_t *base;                                                           \
+} pre##_pool = { 0, 0, NULL};                                              \
+static uint32_t pre##_alloc(uint32_t count)                                \
+{                                                                          \
+    uint32_t offset;                                                       \
+    while (pre##_pool.size + count > pre##_pool.capacity) {                \
+        if (pre##_pool.capacity) {                                         \
+            pre##_pool.capacity *= 2;                                      \
+        } else {                                                           \
+            pre##_pool.capacity = initial_capacity;                        \
+        }                                                                  \
+        pre##_pool.base =                                                  \
+            realloc(pre##_pool.base, pre##_pool.capacity * sizeof(obj_t)); \
+    }                                                                      \
+    offset = pre##_pool.size;                                              \
+    pre##_pool.size += count;                                              \
+    return offset;                                                         \
+}                                                                          \
+static void pre##_free(uint32_t count)                                     \
+{                                                                          \
+    pre##_pool.size -= count;                                              \
+}                                                                          \
+static uint32_t pre##_offset(obj_t *obj)                                   \
+{                                                                          \
+    return obj == NULL ? ~0 : obj - pre##_pool.base;                       \
+}                                                                          \
+static obj_t *pre##_pointer(uint32_t offset)                               \
+{                                                                          \
+    return offset >= pre##_pool.size ? NULL : &pre##_pool.base[offset];    \
+}                                                                          \
+static void pre##_reset(void)                                              \
+{                                                                          \
+    if (pre##_pool.base)                                                   \
+        free(pre##_pool.base);                                             \
+    pre##_pool.base = NULL;                                                \
+    pre##_pool.size = 0;                                                   \
+    pre##_pool.capacity = 0;                                               \
+}                                                                          \
+
+#endif
-- 
1.7.1
