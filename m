Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E4C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382362AbiEMQXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 12:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382365AbiEMQXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 12:23:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8D35A98
        for <git@vger.kernel.org>; Fri, 13 May 2022 09:23:23 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c1so7386004qkf.13
        for <git@vger.kernel.org>; Fri, 13 May 2022 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4J5LMX1yNMmIaUjUsm+hB2mc6SVFaPrz5aHNvsE7yZU=;
        b=DEzOxKe4992Kn/q0rYBUl4rwtd8H6VjmjWdNGC1UuTtRpk20GWfwDB/TaFQYbESUrM
         ehPobTz91WtJsKp4aEDHIqrE58Ml5w1Qz3xDFH9elJy7HIOLVEHIK5WN7VczQO2Na0lM
         TpqKN3F1peVu+SbEI7MOuZIBKe5T1KdToDKW7Ph861Gu3i3lIRRMYPgRwSrJpTK3YJ6h
         vyOiwsiA3wGVu1Un8rlVyrSYKfSnibS/O6GsQGLBn23hLQ2Ut0jzH2GD9x9QJSZMfKVh
         gZ0Xglsdee5hT5wbUkZHIWw7TZ01i882jmGxnt4+DiHRBqz6Mq/OLRuiPm0Yfj/e93MT
         7XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4J5LMX1yNMmIaUjUsm+hB2mc6SVFaPrz5aHNvsE7yZU=;
        b=FzjOn1laQL1jRnOZ3P+xqioIWdJs3lphAYqOOJWKKZaEWim15lHwCcwlcXBWY6O8wr
         85NKPFpna01KzHL1N7Pwxsge9rdCdue0uckIUPbsYG4ZD1MFWQPVYH7V8ifT69BI77bH
         bcNC46da/pzJ5WV9jTGsaCZskafSTPCDAWlTdkNPmgVo7w13gpp41CHQWLA7XRHK+nwr
         H6/sTLrbPR/6UJaSaDdJWmaQk7X3zw8L7h24IrpxFjL55zzW2XaWIFeNoZgYcbaNzpb1
         JBtOA/yXiRbhuNso6Zjo/1i0zqx2p/QdtFKMXpE3j8KcludjWs3UdZ8OayetjcK/3c3g
         U++g==
X-Gm-Message-State: AOAM532WjJfFGV82ZbI4ElF+rHwNVXVvovDphCdNmIzGcrrM96kHQmgT
        x/OwM5heGE9guu3+dpZ0uXUdRw4L7W/keWSo
X-Google-Smtp-Source: ABdhPJxvoCGoBXmYWDxmom3EBPDaiYI0APcgaXLWl3acKao5aeW9uI2drnPPm4SZwLBMxMvwtd5qlw==
X-Received: by 2002:a05:620a:99a:b0:69f:8204:d8de with SMTP id x26-20020a05620a099a00b0069f8204d8demr4266786qkx.58.1652459002051;
        Fri, 13 May 2022 09:23:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i17-20020ac84891000000b002f39b99f684sm1781675qtq.30.2022.05.13.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:23:21 -0700 (PDT)
Date:   Fri, 13 May 2022 12:23:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH 2/2] builtin/pack-objects.c: ensure pack validity from MIDX
 bitmap objects
Message-ID: <bcc48004450769410d7e6d8a6e56f08bfa9a02a3.1652458395.git.me@ttaylorr.com>
References: <cover.1652458395.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652458395.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using a multi-pack bitmap, pack-objects will try to perform its
traversal using a call to `traverse_bitmap_commit_list()`, which calls
`add_object_entry_from_bitmap()` to add each object it finds to its
packing list.

This path can cause pack-objects to add objects from packs that don't
have open pack_fds on them, by avoiding a call to `is_pack_valid()`.
This is because we only call `is_pack_valid()` on the preferred pack (in
order to do verbatim reuse via `reuse_partial_packfile_from_bitmap()`)
and not others when loading a MIDX bitmap.

In this case, `add_object_entry_from_bitmap()` will check whether it
wants each object entry by calling `want_object_in_pack()`, which will
call `want_found_object` (since its caller already supplied a
`found_pack`). In most cases (particularly without `--local`, and when
`ignored_packed_keep_on_disk` and `ignored_packed_keep_in_core` are
both "0"), we'll take the entry from the pack contained in the MIDX
bitmap, all without an open pack_fd.

When we then try to use that entry later to assemble the actual pack,
we'll be susceptible to any simultaneous writers moving that pack out of
the way (e.g., due to a concurrent repack) without having an open file
descriptor, causing races that result in errors like:

    remote: Enumerating objects: 1498802, done.
    remote: fatal: packfile ./objects/pack/pack-e57d433b5a588daa37fbe946e2b28dfaec03a93e.pack cannot be accessed
    remote: aborting due to possible repository corruption on the remote side.

This race can happen even with multi-pack bitmaps, since we may open a
MIDX bitmap that is being rewritten long before its packs are actually
unlinked.

Work around this by calling `is_pack_valid()` from within
`want_found_object()`, matching the behavior in
`want_object_in_pack_one()` (which has an analogous call). Most calls to
`is_pack_valid()` should be basically no-ops, since only the first call
requires us to open a file (subsequent calls realize the file is already
open, and return immediately).

This does require us to make a small change in
`want_object_in_pack_one()`, since `want_found_object()` may return `-1`
(indicating "keep searching for other packs containing this object")
when `*found_pack` is non-NULL. Force `want_object_in_pack_one()` to
call `is_pack_valid()` when `p != *found_pack`, not just when
`*found_pack` is non-NULL.

An alternative approach to closing this race would have been to call
`is_pack_valid()` on _all_ packs in a multi-pack bitmap on load. This
has a couple of problems:

  - it is unnecessarily expensive in the cases where we don't actually
    need to open any packs (e.g., in `git rev-list --use-bitmap-index
    --count`)

  - more importantly, it means any time we would have hit this race,
    we'll avoid using bitmaps altogether, leading to significant
    slowdowns by forcing a full object traversal

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 014dcd4bc9..a243193807 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1357,6 +1357,9 @@ static int want_found_object(const struct object_id *oid, int exclude,
 	if (incremental)
 		return 0;
 
+	if (!is_pack_valid(p))
+		return -1;
+
 	/*
 	 * When asked to do --local (do not include an object that appears in a
 	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
@@ -1424,14 +1427,15 @@ static int want_object_in_pack_one(struct packed_git *p,
 				   off_t *found_offset)
 {
 	off_t offset;
+	int use_found = p == *found_pack;
 
-	if (p == *found_pack)
+	if (use_found)
 		offset = *found_offset;
 	else
 		offset = find_pack_entry_one(oid->hash, p);
 
 	if (offset) {
-		if (!*found_pack) {
+		if (!use_found) {
 			if (!is_pack_valid(p))
 				return -1;
 			*found_offset = offset;
-- 
2.36.1.76.g80c0bcd80e
