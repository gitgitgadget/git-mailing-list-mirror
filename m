From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] Add cpp macro implementation of treaps
Date: Fri,  4 Jun 2010 15:26:24 +0200
Message-ID: <1275657988-29765-3-git-send-email-artagnon@gmail.com>
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
	id 1OKWty-0005qy-Tl
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab0FDNZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:25:12 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:54197 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab0FDNZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:25:10 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so308388ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=25jRTBG5JNWEp5ku57nDBqCx4E3AZGhMgV17S/Znt5o=;
        b=XAaSDKRbsJI+qiCLKyNejFpu/yR0A9NsP3D8dJzHvjKcUL6TXrEFTw5meHBQFtLkqz
         zXioPZwfrFbbNgJt5H1D7vMt3brtTbkup+XqqhodhyRx/T2WAlPC1vg1E0xOude05GGp
         xVjNmAgq2HL7gtUwykPRfECXzvMTQL7/OKmlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o9AbKHDPKjpeghVahvkZWQJ561jqqX6e7vwTDgCiFnl8VwmhU3qGWL/Ud0FsYC+gwJ
         QCvbUP+cgs/Wo1uQuFiZ42t7QxLKZekKoRDrA0Ty/168s2JujHhFaHVUvHIOpH2FP/bk
         Qd7SZGLws/yVe/UNKnCwaRJqyRGLxY3tRgja0=
Received: by 10.213.109.6 with SMTP id h6mr5776377ebp.57.1275657909372;
        Fri, 04 Jun 2010 06:25:09 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm722817ewy.13.2010.06.04.06.25.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:25:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148403>

The implementation exposes an API to generate type-specific treap
implmentation and various functions to operate on it. It uses
obj_pool.h to store memory nodes in a treap.

Treaps provide a memory-efficient binary search tree structure.
Insertion/deletion/search are about as about as fast in the average
case as red-black trees and the chances of worst-case behavior are
vanishingly small, thanks to (pseudo-)randomness.  That is a small
price to pay, given that treaps are much simpler to implement.

[db: Altered to reference nodes by offset from a common base pointer]
[db: Bob Jenkins' hashing implementation dropped for Knuth's]
[db: Methods unnecessary for search and insert dropped]

From: Jason Evans <jasone@canonware.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/trp.h   |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/trp.txt |   62 +++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt

diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
new file mode 100644
index 0000000..c90f5c3
--- /dev/null
+++ b/vcs-svn/trp.h
@@ -0,0 +1,118 @@
+/*
+ * cpp macro implementation of treaps.
+ *
+ * Usage:
+ *   #include <stdint.h>
+ *   #include <trp.h>
+ *   trp_gen(...)
+ */
+
+#ifndef TRP_H_
+#define TRP_H_
+
+/* Node structure. */
+struct trp_node {
+	uint32_t trpn_left;
+	uint32_t trpn_right;
+};
+
+/* Root structure. */
+struct trp_root {
+	uint32_t trp_root;
+};
+
+/* Pointer/Offset conversion */
+#define trpn_pointer(a_base, a_offset) (a_base##_pointer(a_offset))
+#define trpn_offset(a_base, a_pointer) (a_base##_offset(a_pointer))
+
+/* Left accessors. */
+#define trp_left_get(a_base, a_field, a_node) \
+	trpn_pointer(a_base, (a_node)->a_field.trpn_left)
+#define trp_left_set(a_base, a_field, a_node, a_left) \
+	(a_node)->a_field.trpn_left = trpn_offset(a_base, a_left)
+
+/* Right accessors. */
+#define trp_right_get(a_base, a_field, a_node) \
+	trpn_pointer(a_base, (a_node)->a_field.trpn_right)
+#define trp_right_set(a_base, a_field, a_node, a_right) \
+	(a_node)->a_field.trpn_right = trpn_offset(a_base, a_right)
+
+/* Priority accessors. */
+#define KNUTH_GOLDEN_RATIO_32BIT 2654435761u
+#define trp_prio_get(a_node) \
+	(KNUTH_GOLDEN_RATIO_32BIT*(uint32_t)(uintptr_t)(a_node))
+
+/* Node initializer. */
+#define trp_node_new(a_base, a_field, a_node) \
+	trp_left_set(a_base, a_field, (a_node), NULL); \
+	trp_right_set(a_base, a_field, (a_node), NULL)
+
+/* Internal utility macros. */
+#define trpn_rotate_left(a_base, a_field, a_node, r_node) \
+	do { (r_node) = trp_right_get(a_base, a_field, (a_node)); \
+	trp_right_set(a_base, a_field, (a_node), \
+		trp_left_get(a_base, a_field, (r_node))); \
+	trp_left_set(a_base, a_field, (r_node), (a_node)); } while(0)
+
+#define trpn_rotate_right(a_base, a_field, a_node, r_node) \
+	do { (r_node) = trp_left_get(a_base, a_field, (a_node)); \
+	trp_left_set(a_base, a_field, (a_node), \
+		trp_right_get(a_base, a_field, (r_node))); \
+	trp_right_set(a_base, a_field, (r_node), (a_node)); } while(0)
+
+#define trp_gen(a_attr, a_pre, a_type, a_field, a_base, a_cmp) \
+a_attr a_type *a_pre##psearch(struct trp_root *treap, a_type *key) \
+{ \
+	a_type *ret; \
+	a_type *tnode = trpn_pointer(a_base, treap->trp_root); \
+	ret = NULL; \
+	while (tnode != NULL) { \
+		int cmp = (a_cmp)(key, tnode); \
+		if (cmp < 0) \
+			tnode = trp_left_get(a_base, a_field, tnode); \
+		else if (cmp > 0) { \
+			ret = tnode; \
+			tnode = trp_right_get(a_base, a_field, tnode); \
+		} else { \
+			ret = tnode; \
+			break; \
+		} \
+	} \
+	return (ret); \
+} \
+a_attr a_type *a_pre##insert_recurse(a_type *cur_node, a_type *ins_node) \
+{ \
+	if (cur_node == NULL) \
+		return (ins_node); \
+	else { \
+		a_type *ret; \
+		int cmp = a_cmp(ins_node, cur_node); \
+		if (cmp < 0) { \
+			a_type *left = a_pre##insert_recurse( \
+				trp_left_get(a_base, a_field, cur_node), ins_node); \
+			trp_left_set(a_base, a_field, cur_node, left); \
+			if (trp_prio_get(left) < trp_prio_get(cur_node)) \
+				trpn_rotate_right(a_base, a_field, cur_node, ret); \
+			else \
+				ret = cur_node; \
+		} else { \
+			a_type *right = a_pre##insert_recurse( \
+				trp_right_get(a_base, a_field, cur_node), ins_node); \
+			trp_right_set(a_base, a_field, cur_node, right); \
+			if (trp_prio_get(right) < trp_prio_get(cur_node)) \
+				trpn_rotate_left(a_base, a_field, cur_node, ret); \
+			else \
+				ret = cur_node; \
+		} \
+		return (ret); \
+	} \
+} \
+a_attr void a_pre##insert(struct trp_root *treap, a_type *node) \
+{ \
+	trp_node_new(a_base, a_field, node); \
+	treap->trp_root = trpn_offset(a_base, a_pre##insert_recurse( \
+					      trpn_pointer(a_base, treap->trp_root), \
+					      node)); \
+}
+
+#endif
diff --git a/vcs-svn/trp.txt b/vcs-svn/trp.txt
new file mode 100644
index 0000000..7cf9b40
--- /dev/null
+++ b/vcs-svn/trp.txt
@@ -0,1 +1,61 @@
+TODO: Update this documentation to match the changes to trp.h
+
+The trp_gen() macro generates a type-specific treap implementation,
+based on the above cpp macros.
+
+Arguments:
+
+  a_attr     : Function attribute for generated functions (ex: static).
+  a_pre      : Prefix for generated functions (ex: treap_).
+  a_t_type   : Type for treap data structure (ex: treap_t).
+  a_type     : Type for treap node data structure (ex: treap_node_t).
+  a_field    : Name of treap node linkage (ex: treap_link).
+  a_base     : Expression for the base pointer from which nodes are offset.
+  a_cmp      : Node comparison function name, with the following prototype:
+                 int (a_cmp *)(a_type *a_node, a_type *a_other);
+                                       ^^^^^^
+                                    or a_key
+               Interpretation of comparision function return values:
+                 -1 : a_node <  a_other
+                  0 : a_node == a_other
+                  1 : a_node >  a_other
+               In all cases, the a_node or a_key macro argument is the first
+               argument to the comparison function, which makes it possible
+               to write comparison functions that treat the first argument
+               specially.
+
+Assuming the following setup:
+
+  typedef struct ex_node_s ex_node_t;
+  struct ex_node_s {
+      trp_node(ex_node_t) ex_link;
+  };
+  typedef trp(ex_node_t) ex_t;
+  static ex_node_t ex_base[MAX_NODES];
+  trp_gen(static, ex_, ex_t, ex_node_t, ex_link, ex_base, ex_cmp)
+
+The following API is generated:
+
+  static void
+  ex_new(ex_t *treap);
+      Description: Initialize a treap structure.
+      Args:
+        treap: Pointer to an uninitialized treap object.
+
+  static ex_node_t *
+  ex_psearch(ex_t *treap, ex_node_t *key);
+      Description: Search for node that matches key.  If no match is found,
+                   return what would be key's successor/predecessor, were
+                   key in treap.
+      Args:
+        treap: Pointer to a initialized treap object.
+        key  : Search key.
+      Ret: Node in treap that matches key, or if no match, hypothetical
+           node's successor/predecessor (NULL if no successor/predecessor).
+
+  static void
+  ex_insert(ex_t *treap, ex_node_t *node);
+      Description: Insert node into treap.
+      Args:
+        treap: Pointer to a initialized treap object.
+        node : Node to be inserted into treap.
-- 
1.7.1
