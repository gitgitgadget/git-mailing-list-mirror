Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0698C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353145AbiETTCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353111AbiETTB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:01:56 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC26197F4A
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id eq14so7499345qvb.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zyz6Yw3GkMghOPW6YQl2A8Ep+L1zlk6nE0W8HBFO5Do=;
        b=W1okgsU9YM81YGCplYAmXcpD1SasaARZF8sAP6XJBaYunZTL+m3rNvR0rctRCDEHRy
         rxKLW0zzYeTldDkRdxquZxjqfAShSTKpX/cvvCnAseLsX8FAuCxyDz+mJemTi20UzPTa
         fbdkm6porwPXGQwyurfP83zWq4iTZnoOh3q7IsPGGrMwdBQBKVrYomJYz8g582bMaTba
         nNuxDMJL1EMxsbII8dpuUS3InusgwwAvoysPAV3Hk2jOKGobF3OZDocQLT7UwyWQMU6i
         PeKrA/cBOeEsl9HKkxQVRjnAailiU8hfXvR+g7tUcD9ksnbzURQgNxbvlD7/kAW+lOyK
         yJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zyz6Yw3GkMghOPW6YQl2A8Ep+L1zlk6nE0W8HBFO5Do=;
        b=rsDlEIAxtRRN9tgbcT0RzNA01BD/1MG17QEawbpEwGG9hyVBwPXuXn/t8UtiDe3vrp
         QC/YYaE+7WNiU0B011CwbGxksQkugrbj7VqdGZn9d6ZbV5VnCWvIpjdFAnou8MhSy9hj
         eB5iW8wcb96kdubkoTLaqwDgznLMMuFQ0lSwpTKT35WW404hKXsyUAf1puB8wwU9fHW2
         UAQK4F3xpdLXn9Bs7OiCDHdTfjJ4IW7hNH68AcC18zEwBmDdAjY3+GaqfMta83WCAF36
         Cm/nX8oeJpiVhKcwYFmS1PTky0ibubiffQuJ0OTVoH1LKuB3qa9kQrwzv/9IeG7Jul4H
         6YCA==
X-Gm-Message-State: AOAM5326gDBLMBkg5eDEvx14WTFphD2hOadYijyT/Yqvk2ICFfuh2hAQ
        KAKGq7diR5McisaafATg03GWERsAc2Bu1eLq
X-Google-Smtp-Source: ABdhPJwAe2jHlKUMCuXu0WpQk8hYcojCBQqEnkHWJVk8FWo8FonNm/rjRPomAHRBhBWRL4R5tYb7jA==
X-Received: by 2002:a05:6214:ac3:b0:461:c492:d628 with SMTP id g3-20020a0562140ac300b00461c492d628mr9135488qvi.68.1653073313439;
        Fri, 20 May 2022 12:01:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c19-20020a05620a165300b0069fc13ce1e5sm158619qko.22.2022.05.20.12.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:01:52 -0700 (PDT)
Date:   Fri, 20 May 2022 15:01:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
Subject: [PATCH 3/3] builtin/repack.c: ensure that `names` is sorted
Message-ID: <a3d25b9e5dda9a999597115933bf0ce70dce51b2.1653073280.git.me@ttaylorr.com>
References: <cover.1653073280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653073280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch demonstrates a scenario where the list of packs
written by `pack-objects` (and stored in the `names` string_list) is
out-of-order, and can thus cause us to delete packs we shouldn't.

This patch resolves that bug by ensuring that `names` is sorted in all
cases, not just when

    delete_redundant && pack_everything & ALL_INTO_ONE

is true.

Because we did sort `names` in that case (which, prior to `--geometric`
repacks, was the only time we would actually delete packs, this is only
a bug for `--geometric` repacks.

It would be sufficient to only sort `names` when `delete_redundant` is
set to a non-zero value. But sorting a small list of strings is cheap,
and it is defensive against future calls to `string_list_has_string()`
on this list.

Co-discovered-by: Victoria Dye <vdye@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c            | 3 ++-
 t/t7703-repack-geometric.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ea56e92ad5..0e4aae80c0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -856,6 +856,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!names.nr && !po_args.quiet)
 		printf_ln(_("Nothing new to pack."));
 
+	string_list_sort(&names);
+
 	for_each_string_list_item(item, &names) {
 		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
 	}
@@ -896,7 +898,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
 		const int hexsz = the_hash_algo->hexsz;
-		string_list_sort(&names);
 		for_each_string_list_item(item, &existing_nonkept_packs) {
 			char *sha1;
 			size_t len = strlen(item->string);
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 2cd1de7295..da87f8b2d8 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -231,7 +231,7 @@ test_expect_success '--geometric chooses largest MIDX preferred pack' '
 	)
 '
 
-test_expect_failure '--geometric with pack.packSizeLimit' '
+test_expect_success '--geometric with pack.packSizeLimit' '
 	git init pack-rewrite &&
 	test_when_finished "rm -fr pack-rewrite" &&
 	(
-- 
2.36.1.94.gb0d54bedca
