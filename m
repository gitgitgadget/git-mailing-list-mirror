Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3AF202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 03:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCLDNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 23:13:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38872 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfCLDND (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 23:13:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4EDE220248;
        Tue, 12 Mar 2019 03:13:03 +0000 (UTC)
Date:   Tue, 12 Mar 2019 03:13:03 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: [PATCH] repack: enable bitmaps by default on bare repos
Message-ID: <20190312031303.5tutut7zzvxne5dw@dcvr>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190310233956.GB3059@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Sat, Mar 09, 2019 at 02:49:44AM +0000, Eric Wong wrote:
> > It would make life easier for people new to hosting git servers
> > (and hopefully reduce centralization :)
> 
> I do think they're a net win for people hosting git servers. But if
> that's the goal, I think at most you'd want to make bitmaps the default
> for bare repos. They're really not much help for normal end-user repos
> at this point.

Fair enough, hopefully this can make life easier for admins
new to hosting git:

----------8<---------
Subject: [PATCH] repack: enable bitmaps by default on bare repos

A typical use case for bare repos is for serving clones and
fetches to clients.  Enable bitmaps by default on bare repos to
make it easier for admins to host git repos in a performant way.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/repack.c  | 16 ++++++++++------
 t/t7700-repack.sh | 14 +++++++++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 67f8978043..5d4758b515 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,7 +14,7 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
-static int write_bitmaps;
+static int write_bitmaps = -1;
 static int use_delta_islands;
 static char *packdir, *packtmp;
 
@@ -343,11 +343,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
+	if (!(pack_everything & ALL_INTO_ONE)) {
+		if (write_bitmaps > 0)
+			die(_(incremental_bitmap_conflict_error));
+	} else if (write_bitmaps < 0) {
+		write_bitmaps = is_bare_repository();
+	}
+
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps;
-
-	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
-		die(_(incremental_bitmap_conflict_error));
+		pack_kept_objects = write_bitmaps > 0;
 
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
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6162e2a8e6..3e0b5c40e4 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -221,5 +221,17 @@ test_expect_success 'repack --keep-pack' '
 	)
 '
 
+test_expect_success 'bitmaps are created by default in bare repos' '
+	git clone --bare .git bare.git &&
+	cd bare.git &&
+	mkdir old &&
+	mv objects/pack/* old &&
+	pack=$(ls old/*.pack) &&
+	test_path_is_file "$pack" &&
+	git unpack-objects -q <"$pack" &&
+	git repack -ad &&
+	bitmap=$(ls objects/pack/*.bitmap) &&
+	test_path_is_file "$bitmap"
+'
+
 test_done
-
