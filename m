Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5AC433FE
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68EB60EFD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbhI2B5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbhI2B5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:57:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAEC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d18so1082034iof.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FJ7sX9cvQ2kw392nHDHtd+ACZNHTdlrFq2cEi8Bt7Qc=;
        b=h7+GG9ZtBTySFVIumtYoqvHsdMyZyRt6jvSq17ifY8m4b2qZWulYP1/MLnF6/WAQWh
         8JLmDzR8dz9sN256N6Ou6ivniT5YufSrkdDyw6eZn/x4/XTaH+WMgzZCx3CRTaZegKUT
         Ie8ejXwGWzMLiwPBpeNXmepl+437UD5rvUgXxScGCxOOf4rOAB0j3Sb6EOiy5nbGr7Fz
         KC56MneZHtZvLtHCzPlNHUMEciGaZcUBCXDPGiO66oDb3hY8KPNSzVBLnR11eG8E/sfi
         WFT1CjLuXZxPqe680S50+4GFUMhRak8hdpMRJch+pmiaacF4rKk2NWvUZl3X7cYu6Yb/
         iPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJ7sX9cvQ2kw392nHDHtd+ACZNHTdlrFq2cEi8Bt7Qc=;
        b=A80tqxUtUNJ+FOIiH6Qylpb6SX3zO2GMV9xuFDUdARifDj4cGdOOmquosezPvt0tCW
         w57ZhvVE/TKA+kH9aFtk4SmnJmF0hcp/C8I7tj6r82zmVoLQQWS5FnQ1rFES03pqOO5H
         IXhJJi0ICmbWIKuwuAqcGz3GRfenNkyiQLLaQF23ReLeYXbd6ajyb7ov5ee4c3xKO88e
         2FedTX9V53s5EZkahqTW36/DrAO0kxW0+cjGGmU+m3wEklcdhjrYEadUt4af1SR8MpAC
         ydeYLEYyYpQJyekdYkKFB3bnqvCB4Ds7CiciL/INDEXYshhythacY9Gg4FFvKC7Buq2C
         fYLA==
X-Gm-Message-State: AOAM531cvxUH9kL0O7StAFMpU7UA68q72r3eQJKP61QEb59BKjkC0Ccw
        gWq2wcGKX/jw39vzn99bQqfgRZAXI/Hm2g==
X-Google-Smtp-Source: ABdhPJwNLuZxA7xtrgfXXStySUpIVpp1I3iwDlisuXMUK/sw96ezD+XWADl4B6vTnxPRd0EVy5GmVw==
X-Received: by 2002:a5e:d618:: with SMTP id w24mr6135314iom.178.1632880521840;
        Tue, 28 Sep 2021 18:55:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q17sm562435iod.51.2021.09.28.18.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:21 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 8/9] builtin/repack.c: make largest pack preferred
Message-ID: <3596c76daf095dc997c3d322ed96875efe9348a7.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When repacking into a geometric series and writing a multi-pack bitmap,
it is beneficial to have the largest resulting pack be the preferred
object source in the bitmap's MIDX, since selecting the large packs can
lead to fewer broken delta chains and better compression.

Teach 'git repack' to identify this pack and pass it to the MIDX write
machinery in order to mark it as preferred.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt |  4 ++++
 builtin/repack.c             | 27 ++++++++++++++++++++++++++-
 pack-bitmap.c                |  2 +-
 pack-bitmap.h                |  1 +
 t/helper/test-read-midx.c    | 25 ++++++++++++++++++++++++-
 t/t7703-repack-geometric.sh  | 22 ++++++++++++++++++++++
 6 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0f2d235ca5..7183fb498f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -190,6 +190,10 @@ this "roll-up", without respect to their reachability. This is subject
 to change in the future. This option (implying a drastically different
 repack mode) is not guaranteed to work with all other combinations of
 option to `git repack`.
++
+When writing a multi-pack bitmap, `git repack` selects the largest resulting
+pack as the preferred pack for object selection by the MIDX (see
+linkgit:git-multi-pack-index[1]).
 
 -m::
 --write-midx::
diff --git a/builtin/repack.c b/builtin/repack.c
index abb30f89e8..1577f0d59f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -423,6 +423,25 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	geometry->split = split;
 }
 
+static struct packed_git *get_largest_active_pack(struct pack_geometry *geometry)
+{
+	if (!geometry) {
+		/*
+		 * No geometry means either an all-into-one repack (in which
+		 * case there is only one pack left and it is the largest) or an
+		 * incremental one.
+		 *
+		 * If repacking incrementally, then we could check the size of
+		 * all packs to determine which should be preferred, but leave
+		 * this for later.
+		 */
+		return NULL;
+	}
+	if (geometry->split == geometry->pack_nr)
+		return NULL;
+	return geometry->pack[geometry->pack_nr - 1];
+}
+
 static void clear_pack_geometry(struct pack_geometry *geometry)
 {
 	if (!geometry)
@@ -468,10 +487,12 @@ static void midx_included_packs(struct string_list *include,
 }
 
 static int write_midx_included_packs(struct string_list *include,
+				     struct pack_geometry *geometry,
 				     int show_progress, int write_bitmaps)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
+	struct packed_git *largest = get_largest_active_pack(geometry);
 	FILE *in;
 	int ret;
 
@@ -492,6 +513,10 @@ static int write_midx_included_packs(struct string_list *include,
 	if (write_bitmaps)
 		strvec_push(&cmd.args, "--bitmap");
 
+	if (largest)
+		strvec_pushf(&cmd.args, "--preferred-pack=%s",
+			     pack_basename(largest));
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -783,7 +808,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		midx_included_packs(&include, &existing_nonkept_packs,
 				    &existing_kept_packs, &names, geometry);
 
-		ret = write_midx_included_packs(&include,
+		ret = write_midx_included_packs(&include, geometry,
 						show_progress, write_bitmaps > 0);
 
 		string_list_clear(&include, 0);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8504110a4d..67be9be9a6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1418,7 +1418,7 @@ static int try_partial_reuse(struct packed_git *pack,
 	return 0;
 }
 
-static uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
+uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
 {
 	struct multi_pack_index *m = bitmap_git->midx;
 	if (!m)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 469090bad2..7d407c5a4c 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -55,6 +55,7 @@ int test_bitmap_commits(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 struct list_objects_filter_options *filter,
 					 int filter_provided_objects);
+uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
 				       uint32_t *entries,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index cb0d27049a..0038559129 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -3,6 +3,7 @@
 #include "midx.h"
 #include "repository.h"
 #include "object-store.h"
+#include "pack-bitmap.h"
 
 static int read_midx_file(const char *object_dir, int show_objects)
 {
@@ -72,14 +73,36 @@ static int read_midx_checksum(const char *object_dir)
 	return 0;
 }
 
+static int read_midx_preferred_pack(const char *object_dir)
+{
+	struct multi_pack_index *midx = NULL;
+	struct bitmap_index *bitmap = NULL;
+
+	setup_git_directory();
+
+	midx = load_multi_pack_index(object_dir, 1);
+	if (!midx)
+		return 1;
+
+	bitmap = prepare_bitmap_git(the_repository);
+	if (!(bitmap && bitmap_is_midx(bitmap)))
+		return 1;
+
+
+	printf("%s\n", midx->pack_names[midx_preferred_pack(bitmap)]);
+	return 0;
+}
+
 int cmd__read_midx(int argc, const char **argv)
 {
 	if (!(argc == 2 || argc == 3))
-		usage("read-midx [--show-objects|--checksum] <object-dir>");
+		usage("read-midx [--show-objects|--checksum|--preferred-pack] <object-dir>");
 
 	if (!strcmp(argv[1], "--show-objects"))
 		return read_midx_file(argv[2], 1);
 	else if (!strcmp(argv[1], "--checksum"))
 		return read_midx_checksum(argv[2]);
+	else if (!strcmp(argv[1], "--preferred-pack"))
+		return read_midx_preferred_pack(argv[2]);
 	return read_midx_file(argv[1], 0);
 }
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 67049f7637..bdbbcbf1ec 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -180,4 +180,26 @@ test_expect_success '--geometric ignores kept packs' '
 	)
 '
 
+test_expect_success '--geometric chooses largest MIDX preferred pack' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# These packs already form a geometric progression.
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 2 && # 6 objects
+		ls $objdir/pack/pack-*.idx >before &&
+		test_commit_bulk --start=4 4 && # 12 objects
+		ls $objdir/pack/pack-*.idx >after &&
+
+		git repack --geometric 2 -dbm &&
+
+		comm -3 before after | xargs -n 1 basename >expect &&
+		test-tool read-midx --preferred-pack $objdir >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.33.0.96.g73915697e6

