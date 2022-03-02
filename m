Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E4C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbiCBA7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbiCBA7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:59:18 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBCD90268
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:35 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r8so135943ioj.9
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BOC5DUwQBSar7jUJrq+622ol1tE8O3U8tCSOTGdW45w=;
        b=j6XHLLMDlevPfBQqMEJRUcmc1tPTHWBoDYqbQNMQ4VK4Pinj4mp4oxNvtm70iU0izr
         gEJRMBAzLnIXduGLHW1wm2ouSc38mtIuwYOI7y55UiMQn2P+7pNXv8ZL3pV2ItNA2xw9
         Mz/lpRDDBbHrUdvPhYP+pt+RtK9xILcNw+Sh/5F9THJXCr+S+3JrdTe+nWC+EKwKp4Kj
         a9fIDMMDEeVhBKgYLsC12B9abDVQ3IhZjIUgcr13TsXAB+6Xcei2nnnkdPTF9CE0iquJ
         G3erjo83K/K8ZN8FqgLMTqhHYDaVfHZpqfEYxJsBLjuLmEsRsmAhKw473iCAVl1F41cu
         0HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BOC5DUwQBSar7jUJrq+622ol1tE8O3U8tCSOTGdW45w=;
        b=Df2bnEH5QVNfDrIIRwDGPZs64FtnLZW1sttGUdz1yCAitxp0F6eEbvoLzTFAR87ipw
         blCKwXWeJge++fzbku9msVHtG3QRNPOY+AB+bT7FC4VTG5jy6WpTK84HhzIYYE1BBpRx
         jGrjh90ie786LBX6yoy+l1VtH4/bYhcfThO2yqJfJpvQ3u9dYJ27DR3BJnoAUQE1/6Fw
         wNpbdRb/LtXQA0nwn++2k8dEqTv29eLoLRIHtRbU+L+OVuefoCq0N8Wh6iqLb4xDgS6r
         wEAmXWG279+FKOgLb1Frsq1Z9DIl4tkaTp+IWZnFXRucTP0S7I9Ld7Nm9eeoMw9MZyd6
         iyjA==
X-Gm-Message-State: AOAM5338m+u9uliPlB4KUlko7/NwHQQfxSsS8MXwezYqao5amOO8T+t0
        DekB/D3LFoo5qqAquXMnwQPK0PXrscs9sme1
X-Google-Smtp-Source: ABdhPJwPPwKEx45lpoGcap7zQ89wwZ5x2MX9wMSCxN0Q8rO4Y/cQBjJOaHN7j0ry4Meqg61uZL+Zvg==
X-Received: by 2002:a02:7742:0:b0:311:626c:d554 with SMTP id g63-20020a027742000000b00311626cd554mr23210247jac.134.1646182714971;
        Tue, 01 Mar 2022 16:58:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v23-20020a056602015700b006409f5261a4sm8010899iot.40.2022.03.01.16.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:34 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 15/17] builtin/repack.c: add cruft packs to MIDX during
 geometric repack
Message-ID: <b09dbc9fe5f02b07f4b20503c4d8f427c6edb6fa.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
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
 t/t5328-pack-objects-cruft.sh | 26 ++++++++++++++++++++++++++
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
diff --git a/t/t5328-pack-objects-cruft.sh b/t/t5328-pack-objects-cruft.sh
index e4744e4465..13158e4ab7 100755
--- a/t/t5328-pack-objects-cruft.sh
+++ b/t/t5328-pack-objects-cruft.sh
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

