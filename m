From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 4/9] parse-options: add parse_opt_merge_filter()
Date: Sun,  7 Jun 2015 01:34:07 +0530
Message-ID: <1433621052-5588-4-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKc-0002Lu-Fc
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbbFFUEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:32 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34852 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbbFFUE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:28 -0400
Received: by pdbnf5 with SMTP id nf5so74255157pdb.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BqfxqaFGcNcClb3eerEYsSdXjjTnLMpvYim7GGJ+vu8=;
        b=t36amxch3B1LoAqccn088/G5AqHOwm1WMYgxRo4wcb5SrTQpAiip8xO9/Dk4/UDYwK
         eejsMcK09mkiqq79UmB3v6cYySt60q+7ciAEebCjuSSmDbBX7VmSYsn8EsWyan6QBAfO
         PpvJMI5pJ8JtEq5XPxEYH27eJ64KERxmzPSE3Mh7mUTYsd6ihvCKWlRbBucZ44gLP594
         GJ6Sv6wpt0f9p6BH+AngMH/c4Aky29vwFrBp2As0nH9JL/dgKgSatmVJ1e5UudYGnrXd
         rWQ7057Fpr299wnYS+nW88HV/FQt+lDLOTlvVvJEUzidTMpeDjxE2S9ynZT5xwT/xRTs
         Om9Q==
X-Received: by 10.68.213.198 with SMTP id nu6mr16304045pbc.60.1433621068035;
        Sat, 06 Jun 2015 13:04:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270949>

Add 'parse_opt_merge_filter()' to parse '--merged' and '--no-merged'
options and write MACROS for the same.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 parse-options-cb.c | 22 ++++++++++++++++++++++
 parse-options.h    | 11 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index a4d294d..1969803 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "color.h"
 #include "string-list.h"
+#include "ref-filter.h"
 #include "sha1-array.h"
 
 /*----- some often used options -----*/
@@ -109,6 +110,27 @@ int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_filter *rf = opt->value;
+	unsigned char sha1[20];
+
+	rf->merge = opt->long_name[0] == 'n'
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
+
 int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 {
 	int *target = opt->value;
diff --git a/parse-options.h b/parse-options.h
index 3ae16a1..7bcf0f3 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -221,6 +221,7 @@ extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_points_at(const struct option *, const char *, int);
+extern int parse_opt_merge_filter(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
@@ -243,5 +244,15 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
+#define OPT_NO_MERGED(filter, h) \
+	{ OPTION_CALLBACK, 0, "no-merged", (filter), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
+	  parse_opt_merge_filter, (intptr_t) "HEAD" \
+	}
+#define OPT_MERGED(filter, h) \
+	{ OPTION_CALLBACK, 0, "merged", (filter), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
+	  parse_opt_merge_filter, (intptr_t) "HEAD" \
+	}
 
 #endif
-- 
2.4.2
