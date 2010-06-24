From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9] Add string-specific memory pool
Date: Thu, 24 Jun 2010 05:58:14 -0500
Message-ID: <20100624105813.GE12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:58:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORk8b-000496-I1
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab0FXK6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 06:58:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55249 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab0FXK6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 06:58:24 -0400
Received: by iwn41 with SMTP id 41so735128iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/iXlcreaLIUIyFnwGUC64l1ov8IcjC9zzMNpfTFTepY=;
        b=vCk813Q7kk3GgdG94KjT0QmRT/iH3ZTWg7jLOSKcDJ/qWAe0cjQ3o+TwuFgpbRvnY8
         3WrP2Y8+0ltlHqIN48TF+mCQu6jUWdJcByxWd0p5hcNq5+gutBclC/kRLkgnGEfTTsIK
         78InlOVYs+Rndrx1J05ifTtPodnTTt4ppoj8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QeG13VGlKy0W05INesVDCev4J8lqS7i8ZRwVY950ivTRkkTM4GulTvfMrtBwOCECl6
         ejDAG+i0OiDoWbtsHKI21X/xAo238azVA2jPjBSYVy4sx/hmptuKqcgHnQDjNQ+ajk14
         J2rXz2gPZdlGzumA6Nzgr0TedGe4glzVGQ37M=
Received: by 10.231.59.9 with SMTP id j9mr10662478ibh.31.1277377103261;
        Thu, 24 Jun 2010 03:58:23 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm32900314ibi.11.2010.06.24.03.58.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 03:58:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149576>

From: David Barr <david.barr@cordelta.com>

Intern strings so they can be compared by address and stored without
wasting space.

This library uses the macros in the obj_pool.h and trp.h to create a
memory pool for strings and expose an API for handling them.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile              |    4 +-
 vcs-svn/string_pool.c |  114 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/string_pool.h |   15 ++++++
 3 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h

diff --git a/Makefile b/Makefile
index 663a366..e11e588 100644
--- a/Makefile
+++ b/Makefile
@@ -1740,7 +1740,7 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS =
+VCSSVN_OBJS = vcs-svn/string_pool.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1864,7 +1864,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(VCSSVN_OBJS): \
-	vcs-svn/obj_pool.h vcs-svn/trp.h
+	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
new file mode 100644
index 0000000..bd5a380
--- /dev/null
+++ b/vcs-svn/string_pool.c
@@ -0,0 +1,114 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "trp.h"
+#include "obj_pool.h"
+#include "string_pool.h"
+
+static struct trp_root tree = { ~0 };
+
+struct node {
+	uint32_t offset;
+	struct trp_node children;
+};
+
+/* Two memory pools: one for struct node, and another for strings */
+obj_pool_gen(node, struct node, 4096);
+obj_pool_gen(string, char, 4096);
+
+static char *node_value(struct node *node)
+{
+	return node ? string_pointer(node->offset) : NULL;
+}
+
+static int node_cmp(struct node *a, struct node *b)
+{
+	return strcmp(node_value(a), node_value(b));
+}
+
+/* Build a Treap from the node structure (a trp_node w/ offset) */
+trp_gen(static, tree_, struct node, children, node, node_cmp);
+
+char *pool_fetch(uint32_t entry)
+{
+	return node_value(node_pointer(entry));
+}
+
+uint32_t pool_intern(char *key)
+{
+	/* Canonicalize key */
+	struct node *match = NULL;
+	uint32_t key_len;
+	if (key == NULL)
+		return ~0;
+	key_len = strlen(key) + 1;
+	struct node *node = node_pointer(node_alloc(1));
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
index 0000000..085e6d7
--- /dev/null
+++ b/vcs-svn/string_pool.h
@@ -0,0 +1,15 @@
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
