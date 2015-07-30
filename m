From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 06/11] ref-filter: add support to sort by version
Date: Thu, 30 Jul 2015 21:05:47 +0530
Message-ID: <1438270552-10333-6-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:36:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKpsU-0001Bf-BA
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbbG3PgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:36:07 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34302 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbG3PgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:36:05 -0400
Received: by pachj5 with SMTP id hj5so2106422pac.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5o18JvCD6aVrj+nL2N7vln+0pr5bxQqfYv6KMnK0BFY=;
        b=ybReArdqlBpr9QkLrZFiYoWks1RV2ARRJdadfwcZK5jin7hxFXtW2YeUxm+lCprBpk
         dKNQz6rJpOtS6feWKLHIoWjGk8P3yc8sIJHd9gsdR6Tkc6BZTZ9bAlNdtZBzu7JTFwib
         31pY1bsab/7lVIMVxcC9F/ZxCq1gCpeg6hRjvzGT6MmVeb8PQRhrFUy0LDa7BolVu+2x
         eorRI6j/v93D78oEl9EPg3pG8vCbYYXODkkYBdgLaENIvQSO9Um0XUK95QVYeio13TQr
         XgiDWtEpp40QWBEPUvn8aKK3COXAFCaydA8RCwyIcx6VQY8E/9wXTHlyhSBwJAuZZo45
         MCFw==
X-Received: by 10.66.146.100 with SMTP id tb4mr108151006pab.70.1438270564674;
        Thu, 30 Jul 2015 08:36:04 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id oq10sm2790985pdb.75.2015.07.30.08.36.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:36:03 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274998>

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
 ref-filter.c                       | 14 +++++++++-----
 ref-filter.h                       |  3 ++-
 t/t6302-for-each-ref-filter.sh     | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 9961921..bcf319a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -151,6 +151,9 @@ For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
 All other fields are used to sort in their byte-value order.
 
+There is also an option to sort by versions, this can be done by using
+the fieldname `version:refname` or its alias `v:refname`.
+
 In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
 returns an empty string instead.
diff --git a/ref-filter.c b/ref-filter.c
index edb2c38..2b4a853 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -12,6 +12,7 @@
 #include "revision.h"
 #include "utf8.h"
 #include "git-compat-util.h"
+#include "version.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1172,19 +1173,19 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 
 	get_ref_atom_value(a, s->atom, &va);
 	get_ref_atom_value(b, s->atom, &vb);
-	switch (cmp_type) {
-	case FIELD_STR:
+	if (s->version)
+		cmp = versioncmp(va->s, vb->s);
+	else if (cmp_type == FIELD_STR)
 		cmp = strcmp(va->s, vb->s);
-		break;
-	default:
+	else {
 		if (va->ul < vb->ul)
 			cmp = -1;
 		else if (va->ul == vb->ul)
 			cmp = 0;
 		else
 			cmp = 1;
-		break;
 	}
+
 	return (s->reverse) ? -cmp : cmp;
 }
 
@@ -1429,6 +1430,9 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
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
index 4d94ebf..2bdae58 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -34,7 +34,8 @@ struct ref_formatting_state {
 struct ref_sorting {
 	struct ref_sorting *next;
 	int atom; /* index into used_atom array (internal) */
-	unsigned reverse : 1;
+	unsigned reverse : 1,
+		version : 1;
 };
 
 struct ref_array_item {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 48caac9..b9ebb3d 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -113,4 +113,40 @@ test_expect_success 'no padding when `padright` length is smaller than atom leng
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for version sort' '
+	test_commit foo1.3 &&
+	test_commit foo1.6 &&
+	test_commit foo1.10
+'
+
+test_expect_success 'version sort' '
+	git for-each-ref --sort=version:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'version sort (shortened)' '
+	git for-each-ref --sort=v:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'reverse version sort' '
+	git for-each-ref --sort=-version:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
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
