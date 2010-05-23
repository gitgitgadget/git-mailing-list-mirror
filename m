From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] Add cpp macro implementation of treaps
Date: Sun, 23 May 2010 23:40:27 +0200
Message-ID: <1274650832-7411-3-git-send-email-artagnon@gmail.com>
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
	id 1OGItO-0004R9-5E
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab0EWVjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:39:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44125 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab0EWVjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:39:14 -0400
Received: by wyb29 with SMTP id 29so1098079wyb.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vDJ8h9m/aQpqpDkkPdZAAXmjZGQIRBsJIFBqMd5bLMY=;
        b=wNGGzYr15mpugrmmDBUKf2UJGVvyidfPvcuzJ0qyqZtPUfOJm/sbz2buTVURRwYAq2
         AhJ+kRkg/uloJQEMrDnc9kI3/9kHptUOPXMyrbSTOBBcQmZk/kzvhqW3jE8MBwT/Bi74
         eygjoyyV1czEf7Xba5uanu/91J/SbiejVkL48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WNCw5KKuoj5uWup28+1pa9nMQhoE0bkZgyeXK06Z806MK5N1co3W6rh+tYBltN7YVW
         4nlDVLXSoF/6maW13T05PH12gvnOdRnEw/7drV1YVYa7pv4EU7Z9+9L6uhTthhkaSfgx
         gPX53kVCxXp1e/uGlUjctAshlgZVPMJrj3PK4=
Received: by 10.216.89.17 with SMTP id b17mr2979239wef.131.1274650752971;
        Sun, 23 May 2010 14:39:12 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm1606618ewy.4.2010.05.23.14.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 14:39:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147592>

The implementation exposes an API to generate type-specific treap
implmentation and various functions to operate on it. Taken directly
from David Michael Barr's svn-dump-fast-export repository.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/trp.h |  221 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 221 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/trp.h

diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
new file mode 100644
index 0000000..d40f9d3
--- /dev/null
+++ b/vcs-svn/trp.h
@@ -0,0 +1,221 @@
+/******************************************************************************
+ *
+ * cpp macro implementation of treaps.
+ *
+ * Usage:
+ *
+ *   #include <trp.h>
+ *   trp(...)
+ *   trp_gen(...)
+ *   ...
+ *
+ ******************************************************************************/
+
+#ifndef TRP_H_
+#define	TRP_H_
+
+#include <stdint.h>
+
+/* Node structure. */
+#define	trp_node(a_type)						\
+struct {								\
+    uint32_t trpn_left;							\
+    uint32_t trpn_right;						\
+}
+
+/* Root structure. */
+#define	trp(a_type)							\
+struct {								\
+    uint32_t trp_root;							\
+}
+
+/* Pointer/Offset conversion */
+#define trpn_pointer(a_base, a_offset)					\
+    (a_base##_pointer(a_offset))
+#define trpn_offset(a_base, a_pointer)				        \
+    (a_base##_offset(a_pointer))
+
+/* Left accessors. */
+#define	trp_left_get(a_base, a_type, a_field, a_node)			\
+    trpn_pointer(a_base, (a_node)->a_field.trpn_left)
+#define	trp_left_set(a_base, a_type, a_field, a_node, a_left) do {	\
+    (a_node)->a_field.trpn_left = trpn_offset(a_base, a_left);	        \
+} while (0)
+
+/* Right accessors. */
+#define	trp_right_get(a_base, a_type, a_field, a_node)			\
+    trpn_pointer(a_base, (a_node)->a_field.trpn_right)
+#define	trp_right_set(a_base, a_type, a_field, a_node, a_right) do {	\
+    (a_node)->a_field.trpn_right = trpn_offset(a_base, a_right);        \
+} while (0)
+
+/* Priority accessors. */
+#define	trp_prio_get(a_type, a_field, a_node)				\
+    (2654435761*(uint32_t)(uintptr_t)(a_node))
+
+/* Node initializer. */
+#define	trp_node_new(a_base, a_type, a_field, a_trp, a_node) do {	\
+    trp_left_set(a_base, a_type, a_field, (a_node), NULL);		\
+    trp_right_set(a_base, a_type, a_field, (a_node), NULL);		\
+} while (0)
+
+/* Tree initializer. */
+#define	trp_new(a_type, a_base, a_trp) do {		        	\
+    (a_trp)->trp_root = trpn_offset(a_base, NULL);			\
+} while (0)
+
+/* Internal utility macros. */
+#define	trpn_rotate_left(a_base, a_type, a_field, a_node, r_node) do {	\
+    (r_node) = trp_right_get(a_base, a_type, a_field, (a_node));	\
+    trp_right_set(a_base, a_type, a_field, (a_node),			\
+      trp_left_get(a_base, a_type, a_field, (r_node)));			\
+    trp_left_set(a_base, a_type, a_field, (r_node), (a_node));		\
+} while (0)
+
+#define	trpn_rotate_right(a_base, a_type, a_field, a_node, r_node) do {	\
+    (r_node) = trp_left_get(a_base, a_type, a_field, (a_node));		\
+    trp_left_set(a_base, a_type, a_field, (a_node),			\
+      trp_right_get(a_base, a_type, a_field, (r_node)));		\
+    trp_right_set(a_base, a_type, a_field, (r_node), (a_node));		\
+} while (0)
+
+/*
+ * The trp_gen() macro generates a type-specific treap implementation,
+ * based on the above cpp macros.
+ *
+ * Arguments:
+ *
+ *   a_attr     : Function attribute for generated functions (ex: static).
+ *   a_pre      : Prefix for generated functions (ex: treap_).
+ *   a_t_type   : Type for treap data structure (ex: treap_t).
+ *   a_type     : Type for treap node data structure (ex: treap_node_t).
+ *   a_field    : Name of treap node linkage (ex: treap_link).
+ *   a_base     : Expression for the base pointer from which nodes are offset.
+ *   a_cmp      : Node comparison function name, with the following prototype:
+ *                  int (a_cmp *)(a_type *a_node, a_type *a_other);
+ *                                        ^^^^^^
+ *                                     or a_key
+ *                Interpretation of comparision function return values:
+ *                  -1 : a_node <  a_other
+ *                   0 : a_node == a_other
+ *                   1 : a_node >  a_other
+ *                In all cases, the a_node or a_key macro argument is the first
+ *                argument to the comparison function, which makes it possible
+ *                to write comparison functions that treat the first argument
+ *                specially.
+ *
+ * Assuming the following setup:
+ *
+ *   typedef struct ex_node_s ex_node_t;
+ *   struct ex_node_s {
+ *       trp_node(ex_node_t) ex_link;
+ *   };
+ *   typedef trp(ex_node_t) ex_t;
+ *   static ex_node_t ex_base[MAX_NODES];
+ *   trp_gen(static, ex_, ex_t, ex_node_t, ex_link, ex_base, ex_cmp)
+ *
+ * The following API is generated:
+ *
+ *   static void
+ *   ex_new(ex_t *treap);
+ *       Description: Initialize a treap structure.
+ *       Args:
+ *         treap: Pointer to an uninitialized treap object.
+ *
+ *   static ex_node_t *
+ *   ex_psearch(ex_t *treap, ex_node_t *key);
+ *       Description: Search for node that matches key.  If no match is found,
+ *                    return what would be key's successor/predecessor, were
+ *                    key in treap.
+ *       Args:
+ *         treap: Pointer to a initialized treap object.
+ *         key  : Search key.
+ *       Ret: Node in treap that matches key, or if no match, hypothetical
+ *            node's successor/predecessor (NULL if no successor/predecessor).
+ *
+ *   static void
+ *   ex_insert(ex_t *treap, ex_node_t *node);
+ *       Description: Insert node into treap.
+ *       Args:
+ *         treap: Pointer to a initialized treap object.
+ *         node : Node to be inserted into treap.
+ */
+#define	trp_gen(a_attr, a_pre, a_t_type, a_type, a_field, a_base, a_cmp)\
+a_attr void								\
+a_pre##new(a_t_type *treap) {           				\
+    trp_new(a_type, a_base, treap);			        	\
+}									\
+a_attr a_type *								\
+a_pre##search(a_t_type *treap, a_type *key) {				\
+    a_type *ret;							\
+    int cmp;								\
+    ret = trpn_pointer(a_base, treap->trp_root);			\
+    while (ret != NULL							\
+      && (cmp = (a_cmp)(key, ret)) != 0) {				\
+	if (cmp < 0) {							\
+	    ret = trp_left_get(a_base, a_type, a_field, ret);		\
+	} else {							\
+	    ret = trp_right_get(a_base, a_type, a_field, ret);		\
+	}								\
+    }									\
+    return (ret);							\
+}									\
+a_attr a_type *								\
+a_pre##psearch(a_t_type *treap, a_type *key) {				\
+    a_type *ret;							\
+    a_type *tnode = trpn_pointer(a_base, treap->trp_root);		\
+    ret = NULL;								\
+    while (tnode != NULL) {						\
+	int cmp = (a_cmp)(key, tnode);					\
+	if (cmp < 0) {							\
+	    tnode = trp_left_get(a_base, a_type, a_field, tnode);	\
+	} else if (cmp > 0) {						\
+	    ret = tnode;						\
+	    tnode = trp_right_get(a_base, a_type, a_field, tnode);	\
+	} else {							\
+	    ret = tnode;						\
+	    break;							\
+	}								\
+    }									\
+    return (ret);							\
+}									\
+a_attr a_type *								\
+a_pre##insert_recurse(a_type *cur_node, a_type *ins_node) {		\
+    if (cur_node == NULL) {						\
+	return (ins_node);						\
+    } else {								\
+	a_type *ret;							\
+	int cmp = a_cmp(ins_node, cur_node);				\
+	if (cmp < 0) {							\
+	    a_type *left = a_pre##insert_recurse(trp_left_get(a_base,	\
+              a_type, a_field, cur_node), ins_node);			\
+	    trp_left_set(a_base, a_type, a_field, cur_node, left);	\
+	    if (trp_prio_get(a_type, a_field, left) <			\
+	      trp_prio_get(a_type, a_field, cur_node)) {		\
+		trpn_rotate_right(a_base, a_type, a_field, cur_node,	\
+                  ret);							\
+	    } else {							\
+		ret = cur_node;						\
+	    }								\
+	} else {							\
+	    a_type *right = a_pre##insert_recurse(trp_right_get(a_base, \
+	      a_type, a_field, cur_node), ins_node);			\
+	    trp_right_set(a_base, a_type, a_field, cur_node, right);	\
+	    if (trp_prio_get(a_type, a_field, right) <			\
+	      trp_prio_get(a_type, a_field, cur_node)) {		\
+		trpn_rotate_left(a_base, a_type, a_field, cur_node,	\
+                  ret);							\
+	    } else {							\
+		ret = cur_node;						\
+	    }								\
+	}								\
+	return (ret);							\
+    }									\
+}									\
+a_attr void								\
+a_pre##insert(a_t_type *treap, a_type *node) {				\
+    trp_node_new(a_base, a_type, a_field, treap, node);			\
+    treap->trp_root = trpn_offset(a_base, a_pre##insert_recurse(        \
+        trpn_pointer(a_base, treap->trp_root), node));	                \
+}
+#endif                          /* TRP_H_ */
-- 
1.7.1
