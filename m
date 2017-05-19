Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9075C2021E
	for <e@80x24.org>; Fri, 19 May 2017 12:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755207AbdESM7T (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:59:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:54868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdESM7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:59:18 -0400
Received: (qmail 3080 invoked by uid 109); 19 May 2017 12:59:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:59:17 +0000
Received: (qmail 27941 invoked by uid 111); 19 May 2017 12:59:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:59:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:59:15 -0400
Date:   Fri, 19 May 2017 08:59:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 14/15] diff: use pending "path" if it is available
Message-ID: <20170519125915.eaw7zb3sjjs4xz3b@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a subtle distinction between "name" and "path" for a
blob that we resolve: the name is what the user told us on
the command line, and the path is what we traversed when
finding the blob within a tree (if we did so).

When we diff blobs directly, we use "name", but "path" is
more likely to be useful to the user (it will find the
correct .gitattributes, and give them a saner diff header).

We still have to fall back to using the name for some cases
(i.e., any blob reference that isn't of the form tree:path).
That's the best we can do in such a case.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c        | 7 ++++++-
 t/t4063-diff-blobs.sh | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 4c0811d6f..1a1149eed 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -23,6 +23,11 @@
 static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit> [<commit>]] [--] [<path>...]";
 
+static const char *blob_path(struct object_array_entry *entry)
+{
+	return entry->path ? entry->path : entry->name;
+}
+
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
 			 const struct object_id *old_oid,
@@ -110,7 +115,7 @@ static int builtin_diff_blobs(struct rev_info *revs,
 		     blob[0]->mode, blob[1]->mode,
 		     &blob[0]->item->oid, &blob[1]->item->oid,
 		     1, 1,
-		     blob[0]->name, blob[1]->name);
+		     blob_path(blob[0]), blob_path(blob[1]));
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index df9c35b2d..80ce033ab 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -55,7 +55,7 @@ test_expect_success 'diff by tree:path (run)' '
 test_expect_success 'index of tree:path diff' '
 	check_index $sha1_one $sha1_two
 '
-test_expect_failure 'tree:path diff uses filenames as paths' '
+test_expect_success 'tree:path diff uses filenames as paths' '
 	check_paths one two
 '
 test_expect_success 'tree:path diff shows mode change' '
@@ -68,7 +68,7 @@ test_expect_success 'diff by ranged tree:path' '
 test_expect_success 'index of ranged tree:path diff' '
 	check_index $sha1_one $sha1_two
 '
-test_expect_failure 'ranged tree:path diff uses filenames as paths' '
+test_expect_success 'ranged tree:path diff uses filenames as paths' '
 	check_paths one two
 '
 test_expect_success 'ranged tree:path diff shows mode change' '
-- 
2.13.0.219.g63f6bc368

