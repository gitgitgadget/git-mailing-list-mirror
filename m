From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --pretty=gnucl: avoid line wrapping before the comma
Date: Fri, 2 Mar 2007 15:29:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021528590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702272147590.29426@xanadu.home>
 <Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcoghcd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:29:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN8l0-0005oO-Q7
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 15:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992484AbXCBO3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 09:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992489AbXCBO3L
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 09:29:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:44113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992484AbXCBO3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 09:29:10 -0500
Received: (qmail invoked by alias); 02 Mar 2007 14:29:08 -0000
X-Provags-ID: V01U2FsdGVkX1/J1lYyI5vJVtWAGkBo4Z2ZBep61qjpahD938AbSR
	y/MI1PEnwBGc9e
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslcoghcd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41210>


Earlier, this code played dumb by outputting the file name and the comma
separately (to make it easier to determine when to output a colon
instead of the comma). This misguided code is fixed by this patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I know that this is a dead topic branch, but I did not want
	to leave buggy code behind for future reference.

 diff.c |   60 ++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/diff.c b/diff.c
index 9f9cb34..d33242a 100644
--- a/diff.c
+++ b/diff.c
@@ -1851,52 +1851,64 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 
 struct changelog_t {
 	int offset, seen_first;
+	char buffer[1024];
 };
 
+static void flush_changelog_file_entry(struct changelog_t *log, char delim) {
+	if (!log->seen_first) {
+		log->offset = print_wrapped_text("* ", -CHANGELOG_TAB_SIZE,
+				CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
+		log->seen_first = 1;
+	}
+
+	if (log->buffer[0]) {
+		int len = strlen(log->buffer);
+		if (len + 3 < sizeof(log->buffer)) {
+			log->buffer[len++] = delim;
+			log->buffer[len++] = ' ';
+			log->buffer[len++] = '\0';
+		} else
+			warn("Line too long: skipping delimiter");
+
+		log->offset = print_wrapped_text(log->buffer, -log->offset,
+				CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
+		log->buffer[0] = '\0';
+	}
+}
+
 static void run_changelog(struct diff_filepair *p, struct diff_options *o,
-	struct changelog_t *changelog)
+	struct changelog_t *log)
 {
 	const char *name;
 	const char *other;
-	static char buffer[1024];
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
 		return;
 	}
 
-	if (changelog->seen_first)
-		buffer[0] = ',';
-	else {
-		buffer[0] = '*';
-		changelog->offset = -CHANGELOG_TAB_SIZE;
-		changelog->seen_first = 1;
-	}
-
 	name = p->one->path;
 	other = p->two->path;
 
-	if (!name) {
-		if (!other)
-			return;
-		snprintf(buffer + 1, sizeof(buffer) - 1, " %s", other);
-	} else if (!other || !strcmp(name, other))
-		snprintf(buffer + 1, sizeof(buffer) - 1, " %s", name);
+	if (!name && !other)
+		return;
+
+	flush_changelog_file_entry(log, ',');
+	if (!name)
+		snprintf(log->buffer, sizeof(log->buffer), "%s", other);
+	else if (!other || !strcmp(name, other))
+		snprintf(log->buffer, sizeof(log->buffer), "%s", name);
 	else
-		snprintf(buffer + 1, sizeof(buffer) - 1, " %s => %s",
+		snprintf(log->buffer, sizeof(log->buffer), "%s => %s",
 				name, other);
-	changelog->offset = print_wrapped_text(buffer, -changelog->offset,
-		CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
 }
 
 static void finalize_changelog(struct diff_options *options,
 		struct changelog_t *changelog)
 {
-	if (!options->stat_sep)
-		return;
-	changelog->offset = print_wrapped_text(": ", -changelog->offset,
-		CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
-	changelog->offset = print_wrapped_text(options->stat_sep,
+	flush_changelog_file_entry(changelog, ':');
+	changelog->offset = print_wrapped_text(options->stat_sep ?
+			options->stat_sep : "*** empty message ***",
 			-changelog->offset,
 			CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
 }
-- 
1.5.0.2.780.g57e5-dirty
