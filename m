Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2131F732
	for <e@80x24.org>; Wed, 31 Jul 2019 05:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfGaFj3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 01:39:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:56566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725866AbfGaFj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 01:39:29 -0400
Received: (qmail 11757 invoked by uid 109); 31 Jul 2019 05:39:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 05:39:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13991 invoked by uid 111); 31 Jul 2019 05:41:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 01:41:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 01:39:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: [PATCH 2/3] repack: silence warnings when auto-enabled bitmaps
 cannot be built
Message-ID: <20190731053927.GB16941@sigill.intra.peff.net>
References: <20190731053703.GA16709@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731053703.GA16709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on various config options, a full repack may not be able to
build a reachability bitmap index (e.g., if pack.packSizeLimit forces us
to write multiple packs). In these cases pack-objects may write a
warning to stderr.

Since 36eba0323d (repack: enable bitmaps by default on bare repos,
2019-03-14), we may generate these warnings even when the user did not
explicitly ask for bitmaps. This has two downsides:

  - it can be confusing, if they don't know what bitmaps are

  - a daemonized auto-gc will write this to its log file, and the
    presence of the warning may suppress further auto-gc (until
    gc.logExpiry has elapsed)

Let's have repack communicate to pack-objects that the choice to turn on
bitmaps was not made explicitly by the user, which in turn allows
pack-objects to suppress these warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 21 ++++++++++++++++-----
 builtin/repack.c       | 15 +++++++++------
 t/t7700-repack.sh      | 11 +++++++++++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 267c562b1f..76ce906946 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -96,7 +96,11 @@ static off_t reuse_packfile_offset;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
-static int write_bitmap_index;
+static enum {
+	WRITE_BITMAP_FALSE = 0,
+	WRITE_BITMAP_QUIET,
+	WRITE_BITMAP_TRUE,
+} write_bitmap_index;
 static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
 static int exclude_promisor_objects;
@@ -892,7 +896,8 @@ static void write_pack_file(void)
 						 nr_written, oid.hash, offset);
 			close(fd);
 			if (write_bitmap_index) {
-				warning(_(no_split_warning));
+				if (write_bitmap_index != WRITE_BITMAP_QUIET)
+					warning(_(no_split_warning));
 				write_bitmap_index = 0;
 			}
 		}
@@ -1176,7 +1181,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
-			warning(_(no_closure_warning));
+			if (write_bitmap_index != WRITE_BITMAP_QUIET)
+				warning(_(no_closure_warning));
 			write_bitmap_index = 0;
 		}
 		return 0;
@@ -3313,8 +3319,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    N_("do not hide commits by grafts"), 0),
 		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
 			 N_("use a bitmap index if available to speed up counting objects")),
-		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
-			 N_("write a bitmap index together with the pack index")),
+		OPT_SET_INT(0, "write-bitmap-index", &write_bitmap_index,
+			    N_("write a bitmap index together with the pack index"),
+			    WRITE_BITMAP_TRUE),
+		OPT_SET_INT_F(0, "write-bitmap-index-quiet",
+			      &write_bitmap_index,
+			      N_("write a bitmap index if possible"),
+			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		{ OPTION_CALLBACK, 0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
diff --git a/builtin/repack.c b/builtin/repack.c
index 30982ed2a2..db93ca3660 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -345,13 +345,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		die(_("--keep-unreachable and -A are incompatible"));
 
 	if (write_bitmaps < 0) {
-		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
-				 is_bare_repository() &&
-				 keep_pack_list.nr == 0 &&
-				 !has_pack_keep_file();
+		if (!(pack_everything & ALL_INTO_ONE) ||
+		    !is_bare_repository() ||
+		    keep_pack_list.nr != 0 ||
+		    has_pack_keep_file())
+			write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps;
+		pack_kept_objects = !!write_bitmaps;
 
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
 		die(_(incremental_bitmap_conflict_error));
@@ -375,8 +376,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--indexed-objects");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
-	if (write_bitmaps)
+	if (write_bitmaps > 0)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
+	else if (write_bitmaps < 0)
+		argv_array_push(&cmd.args, "--write-bitmap-index-quiet");
 	if (use_delta_islands)
 		argv_array_push(&cmd.args, "--delta-islands");
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 8d9a358df8..54f815b8b9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -250,4 +250,15 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'auto-bitmaps do not complain if unavailable' '
+	test_config -C bare.git pack.packSizeLimit 1M &&
+	blob=$(test-tool genrandom big $((1024*1024)) |
+	       git -C bare.git hash-object -w --stdin) &&
+	git -C bare.git update-ref refs/tags/big $blob &&
+	git -C bare.git repack -ad 2>stderr &&
+	test_must_be_empty stderr &&
+	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.23.0.rc0.426.gbdee707ba7

