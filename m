From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 05/19] ref-filter: add parse_opt_merge_filter()
Date: Mon, 22 Jun 2015 02:18:19 +0530
Message-ID: <1434919705-4884-5-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:48:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mAi-0005Qm-6Q
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbbFUUsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:48:51 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36248 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbbFUUst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:48:49 -0400
Received: by paceq1 with SMTP id eq1so95264497pac.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jHbk7k6iIdhl3GsMMNK2ngiH0dhOf8qVFHvohjd5fJY=;
        b=LsFAR4aq1KoP8bQlZkSq2g21QzCGsHuadoNLndRntbLYZRxtMTopARquJj+D+kffnR
         ERohfPeCcKvdib67NStjtiKN9G5eWmGqC0Sgxu7baGGkLNbY7mU7wHD1bbQOpKnxgj0y
         uPgbd39z77KkCSJAf/PLGkZB6Ni/GZsmEbw0RTuJYckE9ctiXyMR6zvRlI/i7L0KX0mj
         QKb4ucIKMZJz722yG02aydVuIbxDXxTTkdrsuQsQ2jq9AFJ6MkCJQITBoXjbKr38wJJS
         i2MRM1f7SDUK1+/qL3fbSTpnMw3+SJjCZ6gSr2QO2Ja1dIL3YLvPwWzw+JJU+NqlUKvf
         J2YQ==
X-Received: by 10.68.136.169 with SMTP id qb9mr52330334pbb.47.1434919729541;
        Sun, 21 Jun 2015 13:48:49 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.48.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:48:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272290>

Add 'parse_opt_merge_filter()' to parse '--merged' and '--no-merged'
options and write MACROS for the same.

This is copied from 'builtin/branch.c' which will eventually be removed
when we port 'branch.c' to use ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c |  4 ++++
 ref-filter.c     | 21 +++++++++++++++++++++
 ref-filter.h     | 11 +++++++++++
 3 files changed, 36 insertions(+)

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
index 591e281..6502179 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1125,3 +1125,24 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
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
+	if (!arg)
+		arg = "HEAD";
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
2.4.3.439.gfea0c2a.dirty
