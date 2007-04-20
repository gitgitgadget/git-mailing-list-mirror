From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Kill the useless progress meter in merge-recursive
Date: Fri, 20 Apr 2007 02:37:18 -0400
Message-ID: <20070420063718.GA8424@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 08:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HemkJ-0003dW-EK
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 08:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbXDTGhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 02:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422941AbXDTGhX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 02:37:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56310 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422797AbXDTGhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 02:37:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HemkB-0001xJ-La; Fri, 20 Apr 2007 02:37:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BF4D620FBAE; Fri, 20 Apr 2007 02:37:18 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45067>

The mess known as the progress meter in merge-recursive was my own
fault; I put it in thinking that we might be spending a lot of time
resolving unmerged entries in the index that were not handled by
the simple 3-way index merge code.

Turns out we don't really spend that much time there, so the progress
meter was pretty much always jumping to "(n/n) 100%" as soon as
the program started.  That isn't a very good indication of progress.

Since I don't have a great solution for how a progress meter should
work here, I'm proposing we back it out entirely.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 In addition to Nico's nice progress meter cleanups.  :-)
 And now hopefully I am done for the night.

 merge-recursive.c |   65 ++--------------------------------------------------
 1 files changed, 3 insertions(+), 62 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 595b022..bd05ee3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -95,11 +95,6 @@ static struct path_list current_directory_set = {NULL, 0, 0, 1};
 static int call_depth = 0;
 static int verbosity = 2;
 static int buffer_output = 1;
-static int do_progress = 1;
-static unsigned last_percent;
-static unsigned merged_cnt;
-static unsigned total_cnt;
-static volatile sig_atomic_t progress_update;
 static struct output_buffer *output_list, *output_end;
 
 static int show (int v)
@@ -174,39 +169,6 @@ static void output_commit_title(struct commit *commit)
 	}
 }
 
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
-static void display_progress()
-{
-	unsigned percent = total_cnt ? merged_cnt * 100 / total_cnt : 0;
-	if (progress_update || percent != last_percent) {
-		fprintf(stderr, "%4u%% (%u/%u) done\r",
-			percent, merged_cnt, total_cnt);
-		progress_update = 0;
-		last_percent = percent;
-	}
-}
-
 static struct cache_entry *make_cache_entry(unsigned int mode,
 		const unsigned char *sha1, const char *path, int stage, int refresh)
 {
@@ -377,14 +339,11 @@ static struct path_list *get_unmerged(void)
 	int i;
 
 	unmerged->strdup_paths = 1;
-	total_cnt += active_nr;
 
-	for (i = 0; i < active_nr; i++, merged_cnt++) {
+	for (i = 0; i < active_nr; i++) {
 		struct path_list_item *item;
 		struct stage_data *e;
 		struct cache_entry *ce = active_cache[i];
-		if (do_progress)
-			display_progress();
 		if (!ce_stage(ce))
 			continue;
 
@@ -1214,15 +1173,12 @@ static int merge_trees(struct tree *head,
 		re_merge = get_renames(merge, common, head, merge, entries);
 		clean = process_renames(re_head, re_merge,
 				branch1, branch2);
-		total_cnt += entries->nr;
-		for (i = 0; i < entries->nr; i++, merged_cnt++) {
+		for (i = 0; i < entries->nr; i++) {
 			const char *path = entries->items[i].path;
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed
 				&& !process_entry(path, e, branch1, branch2))
 				clean = 0;
-			if (do_progress)
-				display_progress();
 		}
 
 		path_list_clear(re_merge, 0);
@@ -1330,15 +1286,6 @@ static int merge(struct commit *h1,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	if (!call_depth && do_progress) {
-		/* Make sure we end at 100% */
-		if (!total_cnt)
-			total_cnt = 1;
-		merged_cnt = total_cnt;
-		progress_update = 1;
-		display_progress();
-		fputc('\n', stderr);
-	}
 	flush_output();
 	return clean;
 }
@@ -1415,12 +1362,8 @@ int main(int argc, char *argv[])
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
-	if (verbosity >= 5) {
+	if (verbosity >= 5)
 		buffer_output = 0;
-		do_progress = 0;
-	}
-	else
-		do_progress = isatty(1);
 
 	branch1 = argv[++i];
 	branch2 = argv[++i];
@@ -1431,8 +1374,6 @@ int main(int argc, char *argv[])
 	branch1 = better_branch_name(branch1);
 	branch2 = better_branch_name(branch2);
 
-	if (do_progress)
-		setup_progress_signal();
 	if (show(3))
 		printf("Merging %s with %s\n", branch1, branch2);
 
-- 
1.5.1.1.135.gf948
