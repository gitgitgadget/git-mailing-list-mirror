Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8CBC433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiERXLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiERXLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B804FC6A
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:18 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id s6so2528048ilp.9
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MmehGJJuLil8k5aiAqhgYAM6WmGTkWbcsTe7mQcfQc=;
        b=bQoK7WmxCW/1aj2kakgp10bpNcwOSIVe2ANpFefOvAovv3Lc48QpH2HJJ1yH79yUIG
         b1sm65RwqRrgFTnT3s3AgQmeI0bxuU4Xvh69L47tceUKLGGzfjYHe1HKUd//shLZHoZ3
         oSdY5lD800hqFjVXJMloEq8aIlioYY/HAP+xuzcYhmXQiSBb3x67QBrU0ez1xAlfXBa4
         j6sJkMGOXwdWJvwRBD1XN2w9ZZ8KYnODt6Xf+7BaBfHgYosZTGeXdK32ClhCylufzpBF
         SWtgOLi2Yfk+wvSovGtNTbwDGsUEad38P1zMbfjQ112mP9R3F/gnnRInrK7oont30TFy
         Ttcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MmehGJJuLil8k5aiAqhgYAM6WmGTkWbcsTe7mQcfQc=;
        b=ycRodJnUT1tq4jWJ71XlSpn1LyjL7X+YQL42oe0Ra0uJJ1M16sdv6TSA1yshv1vkTr
         i+u+UT4I155ez02EhHxx7asibnFggEBrCpvN1aO5A9hb9X/Ebinh2HOzqqjUOasfYrSI
         yiToyv5V0aQB0nImQCNtVTG6bbzBO3kuS+gl7opLWDin3j9oCHnBJuMHaahlYGKs16uX
         cGFRYUp+HYrJq7MM6yxJsCq8d0KVFcjianB5dFrQBEZhSZVAwuPaEbj1NcM9ISudnD5a
         HZo1SHVlyXKBzqADJkjSk0aDbkNuSBq5DeOtvq2SwKx+UsXseltoeGNtltU3nW809a42
         8ABA==
X-Gm-Message-State: AOAM5306F0X1KYUCbTvAeBCFtx+yeQhArohvHtdyryA0ZiVNz7G+XApt
        IcIzjL3PX4z94uAmQUjZUREWcaWujK9phKOI
X-Google-Smtp-Source: ABdhPJyZz5El74usOBsf8z1he0I2KPV3vPKYwudNKcLABY6T1K7ba7JQIsf0N1RHz1YhpGbrKXZXwQ==
X-Received: by 2002:a05:6e02:1a8b:b0:2d1:2123:266e with SMTP id k11-20020a056e021a8b00b002d12123266emr1125763ilv.107.1652915478042;
        Wed, 18 May 2022 16:11:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c15-20020a6b4e0f000000b0065a47e16f49sm235295iob.27.2022.05.18.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:17 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 10/17] reachable: report precise timestamps from objects
 in cruft packs
Message-ID: <58fecd1747462faf323d861662f588590ece3376.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating a cruft pack, the caller within pack-objects will want
to know the precise timestamps of cruft objects (i.e., their
corresponding values in the .mtimes table) rather than the mtime of the
cruft pack itself.

Teach add_recent_packed() to lookup each object's precise mtime from the
.mtimes file if one exists (indicated by the is_cruft bit on the
packed_git structure).

A couple of small things worth noting here:

  - load_pack_mtimes() needs to be called before asking for
    nth_packed_mtime(), and that call is done lazily here. That function
    exits early if the .mtimes file has already been opened and parsed,
    so only the first call is slow.

  - Checking the is_cruft bit can be done without any extra work on the
    caller's behalf, since it is set up for us automatically as a
    side-effect of calling add_packed_git() (just like the 'pack_keep'
    and 'pack_promisor' bits).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 reachable.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index d4507c4270..aba63ebeb3 100644
--- a/reachable.c
+++ b/reachable.c
@@ -13,6 +13,7 @@
 #include "worktree.h"
 #include "object-store.h"
 #include "pack-bitmap.h"
+#include "pack-mtimes.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -155,6 +156,7 @@ static int add_recent_packed(const struct object_id *oid,
 			     void *data)
 {
 	struct object *obj;
+	timestamp_t mtime = p->mtime;
 
 	if (!want_recent_object(data, oid))
 		return 0;
@@ -163,7 +165,12 @@ static int add_recent_packed(const struct object_id *oid,
 
 	if (obj && obj->flags & SEEN)
 		return 0;
-	add_recent_object(oid, p, nth_packed_object_offset(p, pos), p->mtime, data);
+	if (p->is_cruft) {
+		if (load_pack_mtimes(p) < 0)
+			die(_("could not load cruft pack .mtimes"));
+		mtime = nth_packed_mtime(p, pos);
+	}
+	add_recent_object(oid, p, nth_packed_object_offset(p, pos), mtime, data);
 	return 0;
 }
 
-- 
2.36.1.94.gb0d54bedca

