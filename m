From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 05/11] ref-filter: add parse_opt_merge_filter()
Date: Thu, 25 Jun 2015 14:27:07 +0530
Message-ID: <1435222633-32007-5-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 10:57:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82yg-0000Y5-O1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbFYI5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:57:42 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35632 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbbFYI5i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:57:38 -0400
Received: by pactm7 with SMTP id tm7so46100727pac.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ow5gtKPsVd50XIRQOljzMZSjM72+B6nsxEudgRygShw=;
        b=XA0YMeBfy6faLp1d9txxP5cChVqAgBw5S3sFXa3ItRq4ZG1mM0/LO+qgMPHaVQq877
         wO3vXyXzP3ed02Hf57jbYaiPDMvKcSG1nZzDlf6Uqzsvn8yzUqhlCDiohIsuZdK2nOQu
         y781q3eax8DQVarJWOymmi9hJrkcFN0f120lh6soUR3UkKWw4rVtLzHtVzLBNLo18E2O
         vD9FkCzB69mvxU0qNDqevC7fqK9ur8RSt4kH+YTFdu5P2iPRW/d9v0AOHKabYsGq48qd
         pIbQEy6/OHCnyD9Tq2srigZO3n9/o3T6+Tnlcz+NQoLukQVYp0ClGaVzEMgM0T+CmJHY
         U6AQ==
X-Received: by 10.70.129.73 with SMTP id nu9mr69221506pdb.166.1435222657821;
        Thu, 25 Jun 2015 01:57:37 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id wa4sm29391000pab.17.2015.06.25.01.57.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 01:57:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272647>

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
index f40f06e..0c2d67c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1125,3 +1125,22 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
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
