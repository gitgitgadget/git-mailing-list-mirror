Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C2D202BB
	for <e@80x24.org>; Sat,  9 Mar 2019 02:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCICtp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 21:49:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42066 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfCICtp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 21:49:45 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1D76020248;
        Sat,  9 Mar 2019 02:49:45 +0000 (UTC)
Date:   Sat, 9 Mar 2019 02:49:44 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: bitmaps by default? [was: prune: use bitmaps for reachability
 traversal]
Message-ID: <20190309024944.zcbwgvn52jsw2a2e@dcvr>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214043743.GB19183@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> Pruning generally has to traverse the whole commit graph in order to
> see which objects are reachable. This is the exact problem that
> reachability bitmaps were meant to solve, so let's use them (if they're
> available, of course).

Perhaps this is good impetus for doing bitmaps by default?

It would make life easier for people new to hosting git servers
(and hopefully reduce centralization :)


I started working on it, but t0410-partial-clone.sh fails with
"Failed to write bitmap index. Packfile doesn't have full
closure"; so more work needs to be done w.r.t. default behavior
on partial clones...

Here's my WIP:

diff --git a/builtin/repack.c b/builtin/repack.c
index 67f8978043..ca98d32715 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,7 +14,7 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
-static int write_bitmaps;
+static int write_bitmaps = -1;
 static int use_delta_islands;
 static char *packdir, *packtmp;
 
@@ -344,10 +344,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		die(_("--keep-unreachable and -A are incompatible"));
 
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps;
+		pack_kept_objects = write_bitmaps > 0;
 
-	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
-		die(_(incremental_bitmap_conflict_error));
+	if (!(pack_everything & ALL_INTO_ONE)) {
+		if (write_bitmaps > 0)
+			die(_(incremental_bitmap_conflict_error));
+	} else if (write_bitmaps < 0) {
+		write_bitmaps = 1;
+	}
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
@@ -368,7 +372,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--indexed-objects");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
-	if (write_bitmaps)
+	if (write_bitmaps > 0)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
 	if (use_delta_islands)
 		argv_array_push(&cmd.args, "--delta-islands");
