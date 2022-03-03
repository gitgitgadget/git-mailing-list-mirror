Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21380C433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiCCAWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiCCAWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:22:14 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6913DE33
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:22 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id f18so3286766qtb.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GvktSRe3ZfbRs7bVfSI1U4BvamiSpw33fg6sft3UJ9s=;
        b=jYgIdgGQXonBsoGEnsNOhyINU8Xke/+RSs6uzIpdF8/x1oSB0KzpNMAxmiVlCAk8c8
         bdd9tmaeAhHIMTSeePHY5D930TWIeWFOCRpdd1BtuCmHDJoWzWdeRLI7D16IAsZQKB8h
         5k9tqW5ihd3GJzOi/whO+bEJfKrbcuECzwMMaz0t0QOIj56QoqpAVxzCnBelE87reawx
         ZQkmen3msaOmfIMYKHhLFjnFBChDoAPJQYyggo98BQJfIoRSBIzy4RwK3S+4Uoomt9Xn
         wDLXqgagzSmm6Nbk7aVZOOY2VjmaCCYgBNV/Ox1YVXiIwgv4TJW3eRrLiJRpHKp5o8tN
         9c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvktSRe3ZfbRs7bVfSI1U4BvamiSpw33fg6sft3UJ9s=;
        b=cl6VrsPfGT4pZvfnohP9gV88cBzh10uDoVbeJWgCXzMA5I0VaxKp54OzLe0huBigcv
         S51aUYJTKP3QuCAmMZPiFcoMlGJakqNRf8esaBiiG39KPL1c1rnY0a7Ex3TtxEY/d915
         vstchE53RWCJkLiTeh+XSrhdPjOLraZ+lKlAOajKITFOD2iv+RlKsWf1M96H2tv9H7Sr
         O5bae9mzeT7yWZOsgQLGGhE5RJ2iR/tEwjUi4wOxq939Z45zv4cp+rujSl2RtASoJKGC
         3mKcHr6LaEO7gn+mTDE+paphAK9/bnnD4neIxo4YKfPGDoQJWb8ohZ38hSBmrjWQ8eqM
         9NBA==
X-Gm-Message-State: AOAM531blV5Yq9DvjKpavt0WQ7hCq90oifYImN8sFBR2ni/S8DyDt5MV
        m2Ai15qkhBnN+tOFlZiHsM8Ci4MqTOIHbjQ5
X-Google-Smtp-Source: ABdhPJyIrD1UFrbVC5EJz+mjxadi0PmJf6HR8cpA+ljH/ztdnei7KrHLf6FOmtMeeQ7op9YF2kWK0Q==
X-Received: by 2002:a05:622a:11d2:b0:2de:901e:49b5 with SMTP id n18-20020a05622a11d200b002de901e49b5mr25695603qtk.444.1646266881479;
        Wed, 02 Mar 2022 16:21:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d186-20020a379bc3000000b006490a4e507esm306539qke.70.2022.03.02.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:21 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 15/17] builtin/repack.c: add cruft packs to MIDX during
 geometric repack
Message-ID: <ed05cf536bdea62a2b512bb3a610ec7861ff68b5.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using cruft packs, the following race can occur when a geometric
repack that writes a MIDX bitmap takes place afterwords:

  - First, create an unreachable object and do an all-into-one cruft
    repack which stores that object in the repository's cruft pack.
  - Then make that object reachable.
  - Finally, do a geometric repack and write a MIDX bitmap.

Assuming that we are sufficiently unlucky as to select a commit from the
MIDX which reaches that object for bitmapping, then the `git
multi-pack-index` process will complain that that object is missing.

The reason is because we don't include cruft packs in the MIDX when
doing a geometric repack. Since the "make that object reachable" doesn't
necessarily mean that we'll create a new copy of that object in one of
the packs that will get rolled up as part of a geometric repack, it's
possible that the MIDX won't see any copies of that now-reachable
object.

Of course, it's desirable to avoid including cruft packs in the MIDX
because it causes the MIDX to store a bunch of objects which are likely
to get thrown away. But excluding that pack does open us up to the above
race.

This patch demonstrates the bug, and resolves it by including cruft
packs in the MIDX even when doing a geometric repack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c              | 19 +++++++++++++++++--
 t/t5329-pack-objects-cruft.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index afa4d51a22..59b60cd309 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -23,6 +23,7 @@
 #define PACK_CRUFT 4
 
 #define DELETE_PACK 1
+#define CRUFT_PACK 2
 
 static int pack_everything;
 static int delta_base_offset = 1;
@@ -158,8 +159,11 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
 		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
 			string_list_append_nodup(fname_kept_list, fname);
-		else
-			string_list_append_nodup(fname_nonkept_list, fname);
+		else {
+			struct string_list_item *item = string_list_append_nodup(fname_nonkept_list, fname);
+			if (file_exists(mkpath("%s/%s.mtimes", packdir, fname)))
+				item->util = (void*)(uintptr_t)CRUFT_PACK;
+		}
 	}
 	closedir(dir);
 }
@@ -561,6 +565,17 @@ static void midx_included_packs(struct string_list *include,
 
 			string_list_insert(include, strbuf_detach(&buf, NULL));
 		}
+
+		for_each_string_list_item(item, existing_nonkept_packs) {
+			if (!((uintptr_t)item->util & CRUFT_PACK)) {
+				/*
+				 * no need to check DELETE_PACK, since we're not
+				 * doing an ALL_INTO_ONE repack
+				 */
+				continue;
+			}
+			string_list_insert(include, xstrfmt("%s.idx", item->string));
+		}
 	} else {
 		for_each_string_list_item(item, existing_nonkept_packs) {
 			if ((uintptr_t)item->util & DELETE_PACK)
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index e4744e4465..13158e4ab7 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -648,4 +648,30 @@ test_expect_success 'cruft --local drops unreachable objects' '
 	)
 '
 
+test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		test_commit cruft &&
+		unreachable="$(git rev-parse cruft)" &&
+
+		git reset --hard $unreachable^ &&
+		git tag -d cruft &&
+		git reflog expire --all --expire=all &&
+
+		git repack --cruft -d &&
+
+		# resurrect the unreachable object via a new commit. the
+		# new commit will get selected for a bitmap, but be
+		# missing one of its parents from the selected packs.
+		git reset --hard $unreachable &&
+		test_commit resurrect &&
+
+		git repack --write-midx --write-bitmap-index --geometric=2 -d
+	)
+'
+
 test_done
-- 
2.35.1.73.gccc5557600

