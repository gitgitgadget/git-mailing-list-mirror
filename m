From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] test-generation: compute generation numbers and clock skews
Date: Tue, 04 Sep 2012 02:50:26 -0700
Message-ID: <7vtxvece1p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 11:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8pmH-00021D-UI
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 11:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab2IDJub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 05:50:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756641Ab2IDJu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 05:50:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1CD6A04;
	Tue,  4 Sep 2012 05:50:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	swPyW67wg8wGbBFVqiTey0OWQI=; b=CQyrQmPfZu1Zr0eGG0bBxx/sThI8VbmxZ
	3zcJMhmj2CRP860DDeq8ERMib6/FDj29hPOhnxSp7YLG6+8MV5PFDRc0Mrg2yfZI
	ZGLabyu6ClpxJNHKynPr6ZRc0E+h4ult3kSUink0T0i+ZbgkUrgkK32BIU3mLxvS
	ErsOiC7/8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=pYp
	tE5KWcA9GeAfcQwDYe0D9IGTp9H6HxbKny+IsAcEnQE5SLwKZBaWLU81JkCzfQTN
	rdtcfmdJWumoDmWjct1AezT9PaBlKUddSpCIBxj/CvLGxI6Nhtq1hYE2tNX2/eSq
	xF8CZMLGjlBH3grDcAueN/Jig7d8naQP92JDEUoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB0E6A03;
	Tue,  4 Sep 2012 05:50:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC8B06A01; Tue,  4 Sep 2012
 05:50:27 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4FEA3BE-F675-11E1-9C32-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204731>

It finds three commits that has older commit timestamp than the
newest commit timestamp among its ancestor in our history; all of
these are a direct child of a commit that is older (i.e. the clock
skew lasts for only one hop).

  commit  gen  timestamp                 skew gen ancestor
  ed19f36 2870 2006-03-04 07:29:56 +0000 (8) 2869 91a6bf4
  7763987 6404 2007-09-02 06:53:47 +0000 (373) 6403 86bab96
  619a644 9982 2009-10-18 19:34:56 +0000 (268948) 9981 46148dd

On the other hand, the kernel history is littered with skewed
chains.  I counted 2239 commits that have an ancestor newer than
themselves in total (they tend to cluster, but I haven't counted
clusters), among 322345 commits (0.7%).

For example, a 33-commit chain leading to b4e1b7e builds on top of
422e6c4 that was commited by Linus at Tue Mar 15 15:48:13 2011, but
the tip commit claims to have been committed at Sun Feb 20 19:19:43
2011, which is clearly impossible.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Take the usefulness and correctness of this patch with a large
   grain of salt, as it was done primarily because I couldn't sleep
   X-<.

   The motivation behind this toy is to help analyzing the real
   world history and come up with a way to improve the robustness of
   history traversal, which depends on the SLOP heuristics, without
   having to give each and every commit object an extra generation
   number (worse yet, after the fact).  We could instead mark only
   these 2200+ commits, and teach still_interesting() function not
   to rely on SLOP, but answer yes while one of these commits marked
   as "unreliable/skewed" are still on the list.  When we no longer
   have these skewed commits (whose definition is "its timestamp is
   older than one of its ancestor's timestamp), we know that the
   time-based priority queue has popped all the ancestors that
   possibly can matter, and stop the traversal with confidence.

 Makefile          |   1 +
 test-generation.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 test-generation.c

diff --git a/Makefile b/Makefile
index 66e8216..52f62b7 100644
--- a/Makefile
+++ b/Makefile
@@ -489,6 +489,7 @@ TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-generation
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
diff --git a/test-generation.c b/test-generation.c
new file mode 100644
index 0000000..4df5a0d
--- /dev/null
+++ b/test-generation.c
@@ -0,0 +1,105 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+
+struct gdata {
+	int generation;
+	struct commit *youngest_ancestor;
+};
+
+static struct gdata *util_gd(struct commit *commit)
+{
+	return commit->util;
+}
+
+static void show_commit(struct commit *commit, struct gdata *gd)
+{
+	printf("%s %d",
+	       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+	       gd->generation);
+	if (gd->youngest_ancestor != commit) {
+		struct commit *ancestor = gd->youngest_ancestor;
+		const char *abbrev;
+
+		abbrev = find_unique_abbrev(ancestor->object.sha1,
+					    DEFAULT_ABBREV);
+		printf(" %s ", show_date(commit->date, 0, DATE_ISO8601));
+		printf("(%lu) ", ancestor->date - commit->date);
+		printf("%d", util_gd(ancestor)->generation);
+		printf(" %s", abbrev);
+	}
+	putchar('\n');
+}
+
+int main(int ac, const char **av)
+{
+	struct rev_info revs;
+	struct setup_revision_opt opt;
+	struct commit_list *list;
+	struct commit_list *stuck = NULL;
+
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	init_revisions(&revs, NULL);
+	setup_revisions(ac, av, &revs, &opt);
+	prepare_revision_walk(&revs);
+
+	list = revs.commits;
+	while (list || stuck) {
+		struct commit_list *parent, *next;
+		struct commit *commit;
+		struct gdata *gd;
+		int ready = 1;
+		int parent_generation;
+		struct commit *youngest_ancestor;
+
+		if (!list) {
+			list = stuck;
+			stuck = NULL;
+		}
+		commit = list->item;
+		youngest_ancestor = commit;
+		parent_generation = 0;
+		parse_commit(commit);
+		if (!commit->util)
+			commit->util = xcalloc(1, sizeof(*gd));
+		gd = commit->util;
+		if (gd->generation) {
+			/* we have handled this already */
+			next = list->next;
+			free(list);
+			list = next;
+			continue;
+		}
+
+		for (parent = commit->parents; parent; parent = parent->next) {
+			struct commit *p = parent->item;
+			struct gdata *pgd = p->util;
+
+			/* queue to the front */
+			commit_list_insert(p, &list);
+			if (!pgd || !pgd->generation) {
+				ready = 0;
+				continue;
+			}
+			if (parent_generation < pgd->generation)
+				parent_generation = pgd->generation;
+			if (youngest_ancestor->date < pgd->youngest_ancestor->date)
+				youngest_ancestor = pgd->youngest_ancestor;
+		}
+		if (!ready) {
+			commit_list_insert(commit, &stuck);
+			continue;
+		}
+		gd->generation = parent_generation + 1;
+		gd->youngest_ancestor = youngest_ancestor;
+
+		next = list->next;
+		free(list);
+		list = next;
+
+		show_commit(commit, gd);
+	}
+}
-- 
1.7.12.321.g60f00e5
