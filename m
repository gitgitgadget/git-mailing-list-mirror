From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 05/10] ref-filter: add support to sort by version
Date: Sat, 25 Jul 2015 00:34:40 +0530
Message-ID: <1437764685-8633-6-git-send-email-Karthik.188@gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:05:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiHv-0003eN-MP
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbbGXTFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:05:32 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32887 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065AbbGXTF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:05:28 -0400
Received: by pdbnt7 with SMTP id nt7so17609886pdb.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ksOwIWWRhwzpDnlX0Ke8KbBYXZ7kklzuGcMVlXpjCto=;
        b=XVXSZdYE0IpWDd+EpsHqXUndd4ZogIDkx9NaA+H5MwkmmmHiuRXDuNp+D0NTuC6KoJ
         XPuBKdJCfEXJcb+tqCmJiqeMX63VjXrQBtpc8aS8PaOJ916s/Z5vjv14hQuvOArBv7We
         kyu4tdsvkx3G+OJZs9eujYCFPAlOtl6+/PZpJYDu+6c9TVjTFHPL9LWPoe4N8vt4qmng
         a0qgaEt1ObhLDv5Mgpw9lR/rmKx53Nyv83WT8+lX63hEW/fbwjHp3+YSY+ezmjTw6zvZ
         2thUeUjLUaw+n/BeED142rta0WYPrraTePwu7qUEo1tFyfBLz1rpZiSKf2sU1BcIdaQs
         paHA==
X-Received: by 10.70.42.105 with SMTP id n9mr34587191pdl.78.1437764728048;
        Fri, 24 Jul 2015 12:05:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ns14sm15922915pdb.17.2015.07.24.12.05.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:05:27 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274582>

From: Karthik Nayak <karthik.188@gmail.com>

Add support to sort by version using the "v:refname" and
"version:refname" option. This is achieved by using the 'versioncmp()'
function as the comparing function for qsort.

This option is included to support sorting by versions in `git tag -l`
which will eventaully be ported to use ref-filter APIs.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 26 ++++++++++++++------------
 ref-filter.h                       |  3 ++-
 t/t6302-for-each-ref-filter.sh     | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..224dc8c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -145,6 +145,9 @@ For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
 All other fields are used to sort in their byte-value order.
 
+There is also an option to sort by versions, this can be done by using
+the fieldname `version:refname` or in short `v:refname`.
+
 In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
 returns an empty string instead.
diff --git a/ref-filter.c b/ref-filter.c
index 08ecce5..8f2148f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -12,6 +12,7 @@
 #include "revision.h"
 #include "utf8.h"
 #include "git-compat-util.h"
+#include "version.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1180,19 +1181,17 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 
 	get_ref_atom_value(&state, a, s->atom, &va);
 	get_ref_atom_value(&state, b, s->atom, &vb);
-	switch (cmp_type) {
-	case FIELD_STR:
+	if (s->version)
+		cmp = versioncmp(va->s, vb->s);
+	else if (cmp_type == FIELD_STR)
 		cmp = strcmp(va->s, vb->s);
-		break;
-	default:
-		if (va->ul < vb->ul)
-			cmp = -1;
-		else if (va->ul == vb->ul)
-			cmp = 0;
-		else
-			cmp = 1;
-		break;
-	}
+	else if (va->ul < vb->ul)
+		cmp = -1;
+	else if (va->ul == vb->ul)
+		cmp = 0;
+	else
+		cmp = 1;
+
 	return (s->reverse) ? -cmp : cmp;
 }
 
@@ -1420,6 +1419,9 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 		s->reverse = 1;
 		arg++;
 	}
+	if (skip_prefix(arg, "version:", &arg) ||
+	    skip_prefix(arg, "v:", &arg))
+		s->version = 1;
 	len = strlen(arg);
 	s->atom = parse_ref_filter_atom(arg, arg+len);
 	return 0;
diff --git a/ref-filter.h b/ref-filter.h
index 1e2ee65..a12fe0c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -26,7 +26,8 @@ struct atom_value {
 struct ref_sorting {
 	struct ref_sorting *next;
 	int atom; /* index into used_atom array (internal) */
-	unsigned reverse : 1;
+	unsigned reverse : 1,
+		version : 1;
 };
 
 struct ref_formatting_state {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..5017032 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,40 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for version sort' '
+	test_commit foo1.3 &&
+	test_commit foo1.6 &&
+	test_commit foo1.10
+'
+
+test_expect_success 'version sort' '
+	git tag -l --sort=version:refname | grep "foo" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'version sort (shortened)' '
+	git tag -l --sort=v:refname | grep "foo" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'reverse version sort' '
+	git tag -l --sort=-version:refname | grep "foo" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.6
+	foo1.3
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
