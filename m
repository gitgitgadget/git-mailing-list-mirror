From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/10] ref-filter: adopt get_head_description() from branch.c
Date: Thu,  8 Oct 2015 14:48:00 +0530
Message-ID: <1444295885-1657-6-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:18:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7LE-0007dw-NM
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbbJHJSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:21 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33309 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbbJHJSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:17 -0400
Received: by pacex6 with SMTP id ex6so49744928pac.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/qn4gf42qaSKeXvp7SsIYvYa3es97wePqMyAm6xP6Dk=;
        b=OrTwGLyJHJm+xdDprPoPL7XremednVcgbNynmg741nJGUZt+pFXyI2VRGVBNeIjedg
         wtyp+h8FCnjaI7a7lMoj0DTrXNGrJ69XyZ77i/+X4L7QgnbiC0FC4w2kkq59/iu3W3bd
         cSw9Fw77PBH5fo1+2ivcP8yegh2B32qPkWExcCQRHavjeaPfNylHt/4ox1Ov9gJO6wwV
         pqxZStCe21bgKpF/jrzbTYefGF+Q4Kg6+I7E2eXgPWnmYlMTS+iXDELcr27l48+fxRtq
         /65HyrKx7DHR31Yi9fZGucVmyATY0NdzqN1hBvScUKxpRu/qTeebRAwKxZfH6lwA6wkt
         /CEQ==
X-Received: by 10.68.219.4 with SMTP id pk4mr7028141pbc.138.1444295897354;
        Thu, 08 Oct 2015 02:18:17 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:16 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279228>

Copy the implementation of get_head_description() from branch.c.  This
gives a description of the HEAD ref if called. This is used as the
refname for the HEAD ref whenever the FILTER_REFS_DETACHED_HEAD option
is used. Make it public because we need it to calculate the length of
the HEAD refs description in branch.c:calc_maxwidth() when we port
branch.c to use ref-filter APIs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c |  4 ++++
 ref-filter.c     | 38 ++++++++++++++++++++++++++++++++++++--
 ref-filter.h     |  2 ++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b7a60f4..67ef9f1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -355,6 +355,10 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
 	strbuf_release(&subject);
 }
 
+/*
+ * This is duplicated in ref-filter.c, will be removed when we adopt
+ * ref-filter's printing APIs.
+ */
 static char *get_head_description(void)
 {
 	struct strbuf desc = STRBUF_INIT;
diff --git a/ref-filter.c b/ref-filter.c
index de4d451..a3cc3af 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "git-compat-util.h"
 #include "version.h"
+#include "wt-status.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -916,6 +917,37 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+char *get_head_description(void)
+{
+	struct strbuf desc = STRBUF_INIT;
+	struct wt_status_state state;
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state, 1);
+	if (state.rebase_in_progress ||
+	    state.rebase_interactive_in_progress)
+		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
+			    state.branch);
+	else if (state.bisect_in_progress)
+		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
+			    state.branch);
+	else if (state.detached_from) {
+		/* TRANSLATORS: make sure these match _("HEAD detached at ")
+		   and _("HEAD detached from ") in wt-status.c */
+		if (state.detached_at)
+			strbuf_addf(&desc, _("(HEAD detached at %s)"),
+				state.detached_from);
+		else
+			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+				state.detached_from);
+	}
+	else
+		strbuf_addstr(&desc, _("(no branch)"));
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+	return strbuf_detach(&desc, NULL);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -954,9 +986,11 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (starts_with(name, "refname")) {
 			refname = ref->refname;
-		else if (starts_with(name, "symref"))
+			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+				refname = get_head_description();
+		} else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e..4aea594 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -106,5 +106,7 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
+/*  Get the current HEAD's description */
+char *get_head_description(void);
 
 #endif /*  REF_FILTER_H  */
-- 
2.6.0
