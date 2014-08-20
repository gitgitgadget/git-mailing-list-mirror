From: Jeff King <peff@peff.net>
Subject: [PATCH] intersect_paths: respect mode in git's tree-sort
Date: Tue, 19 Aug 2014 22:14:30 -0400
Message-ID: <20140820021428.GA22266@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:14:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJvQ5-0002Zc-AG
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 04:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbaHTCOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 22:14:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:55264 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751733AbaHTCOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 22:14:33 -0400
Received: (qmail 11953 invoked by uid 102); 20 Aug 2014 02:14:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 21:14:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 22:14:30 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255546>

When we do a combined diff, we individually diff against
each parent, and then use intersect_paths to do a parallel
walk through the sorted results and come up with a final
list of interesting paths.

The sort order here is that returned by the diffs, which
means it is in git's tree-order which sorts sub-trees as if
their paths have "/" at the end. When we do our parallel
walk, we need to use a comparison function which provides
the same order.

Since 8518ff8 (combine-diff: optimize combine_diff_path sets
intersection, 2014-01-20), we use a simple strcmp to
compare the pathnames, and get this wrong. It's somewhat
hard to trigger because normally a diff does not produce
tree entries at all, and therefore the sort order is the
same as a strcmp. However, if the "-t" option is used with
the diff, then we will produce diff_filepairs for both trees
and files.

We can use base_name_compare to do the comparison, just as
the tree-diff code does. Even though what we have are not
technically base names (they are full paths within the
tree), the end result is the same (we do not care about
interior slashes at all, only about the final character).

However, since we do not have the length of each path
stored, we take a slight shortcut: if neither of the entries
is a sub-tree then the comparison is equivalent to a strcmp.
This lets us skip the extra strlen calls in the common case
without having to reimplement base_name_compare from
scratch.

Signed-off-by: Jeff King <peff@peff.net>
---
This regression is in v2.0.0 and up. I suspect most people didn't notice
because "-t" isn't that common an option (and it only kicks in if you
have files like "foo-ext" or "foo.ext" next to a directory "foo"). At
GitHub we do a lot of diffs like this to generate the default tree
views.

You can see more real-world cases by running "git log --merges -c -t
--raw" on git.git. The results from v2.0.0 (and the current "master")
disagree with those from v1.9.4. With my patch, we match v1.9.4 again.

 combine-diff.c           | 12 +++++++++++-
 t/t4038-diff-combined.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index fd6d63c..6d62973 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -12,6 +12,16 @@
 #include "sha1-array.h"
 #include "revision.h"
 
+static int compare_paths(const struct combine_diff_path *one,
+			  const struct diff_filespec *two)
+{
+	if (!S_ISDIR(one->mode) && !S_ISDIR(two->mode))
+		return strcmp(one->path, two->path);
+
+	return base_name_compare(one->path, strlen(one->path), one->mode,
+				 two->path, strlen(two->path), two->mode);
+}
+
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -52,7 +62,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 	i = 0;
 	while ((p = *tail) != NULL) {
 		cmp = ((i >= q->nr)
-		       ? -1 : strcmp(p->path, q->queue[i]->two->path));
+		       ? -1 : compare_paths(p, q->queue[i]->two));
 
 		if (cmp < 0) {
 			/* p->path not in q->queue[]; drop it */
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 1019d7b..71a664d 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -401,4 +401,38 @@ test_expect_success 'combine diff missing delete bug' '
 	compare_diff_patch expected actual
 '
 
+test_expect_success 'combine diff gets tree sorting right' '
+	# create a directory and a file that sort differently in trees
+	# versus byte-wise (implied "/" sorts ".")
+	git checkout -f master &&
+	mkdir foo &&
+	echo base >foo/one &&
+	echo base >foo/two &&
+	echo base >foo.ext &&
+	git add foo foo.ext &&
+	git commit -m base &&
+
+	# one side modifies a file in the directory, along with the root
+	# file...
+	echo master >foo/one &&
+	echo master >foo.ext &&
+	git commit -a -m master &&
+
+	# the other side modifies the other file in the directory
+	git checkout -b other HEAD^ &&
+	echo other >foo/two &&
+	git commit -a -m other &&
+
+	# And now we merge. The files in the subdirectory will resolve cleanly,
+	# meaning that a combined diff will not find them interesting. But it
+	# will find the tree itself interesting, because it had to be merged.
+	git checkout master &&
+	git merge other &&
+
+	printf "MM\tfoo\n" >expect &&
+	git diff-tree -c --name-status -t HEAD >actual.tmp &&
+	sed 1d <actual.tmp >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.0.346.ga0367b9
