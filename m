Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58883EE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHUUPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHUUPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:15:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A79BE
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:15:11 -0700 (PDT)
Received: (qmail 17348 invoked by uid 109); 21 Aug 2023 20:15:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:15:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18625 invoked by uid 111); 21 Aug 2023 20:15:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:15:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:15:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 2/7] diff-files: avoid negative exit value
Message-ID: <20230821201510.GB1798590@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821201358.GA2663749@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If loading the index fails, we print an error and then return "-1" from
the function. But since this is a builtin, we end up with exit(-1),
which produces odd results since program exit codes are unsigned.
Because of integer conversion, it usually becomes 255, which is at least
still an error, but values above 128 are usually interpreted as signal
death.

Since we know the program is exiting immediately, we can just replace
the error return with a die().

Signed-off-by: Jeff King <peff@peff.net>
---
I'm actually not sure this can be triggered in practice; see patch 4 for
more discussion. Regardless, it seems like a strict improvement.

 builtin/diff-files.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 50330b8dd2..2e3e948583 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -80,14 +80,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		diff_merges_set_dense_combined_if_unset(&rev);
 
-	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
-		perror("repo_read_index_preload");
-		result = -1;
-		goto cleanup;
-	}
+	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0)
+		die_errno("repo_read_index_preload");
 	result = run_diff_files(&rev, options);
 	result = diff_result_code(&rev.diffopt, result);
-cleanup:
 	release_revisions(&rev);
 	return result;
 }
-- 
2.42.0.rc2.423.g967ecb4f2b

