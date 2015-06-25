From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 02/11] tag: libify parse_opt_points_at()
Date: Thu, 25 Jun 2015 14:27:04 +0530
Message-ID: <1435222633-32007-2-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 10:57:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82yQ-0000KM-9C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbbFYI51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:57:27 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34644 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbFYI5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:57:23 -0400
Received: by pdbep18 with SMTP id ep18so27475302pdb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rOwCSnlhSNUtlx098nJpU8u/xkiwdUptC654ujW6NFw=;
        b=m7e8uxrnC88qt4JveszY0YJgt9vL8f68XKbG81dQBbawWZNtwxjntvFM9cHuwXwWrA
         WOrtDQKEDikVvD7qa+owOvtjrL8Hkk01F0V9hKj0zDkuGhwGzjdfRL1MnttFZ1tbiDpi
         7Igw1+AiAMhAYx8YL7GGTDSAMHJTIvyf9Q8kQ430NnyVVOsl/VomXHHHENn0FWPwbtKH
         Bhq61ruy5yGaCKLjYeB/25yzeu+KGafAUO3wdFEMOYWelGj7UD1eXce/8o22wuKRYbIM
         6SNe4tiw880enEJymTvhTvK94E7XvkpjtTHkEOOg0bUHjTHqQ2hm5YypPKpbbM8hTvkU
         iXfA==
X-Received: by 10.70.41.33 with SMTP id c1mr89226490pdl.114.1435222643356;
        Thu, 25 Jun 2015 01:57:23 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id wa4sm29391000pab.17.2015.06.25.01.57.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 01:57:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272642>

Rename 'parse_opt_points_at()' to 'parse_opt_object_name()' and
move it from 'tag.c' to 'parse-options'. This now acts as a common
parse_opt function which accepts an objectname and stores it into
a sha1_array.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c      | 21 ++-------------------
 parse-options-cb.c | 17 +++++++++++++++++
 parse-options.h    |  1 +
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 5f6cdc5..e36c43e 100644
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
@@ -625,8 +608,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
 		{
-			OPTION_CALLBACK, 0, "points-at", NULL, N_("object"),
-			N_("print only tags of the object"), 0, parse_opt_points_at
+			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
+			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
 		OPT_END()
 	};
diff --git a/parse-options-cb.c b/parse-options-cb.c
index be8c413..de75411 100644
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
 
+int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
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
index c71e9da..36c71fe 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -220,6 +220,7 @@ extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
+extern int parse_opt_object_name(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
-- 
2.4.4
