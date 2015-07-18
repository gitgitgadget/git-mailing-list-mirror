From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 4/9] ref-filter: add support to sort by version
Date: Sun, 19 Jul 2015 00:42:24 +0530
Message-ID: <1437246749-14423-5-git-send-email-Karthik.188@gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 21:12:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGXXb-0001IN-2V
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 21:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbbGRTMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 15:12:51 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35295 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbGRTMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 15:12:50 -0400
Received: by pdrg1 with SMTP id g1so79350668pdr.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dI2KY6ocK7HSVfBxJwzbQrZTo+D/QdpJhdfuU9J9yBw=;
        b=ddl55JoB/c15US1GnIU14bMBFi2R7i7EAmxJYBZ6sbCGLwgSsHdufEPJ3djrcbBUF3
         7khkTEqGjiWzbN38rdhqF3UUhamx8ugsn7rO6/1vluRiPouBM5uwKdhS7JfK93ZZoALk
         vbtmpTdfYYyLR1kghSzoeJeilS7z4YYoN1iExkqHn7CS+FYi29w+vCYCtnlI5TR2P2oS
         hR06pkQS7ojbGAkep071ms5ERJ2RVbzPsCLLAKXc+1/IYuwFjoTOp2Iy6SzC8RzaUHyI
         wnKND2pQRaZAkV40Ecuage3ZXxt2iCbnoOwCm21HHGhcNSzHg8lyCa84vc8epI80hvGh
         53xQ==
X-Received: by 10.66.55.66 with SMTP id q2mr41849537pap.94.1437246769519;
        Sat, 18 Jul 2015 12:12:49 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ra10sm15104498pab.19.2015.07.18.12.12.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jul 2015 12:12:48 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274172>

From: Karthik Nayak <karthik.188@gmail.com>

Add support to sort by version using the "v:refname" and
"version:refname" option. This is achieved by using the
'version_cmp()' function as the comparing function for qsort.

This option is included to support sorting by versions in `git tag -l`
which will eventaully be ported to use ref-filter APIs.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  2 ++
 ref-filter.c                       | 32 ++++++++++++++++++++------------
 ref-filter.h                       |  2 +-
 t/t6302-for-each-ref-filter.sh     | 26 ++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..cc91275 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -144,6 +144,8 @@ blank line.  Finally, the optional GPG signature is `contents:signature`.
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
 All other fields are used to sort in their byte-value order.
+There is also an option to sort by versions, this is done using the
+field names ('version:refname' or 'v:refname').
 
 In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
diff --git a/ref-filter.c b/ref-filter.c
index 82731ac..85c561e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -12,6 +12,7 @@
 #include "revision.h"
 #include "utf8.h"
 #include "git-compat-util.h"
+#include "version.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1169,18 +1170,22 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 
 	get_ref_atom_value(a, s->atom, &va);
 	get_ref_atom_value(b, s->atom, &vb);
-	switch (cmp_type) {
-	case FIELD_STR:
-		cmp = strcmp(va->s, vb->s);
-		break;
-	default:
-		if (va->ul < vb->ul)
-			cmp = -1;
-		else if (va->ul == vb->ul)
-			cmp = 0;
-		else
-			cmp = 1;
-		break;
+	if (s->version)
+		cmp = versioncmp(va->s, vb->s);
+	else {
+		switch (cmp_type) {
+		case FIELD_STR:
+			cmp = strcmp(va->s, vb->s);
+			break;
+		default:
+			if (va->ul < vb->ul)
+				cmp = -1;
+			else if (va->ul == vb->ul)
+				cmp = 0;
+			else
+				cmp = 1;
+			break;
+		}
 	}
 	return (s->reverse) ? -cmp : cmp;
 }
@@ -1395,6 +1400,9 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
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
index 7dfdea0..6f1646b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -25,7 +25,7 @@ struct atom_value {
 struct ref_sorting {
 	struct ref_sorting *next;
 	int atom; /* index into used_atom array (internal) */
-	unsigned reverse : 1;
+	unsigned reverse : 1, version : 1;
 };
 
 struct ref_array_item {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..c31fd2f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,30 @@ test_expect_success 'filtering with --contains' '
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
