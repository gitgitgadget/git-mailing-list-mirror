From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Sat, 30 May 2015 23:23:31 +0530
Message-ID: <1433008411-8550-8-git-send-email-karthik.188@gmail.com>
References: <5569EF77.4010300@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 19:54:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yyky7-0006JL-Fx
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbbE3Ry0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:54:26 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35024 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbbE3RyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:54:18 -0400
Received: by padjw17 with SMTP id jw17so7396341pad.2
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AHekjYBSqfSWtAqZJqa1F3OhqvPDaUra6WwNPOZUv4=;
        b=p1vtrzYklEiHJJwFUHHaSZc/MdqGgssND92VYEkZdWEETyuWHMzgyUqZd7UOIBP6zB
         rTAUkWXl85pEOlrhfm2KuVTlH1yJbZOgx6yVLDavPwcUUBEiWsmGzP+cWe1Zcnd8Hoew
         OeJlO1aXnWQUDG5CFmmGHpVh4ONHbUnPFrLAx4DQ3hmrZWXNGipWlqDEPfN8/U8A5Xj2
         uh+XUq0MR6hNaftlyRQZKQnWmLnmzKGy7aV2s0hQ+yUM35cndpAPlH4yc4BOVxF6GjRW
         +O6ZBlaF7HWGugWOs/BvFPhpcyosphfnqjQGMKI8oVb3ZRfAe/41h6UVPzhKVP4r0/8/
         O+hA==
X-Received: by 10.66.55.41 with SMTP id o9mr25547157pap.148.1433008458222;
        Sat, 30 May 2015 10:54:18 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ob15sm9317839pdb.40.2015.05.30.10.54.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 May 2015 10:54:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5569EF77.4010300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270301>

Create 'ref-filter.h', also add ref-filter to the Makefile.
This completes movement of creation of 'ref-filter' from
'for-each-ref'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile               |  1 +
 builtin/for-each-ref.c | 41 +------------------------------
 ref-filter.c           |  1 +
 ref-filter.h           | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 40 deletions(-)
 create mode 100644 ref-filter.h

diff --git a/Makefile b/Makefile
index 323c401..ad455a3 100644
--- a/Makefile
+++ b/Makefile
@@ -762,6 +762,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 65ed954..2f11c01 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -2,46 +2,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "parse-options.h"
-
-/* Quoting styles */
-#define QUOTE_NONE 0
-#define QUOTE_SHELL 1
-#define QUOTE_PERL 2
-#define QUOTE_PYTHON 4
-#define QUOTE_TCL 8
-
-struct atom_value {
-	const char *s;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-};
-
-struct ref_sort {
-	struct ref_sort *next;
-	int atom; /* index into used_atom array */
-	unsigned reverse : 1;
-};
-
-struct ref_array_item {
-	unsigned char objectname[20];
-	int flag;
-	const char *symref;
-	struct atom_value *value;
-	char *refname;
-};
-
-struct ref_array {
-	int nr, alloc;
-	struct ref_array_item **items;
-};
-
-struct ref_filter {
-	const char **name_patterns;
-};
-
-struct ref_filter_cbdata {
-	struct ref_array array;
-	struct ref_filter filter;
-};
+#include "ref-filter.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
diff --git a/ref-filter.c b/ref-filter.c
index 2a8f504..1c73750 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "ref-filter.h"
 #include "wildmatch.h"
 #include "commit.h"
 #include "remote.h"
diff --git a/ref-filter.h b/ref-filter.h
new file mode 100644
index 0000000..dacae59
--- /dev/null
+++ b/ref-filter.h
@@ -0,0 +1,66 @@
+#ifndef REF_FILTER_H
+#define REF_FILTER_H
+
+#include "sha1-array.h"
+#include "refs.h"
+#include "commit.h"
+#include "parse-options.h"
+
+/* Quoting styles */
+#define QUOTE_NONE 0
+#define QUOTE_SHELL 1
+#define QUOTE_PERL 2
+#define QUOTE_PYTHON 4
+#define QUOTE_TCL 8
+
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
+struct ref_array_item {
+	unsigned char objectname[20];
+	int flag;
+	const char *symref;
+	struct atom_value *value;
+	char *refname;
+};
+
+struct ref_array {
+	int nr, alloc;
+	struct ref_array_item **items;
+};
+
+struct ref_filter {
+	const char **name_patterns;
+};
+
+struct ref_filter_cbdata {
+	struct ref_array array;
+	struct ref_filter filter;
+};
+
+/*  Callback function for for_each_*ref(). This filters the refs based on the filters set */
+int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data);
+/*  Clear all memory allocated to ref_filter_data */
+void ref_filter_clear_data(struct ref_filter_cbdata *ref_cbdata);
+/*  Parse format string and sort specifiers */
+int parse_ref_filter_atom(const char *atom, const char *ep);
+/*  Used to verify if the given format is correct and to parse out the used atoms */
+int verify_ref_format(const char *format);
+/*  Sort the given ref_array as per the ref_sort provided */
+void sort_ref_array(struct ref_sort *sort, struct ref_array *array);
+/*  Print the ref using the given format and quote_style */
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
+/*  Callback function for parsing the sort option */
+int opt_parse_ref_sort(const struct option *opt, const char *arg, int unset);
+/*  Default sort option based on refname */
+struct ref_sort *ref_default_sort(void);
+
+#endif /*  REF_FILTER_H  */
-- 
2.4.2
