From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 1/4] tag: speed up --contains calculation
Date: Mon, 5 Jul 2010 08:33:36 -0400
Message-ID: <20100705123335.GA25699@sigill.intra.peff.net>
References: <20100705122723.GB21146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 05 14:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVkro-0002EZ-5r
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0GEMdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:33:39 -0400
Received: from peff.net ([208.65.91.99]:38138 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab0GEMdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 08:33:38 -0400
Received: (qmail 12117 invoked by uid 107); 5 Jul 2010 12:34:34 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 08:34:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 08:33:36 -0400
Content-Disposition: inline
In-Reply-To: <20100705122723.GB21146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150261>

When we want to know if commit A contains commit B (or any
one of a set of commits, B through Z), we generally
calculate the merge bases and see if B is a merge base of A
(or for a set, if any of the commits B through Z have that
property).

When we are going to check a series of commits A1 through An
to see whether each contains B (e.g., because we are
deciding which tags to show with "git tag --contains"), we
do a series of merge base calculations. This can be very
expensive, as we repeat a lot of traversal work.

Instead, let's leverage the fact that we are going to use
the same --contains list for each tag, and mark areas of the
commit graph is definitely containing those commits, or
definitely not containing those commits. Later tags can then
stop traversing as soon as they see a previously calculated
answer.

This sped up "git tag --contains HEAD~200" in the linux-2.6
repository from:

  real    0m15.417s
  user    0m15.197s
  sys     0m0.220s

to:

  real    0m5.329s
  user    0m5.144s
  sys     0m0.184s

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this is a depth first search, whereas we generally traverse in
a more breadth-first way. So it can actually make things slightly slower
than the current merge-base code, if:

  1. You don't have any merge base calculations that involve going very
     far back in history.

  2. We depth-first down the wrong side of a merge.

However, in the usual cases, I think it will perform much better.
Comparing an old tag with a recent commit means we have to look at a lot
of the commit graph, anyway.

If anybody has a clever idea for making it breadth-first, I would be
happy to hear it.

Other caveats:

  1. This can probably be a one-liner change to use in "git branch
     --contains", as well. I didn't measure it, as that already tends to
     be reasonably fast.

  2. It uses commit marks, which means it doesn't behave well with other
     traversals. I have no idea if I should be using alternate marks or
     not.

  3. We never clear the marks, or check them against the "want" list. So
     we just assume that repeated calls to contains will have the same
     "want" list.

 builtin/tag.c |    2 +-
 commit.c      |   42 ++++++++++++++++++++++++++++++++++++++++++
 commit.h      |    2 ++
 3 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..c200e1e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -49,7 +49,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			commit = lookup_commit_reference_gently(sha1, 1);
 			if (!commit)
 				return 0;
-			if (!is_descendant_of(commit, filter->with_commit))
+			if (!contains(commit, filter->with_commit))
 				return 0;
 		}
 
diff --git a/commit.c b/commit.c
index e9b0750..20354c6 100644
--- a/commit.c
+++ b/commit.c
@@ -845,3 +845,45 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_release(&buffer);
 	return result;
 }
+
+static int in_commit_list(const struct commit_list *want, struct commit *c)
+{
+	for (; want; want = want->next)
+		if (!hashcmp(want->item->object.sha1, c->object.sha1))
+			return 1;
+	return 0;
+}
+
+static int contains_recurse(struct commit *candidate,
+			    const struct commit_list *want)
+{
+	struct commit_list *p;
+
+	/* was it previously marked as containing a want commit? */
+	if (candidate->object.flags & TMP_MARK)
+		return 1;
+	/* or marked as not possibly containing a want commit? */
+	if (candidate->object.flags & UNINTERESTING)
+		return 0;
+	/* or are we it? */
+	if (in_commit_list(want, candidate))
+		return 1;
+
+	if (parse_commit(candidate) < 0)
+		return 0;
+
+	/* Otherwise recurse and mark ourselves for future traversals. */
+	for (p = candidate->parents; p; p = p->next) {
+		if (contains_recurse(p->item, want)) {
+			candidate->object.flags |= TMP_MARK;
+			return 1;
+		}
+	}
+	candidate->object.flags |= UNINTERESTING;
+	return 0;
+}
+
+int contains(struct commit *candidate, const struct commit_list *want)
+{
+	return contains_recurse(candidate, want);
+}
diff --git a/commit.h b/commit.h
index eb2b8ac..1a7299e 100644
--- a/commit.h
+++ b/commit.h
@@ -153,6 +153,8 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);
 
+int contains(struct commit *, const struct commit_list *);
+
 extern int interactive_add(int argc, const char **argv, const char *prefix);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
 			       const char **pathspec);
-- 
1.7.2.rc1.209.g2a36c
