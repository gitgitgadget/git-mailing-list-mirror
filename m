From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/8] branch: bump get_head_description() to the top
Date: Sat, 22 Aug 2015 12:21:43 +0530
Message-ID: <1440226309-25415-3-git-send-email-Karthik.188@gmail.com>
References: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 08:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZT2ej-0004Jj-RW
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 08:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbHVGvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 02:51:50 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36491 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbbHVGvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 02:51:49 -0400
Received: by pdbmi9 with SMTP id mi9so34020976pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8obU0x6RSsY+oOkg57cR4Ix0m1L3x/oH1L5fXr+4E9g=;
        b=kvgMlqZpKsZUYGxgXWMEAT6ic6tbqze27Z/ROofOD7BodwqX3JE4AEQFPZ43Xji2SW
         oZr+tsfl44fUoaUOoE0aZYVS92jkxWYn4Gt0zmIHFr31a/88dDmCwOGdgaoDTd1p6j17
         tVH1htJkhDtV/z62KHAe9/moNw/9YhaAxHTmaWR/EKPMphk77QIJPj2YLVRNBNZbYTpa
         XS1lJQK4qVEAx4r4Necz0jbCudryqOB+9MKEOAlrFoKQ91P+KNa70kn55KRsTP3GSokY
         V4DVf3TBm3nYEo8lckaRsmm8QNHAEWmNebNnxTWp5uZVCotGBJORwL1p/XC1AkyRt597
         IoAA==
X-Received: by 10.70.46.133 with SMTP id v5mr24976823pdm.110.1440226308534;
        Fri, 21 Aug 2015 23:51:48 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm4412342pac.22.2015.08.21.23.51.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 23:51:47 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276380>

This is a preperatory patch for 'roll show_detached HEAD into regular
ref_list'. This patch moves get_head_description() to the top so that
it can be used in print_ref_item().

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 62 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 28a10d6..193296a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -497,6 +497,37 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 	strbuf_release(&subject);
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
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 			   int abbrev, int current, const char *remote_prefix)
 {
@@ -570,37 +601,6 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 	return max;
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
 static void show_detached(struct ref_list *ref_list, int maxwidth)
 {
 	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
-- 
2.5.0
