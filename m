From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 02/11] tag: libify parse_opt_points_at()
Date: Tue, 16 Jun 2015 19:50:48 +0530
Message-ID: <1434464457-10749-2-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:25:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rmu-0005sY-6E
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680AbbFPOYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:24:22 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36501 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115AbbFPOYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:24:16 -0400
Received: by pdjm12 with SMTP id m12so15493507pdj.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xniJp1oDvkSArMv6ZZE8qIkVtEvcBwe54BHTlfQrCO8=;
        b=NyDinUA2SFLcqKYwd2iBwclIHA8Wq5dn+RWQTXnpUcs0JsDG8od1Zev3vgLnk+6sFC
         MnCfDVY9Fv0yUq73bh07pZ60FEMIVMwSbn6oxrIesw/+EIdeuT+LzsdidI11OvAXTDEe
         g6PXaie6HYExZ+31nM2iZ925gp5yURQjy1YtPqAI9K/thqUJsKVBnyqF47WCLQsu7MYd
         40m2AkfcFMFIwQqWugFKzYEdvbq6xK7tUZXMmHdSfNHlpiCcfPKazAhR2+6rV0BQGaXc
         VIUfG/fmLIFrZP9P2N0KgPUd00DpCx6sAdWVpbcb5mKmNHhqUTWQwdzA+CCnOyAXtjka
         ZY8Q==
X-Received: by 10.66.101.9 with SMTP id fc9mr1061645pab.37.1434464655073;
        Tue, 16 Jun 2015 07:24:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm1594145pda.54.2015.06.16.07.24.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 07:24:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.436.g722e2ce.dirty
In-Reply-To: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271756>

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
2.4.3.436.g722e2ce.dirty
