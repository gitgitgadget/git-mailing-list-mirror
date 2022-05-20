Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E5EC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354056AbiETXSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354064AbiETXSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F0E1A8E0C
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 11so6618715qtp.9
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h5cliPK5GLpDE1WKdbHy7c35ftY6ucxJfIgmX8MSY+Y=;
        b=VrNSECodeYwc64Q7SpGFMX3MMl1CGOwN5E5aQNVN7wW5g8N3oReLU1Glrp8c2EM2dj
         /+77yqSnZCBLADFFltM9hxa2RfihEXxefb6XH9NNdE0Lz6buZyKOPGXwx1iEWTZbxOLl
         8JqpjDU48+KZkoFwpqdXw70RZxOzKUWhWX9jZaxcVs2HjbLfqqaIpUGO0HrfQKlVcjf+
         SSgNiJfrhB/Me+suTdYmalsh0mF4nQr2LspmBe2DFyI2VoJF7S408WdOK+plLaVDVhH9
         Ckworm0RbrrqzKa3huqws0mXZgdAXnmRDLHSZ3Hivo8G4XgrmOqGeXcw6Ns8XHnNNqcq
         jScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5cliPK5GLpDE1WKdbHy7c35ftY6ucxJfIgmX8MSY+Y=;
        b=S2hioNE04m0AntwPT0IX+IWp+nGFJEbaSo6pkj+agWlJtjr+2PNLYsi67+ett/6+ed
         b3DPOXMI3Zv2ZGJ16drzwhNjNg5kt7qhOaCb3PrE88LgAqSPBQ/eSzpddsuKjAcN0aZ4
         Rl/XFHIp6W6yrRSLifuTQ725wAfLgRgJg91z2n78wCjmyC73gCI8BNQUgNp2qJi7XT06
         CX9eDhb9gTvElcvV+nhEG7faKZEzfSFq+of4k6vcbukXLmiKp9rf/xznhjhA6IcK3xao
         asAo1iZ8izQiwUgVvEFoTvrh3HtXpbaVn+rMcbYJuKOhaBqloOvV8uOUDqRRS36sEk59
         Jg0A==
X-Gm-Message-State: AOAM532cun5hP3jacAWF4A0msOiAXBxOfwZ9ZTxcySOAglWT/wQ/c84x
        +WOvnFlX/0JvcbvBU4EEDUv1Yu/Tfp1y1PHN
X-Google-Smtp-Source: ABdhPJzdi4lqsTKGxXPvgZSTIGPNRtQ6J8ZEUKCfvt525ITYKDeInph9ZuZkLFI6y7zptBQQYQ+EZQ==
X-Received: by 2002:ac8:5714:0:b0:2f3:b4b0:6fd6 with SMTP id 20-20020ac85714000000b002f3b4b06fd6mr9287780qtw.651.1653088693001;
        Fri, 20 May 2022 16:18:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 7-20020ac85647000000b002f8f547d12asm478838qtt.32.2022.05.20.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:18:12 -0700 (PDT)
Date:   Fri, 20 May 2022 19:18:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 15/17] builtin/repack.c: add cruft packs to MIDX during
 geometric repack
Message-ID: <e9f46e7b5ed6564f5eb6988038bb34df4d2ad2ca.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
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
 builtin/repack.c              | 23 ++++++++++++++++++++---
 t/t5329-pack-objects-cruft.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 36d1f03671..15071fadbe 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -23,6 +23,7 @@
 #define PACK_CRUFT 4
 
 #define DELETE_PACK 1
+#define CRUFT_PACK 2
 
 static int pack_everything;
 static int delta_base_offset = 1;
@@ -159,10 +160,15 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		fname = xmemdupz(e->d_name, len);
 
 		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
-		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
+		    (file_exists(mkpath("%s/%s.keep", packdir, fname)))) {
 			string_list_append_nodup(fname_kept_list, fname);
-		else
-			string_list_append_nodup(fname_nonkept_list, fname);
+		} else {
+			struct string_list_item *item;
+			item = string_list_append_nodup(fname_nonkept_list,
+							fname);
+			if (file_exists(mkpath("%s/%s.mtimes", packdir, fname)))
+				item->util = (void*)(uintptr_t)CRUFT_PACK;
+		}
 	}
 	closedir(dir);
 }
@@ -564,6 +570,17 @@ static void midx_included_packs(struct string_list *include,
 
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
index c82f973b41..8de87afce2 100755
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
2.36.1.94.gb0d54bedca

