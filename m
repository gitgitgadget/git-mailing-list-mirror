From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/6] Introduce sorted-array binary-search function.
Date: Wed,  8 Dec 2010 23:51:30 +0100
Message-ID: <1291848695-24601-2-git-send-email-ydirson@altern.org>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 23:52:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSs2-0003GC-VK
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab0LHWvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:51:48 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49430 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098Ab0LHWvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:51:46 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 216A5D48021;
	Wed,  8 Dec 2010 23:51:39 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQSrK-0006Pi-Vg; Wed, 08 Dec 2010 23:51:38 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163238>

We use a cpp-based template mechanism to declare the array and its
management data, as well as a search function.
Thanks to Jonathan Nieder for this design idea.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/technical/api-sorted-array.txt |  132 ++++++++++++++++++++++++++
 Makefile                                     |    1 +
 sorted-array.h                               |  128 +++++++++++++++++++++++++
 3 files changed, 261 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-sorted-array.txt
 create mode 100644 sorted-array.h

diff --git a/Documentation/technical/api-sorted-array.txt b/Documentation/technical/api-sorted-array.txt
new file mode 100644
index 0000000..b1238ad
--- /dev/null
+++ b/Documentation/technical/api-sorted-array.txt
@@ -0,0 +1,132 @@
+sorted-array API
+================
+
+The sorted-array API is meant to provide efficient binary-search
+functions into a C array of elements of arbitrary type, and insert
+functions that maintain ordering.
+
+It is meant for data structures where lookup time is much more
+important than insertion type: while lookup has o(log(n)) time
+complexity, insertion has o(n) and involves many copies.
+
+API overview
+------------
+
+The API allow to declare all variables and function as static or not,
+through the first argument to all macros, which can be `static` or
+empty.
+
+It is based on the idea of providing custom functions, which will then
+be used by generic algorithms:
+* one for comparing a search term with an array item
+* one for initializing a new array item from a search term after insertion
+
+A set of convenience wrapper macros are provided, to define a readable
+API for inserting and sorting.
+
+Note that the type of the search term can be different from the type
+of array elements (which can be more expensive to create).
+
+API reference
+-------------
+
+The macros can be categorized as follows:
+
+* the one used to define a sorted array, and its management variable
+  holding currently-allocated number of elements and number of
+  elements effectively used.  The name of those (int) management
+  variables are crafted by using the `LISTNAME` and appending
+  respectively `_alloc` and `_nr`.
++
+----
+declare_sorted_array(MAYBESTATIC,ELEMTYPE,LISTNAME)
+----
++
+eg:
++
+----
+declare_sorted_array(static, struct diff_rename_dst, rename_dst);
+----
+
+* those defining ready-for-use search and insert functions.  They
+  exist in several flavours, distinguished by their suffix, which
+  refer to different return-type semantics.
++
+----
+declare_sorted_array_search_*(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,LISTNAME,CMP)
+declare_sorted_array_insert_*(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENSEARCH,LISTNAME,CMP,INIT)
+----
++
+They all work by defining behind the scene a (static) generic search or insert
+function named with `_gen_` prepended to `FUNCNAME`.  Such generic functions
+may be useful to know about if you need to define an insert function with
+the exact same parameters.
++
+All functions of a given type (search or insert) take the same kind of
+arguments:
+
+`MAYBESTATIC`::
+	the ubiquitous `static`or empty placeholder
+`ELEMTYPE`::
+	type of element to be stored in the array
+`FUNCNAME`::
+	name of the function to be defined
+`INITTYPE`::
+	type of search term / initializer passed as argument to the
+	generated function
+`LISTNAME`::
+	name of the array in which the search takes place, usually declared
+	through `declare_sorted_array()`
+`CMP`::
+	comparison function taking an INITTYPE argument and a
+	pointer to an ELEMTYPE argument, and returning an int with
+	the same meaning as `strcmp()`.
+`GENSEARCH`::
+	(insert only) generic search function generated by
+	`declare_gen_binsearch()`
+`INIT`::
+	(insert only) element-initializer function taking as arguments
+	pointer to the ELEMTYPE to be initialized, and an INITTYPE argument
+	to take information from
+
+
+Suffix meanings are as follows:
+
+`check`::
+
+	Returns the position of the element if found pre-existing in
+	the list, or if not found, (-pos - 1) where pos is where the
+	element would have been (for search funcs) or has been (for
+	insert funcs) inserted.
+
+`checkbool`::
+
+	Returns an int, just telling whether the searched element was
+	pre-existing in the list (1) or not (0).
+
+`elem`::
+
+	Returns NULL if the search term was not found (for search
+	funcs), or a pointer to the element found or newly inserted.
+
+* those defining even-more-ready-for-use insert functions, which do
+  not need to define the generic search function at all.  Those macro
+  names are the same as the forms with an `GENSEARCH` argument, but
+  with a name ending in `_insertonly_*`, and without that `GENSEARCH`
+  argument.  The generic (static) search functions are named as
+  `_gensearch` prepended to the `FUNCNAME` argument.
+
+* those defining the generic algorithms
++
+They rarely need to be used directly, they are usually expanded
+transparently from the `declare_sorted_array_*` macros.
++
+----
+declare_gen_binsearch(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE)
+declare_gen_sorted_insert(MAYBESTATIC,ELEMTYPE,FUNCNAME,SEARCHFUNC,INITTYPE)
+----
+
+* those defining the individual wrappers
++
+They rarely need to be used directly, they are usually expanded
+transparently from the `declare_sorted_array_*` macros.
diff --git a/Makefile b/Makefile
index 7eb948d..522261e 100644
--- a/Makefile
+++ b/Makefile
@@ -544,6 +544,7 @@ LIB_H += run-command.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
+LIB_H += sorted-array.h
 LIB_H += strbuf.h
 LIB_H += string-list.h
 LIB_H += submodule.h
diff --git a/sorted-array.h b/sorted-array.h
new file mode 100644
index 0000000..added0e
--- /dev/null
+++ b/sorted-array.h
@@ -0,0 +1,128 @@
+#ifndef SORTED_ARRAY_H_
+#define SORTED_ARRAY_H_
+
+/*
+ * Sorted-array management.
+ * See Documentation/technical/api-sorted-array.txt
+ */
+
+#define declare_sorted_array(MAYBESTATIC,ELEMTYPE,LIST)			\
+MAYBESTATIC ELEMTYPE *LIST;						\
+MAYBESTATIC int LIST##_nr, LIST##_alloc;
+
+#define declare_gen_binsearch(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE)	\
+MAYBESTATIC int FUNCNAME(						\
+	ELEMTYPE *list, int list_nr,					\
+	int(*cmp_func)(INITTYPE ref, ELEMTYPE *elem),			\
+	INITTYPE data)							\
+{									\
+	int lo, hi;							\
+									\
+	lo = 0;								\
+	hi = list_nr;							\
+	while (hi > lo) {						\
+		int mid = (hi + lo) >> 1;				\
+		int cmp = cmp_func(data, list + mid);			\
+		if (!cmp)						\
+			return mid;					\
+		if (cmp < 0)						\
+			hi = mid;					\
+		else							\
+			lo = mid + 1;					\
+	}								\
+	return -lo - 1;							\
+}
+
+#define declare_gen_sorted_insert(MAYBESTATIC,ELEMTYPE,FUNCNAME,SEARCHFUNC,INITTYPE) \
+MAYBESTATIC int FUNCNAME(						\
+	ELEMTYPE **list_p, int *list_nr_p, int *list_alloc_p,		\
+	int(*cmp_func)(INITTYPE ref, ELEMTYPE *elem),			\
+	void(*init_func)(ELEMTYPE *elem, INITTYPE init),		\
+	INITTYPE data)							\
+{									\
+	int pos = SEARCHFUNC(*list_p, *list_nr_p, cmp_func, data);	\
+	if (pos >= 0) 							\
+		return pos;						\
+	/* not found */							\
+	pos = -pos - 1;							\
+	/* insert to make it at "pos" */				\
+	if (*list_alloc_p <= *list_nr_p) {				\
+		(*list_alloc_p) = alloc_nr((*list_alloc_p));		\
+		*list_p = xrealloc(*list_p,				\
+				   (*list_alloc_p) * sizeof(**list_p)); \
+	}								\
+	(*list_nr_p)++;							\
+	if (pos < *list_nr_p)						\
+		memmove(*list_p + pos + 1, *list_p + pos,		\
+			(*list_nr_p - pos - 1) * sizeof(**list_p));	\
+	init_func(&(*list_p)[pos], data);				\
+	return -pos - 1;						\
+}
+
+#define _declare_sorted_array_search_check(MAYBESTATIC,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP) \
+MAYBESTATIC int FUNCNAME(INITTYPE data)					\
+{									\
+	return GENSEARCH(LIST, LIST##_nr, CMP, data);			\
+}
+#define declare_sorted_array_search_check(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,LIST,CMP) \
+  declare_gen_binsearch(MAYBESTATIC,ELEMTYPE,_gen_##FUNCNAME,INITTYPE); \
+  _declare_sorted_array_search_check(MAYBESTATIC,FUNCNAME,INITTYPE,_gen_##FUNCNAME,LIST,CMP);
+
+#define _declare_sorted_array_insert_check(MAYBESTATIC,FUNCNAME,INITTYPE,GENINSERT,LIST,CMP,INIT) \
+MAYBESTATIC int FUNCNAME(INITTYPE data)					\
+{									\
+	return GENINSERT(&LIST, &LIST##_nr, &LIST##_alloc,		\
+			 CMP, INIT, data);				\
+}
+#define declare_sorted_array_insert_check(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP,INIT) \
+  declare_gen_sorted_insert(static,ELEMTYPE,_gen_##FUNCNAME,GENSEARCH,INITTYPE); \
+  _declare_sorted_array_insert_check(MAYBESTATIC,FUNCNAME,INITTYPE,_gen_##FUNCNAME,LIST,CMP,INIT);
+#define declare_sorted_array_insertonly_check(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,LIST,CMP,INIT) \
+  declare_gen_binsearch(static,ELEMTYPE,_gensearch_##FUNCNAME,INITTYPE); \
+  declare_sorted_array_insert_check(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,_gensearch_##FUNCNAME,LIST,CMP,INIT);
+
+#define _declare_sorted_array_insert_checkbool(MAYBESTATIC,FUNCNAME,INITTYPE,GENINSERT,LIST,CMP,INIT) \
+MAYBESTATIC int FUNCNAME(INITTYPE data)					\
+{									\
+	int idx = GENINSERT(&LIST, &LIST##_nr, &LIST##_alloc,		\
+			    CMP, INIT, data);				\
+	if (idx < 0)							\
+		return 0;						\
+	return 1;							\
+}
+#define declare_sorted_array_insert_checkbool(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP,INIT) \
+  declare_gen_sorted_insert(static,ELEMTYPE,_gen_##FUNCNAME,GENSEARCH,INITTYPE); \
+  _declare_sorted_array_insert_checkbool(MAYBESTATIC,FUNCNAME,INITTYPE,_gen_##FUNCNAME,LIST,CMP,INIT);
+#define declare_sorted_array_insertonly_checkbool(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,LIST,CMP,INIT) \
+  declare_gen_binsearch(static,ELEMTYPE,_gensearch_##FUNCNAME,INITTYPE); \
+  declare_sorted_array_insert_checkbool(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,_gensearch_##FUNCNAME,LIST,CMP,INIT);
+
+#define _declare_sorted_array_search_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP) \
+MAYBESTATIC ELEMTYPE *FUNCNAME(INITTYPE data)				\
+{									\
+	int idx = GENSEARCH(LIST, LIST##_nr, CMP, data);		\
+	if (idx < 0)							\
+		return NULL;						\
+	return &(LIST[idx]);						\
+}
+#define declare_sorted_array_search_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,LIST,CMP) \
+  declare_gen_binsearch(static,ELEMTYPE,_gen_##FUNCNAME,INITTYPE); \
+  _declare_sorted_array_search_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,_gen_##FUNCNAME,LIST,CMP);
+
+#define _declare_sorted_array_insert_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENINSERT,LIST,CMP,INIT) \
+MAYBESTATIC ELEMTYPE *FUNCNAME(INITTYPE data)				\
+{									\
+	int idx = GENINSERT(&LIST, &LIST##_nr, &LIST##_alloc,		\
+			    CMP, INIT, data);				\
+	if (idx < 0)							\
+		idx = -idx - 1;						\
+	return &(LIST[idx]);						\
+}
+#define declare_sorted_array_insert_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP,INIT) \
+  declare_gen_sorted_insert(static,ELEMTYPE,_gen_##FUNCNAME,GENSEARCH,INITTYPE); \
+  _declare_sorted_array_insert_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,_gen_##FUNCNAME,LIST,CMP,INIT);
+#define declare_sorted_array_insertonly_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,LIST,CMP,INIT) \
+  declare_gen_binsearch(static,ELEMTYPE,_gensearch_##FUNCNAME,INITTYPE); \
+  declare_sorted_array_insert_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,_gensearch_##FUNCNAME,LIST,CMP,INIT);
+
+#endif
-- 
1.7.2.3
