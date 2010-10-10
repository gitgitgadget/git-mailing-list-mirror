From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] [RFC] Transfer special display of toplevel dir to display-time.
Date: Sun, 10 Oct 2010 21:59:55 +0200
Message-ID: <1286740795-7929-3-git-send-email-ydirson@altern.org>
References: <20101010123954.GB4983@home.lan>
 <1286740795-7929-1-git-send-email-ydirson@altern.org>
 <1286740795-7929-2-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 22:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52ZE-00070z-Gb
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab0JJUcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 16:32:15 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51535 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab0JJUcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 16:32:11 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B8340D48002;
	Sun, 10 Oct 2010 22:32:05 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P52j5-00025m-If; Sun, 10 Oct 2010 22:42:35 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286740795-7929-2-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158700>

I have mixed feelings about this one: it makes the display code much
more messy than the rename code was, and it will need to be duplicated
for each output format.

So I suggest to finally just keep the "./" assignation in diffcore_rename.
Any better idea ?
---
 diff.c            |   22 +++++++++++++++-------
 diffcore-rename.c |    5 -----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 4de43d6..6fe47c2 100644
--- a/diff.c
+++ b/diff.c
@@ -3471,15 +3471,23 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 	if (p->status == DIFF_STATUS_COPIED ||
 	    p->status == DIFF_STATUS_RENAMED) {
 		const char *name_a, *name_b;
+		char buf[PATH_MAX];
+		name_a = p->one->path;
+		name_b = p->two->path;
 		if (p->is_bulkmove) {
-			/* append "*" to the first dirname */
-			char buf[PATH_MAX];
-			char* next = memccpy(buf, p->one->path, '\0', PATH_MAX);
-			next[-1] = '*'; *next = '\0';
-			name_a = buf;
+			if (!*name_a)
+				name_a = "./*"; /* visualize toplevel dir */
+			else {
+				/* append "*" to the first dirname */
+				char* next = memccpy(buf, name_a, '\0', PATH_MAX);
+				next[-1] = '*'; *next = '\0';
+				name_a = buf;
+			}
 		} else
-			name_a = p->one->path;
-		name_b = p->two->path;
+			if (!*name_a)
+				name_a = "./"; /* visualize toplevel dir */
+		if (!*name_b)
+			name_b = "./"; /* visualize toplevel dir */
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
 		write_name_quoted(name_a, opt->file, inter_name_termination);
 		write_name_quoted(name_b, opt->file, line_termination);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8de0d57..a075a25 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -821,11 +821,6 @@ void diffcore_rename(struct diff_options *options)
 	for (candidate=bulkmove_candidates; candidate; candidate = candidate->next) {
 		struct diff_filepair* pair;
 		if (candidate->discarded) continue;
-		/* visualize toplevel dir if needed */ //FIXME: wrong place for this ?
-		if (!*candidate->one->path)
-			candidate->one->path = "./";
-		if (!*candidate->two->path)
-			candidate->two->path = "./";
 		pair = diff_queue(&outq, candidate->one, candidate->two);
 		pair->score = MAX_SCORE;
 		pair->renamed_pair = 1;
-- 
1.7.2.3
