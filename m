From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 03/10] branch: bump get_head_description() to the top
Date: Tue,  4 Aug 2015 18:31:16 +0530
Message-ID: <1438693282-15516-3-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbqb-0003IO-7G
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933988AbbHDNB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:29 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35357 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933984AbbHDNBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:01:25 -0400
Received: by pdrg1 with SMTP id g1so4325158pdr.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lvef55PbEPWKPoRACq4fhGWGJlsM44VBwmLcyu/bp7c=;
        b=RZoe7DZUryQvyD3XAfzP+N+rOTCmwsLGGXYMG8adT4cA90yoAUjKUwWMLQkSoZqJXw
         30H+3KLxvWnALY71eYcY/3izfk9J/htAcpiTb86MI7GZIQ5SR/T9twkMIRWZJT17vrY0
         q3DvrbRO4AmtC8ha7z3WTHGgFEhB8KsarI3D1L0PlsikAp9ffAWc6I0fHZXrl2oYE1lC
         TlfUPdak21DYkmgjtqbqUkoW9xol555J6HTiKQcfqX3VQUr/Wu0fQwuf/qpg1G9XVjjq
         Maf9h0z4jXLZ1LwarUmdF/dXSFhMAAZypLH+M8ZploRqLqEBQOiXws1c8bWKX6AjliS7
         feJQ==
X-Received: by 10.70.37.169 with SMTP id z9mr7525446pdj.123.1438693285217;
        Tue, 04 Aug 2015 06:01:25 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uy6sm1450657pbc.13.2015.08.04.06.01.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:01:24 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275268>

This is a preperatory patch for 'roll show_detached HEAD into regular
ref_list'. This patch moves get_head_descrition() to the top so that
it can be used in print_ref_item().

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 62 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b058b74..65f6d0d 100644
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
@@ -569,37 +600,6 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
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
