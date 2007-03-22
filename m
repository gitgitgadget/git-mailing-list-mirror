From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bisect: show the maximal number of commits to be tested
Date: Thu, 22 Mar 2007 02:43:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070317141209.GA7838@cepheus>
 <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070317195840.GA20735@informatik.uni-freiburg.de> <20070321210454.GA2844@lala>
 <Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-917082937-1174527798=:4045"
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 02:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUCKr-0004Be-Bs
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 02:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXCVBnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 21:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXCVBnV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 21:43:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:40107 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751220AbXCVBnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 21:43:20 -0400
Received: (qmail invoked by alias); 22 Mar 2007 01:43:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 22 Mar 2007 02:43:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gTywpDaGgg+epjN73p7tjAk0/mhgoh8Vp1cY5wK
	1zm+7qqbzx6559
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42830>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-917082937-1174527798=:4045
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


Since git-bisect already asks rev-list to find the midpoint (and rev-list
consequently counts the number of commits), rev-list can pass it the
maximal number of commits.

As a bonus, this avoids an extra call to rev-list.

Miscalculation noticed by Uwe, implementation suggested by Linus.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 21 Mar 2007, Linus Torvalds wrote:

	> On Wed, 21 Mar 2007, Uwe Kleine-König wrote:
	> >
	> > Up to now the number printed was calculated assuming that the 
	> > current revision to test is bad.  Given that it's not possible 
	> > that this always matches the number of suspicious revs if the 
	> > current one is good, the maximum of both is taken now.
	> 
	> How about adding a new flag to "git-rev-list", to make it count 
	> both ways?

	Did I understand you correctly?

 Documentation/git-rev-list.txt |    8 ++++++++
 builtin-rev-list.c             |   40 +++++++++++++++++++++++++++++++++-------
 git-bisect.sh                  |    7 +++----
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 4f145ea..5f6f2a3 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -26,6 +26,7 @@ SYNOPSIS
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
+	     [ \--bisect-vars ]
 	     [ \--merge ]
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
@@ -249,6 +250,13 @@ introduces a regression is thus reduced to a binary search: repeatedly
 generate and test new 'midpoint's until the commit chain is of length
 one.
 
+--bisect-vars::
+
+This calculates the same as --bisect, but outputs a line ready to be
+eval'ed by the shell. This line will assign the name of the midpoint
+revision to the variable 'rev', and the maximal number of commits to
+be tested after this revision to 'nr'.
+
 --
 
 Commit Ordering
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c2db5a5..b653975 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -36,12 +36,12 @@ static const char rev_list_usage[] =
 "    --abbrev=nr | --no-abbrev\n"
 "    --abbrev-commit\n"
 "  special purpose:\n"
-"    --bisect"
+"    --bisect\n"
+"    --bisect-vars"
 ;
 
 static struct rev_info revs;
 
-static int bisect_list;
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
@@ -168,7 +168,8 @@ static void clear_distance(struct commit_list *list)
 	}
 }
 
-static struct commit_list *find_bisection(struct commit_list *list)
+static struct commit_list *find_bisection(struct commit_list *list,
+	int *nr_bad, int *nr_good)
 {
 	int nr, closest;
 	struct commit_list *p, *best;
@@ -198,8 +199,20 @@ static struct commit_list *find_bisection(struct commit_list *list)
 			closest = distance;
 		}
 	}
-	if (best)
+	if (best) {
 		best->next = NULL;
+		/*
+		 * The variable nr_bad holds the number of revisions
+		 * to be tested if "best" is marked as bad, and nr_good
+		 * the number if "best" is marked as good.
+		 *
+		 * Since the given range is <good>..<bad>, we have to
+		 * subtract one, because both <good> and <bad> were
+		 * already tested.
+		 */
+		*nr_bad = nr - closest - 1;
+		*nr_good = closest - 1;
+	}
 	return best;
 }
 
@@ -224,7 +237,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
 	int i;
-	int read_from_stdin = 0;
+	int read_from_stdin = 0, bisect_list = 0, bisect_show_vars = 0;
 
 	git_config(git_default_config);
 	init_revisions(&revs, prefix);
@@ -247,6 +260,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_list = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--bisect-vars")) {
+			bisect_list = 1;
+			bisect_show_vars = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
@@ -285,8 +303,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.tree_objects)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
-	if (bisect_list)
-		revs.commits = find_bisection(revs.commits);
+	if (bisect_list) {
+		int nr_bad = 0, nr_good = 0;
+		revs.commits = find_bisection(revs.commits, &nr_bad, &nr_good);
+		if (bisect_show_vars) {
+			printf("rev=%s;nr=%d;\n", !revs.commits ? "" :
+				sha1_to_hex(revs.commits->item->object.sha1),
+				nr_bad > nr_good ? nr_bad : nr_good);
+			return 0;
+		}
+	}
 
 	traverse_commit_list(&revs, show_commit, show_object);
 
diff --git a/git-bisect.sh b/git-bisect.sh
index b1c3a6b..cd5e3c9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -138,9 +138,9 @@ bisect_next() {
 	bisect_autostart
 	bisect_next_check fail
 	bad=$(git-rev-parse --verify refs/bisect/bad) &&
-	good=$(git-rev-parse --sq --revs-only --not \
-		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) &&
-	rev=$(eval "git-rev-list --bisect $good $bad -- $(cat $GIT_DIR/BISECT_NAMES)") || exit
+	good=$(git-rev-parse --revs-only --not \
+		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) || exit
+	eval "$(git-rev-list --bisect-vars $good $bad -- $(cat $GIT_DIR/BISECT_NAMES))" || exit
 	if [ -z "$rev" ]; then
 	    echo "$bad was both good and bad"
 	    exit 1
@@ -150,7 +150,6 @@ bisect_next() {
 	    git-diff-tree --pretty $rev
 	    exit 0
 	fi
-	nr=$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
 	echo "Bisecting: $nr revisions left to test after this"
 	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
 	git checkout -q new-bisect || exit
-- 
1.5.1.rc1.2306.g3d2f

---1148973799-917082937-1174527798=:4045--
