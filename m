From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 08/11] ref-filter: add 'ref-filter.h'
Date: Sun, 14 Jun 2015 01:07:26 +0530
Message-ID: <1434224249-21476-8-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:38:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rGW-0002Nj-14
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbFMTir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:38:47 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33528 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbFMTio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:38:44 -0400
Received: by pdjn11 with SMTP id n11so44683614pdj.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QW59HwKODC4Z1DNugQ2WmhdkBl9Qezyg7XXGVK5W3YU=;
        b=pbcYUQoqDBipmXPA/lYk6+wpGzuWFLZhPhwJvdumxMnmzZH7STkZzbCSnwnCnDm8c4
         aaeuidsFH1O8AugH3MI08zk6ZmAWNsTH/h5lHCRjoKnL8d9C7AT5zHwYkuBli5WecBVe
         mQUXUmn1Xlgl2QL9S9InKCT+Vj4wD8nO/vzQE2j5ZGaTNTz9y9IkMJ4YsWB7SQdsy6gl
         7MqJolp3Me8NT9h+9JzJG/p8dzrcngkuanuYvscEQuNy9eRbs/500u+EpprGwdhBf+Jg
         Y5SHvbP9K+jwZGbeSMVQL+inYOsMBe3XXqCQF04OhSu2/Q23Y1GzbG5aweVL38Bu/VMG
         8oeA==
X-Received: by 10.68.131.225 with SMTP id op1mr33911463pbb.86.1434224323851;
        Sat, 13 Jun 2015 12:38:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.38.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:38:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271570>

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
index d11059b..26485b9 100644
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
-
 static struct {
 	const char *name;
 	cmp_type cmp_type;
diff --git a/ref-filter.h b/ref-filter.h
new file mode 100644
index 0000000..506ac8f
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
+	int atom; /* index into used_atom array (internal) */
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
2.4.3.435.g2403634.dirty
