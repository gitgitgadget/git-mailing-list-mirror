From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Ensure that commit/status don't stat all files when core.ignoreStat = true
Date: Tue, 27 May 2008 10:15:09 +0200
Message-ID: <"Storm-Olsen*Marius___oslo/trolltech////////////////Marius#b#Storm-Olsen"@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue May 27 12:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0wYh-0007Au-HD
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 12:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbYE0Kgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 06:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757415AbYE0Kgo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 06:36:44 -0400
Received: from hoat.troll.no ([62.70.27.150]:37590 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757313AbYE0Kgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 06:36:43 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2008 06:36:43 EDT
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id C6F3320BB4;
	Tue, 27 May 2008 12:29:49 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id BB98420BA5;
	Tue, 27 May 2008 12:29:49 +0200 (CEST)
Content-Disposition: inline
Apparently-To: <marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83000>

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
