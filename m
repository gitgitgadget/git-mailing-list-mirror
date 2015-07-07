From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 05/11] ref-filter: add parse_opt_merge_filter()
Date: Tue,  7 Jul 2015 21:36:11 +0530
Message-ID: <1436285177-12279-5-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVP6-0001Xn-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757988AbbGGQHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:24 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34850 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbGGQHP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:15 -0400
Received: by pdbci14 with SMTP id ci14so128172748pdb.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sn7vkZTHdCVSHn6tm9b1EU4ruW+h1f+R6MZCfwdJQrA=;
        b=z5WCH3tWUj/KXqfOnf3MTNjVdZTx3DbuQ6JUth6+yrz+p5xXKXs1oO7KQxkL/9oiCP
         A1S8ZRdKGalSio5dr4Xb0F+COAk4VP2RYzDnV0quKTcKsCNJO8QuauxyEG7LUec9PVSq
         Tj3aeOcwLcRvyFhA6LIEWY7dFcPwK1y8Kz8EuD+GInfmLLWZVl+K/P3UgksvhK1C1WXw
         f4uj+9sLpF7x/aOLQkzCSbXqOmia8MgCrKWyvl9cDS79NPaYSYWVw7wh16qVUra0hEVt
         sL0vP4yfUGBHehBLnikln41wdTiAlXyqmc4nvesGkAxFRPbw3QI0PUyLtr9zJnBiGSGn
         XR7g==
X-Received: by 10.70.65.99 with SMTP id w3mr10538712pds.132.1436285235136;
        Tue, 07 Jul 2015 09:07:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.07.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:07:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273575>

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
index 58e532c..b4753ab 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1139,3 +1139,22 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
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
index c2856b8..443cfa7 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -50,6 +50,15 @@ struct ref_filter_cbdata {
 	struct ref_filter *filter;
 };
 
+/*  Macros for checking --merged and --no-merged options */
+#define _OPT_MERGED_NO_MERGED(option, filter, h) \
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
2.4.5
