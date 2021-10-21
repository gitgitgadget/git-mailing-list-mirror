Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC80C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E80160E8C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJUDmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhJUDm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:27 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A933C061755
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h27so18620794ila.5
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hhdlekp2cDi7IiVFDVmGe3w45HGV5elE1mgOJVNzEDA=;
        b=ObgTsbdNZmhn7IOspp1AAmPNaIHLg/MA92G00oQoiP/MT+Dwb14f5QuVxVeaFraD9k
         SAwYaTxAO5yW/OlW6bL1/OwpnZyx40+vlwOgJSFT7uaGWdNShkfSjcHb6+p8L0NPgxsv
         bOwkfQ+zeRlSI0hjHKViEhM3nCQ9juzywgdELCjVftZE0LzV+QrdwjUAjS06bJ+5yHJd
         ex04PrD2jXDL9lZj8Gbu+5ZbvObS9YCweUDYFjuhbJ+mVReoCvPt6PWhPivpJdOOaQ1v
         c5FVtbe0t4FuQNVEd8E16aD36dArybx+3/0Y/LdOk9QGhRQ8C9UmpvXpTI6CiOAbzQTO
         2nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hhdlekp2cDi7IiVFDVmGe3w45HGV5elE1mgOJVNzEDA=;
        b=6Dohr4bqX7oN6NBTSZ1OZYXDwE1WCZ5WNcn6klkH/wUBX/7/riaFtxJWFZ1LWDfuJY
         GVe/tv15jcdrFVpdUNLFPTRjvV3fJ7EiKNnA5flp0vNi3VAYUrQsy7tIvZ+yK2sqXip9
         kxtDPSjYZJWuYDo8AlGA1KGwVdYpaMMIY52iboAOd+ibq2348RNpy8rjLtK+k0DbNyxx
         TnYfuc+VSM/vwyi8oaAg7ymNy78CPbohUPQGXGmLCUj6f2mNVQSRURDZzmM+8Ej3oYik
         R2WBzVuRmBnt26HOGrb36VcUKGBwl2dLwWsMPi5BillNGYX8paBnkjlAPhMqrGJukpth
         4RxQ==
X-Gm-Message-State: AOAM531TjOKoWNrW37uGQKbC5on4FfSCHZ0/vdjhPkeAR/uPyQMWBMsg
        4bE180DfsU5tXo6ZxS+ZelB65YLusxs=
X-Google-Smtp-Source: ABdhPJxjy5TJ4XEXNCO7y8WwvIlYeIS9/sAkoTOwmZI2UCx4ezpwuld0fyAw93W7f4VLK2uEgasuVg==
X-Received: by 2002:a05:6e02:1b01:: with SMTP id i1mr2026716ilv.157.1634787610705;
        Wed, 20 Oct 2021 20:40:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay5sm2414302iob.46.2021.10.20.20.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:40:10 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:40:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 10/11] pack-bitmap-write.c: don't return without
 stop_progress()
Message-ID: <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
bitmap writing, 2013-12-21), we did not call stop_progress() if we
reached the early exit in this function.

We could call stop_progress() before we return, but better yet is to
defer calling start_progress() until we need it.

This will matter in a subsequent commit where we BUG(...) out if this
happens, and matters now e.g. because we don't have a corresponding
"region_end" for the progress trace2 event.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 9c55c1531e..cab3eaa2ac 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -575,15 +575,15 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 	QSORT(indexed_commits, indexed_commits_nr, date_compare);
 
-	if (writer.show_progress)
-		writer.progress = start_progress("Selecting bitmap commits", 0);
-
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
 			push_bitmapped_commit(indexed_commits[i]);
 		return;
 	}
 
+	if (writer.show_progress)
+		writer.progress = start_progress("Selecting bitmap commits", 0);
+
 	for (;;) {
 		struct commit *chosen = NULL;
 
-- 
2.33.0.96.g73915697e6

