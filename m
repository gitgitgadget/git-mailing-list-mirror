From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 5/9] ref-filter: adopt get_head_description() from branch.c
Date: Fri,  2 Oct 2015 23:09:02 +0530
Message-ID: <1443807546-5985-6-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4Iz-00040e-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbbJBRj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:26 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33691 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbbJBRjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:24 -0400
Received: by padew5 with SMTP id ew5so12560809pad.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YxACKEqQKdCJZOlOkUKDce9FPteBXW/uVxpe/Km4Dys=;
        b=nOOiHU32eN6fLb2zjIIHw2bFDWpLZZBPE+ueU0vHKTAClZcVTpt/XAeFLNcBhyPmh8
         6XvVuEVIGYVfev8CxT0nWzA5RuzezNL3vKzCTARCghYS8mPPnCk0YA5AfRFB7oX/gBEY
         oThRiBr3TZP6L7wOKPeaMzgnl9GfJLS4vl1xH6bv/Hmi2pQzZnzyT97NP31eEYLmx7rX
         qwoYbjlsGWDD4ZOOXeE/mJsJ9VMrCWJIrKD9AuGAVLgLpX2d3sNfyqIlggz/52TZoAPq
         6ERaFVV2GqjIo3Hl3P1jQObfjSTkRZFFpblZ63i4H8Lic6zBdtkR4S/IlD+4RhZ8qqUY
         m4fw==
X-Received: by 10.66.251.136 with SMTP id zk8mr21725815pac.143.1443807564188;
        Fri, 02 Oct 2015 10:39:24 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:23 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278927>

Copy the implementation of get_head_description() from branch.c.
This gives a description of the HEAD ref if called. This is used as
the refname for the HEAD ref whenever the FILTER_REFS_DETACHED_HEAD
option is used.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c |  4 ++++
 ref-filter.c     | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

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
index 223daeb..15df421 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "git-compat-util.h"
 #include "version.h"
+#include "wt-status.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -915,6 +916,37 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static char *get_head_description(void)
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
@@ -953,9 +985,11 @@ static void populate_value(struct ref_array_item *ref)
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
-- 
2.6.0
