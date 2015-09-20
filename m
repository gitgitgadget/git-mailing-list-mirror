From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 2/8] branch: bump get_head_description() to the top
Date: Sun, 20 Sep 2015 23:40:21 +0530
Message-ID: <1442772627-25421-3-git-send-email-Karthik.188@gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 20:10:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdj4K-0006dC-0c
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 20:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbbITSKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 14:10:25 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36362 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258AbbITSKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 14:10:24 -0400
Received: by pacik9 with SMTP id ik9so11665630pac.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT5kkCeVrdS8/pxVFC9I/iGgCAKcOGIdu1AvPrUjUxA=;
        b=Lh7rh7W/WxuRlMWYggSxVgoXSGAmTVG3P19nZRLfOSr7G3zVt9ZPgZQI5/nDzWxZyF
         Z/3XGkE3XF6Lg8HuB4olPge0YN3RXXxV578tRpns+4gXWGDWtk7Pyh+gMzmVUSZAV7Xe
         8VGui1gDkq3vP6MCWqb1hj7CkOJgkvlFyKiqL0wt5q6mwWcbxpKiyi9WrT2bkech1NGx
         Wpqy+X/CZCkw559WN8FTt0rB6zbT6qI3YiXnzT9D1a7bgx7itg/h60YTVVXfZjqIk8/d
         fb8rFpXD5CrZpcgMeXGY604E4/dzgjKzjitnuvQAXDOPhb6vJvAZeWCFQZEfh5sObRGD
         tHnA==
X-Received: by 10.66.164.132 with SMTP id yq4mr20068540pab.8.1442772623848;
        Sun, 20 Sep 2015 11:10:23 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id qr5sm20037916pbb.26.2015.09.20.11.10.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 11:10:23 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278250>

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
index b6d356f..772cc3b 100644
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
2.5.1
