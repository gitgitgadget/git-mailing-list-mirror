From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/6] Introduce sorted-array binary-search function.
Date: Sun,  5 Dec 2010 11:34:02 +0100
Message-ID: <1291545247-4151-2-git-send-email-ydirson@altern.org>
References: <1291545247-4151-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 11:34:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPBvc-0002k7-0P
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 11:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab0LEKe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 05:34:28 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:40118 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab0LEKeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 05:34:25 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 99D5CD48156;
	Sun,  5 Dec 2010 11:34:19 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PPBv8-00015v-Fi; Sun, 05 Dec 2010 11:34:18 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291545247-4151-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162938>

We use a cpp-based template mechanism to declare the array and its
management data, as well as a search function.
Thanks to Jonathan Nieder for this design idea.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Makefile       |    1 +
 sorted-array.h |  153 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 sorted-array.h

diff --git a/Makefile b/Makefile
index 1d42413..ced07df 100644
--- a/Makefile
+++ b/Makefile
@@ -539,6 +539,7 @@ LIB_H += run-command.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
+LIB_H += sorted-array.h
 LIB_H += strbuf.h
 LIB_H += string-list.h
 LIB_H += submodule.h
diff --git a/sorted-array.h b/sorted-array.h
new file mode 100644
index 0000000..dc4be87
--- /dev/null
+++ b/sorted-array.h
@@ -0,0 +1,153 @@
+#ifndef SORTED_ARRAY_H_
+#define SORTED_ARRAY_H_
+
+/*
+ * Declare an array of given type, together with its management
+ * variable holding currently-allocated number of elements and number
+ * of elements effectively used.
+ */
+#define declare_sorted_array(MAYBESTATIC,ELEMTYPE,LIST)			\
+MAYBESTATIC ELEMTYPE *LIST;						\
+MAYBESTATIC int LIST##_nr, LIST##_alloc;
+
+/*
+ * Declare FUNCNAME as a binary-search function on sorted-arrays of
+ * ELEMTYPE elements, search term being be of type INITTYPE.
+ *
+ * The resulting function can act on any ELEMTYPE* list, using any
+ * suitable comparison function taking an INITTYPE argument and a
+ * pointer to an ELEMTYPE argument, and returning an int with the same
+ * meaning as strcmp.  If the element is found, it returns the index
+ * in the list where it was found; if it is not found, it returns
+ * (-pos - 1), where "pos" is the index in the list where the element
+ * would be inserted.
+ *
+ * See below for macros to define more specific functions tailored to
+ * a given list, and with output suitable to various usages.
+ */
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
+/*
+ * Declare FUNCNAME as a function to search for an element in
+ * sorted-arrays of ELEMTYPE elements, inserting it if it was not
+ * found, search term being be of type INITTYPE.  The position where
+ * to insert will be given found by SEARCHFUNC, which must be
+ * compatible with the search functions defined by
+ * declare_gen_binsearch().
+ *
+ * The resulting function takes the same arguments as similar search
+ * functions, with the addition of a function to initialize the
+ * newly-allocated element from the search term.
+ */
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
+/*
+ * Returns the position of the element if found pre-existing in the
+ * list, or if not found, -pos-1 where pos is where the element would
+ * have been inserted.
+ */
+#define declare_sorted_array_search_check(MAYBESTATIC,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP) \
+MAYBESTATIC int FUNCNAME(INITTYPE data)					\
+{									\
+	return GENSEARCH(LIST, LIST##_nr, CMP, data);			\
+}
+
+/*
+ * Returns the position of the element if found pre-existing in the
+ * list, or if not found inserts it, and returns -pos-1 where pos is
+ * where the element was inserted.
+ */
+#define declare_sorted_array_insert_check(MAYBESTATIC,FUNCNAME,INITTYPE,GENINSERT,LIST,CMP,INIT) \
+MAYBESTATIC int FUNCNAME(INITTYPE data)					\
+{									\
+	return GENINSERT(&LIST, &LIST##_nr, &LIST##_alloc,		\
+			 CMP, INIT, data);				\
+}
+
+/*
+ * Insert, and just tell whether the searched element was pre-existing
+ * in the list or not.
+ */
+#define declare_sorted_array_insert_checkbool(MAYBESTATIC,FUNCNAME,INITTYPE,GENINSERT,LIST,CMP,INIT) \
+MAYBESTATIC int FUNCNAME(INITTYPE data)					\
+{									\
+	int idx = GENINSERT(&LIST, &LIST##_nr, &LIST##_alloc,		\
+			    CMP, INIT, data);				\
+	if (idx < 0)							\
+		return 0;						\
+	return 1;							\
+}
+
+/*
+ * Search for element.  Returns address of the element found, or NULL
+ * if not found.
+ */
+#define declare_sorted_array_search_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP) \
+MAYBESTATIC ELEMTYPE *FUNCNAME(INITTYPE data)				\
+{									\
+	int idx = GENSEARCH(LIST, LIST##_nr, CMP, data);		\
+	if (idx < 0)							\
+		return NULL;						\
+	return &(LIST[idx]);						\
+}
+
+/*
+ * Insert element if not there already.  Returns address of the
+ * element found or newly-inserted.
+ */
+#define declare_sorted_array_insert_elem(MAYBESTATIC,ELEMTYPE,FUNCNAME,INITTYPE,GENINSERT,LIST,CMP,INIT) \
+MAYBESTATIC ELEMTYPE *FUNCNAME(INITTYPE data)				\
+{									\
+	int idx = GENINSERT(&LIST, &LIST##_nr, &LIST##_alloc,		\
+			    CMP, INIT, data);				\
+	if (idx < 0)							\
+		idx = -idx - 1;						\
+	return &(LIST[idx]);						\
+}
+
+#endif
-- 
1.7.2.3
