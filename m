From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/8] branch: bump get_head_description() to the top
Date: Wed, 19 Aug 2015 00:45:39 +0530
Message-ID: <1439925345-9969-3-git-send-email-Karthik.188@gmail.com>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 21:16:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmMa-0003fv-GC
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbbHRTPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:15:49 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35926 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbbHRTPp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:15:45 -0400
Received: by pawq9 with SMTP id q9so41768866paw.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8obU0x6RSsY+oOkg57cR4Ix0m1L3x/oH1L5fXr+4E9g=;
        b=L8ea+i9NfEMKlAVua66A23GWEChkKT/GTrNx1yD8730XV6u0z7eW3e39JREK1CVdda
         HvtsoSG8iAEG7qkheBW5TmSyVxSkJxHlsQAUzwRMQPIctkHLPfOIUirzcRjca2IqY1oK
         w+9mEju0rqcucPka3T/HHNVPtIQm7udsp59wCPczTVP+6pnh8EALyovGZwvD3ZuK6Db3
         XxDpNdm5EckWb7MTjChjuG0z1YR9MgPSMpkdRZfQGbgdW+r99KtGtgqY73VCpSrAf6C7
         oDOJfRX6gzq5VDI2JC7EDUjuhIzGpECaV7rJcN8/oK5iapxEylgXUPIxVlbxi34nNmzV
         9yNg==
X-Received: by 10.68.65.47 with SMTP id u15mr16382102pbs.127.1439925345121;
        Tue, 18 Aug 2015 12:15:45 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id v2sm43800pda.34.2015.08.18.12.15.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 12:15:44 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276148>

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
