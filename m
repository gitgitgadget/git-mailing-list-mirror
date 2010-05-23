From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] Add API for string-specific memory pool
Date: Sun, 23 May 2010 23:40:30 +0200
Message-ID: <1274650832-7411-6-git-send-email-artagnon@gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 23 23:39:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGItP-0004R9-HF
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab0EWVj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:39:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44125 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352Ab0EWVjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:39:20 -0400
Received: by mail-wy0-f174.google.com with SMTP id 29so1098079wyb.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Rl5Rxn3GKA5rBnpPyUGoBzmgjfBtG7tVQzSDQNfFe/A=;
        b=qUh0eGTjWJefi8p4BhdB9Bhobwsou8td9hFbQFLfvx8lrNfbIUl9zjSQrvWIGzTLdE
         rVv51MB/l1gSdBZVOrVl0ONSXQ9FUxil2NR3Y6kqwbW//Q1D+VaScp9wDr/jIx/u1q+u
         9EPGzDNgDqigx+Nmx0aJ+5wsusAIPs/uBi+Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y1ULWgNTjqlK8pixpj7/BB7NFwX4uAVVVUXWgLWm8pj7jKpWnHDd/4Ap37vCc55KbU
         Y9QgAGaGmAz509HWZxrJV/hne5cbvQEoh3hITPqJdJhKJA3uLpcU1qXWrnVxjugsLAJL
         DGFrBrlZaQe/4Fl8iV4DU2ODtOLIVGYFhm1aA=
Received: by 10.216.183.11 with SMTP id p11mr2357961wem.226.1274650759593;
        Sun, 23 May 2010 14:39:19 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm1654165ewy.2.2010.05.23.14.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 14:39:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147588>

string_pool uses the macros in the memory pool library to create a
memory pool for strings and expose an API for handling the
strings. Taken directly from David Michael Barr's svn-dump-fast-export
repository.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/string_pool.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/string_pool.h |   11 ++++++
 2 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h

diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
new file mode 100644
index 0000000..4624134
--- /dev/null
+++ b/vcs-svn/string_pool.c
@@ -0,0 +1,84 @@
+#include <string.h>
+
+#include "trp.h"
+#include "obj_pool.h"
+#include "string_pool.h"
+
+typedef struct node_s node_t;
+typedef trp(node_t) tree_t;
+static tree_t tree = { ~0 };
+
+struct node_s {
+    uint32_t offset;
+    trp_node(node_t) children;
+};
+
+/* Create two memory pools: one for node_t, and another for strings */
+obj_pool_gen(node, node_t, 4096);
+obj_pool_gen(string, char, 4096);
+
+static char *node_value(node_t *node)
+{
+    return node ? string_pointer(node->offset) : NULL;
+}
+
+static int node_value_cmp(node_t *a, node_t *b)
+{
+    return strcmp(node_value(a), node_value(b));
+}
+
+static int node_indentity_cmp(node_t *a, node_t *b)
+{
+    int r = node_value_cmp(a, b);
+    return r ? r : (((uintptr_t) a) > ((uintptr_t) b))
+        - (((uintptr_t) a) < ((uintptr_t) b));
+}
+
+/* Build a Treap from the node_s structure (a trp_node w/ offset) */
+trp_gen(static, tree_, tree_t, node_t, children, node,
+        node_indentity_cmp);
+
+static char *pool_fetch(uint32_t entry)
+{
+    return node_value(node_pointer(entry));
+}
+
+uint32_t pool_intern(char *key)
+{
+    node_t *match = NULL;
+    uint32_t key_len = strlen(key) + 1;
+    node_t *node = node_pointer(node_alloc(1));
+    node->offset = string_alloc(key_len);
+    strcpy(node_value(node), key);
+    match = tree_psearch(&tree, node);
+    if (!match || node_value_cmp(node, match)) {
+        tree_insert(&tree, node);
+    } else {
+        node_free(1);
+        string_free(key_len);
+        node = match;
+    }
+    return node_offset(node);
+}
+
+uint32_t pool_tok_r(char *str, const char *delim, char **saveptr)
+{
+    char *token = strtok_r(str, delim, saveptr);
+    return token ? pool_intern(token) : ~0;
+}
+
+void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream)
+{
+    uint32_t i;
+    for (i = 0; i < len; i++) {
+        fputs(pool_fetch(seq[i]), stream);
+        if (i < len - 1)
+            fputc(delim, stream);
+    }
+}
+
+void pool_reset(void)
+{
+    node_reset();
+    string_reset();
+}
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
new file mode 100644
index 0000000..fb9e6b8
--- /dev/null
+++ b/vcs-svn/string_pool.h
@@ -0,0 +1,11 @@
+#ifndef STRING_POOL_H_
+#define	STRING_POOL_H_
+
+#include <stdint.h>
+#include <stdio.h>
+
+uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
+void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream);
+void pool_reset(void);
+
+#endif
-- 
1.7.1
