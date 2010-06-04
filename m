From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] Add library for string-specific memory pool
Date: Fri,  4 Jun 2010 15:26:25 +0200
Message-ID: <1275657988-29765-4-git-send-email-artagnon@gmail.com>
References: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:25:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKWu0-0005qy-2b
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab0FDNZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:25:16 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:54197 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab0FDNZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:25:14 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so308388ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=B4EKHiBRIv+O1a9R0havsjQ/karjqdiwfIuHN9e/GSw=;
        b=EybWNFyFTeTb7QfXIdZ07yAtUeGdgrX+5RzaHajiUomg67Yw+ladl60Vi3VRHPud6z
         2nByVXR8Wi/VhRWxdWnuJu/Ck70UxWwGgOY1LBK2wxVC7aTK9DqK9ahkUHwocAf5vu2b
         k97jEVxn2+MNm+6Wx46u7aDE7qMzNQdVWKOOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NVR01wL65YdY08p0M/lgE2dIzt53yzuKAJcGEc/7oP5ItyRdOeHJfqSkkz+XuJXNBS
         itKUMwWIg1EfghbbgcG3o2wTkoChTM7HvBdisgJcPJ7QFbo0ZES9wVF7fLSa7XLo6L5G
         rmuXLBcAQqefy+Maoil4aIA9+wnbuTK3fvyDw=
Received: by 10.213.34.3 with SMTP id j3mr7968596ebd.70.1275657913260;
        Fri, 04 Jun 2010 06:25:13 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm730275ewy.2.2010.06.04.06.25.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:25:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148401>

This library uses the macros in the obj_pool.h and trp.h to create a
memory pool for strings and expose an API for handling them.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/string_pool.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/string_pool.h |   14 ++++++
 2 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h

diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
new file mode 100644
index 0000000..cfcf127
--- /dev/null
+++ b/vcs-svn/string_pool.c
@@ -0,0 +1,110 @@
+#include "git-compat-util.h"
+
+#include "trp.h"
+#include "obj_pool.h"
+#include "string_pool.h"
+
+typedef struct node_s node_t;
+static struct trp_root tree = { ~0 };
+
+struct node_s {
+	uint32_t offset;
+	struct trp_node children;
+};
+
+/* Create two memory pools: one for node_t, and another for strings */
+obj_pool_gen(node, node_t, 4096);
+obj_pool_gen(string, char, 4096);
+
+static char *node_value(node_t *node)
+{
+	return node ? string_pointer(node->offset) : NULL;
+}
+
+static int node_value_cmp(node_t *a, node_t *b)
+{
+	return strcmp(node_value(a), node_value(b));
+}
+
+static int node_indentity_cmp(node_t *a, node_t *b)
+{
+	int r = node_value_cmp(a, b);
+	return r ? r : (((uintptr_t) a) > ((uintptr_t) b))
+		- (((uintptr_t) a) < ((uintptr_t) b));
+}
+
+/* Build a Treap from the node_s structure (a trp_node w/ offset) */
+trp_gen(static, tree_, node_t, children, node, node_indentity_cmp);
+
+char *pool_fetch(uint32_t entry)
+{
+	return node_value(node_pointer(entry));
+}
+
+uint32_t pool_intern(char *key)
+{
+	/* Canonicalize key */
+	node_t *match = NULL;
+	uint32_t key_len;
+	if (key == NULL)
+		return ~0;
+	key_len = strlen(key) + 1;
+	node_t *node = node_pointer(node_alloc(1));
+	node->offset = string_alloc(key_len);
+	strcpy(node_value(node), key);
+	match = tree_psearch(&tree, node);
+	if (!match || node_value_cmp(node, match)) {
+		tree_insert(&tree, node);
+	} else {
+		node_free(1);
+		string_free(key_len);
+		node = match;
+	}
+	return node_offset(node);
+}
+
+uint32_t pool_tok_r(char *str, const char *delim, char **saveptr)
+{
+	char *token = strtok_r(str, delim, saveptr);
+	return token ? pool_intern(token) : ~0;
+}
+
+void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream)
+{
+	uint32_t i;
+	for (i = 0; i < len && ~seq[i]; i++) {
+		fputs(pool_fetch(seq[i]), stream);
+		if (i < len - 1 && ~seq[i + 1])
+			fputc(delim, stream);
+	}
+}
+
+uint32_t pool_tok_seq(uint32_t max, uint32_t *seq, char *delim, char *str)
+{
+	char *context = NULL;
+	uint32_t length = 0, token = str ? pool_tok_r(str, delim, &context) : ~0;
+	while (length < max) {
+		seq[length++] = token;
+		if (token == ~0)
+			break;
+		token = pool_tok_r(NULL, delim, &context);
+	}
+	seq[length ? length - 1 : 0] = ~0;
+	return length;
+}
+
+void pool_init(void)
+{
+	uint32_t node;
+	node_init();
+	string_init();
+	for (node = 0; node < node_pool.size; node++) {
+		tree_insert(&tree, node_pointer(node));
+	}
+}
+
+void pool_reset(void)
+{
+	node_reset();
+	string_reset();
+}
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
new file mode 100644
index 0000000..e2cc447
--- /dev/null
+++ b/vcs-svn/string_pool.h
@@ -0,0 +1,14 @@
+#ifndef STRING_POOL_H_
+#define	STRING_POOL_H_
+
+#include "git-compat-util.h"
+
+uint32_t pool_intern(char *key);
+char *pool_fetch(uint32_t entry);
+uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
+void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream);
+uint32_t pool_tok_seq(uint32_t max, uint32_t *seq, char *delim, char *str);
+void pool_init(void);
+void pool_reset(void);
+
+#endif
-- 
1.7.1
