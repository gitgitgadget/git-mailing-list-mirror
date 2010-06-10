From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] Add cpp macro implementation of treaps
Date: Thu, 10 Jun 2010 15:09:45 +0200
Message-ID: <1276175389-6185-3-git-send-email-artagnon@gmail.com>
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
	id 1OMhVg-0002fq-0d
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 15:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab0FJNJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 09:09:04 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:61012 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0FJNJB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 09:09:01 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so80476ewy.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/1BI+bF/vFkoDTVtd3xDfZHgGBDThMCoVBJ6FVSMscc=;
        b=jk0U6lDH/nvzmdAovj3mMmvfsvnt8TT71AUsBhd26Q8qZISYZYhZBtr9MlLVPSeVJN
         69mRdvOxcRrUsdrD5U7mxunXyAoPl0ajoaozvsk3gzIQ1wN37U27hZ4TcbBZYklac33g
         lWEMehTSFwHDqjP/WIch8e9/tS+KF3BYdqE98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p0IfsZ1WGtUY9yDR7BG7X+urTJQTiX5vMYhqvlOCxn2wYiRvZjcyKAFYwaffu0JsW4
         wYPyZMdlJlHc+z1q0G1A7b/n1hxccpsCVp9dpBYtIDTc5xOCfo2mvGGR+mwFgw89kKb3
         3hILoD15l2Oa5th+NWwrkrmzhZYEZNjJXG0ho=
Received: by 10.213.112.144 with SMTP id w16mr150485ebp.1.1276175340134;
        Thu, 10 Jun 2010 06:09:00 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 16sm4781455ewy.11.2010.06.10.06.08.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 06:08:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148868>

From: Jason Evans <jasone@canonware.com>

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

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/trp.h   |  201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/trp.txt |   61 +++++++++++++++++
 2 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt

diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
new file mode 100644
index 0000000..50fde39
--- /dev/null
+++ b/vcs-svn/trp.h
@@ -0,0 +1,201 @@
+/*
+ * cpp macro implementation of treaps.
+ *
+ * Usage:
+ *   #include <stdint.h>
+ *   #include <trp.h>
+ *   trp_gen(...)
+ *
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
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
+#define trpn_modify(a_base, a_offset) \
+	do { \
+		if ((a_offset) < a_base##_pool.committed) { \
+			uint32_t old_offset = (a_offset);\
+			(a_offset) = a_base##_alloc(1); \
+			*trpn_pointer(a_base, a_offset) = \
+				*trpn_pointer(a_base, old_offset); \
+		} \
+	} while (0);
+
+/* Left accessors. */
+#define trp_left_get(a_base, a_field, a_node) \
+	(trpn_pointer(a_base, a_node)->a_field.trpn_left)
+#define trp_left_set(a_base, a_field, a_node, a_left) \
+	do { trpn_modify(a_base, a_node); \
+	trp_left_get(a_base, a_field, a_node) = (a_left); } while(0)
+
+/* Right accessors. */
+#define trp_right_get(a_base, a_field, a_node) \
+	(trpn_pointer(a_base, a_node)->a_field.trpn_right)
+#define trp_right_set(a_base, a_field, a_node, a_right) \
+	do { trpn_modify(a_base, a_node); \
+	trp_right_get(a_base, a_field, a_node) = (a_right); } while(0)
+
+/* Priority accessors. */
+#define KNUTH_GOLDEN_RATIO_32BIT 2654435761u
+#define trp_prio_get(a_node) \
+	(KNUTH_GOLDEN_RATIO_32BIT*(a_node))
+
+/* Node initializer. */
+#define trp_node_new(a_base, a_field, a_node) \
+	trp_left_set(a_base, a_field, (a_node), ~0); \
+	trp_right_set(a_base, a_field, (a_node), ~0)
+
+/* Internal utility macros. */
+#define trpn_first(a_base, a_field, a_root, r_node) \
+	do { \
+		(r_node) = (a_root); \
+		if ((r_node) == ~0) \
+			return NULL; \
+		while (~trp_left_get(a_base, a_field, (r_node))) \
+			(r_node) = trp_left_get(a_base, a_field, (r_node)); \
+	} while (0)
+
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
+a_attr a_type *a_pre##first(struct trp_root *treap) \
+{ \
+	uint32_t ret; \
+	trpn_first(a_base, a_field, treap->trp_root, ret); \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr a_type *a_pre##next(struct trp_root *treap, a_type *node) { \
+	uint32_t ret; \
+	uint32_t offset = trpn_offset(a_base, node); \
+	if (~trp_right_get(a_base, a_field, offset)) { \
+		trpn_first(a_base, a_field, \
+			trp_right_get(a_base, a_field, offset), ret); \
+	} else { \
+		uint32_t tnode = treap->trp_root; \
+		ret = ~0; \
+		while (1) { \
+			int cmp = (a_cmp)(trpn_pointer(a_base, offset), \
+				trpn_pointer(a_base, tnode)); \
+			if (cmp < 0) { \
+				ret = tnode; \
+				tnode = trp_left_get(a_base, a_field, tnode); \
+			} else if (cmp > 0) { \
+				tnode = trp_right_get(a_base, a_field, tnode); \
+			} else { \
+				break; \
+			} \
+		} \
+	} \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr a_type *a_pre##search(struct trp_root *treap, a_type *key) \
+{ \
+	int cmp; \
+	uint32_t ret = treap->trp_root; \
+	while (~ret && (cmp = (a_cmp)(key, trpn_pointer(a_base,ret)))) \
+		if (cmp < 0) \
+			ret = trp_left_get(a_base, a_field, ret); \
+		else \
+			ret = trp_right_get(a_base, a_field, ret); \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr uint32_t a_pre##insert_recurse(uint32_t cur_node, uint32_t ins_node) \
+{ \
+	if (cur_node == ~0) \
+		return (ins_node); \
+	else { \
+		uint32_t ret; \
+		int cmp = (a_cmp)(trpn_pointer(a_base, ins_node), \
+					trpn_pointer(a_base, cur_node)); \
+		if (cmp < 0) { \
+			uint32_t left = a_pre##insert_recurse( \
+				trp_left_get(a_base, a_field, cur_node), ins_node); \
+			trp_left_set(a_base, a_field, cur_node, left); \
+			if (trp_prio_get(left) < trp_prio_get(cur_node)) \
+				trpn_rotate_right(a_base, a_field, cur_node, ret); \
+			else \
+				ret = cur_node; \
+		} else { \
+			uint32_t right = a_pre##insert_recurse( \
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
+	uint32_t offset = trpn_offset(a_base, node); \
+	trp_node_new(a_base, a_field, offset); \
+	treap->trp_root = a_pre##insert_recurse( treap->trp_root, offset); \
+} \
+a_attr uint32_t a_pre##remove_recurse(uint32_t cur_node, uint32_t rem_node) \
+{ \
+	int cmp = a_cmp(trpn_pointer(a_base, rem_node), \
+			trpn_pointer(a_base, cur_node)); \
+	if (cmp == 0) { \
+		uint32_t ret; \
+		uint32_t left = trp_left_get(a_base, a_field, cur_node); \
+		uint32_t right = trp_right_get(a_base, a_field, cur_node); \
+		if (left == ~0) { \
+			if (right == ~0) \
+				return (~0); \
+		} else if (right == ~0 || trp_prio_get(left) < trp_prio_get(right)) { \
+			trpn_rotate_right(a_base, a_field, cur_node, ret); \
+			right = a_pre##remove_recurse(cur_node, rem_node); \
+			trp_right_set(a_base, a_field, ret, right); \
+			return (ret); \
+		} \
+		trpn_rotate_left(a_base, a_field, cur_node, ret); \
+		left = a_pre##remove_recurse(cur_node, rem_node); \
+		trp_left_set(a_base, a_field, ret, left); \
+		return (ret); \
+	} else if (cmp < 0) { \
+		uint32_t left = a_pre##remove_recurse( \
+			trp_left_get(a_base, a_field, cur_node), rem_node); \
+		trp_left_set(a_base, a_field, cur_node, left); \
+		return (cur_node); \
+	} else { \
+		uint32_t right = a_pre##remove_recurse( \
+			trp_right_get(a_base, a_field, cur_node), rem_node); \
+		trp_right_set(a_base, a_field, cur_node, right); \
+		return (cur_node); \
+	} \
+} \
+a_attr void a_pre##remove(struct trp_root *treap, a_type *node) \
+{ \
+	treap->trp_root = a_pre##remove_recurse(treap->trp_root, \
+		trpn_offset(a_base, node)); \
+} \
+
+#endif
diff --git a/vcs-svn/trp.txt b/vcs-svn/trp.txt
new file mode 100644
index 0000000..b7e2d18
--- /dev/null
+++ b/vcs-svn/trp.txt
@@ -0,0 +1,61 @@
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
