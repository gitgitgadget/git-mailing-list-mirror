From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Chose better tag names in git-describe after merges.
Date: Wed, 10 Jan 2007 06:39:47 -0500
Message-ID: <20070110113947.GC25251@spearce.org>
References: <de93279981338622182dd8f00e4686c6624697b6.1168428978.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 12:40:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4boA-0001mH-AB
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 12:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbXAJLjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 06:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbXAJLjv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 06:39:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53465 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964863AbXAJLju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 06:39:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4bo2-0004Cd-6I; Wed, 10 Jan 2007 06:39:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E4D120FBAE; Wed, 10 Jan 2007 06:39:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <de93279981338622182dd8f00e4686c6624697b6.1168428978.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36501>

Recently git.git itself encountered a situation on its master and
next branches where git-describe stopped reporting 'v1.5.0-rc0-gN'
and instead started reporting 'v1.4.4.4-gN'.  This appeared to be
a backward jump in version numbering.

  maint     o-------------------4
            \                    \
  master     o-o-o-o-o-o-o-5-o-C-o-W

The issue is that commit C in the diagram claims it is version
1.5.0, as the tag v1.5.0 is placed on commit 5.  Yet commit W
claims it is version 1.4.4.4 as the tag v1.5.0 has an older tag
date than the v1.4.4.4 tag.

As it turns out this situation is very common.  A bug fix applied
to maint and later merged into master occurs frequently enough that
it should Just Work Right(tm).

Rather than taking the first tag that gets found git-describe will
now generate a list of all possible tags and select the one which
has the most number of commits in common with HEAD (or whatever
revision the user requested the description of).

This rule is based on the principle shown in the diagram above.
There are a large number of commits on the primary development branch
'master' which do not appear in the 'maint' branch, and many of
these are already tagged as part of v1.5.0-rc0.  Additionally these
commits are not in v1.4.4.4, as they are part of the v1.5.0 release
still being developed.  The v1.5.0-rc0 tag is more descriptive of
W than v1.4.4.4 is, and therefore should be used.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This implements the algorithm I suggested on the mailing list.

 In my limited testing on git.git its 4x slower than the previous
 git-describe on current 'next' as its coming up with about 10
 tags as possible matches and then needs to generate the rev-list
 for each of them.  (Old = 100 ms, new = 400 ms).  I think that is
 acceptable in exchange for a "more likely to be correct" answer,
 especially when users are embedding git-describe's output into
 their binaries and expecting it to make some sort of sense.

 Since this is my first foray into calling the revision machinary
 for any sort of useful computation I would certainly appreciate
 comments and suggestions for improvements from those who know it
 better than I.  :-)

 builtin-describe.c |   78 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index ad3b469..d65c7d2 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -2,10 +2,11 @@
 #include "commit.h"
 #include "tag.h"
 #include "refs.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
 #include "builtin.h"
 
-#define SEEN (1u << 0)
-
 static const char describe_usage[] =
 "git-describe [--all] [--tags] [--abbrev=<n>] <committish>*";
 
@@ -16,7 +17,7 @@ static int abbrev = DEFAULT_ABBREV;
 
 static int names, allocs;
 static struct commit_name {
-	const struct commit *commit;
+	struct commit *commit;
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
 	char path[FLEX_ARRAY]; /* more */
 } **name_array = NULL;
@@ -35,7 +36,7 @@ static struct commit_name *match(struct commit *cmit)
 }
 
 static void add_to_known_names(const char *path,
-			       const struct commit *commit,
+			       struct commit *commit,
 			       int prio)
 {
 	int idx;
@@ -98,6 +99,12 @@ static int compare_names(const void *_a, const void *_b)
 	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
 }
 
+struct possible_tag {
+	struct possible_tag *next;
+	struct commit_name *name;
+	unsigned long depth;
+};
+
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
@@ -105,6 +112,7 @@ static void describe(const char *arg, int last_one)
 	struct commit_list *list;
 	static int initialized = 0;
 	struct commit_name *n;
+	struct possible_tag *all_matches, *min_match, *cur_match;
 
 	if (get_sha1(arg, sha1))
 		die("Not a valid object name %s", arg);
@@ -125,19 +133,67 @@ static void describe(const char *arg, int last_one)
 	}
 
 	list = NULL;
+	all_matches = NULL;
+	cur_match = NULL;
 	commit_list_insert(cmit, &list);
 	while (list) {
-		struct commit *c = pop_most_recent_commit(&list, SEEN);
+		struct commit *c = pop_commit(&list);
 		n = match(c);
 		if (n) {
-			printf("%s-g%s\n", n->path,
-			       find_unique_abbrev(cmit->object.sha1, abbrev));
-			if (!last_one)
-				clear_commit_marks(cmit, SEEN);
-			return;
+			struct possible_tag *p = xmalloc(sizeof(*p));
+			p->name = n;
+			p->next = NULL;
+			if (cur_match)
+				cur_match->next = p;
+			else
+				all_matches = p;
+			cur_match = p;
+		} else {
+			struct commit_list *parents = c->parents;
+			while (parents) {
+				struct commit *p = parents->item;
+				parse_commit(p);
+				if (!(p->object.flags & SEEN)) {
+					p->object.flags |= SEEN;
+					insert_by_date(p, &list);
+				}
+				parents = parents->next;
+			}
+		}
+	}
+
+	if (!all_matches)
+		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+
+	min_match = NULL;
+	for (cur_match = all_matches; cur_match; cur_match = cur_match->next) {
+		struct rev_info revs;
+		struct commit *tagged = cur_match->name->commit;
+
+		clear_commit_marks(cmit, -1);
+		init_revisions(&revs, NULL);
+		tagged->object.flags |= UNINTERESTING;
+		add_pending_object(&revs, &tagged->object, NULL);
+		add_pending_object(&revs, &cmit->object, NULL);
+
+		prepare_revision_walk(&revs);
+		cur_match->depth = 0;
+		while ((!min_match || cur_match->depth < min_match->depth)
+			&& get_revision(&revs))
+			cur_match->depth++;
+		if (!min_match || cur_match->depth < min_match->depth)
+			min_match = cur_match;
+	}
+	printf("%s-g%s\n", min_match->name->path,
+		   find_unique_abbrev(cmit->object.sha1, abbrev));
+
+	if (!last_one) {
+		for (cur_match = all_matches; cur_match; cur_match = min_match) {
+			min_match = cur_match->next;
+			free(cur_match);
 		}
+		clear_commit_marks(cmit, SEEN);
 	}
-	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
 }
 
 int cmd_describe(int argc, const char **argv, const char *prefix)
-- 
1.4.4.4.gf027-dirty
