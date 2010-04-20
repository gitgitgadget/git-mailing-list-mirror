From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revision: --ancestry-path
Date: Tue, 20 Apr 2010 15:10:49 -0700
Message-ID: <7v39ypg4gm.fsf_-_@alter.siamese.dyndns.org>
References: <201004201649.31084.johan@herland.net>
 <7viq7lg8f2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 00:11:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Lew-0006HJ-Bv
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 00:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab0DTWLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 18:11:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0DTWLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 18:11:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73E03ACD98;
	Tue, 20 Apr 2010 18:10:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f0U2X9tbJD2fNO4zCFHyX2ZexyE=; b=F+0r1Z
	l6yttR6ucL8LRmNn0cyNc62zO92HyQUl5O5fttLPITXLt9ePXVxgjed0ZabLHcyI
	Zsfbxzpi/giaUBPpiwb5QMIzRAVBUVKMgd0aoQr8/znaLQD34gDIjjm56q29YPHi
	xE9OO6GTuHEl8vnwRCnHolFpEA7jH1aBWQOL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FFvMV5pKZQ5NHXkBISIVz+0yWer9wDut
	V1P0zJqTQYsjqAXBSFSSNQg1Qkw1gSPDUfOEB+7gNTftxJcLUCQSNB8CL0wokaAD
	Vy6YiPXGGC7dN2nrqGHRQHXWNmoLp8XgHuDYeyvlH3oNfyzXpS0xz5SBrwCCpzCA
	yi9uftlpaUU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 421DBACD97;
	Tue, 20 Apr 2010 18:10:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09150ACD96; Tue, 20 Apr
 2010 18:10:50 -0400 (EDT)
In-Reply-To: <7viq7lg8f2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 20 Apr 2010 13\:45\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 972613BA-4CC9-11DF-9E14-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145401>

This is somewhat a rough-cut, as I haven't thought through possible
interactions this new option may have with "rev-list --parents" and
"rev-list --graph" (see "NEEDSWORK" in revision.c), but I'll leave that to
people who are more interested in this topic than myself ;-).

-- >8 --
"rev-list A..H" computes the set of commits that are ancestors of H, but
excludes the ones that are ancestors of A.  This is useful to see what
happened to the history leading to H since A, in the sense that "what does
H have that did not exist in A" (e.g. when you have a choice to update to
H from A).

	       x---x---A---B---C  <-- topic
	      /			\
     x---x---x---o---o---o---o---M---D---E---F---G  <-- dev
    /						  \
   x---o---o---o---o---o---o---o---o---o---o---o---N---H  <-- master

The result in the above example would be the commits marked with caps
letters (except for A itself, of course), and the ones marked with 'o'.

When you want to find out what commits in H are contaminated with the bug
introduced by A and need fixing, however, you might want to view only the
subset of "A..B" that are actually descendants of A, i.e. excluding the
ones marked with 'o'.  Introduce a new option --ancestry-path to compute
this set with "rev-list --ancestry-path A..B".

Note that in practice, you would build a fix immediately on top of A and
"git branch --contains A" will give the names of branches that you would
need to merge the fix into (i.e. topic, dev and master), so this may not
be worth paying the extra cost of postprocessing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c                        |  106 +++++++++++++++++++++++++++++++++++++
 revision.h                        |    1 +
 t/t6019-rev-list-ancestry-path.sh |   56 +++++++++++++++++++
 3 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100755 t/t6019-rev-list-ancestry-path.sh

diff --git a/revision.c b/revision.c
index f4b8b38..cb91094 100644
--- a/revision.c
+++ b/revision.c
@@ -646,6 +646,99 @@ static int still_interesting(struct commit_list *src, unsigned long date, int sl
 	return slop-1;
 }
 
+/*
+ * "rev-list --ancestry-path A..B" computes commits that are ancestors
+ * of B but not ancestors of A but further limits the result to those
+ * that are descendants of A.  This takes the list of bottom commits and
+ * the result of "A..B" without --ancestry-path, and limits the latter
+ * further to the ones that can reach one of the commits in "bottom".
+ */
+static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *list)
+{
+	struct commit_list *p;
+	struct commit_list *rlist = NULL;
+	int made_progress;
+
+	/*
+	 * Clear TMP_MARK and reverse the list so that it will be likely
+	 * that we would process parents before children.
+	 */
+	for (p = list; p; p = p->next) {
+		p->item->object.flags &= ~TMP_MARK;
+		commit_list_insert(p->item, &rlist);
+	}
+
+	for (p = bottom; p; p = p->next)
+		p->item->object.flags |= TMP_MARK;
+
+	/*
+	 * Mark the ones that can reach bottom commits in "list",
+	 * in a bottom-up fashion.
+	 */
+	do {
+		made_progress = 0;
+		for (p = rlist; p; p = p->next) {
+			struct commit *c = p->item;
+			struct commit_list *parents;
+			if (c->object.flags & (TMP_MARK | UNINTERESTING))
+				continue;
+			for (parents = c->parents;
+			     parents;
+			     parents = parents->next) {
+				if (!(parents->item->object.flags & TMP_MARK))
+					continue;
+				c->object.flags |= TMP_MARK;
+				made_progress = 1;
+				break;
+			}
+		}
+	} while (made_progress);
+
+	/*
+	 * NEEDSWORK: decide if we want to remove parents that are
+	 * not marked with TMP_MARK from commit->parents for commits
+	 * in the resulting list.  We may not want to do that, though.
+	 */
+
+	/*
+	 * The ones that are not marked with TMP_MARK are uninteresting
+	 */
+	for (p = list; p; p = p->next) {
+		struct commit *c = p->item;
+		if (c->object.flags & TMP_MARK) {
+			c->object.flags &= ~TMP_MARK;
+			continue;
+		}
+		c->object.flags |= UNINTERESTING;
+	}
+
+	/* Release the bottom list */
+	while (bottom) {
+		p = bottom->next;
+		bottom->item->object.flags &= ~TMP_MARK;
+		free(bottom);
+		bottom = p;
+	}
+	free_commit_list(rlist);
+}
+
+/*
+ * Before walking the history, keep the set of "negative" refs the
+ * caller has asked to exclude.
+ *
+ * This is used to compute "rev-list --ancestry-path A..B", as we need
+ * to filter the result of "A..B" further to the ones that can actually
+ * reach A.
+ */
+static struct commit_list *collect_bottom_commits(struct commit_list *list)
+{
+	struct commit_list *elem, *bottom = NULL;
+	for (elem = list; elem; elem = elem->next)
+		if (elem->item->object.flags & UNINTERESTING)
+			commit_list_insert(elem->item, &bottom);
+	return bottom;
+}
+
 static int limit_list(struct rev_info *revs)
 {
 	int slop = SLOP;
@@ -653,6 +746,13 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
+	struct commit_list *bottom = NULL;
+
+	if (revs->ancestry_path) {
+		bottom = collect_bottom_commits(list);
+		if (!bottom)
+			die("--ancestry-path given but there is no bottom commits");
+	}
 
 	while (list) {
 		struct commit_list *entry = list;
@@ -694,6 +794,9 @@ static int limit_list(struct rev_info *revs)
 	if (revs->cherry_pick)
 		cherry_pick_list(newlist, revs);
 
+	if (bottom)
+		limit_to_ancestry(bottom, newlist);
+
 	revs->commits = newlist;
 	return 0;
 }
@@ -1089,6 +1192,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->min_age = approxidate(arg + 8);
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;
+	} else if (!strcmp(arg, "--ancestry-path")) {
+		revs->ancestry_path = 1;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
 		init_reflog_walk(&revs->reflog_info);
 	} else if (!strcmp(arg, "--default")) {
diff --git a/revision.h b/revision.h
index 568f1c9..855464f 100644
--- a/revision.h
+++ b/revision.h
@@ -66,6 +66,7 @@ struct rev_info {
 			reverse_output_stage:1,
 			cherry_pick:1,
 			bisect:1,
+			ancestry_path:1,
 			first_parent_only:1;
 
 	/* Diff flags */
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
new file mode 100755
index 0000000..0230724
--- /dev/null
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='--ancestry-path'
+
+#          D---E-------F
+#         /     \       \
+#    B---C---G---H---I---J
+#   /                     \
+#  A-------K---------------L--M
+#
+#  D..M                 == E F G H I J K L M
+#  --ancestry-path D..M == E F H I J L M
+
+. ./test-lib.sh
+
+test_merge () {
+	test_tick &&
+	git merge -s ours -m "$2" "$1" &&
+	git tag "$2"
+}
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	test_commit D &&
+	test_commit E &&
+	test_commit F &&
+	git reset --hard C &&
+	test_commit G &&
+	test_merge E H &&
+	test_commit I &&
+	test_merge F J &&
+	git reset --hard A &&
+	test_commit K &&
+	test_merge J L &&
+	test_commit M
+'
+
+test_expect_success 'rev-list D..M' '
+	for c in E F G H I J K L M; do echo $c; done >expect &&
+	git rev-list --format=%s D..M |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --ancestry-path D..M' '
+	for c in E F H I J L M; do echo $c; done >expect &&
+	git rev-list --ancestry-path --format=%s D..M |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.1.rc2.265.g8743f
