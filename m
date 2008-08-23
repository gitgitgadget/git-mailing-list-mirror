From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Fix in-index merge.
Date: Sat, 23 Aug 2008 10:14:53 +0200
Message-ID: <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
References: <20080823060839.GB23800@genesis.frugalware.org>
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 10:15:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoHT-0000R7-7P
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbYHWIO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYHWIO0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:14:26 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55035 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYHWIOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:14:23 -0400
Received: from vmobile.example.net (dsl5401CFDD.pool.t-online.hu [84.1.207.221])
	by yugo.frugalware.org (Postfix) with ESMTP id C25121DDC5B;
	Sat, 23 Aug 2008 10:14:20 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AE5DB96FA; Sat, 23 Aug 2008 10:14:53 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <20080823060839.GB23800@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93430>

There were 3 issues:

1) We need read_cache() before using unpack_trees().

2) commit_tree() frees the parents, so we need to malloc them.

3) The current HEAD was missing from the parent list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Aug 22, 2008 at 08:36:39AM +0200, Paolo Bonzini <bonzini@gnu.org> wrote:
> I had already posted this bug report yesterday but it was hidden in a
> cover
> letter at
> http://permalink.gmane.org/gmane.comp.version-control.git/93143

This should fix the issue.

 builtin-merge.c          |   11 +++++++----
 t/t7607-merge-inindex.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)
 create mode 100755 t/t7607-merge-inindex.sh

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
diff --git a/t/t7607-merge-inindex.sh b/t/t7607-merge-inindex.sh
new file mode 100755
index 0000000..98b778f
--- /dev/null
+++ b/t/t7607-merge-inindex.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing in-index merge.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a > a &&
+	git add a &&
+	git commit -m a &&
+	git tag a &&
+	git checkout -b branch
+	echo b > b &&
+	git add b &&
+	git commit -m b &&
+	git tag b
+'
+
+test_expect_success 'in-index merge' '
+	git checkout master &&
+	git merge --no-ff -s resolve branch > out &&
+	grep Wonderful. out &&
+	test "$(git rev-parse a)" = "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse b)" = "$(git rev-parse HEAD^2)"
+'
+
+test_done
-- 
1.6.0.rc3.17.gc14c8.dirty
