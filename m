From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] Display a progress meter during merge-recursive.
Date: Sun, 14 Jan 2007 00:28:58 -0500
Message-ID: <20070114052858.GD19113@spearce.org>
References: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 06:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5xvq-0006Ma-O9
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 06:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbXANF3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 00:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbXANF3E
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 00:29:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46639 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbXANF3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 00:29:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5xvP-0004jn-Jq; Sun, 14 Jan 2007 00:28:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5AB4220FBAE; Sun, 14 Jan 2007 00:28:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36792>

Because large merges on slow systems can take up to a minute to
execute we should try to keep the user entertained with a progress
meter to let them know how far we have progressed through the
current merge.

The progress meter considers each entry in the in-memory index to
be a unit, which means a single recursive merge will double the
number of units in the progress meter.  Files which are unmerged
after the 3-way tree merge are also considered a unit within the
progress meter.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c16062b..c4e21bc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -79,6 +79,11 @@ static struct path_list current_directory_set = {NULL, 0, 0, 1};
 static int call_depth = 0;
 static int verbosity = 2;
 static int buffer_output = 1;
+static int do_progress = 1;
+static unsigned last_percent;
+static unsigned merged_cnt;
+static unsigned total_cnt;
+static volatile sig_atomic_t progress_update;
 static struct output_buffer *output_list, *output_end;
 
 static int show (int v)
@@ -153,6 +158,39 @@ static void output_commit_title(struct commit *commit)
 	}
 }
 
+static void progress_interval(int signum)
+{
+	progress_update = 1;
+}
+
+static void setup_progress_signal(void)
+{
+	struct sigaction sa;
+	struct itimerval v;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = progress_interval;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+
+	v.it_interval.tv_sec = 1;
+	v.it_interval.tv_usec = 0;
+	v.it_value = v.it_interval;
+	setitimer(ITIMER_REAL, &v, NULL);
+}
+
+static void display_progress()
+{
+	unsigned percent = merged_cnt * 100 / total_cnt;
+	if (progress_update || percent != last_percent) {
+		fprintf(stderr, "%4u%% (%u/%u) done\r",
+			percent, merged_cnt, total_cnt);
+		progress_update = 0;
+		last_percent = percent;
+	}
+}
+
 static struct cache_entry *make_cache_entry(unsigned int mode,
 		const unsigned char *sha1, const char *path, int stage, int refresh)
 {
@@ -315,11 +353,14 @@ static struct path_list *get_unmerged(void)
 	int i;
 
 	unmerged->strdup_paths = 1;
+	total_cnt += active_nr;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < active_nr; i++, merged_cnt++) {
 		struct path_list_item *item;
 		struct stage_data *e;
 		struct cache_entry *ce = active_cache[i];
+		if (do_progress)
+			display_progress();
 		if (!ce_stage(ce))
 			continue;
 
@@ -1096,13 +1137,15 @@ static int merge_trees(struct tree *head,
 		re_merge = get_renames(merge, common, head, merge, entries);
 		clean = process_renames(re_head, re_merge,
 				branch1, branch2);
-		for (i = 0; i < entries->nr; i++) {
+		total_cnt += entries->nr;
+		for (i = 0; i < entries->nr; i++, merged_cnt++) {
 			const char *path = entries->items[i].path;
 			struct stage_data *e = entries->items[i].util;
-			if (e->processed)
-				continue;
-			if (!process_entry(path, e, branch1, branch2))
+			if (!e->processed
+				&& !process_entry(path, e, branch1, branch2))
 				clean = 0;
+			if (do_progress)
+				display_progress();
 		}
 
 		path_list_clear(re_merge, 0);
@@ -1210,6 +1253,12 @@ static int merge(struct commit *h1,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
+	if (!call_depth && do_progress) {
+		merged_cnt = total_cnt;
+		progress_update = 1;
+		display_progress();
+		fputc('\n', stderr);
+	}
 	flush_output();
 	return clean;
 }
@@ -1279,6 +1328,10 @@ int main(int argc, char *argv[])
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
+	if (verbosity >= 5) {
+		buffer_output = 0;
+		do_progress = 0;
+	}
 
 	branch1 = argv[++i];
 	branch2 = argv[++i];
@@ -1288,8 +1341,12 @@ int main(int argc, char *argv[])
 
 	branch1 = better_branch_name(branch1);
 	branch2 = better_branch_name(branch2);
-	if (verbosity >= 5)
+	if (verbosity >= 5) {
 		buffer_output = 0;
+		do_progress = 0;
+	}
+	if (do_progress)
+		setup_progress_signal();
 	if (show(3))
 		printf("Merging %s with %s\n", branch1, branch2);
 
-- 
1.5.0.rc1.g4494
