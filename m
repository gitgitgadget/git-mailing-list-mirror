From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] Compute accurate distances in git-describe before output.
Date: Sat, 27 Jan 2007 01:54:21 -0500
Message-ID: <20070127065421.GD10380@spearce.org>
References: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 07:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAhSI-0001yj-G9
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 07:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbXA0GyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 01:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXA0GyZ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 01:54:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49379 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbXA0GyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 01:54:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAhSA-00083L-Kg; Sat, 27 Jan 2007 01:54:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6160E20FBAE; Sat, 27 Jan 2007 01:54:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37927>

My prior change to git-describe attempts to print the distance
between the input commit and the best matching tag, but this distance
was usually only an estimate as we always aborted revision walking
as soon as we overflowed the configured limit on the number of
possible tags (as set by --candidates).

Displaying an estimated distance is not very useful and can just be
downright confusing.  Most users (heck, most Git developers) don't
immediately understand why this distance differs from the output
of common tools such as `git rev-list | wc -l`.  Even worse, the
estimated distance could change in the future (including decreasing
despite no rebase occuring) if we find more possible tags earlier
on during traversal.  (This could happen if more tags are merged
into the branch between queries.)  These factors basically make an
estimated distance useless.

Fortunately we are usually most of the way through an accurate
distance computation by the time we abort (due to reaching the
current --candidates limit).  This means we can simply finish
counting out the revisions still in our commit queue to present
the accurate distance at the end.  The number of commits remaining
in the commit queue is probably less than the number of commits
already traversed, so finishing out the count is not likely to take
very long.  This final distance will then always match the output of
`git rev-list | wc -l`.

We can easily reduce the total number of commits that need to be
walked at the end by stopping as soon as all of the commits in the
commit queue are flagged as being merged into the already selected
best possible tag.  If that's true then there are no remaining
unseen commits which can contribute to our best possible tag's
depth counter, so further traversal is useless.

Basic testing on my Mac OS X system shows there is no noticable
performance difference between this accurate distance counting
version of git-describe and the prior version of git-describe,
at least when run on git.git.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-describe.txt |    2 +-
 builtin-describe.c             |   42 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index b3e9276..160779a 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -61,7 +61,7 @@ But since my parent branch has a few commits on top of that,
 describe has added the number of additional commits ("+14") and
 the hash of the tip commit ("-g2414721") to the end.
 
-The number of additional commits is an estimate of the number
+The number of additional commits shown after the tag is the number
 of commits which would be displayed by "git log v1.0.4..parent".
 The hash suffix is "-g" + 8-char abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
diff --git a/builtin-describe.c b/builtin-describe.c
index 6e59e75..2ad3c16 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -91,6 +91,39 @@ static int compare_pt(const void *a_, const void *b_)
 	return 0;
 }
 
+static unsigned long finish_depth_computation(
+	struct commit_list **list,
+	struct possible_tag *best)
+{
+	unsigned long seen_commits = 0;
+	while (*list) {
+		struct commit *c = pop_commit(list);
+		struct commit_list *parents = c->parents;
+		seen_commits++;
+		if (c->object.flags & best->flag_within) {
+			struct commit_list *a = *list;
+			while (a) {
+				struct commit *i = a->item;
+				if (!(i->object.flags & best->flag_within))
+					break;
+				a = a->next;
+			}
+			if (!a)
+				break;
+		} else
+			best->depth++;
+		while (parents) {
+			struct commit *p = parents->item;
+			parse_commit(p);
+			if (!(p->object.flags & SEEN))
+				insert_by_date(p, list);
+			p->object.flags |= c->object.flags;
+			parents = parents->next;
+		}
+	}
+	return seen_commits;
+}
+
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
@@ -166,12 +199,19 @@ static void describe(const char *arg, int last_one)
 			parents = parents->next;
 		}
 	}
-	free_commit_list(list);
 
 	if (!match_cnt)
 		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
 
 	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
+
+	if (gave_up_on) {
+		insert_by_date(gave_up_on, &list);
+		seen_commits--;
+	}
+	seen_commits += finish_depth_computation(&list, &all_matches[0]);
+	free_commit_list(list);
+
 	if (debug) {
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-- 
1.5.0.rc2.g8a816
