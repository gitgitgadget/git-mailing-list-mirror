Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444CEC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiCBA7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiCBA7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:59:15 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC89284C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:33 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id m185so48700iof.10
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MEmXxd3UfEXLl/sVy5AcsqzJ2DK6P3effos5SpxBajY=;
        b=j9iww/4erxX9EGDqP8EvjhDuGhJVaS1CqiNmy52oIdO4nBzhyoLpyHnXrmQFp8rgjP
         3Mg0bIX1HYU4pIbwzr7RQNOSza/KXfzVTGEoA8pTU17AITD9H3xsvnCNyzhS/fTJvtZz
         S7bS1oBq1+LsmxfhQjKwOX7ZxOudwHQTn0RkBdfVh7qbedT0601dyltCGBLUloHY7eQ9
         BSNAeeOH31CIA1YJ3lsUy1UUPH4jbu11IPHue3WAl+bPATj0+mVAN550basqAYA3aYQr
         8JZa+ZxDqB6ZBUPJsaiIBDgcOayslpDRRZkmXMZTuakfzxIpvVnK8a8CXW1qyqtLVcf4
         +W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MEmXxd3UfEXLl/sVy5AcsqzJ2DK6P3effos5SpxBajY=;
        b=1XiJiKpFEy8dJPQX9CjfcBqVOSgb7TRG8WWQuKuuqHcZXHjxKBMHTEBjf+gDLiw29T
         SFLwbjdg/7CokDWvRUJua59CGwvCCWFVEixEkrlQ/nwVw2WfXw/oY3WyK5xA74AKan6R
         rphTE5lhc+KPwn3I57VORKjI9+Jt/6H7THH4yr6nfudiX9TCoZLil4BSLe8d/I+AfaDv
         6xHk+ocxeKUwhP4SeFahD1d4sjsR5D3Tja1bnE/itN/dX7kx95c/ytXzQ9wgFXYz0bJi
         7cAav39zXQ5mtLF3p/hr+ew/emFjJYs5pGlWZnIqVs2qXgMervZWOrvjM6azaZUjXkSj
         /aOg==
X-Gm-Message-State: AOAM532tipVrk8++6mSSruH4J5nWS5fREeXgx3+mFH3CfyY1ZL3Klq1b
        lAsC/pMTwTUVCu+sq4Ri0LfhEKt1hyJ2Fs3B
X-Google-Smtp-Source: ABdhPJxlwz8o55Qidd0x2csHol+M7oDPcB/v23Pf3bGW2zy/5gRtqY4cuCqw4R69aZfV5VW+w+tplw==
X-Received: by 2002:a05:6638:1382:b0:314:72f6:18d7 with SMTP id w2-20020a056638138200b0031472f618d7mr22766414jad.25.1646182712672;
        Tue, 01 Mar 2022 16:58:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u17-20020a056e02111100b002c2a943034esm8273533ilk.5.2022.03.01.16.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:32 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 14/17] builtin/repack.c: use named flags for existing_packs
Message-ID: <e6eee7f15c25a19e6b6c78aa1742df6d7b3d4faa.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the `util` pointer for items in the `existing_packs` string list
to indicate which packs are going to be deleted. Since that has so far
been the only use of that `util` pointer, we just set it to 0 or 1.

But we're going to add an additional state to this field in the next
patch, so prepare for that by adding a #define for the first bit so we
can more expressively inspect the flags state.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d61c78e94e..afa4d51a22 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -22,6 +22,8 @@
 #define LOOSEN_UNREACHABLE 2
 #define PACK_CRUFT 4
 
+#define DELETE_PACK 1
+
 static int pack_everything;
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -561,7 +563,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, existing_nonkept_packs) {
-			if (item->util)
+			if ((uintptr_t)item->util & DELETE_PACK)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
@@ -1000,7 +1002,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			 * was given) and that we will actually delete this pack
 			 * (if `-d` was given).
 			 */
-			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
+			if (!string_list_has_string(&names, sha1))
+				item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
 		}
 	}
 
@@ -1024,7 +1027,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (delete_redundant) {
 		int opts = 0;
 		for_each_string_list_item(item, &existing_nonkept_packs) {
-			if (!item->util)
+			if (!((uintptr_t)item->util & DELETE_PACK))
 				continue;
 			remove_redundant_pack(packdir, item->string);
 		}
-- 
2.35.1.73.gccc5557600

