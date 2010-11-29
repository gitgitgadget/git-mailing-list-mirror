From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/6] Introduce sorted-array binary-search function.
Date: Mon, 29 Nov 2010 23:57:16 +0100
Message-ID: <1291071441-11808-2-git-send-email-ydirson@altern.org>
References: <1291071441-11808-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 23:57:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCfJ-0001U5-2a
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab0K2W5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:57:40 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:33217 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab0K2W5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:57:38 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 86757D4807F;
	Mon, 29 Nov 2010 23:57:32 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PNCf5-000356-9s; Mon, 29 Nov 2010 23:57:31 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291071441-11808-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162439>

We use a cpp-based template mechanism to declare the array and its
management data, as well as a search function.
Thanks to Jonathan Nieder for this design idea.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Makefile       |    1 +
 sorted-array.h |  104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 sorted-array.h

diff --git a/Makefile b/Makefile
index 919ed2b..4b26976 100644
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
index 0000000..20219e7
--- /dev/null
+++ b/sorted-array.h
@@ -0,0 +1,104 @@
+#ifndef SORTED_ARRAY_H_
+#define SORTED_ARRAY_H_
+
+#define declare_sorted_array(MAYBESTATIC,ELEMTYPE,LIST)			\
+MAYBESTATIC ELEMTYPE *LIST;						\
+MAYBESTATIC int LIST##_nr, LIST##_alloc;
+
+/* internal func: the implementation */
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
+/*
+ * Returns the position of the element if found pre-existing in the
+ * list, or if not found, -pos-1 where pos is where the element was
+ * inserted if insert_ok, or would have been inserted if !insert_ok.
+ */
+#define declare_sorted_array_search_check(MAYBESTATIC,FUNCNAME,INITTYPE,GENSEARCH,LIST,CMP) \
+MAYBESTATIC int FUNCNAME(INITTYPE data)					\
+{									\
+	return GENSEARCH(LIST, LIST##_nr, CMP, data);			\
+}
+
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
+ * Search for element, inserting it if requested.  Returns address of
+ * the element found or newly-inserted, or NULL if not found and
+ * insertion was not requested.
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
+#endif
-- 
1.7.2.3
