Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47EC433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhK2W3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhK2W24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:56 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E7C096771
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:29 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id m9so23674457iop.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=69TcDT5IlFADPKCncZviADdfxq5uUG4jTWHt5ZZBelk=;
        b=m0q04MJl5e8nWfN2zreooFIYhVDwv86D8W4zvoztOoX7V8HlASgwNYVfqu8ZfgNmCX
         XOzf0w5KfetL/aaLr0AG0rElYo8WcriP/QzoNGc+KhAvW2YOXH4h8C8X/n4iIsvrIxzj
         xRdeOMmEVIY9tJomUTnYJorPUI7SlOeliVBScoJ3n1TYUsh97ajnizzOM2rfWl3Kbqvj
         5pESAGsn+cxJa3EC8Os+pNrMugrx33N0BHKHomcgbdJnhZSWTWHuWK4MSEi4+PpB5pW5
         HJ4wxsU4aD9n7dPLxKqQk4P2v5iUiv68xJnFsq2PyM8AmgLBD2KFTMlX2FRVt/n0rCtN
         giWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69TcDT5IlFADPKCncZviADdfxq5uUG4jTWHt5ZZBelk=;
        b=wntGgvd8uzcYxArb9N3LOJcrPEG42edPCHMS7naQ0floPKj6OlgDfVdzKb1/wDc0oj
         k4m55CRYhS+dwcHQ1hsLqVAjUyLk+4TnOhgibx1GcSjVA6wHyKW9zrakJMUb8Z4E5doB
         4SGeyEEv/MuGg+P7lPva3FCejs5GCNERfdDuFU4sEvYFHcmjf8USYtcdqgG8TNoLMIw7
         5QJ+7OGbtd4cEkIk24Mlw5deIG37pEzeyC4lneDmTYdoXg20EQDBPB7S9ZJAw9rD5u5F
         0cRFyfZ8mtimrCVOHDATWXhrsa7VsPPp11G9IF+hREnrkrGR3x/YqQ3BCJSEQh78xTO6
         jQGg==
X-Gm-Message-State: AOAM533PuNdB0DKavI6yYaG1qu/yCkm8sxwdB1E6x5HsPfCNV4vqZklu
        cXt1acb1c0SSrLtE/W/7Rqqg6N7QxjpMzVJX
X-Google-Smtp-Source: ABdhPJz6o9Tl/4Tz9f7w9sg3b4uT5vwc1trU1aqLqRzApRyDrY7ZhdLXpUTcf80h6G1NgiNJ+PrYoA==
X-Received: by 2002:a05:6602:27c2:: with SMTP id l2mr60478240ios.147.1638224728869;
        Mon, 29 Nov 2021 14:25:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q8sm9978046iow.47.2021.11.29.14.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:28 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 10/17] reachable: report precise timestamps from objects in
 cruft packs
Message-ID: <52e9ac571070154e4669b7f5f68685ccdb9e5337.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
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
2.34.1.25.gb3157a20e6

