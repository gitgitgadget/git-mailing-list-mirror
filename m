From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Kill the useless progress meter in merge-recursive
Date: Fri, 20 Apr 2007 01:21:59 -0700
Message-ID: <7vd51z317c.fsf@assigned-by-dhcp.cox.net>
References: <20070420063718.GA8424@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 10:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeoOO-0000Yx-9S
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 10:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992458AbXDTIWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 04:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbXDTIWF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 04:22:05 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56789 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbXDTIWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 04:22:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420082159.XFDA1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 04:21:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pLMz1W00E1kojtg0000000; Fri, 20 Apr 2007 04:22:00 -0400
In-Reply-To: <20070420063718.GA8424@spearce.org> (Shawn O. Pearce's message of
	"Fri, 20 Apr 2007 02:37:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45072>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The mess known as the progress meter in merge-recursive was my own
> fault; I put it in thinking that we might be spending a lot of time
> resolving unmerged entries in the index that were not handled by
> the simple 3-way index merge code.
>
> Turns out we don't really spend that much time there, so the progress
> meter was pretty much always jumping to "(n/n) 100%" as soon as
> the program started.  That isn't a very good indication of progress.

I would propose removing the progress meter for "Checking out
files" in unpack-trees, for the same reason.

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
