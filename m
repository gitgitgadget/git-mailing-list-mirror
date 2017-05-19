Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E052021E
	for <e@80x24.org>; Fri, 19 May 2017 12:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbdESM7h (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:59:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:54874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdESM7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:59:36 -0400
Received: (qmail 3157 invoked by uid 109); 19 May 2017 12:59:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:59:36 +0000
Received: (qmail 27961 invoked by uid 111); 19 May 2017 13:00:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 09:00:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:59:34 -0400
Date:   Fri, 19 May 2017 08:59:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 15/15] diff: use blob path for blob/file diffs
Message-ID: <20170519125934.6kz7qukpmf43lcld@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we diff a blob against a working tree file like:

  git diff HEAD:Makefile Makefile

we always use the working tree filename for both sides of
the diff. In most cases that's fine, as the two would be the
same anyway, as above. And until recently, we used the
"name" for the blob, not the path, which would have the
messy "HEAD:" on the beginning.

But when they don't match, like:

  git diff HEAD:old_path new_path

it makes sense to show both names.

This patch uses the blob's path field if it's available, and
otherwise falls back to using the filename (in preference to
the blob's name, which is likely to be garbage like a raw
sha1).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c        | 3 ++-
 t/t4063-diff-blobs.sh | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 1a1149eed..5e7c6428c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -90,7 +90,8 @@ static int builtin_diff_b_f(struct rev_info *revs,
 		     blob[0]->mode, canon_mode(st.st_mode),
 		     &blob[0]->item->oid, &null_oid,
 		     1, 0,
-		     path, path);
+		     blob[0]->path ? blob[0]->path : path,
+		     path);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index 80ce033ab..bc69e26c5 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -81,11 +81,16 @@ test_expect_success 'diff blob against file' '
 test_expect_success 'index of blob-file diff' '
 	check_index $sha1_one $sha1_two
 '
-test_expect_failure 'blob-file diff uses filename as paths' '
+test_expect_success 'blob-file diff uses filename as paths' '
 	check_paths one two
 '
 test_expect_success FILEMODE 'blob-file diff shows mode change' '
 	check_mode 100644 100755
 '
 
+test_expect_success 'blob-file diff prefers filename to sha1' '
+	run_diff $sha1_one two &&
+	check_paths two two
+'
+
 test_done
-- 
2.13.0.219.g63f6bc368
