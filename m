From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Correct priority of lightweight tags in git-describe.
Date: Sun, 14 Jan 2007 04:37:44 -0500
Message-ID: <20070114093744.GB15007@spearce.org>
References: <2a044746b474f7c1840116762e79481b4669900e.1168767397.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 10:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H61oE-0005gc-SH
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 10:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXANJhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 04:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXANJhs
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 04:37:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52962 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXANJhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 04:37:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H61o7-00024v-M0; Sun, 14 Jan 2007 04:37:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AB83120FBAE; Sun, 14 Jan 2007 04:37:44 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <2a044746b474f7c1840116762e79481b4669900e.1168767397.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36800>

We really want to always favor an annotated tag over a lightweight
tag when describing a commit.  Unfortunately git-describe wasn't
doing this as it was favoring the depth attribute of a possible_tag
over the priority.  Now priority is the highest sort and we only
consider a lightweight tag if no annotated tags were identified.

Rather than searching for the minimum tag using a simple loop we
now sort them using a stable sort algorithm, this way the possible
tags display in order if --debug gets used.  The stable sort helps
to preseve the inherit topology/date order that we obtain during
our search loop.

This fix allows the tests in t6120-describe.sh to pass.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 421658d..45fea10 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -22,6 +22,9 @@ static struct commit_name {
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
 	char path[FLEX_ARRAY]; /* more */
 } **name_array[256];
+static const char *prio_names[] = {
+	"head", "lightweight", "annotated",
+};
 
 static struct commit_name *match(struct commit *cmit)
 {
@@ -122,6 +125,17 @@ struct possible_tag {
 	unsigned flag_within;
 };
 
+static int compare_pt(const void *_a, const void *_b)
+{
+	struct possible_tag *a = (struct possible_tag *)_a;
+	struct possible_tag *b = (struct possible_tag *)_b;
+	if (a->name->prio != b->name->prio)
+		return b->name->prio - a->name->prio;
+	if (a->depth != b->depth)
+		return a->depth - b->depth;
+	return 0;
+}
+
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
@@ -129,7 +143,7 @@ static void describe(const char *arg, int last_one)
 	struct commit_list *list;
 	static int initialized = 0;
 	struct commit_name *n;
-	struct possible_tag all_matches[MAX_TAGS], *min_match;
+	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
 
@@ -205,18 +219,12 @@ static void describe(const char *arg, int last_one)
 	if (!match_cnt)
 		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
 
-	min_match = &all_matches[0];
-	for (cur_match = 1; cur_match < match_cnt; cur_match++) {
-		struct possible_tag *t = &all_matches[cur_match];
-		if (t->depth < min_match->depth
-			&& t->name->prio >= min_match->name->prio)
-			min_match = t;
-	}
+	mergesort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
 	if (debug) {
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			fprintf(stderr, " %c %8lu %s\n",
-				min_match == t ? '*' : ' ',
+			fprintf(stderr, " %-11s %8lu %s\n",
+				prio_names[t->name->prio],
 				t->depth, t->name->path);
 		}
 		fprintf(stderr, "traversed %lu commits\n", seen_commits);
@@ -228,7 +236,7 @@ static void describe(const char *arg, int last_one)
 				sha1_to_hex(gave_up_on->object.sha1));
 		}
 	}
-	printf("%s-g%s\n", min_match->name->path,
+	printf("%s-g%s\n", all_matches[0].name->path,
 		   find_unique_abbrev(cmit->object.sha1, abbrev));
 
 	if (!last_one)
-- 
1.5.0.rc1.g4494
