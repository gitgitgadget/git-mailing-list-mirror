From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Fix in-index merge.
Date: Sat, 23 Aug 2008 12:41:23 +0200
Message-ID: <1219488083-4535-1-git-send-email-vmiklos@frugalware.org>
References: <7vd4k02jyr.fsf@gitster.siamese.dyndns.org>
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 12:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWqZO-0003pi-1x
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 12:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbYHWKkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 06:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbYHWKkx
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 06:40:53 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53256 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbYHWKkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 06:40:52 -0400
Received: from vmobile.example.net (dsl5401CFDD.pool.t-online.hu [84.1.207.221])
	by yugo.frugalware.org (Postfix) with ESMTP id 232691DDC5B;
	Sat, 23 Aug 2008 12:40:51 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 612F296FA; Sat, 23 Aug 2008 12:41:23 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <7vd4k02jyr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93456>

There were 3 issues:

1) We need read_cache() before using unpack_trees().

2) commit_tree() frees the parents, so we need to malloc them.

3) The current HEAD was missing from the parent list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Aug 23, 2008 at 01:50:52AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Please do not add new testfiles unnecessarily.  You already have test
> scripts that cover "git-merge".  Add new ones to them.  The same
> comment
> goes to the other patch.

Here it is.

 builtin-merge.c  |   11 +++++++----
 t/t7600-merge.sh |    9 +++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index a201c66..dffe4b8 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -469,6 +469,7 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 
+	read_cache();
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 2;
 	opts.src_index = &the_index;
@@ -651,13 +652,15 @@ static void add_strategies(const char *string, unsigned attr)
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
-- 
1.6.0.rc3.17.gc14c8.dirty
