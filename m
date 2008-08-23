From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: fail properly when we are in the middle of a conflicted merge
Date: Sat, 23 Aug 2008 12:57:51 +0200
Message-ID: <1219489071-5679-1-git-send-email-vmiklos@frugalware.org>
References: <7v3akw2jgo.fsf@gitster.siamese.dyndns.org>
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 12:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWqp7-0000KA-5F
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 12:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbYHWK5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 06:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYHWK5V
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 06:57:21 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60907 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYHWK5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 06:57:20 -0400
Received: from vmobile.example.net (dsl5401CFDD.pool.t-online.hu [84.1.207.221])
	by yugo.frugalware.org (Postfix) with ESMTP id CF1C01DDC5B;
	Sat, 23 Aug 2008 12:57:18 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C7DFC96FA; Sat, 23 Aug 2008 12:57:51 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <7v3akw2jgo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93459>

Using unmerged_cache() without reading the cache first never will return
anything. However, if we read the cache early then we have to discard it
when we want to read it again from the disk.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Aug 23, 2008 at 02:01:43AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> With this, I do not think you would need to keep the read_cache() you
> added to the beginning of the read_tree_trivial(), for the same reason
> you
> are removing read_cache_unmerged() from the beginning of
> checkout_fast_forward() in this patch.

Right, I removed it as well. Also fixed the testcase (no more new file).

 builtin-merge.c            |    7 +++----
 t/t3030-merge-recursive.sh |   11 +++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index dffe4b8..b280444 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -469,7 +469,6 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 
-	read_cache();
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 2;
 	opts.src_index = &the_index;
@@ -565,8 +564,6 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 	struct dir_struct dir;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	if (read_cache_unmerged())
-		die("you need to resolve your current index first");
 	refresh_cache(REFRESH_QUIET);
 
 	fd = hold_locked_index(lock_file, 1);
@@ -746,6 +743,7 @@ static int evaluate_result(void)
 	int cnt = 0;
 	struct rev_info rev;
 
+	discard_cache();
 	if (read_cache() < 0)
 		die("failed to read the cache");
 
@@ -779,7 +777,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list **remotes = &remoteheads;
 
 	setup_work_tree();
-	if (unmerged_cache())
+	if (read_cache_unmerged())
 		die("You are in the middle of a conflicted merge.");
 
 	/*
@@ -1076,6 +1074,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
-- 
1.6.0.rc3.17.gc14c8.dirty
