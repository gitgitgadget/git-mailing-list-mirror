From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not show progress meter while checking files out.
Date: Fri, 20 Apr 2007 01:42:19 -0700
Message-ID: <1177058540390-git-send-email-junkio@cox.net>
References: <11770585393395-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 10:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeohH-0006Py-CM
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 10:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992626AbXDTImX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 04:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992635AbXDTImW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 04:42:22 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56222 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992626AbXDTImU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 04:42:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420084220.CQUW1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Fri, 20 Apr 2007 04:42:20 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pLiK1W00U1kojtg0000100; Fri, 20 Apr 2007 04:42:20 -0400
X-Mailer: git-send-email 1.5.1.1.942.g0a20
In-Reply-To: <11770585393395-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45075>

Originally I thought it would take too long to check out many
files and to prevent people from getting bored, I added progress
meter.  But it feels a bit too noisy; let's disable it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 unpack-trees.c |   62 --------------------------------------------------------
 1 files changed, 0 insertions(+), 62 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5139481..1419653 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -288,73 +288,15 @@ static void unlink_entry(char *name)
 	}
 }
 
-static volatile sig_atomic_t progress_update;
-
-static void progress_interval(int signum)
-{
-	progress_update = 1;
-}
-
-static void setup_progress_signal(void)
-{
-	struct sigaction sa;
-	struct itimerval v;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = progress_interval;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
-}
-
 static struct checkout state;
 static void check_updates(struct cache_entry **src, int nr,
 		struct unpack_trees_options *o)
 {
 	unsigned short mask = htons(CE_UPDATE);
-	unsigned last_percent = 200, cnt = 0, total = 0;
-
-	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < nr; cnt++) {
-			struct cache_entry *ce = src[cnt];
-			if (!ce->ce_mode || ce->ce_flags & mask)
-				total++;
-		}
-
-		/* Don't bother doing this for very small updates */
-		if (total < 250)
-			total = 0;
-
-		if (total) {
-			fprintf(stderr, "Checking files out...\n");
-			setup_progress_signal();
-			progress_update = 1;
-		}
-		cnt = 0;
-	}
 
 	while (nr--) {
 		struct cache_entry *ce = *src++;
 
-		if (total) {
-			if (!ce->ce_mode || ce->ce_flags & mask) {
-				unsigned percent;
-				cnt++;
-				percent = (cnt * 100) / total;
-				if (percent != last_percent ||
-				    progress_update) {
-					fprintf(stderr, "%4u%% (%u/%u) done\r",
-						percent, cnt, total);
-					last_percent = percent;
-					progress_update = 0;
-				}
-			}
-		}
 		if (!ce->ce_mode) {
 			if (o->update)
 				unlink_entry(ce->name);
@@ -366,10 +308,6 @@ static void check_updates(struct cache_entry **src, int nr,
 				checkout_entry(ce, &state, NULL);
 		}
 	}
-	if (total) {
-		signal(SIGALRM, SIG_IGN);
-		fputc('\n', stderr);
-	}
 }
 
 int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
-- 
1.5.1.1.942.g0a20
