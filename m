Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1298C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhK2W3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhK2W3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:29:11 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2AC09677B
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:42 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id w22so23623740ioa.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LS1rNUUIkXRDa/0uaRTlljweRbMliW6+/CFm0/WNrWg=;
        b=mAV/5CMWvmmfK2HZxbgcWb28hjqLZrZ7/e4IwHBRlcBYYliogZYC9zQfItvb2ol3TW
         4gGusKDWxYh1h5jsnrTMM5/UB27+3y7A/daZ6VlIP1bVGUbfQ9DTStBwBScohnVgPmx5
         o6CTHgpAYRrnvfsEVjPHoR98Y1/tKWnJU5yi0+zrB44SUCWM8DHKfu83rtB6M2MqRWC+
         awPZOwKgydFmaVIogaLQfaDcPXvrWCb2kpkRzzvHdOAWplMrmwhjdyL6lYioTQTj7ZfX
         XOsKE+z+D2nV6p+Jg63yObCmVQ1RBZ2hMMuKanxRSfAOPu8+L/C9O5G8Wm8NGhqRskOk
         0TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LS1rNUUIkXRDa/0uaRTlljweRbMliW6+/CFm0/WNrWg=;
        b=CVOEC+/FMtba84l9+eJUvuNqMTheHaKFGwiyhxtS9g8h0BIl5r3lFQPGiwGfUTRpOt
         giyaPhB61Wmdr6NvBQzxu3hq75n4xF78NrBDUMZ3+ycBri6dDeg0/vZ4+o664C8fwyS0
         dYi4oVlBLFlR2d742XRBoQs5TuAFdVflmzUxq2ZDj7HA3pFUacgIjSLaTggcsUW1KENM
         KPD9h9m7Fp1xqaji/xbaYx635ymPqmiyL0tKlch0VYhD1o7zSBgR1m6cHTWBRG7mB1hK
         bqqVMdfFRSuCgzGKT4Xq+zImrIfZ4RZK+d5oD7j7y5ss91GRHTdkNEoReDGBC7Hx8n64
         xXtQ==
X-Gm-Message-State: AOAM532ApsziPNOQQZjaQyhZRrQfW6/TT58McYPu1tFVzDPGNNRuJVVq
        y1qw1OU7iCzzfbYdQNcM2/g/8QwZXMq3qjFg
X-Google-Smtp-Source: ABdhPJyWX+38z3Agu0V/JJDmyxhuX4n8eaAB8x2DNfhLFkX9PtLzz3tHCSon+Is7orD28uo7wEGMew==
X-Received: by 2002:a5e:8f0b:: with SMTP id c11mr61277099iok.105.1638224741975;
        Mon, 29 Nov 2021 14:25:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y8sm8739117iox.32.2021.11.29.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:41 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 15/17] builtin/repack.c: add cruft packs to MIDX during
 geometric repack
Message-ID: <b2937ceda7ad1180f46b478f3d7c5a990e00c9cd.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
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
 t/t5327-pack-objects-cruft.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index cd4d789d27..5a201063e7 100644
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
@@ -559,6 +563,17 @@ static void midx_included_packs(struct string_list *include,
 
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
diff --git a/t/t5327-pack-objects-cruft.sh b/t/t5327-pack-objects-cruft.sh
index 750e9d6d6f..857f9e8855 100755
--- a/t/t5327-pack-objects-cruft.sh
+++ b/t/t5327-pack-objects-cruft.sh
@@ -594,4 +594,30 @@ test_expect_success 'cruft --local drops unreachable objects' '
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
+		rm -fr .git/logs &&
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
2.34.1.25.gb3157a20e6

