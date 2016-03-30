From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 05/16] ref-filter: move get_head_description() from branch.c
Date: Wed, 30 Mar 2016 15:09:49 +0530
Message-ID: <1459330800-12525-6-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCc5-0001fQ-V2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbcC3JkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:24 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33637 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbcC3JkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id zm5so36435116pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VJCW+J9RCZRNVlH1jb6COr1NYPN+LraZeLRX+MyU/4E=;
        b=Fyk0LmtIajWXybUlqUhbaAPVdRuJX1DnyhKigjkaMq5Pw4t8kit3Ze05aDIjudrCrv
         hKElucWdklu5Y+y5AdwLXuOE2XcNzvZmSaz/hPbPxSvG4Rg+MAoMBBwBnCH4l+8YwDW/
         pRUVUY0FHNj/+q6Fx5Y11CTV/L5lAnUvlpqWux1sk8DEMVXmEaJ4p1SjlH3g4ZV0HEGI
         PQFFDdjSw3bWzepzxW+Ff2O4FgUilp25dY+T8ykgZSUmmzC/N5vEjk1n3rmfi0mIYZ/i
         2YVdi3Uefi3QuLcSFZah2Ax8mv0K/FGKnGL1kuvLkj6ee9u0h3XczP79Z+CNoXM70vrc
         TcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VJCW+J9RCZRNVlH1jb6COr1NYPN+LraZeLRX+MyU/4E=;
        b=CS3OrFmV8FR6eWYzdPWJMB/Q0XqWEm+nVKsXwTsW0Q83fIuOJ0FbtodHfsYOCX+l+r
         6PuPoF2jE2guDZtzsyE38vSo7xfQy7mIa/pqCP6LKSyZHwievTUJVzZ8gp/g1v40pE9z
         9dXLQrSMebka7vF8WmNcFlOFenz4vyHfXFqArGYVFN5MAW0hRz7KOfENPM+zNo+AdmvA
         WNfA/x1aDuMKPNyInSVDTrkSp45dx+N2ZPMrZK74cAk/ARwECX6zuIdQ7oJ+/Ez1HBlH
         K4Sh+V5un0BG4oWu5mAwDeZHqk3vav+n4c2hjp6lJZOp9DWY3fwk7RXhaPS4D0lz0vcF
         5eQg==
X-Gm-Message-State: AD7BkJK6Ri4o5Auxc+i6KtuErCB4P8Jy9YDKeiA8Pf3q61KVojxVmYYd1diyc8V7BYLn7A==
X-Received: by 10.66.102.70 with SMTP id fm6mr11313231pab.98.1459330821490;
        Wed, 30 Mar 2016 02:40:21 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:20 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290286>

Move the implementation of get_head_description() from branch.c to
ref-filter.  This gives a description of the HEAD ref if called. This
is used as the refname for the HEAD ref whenever the
FILTER_REFS_DETACHED_HEAD option is used. Make it public because we
need it to calculate the length of the HEAD refs description in
branch.c:calc_maxwidth() when we port branch.c to use ref-filter
APIs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 31 -------------------------------
 ref-filter.c     | 38 ++++++++++++++++++++++++++++++++++++--
 ref-filter.h     |  2 ++
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..460f32f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -355,37 +355,6 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
 	strbuf_release(&subject);
 }
 
-static char *get_head_description(void)
-{
-	struct strbuf desc = STRBUF_INIT;
-	struct wt_status_state state;
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
-	if (state.rebase_in_progress ||
-	    state.rebase_interactive_in_progress)
-		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
-			    state.branch);
-	else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
-			    state.branch);
-	else if (state.detached_from) {
-		/* TRANSLATORS: make sure these match _("HEAD detached at ")
-		   and _("HEAD detached from ") in wt-status.c */
-		if (state.detached_at)
-			strbuf_addf(&desc, _("(HEAD detached at %s)"),
-				state.detached_from);
-		else
-			strbuf_addf(&desc, _("(HEAD detached from %s)"),
-				state.detached_from);
-	}
-	else
-		strbuf_addstr(&desc, _("(no branch)"));
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
-	return strbuf_detach(&desc, NULL);
-}
-
 static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 				      struct ref_filter *filter, const char *remote_prefix)
 {
diff --git a/ref-filter.c b/ref-filter.c
index 17f781d..7004bf0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "git-compat-util.h"
 #include "version.h"
+#include "wt-status.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1077,6 +1078,37 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = refname;
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
@@ -1116,9 +1148,11 @@ static void populate_value(struct ref_array_item *ref)
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
2.7.4
