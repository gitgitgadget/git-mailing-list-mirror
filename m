Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AABB1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbcIGWEO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:04:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:39698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752563AbcIGWEN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:04:13 -0400
Received: (qmail 29615 invoked by uid 109); 7 Sep 2016 22:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 22:04:12 +0000
Received: (qmail 8507 invoked by uid 111); 7 Sep 2016 22:04:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 18:04:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:04:09 -0400
Date:   Wed, 7 Sep 2016 18:04:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 2/3] diff_flush_patch_id: stop returning error result
Message-ID: <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of our errors come from diff_get_patch_id(), which has
exactly three error conditions. The first is an internal
assertion, which should be a die("BUG") in the first place.

The other two are caused by an inability to two diff blobs,
which is an indication of a serious problem (probably
repository corruption). All the rest of the diff subsystem
dies immediately on these conditions. By passing up the
error, in theory we can keep going even if patch-id is
unable to function. But in practice this means we may
generate subtly wrong results (e.g., by failing to correlate
two commits). Let's just die(), as we're better off making
it clear to the user that their repository is not
functional.

As a result, we can simplify the calling code.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a prerequisite for patch 3, since it means that
commit_patch_id() stops returning "real" errors. But obviously if this
is distasteful (and it does feel a little weird to convert error() to
die(), even though the rest of the diff code-base behaves this way), we
can teach commit_patch_id() to distinguish between "this has no
patch-id" and "a real error occured" in its return value.

 diff.c      | 18 ++++++++----------
 diff.h      |  2 +-
 patch-ids.c |  3 ++-
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 534c12e..d0594f6 100644
--- a/diff.c
+++ b/diff.c
@@ -4462,7 +4462,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 }
 
 /* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
+static void diff_get_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -4484,7 +4484,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		if (p->status == 0)
-			return error("internal diff status error");
+			die("BUG: diff status unset while computing patch_id");
 		if (p->status == DIFF_STATUS_UNKNOWN)
 			continue;
 		if (diff_unmodified_pair(p))
@@ -4536,7 +4536,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 
 		if (fill_mmfile(&mf1, p->one) < 0 ||
 		    fill_mmfile(&mf2, p->two) < 0)
-			return error("unable to read files to diff");
+			die("unable to read files to diff");
 
 		if (diff_filespec_is_binary(p->one) ||
 		    diff_filespec_is_binary(p->two)) {
@@ -4552,27 +4552,25 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 		xecfg.flags = 0;
 		if (xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
 				  &xpp, &xecfg))
-			return error("unable to generate patch-id diff for %s",
-				     p->one->path);
+			die("unable to generate patch-id diff for %s",
+			    p->one->path);
 	}
 
 	git_SHA1_Final(sha1, &ctx);
-	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
+void diff_flush_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, sha1, diff_header_only);
+
+	diff_get_patch_id(options, sha1, diff_header_only);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
 
 	free(q->queue);
 	DIFF_QUEUE_CLEAR(q);
-
-	return result;
 }
 
 static int is_summary_empty(const struct diff_queue_struct *q)
diff --git a/diff.h b/diff.h
index 7883729..f4dcfe1 100644
--- a/diff.h
+++ b/diff.h
@@ -342,7 +342,7 @@ extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
 extern int do_diff_cache(const unsigned char *, struct diff_options *);
-extern int diff_flush_patch_id(struct diff_options *, unsigned char *, int);
+extern void diff_flush_patch_id(struct diff_options *, unsigned char *, int);
 
 extern int diff_result_code(struct diff_options *, int);
 
diff --git a/patch-ids.c b/patch-ids.c
index 77e4663..0e95220 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -13,7 +13,8 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1, diff_header_only);
+	diff_flush_patch_id(options, sha1, diff_header_only);
+	return 0;
 }
 
 /*
-- 
2.10.0.rc2.154.gb4a4b8b

