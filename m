From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 02/11] tag: libify parse_opt_points_at()
Date: Thu, 25 Jun 2015 01:23:43 +0530
Message-ID: <1435175632-27803-2-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
 <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 21:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qkS-0007pI-TD
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbbFXTyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:54:08 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35969 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbbFXTyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:54:04 -0400
Received: by pdcu2 with SMTP id u2so37115236pdc.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rOwCSnlhSNUtlx098nJpU8u/xkiwdUptC654ujW6NFw=;
        b=QqJS4scEO85Rzd++PtLTZBTyLtjIYE3+bCqohzAw78lb8RRN+oKv1pgwhzM5WFrL7Y
         8+iqyD5DsaZEHlnz3rN5fujoZ07wdJYae5pw1oyLmcwGkHOHX3n2CoHOPTx3toPBlSH2
         hzEj72mdK1tysGbDqeGYMe5KC0cDypbSdIfdF3Rn1weqxsjnglXHnCfN+oK5uSPnjNiO
         eJRpiUi5WFC0YOrhzdS8wjbbzxyPT7K+hsJq0Y6ApTJpeMaJkqv1OcV930xr3t0bt6LK
         MH4cnz65/4Ht1YmCuwy7R443CptxIIa5Dq69yRmHXYQoQrchDxoOlUFq/Vgj0LJ6UddS
         fOUw==
X-Received: by 10.66.218.6 with SMTP id pc6mr82940467pac.20.1435175643962;
        Wed, 24 Jun 2015 12:54:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id zx1sm27583483pbb.73.2015.06.24.12.54.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272596>

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
