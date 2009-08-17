From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] read-tree: Fix regression with creation of a new index file.
Date: Mon, 17 Aug 2009 17:35:44 +0200
Message-ID: <877hx25u7j.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 17:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4aF-0001Bz-ER
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370AbZHQP5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 11:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756362AbZHQP5I
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:57:08 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:49695 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbZHQP5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 11:57:07 -0400
X-Greylist: delayed 1272 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Aug 2009 11:57:07 EDT
Received: from adsl-84-227-19-204.adslplus.ch ([84.227.19.204] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Md4FP-0001oJ-9c; Mon, 17 Aug 2009 10:35:54 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 773981E7331; Mon, 17 Aug 2009 17:35:44 +0200 (CEST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126199>

Reading the index into an empty file has been broken by
5a56da58060e50980fab0f4c38203a25440d1530, since it causes the existing
index to always be loaded first, and dies if it's an empty file:

$ GIT_INDEX_FILE=`mktemp` git read-tree master
fatal: index file smaller than expected

It breaks for instance committing from git.el. This patch reverts to the
previous behavior of only loading the index when merging it.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 builtin-read-tree.c            |   10 ++++++----
 t/t1009-read-tree-new-index.sh |   25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100755 t/t1009-read-tree-new-index.sh

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..14c836b 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -113,13 +113,15 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	if (read_cache_unmerged() && (opts.prefix || opts.merge))
-		die("You need to resolve your current index first");
-
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
-	stage = opts.merge = (opts.reset || opts.merge || prefix_set);
+
+	if (opts.reset || opts.merge || opts.prefix) {
+		if (read_cache_unmerged() && (opts.prefix || opts.merge))
+			die("You need to resolve your current index first");
+		stage = opts.merge = 1;
+	}
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
new file mode 100755
index 0000000..59b3aa4
--- /dev/null
+++ b/t/t1009-read-tree-new-index.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description='test read-tree into a fresh index file'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo one >a &&
+	git add a &&
+	git commit -m initial
+'
+
+test_expect_success 'non-existent index file' '
+	rm -f new-index &&
+	GIT_INDEX_FILE=new-index git read-tree master
+'
+
+test_expect_success 'empty index file' '
+	rm -f new-index &&
+	> new-index &&
+	GIT_INDEX_FILE=new-index git read-tree master
+'
+
+test_done
+
-- 
1.6.4.181.g3f2ea.dirty

-- 
Alexandre Julliard
julliard@winehq.org
