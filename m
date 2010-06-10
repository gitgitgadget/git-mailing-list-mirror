From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] Add library for string-specific memory pool
Date: Thu, 10 Jun 2010 15:09:46 +0200
Message-ID: <1276175389-6185-4-git-send-email-artagnon@gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 15:09:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhVg-0002fq-L4
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 15:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab0FJNJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 09:09:07 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:61012 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab0FJNJE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 09:09:04 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so80476ewy.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d+ykVxM1TKFISxX8wQsiIBUgn/bo2ZvT9CGhNs7hY2E=;
        b=YRjVGtMMT66EBVKAHb4apa4AWAXBSctPYpapc44Lb7T637RRGLTu/3M0jwmQKCoBkE
         3NFEDEErB/GsrVK8octqWN1qeeqpBdZp+YSY53oazcW2/FkV4O0uw3gO5NqwrmHdKvIS
         HFv3vbPhM9pp8bo9xi3tW2Oa3N79Q5825b9+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bYr2fUv86BhgZZAERJbu23wj1cZ1Tz+C55sjL4FoOtSUZOvAGXuFr9aNlykpgq2wDT
         4x/eNsbzBXl8Ln2BzWSCZvMQRvMO4yyFOMGf53ETRZCUJqT+cSj0YSsb+yzeYecwfjEQ
         cTM7+thrf4Z6F1hChPgajMnEKkJVBBQrilfhk=
Received: by 10.213.29.65 with SMTP id p1mr2331866ebc.43.1276175343267;
        Thu, 10 Jun 2010 06:09:03 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 16sm4771316ewy.3.2010.06.10.06.09.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 06:09:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148869>

From: David Barr <david.barr@cordelta.com>

This library uses the macros in the obj_pool.h and trp.h to create a
memory pool for strings and expose an API for handling them.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/string_pool.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/string_pool.h |   15 ++++++
 2 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h

diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
new file mode 100644
index 0000000..523a6cc
--- /dev/null
+++ b/vcs-svn/string_pool.c
@@ -0,0 +1,116 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
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
+static int node_cmp(node_t *a, node_t *b)
+{
+	return strcmp(node_value(a), node_value(b));
+}
+
+/* Build a Treap from the node_s structure (a trp_node w/ offset) */
+trp_gen(static, tree_, node_t, children, node, node_cmp);
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
+	match = tree_search(&tree, node);
+	if (!match) {
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
+	uint32_t string = 0;
+	string_init();
+	while (string < string_pool.size) {
+		node = node_alloc(1);
+		node_pointer(node)->offset = string;
+		tree_insert(&tree, node_pointer(node));
+		string += strlen(string_pointer(string)) + 1;
+	}
+}
+
+void pool_commit(void)
+{
+	string_commit();
+}
+
+void pool_reset(void)
+{
+	node_reset();
+	string_reset();
+}
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
new file mode 100644
index 0000000..a69d165
--- /dev/null
+++ b/vcs-svn/string_pool.h
@@ -0,1 +1,15 @@
+#ifndef STRING_POOL_H_
+#define STRING_POOL_H_
+
+#include "git-compat-util.h"
+
+uint32_t pool_intern(char *key);
+char *pool_fetch(uint32_t entry);
+uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
+void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream);
+uint32_t pool_tok_seq(uint32_t max, uint32_t *seq, char *delim, char *str);
+void pool_init(void);
+void pool_commit(void);
+void pool_reset(void);
+
+#endif
-- 
1.7.1
