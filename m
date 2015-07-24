From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 03/10] ref-filter: add option to filter only tags
Date: Sat, 25 Jul 2015 00:34:38 +0530
Message-ID: <1437764685-8633-4-git-send-email-Karthik.188@gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:05:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiHj-0003TL-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbbGXTF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:05:26 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35319 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbbGXTFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:05:23 -0400
Received: by pabkd10 with SMTP id kd10so18513301pab.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mvfiMTSqNeCuju/0HanQKaeHqBJUpjRYTkMfpc1T2qE=;
        b=MnpTt9flfE6/z5yerYK4svmSMNkrZ2dHt6pY09zkok4bNxAEplNZDxvKFSpV4/Pdf/
         ZfjORYNaqcVNUZUmoHZPAtKvzN2RpFe8Lx1TLrLe7pvNLG5Q6BiBkud8yWDIZxQkg8MR
         2Ya+aEUDi93tSWATnO+6awwTOXfCoZTIniwomSaRwolCyatfMnxmpnNjFwPOiTbYtVat
         84DWnfNCWg96Ahs8NVCuXgs4r/thSMvUoz7iWMfIgn1x399EMUrVgrevwGaERGcS4qDM
         4TL3ZorzuqsI8MbJjDAPEPSQkRADlAY67aVMZO7Z91KLQCBIJ0TJUYqmZ5BAQ95TymyH
         YTkA==
X-Received: by 10.66.119.201 with SMTP id kw9mr34663788pab.49.1437764722696;
        Fri, 24 Jul 2015 12:05:22 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ns14sm15922915pdb.17.2015.07.24.12.05.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:05:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274581>

From: Karthik Nayak <karthik.188@gmail.com>

Add a functions called 'for_each_tag_ref_fullpath()' to refs.{c,h}
which iterates through each tag ref without trimming the path.

Add an option in 'filter_refs()' to use 'for_each_tag_ref_fullpath()'
and filter refs. This type checking is done by adding a
'FILTER_REFS_TAGS' in 'ref-filter.h'

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 2 ++
 ref-filter.h | 1 +
 refs.c       | 5 +++++
 refs.h       | 1 +
 4 files changed, 9 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index fd13a23..34e6603 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1157,6 +1157,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index bacbb23..729dece 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,6 +15,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 struct atom_value {
 	const char *s;
diff --git a/refs.c b/refs.c
index ce8cd8d..b679fce 100644
--- a/refs.c
+++ b/refs.c
@@ -2103,6 +2103,11 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
+int for_each_tag_ref_fullpath(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(&ref_cache, "refs/tags/", fn, 0, 0, cb_data);
+}
+
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
diff --git a/refs.h b/refs.h
index e82fca5..e5d53d3 100644
--- a/refs.h
+++ b/refs.h
@@ -174,6 +174,7 @@ extern int head_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_tag_ref_fullpath(each_ref_fn fn, void *cb_data);
 extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
-- 
2.4.6
