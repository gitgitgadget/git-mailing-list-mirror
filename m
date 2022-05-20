Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D0EC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiETXSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354042AbiETXSA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41747197F4F
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:59 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x7so5667777qta.6
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MmehGJJuLil8k5aiAqhgYAM6WmGTkWbcsTe7mQcfQc=;
        b=jvxbIMQQyU/Cn0EaauIeWcWpVJdTwAkki1In2o53qYocmEwmT55xiWfMvyx7/lJkgu
         oPQvfQ8iSkk4lUwpev5nzt4LuND/7ymx3IHwCOP0QzT0RxfZfv+snn9aOOL85Z3Kw7/S
         /1ryTJoMKZvgBD8692cmxjkKEW82Bi+jTTqwb881f70NVm8qkyvQEiiAIYX0Bu7Owvin
         hmIDMIFCC70gKyyC1cZWcSSQLYA+Neu2wds2ZAxPqzAMK+sc3teHBflEWgEWqc0OC7Uk
         X8rCBmqoOY3YUsKwYYUDt3ns+4QdbMMt+SdFo82ncqHyqQtJzKn3BPnUjBKA8+OLnL1L
         TUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MmehGJJuLil8k5aiAqhgYAM6WmGTkWbcsTe7mQcfQc=;
        b=czWWMZpuTGbmnd5xMz2EmimksFOD/JkUxZAEDEitiLAp/fpU1A7F1BBk6kW3pmCzcq
         4dHC4+ol/oKkTR/LgZbyUWSf9n0N5b6hD0mT/6s0T8By2NU2zkVhbHS+OFRhdEKVJBuN
         slXFSp1LnWy10FIHx+OA2I6zz3J7jCAJYJ/7sg4aJLv+nwG2CsdBzExjYd6aam7V25R0
         FXgzIf2MrmQd8Dg+UpSamOF3IUCq13maQ09QXtUuASe78phMlOyFUfpz41CCgP+YwriC
         ozZgfT5kpzUEDyfHbK2UXke0PeNpO01LePW7oGrblmWaw+ht78KKFc/RXCELSeLN1xvn
         8JPg==
X-Gm-Message-State: AOAM531z+IEehC7/5Dqc5HxHA9aQWw+mvWoi5Iq77W+XOLAp83/7Lcia
        ThomEyMfnDqtxwTTz3epD49jnHhbkWp4JT8Z
X-Google-Smtp-Source: ABdhPJxqhjSVCC4R7h8yTqy6e9v3QJRcPBx7xK3drARKymsYMESop++b6csM8bGdQ0X1ScrZXGcyiA==
X-Received: by 2002:a05:622a:147:b0:2f9:2ad3:1209 with SMTP id v7-20020a05622a014700b002f92ad31209mr1314858qtw.388.1653088678775;
        Fri, 20 May 2022 16:17:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a16a100b0069fc13ce23csm394228qkj.109.2022.05.20.16.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:58 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 10/17] reachable: report precise timestamps from objects
 in cruft packs
Message-ID: <d66be44d9a08bb97761b8eb23861caec638025e3.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
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

