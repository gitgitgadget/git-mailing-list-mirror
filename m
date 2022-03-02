Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A8C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiCBA7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiCBA7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:59:14 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C249E575
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:23 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i14so248089ilv.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nezjvj6pX053XZ+pGAlInOXtcc1BttqR7oLkcfBTFY0=;
        b=VKkfs93trlLvsZWxLFT6zxuWy1/PETHXEEWDyjWC5b5KVowXog5q05Kv6yII/vfiBT
         OWhzq7puqa6tciWXtHw6JkJnQsvfY72CizFTNjJA0idAUkQF2Q81DqbxZBFVJZaJRhkX
         wmKM7DCQjfUYg/5IS49BFJAjNEpfh/O1O7DzJGfm9NvBMqVpguM3K4C4xl+wCUrwCvK6
         /L6e0MZQDExdBVTHqIYNusYq236rOehopASUsd5e9iucBJzBE8SEY5t1f1jVH+rARwof
         R4EKck1E2yLavvSQvEtfS2/eJPmxZBOOuWZY+J8tAEQyrsllqRyFC2gLMNAGDFEZi9bS
         XWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nezjvj6pX053XZ+pGAlInOXtcc1BttqR7oLkcfBTFY0=;
        b=oA+Qtpci/QhOlvmoeJPVMvkDgEibaEa1uzucAF5bmNcpQUghvCiMUgqsIHZjFEXd9Z
         J/dd9nvHILO+gAljOpAlvkcVipVnGvLOgYRAsT/rHuXALuFK3Ifou6aNlrQnhTvRxt/f
         N8Ak9ky1U0xQczUzkagp2agBJ0WoU2/h5eEoQobtXFO0bNYamHvZEYAWr3T+Niobj1Qb
         Q3bA6qmU5dq9e+881ht+5cx0A8BHUewXTzi79SNSulDR9TPefxpoPFx+anDK4GjDCSSu
         7pMPvTOJABPcpRCtcTibJkJLweRecAr3eyNyKUqT9fWuipMyID0kFDvZSOgeEPDj9ymO
         zGNg==
X-Gm-Message-State: AOAM533gnOzlRaLTlXno57JfMyWqx7saaJcBOYo7OH0s7v2rZrfUYN10
        f311dAsdOGKbnlKCpZ5ku5AgwhZiNSAnlzWE
X-Google-Smtp-Source: ABdhPJxRV0wEF4DdRYgb4Va3EdMYLBvK1GFRV6Hd44EE9OwzSzhn+Cg0GFD+x2bCe74o1DwyBe/Uqw==
X-Received: by 2002:a05:6e02:1708:b0:2c2:7258:3e72 with SMTP id u8-20020a056e02170800b002c272583e72mr25605151ill.267.1646182703170;
        Tue, 01 Mar 2022 16:58:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q190-20020a6b8ec7000000b00638d75f5cd0sm8165633iod.47.2022.03.01.16.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:22 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 10/17] reachable: report precise timestamps from objects
 in cruft packs
Message-ID: <a8bde361f9b99abe90727959208413fddea602e3.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
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
index 0eb9909f47..9ec8e6bd5b 100644
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
2.35.1.73.gccc5557600

