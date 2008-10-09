From: Lars Stoltenow <penma@derf.homelinux.org>
Subject: [PATCH] git-daemon: Worked around uclibc buffer problem
Date: Thu, 9 Oct 2008 23:34:48 +0200
Message-ID: <20081009213448.GA11204@derf.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 00:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3Ye-0001pY-0N
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 00:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbYJIV7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755950AbYJIV7U
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:59:20 -0400
Received: from p508BE19A.dip.t-dialin.net ([80.139.225.154]:58430 "EHLO
	aneurysm.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753348AbYJIV7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:59:19 -0400
X-Greylist: delayed 1468 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 17:59:19 EDT
Received: from penma by aneurysm.local with local (Exim 4.69)
	(envelope-from <penma@derf.homelinux.org>)
	id 1Ko39k-00037l-Tq
	for git@vger.kernel.org; Thu, 09 Oct 2008 23:34:48 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97895>

uclibc immediately write()s every string argument to fprintf, which causes
superfluous 'remote: ' strings to appear when cloning repos. This patch
makes it write the message in one shot.

Signed-off-by: Lars Stoltenow <penma@penma.de>
---
 builtin-pack-objects.c |    7 +++++--
 progress.c             |    8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 1158e42..94f7404 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2232,9 +2232,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
-	if (progress)
-		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
+	if (progress) {
+		char message[128];
+		snprintf(message, sizeof(message), "Total %"PRIu32" (delta %"PRIu32"),"
 			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
+		fputs(message, stderr);
+	}
 	return 0;
 }
diff --git a/progress.c b/progress.c
index 55a8687..56c9134 100644
--- a/progress.c
+++ b/progress.c
@@ -94,16 +94,20 @@ static int display(struct progress *progress, unsigned n, const char *done)
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
+			char message[128];
 			progress->last_percent = percent;
-			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
+			snprintf(message, sizeof(message), "%s: %3u%% (%u/%u)%s%s",
 				progress->title, percent, n,
 				progress->total, tp, eol);
+			fputs(message, stderr);
 			fflush(stderr);
 			progress_update = 0;
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s: %u%s%s", progress->title, n, tp, eol);
+		char message[128];
+		snprintf(message, sizeof(message), "%s: %u%s%s", progress->title, n, tp, eol);
+		fputs(message, stderr);
 		fflush(stderr);
 		progress_update = 0;
 		return 1;
-- 
1.6.0.2.GIT
