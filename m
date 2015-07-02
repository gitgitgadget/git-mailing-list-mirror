From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 02/11] tag: libify parse_opt_points_at()
Date: Thu,  2 Jul 2015 20:51:01 +0530
Message-ID: <1435850470-5175-2-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgJB-00007w-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbGBPVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:21:39 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35171 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbGBPV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:21:26 -0400
Received: by pactm7 with SMTP id tm7so42011300pac.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h36Tz3yDclB6TpB1inIGHQ4vMTjOTytdAEs2A2b8Gb4=;
        b=K8FfeuZ/1QVUcWDWF2ZjtiaTSKxiBIFoItUPeLPoQXPjwK5aNYe51rMCfdZlEGKuX/
         kS4Hq78rQwqDHYSO3vqJL1WTZ2CcBKYkx+9hpSAN80R97fn8WrbVlTdIL2YfLS3GxZes
         MnKs83ts8w/r9D7zObV8UN+gPSLoAIk3J1ovYwAfA39reK1/gdAjjISd6e8ReX16QgiP
         nxdsprDwHdqFpsRYQK+vQHUU1SxEZxiuj1I2eVvZpwtktMDV2r03e0+nb7hqmolxVuS8
         l7jK8Kzd3d+SRCjwJ125CD8RsvONUmLVo6xb/2yl6Ng/3kVo9Xwp4jqq86DrV5jz0n5R
         b9hA==
X-Received: by 10.68.244.73 with SMTP id xe9mr66950868pbc.98.1435850484244;
        Thu, 02 Jul 2015 08:21:24 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.21.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:21:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273235>

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
index ca865f6..1478818 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -223,6 +223,7 @@ extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
+extern int parse_opt_object_name(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
-- 
2.4.4
