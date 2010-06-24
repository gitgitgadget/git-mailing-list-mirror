From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] Add treap implementation
Date: Thu, 24 Jun 2010 05:57:06 -0500
Message-ID: <20100624105706.GD12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORk7Y-0003FD-Gm
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab0FXK5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 06:57:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38322 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab0FXK5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 06:57:17 -0400
Received: by gye5 with SMTP id 5so4271684gye.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vg6VqfPG5AgTRLvW9qc8OKJxQbFMlYpBPrNW+OVqbMk=;
        b=Wvoqjh0Jvd3SpqYXBPbbBUdDeUjc+Mag+aGWT7G3TqL3vwpqZospJvnA/HRwy2EwmV
         5J3fd5q/KL8S/QuE8H+daoZf8RiPxhqA6VfaIAfgV4EOWnkf4lhpZM+96jaoYo0LVjaJ
         TIaJrh7Y6jIFd0pgqj3eAaNNHoxW1tvsWsCQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hlvhMpfKjk4tnLmaC6pY13UkbUhKUyc5cM+E5HnMSyfBG0tUP4hgpbju6odI2llVxj
         g/VrbT18khcq7/2ex9mvC1TAKivYAFKgNL+KbWThTgve9crdNqWLWK8dtYuSW7To9upE
         Wnnqy14kMHXQB6sF+XBn1DtnWtE9+fnKPct5Y=
Received: by 10.150.142.17 with SMTP id p17mr9032378ybd.361.1277377035838;
        Thu, 24 Jun 2010 03:57:15 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm40902655ibu.0.2010.06.24.03.57.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 03:57:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149575>

=46rom: Jason Evans <jasone@canonware.com>

Provide macros to generate a type-specific treap implementation and
various functions to operate on it. It uses obj_pool.h to store memory
nodes in a treap.  Previously committed nodes are never removed from
the pool; after any *_commit operation, it is assumed (correctly, in
the case of svn-fast-export) that someone else must care about them.

Treaps provide a memory-efficient binary search tree structure.
Insertion/deletion/search are about as about as fast in the average
case as red-black trees and the chances of worst-case behavior are
vanishingly small, thanks to (pseudo-)randomness.  The bad worst-case
behavior is a small price to pay, given that treaps are much simpler
to implement.

=46rom http://www.canonware.com/download/trp/trp_hash/trp.h

[db: Altered to reference nodes by offset from a common base pointer]
[db: Bob Jenkins' hashing implementation dropped for Knuth's]
[db: Methods unnecessary for search and insert dropped]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile        |    2 +-
 vcs-svn/LICENSE |    3 +
 vcs-svn/trp.h   |  220 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 vcs-svn/trp.txt |   90 ++++++++++++++++++++++
 4 files changed, 314 insertions(+), 1 deletions(-)
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt

diff --git a/Makefile b/Makefile
index fc31ee0..663a366 100644
--- a/Makefile
+++ b/Makefile
@@ -1864,7 +1864,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
=20
 $(VCSSVN_OBJS): \
-	vcs-svn/obj_pool.h
+	vcs-svn/obj_pool.h vcs-svn/trp.h
 endif
=20
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
index 6e52372..a3d384c 100644
--- a/vcs-svn/LICENSE
+++ b/vcs-svn/LICENSE
@@ -1,6 +1,9 @@
 Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
 All rights reserved.
=20
+Copyright (C) 2008 Jason Evans <jasone@canonware.com>.
+All rights reserved.
+
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
new file mode 100644
index 0000000..dd7d5ee
--- /dev/null
+++ b/vcs-svn/trp.h
@@ -0,0 +1,220 @@
+/*
+ * C macro implementation of treaps.
+ *
+ * Usage:
+ *   #include <stdint.h>
+ *   #include "trp.h"
+ *   trp_gen(...)
+ *
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#ifndef TRP_H_
+#define TRP_H_
+
+#define MAYBE_UNUSED __attribute__((__unused__))
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
+/* Pointer/Offset conversion. */
+#define trpn_pointer(a_base, a_offset) (a_base##_pointer(a_offset))
+#define trpn_offset(a_base, a_pointer) (a_base##_offset(a_pointer))
+#define trpn_modify(a_base, a_offset) \
+	do { \
+		if ((a_offset) < a_base##_pool.committed) { \
+			uint32_t old_offset =3D (a_offset);\
+			(a_offset) =3D a_base##_alloc(1); \
+			*trpn_pointer(a_base, a_offset) =3D \
+				*trpn_pointer(a_base, old_offset); \
+		} \
+	} while (0);
+
+/* Left accessors. */
+#define trp_left_get(a_base, a_field, a_node) \
+	(trpn_pointer(a_base, a_node)->a_field.trpn_left)
+#define trp_left_set(a_base, a_field, a_node, a_left) \
+	do { \
+		trpn_modify(a_base, a_node); \
+		trp_left_get(a_base, a_field, a_node) =3D (a_left); \
+	} while(0)
+
+/* Right accessors. */
+#define trp_right_get(a_base, a_field, a_node) \
+	(trpn_pointer(a_base, a_node)->a_field.trpn_right)
+#define trp_right_set(a_base, a_field, a_node, a_right) \
+	do { \
+		trpn_modify(a_base, a_node); \
+		trp_right_get(a_base, a_field, a_node) =3D (a_right); \
+	} while(0)
+
+/*
+ * Fibonacci hash function.
+ * The multiplier is the nearest prime to (2^32 times (=E2=88=9A5 - 1)=
/2).
+ * See Knuth =C2=A76.4: volume 3, 3rd ed, p518.
+ */
+#define trpn_hash(a_node) (uint32_t) (2654435761u * (a_node))
+
+/* Priority accessors. */
+#define trp_prio_get(a_node) trpn_hash(a_node)
+
+/* Node initializer. */
+#define trp_node_new(a_base, a_field, a_node) \
+	do { \
+		trp_left_set(a_base, a_field, (a_node), ~0); \
+		trp_right_set(a_base, a_field, (a_node), ~0); \
+	} while(0)
+
+/* Internal utility macros. */
+#define trpn_first(a_base, a_field, a_root, r_node) \
+	do { \
+		(r_node) =3D (a_root); \
+		if ((r_node) =3D=3D ~0) \
+			return NULL; \
+		while (~trp_left_get(a_base, a_field, (r_node))) \
+			(r_node) =3D trp_left_get(a_base, a_field, (r_node)); \
+	} while (0)
+
+#define trpn_rotate_left(a_base, a_field, a_node, r_node) \
+	do { \
+		(r_node) =3D trp_right_get(a_base, a_field, (a_node)); \
+		trp_right_set(a_base, a_field, (a_node), \
+			trp_left_get(a_base, a_field, (r_node))); \
+		trp_left_set(a_base, a_field, (r_node), (a_node)); \
+	} while(0)
+
+#define trpn_rotate_right(a_base, a_field, a_node, r_node) \
+	do { \
+		(r_node) =3D trp_left_get(a_base, a_field, (a_node)); \
+		trp_left_set(a_base, a_field, (a_node), \
+			trp_right_get(a_base, a_field, (r_node))); \
+		trp_right_set(a_base, a_field, (r_node), (a_node)); \
+	} while(0)
+
+#define trp_gen(a_attr, a_pre, a_type, a_field, a_base, a_cmp) \
+a_attr a_type MAYBE_UNUSED *a_pre##first(struct trp_root *treap) \
+{ \
+	uint32_t ret; \
+	trpn_first(a_base, a_field, treap->trp_root, ret); \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr a_type MAYBE_UNUSED *a_pre##next(struct trp_root *treap, a_type=
 *node) \
+{ \
+	uint32_t ret; \
+	uint32_t offset =3D trpn_offset(a_base, node); \
+	if (~trp_right_get(a_base, a_field, offset)) { \
+		trpn_first(a_base, a_field, \
+			trp_right_get(a_base, a_field, offset), ret); \
+	} else { \
+		uint32_t tnode =3D treap->trp_root; \
+		ret =3D ~0; \
+		while (1) { \
+			int cmp =3D (a_cmp)(trpn_pointer(a_base, offset), \
+				trpn_pointer(a_base, tnode)); \
+			if (cmp < 0) { \
+				ret =3D tnode; \
+				tnode =3D trp_left_get(a_base, a_field, tnode); \
+			} else if (cmp > 0) { \
+				tnode =3D trp_right_get(a_base, a_field, tnode); \
+			} else { \
+				break; \
+			} \
+		} \
+	} \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr a_type MAYBE_UNUSED *a_pre##search(struct trp_root *treap, a_ty=
pe *key) \
+{ \
+	int cmp; \
+	uint32_t ret =3D treap->trp_root; \
+	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base,ret)))) { \
+		if (cmp < 0) \
+			ret =3D trp_left_get(a_base, a_field, ret); \
+		else \
+			ret =3D trp_right_get(a_base, a_field, ret); \
+	} \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr uint32_t MAYBE_UNUSED a_pre##insert_recurse(uint32_t cur_node, =
uint32_t ins_node) \
+{ \
+	if (cur_node =3D=3D ~0) { \
+		return (ins_node); \
+	} else { \
+		uint32_t ret; \
+		int cmp =3D (a_cmp)(trpn_pointer(a_base, ins_node), \
+					trpn_pointer(a_base, cur_node)); \
+		if (cmp < 0) { \
+			uint32_t left =3D a_pre##insert_recurse( \
+				trp_left_get(a_base, a_field, cur_node), ins_node); \
+			trp_left_set(a_base, a_field, cur_node, left); \
+			if (trp_prio_get(left) < trp_prio_get(cur_node)) \
+				trpn_rotate_right(a_base, a_field, cur_node, ret); \
+			else \
+				ret =3D cur_node; \
+		} else { \
+			uint32_t right =3D a_pre##insert_recurse( \
+				trp_right_get(a_base, a_field, cur_node), ins_node); \
+			trp_right_set(a_base, a_field, cur_node, right); \
+			if (trp_prio_get(right) < trp_prio_get(cur_node)) \
+				trpn_rotate_left(a_base, a_field, cur_node, ret); \
+			else \
+				ret =3D cur_node; \
+		} \
+		return (ret); \
+	} \
+} \
+a_attr void MAYBE_UNUSED a_pre##insert(struct trp_root *treap, a_type =
*node) \
+{ \
+	uint32_t offset =3D trpn_offset(a_base, node); \
+	trp_node_new(a_base, a_field, offset); \
+	treap->trp_root =3D a_pre##insert_recurse(treap->trp_root, offset); \
+} \
+a_attr uint32_t MAYBE_UNUSED a_pre##remove_recurse(uint32_t cur_node, =
uint32_t rem_node) \
+{ \
+	int cmp =3D a_cmp(trpn_pointer(a_base, rem_node), \
+			trpn_pointer(a_base, cur_node)); \
+	if (cmp =3D=3D 0) { \
+		uint32_t ret; \
+		uint32_t left =3D trp_left_get(a_base, a_field, cur_node); \
+		uint32_t right =3D trp_right_get(a_base, a_field, cur_node); \
+		if (left =3D=3D ~0) { \
+			if (right =3D=3D ~0) \
+				return (~0); \
+		} else if (right =3D=3D ~0 || trp_prio_get(left) < trp_prio_get(righ=
t)) { \
+			trpn_rotate_right(a_base, a_field, cur_node, ret); \
+			right =3D a_pre##remove_recurse(cur_node, rem_node); \
+			trp_right_set(a_base, a_field, ret, right); \
+			return (ret); \
+		} \
+		trpn_rotate_left(a_base, a_field, cur_node, ret); \
+		left =3D a_pre##remove_recurse(cur_node, rem_node); \
+		trp_left_set(a_base, a_field, ret, left); \
+		return (ret); \
+	} else if (cmp < 0) { \
+		uint32_t left =3D a_pre##remove_recurse( \
+			trp_left_get(a_base, a_field, cur_node), rem_node); \
+		trp_left_set(a_base, a_field, cur_node, left); \
+		return (cur_node); \
+	} else { \
+		uint32_t right =3D a_pre##remove_recurse( \
+			trp_right_get(a_base, a_field, cur_node), rem_node); \
+		trp_right_set(a_base, a_field, cur_node, right); \
+		return (cur_node); \
+	} \
+} \
+a_attr void MAYBE_UNUSED a_pre##remove(struct trp_root *treap, a_type =
*node) \
+{ \
+	treap->trp_root =3D a_pre##remove_recurse(treap->trp_root, \
+		trpn_offset(a_base, node)); \
+} \
+
+#endif
diff --git a/vcs-svn/trp.txt b/vcs-svn/trp.txt
new file mode 100644
index 0000000..f387aaa
--- /dev/null
+++ b/vcs-svn/trp.txt
@@ -0,0 +1,90 @@
+treap API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The trp API generates a data structure and functions to handle a
+large growing set of objects stored in a pool.
+
+The caller:
+
+. Specifies parameters for the generated functions with the
+  trp_gen(static, foo_, ...) macro.
+
+. Allocates and clears a `struct trp_node` variable.
+
+. Adds new items to the set using `foo_insert`.
+
+. Can find a specific item in the set using `foo_search`.
+
+. Can iterate over items in the set using `foo_first` and `foo_next`.
+
+. Can remove an item from the set using `foo_remove`.
+
+. The set is never freed.
+
+Example:
+
+----
+struct ex_node {
+	const char *s;
+	struct trp_node ex_link;
+};
+static struct trp_root ex_base;
+obj_pool_gen(ex, struct ex_node, 4096);
+trp_gen(static, ex_, struct ex_node, ex_link, ex, strcmp)
+struct ex_node *item;
+
+item =3D ex_pointer(ex_alloc(1));
+item->s =3D "hello";
+ex_insert(&ex_base, item);
+item =3D ex_pointer(ex_alloc(1));
+item->s =3D "goodbye";
+ex_insert(&ex_base, item);
+for (item =3D ex_first(&ex_base); item; item =3D ex_next(&ex_base, ite=
m))
+	printf("%s\n", item->s);
+----
+
+Functions
+---------
+
+trp_gen(attr, foo_, node_type, link_field, pool, cmp)::
+
+	Generate a type-specific treap implementation.
++
+. The storage class for generated functions will be 'attr' (e.g., `sta=
tic`).
+. Generated function names are prefixed with 'foo_' (e.g., `treap_`).
+. Treap nodes will be of type 'node_type' (e.g., `struct treap_node`).
+  This type must be a struct with at least one `struct trp_node` field
+  to point to its children.
+. The field used to access child nodes will be 'link_field'.
+. All treap nodes must lie in the 'pool' object pool.
+. Treap nodes must be totally ordered by the 'cmp' relation, with the
+  following prototype:
++
+int (*cmp)(node_type \*a, node_type \*b)
++
+and returning a value less than, equal to, or greater than zero
+according to the result of comparison.
+
+void foo_insert(struct trp_root *treap, node_type \*node)::
+
+	Insert node into treap.  If inserted multiple times,
+	a node will appear in the treap multiple times.
+
+void foo_remove(struct trp_root *treap, node_type \*node)::
+
+	Remove node from treap.  Caller must ensure node is
+	present in treap before using this function.
+
+node_type *foo_search(struct trp_root \*treap, node_type \*key)::
+
+	Search for a node that matches key.  If no match is found,
+	return what would be key's successor, were key in treap
+	(NULL if no successor).
+
+node_type *foo_first(struct trp_root \*treap)::
+
+	Find the first item from the treap, in sorted order.
+
+node_type *foo_next(struct trp_root \*treap, node_type \*node)::
+
+	Find the next item.
--=20
1.7.1
