Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACA3C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiCCAWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCCAV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:57 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259613A1D4
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:09 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id n185so2749471qke.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nezjvj6pX053XZ+pGAlInOXtcc1BttqR7oLkcfBTFY0=;
        b=OrtRaOBzjf5KKzA8zC5cVb8CL5soOciU0kgtaSEogPqBeSDhmtPWyqd3/5ClZ3biXM
         8Uf5WDS7f++/4XPJDEuTJ9vHuS04lMUkKEpuOLc+0zL/qhwTsw0tzQd90SiabRd1ZbWY
         +u2QU2DMd1SG3l61cXHJFqXKlj7L2Ux2FSqJAWlp00qvcQTulAxiQku46MSMoRsHDYAD
         DKyhdOeTq8EjrUaIAIJhBHKpiuCI3ukS2sOfeU3hgRW2Y6/9pBzup5rkvoIseDQU7sRx
         OdBcGyLbee8jDuuKBpA/A0pORyK4p18Ku1oZwqjoO3OENBhahzuLXGdV8oiKlphXL+B7
         bKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nezjvj6pX053XZ+pGAlInOXtcc1BttqR7oLkcfBTFY0=;
        b=5t8rZJDpCCqmkNi8H7IKsUXl1x7acMjQafoG0H/HE9QRy3QQ2QUG/ExQn15LV+0ktO
         9OfgtXrfdgB5Wall1ODZRdDl2po4vr4ensJfX9EdytxazxbsWkfqYMP1bN0/8X6kZhz7
         PKc9S0HEK0hYQfPW2OE8iIQc/paaAWqcChE89bWNld/41l5KttGtwZnJqW0/iGVp88ub
         Dcrzg5vlMPU9vrwAfoaw+A+Et+1qFPJ4yFM+IP9Kzr1HlyZcAUb4wfeW35XsZohp76yK
         JNHsWSSktvgniJyt0AzpWxXUOgdIXHZwFuptQJeifFdV/DBPneOHXFgcNr+rLuk3M6yJ
         6fbg==
X-Gm-Message-State: AOAM533BAXbT6lld3vr2bvWYgfTSCmJ9HeJinoTsb98v4xP4RNj6gk2P
        kiRja2RbA1ZiN1JXpaBPU+YO2fsSo7IwTar5
X-Google-Smtp-Source: ABdhPJz1DIQrmUizp3uSNbk72lf+Xp5A8h9ajWXwYaBNuI1KdNc4qR6KgrpboKbALeZn2o7nnFAqSA==
X-Received: by 2002:a37:6615:0:b0:47f:3ac3:ceb2 with SMTP id a21-20020a376615000000b0047f3ac3ceb2mr18031036qkc.226.1646266868725;
        Wed, 02 Mar 2022 16:21:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm294769qkc.73.2022.03.02.16.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:08 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 10/17] reachable: report precise timestamps from objects
 in cruft packs
Message-ID: <fa4de8859d1c067d5773d023b1f434031abacc3a.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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

