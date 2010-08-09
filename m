From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/10] Add treap implementation
Date: Mon, 9 Aug 2010 17:17:34 -0500
Message-ID: <20100809221734.GE4203@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiah6-0007Oe-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab0HIWTF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 18:19:05 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39099 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab0HIWTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:19:03 -0400
Received: by qyk7 with SMTP id 7so2657048qyk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=F6UdiU98nG2MYXKfPOV/H+U9iB5y8IB06tSevLlrzZU=;
        b=Y8F94kL9Tp5kx8HMi+38CA6qK0TiMb9+jNrsUhoZf0qBLkgh7yRV0pdc0VqAONQ8aE
         mlVd2Q31Fv1P7dLpyiq0AVH8OLtAeDKrGm60XXiOu1DYimDVP+tfYWnQjtOMbzQsoC/f
         rUgcOZyrORTiTfZAgjiAlH/I5UqvE5h2urjdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mQO9jtEVJVvBzU4yDSqav+ljOxZc2QOvS5ECBOlPEzhmtSm4fTuriDCb41qoABEzWy
         XG9A0YoZf22FZifmSUsA/QGje8cnzcikUxb/YYzGlzCp7Vy1W2h1en/zcsHIbVJUgE18
         yaIf9hemKGjWMQIkzAXtPWGnfEFtwkw60bjOc=
Received: by 10.220.121.233 with SMTP id i41mr10015204vcr.3.1281392341874;
        Mon, 09 Aug 2010 15:19:01 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id i23sm1145670vcr.34.2010.08.09.15.18.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:19:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153039>

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
[rr: Squelched compiler warnings]
[db: Added support for immutable treap nodes]
[jn: Reintroduced treap_nsearch(); with tests]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
With the treap_nsearch() fixup from last time squashed in and some
more history in the log message.

 .gitignore         |    1 +
 Makefile           |    3 +-
 t/t0080-vcs-svn.sh |   22 +++++
 test-treap.c       |   65 ++++++++++++++
 vcs-svn/LICENSE    |    3 +
 vcs-svn/trp.h      |  236 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 vcs-svn/trp.txt    |  103 +++++++++++++++++++++++
 7 files changed, 432 insertions(+), 1 deletions(-)
 create mode 100644 test-treap.c
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt

diff --git a/.gitignore b/.gitignore
index 1e64a6a..af47653 100644
--- a/.gitignore
+++ b/.gitignore
@@ -173,6 +173,7 @@
 /test-run-command
 /test-sha1
 /test-sigchain
+/test-treap
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index eb471e7..e7c33ec 100644
--- a/Makefile
+++ b/Makefile
@@ -415,6 +415,7 @@ TEST_PROGRAMS_NEED_X +=3D test-path-utils
 TEST_PROGRAMS_NEED_X +=3D test-run-command
 TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
+TEST_PROGRAMS_NEED_X +=3D test-treap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
@@ -1865,7 +1866,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
=20
 $(VCSSVN_OBJS): \
-	vcs-svn/obj_pool.h
+	vcs-svn/obj_pool.h vcs-svn/trp.h
 endif
=20
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
index 3f29496..ce02c58 100755
--- a/t/t0080-vcs-svn.sh
+++ b/t/t0080-vcs-svn.sh
@@ -76,4 +76,26 @@ test_expect_success 'obj pool: high-water mark' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'treap sort' '
+	cat <<-\EOF >unsorted &&
+	68
+	12
+	13
+	13
+	68
+	13
+	13
+	21
+	10
+	11
+	12
+	13
+	13
+	EOF
+	sort unsorted >expected &&
+
+	test-treap <unsorted >actual &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/test-treap.c b/test-treap.c
new file mode 100644
index 0000000..cdba511
--- /dev/null
+++ b/test-treap.c
@@ -0,0 +1,65 @@
+/*
+ * test-treap.c: code to exercise the svn importer's treap structure
+ */
+
+#include "cache.h"
+#include "vcs-svn/obj_pool.h"
+#include "vcs-svn/trp.h"
+
+struct int_node {
+	uintmax_t n;
+	struct trp_node children;
+};
+
+obj_pool_gen(node, struct int_node, 3)
+
+static int node_cmp(struct int_node *a, struct int_node *b)
+{
+	return (a->n > b->n) - (a->n < b->n);
+}
+
+trp_gen(static, treap_, struct int_node, children, node, node_cmp)
+
+static void strtonode(struct int_node *item, const char *s)
+{
+	char *end;
+	item->n =3D strtoumax(s, &end, 10);
+	if (*s =3D=3D '\0' || (*end !=3D '\n' && *end !=3D '\0'))
+		die("invalid integer: %s", s);
+}
+
+int main(int argc, char *argv[])
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct trp_root root =3D { ~0 };
+	uint32_t item;
+
+	if (argc !=3D 1)
+		usage("test-treap < ints");
+
+	while (strbuf_getline(&sb, stdin, '\n') !=3D EOF) {
+		item =3D node_alloc(1);
+		strtonode(node_pointer(item), sb.buf);
+		treap_insert(&root, node_pointer(item));
+	}
+
+	item =3D node_offset(treap_first(&root));
+	while (~item) {
+		uint32_t next;
+		struct int_node *tmp =3D node_pointer(node_alloc(1));
+
+		tmp->n =3D node_pointer(item)->n;
+		next =3D node_offset(treap_next(&root, node_pointer(item)));
+
+		treap_remove(&root, node_pointer(item));
+		item =3D node_offset(treap_nsearch(&root, tmp));
+
+		if (item !=3D next && (!~item || node_pointer(item)->n !=3D tmp->n))
+			die("found %"PRIuMAX" in place of %"PRIuMAX"",
+				~item ? node_pointer(item)->n : ~(uintmax_t) 0,
+				~next ? node_pointer(next)->n : ~(uintmax_t) 0);
+		printf("%"PRIuMAX"\n", tmp->n);
+	}
+	node_reset();
+	return 0;
+}
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
index 0000000..1f5f51f
--- /dev/null
+++ b/vcs-svn/trp.h
@@ -0,0 +1,236 @@
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
+		if (cmp < 0) { \
+			ret =3D trp_left_get(a_base, a_field, ret); \
+		} else { \
+			ret =3D trp_right_get(a_base, a_field, ret); \
+		} \
+	} \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr a_type MAYBE_UNUSED *a_pre##nsearch(struct trp_root *treap, a_t=
ype *key) \
+{ \
+	int cmp; \
+	uint32_t ret =3D treap->trp_root; \
+	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base,ret)))) { \
+		if (cmp < 0) { \
+			if (!~trp_left_get(a_base, a_field, ret)) \
+				break; \
+			ret =3D trp_left_get(a_base, a_field, ret); \
+		} else { \
+			ret =3D trp_right_get(a_base, a_field, ret); \
+		} \
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
index 0000000..eb4c191
--- /dev/null
+++ b/vcs-svn/trp.txt
@@ -0,0 +1,103 @@
+Motivation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Treaps provide a memory-efficient binary search tree structure.
+Insertion/deletion/search are about as about as fast in the average
+case as red-black trees and the chances of worst-case behavior are
+vanishingly small, thanks to (pseudo-)randomness.  The bad worst-case
+behavior is a small price to pay, given that treaps are much simpler
+to implement.
+
+API
+=3D=3D=3D
+
+The trp API generates a data structure and functions to handle a
+large growing set of objects stored in a pool.
+
+The caller:
+
+. Specifies parameters for the generated functions with the
+  trp_gen(static, foo_, ...) macro.
+
+. Allocates a `struct trp_root` variable and sets it to {~0}.
+
+. Adds new nodes to the set using `foo_insert`.
+
+. Can find a specific item in the set using `foo_search`.
+
+. Can iterate over items in the set using `foo_first` and `foo_next`.
+
+. Can remove an item from the set using `foo_remove`.
+
+Example:
+
+----
+struct ex_node {
+	const char *s;
+	struct trp_node ex_link;
+};
+static struct trp_root ex_base =3D {~0};
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
+	result is NULL.
+
+node_type *foo_nsearch(struct trp_root \*treap, node_type \*key)::
+
+	Like `foo_search`, but if if the key is missing return what
+	would be key's successor, were key in treap (NULL if no
+	successor).
+
+node_type *foo_first(struct trp_root \*treap)::
+
+	Find the first item from the treap, in sorted order.
+
+node_type *foo_next(struct trp_root \*treap, node_type \*node)::
+
+	Find the next item.
--=20
1.7.2.1.544.ga752d.dirty
