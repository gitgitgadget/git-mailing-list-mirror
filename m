From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 05/11] ref-filter: add parse_opt_merge_filter()
Date: Thu,  2 Jul 2015 20:51:04 +0530
Message-ID: <1435850470-5175-5-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:22:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgJW-0000I8-Gk
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbGBPWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:22:07 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33428 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbbGBPV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:21:56 -0400
Received: by pdjd13 with SMTP id d13so46895063pdj.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E7lkP7NVUSZuylwdRXDZXYAHlJm/WjFLiQitp169Hy0=;
        b=fHN/hvYxNnVSUCJiBDKaOuJqEe14IjjUXhtKiBc8TCpQkHaiQD/7daxU56W45+OYJv
         ffREucEEA8lKDu8pGvD7mkQqKn4xsUSoNDPM+WczPJqoA2rg/JtuxQzmX8yfjTTecaBn
         K5YuFe/ZaWjsj438qJyhWMompQkcpNfaQjGhtze/UGZ+L4rUAxVccsz0vOeQ/twZCAML
         iO2j2sA1j8KFrJgthX1m4WjRFj09J2iKE5RC5mEt0fiH/rCJQV/9KvNw2etff3qIYz98
         C9Ej5gNZb7ZqAc/ldIn7w2jeMQKP57AW+cNZGf3uIssi3k+ZsM9OBjUfxKr+degXuqbc
         iSSA==
X-Received: by 10.68.243.9 with SMTP id wu9mr4276889pbc.28.1435850515746;
        Thu, 02 Jul 2015 08:21:55 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.21.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:21:54 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273237>

Add 'parse_opt_merge_filter()' to parse '--merged' and '--no-merged'
options and write macros for the same.

This is copied from 'builtin/branch.c' which will eventually be removed
when we port 'branch.c' to use ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c |  4 ++++
 ref-filter.c     | 19 +++++++++++++++++++
 ref-filter.h     | 11 +++++++++++
 3 files changed, 34 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index b42e5b6..ddd90e6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -745,6 +745,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	strbuf_release(&newsection);
 }
 
+/*
+ * This function is duplicated in ref-filter. It will eventually be removed
+ * when we port branch.c to use ref-filter APIs.
+ */
 static int opt_parse_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	merge_filter = ((opt->long_name[0] == 'n')
diff --git a/ref-filter.c b/ref-filter.c
index f1f425e..b57076d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1138,3 +1138,22 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 	s->atom = parse_ref_filter_atom(arg, arg+len);
 	return 0;
 }
+
+int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_filter *rf = opt->value;
+	unsigned char sha1[20];
+
+	rf->merge = starts_with(opt->long_name, "no")
+		? REF_FILTER_MERGED_OMIT
+		: REF_FILTER_MERGED_INCLUDE;
+
+	if (get_sha1(arg, sha1))
+		die(_("malformed object name %s"), arg);
+
+	rf->merge_commit = lookup_commit_reference_gently(sha1, 0);
+	if (!rf->merge_commit)
+		return opterror(opt, "must point to a commit", 0);
+
+	return 0;
+}
diff --git a/ref-filter.h b/ref-filter.h
index c2856b8..ad2902b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -50,6 +50,15 @@ struct ref_filter_cbdata {
 	struct ref_filter *filter;
 };
 
+/*  Macros for checking --merged and --no-merged options */
+#define _OPT_MERGED_NO_MERGED(option, filter, h)				\
+	{ OPTION_CALLBACK, 0, option, (filter), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
+	  parse_opt_merge_filter, (intptr_t) "HEAD" \
+	}
+#define OPT_MERGED(f, h) _OPT_MERGED_NO_MERGED("merged", f, h)
+#define OPT_NO_MERGED(f, h) _OPT_MERGED_NO_MERGED("no-merged", f, h)
+
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
@@ -71,5 +80,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
 struct ref_sorting *ref_default_sorting(void);
+/*  Function to parse --merged and --no-merged options */
+int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
 #endif /*  REF_FILTER_H  */
-- 
2.4.4
