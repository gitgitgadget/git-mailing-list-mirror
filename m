From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Remove hash in git-describe in favor of util slot.
Date: Sun, 14 Jan 2007 22:16:55 -0500
Message-ID: <20070115031655.GA11809@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWG-0000gM-89
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:16 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8s-0003eK-BO
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbXAODRD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 22:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbXAODRD
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 22:17:03 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35270 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbXAODRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 22:17:01 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6IL0-0003W5-FK; Sun, 14 Jan 2007 22:16:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E58E20FBAE; Sun, 14 Jan 2007 22:16:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36833>

Currently we don't use the util field of struct commit but we want
fast access to the highest priority name that references any given
commit object during our matching loop.  A really simple approach
is to just store the name directly in the util field.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This removes more lines than it adds, so it must be good, right?
 :-)

 builtin-describe.c |   76 ++++++++-------------------------------------------
 1 files changed, 12 insertions(+), 64 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index e38c899..e7b8f95 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -16,60 +16,27 @@ static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
 
-static unsigned int names[256], allocs[256];
-static struct commit_name {
-	struct commit *commit;
+struct commit_name {
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
 	char path[FLEX_ARRAY]; /* more */
-} **name_array[256];
+};
 static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
-static struct commit_name *match(struct commit *cmit)
-{
-	unsigned char level0 = cmit->object.sha1[0];
-	struct commit_name **p = name_array[level0];
-	unsigned int hi = names[level0];
-	unsigned int lo = 0;
-
-	while (lo < hi) {
-		unsigned int mi = (lo + hi) / 2;
-		int cmp = hashcmp(p[mi]->commit->object.sha1,
-			cmit->object.sha1);
-		if (!cmp) {
-			while (mi && p[mi - 1]->commit == cmit)
-				mi--;
-			return p[mi];
-		}
-		if (cmp > 0)
-			hi = mi;
-		else
-			lo = mi+1;
-	}
-	return NULL;
-}
-
 static void add_to_known_names(const char *path,
 			       struct commit *commit,
 			       int prio)
 {
-	int idx;
-	int len = strlen(path)+1;
-	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
-	unsigned char m = commit->object.sha1[0];
-
-	name->commit = commit;
-	name->prio = prio;
-	memcpy(name->path, path, len);
-	idx = names[m];
-	if (idx >= allocs[m]) {
-		allocs[m] = (idx + 50) * 3 / 2;
-		name_array[m] = xrealloc(name_array[m],
-			allocs[m] * sizeof(*name_array));
+	struct commit_name *e = commit->util;
+	if (!e || e->prio < prio) {
+		size_t len = strlen(path)+1;
+		free(e);
+		e = xmalloc(sizeof(struct commit_name) + len);
+		e->prio = prio;
+		memcpy(e->path, path, len);
+		commit->util = e;
 	}
-	name_array[m][idx] = name;
-	names[m] = ++idx;
 }
 
 static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
@@ -104,21 +71,6 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	return 0;
 }
 
-static int compare_names(const void *_a, const void *_b)
-{
-	struct commit_name *a = *(struct commit_name **)_a;
-	struct commit_name *b = *(struct commit_name **)_b;
-	unsigned long a_date = a->commit->date;
-	unsigned long b_date = b->commit->date;
-	int cmp = hashcmp(a->commit->object.sha1, b->commit->object.sha1);
-
-	if (cmp)
-		return cmp;
-	if (a->prio != b->prio)
-		return b->prio - a->prio;
-	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
-}
-
 struct possible_tag {
 	struct commit_name *name;
 	int depth;
@@ -158,15 +110,11 @@ static void describe(const char *arg, int last_one)
 		die("%s is not a valid '%s' object", arg, commit_type);
 
 	if (!initialized) {
-		unsigned int m;
 		initialized = 1;
 		for_each_ref(get_name, NULL);
-		for (m = 0; m < ARRAY_SIZE(name_array); m++)
-			qsort(name_array[m], names[m],
-				sizeof(*name_array[m]), compare_names);
 	}
 
-	n = match(cmit);
+	n = cmit->util;
 	if (n) {
 		printf("%s\n", n->path);
 		return;
@@ -182,7 +130,7 @@ static void describe(const char *arg, int last_one)
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
 		seen_commits++;
-		n = match(c);
+		n = c->util;
 		if (n) {
 			if (match_cnt < max_candidates) {
 				struct possible_tag *t = &all_matches[match_cnt++];
-- 
1.5.0.rc1.g4494
