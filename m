From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] merge: fix numerus bugs around "trivial merge" area
Date: Sat, 23 Aug 2008 12:56:57 -0700
Message-ID: <7vfxovy06u.fsf_-_@gitster.siamese.dyndns.org>
References: <7v3akw2jgo.fsf@gitster.siamese.dyndns.org>
 <1219489071-5679-1-git-send-email-vmiklos@frugalware.org>
 <7vk5e7y0a0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 21:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWzG9-0007cO-SZ
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbYHWT5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758159AbYHWT5J
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:57:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810AbYHWT5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:57:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E4D186AA8A;
	Sat, 23 Aug 2008 15:57:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A1A966AA89; Sat, 23 Aug 2008 15:57:01 -0400 (EDT)
In-Reply-To: <7vk5e7y0a0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 23 Aug 2008 12:55:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9FB463A-714D-11DD-8EF8-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93483>

The "trivial merge" codepath wanted to optimize itself by making an
internal call to the read-tree machinery, but it did not read the index
before doing so, and the codepath was never exercised.  Incidentally, this
failure to read the index upfront meant that the safety to refuse doing
anything when the index is unmerged did not kick in, either.

These two problem are fixed by using read_cache_unmerged() that does read
the index before checking if it is unmerged at the beginning of
cmd_merge().

The primary logic of the merge, however, had an assumption that the
process never read the index in-core, and write_cache_as_tree() call it
makes from write_tree_trivial() will always read from the on-disk index
the strategies created and write it out as a tree.  This assumption is now
broken by the above fix.  It now calls discard_cache() before calling
write_tree_trivial() when it wants to write the on-disk index as a tree to
fix this issue.

When multiple strategies are tried, their results are evaluated by reading
the resulting index and inspecting it.  The codepath needs to make a call
to read_cache() for each successful strategy, and for that to work, they
need to discard_cache() the one from the previous round.

Also the "trivial merge" forgot that the current commit is one of the
parents of the resulting commit.

This still has breakage in the way it writes out the resulting tree out of
the trivial merge codepath, which is a topic of the next patch.  One test
in t7605-merge-resolve.sh exposes this breakage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c            |   16 +++++++++-------
 t/t3030-merge-recursive.sh |   11 +++++++++++
 t/t7600-merge.sh           |    9 +++++++++
 t/t7605-merge-resolve.sh   |    6 ++++--
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index a201c66..b280444 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -564,8 +564,6 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 	struct dir_struct dir;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	if (read_cache_unmerged())
-		die("you need to resolve your current index first");
 	refresh_cache(REFRESH_QUIET);
 
 	fd = hold_locked_index(lock_file, 1);
@@ -651,13 +649,15 @@ static void add_strategies(const char *string, unsigned attr)
 static int merge_trivial(void)
 {
 	unsigned char result_tree[20], result_commit[20];
-	struct commit_list parent;
+	struct commit_list *parent = xmalloc(sizeof(struct commit_list *));
 
 	write_tree_trivial(result_tree);
 	printf("Wonderful.\n");
-	parent.item = remoteheads->item;
-	parent.next = NULL;
-	commit_tree(merge_msg.buf, result_tree, &parent, result_commit);
+	parent->item = lookup_commit(head);
+	parent->next = xmalloc(sizeof(struct commit_list *));
+	parent->next->item = remoteheads->item;
+	parent->next->next = NULL;
+	commit_tree(merge_msg.buf, result_tree, parent, result_commit);
 	finish(result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -743,6 +743,7 @@ static int evaluate_result(void)
 	int cnt = 0;
 	struct rev_info rev;
 
+	discard_cache();
 	if (read_cache() < 0)
 		die("failed to read the cache");
 
@@ -776,7 +777,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list **remotes = &remoteheads;
 
 	setup_work_tree();
-	if (unmerged_cache())
+	if (read_cache_unmerged())
 		die("You are in the middle of a conflicted merge.");
 
 	/*
@@ -1073,6 +1074,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		/* Automerge succeeded. */
+		discard_cache();
 		write_tree_trivial(result_tree);
 		automerge_was_ok = 1;
 		break;
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index aff3603..f288015 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -269,6 +269,17 @@ test_expect_success 'merge-recursive result' '
 
 '
 
+test_expect_success 'fail if the index has unresolved entries' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c1" &&
+
+	test_must_fail git merge "$c5" &&
+	test_must_fail git merge "$c5" 2> out &&
+	grep "You are in the middle of a conflicted merge" out
+
+'
+
 test_expect_success 'merge-recursive remove conflict' '
 
 	rm -fr [abcd] &&
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index fee8fb7..dbc90bc 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -498,4 +498,13 @@ test_expect_success 'merge fast-forward in a dirty tree' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'in-index merge' '
+	git reset --hard c0 &&
+	git merge --no-ff -s resolve c1 > out &&
+	grep "Wonderful." out &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index ee21a10..5c53608 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
-test_expect_success 'merge c1 to c2' '
+test_expect_failure 'merge c1 to c2' '
 	git reset --hard c1 &&
 	git merge -s resolve c2 &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
@@ -36,7 +36,9 @@ test_expect_success 'merge c1 to c2' '
 	git diff --exit-code &&
 	test -f c0.c &&
 	test -f c1.c &&
-	test -f c2.c
+	test -f c2.c &&
+	test 3 = $(git ls-tree -r HEAD | wc -l) &&
+	test 3 = $(git ls-files | wc -l)
 '
 
 test_expect_success 'merge c2 to c3 (fails)' '
-- 
1.6.0.51.g078ae
