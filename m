Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20CBC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 02:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJRC0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJRC0K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 22:26:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C4E7AC3B
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:26:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 187so10692958iov.10
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEwPP1FZGTvvLJ41eQcVJtu7MNiwWqplM/jyYPIbbz0=;
        b=Plvy4+warJB2mRaPkhFO6lxx3sI6U3KHVgZ1NamLJjJgcvZp6FPj+cR5xMA2+8s0rQ
         8v3kwlS3A0WFUz9iEjpjh6y2o5879YDxH4l3jhkGwTflFaZqcksG1s7tT/sQyWr2lJf4
         j3f9gzaQulB/hJ3XadU9vMAeLJsOW8mVePgCSBDXSVOuDXg5zUiC97iNaNCTeQgGD5Oz
         q94A9Xy2KwPmkFR7pDJWyebQULy3joTSqwldUioSIiKVEvHndmMhvjotxVCi8RViSmX2
         arIoeD72PnCWM09PxVLY6BX/S26iS47+yzYRCpSD8SSe5tJhSgKqBKjsp9O6j3przQsg
         PtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEwPP1FZGTvvLJ41eQcVJtu7MNiwWqplM/jyYPIbbz0=;
        b=VbfbwU/+n++jGUT2ff5pixrZoRwujco4qaRyA3T8xhmWNxsb+wrD3DRms/nf/Po3Zd
         fiuqAQO7OpoMJzUlD5U7TfSx2VcAZb3QRg/QS9zg95mFTmQcRH03JsFNujMtRXsRzuXm
         bGdY19jhCrLJKNgpqfSwa0TesOZjsmRsFQ+/z5qCHxfpc3Iqubu1O6BLIj+pAtmdC0ay
         KG36PhLuUh9tAXp4VeQGkO6V6w/ZmYvOTJGdWgJFI6cYsYVvf79XMpLl9PfayxCralHv
         WSlM/T3PziWaoU2Tos4MDl0EN0vun0+JbWLvgTzAPJshW6mXvlRiOcgkrflXyTgd2Tgj
         fOYg==
X-Gm-Message-State: ACrzQf1JMbgfotScnTk7MM9kUdRiILDKiQxcc9mnUtviacUnRFbFx5g+
        MdGVvoow0z8FrwoLcjrrMZqOI7TNtqXZqqU2
X-Google-Smtp-Source: AMsMyM4t0sMdsPV/gwL1xY5/BodmuJJ907BNAkzqjM1LpH4OB+pmGsChr8ySthHRyDnLlwRcNDUwqA==
X-Received: by 2002:a02:94cf:0:b0:363:4a26:8cff with SMTP id x73-20020a0294cf000000b003634a268cffmr781173jah.286.1666059967992;
        Mon, 17 Oct 2022 19:26:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y3-20020a92c743000000b002e988fe84d1sm506325ilp.58.2022.10.17.19.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:26:07 -0700 (PDT)
Date:   Mon, 17 Oct 2022 22:26:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, peff@peff.net
Subject: [PATCH] repack: don't remove .keep packs with `--pack-kept-objects`
Message-ID: <6a012cd625c1d197ede91c85299cbfb37adf356b.1666059872.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git repack` supports a `--pack-kept-objects` flag which more or less
translates to whether or not we pass `--honor-pack-keep` down to `git
pack-objects` when assembling a new pack.

This behavior has existed since ee34a2bead (repack: add
`repack.packKeptObjects` config var, 2014-03-03). In that commit, the
documentation was extended to say:

    [...] Note that we still do not delete `.keep` packs after
    `pack-objects` finishes.

Unfortunately, this is not the case when `--pack-kept-objects` is
combined with a `--geometric` repack. When doing a geometric repack, we
include `.keep` packs when enumerating available packs only when
`pack_kept_objects` is set.

So this all works fine when `--no-pack-kept-objects` (or similar) is
given. Kept packs are excluded from the geometric roll-up, so when we go
to delete redundant packs (with `-d`), no `.keep` packs appear "below
the split" in our geometric progression.

But when `--pack-kept-objects` is given, things can go awry. Namely,
when a kept pack is included in the list of packs tracked by the
`pack_geometry` struct *and* part of the pack roll-up, we will delete
the `.keep` pack when we shouldn't.

Note that this *doesn't* result in object corruption, since the `.keep`
pack's objects are still present in the new pack. But the `.keep` pack
itself is removed, which violates our promise from back in ee34a2bead.

But there's more. Because `repack` computes the geometric roll-up
independently from selecting which packs belong in a MIDX (with
`--write-midx`), this can lead to odd behavior. Consider when a `.keep`
pack appears below the geometric split (ie., its objects will be part of
the new pack we generate).

We'll write a MIDX containing the new pack along with the existing
`.keep` pack. But because the `.keep` pack appears below the geometric
split line, we'll (incorrectly) try to remove it. While this doesn't
corrupt the repository, it does cause us to remove the MIDX we just
wrote, since removing that pack would invalidate the new MIDX.

Funny enough, this behavior became far less noticeable after e4d0c11c04
(repack: respect kept objects with '--write-midx -b', 2021-12-20), which
made `pack_kept_objects` be enabled by default only when we were writing
a non-MIDX bitmap.

But e4d0c11c04 didn't resolve this bug, it just made it harder to notice
unless callers explicitly passed `--pack-kept-objects`.

The solution is to avoid trying to remove `.keep` packs during
`--geometric` repacks, even when they appear below the geometric split
line, which is the approach this patch implements.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
We at GitHub had a slow stream of repacks that removed the just-written
MIDX.

This had mostly been a mystery that didn't occur at high enough volume
to justify looking into. But it went away entirely after merging in
v2.36.x, which contains e4d0c11c04.

Some investigating with Victoria today led to the patch above, which is
still relevant since e4d0c11c04 papers over an existing bug.

 builtin/repack.c            |  5 +++++
 t/t7700-repack.sh           | 24 ++++++++++++++++++++++++
 t/t7703-repack-geometric.sh |  6 +++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..f71909696d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1089,6 +1089,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				strbuf_addstr(&buf, pack_basename(p));
 				strbuf_strip_suffix(&buf, ".pack");

+				if ((p->pack_keep) ||
+				    (string_list_has_string(&existing_kept_packs,
+							    buf.buf)))
+					continue;
+
 				remove_redundant_pack(packdir, buf.buf);
 			}
 			strbuf_release(&buf);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index ca45c4cd2c..df8e94d7a8 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -426,6 +426,30 @@ test_expect_success '--write-midx -b packs non-kept objects' '
 	)
 '

+test_expect_success '--write-midx with --pack-kept-objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit one &&
+		test_commit two &&
+
+		one="$(echo "one" | git pack-objects --revs $objdir/pack/pack)" &&
+		two="$(echo "one..two" | git pack-objects --revs $objdir/pack/pack)" &&
+
+		keep="$objdir/pack/pack-$one.keep" &&
+		touch "$keep" &&
+
+		git repack --write-midx --write-bitmap-index --geometric=2 -d \
+			--pack-kept-objects &&
+
+		test_path_is_file $keep &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
+	)
+'
+
 test_expect_success TTY '--quiet disables progress' '
 	test_terminal env GIT_PROGRESS_DELAY=0 \
 		git -C midx repack -ad --quiet --write-midx 2>stderr &&
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index da87f8b2d8..8821fbd2dd 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -176,8 +176,12 @@ test_expect_success '--geometric ignores kept packs' '
 		# be repacked, too.
 		git repack --geometric 2 -d --pack-kept-objects &&

+		# After repacking, two packs remain: one new one (containing the
+		# objects in both the .keep and non-kept pack), and the .keep
+		# pack (since `--pack-kept-objects -d` does not actually delete
+		# the kept pack).
 		find $objdir/pack -name "*.pack" >after &&
-		test_line_count = 1 after
+		test_line_count = 2 after
 	)
 '

--
2.38.0.16.g393fd4c6db
