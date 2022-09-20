Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F4BC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiITB4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiITBzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D224C607
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:49 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id w4so1100166qvp.2
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9VnZ1xqn5CgXSJSttk+n6n1EwpuOhTpSW7cIXhcQGd0=;
        b=MfcIRWYvNV+FRgUc6ufkVSgGaEFjsrsGq8qGpW4vZvrpNQlOswEDqDVdOEtglyp6KZ
         R9/i1QHqk5tgTp4/N4Qtg7F6YlzmOdzbaVUM9dMWGc+NSU5P5QM5xAAAyw2KMRx7Qm89
         LKB961yA0/Hxlqdovoiz0Bg/yGwA3Hnhm07NznjYd5MPRlDRitDIEaO4NmdgFBn63OQi
         eYkzHGnysPgZmxc401gHGbBawTzpOPQQH9aYaDjqV4YjcKrpGH6gr/nUpCaF+hdo7Lsy
         7K7ZBreSE6WRkGUDliOTHg+cufkfU4keaHeVhMrlTu0eGv3Ty5k1x6T04g7MNzp4iqak
         7pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9VnZ1xqn5CgXSJSttk+n6n1EwpuOhTpSW7cIXhcQGd0=;
        b=qwqn62JdZo6uuPZKxhZzT4Xkoy8LLoFqGbzwDv/qcb6G5BHnGNU47c/VD/EwqJBfNw
         Ynq+/9mNxJ++wIA7VmlwvsCuyGOz/GcIRdBxht/wvUKjH9LDnRp+hlCS6qBjbn1Klwj4
         tAxkBFgPXWB3ItcpN7O3/FDPc53hMKcFqMzBJVQe3H8dPh3QOcdFKB5P8NZjbLTX5CfK
         FCT3+kGHKkmxtXFB7QnS9zCW8PeXcanovIeIYCLRNf1IiFAJOa/ch5QPzKb76oerfwog
         GjA4olYX7M8f0v0iUmBAz0eoz+fDINrCsnvErmGp1D8mASdztnTI6qe31LlCJZaHu6Mg
         vqhQ==
X-Gm-Message-State: ACrzQf3IdZxx72oKQkI6oUBLz27dXvWagnwSopUObf8bbjiEVL6X7P7K
        O/+th3Wlf/TkVNIYMQ6x8kNj0WDwa3VLhg==
X-Google-Smtp-Source: AMsMyM5Z0tSjcVjrCl4SDbfqzmOJVk7ZJnmllXb8UIRJakL0xZ2jln0zVsfMyD2g8APU3RnOTbSGhQ==
X-Received: by 2002:a0c:a79a:0:b0:49f:583f:5292 with SMTP id v26-20020a0ca79a000000b0049f583f5292mr16951245qva.116.1663638949349;
        Mon, 19 Sep 2022 18:55:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u18-20020a37ab12000000b006ce7316f361sm42041qke.118.2022.09.19.18.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:49 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 4/7] midx.c: avoid cruft packs with `repack --batch-size=0`
Message-ID: <b3a70d486e8c163d57f8d1d1f156ca0196ae6d45.1663638929.git.me@ttaylorr.com>
References: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `repack` sub-command of the `git multi-pack-index` builtin creates a
new pack aggregating smaller packs contained in the MIDX up to some
given `--batch-size`.

When `--batch-size=0`, this instructs the MIDX builtin to repack
everything contained in the MIDX into a single pack.

In similar spirit as a previous commit, it is undesirable to repack the
contents of a cruft pack in this step. Teach `repack` to ignore any
cruft pack(s) when `--batch-size=0` for the same reason(s).

(The case of a non-zero `--batch-size` will be handled in a subsequent
commit).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      |  2 ++
 t/t5319-multi-pack-index.sh | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/midx.c b/midx.c
index bff5b99933..05bcfc6f02 100644
--- a/midx.c
+++ b/midx.c
@@ -1895,6 +1895,8 @@ static int fill_included_packs_all(struct repository *r,
 			continue;
 		if (!pack_kept_objects && m->packs[i]->pack_keep)
 			continue;
+		if (m->packs[i]->is_cruft)
+			continue;
 
 		include_pack[i] = 1;
 		count++;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2d51b09680..d967d92c20 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -784,6 +784,29 @@ test_expect_success 'repack creates a new pack' '
 	)
 '
 
+test_expect_success 'repack (all) ignores cruft pack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		test_commit --no-tag unreachable &&
+
+		git reset --hard base &&
+		git reflog expire --all --expire=all &&
+		git repack --cruft -d &&
+
+		git multi-pack-index write &&
+
+		find $objdir/pack | sort >before &&
+		git multi-pack-index repack --batch-size=0 &&
+		find $objdir/pack | sort >after &&
+
+		test_cmp before after
+	)
+'
+
 test_expect_success 'expire removes repacked packs' '
 	(
 		cd dup &&
-- 
2.37.0.1.g1379af2e9d

