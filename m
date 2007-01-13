From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] Improve git-describe performance by reducing revision listing.
Date: Sat, 13 Jan 2007 17:30:53 -0500
Message-ID: <20070113223053.GD18011@spearce.org>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 23:31:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5rOu-0002jz-Ma
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 23:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbXAMWa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 17:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbXAMWa6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 17:30:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36096 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030297AbXAMWa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 17:30:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5rOf-0000Zk-VC; Sat, 13 Jan 2007 17:30:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D427E20FBAE; Sat, 13 Jan 2007 17:30:53 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36781>

My prior version of git-describe ran very slowly on even reasonably
sized projects like git.git and linux.git as it tended to identify
a large number of possible tags and then needed to generate the
revision list for each of those tags to sort them and select the
best tag to describe the input commit.

All we really need is the number of commits in the input revision
which are not in the tag.  We can generate these counts during
the revision walking and tag matching loop by assigning a color to
each tag and coloring the commits as we walk them.  This limits us
to identifying no more than 26 possible tags, as there is limited
space available within the flags field of struct commit.

The limitation of 26 possible tags is hopefully not going to be a
problem in real usage, as most projects won't create 26 maintenance
releases and merge them back into a development trunk after the
development trunk was tagged with a release candidate tag.  If that
does occur git-describe will start to revert to its old behavior of
using the newer maintenance release tag to describe the development
trunk, rather than the development trunk's own tag.  The suggested
workaround would be to retag the development trunk's tip.

However since even 26 possible tags can take a while to generate a
description for on some projects I'm defaulting the limit to 10 but
offering the user --candidates to increase the number of possible
matches if they need a more accurate result.  I specifically chose
10 for the default as it seems unlikely projects will have more
than 10 maintenance releases merged into a development trunk before
retagging the development trunk, and it seems to perform about the
same on linux.git as v1.4.4.4 git-describe.

A large amount of debugging information was also added during
the development of this change, so I've left it in to be toggled
on with --debug.  It may be useful to the end user to help them
understand why git-describe took one particular tag over another.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Junio C Hamano <junkio@cox.net> wrote:
 > This actually is QUITE bad.
 > 
 > With the tip of linux-2.6 repository, v1.4.4 series takes 0.03s
 > while v1.5.0-rc1 takes about 3.6s.  That is 100x fold, not just 4x.

 This should restore git-describe to taking 0.03s on your system,
 yet get us 10 tag accuracy.  It is running close to even with
 1.4.4.4's git-describe on my system.

 Documentation/git-describe.txt |   30 ++++++++++
 builtin-describe.c             |  125 ++++++++++++++++++++++++----------------
 2 files changed, 106 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 2700f35..b87783c 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -35,6 +35,16 @@ OPTIONS
 	Instead of using the default 8 hexadecimal digits as the
 	abbreviated object name, use <n> digits.
 
+--candidates=<n>::
+	Instead of considering only the 10 most recent tags as
+	candidates to describe the input committish consider
+	up to <n> candidates.  Increasing <n> above 10 will take
+	slightly longer but may produce a more accurate result.
+
+--debug::
+	Verbosely display information about the searching strategy
+	being employed to standard error.  The tag name will still
+	be printed to standard out.
 
 EXAMPLES
 --------
@@ -63,6 +73,26 @@ the output shows the reference path as well:
 	[torvalds@g5 git]$ git describe --all HEAD^
 	heads/lt/describe-g975b
 
+SEARCH STRATEGY
+---------------
+
+For each committish supplied "git describe" will first look for
+a tag which tags exactly that commit.  Annotated tags will always
+be preferred over lightweight tags, and tags with newer dates will
+always be preferred over tags with older dates.  If an exact match
+is found, its name will be output and searching will stop.
+
+If an exact match was not found "git describe" will walk back
+through the commit history to locate an ancestor commit which
+has been tagged.  The ancestor's tag will be output along with an
+abbreviation of the input committish's SHA1.
+
+If multiple tags were found during the walk then the tag which
+has the fewest commits different from the input committish will be
+selected and output.  Here fewest commits different is defined as
+the number of commits which would be shown by "git log tag..input"
+will be the smallest number of commits possible.
+
 
 Author
 ------
diff --git a/builtin-describe.c b/builtin-describe.c
index 5d6865b..421658d 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -2,17 +2,19 @@
 #include "commit.h"
 #include "tag.h"
 #include "refs.h"
-#include "diff.h"
-#include "diffcore.h"
-#include "revision.h"
 #include "builtin.h"
 
+#define SEEN		(1u<<0)
+#define MAX_TAGS	(FLAG_BITS - 1)
+
 static const char describe_usage[] =
 "git-describe [--all] [--tags] [--abbrev=<n>] <committish>*";
 
+static int debug;	/* Display lots of verbose info */
 static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev = DEFAULT_ABBREV;
+static int max_candidates = 10;
 
 static unsigned int names[256], allocs[256];
 static struct commit_name {
@@ -115,19 +117,21 @@ static int compare_names(const void *_a, const void *_b)
 }
 
 struct possible_tag {
-	struct possible_tag *next;
 	struct commit_name *name;
 	unsigned long depth;
+	unsigned flag_within;
 };
 
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
-	struct commit *cmit;
+	struct commit *cmit, *gave_up_on = NULL;
 	struct commit_list *list;
 	static int initialized = 0;
 	struct commit_name *n;
-	struct possible_tag *all_matches, *min_match, *cur_match;
+	struct possible_tag all_matches[MAX_TAGS], *min_match;
+	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
+	unsigned long seen_commits = 0;
 
 	if (get_sha1(arg, sha1))
 		die("Not a valid object name %s", arg);
@@ -150,71 +154,85 @@ static void describe(const char *arg, int last_one)
 		return;
 	}
 
+	if (debug)
+		fprintf(stderr, "searching to describe %s\n", arg);
+
 	list = NULL;
-	all_matches = NULL;
-	cur_match = NULL;
+	cmit->object.flags = SEEN;
 	commit_list_insert(cmit, &list);
 	while (list) {
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
+		seen_commits++;
 		n = match(c);
 		if (n) {
-			struct possible_tag *p = xmalloc(sizeof(*p));
-			p->name = n;
-			p->next = NULL;
-			if (cur_match)
-				cur_match->next = p;
-			else
-				all_matches = p;
-			cur_match = p;
-			if (n->prio == 2)
-				continue;
+			if (match_cnt < max_candidates) {
+				struct possible_tag *t = &all_matches[match_cnt++];
+				t->name = n;
+				t->depth = seen_commits - 1;
+				t->flag_within = 1u << match_cnt;
+				c->object.flags |= t->flag_within;
+				if (n->prio == 2)
+					annotated_cnt++;
+			}
+			else {
+				gave_up_on = c;
+				break;
+			}
+		}
+		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
+			struct possible_tag *t = &all_matches[cur_match];
+			if (!(c->object.flags & t->flag_within))
+				t->depth++;
+		}
+		if (annotated_cnt && !list) {
+			if (debug)
+				fprintf(stderr, "finished search at %s\n",
+					sha1_to_hex(c->object.sha1));
+			break;
 		}
 		while (parents) {
 			struct commit *p = parents->item;
 			parse_commit(p);
-			if (!(p->object.flags & SEEN)) {
-				p->object.flags |= SEEN;
+			if (!(p->object.flags & SEEN))
 				insert_by_date(p, &list);
-			}
+			p->object.flags |= c->object.flags;
 			parents = parents->next;
 		}
 	}
+	free_commit_list(list);
 
-	if (!all_matches)
+	if (!match_cnt)
 		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
 
-	min_match = NULL;
-	for (cur_match = all_matches; cur_match; cur_match = cur_match->next) {
-		struct rev_info revs;
-		struct commit *tagged = cur_match->name->commit;
-
-		clear_commit_marks(cmit, -1);
-		init_revisions(&revs, NULL);
-		tagged->object.flags |= UNINTERESTING;
-		add_pending_object(&revs, &tagged->object, NULL);
-		add_pending_object(&revs, &cmit->object, NULL);
-
-		prepare_revision_walk(&revs);
-		cur_match->depth = 0;
-		while ((!min_match || cur_match->depth < min_match->depth)
-			&& get_revision(&revs))
-			cur_match->depth++;
-		if (!min_match || (cur_match->depth < min_match->depth
-			&& cur_match->name->prio >= min_match->name->prio))
-			min_match = cur_match;
-		free_commit_list(revs.commits);
+	min_match = &all_matches[0];
+	for (cur_match = 1; cur_match < match_cnt; cur_match++) {
+		struct possible_tag *t = &all_matches[cur_match];
+		if (t->depth < min_match->depth
+			&& t->name->prio >= min_match->name->prio)
+			min_match = t;
+	}
+	if (debug) {
+		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
+			struct possible_tag *t = &all_matches[cur_match];
+			fprintf(stderr, " %c %8lu %s\n",
+				min_match == t ? '*' : ' ',
+				t->depth, t->name->path);
+		}
+		fprintf(stderr, "traversed %lu commits\n", seen_commits);
+		if (gave_up_on) {
+			fprintf(stderr,
+				"more than %i tags found; listed %i most recent\n"
+				"gave up search at %s\n",
+				max_candidates, max_candidates,
+				sha1_to_hex(gave_up_on->object.sha1));
+		}
 	}
 	printf("%s-g%s\n", min_match->name->path,
 		   find_unique_abbrev(cmit->object.sha1, abbrev));
 
-	if (!last_one) {
-		for (cur_match = all_matches; cur_match; cur_match = min_match) {
-			min_match = cur_match->next;
-			free(cur_match);
-		}
-		clear_commit_marks(cmit, SEEN);
-	}
+	if (!last_one)
+		clear_commit_marks(cmit, -1);
 }
 
 int cmd_describe(int argc, const char **argv, const char *prefix)
@@ -226,6 +244,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 		if (*arg != '-')
 			break;
+		else if (!strcmp(arg, "--debug"))
+			debug = 1;
 		else if (!strcmp(arg, "--all"))
 			all = 1;
 		else if (!strcmp(arg, "--tags"))
@@ -235,6 +255,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
 				abbrev = DEFAULT_ABBREV;
 		}
+		else if (!strncmp(arg, "--candidates=", 13)) {
+			max_candidates = strtoul(arg + 13, NULL, 10);
+			if (max_candidates < 1)
+				max_candidates = 1;
+			else if (max_candidates > MAX_TAGS)
+				max_candidates = MAX_TAGS;
+		}
 		else
 			usage(describe_usage);
 	}
-- 
1.5.0.rc1.g4494
