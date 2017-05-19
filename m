Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198982021E
	for <e@80x24.org>; Fri, 19 May 2017 12:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbdESMy7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:54:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbdESMy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:54:58 -0400
Received: (qmail 2733 invoked by uid 109); 19 May 2017 12:54:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:54:58 +0000
Received: (qmail 27841 invoked by uid 111); 19 May 2017 12:55:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:55:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:54:56 -0400
Date:   Fri, 19 May 2017 08:54:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 09/15] t4063: add tests of direct blob diffs
Message-ID: <20170519125456.j3xnwazaahtogwni@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-diff command can directly compare two blobs (or a
blob and a file), but we don't test this at all. Let's add
some basic tests that reveal a few problems.

There are basically four interesting inputs:

  1. sha1 against sha1 (where diff has no information beyond
     the contents)

  2. tree:path against tree:path (where it can get
     information via get_sha1_with_context)

  3. Same as (2), but using the ".." range syntax

  4. tree:path against a filename

And beyond generating a sane diff, we care about a few
little bits: which paths they show in the diff header, and
whether they correctly pick up a mode change.

They should all be able to show a mode except for (1),
though note that case (3) is currently broken.

For the headers, we would ideally show the path within the
tree if we have it, making:

  git diff a:path b:path

look the same as:

  git diff a b -- path

We can't always do that (e.g., in the direct sha1/sha1 diff,
we have no path to show), in which case we should fall back
to the name that resolved to the blob (which is nonsense
from the repository's perspective, but is the best we can
do).

Aside from the fallback case in (1), none of the cases get
this right. Cases (2) and (3) always show the full
tree:path, even though we should be able to know just the
"path" portion.

Case (4) picks up the filename path, but assigns it to
_both_ sides of the diff. So this works for:

  git diff tree:path path

but not for:

  git diff tree:other_path path

The appropriate tests are marked to expect failure.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4063-diff-blobs.sh | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 t/t4063-diff-blobs.sh

diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
new file mode 100755
index 000000000..90c6f6b85
--- /dev/null
+++ b/t/t4063-diff-blobs.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='test direct comparison of blobs via git-diff'
+. ./test-lib.sh
+
+run_diff () {
+	# use full-index to make it easy to match the index line
+	git diff --full-index "$@" >diff
+}
+
+check_index () {
+	grep "^index $1\\.\\.$2" diff
+}
+
+check_mode () {
+	grep "^old mode $1" diff &&
+	grep "^new mode $2" diff
+}
+
+check_paths () {
+	grep "^diff --git a/$1 b/$2" diff
+}
+
+test_expect_success 'create some blobs' '
+	echo one >one &&
+	echo two >two &&
+	chmod +x two &&
+	git add . &&
+
+	# cover systems where modes are ignored
+	git update-index --chmod=+x two &&
+
+	git commit -m base &&
+
+	sha1_one=$(git rev-parse HEAD:one) &&
+	sha1_two=$(git rev-parse HEAD:two)
+'
+
+test_expect_success 'diff by sha1' '
+	run_diff $sha1_one $sha1_two
+'
+test_expect_success 'index of sha1 diff' '
+	check_index $sha1_one $sha1_two
+'
+test_expect_success 'sha1 diff uses arguments as paths' '
+	check_paths $sha1_one $sha1_two
+'
+test_expect_success 'sha1 diff has no mode change' '
+	! grep mode diff
+'
+
+test_expect_success 'diff by tree:path (run)' '
+	run_diff HEAD:one HEAD:two
+'
+test_expect_success 'index of tree:path diff' '
+	check_index $sha1_one $sha1_two
+'
+test_expect_failure 'tree:path diff uses filenames as paths' '
+	check_paths one two
+'
+test_expect_success 'tree:path diff shows mode change' '
+	check_mode 100644 100755
+'
+
+test_expect_success 'diff by ranged tree:path' '
+	run_diff HEAD:one..HEAD:two
+'
+test_expect_success 'index of ranged tree:path diff' '
+	check_index $sha1_one $sha1_two
+'
+test_expect_failure 'ranged tree:path diff uses filenames as paths' '
+	check_paths one two
+'
+test_expect_failure 'ranged tree:path diff shows mode change' '
+	check_mode 100644 100755
+'
+
+test_expect_success 'diff blob against file' '
+	run_diff HEAD:one two
+'
+test_expect_success 'index of blob-file diff' '
+	check_index $sha1_one $sha1_two
+'
+test_expect_failure 'blob-file diff uses filename as paths' '
+	check_paths one two
+'
+test_expect_success FILEMODE 'blob-file diff shows mode change' '
+	check_mode 100644 100755
+'
+
+test_done
-- 
2.13.0.219.g63f6bc368

