From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Ensure that commit/status don't stat all files when core.ignoreStat = true
Date: Tue, 27 May 2008 11:29:09 +0200
Message-ID: <1211880549-15758-1-git-send-email-marius@trolltech.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 12:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0wSl-0005Ye-94
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 12:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbYE0Kac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 06:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbYE0Kac
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 06:30:32 -0400
Received: from init.linpro.no ([87.238.46.2]:44240 "EHLO init.linpro.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926AbYE0Kab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 06:30:31 -0400
X-Greylist: delayed 3508 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2008 06:30:31 EDT
Received: from [62.70.27.100] (helo=localhost.localdomain)
	(Authenticated Sender=marius@storm-olsen.com)
	by init.linpro.no with esmtpa (Exim 4.50 #1 (Debian))
	id 1K0vX8-0007Ma-Oc; Tue, 27 May 2008 11:31:54 +0200
X-Mailer: git-send-email 1.5.5.1.501.gefb4
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on spamtrap
X-Spam-Status: No, hits=0.0 required=5.0 tests=DSPAM=0	version=2.63
X-Spam-Level: 
X-DSPAM-Signature: !DSPAM:483bd0d322686149172119!
X-DSPAM-Probability: 0.0000
X-DSPAM-Confidence: 0.9997
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82999>

The core.ignoreStat option is used to assume that files in the
index are unchanged, thus avoiding expensive lstat()s on slow
systems. However, due to refresh_cache_ent still stating but
ignoring the info, and the listing of untracked files in
commit/status, we would still lstat() all the files.

This change shortcuts the refresh_cache_ent(), and makes
commit/status not list untracked files, unless the -u option
is specified.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 read-cache.c |   10 ++++++++++
 wt-status.c  |   11 ++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8b467f8..104e387 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -882,6 +882,16 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	if (ce_uptodate(ce))
 		return ce;
 
+	/*
+	 * assume_unchanged is used to avoid lstats to check if the
+	 * file has been modified. When true, the user need to
+	 * manually update the index.
+	 */
+	if (assume_unchanged) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
+
 	if (lstat(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
diff --git a/wt-status.c b/wt-status.c
index a44c543..72db466 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -342,7 +342,14 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_changed(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
-	wt_status_print_untracked(s);
+
+	if (assume_unchanged && !s->untracked) {
+		if (s->commitable)
+			fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
+		/* !s->commitable message displayed below */
+	}
+	else
+		wt_status_print_untracked(s);
 
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
@@ -357,6 +364,8 @@ void wt_status_print(struct wt_status *s)
 			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)
 			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
+		else if (assume_unchanged && !s->untracked)
+			printf("nothing to commit (use -u to show untracked files)\n");
 		else
 			printf("nothing to commit (working directory clean)\n");
 	}
-- 
1.5.5.1.501.gefb4
