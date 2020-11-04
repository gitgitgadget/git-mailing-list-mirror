Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87CC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420602222C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgKDN1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:27:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:47148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbgKDN1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:27:38 -0500
Received: (qmail 9722 invoked by uid 109); 4 Nov 2020 13:27:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 13:27:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10178 invoked by uid 111); 4 Nov 2020 13:27:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 08:27:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 08:27:37 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Postler <johannes.postler@txture.io>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/3] format-patch: tie file-opening logic to output_directory
Message-ID: <20201104132737.GB3030146@coredump.intra.peff.net>
References: <20201104132428.GA2491189@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104132428.GA2491189@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In format-patch we're either outputting to stdout or to individual files
in an output directory (which maybe just "./"). Our logic for whether to
open a new file for each patch is checked with "!use_stdout", but it is
equally correct to check for a non-NULL output_directory.

The distinction will matter when we add a new single-stream output in a
future patch, when only one of the three methods will want individual
files. Let's swap the logic here in preparation.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4c391ba3ca..27c6d612e4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1153,7 +1153,7 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 	}
 }
 
-static void make_cover_letter(struct rev_info *rev, int use_stdout,
+static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
@@ -1173,7 +1173,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	committer = git_committer_info(0);
 
-	if (!use_stdout &&
+	if (use_separate_file &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
 		die(_("failed to create cover-letter file"));
 
@@ -2117,7 +2117,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
-		make_cover_letter(&rev, use_stdout,
+		make_cover_letter(&rev, !!output_directory,
 				  origin, nr, list, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
@@ -2172,7 +2172,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, oid_to_hex(&commit->object.oid));
 		}
 
-		if (!use_stdout &&
+		if (output_directory &&
 		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
@@ -2185,7 +2185,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 * the log; when using one file per patch, we do
 		 * not want the extra blank line.
 		 */
-		if (!use_stdout)
+		if (output_directory)
 			rev.shown_one = 0;
 		if (shown) {
 			print_bases(&bases, rev.diffopt.file);
@@ -2196,7 +2196,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			else
 				print_signature(rev.diffopt.file);
 		}
-		if (!use_stdout)
+		if (output_directory)
 			fclose(rev.diffopt.file);
 	}
 	stop_progress(&progress);
-- 
2.29.2.559.g8ec94df761

