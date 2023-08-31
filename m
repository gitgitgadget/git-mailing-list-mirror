Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93872C83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbjHaGWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjHaGWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:22:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD3410C4
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:21:41 -0700 (PDT)
Received: (qmail 21160 invoked by uid 109); 31 Aug 2023 06:21:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:21:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3012 invoked by uid 111); 31 Aug 2023 06:21:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:21:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:21:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/10] traverse_trees(): respect max_allowed_tree_depth
Message-ID: <20230831062140.GF3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree-walk.c code walks trees recursively, and may run out of stack
space. The easiest way to see this is with git-archive; on my 64-bit
Linux system it runs out of stack trying to generate a tarfile with a
tree depth of 13,772.

I've picked 4100 as the depth for our "big" test. I ran it with a much
higher value to confirm that we do get a segfault without this patch.
But really anything over 4096 is sufficient for its stated purpose,
which is to find out if our default limit of 4096 is low enough to
prevent segfaults on all platforms. Keeping it small saves us time on
the test setup.

The tree-walk code that's touched here underlies unpack_trees(), so this
protects any programs which use it, not just git-archive (but archive is
easy to test, and was what alerted me to this issue in a real-world
case).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6700-tree-depth.sh | 66 +++++++++++++++++++++++++++++++++++++++++++
 tree-walk.c           |  4 +++
 2 files changed, 70 insertions(+)
 create mode 100755 t/t6700-tree-depth.sh

diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
new file mode 100755
index 0000000000..d4d17db2ae
--- /dev/null
+++ b/t/t6700-tree-depth.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='handling of deep trees in various commands'
+. ./test-lib.sh
+
+# We'll test against two depths here: a small one that will let us check the
+# behavior of the config setting easily, and a large one that should be
+# forbidden by default. Testing the default depth will let us know whether our
+# default is enough to prevent segfaults on systems that run the tests.
+small_depth=50
+big_depth=4100
+
+small_ok="-c core.maxtreedepth=$small_depth"
+small_no="-c core.maxtreedepth=$((small_depth-1))"
+
+# usage: mkdeep <name> <depth>
+#   Create a tag <name> containing a file whose path has depth <depth>.
+#
+# We'll use fast-import here for two reasons:
+#
+#   1. It's faster than creating $big_depth tree objects.
+#
+#   2. As we tighten tree limits, it's more likely to allow large sizes
+#      than trying to stuff a deep path into the index.
+mkdeep () {
+	{
+		echo "commit refs/tags/$1" &&
+		echo "committer foo <foo@example.com> 1234 -0000" &&
+		echo "data <<EOF" &&
+		echo "the commit message" &&
+		echo "EOF" &&
+
+		printf 'M 100644 inline ' &&
+		i=0 &&
+		while test $i -lt $2
+		do
+			printf 'a/'
+			i=$((i+1))
+		done &&
+		echo "file" &&
+
+		echo "data <<EOF" &&
+		echo "the file contents" &&
+		echo "EOF" &&
+		echo
+	} | git fast-import
+}
+
+test_expect_success 'create small tree' '
+	mkdeep small $small_depth
+'
+
+test_expect_success 'create big tree' '
+	mkdeep big $big_depth
+'
+
+test_expect_success 'limit recursion of git-archive' '
+	git $small_ok archive small >/dev/null &&
+	test_must_fail git $small_no archive small >/dev/null
+'
+
+test_expect_success 'default limit for git-archive fails gracefully' '
+	test_must_fail git archive big >/dev/null
+'
+
+test_done
diff --git a/tree-walk.c b/tree-walk.c
index 4efd0fc391..b517792ba2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -9,6 +9,7 @@
 #include "tree.h"
 #include "pathspec.h"
 #include "json-writer.h"
+#include "environment.h"
 
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -449,6 +450,9 @@ int traverse_trees(struct index_state *istate,
 	int interesting = 1;
 	char *traverse_path;
 
+	if (traverse_trees_cur_depth > max_allowed_tree_depth)
+		return error("exceeded maximum allowed tree depth");
+
 	traverse_trees_count++;
 	traverse_trees_cur_depth++;
 
-- 
2.42.0.561.gaa987ecc69

