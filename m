From: Jeff King <peff@peff.net>
Subject: [PATCH] status: respect advice.statusHints for ahead/behind advice
Date: Mon, 3 Dec 2012 01:16:57 -0500
Message-ID: <20121203061656.GA20164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfPLN-0001Ng-3P
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 07:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab2LCGRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 01:17:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50377 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab2LCGRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 01:17:11 -0500
Received: (qmail 26503 invoked by uid 107); 3 Dec 2012 06:18:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Dec 2012 01:18:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2012 01:16:57 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211028>

If the user has unset advice.statusHints, we already
suppress the "use git reset to..." hints in each stanza. The
new "use git push to publish..." hint is the same type of
hint. Let's respect statusHints for it, rather than making
the user set yet another advice flag.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of mm/status-push-pull-advise.

I left "git checkout" alone, though I'd also like to turn it off there,
too. Should it get a separate advice option there? Should it simply
respect statusHints (it seems odd because I know that "status" there
means "git status", not "hints about the status of your repo")?

 builtin/checkout.c |  2 +-
 remote.c           | 17 ++++++++++-------
 remote.h           |  2 +-
 wt-status.c        |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 781295b..28146d1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -544,7 +544,7 @@ static void report_tracking(struct branch_info *new)
 	struct strbuf sb = STRBUF_INIT;
 	struct branch *branch = branch_get(new->name);
 
-	if (!format_tracking_info(branch, &sb))
+	if (!format_tracking_info(branch, &sb, 1))
 		return;
 	fputs(sb.buf, stdout);
 	strbuf_release(&sb);
diff --git a/remote.c b/remote.c
index 9c19689..176a777 100644
--- a/remote.c
+++ b/remote.c
@@ -1617,7 +1617,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 /*
  * Return true when there is anything to report, otherwise false.
  */
-int format_tracking_info(struct branch *branch, struct strbuf *sb)
+int format_tracking_info(struct branch *branch, struct strbuf *sb, int advice)
 {
 	int num_ours, num_theirs;
 	const char *base;
@@ -1633,8 +1633,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   num_ours),
 			base, num_ours);
-		strbuf_addf(sb,
-			_("  (use \"git push\" to publish your local commits)\n"));
+		if (advice)
+			strbuf_addf(sb,
+				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!num_ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
@@ -1643,8 +1644,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			       "and can be fast-forwarded.\n",
 			   num_theirs),
 			base, num_theirs);
-		strbuf_addf(sb,
-			_("  (use \"git pull\" to update your local branch)\n"));
+		if (advice)
+			strbuf_addf(sb,
+				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -1655,8 +1657,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			       "respectively.\n",
 			   num_theirs),
 			base, num_ours, num_theirs);
-		strbuf_addf(sb,
-			_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+		if (advice)
+			strbuf_addf(sb,
+				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
 	}
 	return 1;
 }
diff --git a/remote.h b/remote.h
index 251d8fd..ac504a5 100644
--- a/remote.h
+++ b/remote.h
@@ -153,7 +153,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
 
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
-int format_tracking_info(struct branch *branch, struct strbuf *sb);
+int format_tracking_info(struct branch *branch, struct strbuf *sb, int advice);
 
 struct ref *get_local_heads(void);
 /*
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..b48c8cf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -755,7 +755,7 @@ static void wt_status_print_tracking(struct wt_status *s)
 	if (prefixcmp(s->branch, "refs/heads/"))
 		return;
 	branch = branch_get(s->branch + 11);
-	if (!format_tracking_info(branch, &sb))
+	if (!format_tracking_info(branch, &sb, advice_status_hints))
 		return;
 
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
-- 
1.7.12.4.42.ge2b5b43
