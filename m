Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E81944F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E0D57
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 12:39:44 -0800 (PST)
Received: (qmail 20681 invoked by uid 109); 13 Nov 2023 20:39:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 20:39:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6464 invoked by uid 111); 13 Nov 2023 20:39:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 15:39:45 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 15:39:43 -0500
From: Jeff King <peff@peff.net>
To: Kevin Lyles <klyles@epic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"allred.sean@gmail.com" <allred.sean@gmail.com>
Subject: Re: rev-list default order sometimes very slow (size and metadata
 dependent)
Message-ID: <20231113203943.GD3838361@coredump.intra.peff.net>
References: <DM6PR17MB247594CF3A0511EF95893935AEADA@DM6PR17MB2475.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR17MB247594CF3A0511EF95893935AEADA@DM6PR17MB2475.namprd17.prod.outlook.com>

On Sat, Nov 11, 2023 at 04:17:17PM +0000, Kevin Lyles wrote:

> If the archive branch is created with author/commit dates older than the
> rest of the repository, we're able to run:
> 
>   $ git rev-list --count --all
> 
> in ~9-10 seconds on a mirror clone with a commit-graph.  However, if the
> archive branch is instead created with author/commit dates newer than the
> rest of the repository, it takes 4-5 minutes.

Thanks for providing a reproduction script. I had trouble following the
text explanation, but I can easily reproduce the issue using your
script.

Running the slow case under perf, it looks like we are spending most of
the time in commit_list_insert_by_date(). Which makes sense. The queue
of commits to visit during the traversal is kept as an ordered linked
list that uses linear search for the insertion. So the worst case to
insert N commits is quadratic.

In practice, it tends not to be a big problem because we visit commits
in roughly reverse-timestamp order as we traverse. So it's more like
O(N*width), where "width" is the average number of simultaneous lines of
history. And your archive graph is...very wide.

Playing with the commit timestamps helps your case because it just
happens to reorder the queue in such a way that we put off looking at
those huge archive merges until much later in the traversal, when our
remaining "N" is much smaller.

The right solution is obviously to switch to a better data structure.
And some of the infrastructure is in place from the last time we dealt
with a similar case:

  https://lore.kernel.org/git/HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com/

There we started using a priority queue instead of the linked list.
That patch stopped shorting of replacing the main revs->commits
traversal list, though, as it's referenced in a ton of places (some of
which really care about its list-like nature). Here's a hacky patch that
tries to lazily convert the list to a queue. It makes your case much
faster, but it also causes a few failures in the test suite (related to
commit ordering), so obviously it's violating some assumptions
somewhere. I'm not sure if it's a fruitful direction or not.

And as you noticed, using --topo-order does not suffer from the same
problem. It follows a completely different path, which...you guessed it,
uses a priority queue. I'm not sure what the current state of things is,
but one of the promises of commit-graphs is that with stored generation
numbers, we could compute topo-order incrementally and efficiently. So
another possible route is that we'd simply enable it by default. But I'm
not sure if there's more work that needs to be done to get there, or if
there are other downsides.

diff --git a/revision.c b/revision.c
index 00d5c29bfc..62d33dbfee 100644
--- a/revision.c
+++ b/revision.c
@@ -3119,6 +3119,7 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
+	clear_prio_queue(&revs->commitq);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -4161,6 +4162,36 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 
 static struct commit *get_revision_1(struct rev_info *revs)
 {
+	/*
+	 * This is kind of hacky. We'll dynamically move commits from the
+	 * linear list over to our priority queue, which has better worst-case
+	 * behavior. Doing it here serves two purposes:
+	 *
+	 *   - we'll let all of the setup code still operate on the "commits"
+	 *     list, and then just move it over to the queue lazily. This
+	 *     probably could be done in prepare_revision_walk() or similar,
+	 *     but by doing it here we know we're catching all code paths.
+	 *
+	 *   - we'll likewise catch any code which tries to add new commits to
+	 *     the list _during_ the traversal. The main one would be
+	 *     process_parents() below, which we've taught to use the queue
+	 *     directly. But this will catch any other random bits of code,
+	 *     including callers of the revision API, which add to the
+	 *     traversal as they go.
+	 *
+	 * A cleaner solution would probably be to get rid of the "commits"
+	 * list entirely, but that's a much bigger task.
+	 */
+	if (revs->commits && !revs->topo_order) {
+		struct commit_list *p;
+		if (!revs->unsorted_input)
+			revs->commitq.compare = compare_commits_by_commit_date;
+		for (p = revs->commits; p; p = p->next)
+			prio_queue_put(&revs->commitq, p->item);
+		free_commit_list(revs->commits);
+		revs->commits = NULL;
+	}
+
 	while (1) {
 		struct commit *commit;
 
@@ -4169,7 +4200,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		else if (revs->topo_walk_info)
 			commit = next_topo_commit(revs);
 		else
-			commit = pop_commit(&revs->commits);
+			commit = prio_queue_get(&revs->commitq);
 
 		if (!commit)
 			return NULL;
@@ -4191,7 +4222,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 				try_to_simplify_commit(revs, commit);
 			else if (revs->topo_walk_info)
 				expand_topo_walk(revs, commit);
-			else if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
+			else if (process_parents(revs, commit, NULL, &revs->commitq) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 						oid_to_hex(&commit->object.oid));
diff --git a/revision.h b/revision.h
index 94c43138bc..4301b825a0 100644
--- a/revision.h
+++ b/revision.h
@@ -12,6 +12,7 @@
 #include "ident.h"
 #include "list-objects-filter-options.h"
 #include "strvec.h"
+#include "prio-queue.h"
 
 /**
  * The revision walking API offers functions to build a list of revisions
@@ -124,6 +125,12 @@ struct rev_info {
 	struct object_array pending;
 	struct repository *repo;
 
+	/*
+	 * We'll use this queue during the actual traversal, rather than
+	 * adding and popping from the "commits" list.
+	 */
+	struct prio_queue commitq;
+
 	/* Parents of shown commits */
 	struct object_array boundary_commits;
 
