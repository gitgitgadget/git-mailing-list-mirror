From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/4] ref-filter: add ref-filter API
Date: Wed, 20 May 2015 18:48:22 +0530
Message-ID: <1432127904-21070-2-git-send-email-karthik.188@gmail.com>
References: <555C88C2.8060902@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, christian.couder@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 15:19:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv3tl-0002PL-0J
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 15:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbbETNS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 09:18:58 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36387 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbbETNSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 09:18:54 -0400
Received: by pdfh10 with SMTP id h10so68759160pdf.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nr2B64lJx5sidVccW8QXNlQ2TOur7pBtuEHKZWZir+o=;
        b=Kvti4+KPqVHoDN2pNnsb70YOWoW9JFRAwK8xkuxe4MWMrFv6hbjPSOJpVvJYliwAQR
         NP8kIReDGYBfCvBwVJvCgNPW7BWi1xiv4g5FC9XG6elcU8mIppF8rHS9yEmhJcRZzZoC
         98lUx2vFEQYOWlTRfFwAPLFgd+liztPNJwshFlDVbXCFt96Soefr2v6y7//KY/YrBBBA
         Wx7BlkleLY8y9k/Nd6CWhh+V+rgkC0H5nmjs4OrnRn9nVUIkU7D9msQdwQ8zuRMVzQVt
         quhnxK3KmnfYDXoOsh8tJCQViAK5HCDiuF2HCER5EqedBf27gOiyz8iYh+QzFa5LsbA1
         BI1g==
X-Received: by 10.66.100.233 with SMTP id fb9mr62322226pab.128.1432127934037;
        Wed, 20 May 2015 06:18:54 -0700 (PDT)
Received: from ashley.localdomain ([106.51.128.148])
        by mx.google.com with ESMTPSA id g2sm16230585pdn.3.2015.05.20.06.18.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 06:18:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <555C88C2.8060902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269462>

add a ref-filter API to provide functions to filter refs for listing.
This will act as a common library for commands like 'tag -l',
'branch -l' and 'for-each-ref'. ref-filter will enable each of these
commands to benefit from the features of the others.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile     |  1 +
 ref-filter.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ref-filter.h | 47 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 ref-filter.c
 create mode 100644 ref-filter.h

diff --git a/Makefile b/Makefile
index 5f3987f..1e03bda 100644
--- a/Makefile
+++ b/Makefile
@@ -759,6 +759,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
diff --git a/ref-filter.c b/ref-filter.c
new file mode 100644
index 0000000..df571a6
--- /dev/null
+++ b/ref-filter.c
@@ -0,0 +1,73 @@
+#include "builtin.h"
+#include "cache.h"
+#include "refs.h"
+#include "ref-filter.h"
+#include "wildmatch.h"
+#include "commit.h"
+
+static int match_name_as_path(const char **pattern, const char *refname)
+{
+	int namelen = strlen(refname);
+	for (; *pattern; pattern++) {
+		const char *p = *pattern;
+		int plen = strlen(p);
+
+		if ((plen <= namelen) &&
+		    !strncmp(refname, p, plen) &&
+		    (refname[plen] == '\0' ||
+		     refname[plen] == '/' ||
+		     p[plen-1] == '/'))
+			return 1;
+		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
+			return 1;
+	}
+	return 0;
+}
+
+static struct ref_filter_item *new_ref_filter_item(const char *refname,
+						   const unsigned char *sha1,
+						   int flag)
+{
+	struct ref_filter_item *ref =  xcalloc(1, sizeof(struct ref_filter_item));
+	ref->name = xstrdup(refname);
+	hashcpy(ref->sha1, sha1);
+	ref->flags = flag;
+
+	return ref;
+}
+
+/*
+ * A call-back given to for_each_ref().  Filter refs and keep them for
+ * later object processing.
+ */
+int ref_filter_add(const char *refname, const unsigned char *sha1, int flag, void *data)
+{
+	struct ref_filter *ref_list = data;
+	struct ref_filter_item *ref;
+
+	if (flag & REF_BAD_NAME) {
+		warning("ignoring ref with broken name %s", refname);
+		return 0;
+	}
+
+	if (*ref_list->name_patterns && !match_name_as_path(ref_list->name_patterns, refname))
+		return 0;
+
+	ref = new_ref_filter_item(refname, sha1, flag);
+
+	REALLOC_ARRAY(ref_list->items, ref_list->count + 1);
+	ref_list->items[ref_list->count++] = ref;
+
+	return 0;
+}
+
+void ref_filter_clear(struct ref_filter *refs)
+{
+	int i;
+
+	for (i = 0; i < refs->count; i++)
+		free(refs->items[i]);
+	free(refs->items);
+	refs->items = NULL;
+	refs->count = refs->alloc = 0;
+}
diff --git a/ref-filter.h b/ref-filter.h
new file mode 100644
index 0000000..3010d13
--- /dev/null
+++ b/ref-filter.h
@@ -0,0 +1,47 @@
+#ifndef REF_FILTER_H
+#define REF_FILTER_H
+
+#include "sha1-array.h"
+#include "refs.h"
+#include "commit.h"
+
+/*
+ * ref-filter is meant to act as a common provider of API's for
+ * 'tag -l', 'branch -l' and 'for-each-ref'. ref-filter is the attempt
+ * at unification of these three commands so that they ay benefit from
+ * the functionality of each other.
+ */
+
+/* An atom is a valid field atom used for sorting and formatting of refs.*/
+struct atom_value {
+	const char *s;
+	unsigned long ul; /* used for sorting when not FIELD_STR */
+};
+
+struct ref_sort {
+	struct ref_sort *next;
+	int atom; /* index into used_atom array */
+	unsigned reverse : 1;
+};
+
+/* ref_filter_item will hold the data pertaining to a particular ref. */
+struct ref_filter_item {
+	unsigned char sha1[20];
+	int flags;
+	const char *symref;
+	struct atom_value *value;
+	char *name;
+};
+
+/*  ref_filter will hold data pertaining to a list of refs. */
+struct ref_filter {
+	int count, alloc;
+	struct ref_filter_item **items;
+	const char **name_patterns;
+};
+
+/*  ref_filter_add is used to add refs to the ref_filter list. */
+int ref_filter_add(const char *refname, const unsigned char *sha1, int flags, void *data);
+void ref_filter_clear(struct ref_filter *refs);
+
+#endif /*  REF_FILTER_H  */
-- 
2.4.1
