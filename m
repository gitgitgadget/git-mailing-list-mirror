From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: fail properly when we are in the middle of a conflicted merge
Date: Sat, 23 Aug 2008 10:17:02 +0200
Message-ID: <1219479422-29148-1-git-send-email-vmiklos@frugalware.org>
References: <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 10:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoJW-0000ux-Rc
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbYHWIQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYHWIQe
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:16:34 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55041 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYHWIQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:16:31 -0400
Received: from vmobile.example.net (dsl5401CFDD.pool.t-online.hu [84.1.207.221])
	by yugo.frugalware.org (Postfix) with ESMTP id 11CDA1DDC5B;
	Sat, 23 Aug 2008 10:16:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8D76C96FA; Sat, 23 Aug 2008 10:17:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93432>

Using unmerged_cache() without reading the cache first never will return
anything. However, if we read the cache early then we have to discard it
when we want to read it again from the disk.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

The code part is pretty much from you, I wanted to add your signoff, but
then realized that you'll do it anyway. ;-)

 builtin-merge.c        |    6 +++---
 t/t7608-merge-dirty.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)
 create mode 100755 t/t7608-merge-dirty.sh

diff --git a/builtin-merge.c b/builtin-merge.c
index dffe4b8..71bd13b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -565,8 +565,6 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 	struct dir_struct dir;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	if (read_cache_unmerged())
-		die("you need to resolve your current index first");
 	refresh_cache(REFRESH_QUIET);
 
 	fd = hold_locked_index(lock_file, 1);
@@ -746,6 +744,7 @@ static int evaluate_result(void)
 	int cnt = 0;
 	struct rev_info rev;
 
+	discard_cache();
 	if (read_cache() < 0)
 		die("failed to read the cache");
 
@@ -779,7 +778,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list **remotes = &remoteheads;
 
 	setup_work_tree();
-	if (unmerged_cache())
+	if (read_cache_unmerged())
 		die("You are in the middle of a conflicted merge.");
 
 	/*
@@ -1076,6 +1075,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		/* Automerge succeeded. */
+		discard_cache();
 		write_tree_trivial(result_tree);
 		automerge_was_ok = 1;
 		break;
diff --git a/t/t7608-merge-dirty.sh b/t/t7608-merge-dirty.sh
new file mode 100755
index 0000000..fb567f6
--- /dev/null
+++ b/t/t7608-merge-dirty.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Merge should fail if the index has unresolved entries.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a > a &&
+	git add a &&
+	git commit -m a &&
+	git tag a &&
+	git checkout -b branch1
+	echo b > a &&
+	git add a &&
+	git commit -m b &&
+	git tag b
+	git checkout -b branch2 HEAD~1
+	echo c > a &&
+	git add a &&
+	git commit -m c &&
+	git tag c
+'
+
+test_expect_success 'in-index merge' '
+	git checkout branch1 &&
+	test_must_fail git merge branch2 &&
+	test_must_fail git merge branch2 2> out &&
+	grep "You are in the middle of a conflicted merge" out
+'
+
+test_done
-- 
1.6.0.rc3.17.gc14c8.dirty
