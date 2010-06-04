From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] Add library for string-specific memory pool
Date: Fri,  4 Jun 2010 15:41:08 +0200
Message-ID: <1275658871-1473-4-git-send-email-artagnon@gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:40:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKX81-0005cL-A8
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab0FDNj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:39:59 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:41712 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab0FDNjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:39:53 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so312332ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oxlvU6sg3xWcWcN3BloAetJqZWCX6T1Qnsru0ChHfIw=;
        b=KKgKgh5QoDMQpzvrTBYWiku25Zhdo9pWLJlw1xS80Pu2Yqj77jnKCsHZycmAkiPeOe
         diZiSB+OQ0Z7LEYlEpfjlOUTNBLKIOCRy3CD8lI6Z5uJDIZ7vIxOi/htyvUIb2KE0dmS
         r9yjUI5jjJzhXBoV0mPfG64wCyAurCFgzamSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=feQ5thkLK2i5TB0n/eNoSQ9ZjJCL60tB+plzKmQpg+54vlslRSdsWYlSM77ZXG/fh3
         DZtos3R0T5Zt6wCWW9Mj1v7/SYZQKvOshzM6UOKRGPo9HFLKDorsyHmSGaLS05HYPpKE
         Kl2Fcd5oGXkgQz5EKPg9I0ZL+JaYeTzqPKtfE=
Received: by 10.213.114.70 with SMTP id d6mr8452727ebq.64.1275658791795;
        Fri, 04 Jun 2010 06:39:51 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm731042ewy.9.2010.06.04.06.39.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:39:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148412>

From: David Barr <david.barr@cordelta.com>

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
