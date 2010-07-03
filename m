From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Sat, 3 Jul 2010 04:06:19 -0400
Message-ID: <20100703080618.GA10483@sigill.intra.peff.net>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Sat Jul 03 10:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUxkK-00039w-KY
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 10:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab0GCIG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 04:06:26 -0400
Received: from peff.net ([208.65.91.99]:50147 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823Ab0GCIGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 04:06:21 -0400
Received: (qmail 12512 invoked by uid 107); 3 Jul 2010 08:07:16 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 03 Jul 2010 04:07:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Jul 2010 04:06:19 -0400
Content-Disposition: inline
In-Reply-To: <20100702192612.GM1333@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150180>

On Fri, Jul 02, 2010 at 03:26:12PM -0400, tytso@mit.edu wrote:

> I just tried your patch, and with a large number of tags (198 tags,
> from v2.6.11 to v2.6.34 with all of the -rc releases of the linux
> kernel), it is indeed faster: 8.5 seconds without the patch versus 2.3
> seconds with the patch.
> 
> However, if I remove a large number of tags (since I know this is
> something that was introduced since 2.6.33, so I made a shared clone
> of the repository but then I removed all of the tags from 2.6.11
> through 2.6.33, so there was only 19 tags in play), the time to
> execute the git tag --contains became 1.3 seconds without the patch,
> versus 2.9 seconds without the patch.
> 
> So with the oldest tags removed, your patch actually made things run
> *slower* (2.3 vs 2.9 seconds, which was counter-intuitive to me), and
> fastest way to speed things up was to restrict the tags that would be
> searched.

I'm guessing that it is caused by the depth-first search that my patch
does. If we follow the "wrong" parent of a merge (i.e., the one that the
commit in question is not on), then we will end up hitting all commits
down to the roots before backtracking and looking down the right
parent.

I noticed that my improved time for "git tag --contains" was similar to
the total time for "git rev-list --all >/dev/null". Can you try timing
that? My suspicion is that it is going to be about 2.9 seconds for you.

So we could potentially improve my patch by doing a breadth-first
search, although that is a bit trickier (since the point is to mark and
prune whole subgraphs of history). But I'm not sure it is worth it in
practice. It will make some lookups quicker, but in most cases you will
end up going to the roots anyway for a negative lookup (in your case it
was only faster because you got rid of all the old tags). A better
strategy is to prune based on commit date so we _never_ go to the roots,
even for a negative hit. That should give similar speedups as a
breadth-first search would to your case, but also make the normal case
much faster by quickly discarding nonsensical paths (e.g., there is not
much point following a commit made 3 years ago to see if it contains a
commit made yesterday).

Try the patch below, which adds a date cutoff similar to the one used in
name-rev. It's much faster in my tests:

  # stock "git tag --contains HEAD~200"
  real    0m2.179s
  user    0m2.156s
  sys     0m0.020s

  # my first patch
  real    0m0.621s
  user    0m0.588s
  sys     0m0.032s

  # this patch
  real    0m0.041s
  user    0m0.036s
  sys     0m0.004s

For non-pathological cases, I expect it to perform equal to stock git at
worst, and in practice much better (for pathological cases, its worst
case is equivalent to "git rev-list --all", which is still not that
bad). Let me know how it does on your case.

The obvious downside is that it stops looking down a path in the face of
extreme clock skew. We could perhaps allow a "--contains=thorough" to
spend a little more time to achieve a better answer (i.e., ignore the
cutoff date).

diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..5768a44 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -10,6 +10,8 @@
 #include "builtin.h"
 #include "refs.h"
 #include "tag.h"
+#include "diff.h"
+#include "revision.h"
 #include "run-command.h"
 #include "parse-options.h"
 
@@ -31,6 +33,61 @@ struct tag_filter {
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 
+static int in_commit_list(const struct commit_list *want, struct commit *c)
+{
+	for (; want; want = want->next)
+		if (!hashcmp(want->item->object.sha1, c->object.sha1))
+			return 1;
+	return 0;
+}
+
+static int contains_recurse(const struct commit_list *want,
+			    struct commit *candidate,
+			    unsigned long cutoff)
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
+	/* stop searching if we go too far back in time */
+	parse_commit(candidate);
+	if (candidate->date < cutoff)
+		return 0;
+
+	/* If not, then try parents, and be sure to mark ourselves
+	 * for future traversals. */
+	for (p = candidate->parents; p; p = p->next) {
+		if (contains_recurse(want, p->item, cutoff)) {
+			candidate->object.flags |= TMP_MARK;
+			return 1;
+		}
+	}
+
+	candidate->object.flags |= UNINTERESTING;
+	return 0;
+}
+
+static int contains(const struct commit_list *want, struct commit *candidate)
+{
+	const struct commit_list *c;
+	unsigned long min_date = ULONG_MAX;
+	for (c = want; c; c = c->next) {
+		parse_commit(c->item);
+		if (c->item->date < min_date)
+			min_date = c->item->date;
+	}
+	/* give a full day of clock skew slop */
+	return contains_recurse(want, candidate, min_date - 86400);
+}
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
@@ -49,7 +106,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			commit = lookup_commit_reference_gently(sha1, 1);
 			if (!commit)
 				return 0;
-			if (!is_descendant_of(commit, filter->with_commit))
+			if (!contains(filter->with_commit, commit))
 				return 0;
 		}
 
