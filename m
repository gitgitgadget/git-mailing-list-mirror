From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH] log and rev-list: don't print extra prefixes already shown in the graph
Date: Sun, 25 May 2008 00:07:21 -0700
Message-ID: <1211699241-19201-1-git-send-email-adam@adamsimpkins.net>
References: <20080525064324.GA16827@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 09:08:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0AL3-0001DI-RR
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 09:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYEYHH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 03:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbYEYHH0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 03:07:26 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:48069 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYEYHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 03:07:25 -0400
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id BC52554BC79;
	Sun, 25 May 2008 03:07:22 -0400 (EDT)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 7383B54BC78;
	Sun, 25 May 2008 03:07:22 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 7960F14100C8; Sun, 25 May 2008 00:07:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.390.gd86da
In-Reply-To: <20080525064324.GA16827@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82856>

With the --graph option, the graph already outputs 'o' instead of '*'
for boundary commits, and '<' or '>' when --left-right is specified.
The extra -/</> prefix in front of the commit itself isn't needed.

(This change also disables the '^' prefix for UNINTERESTING commits.
The graph code currently doesn't print anything special for these
commits, since it assumes no UNINTERESTING, non-BOUNDARY commits are
displayed.  This is potentially a bug if UNINTERESTING non-BOUNDARY
commits can actually be displayed via some code path.)

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---

Here's simple patch to remove the redundant </>/- prefix in the log
message.  As the commit message mentions, I'm not sure if it's doing the
right thing with respect to UNINTERESTING commits, though.

 builtin-rev-list.c |   21 ++++++++++++---------
 log-tree.c         |   41 +++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 54d55cc..b474527 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -65,15 +65,18 @@ static void show_commit(struct commit *commit)
 		printf("%lu ", commit->date);
 	if (header_prefix)
 		fputs(header_prefix, stdout);
-	if (commit->object.flags & BOUNDARY)
-		putchar('-');
-	else if (commit->object.flags & UNINTERESTING)
-		putchar('^');
-	else if (revs.left_right) {
-		if (commit->object.flags & SYMMETRIC_LEFT)
-			putchar('<');
-		else
-			putchar('>');
+
+	if (!revs.graph) {
+		if (commit->object.flags & BOUNDARY)
+			putchar('-');
+		else if (commit->object.flags & UNINTERESTING)
+			putchar('^');
+		else if (revs.left_right) {
+			if (commit->object.flags & SYMMETRIC_LEFT)
+				putchar('<');
+			else
+				putchar('>');
+		}
 	}
 	if (revs.abbrev_commit && revs.abbrev)
 		fputs(find_unique_abbrev(commit->object.sha1, revs.abbrev),
diff --git a/log-tree.c b/log-tree.c
index 1474d1f..5505606 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -228,15 +228,17 @@ void show_log(struct rev_info *opt)
 	if (!opt->verbose_header) {
 		graph_show_commit(opt->graph);
 
-		if (commit->object.flags & BOUNDARY)
-			putchar('-');
-		else if (commit->object.flags & UNINTERESTING)
-			putchar('^');
-		else if (opt->left_right) {
-			if (commit->object.flags & SYMMETRIC_LEFT)
-				putchar('<');
-			else
-				putchar('>');
+		if (!opt->graph) {
+			if (commit->object.flags & BOUNDARY)
+				putchar('-');
+			else if (commit->object.flags & UNINTERESTING)
+				putchar('^');
+			else if (opt->left_right) {
+				if (commit->object.flags & SYMMETRIC_LEFT)
+					putchar('<');
+				else
+					putchar('>');
+			}
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->print_parents)
@@ -293,15 +295,18 @@ void show_log(struct rev_info *opt)
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
 			fputs("commit ", stdout);
-		if (commit->object.flags & BOUNDARY)
-			putchar('-');
-		else if (commit->object.flags & UNINTERESTING)
-			putchar('^');
-		else if (opt->left_right) {
-			if (commit->object.flags & SYMMETRIC_LEFT)
-				putchar('<');
-			else
-				putchar('>');
+
+		if (!opt->graph) {
+			if (commit->object.flags & BOUNDARY)
+				putchar('-');
+			else if (commit->object.flags & UNINTERESTING)
+				putchar('^');
+			else if (opt->left_right) {
+				if (commit->object.flags & SYMMETRIC_LEFT)
+					putchar('<');
+				else
+					putchar('>');
+			}
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
-- 
1.5.5.1.383.g8c56f.dirty
