From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 06/22] teach diff-stages.c about cache iterators
Date: Mon, 12 Sep 2005 10:55:56 -0400
Message-ID: <20050912145556.28120.64001.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:01:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjs-0000SG-Bn
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVILO4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVILO4u
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:50 -0400
Received: from citi.umich.edu ([141.211.133.111]:6521 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751294AbVILOz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:56 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 7A91B1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:55:56 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8396>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 diff-stages.c |   73 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -17,54 +17,55 @@ static int diff_break_opt = -1;
 static const char *orderfile = NULL;
 static const char *diff_filter = NULL;
 
+static int stage1, stage2;
+
 static const char diff_stages_usage[] =
 "git-diff-stages [<common diff options>] <stage1> <stage2> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-static void diff_stages(int stage1, int stage2)
+static int diff_one(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	int i = 0;
-	while (i < active_nr) {
-		struct cache_entry *ce, *stages[4] = { NULL, };
-		struct cache_entry *one, *two;
-		const char *name;
-		int len;
-		ce = active_cache[i];
-		len = ce_namelen(ce);
-		name = ce->name;
-		for (;;) {
-			int stage = ce_stage(ce);
-			stages[stage] = ce;
-			if (active_nr <= ++i)
-				break;
-			ce = active_cache[i];
-			if (ce_namelen(ce) != len ||
-			    memcmp(name, ce->name, len))
-				break;
-		}
-		one = stages[stage1];
-		two = stages[stage2];
-		if (!one && !two)
-			continue;
-		if (!one)
-			diff_addremove('+', ntohl(two->ce_mode),
-				       two->sha1, name, NULL);
-		else if (!two)
-			diff_addremove('-', ntohl(one->ce_mode),
-				       one->sha1, name, NULL);
+	struct cache_entry *one, *two, *stages[4] = { NULL, };
+	const char *name = ce->name;
+	int len = ce_namelen(ce);
+
+	for (;;) {
+		int stage = ce_stage(ce);
+		stages[stage] = ce;
+		next_cc(cc);
+		if (cache_eof(cc))
+			break;
+		ce = cc_to_ce(cc);
+		if (ce_namelen(ce) != len ||
+			memcmp(name, ce->name, len))
+			break;
+	}
+
+	one = stages[stage1];
+	two = stages[stage2];
+	if (!one && !two)
+		goto out;
+	if (!one)
+		diff_addremove('+', ntohl(two->ce_mode),
+					two->sha1, name, NULL);
+	else if (!two)
+		diff_addremove('-', ntohl(one->ce_mode),
+					one->sha1, name, NULL);
 		else if (memcmp(one->sha1, two->sha1, 20) ||
 			 (one->ce_mode != two->ce_mode) ||
-			 find_copies_harder)
+			find_copies_harder)
 			diff_change(ntohl(one->ce_mode), ntohl(two->ce_mode),
-				    one->sha1, two->sha1, name, NULL);
-	}
+					one->sha1, two->sha1, name, NULL);
+out:
+	next_cc(cc);
+	return 0;
 }
 
 int main(int ac, const char **av)
 {
-	int stage1, stage2;
+	if (read_cache() < 0)
+		die("unable to read index file");
 
-	read_cache();
 	while (1 < ac && av[1][0] == '-') {
 		const char *arg = av[1];
 		if (!strcmp(arg, "-r"))
@@ -117,7 +118,7 @@ int main(int ac, const char **av)
 	av += 3; /* The rest from av[0] are for paths restriction. */
 	diff_setup(diff_setup_opt);
 
-	diff_stages(stage1, stage2);
+	walk_cache(diff_one);
 
 	diffcore_std(av,
 		     detect_rename, diff_score_opt,
