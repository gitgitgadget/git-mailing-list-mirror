From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Segfault with rev-list --bisect
Date: Wed, 4 Mar 2015 00:33:33 -0500
Message-ID: <20150304053333.GA9584@peff.net>
References: <CAMo-WNYNeShbbhNfG455o7krGfY7_9zVU3dMpJ7b4Smh_AiATg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Troy Moure <troy.moure@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 06:33:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT1wH-0003uc-TM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 06:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbbCDFdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 00:33:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:56008 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750832AbbCDFdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 00:33:36 -0500
Received: (qmail 17554 invoked by uid 102); 4 Mar 2015 05:33:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Mar 2015 23:33:36 -0600
Received: (qmail 26904 invoked by uid 107); 4 Mar 2015 05:33:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 00:33:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 00:33:33 -0500
Content-Disposition: inline
In-Reply-To: <CAMo-WNYNeShbbhNfG455o7krGfY7_9zVU3dMpJ7b4Smh_AiATg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264720>

On Tue, Mar 03, 2015 at 09:19:14AM -0500, Troy Moure wrote:

> I've found a case where git rev-list --bisect segfaults reproducibly
> (git version is 2.3.1). This is the commit topology (A2 is the first
> parent of M):
> 
> I - A1 - A2
>   \        \
>     - B1 -- M  (HEAD)

Thanks for finding a simple history which shows the problem. I recreated
this with:

    git init repo && cd repo &&
    echo I >I && git add I && git commit -m I &&
    echo A1 >A && git add A && git commit -m A1 &&
    echo A2 >A && git add A && git commit -m A2 &&
    git checkout -b side HEAD~2 &&
    echo B1 >B && git add B && git commit -m B1 &&
    git checkout master &&
    GIT_EDITOR=: git merge side

and was able to reproduce the segfault with:

    git rev-list --bisect --first-parent HEAD --not HEAD~1

(it drops --parents from your command, which is not relevant to the
segfault). The segfault itself happens because we try to access the
weight() of B1, even though we never called weight_set() on it.

And that, I think, is related to --first-parent. We do not set a weight
because B1 is not an interesting commit to us (it is accessible only as
a second parent). I am not too familiar with the bisect code, but it
looks like it is not really ready to handle --first-parent. There are
several spots where it enumerates the parent list, which is going to
examine parents other than the first.

Below is a fairly hacky patch to respect --first-parent through the
bisection code. Like I said, I'm not very familiar with this code, so I
basically just blindly limited any traversal of commit->parents. It does
solve this particular segfault, but I have no clue if it is fixing other
bugs introducing them. :) E.g., it's changing count_distance(), so
perhaps our bisection counts were all off with --first-parent, even when
it didn't segfault?

diff --git a/bisect.c b/bisect.c
index 8c6d843..c51f37a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -31,7 +31,7 @@ static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD
  * We care just barely enough to avoid recursing for
  * non-merge entries.
  */
-static int count_distance(struct commit_list *entry)
+static int count_distance(struct commit_list *entry, int max_parents)
 {
 	int nr = 0;
 
@@ -47,9 +47,10 @@ static int count_distance(struct commit_list *entry)
 		p = commit->parents;
 		entry = p;
 		if (p) {
+			int n = max_parents - 1;
 			p = p->next;
-			while (p) {
-				nr += count_distance(p);
+			while (p && n-- > 0) {
+				nr += count_distance(p, max_parents);
 				p = p->next;
 			}
 		}
@@ -79,12 +80,12 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	*((int*)(elem->item->util)) = weight;
 }
 
-static int count_interesting_parents(struct commit *commit)
+static int count_interesting_parents(struct commit *commit, int max_parents)
 {
 	struct commit_list *p;
 	int count;
 
-	for (count = 0, p = commit->parents; p; p = p->next) {
+	for (count = 0, p = commit->parents; p && max_parents-- > 0; p = p->next) {
 		if (p->item->object.flags & UNINTERESTING)
 			continue;
 		count++;
@@ -117,7 +118,7 @@ static inline int halfway(struct commit_list *p, int nr)
 #define show_list(a,b,c,d) do { ; } while (0)
 #else
 static void show_list(const char *debug, int counted, int nr,
-		      struct commit_list *list)
+		      struct commit_list *list, int max_parents)
 {
 	struct commit_list *p;
 
@@ -132,6 +133,7 @@ static void show_list(const char *debug, int counted, int nr,
 		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
 		const char *subject_start;
 		int subject_len;
+		int n = max_parents;
 
 		fprintf(stderr, "%c%c%c ",
 			(flags & TREESAME) ? ' ' : 'T',
@@ -142,7 +144,7 @@ static void show_list(const char *debug, int counted, int nr,
 		else
 			fprintf(stderr, "---");
 		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
-		for (pp = commit->parents; pp; pp = pp->next)
+		for (pp = commit->parents; pp && n-- > 0; pp = pp->next)
 			fprintf(stderr, " %.*s", 8,
 				sha1_to_hex(pp->item->object.sha1));
 
@@ -245,7 +247,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all)
+					     int find_all, int max_parents)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -257,7 +259,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		unsigned flags = commit->object.flags;
 
 		p->item->util = &weights[n++];
-		switch (count_interesting_parents(commit)) {
+		switch (count_interesting_parents(commit, max_parents)) {
 		case 0:
 			if (!(flags & TREESAME)) {
 				weight_set(p, 1);
@@ -300,7 +302,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
-		weight_set(p, count_distance(p));
+		weight_set(p, count_distance(p, max_parents));
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
@@ -315,10 +317,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		for (p = list; p; p = p->next) {
 			struct commit_list *q;
 			unsigned flags = p->item->object.flags;
+			int n = max_parents;
 
 			if (0 <= weight(p))
 				continue;
-			for (q = p->item->parents; q; q = q->next) {
+			for (q = p->item->parents; q && n-- > 0; q = q->next) {
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
 				if (0 <= weight(q))
@@ -357,11 +360,12 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 
 struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
-					  int find_all)
+					  int find_all, int first_parent_only)
 {
 	int nr, on_list;
 	struct commit_list *p, *best, *next, *last;
 	int *weights;
+	int max_parents = first_parent_only ? 1 : INT_MAX;
 
 	show_list("bisection 2 entry", 0, 0, list);
 
@@ -390,7 +394,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, nr, weights, find_all, max_parents);
 	if (best) {
 		if (!find_all)
 			best->next = NULL;
@@ -916,7 +920,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	bisect_common(&revs);
 
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
-				       !!skipped_revs.nr);
+				       !!skipped_revs.nr,
+				       revs.first_parent_only);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index 2a6c831..03d04d1 100644
--- a/bisect.h
+++ b/bisect.h
@@ -3,7 +3,7 @@
 
 extern struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
-					  int find_all);
+					  int find_all, int first_parent_only);
 
 extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..3f531d6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -380,7 +380,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		int reaches = reaches, all = all;
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
-					      bisect_find_all);
+					      bisect_find_all,
+					      revs.first_parent_only);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
