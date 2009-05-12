From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Revert "checkout branch: prime cache-tree fully"
Date: Tue, 12 May 2009 09:56:56 -0700
Message-ID: <7v4ovq8dk7.fsf@alter.siamese.dyndns.org>
References: <d96d20670905120901qa4c0353xc50160f880e17a21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter MacMillan <peterm@metavera.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vHy-0000TC-R5
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbZELQ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbZELQ45
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:56:57 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34634 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbZELQ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:56:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512165655.VASQ25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 May 2009 12:56:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id qgww1b00V4aMwMQ03gwwb1; Tue, 12 May 2009 12:56:57 -0400
X-Authority-Analysis: v=1.0 c=1 a=BTifD3LgNaoA:10 a=NuvZuKHEjYgA:10
 a=ybZZDoGAAAAA:8 a=NZV4qimDwNJxkN53mboA:9 a=hkA891llqua9d5s89EsA:7
 a=ZOZ051uBRp9GhL9NIMWEpsaUMJ4A:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <d96d20670905120901qa4c0353xc50160f880e17a21@mail.gmail.com> (Peter MacMillan's message of "Tue\, 12 May 2009 12\:01\:14 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118927>

The logic in 83ae209 (checkout branch: prime cache-tree fully,
2009-04-20) is bogus; checkout can switch branches with a dirty
index and in such a case the tree won't match HEAD.

Add t2014-switch to catch this breakage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    9 +--------
 t/t2014-switch.sh  |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 8 deletions(-)
 create mode 100755 t/t2014-switch.sh

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 15f0c32..dc4bfb5 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -365,17 +365,14 @@ static int merge_working_tree(struct checkout_opts *opts,
 	int ret;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 	int newfd = hold_locked_index(lock_file, 1);
-	int reprime_cache_tree = 0;
 
 	if (read_cache() < 0)
 		return error("corrupt index file");
 
-	cache_tree_free(&active_cache_tree);
 	if (opts->force) {
 		ret = reset_tree(new->commit->tree, opts, 1);
 		if (ret)
 			return ret;
-		reprime_cache_tree = 1;
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -411,9 +408,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
-		if (ret != -1) {
-			reprime_cache_tree = 1;
-		} else {
+		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
 			 * give up or do a real merge, depending on
@@ -457,8 +452,6 @@ static int merge_working_tree(struct checkout_opts *opts,
 		}
 	}
 
-	if (reprime_cache_tree)
-		prime_cache_tree(&active_cache_tree, new->commit->tree);
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
 		die("unable to write new index file");
diff --git a/t/t2014-switch.sh b/t/t2014-switch.sh
new file mode 100755
index 0000000..ccfb147
--- /dev/null
+++ b/t/t2014-switch.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='Peter MacMillan'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo Hello >file &&
+	git add file &&
+	test_tick &&
+	git commit -m V1 &&
+	echo Hello world >file &&
+	git add file &&
+	git checkout -b other
+'
+
+test_expect_success 'check all changes are staged' '
+	git diff --exit-code
+'
+
+test_expect_success 'second commit' '
+	git commit -m V2
+'
+
+test_expect_success 'check' '
+	git diff --cached --exit-code
+'
+
+test_done
-- 
1.6.3.9.g6345d
