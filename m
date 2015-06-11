From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 09/12] ref-filter: add 'ref-filter.h'
Date: Thu, 11 Jun 2015 21:40:00 +0530
Message-ID: <1434039003-10928-9-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:11:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z354F-0006do-9A
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbbFKQKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:10:49 -0400
Received: from mail-pd0-f195.google.com ([209.85.192.195]:35102 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbbFKQKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:10:45 -0400
Received: by pdbht2 with SMTP id ht2so2161733pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=29EXMYQTpX02KOsNyIZK/khC5dwlUAu2W9dM6g87m1A=;
        b=0QpAYvMhFgxFy2Opiox5FT4azmuM5ylB90NAbDK6eA+KDu69mVtB2DowNGZwAKSh9S
         eDgmSvxAhNR/DBAlIfV2tkKrPU0MAEUk6L2I2Cq3Sw8kKZrAVlwr/b2okd66QRaN8Dqn
         KeeDgZy6EdNzj7T7vB5ALP4UPO9CVVzIEix+dG1j7gawSwSY0RnCeSVE4L1DYAWCdML5
         YApDBULbvTACRn58xavdQ8i0rNHMm3HwvpPWp+evHoCALbyKg9535x/1kRfnmIT6JfOV
         FvPjfrtlw3dW3SOedCbnFFqg1JBnTKfxbMIzkyPnBoZ+79DD+tq8pVNGS5gRGz8t0N9Q
         S5xA==
X-Received: by 10.70.18.130 with SMTP id w2mr15830581pdd.73.1434039045462;
        Thu, 11 Jun 2015 09:10:45 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:10:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271429>

This is step one of creating a common library for 'for-each-ref',
'branch -l' and 'tag -l'. This creates a header file with the
functions and data structures that ref-filter will provide.
We move the data structures created in for-each-ref to this header
file.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 41 +------------------------------
 ref-filter.h           | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 40 deletions(-)
 create mode 100644 ref-filter.h

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3cf456a..2fbbc59 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -10,49 +10,10 @@
 #include "parse-options.h"
 #include "remote.h"
 #include "color.h"
-
-/* Quoting styles */
-#define QUOTE_NONE 0
-#define QUOTE_SHELL 1
-#define QUOTE_PERL 2
-#define QUOTE_PYTHON 4
-#define QUOTE_TCL 8
+#include "ref-filter.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
-struct atom_value {
-	const char *s;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-};
-
-struct ref_sorting {
-	struct ref_sorting *next;
-	int atom; /* index into 'struct atom_value *' array */
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
-
 static struct {
 	const char *name;
 	cmp_type cmp_type;
diff --git a/ref-filter.h b/ref-filter.h
new file mode 100644
index 0000000..d9e043f
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
+struct ref_sorting {
+	struct ref_sorting *next;
+	int atom; /* index into 'struct atom_value *' array */
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
+int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data);
+/*  Clear all memory allocated to ref_array */
+void ref_array_clear(struct ref_array *array);
+/*  Parse format string and sort specifiers */
+int parse_ref_filter_atom(const char *atom, const char *ep);
+/*  Used to verify if the given format is correct and to parse out the used atoms */
+int verify_ref_format(const char *format);
+/*  Sort the given ref_array as per the ref_sorting provided */
+void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
+/*  Print the ref using the given format and quote_style */
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
+/*  Callback function for parsing the sort option */
+int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
+/*  Default sort option based on refname */
+struct ref_sorting *ref_default_sorting(void);
+
+#endif /*  REF_FILTER_H  */
-- 
2.4.2
