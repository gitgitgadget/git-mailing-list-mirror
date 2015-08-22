From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 07/12] ref-filter: add support to sort by version
Date: Sat, 22 Aug 2015 09:09:43 +0530
Message-ID: <1440214788-1309-8-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzf6-0002IM-DH
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbbHVDkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:40:05 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35511 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbbHVDkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:40:03 -0400
Received: by pdob1 with SMTP id b1so32861618pdo.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HlzjnhAtrIBPXekKiXPp6F8hIDUhKN2hYrtcoXB66/I=;
        b=bX73+fkM/LQyY3nI/48ejCLECWUGE3te+F2ba99lgj8/HJCtaosZXHPIvzIVlboWAK
         ShA4cClMVGF2uYKAkxIZvYUlXRbmd3q3lvhXwa/sFthczdB4Wjg5HG6nca6CP7WGTtry
         4WNbYSxT2slLIW5bPDGs0G/qOzMFQkqkao4IQhJGJZh95Kf68Uyny7TOR1ZpMlijxxNp
         9jIRVpt64Hv8Ke1bRCTZzAIqf8/wAy7T8ftHuDFA+nb9JbaB882fsajvae7oreOe89Kb
         tL/tL0upjAVDIMoJ77UT4YzmhyBVd4uUjsXdVgnwJX9JzuEmnTGxylprnz51ALw0Hn9I
         Ws6g==
X-Received: by 10.70.7.162 with SMTP id k2mr23461516pda.128.1440214803038;
        Fri, 21 Aug 2015 20:40:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.40.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:40:02 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276370>

From: Karthik Nayak <karthik.188@gmail.com>

Add support to sort by version using the "v:refname" and
"version:refname" option. This is achieved by using the 'versioncmp()'
function as the comparing function for qsort.

This option is included to support sorting by versions in `git tag -l`
which will eventually be ported to use ref-filter APIs.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 15 ++++++++++-----
 ref-filter.h                       |  3 ++-
 t/t6302-for-each-ref-filter.sh     | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 943975d..06d468e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -154,6 +154,9 @@ For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
 All other fields are used to sort in their byte-value order.
 
+There is also an option to sort by versions, this can be done by using
+the fieldname `version:refname` or its alias `v:refname`.
+
 In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
 returns an empty string instead.
diff --git a/ref-filter.c b/ref-filter.c
index 515147b..b4a7d72 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -11,6 +11,8 @@
 #include "ref-filter.h"
 #include "revision.h"
 #include "utf8.h"
+#include "git-compat-util.h"
+#include "version.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1327,19 +1329,19 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 
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
 
@@ -1559,6 +1561,9 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
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
index c599ea2..5aa2f40 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -27,7 +27,8 @@ struct atom_value;
 struct ref_sorting {
 	struct ref_sorting *next;
 	int atom; /* index into used_atom array (internal) */
-	unsigned reverse : 1;
+	unsigned reverse : 1,
+		version : 1;
 };
 
 struct ref_array_item {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 227992b..38c99c9 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -150,4 +150,40 @@ test_expect_success 'alignment with format quote' '
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
2.5.0
