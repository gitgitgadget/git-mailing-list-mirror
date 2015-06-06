From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 1/9] tag: libify parse_opt_points_at()
Date: Sun,  7 Jun 2015 01:34:04 +0530
Message-ID: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKP-0002Hf-UM
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbbFFUEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:21 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36268 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbbFFUEU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:20 -0400
Received: by pabqy3 with SMTP id qy3so69168396pab.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8kYnzRQmQh+B4w82hVxvfIE2W3rZECRPMKhE/wgKVIY=;
        b=Y/xRBhm5gW3oETBRIbNiJY59D5X6U/V0IPLgFNMQigPGBM+/6ca0OUjm05AOCpgCPZ
         dv/lOtzNc8LVFzfxubI+PP5WHV26wYjXgOoOBPwHwfNEBqWBfsCbvlDVM5AZXk20h1x8
         zkkLp2gAEpbhnzNg9ikvulmJHSvYM9wMVZaxbcJb1icHYNHvV/19kDpktOgaBcP9S9E7
         9r70rZgDaUmGxvbBVW3UbtTBLETLf8y06OGcVnKsMt2fcxfuZT9FtXFev4rP9dWrK3T3
         Qp9qGLHDKhS58ZgYuTYQhSvOwx5XhNYoriv6dZGA5uRjaiUTkwdknvwULSviX2Cny74p
         xd1g==
X-Received: by 10.69.10.196 with SMTP id ec4mr16406769pbd.69.1433621059592;
        Sat, 06 Jun 2015 13:04:19 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5573520A.90603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270943>

Moving 'parse_opt_points_at()' from 'tag.c' to a common location,
in preparation for using it in 'ref-filter'.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c      | 19 +------------------
 parse-options-cb.c | 17 +++++++++++++++++
 parse-options.h    |  1 +
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 5f6cdc5..eda76ba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -546,23 +546,6 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
-static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
-			const char *arg, int unset)
-{
-	unsigned char sha1[20];
-
-	if (unset) {
-		sha1_array_clear(&points_at);
-		return 0;
-	}
-	if (!arg)
-		return error(_("switch 'points-at' requires an object"));
-	if (get_sha1(arg, sha1))
-		return error(_("malformed object name '%s'"), arg);
-	sha1_array_append(&points_at, sha1);
-	return 0;
-}
-
 static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 {
 	int *sort = opt->value;
@@ -625,7 +608,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
 		{
-			OPTION_CALLBACK, 0, "points-at", NULL, N_("object"),
+			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_points_at
 		},
 		OPT_END()
diff --git a/parse-options-cb.c b/parse-options-cb.c
index be8c413..a4d294d 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "color.h"
 #include "string-list.h"
+#include "sha1-array.h"
 
 /*----- some often used options -----*/
 
@@ -92,6 +93,22 @@ int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
+{
+	unsigned char sha1[20];
+
+	if (unset) {
+		sha1_array_clear(opt->value);
+		return 0;
+	}
+	if (!arg)
+		return -1;
+	if (get_sha1(arg, sha1))
+		return error(_("malformed object name '%s'"), arg);
+	sha1_array_append(opt->value, sha1);
+	return 0;
+}
+
 int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 {
 	int *target = opt->value;
diff --git a/parse-options.h b/parse-options.h
index c71e9da..3ae16a1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -220,6 +220,7 @@ extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
+extern int parse_opt_points_at(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
-- 
2.4.2
