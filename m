From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 06/11] ref-filter: add support to sort by version
Date: Mon, 27 Jul 2015 12:57:10 +0530
Message-ID: <1437982035-6658-6-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 09:27:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJcox-0000kk-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbbG0H13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:27:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35002 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbG0H12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:27:28 -0400
Received: by pabkd10 with SMTP id kd10so47115778pab.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cDDY/F70HMerGEBXzJEog457y9fjI6QpY3evogcJUjk=;
        b=ATDMGbmtK+7bvZgaqgJdTOe8yuD8J7uAMeZov1U63R54eacHceDuTQ8xDOPLwyntZB
         GAWbadYiVlzABL1f8WmmL8FUIeAQOAzesT+IUBrkHNtrKRuggEbHmfOHdSmS4AV0pE+B
         lAhPg/3Gg6EXRatJ+ABHU3CzkZtoDYUPyzwv75ELI5XLjJJPqVCtRI4ABLbAbQPQE9tj
         BROHZ9bXZXj3SeV55Qe2meFzNnk2xIXx/RSoyEHh+v38HjDEV6E81hfzxIBb29yxDKQg
         tMRmEMfHc2KnsFAyFTFV+n5VCbB+PFAIMQwvn5usqn4ZmyOzTUZg6wg37HXemmez8id5
         s7+w==
X-Received: by 10.66.62.202 with SMTP id a10mr65627592pas.42.1437982046890;
        Mon, 27 Jul 2015 00:27:26 -0700 (PDT)
Received: from ashley.localdomain ([106.51.241.234])
        by smtp.gmail.com with ESMTPSA id wv4sm27732769pac.2.2015.07.27.00.27.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 00:27:26 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274656>

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
index 45dd7f8..2b60aee 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -151,6 +151,9 @@ For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
 All other fields are used to sort in their byte-value order.
 
+There is also an option to sort by versions, this can be done by using
+the fieldname `version:refname` or in short `v:refname`.
+
 In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
 returns an empty string instead.
diff --git a/ref-filter.c b/ref-filter.c
index 1605252..26eb26c 100644
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
 
@@ -1420,6 +1421,9 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
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
index 570fc3a..5406721 100644
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
index daaa27a..de872db 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -97,4 +97,40 @@ test_expect_success 'padding to the right using `padright`' '
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
