Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339B4208CD
	for <e@80x24.org>; Mon,  4 Sep 2017 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbdIDW5r (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Sep 2017 18:57:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34492 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbdIDW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2017 18:57:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id r75so1503333wmf.1
        for <git@vger.kernel.org>; Mon, 04 Sep 2017 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UlTey3xFowMCg4HNeAu+x4HSrZzSggNHlFKG4MOARJk=;
        b=KOKnZD+poMJ2NMJ3+iulBfTDuVdXHEoOKzzCbXLLJQwl1Ir14EefM5/rLHJ1TDbr+z
         2cDjSNXTeoR3KFWIZBdeprEBM7cdzvwQ51fq9TdayLmrrer5q0rTAKFqyo+hd+mdUST2
         t/nGPbt8zrHu0HZF6N3yQOi0T1RcNJ1UNaOS024X9RXg/kdYTxgi3QV/Bb9CeZ2BTYIR
         DwXo4vqKODgZxl2McCzNrCwpwKHMsObKqflB5SfZTB1gbJiLbreok4v5q2vM5NWwO7Mq
         yiBNb+lQ/Q7vds8folXHDpnJ/Ynkuo+gSTEYkiobIgsxCId8IasNYr2tTzcopD6hqCc+
         xH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UlTey3xFowMCg4HNeAu+x4HSrZzSggNHlFKG4MOARJk=;
        b=GXWx6VXSsLapYQU5fzu2yJ0sc3JYd0G5JYMzdwUnqDvMKFzIERhSE5UFNDeD0onjos
         jpAGiLbN7Kroy4EbQPAP1db6IHlJ7tt0RFGspFT8jAIJlaQ9ZGNFih/rPPLIljUXw2S4
         o1DhW/PCC7yHmmCFQwE7rl/+omLtD8DqO4Vz67VXK9ohT7Tgww0uPer84H7sTI/bY5QW
         lfI+flYjxhCvwf6MRUhxo9MonAm955OdEvt9evuOWeZHItsneLOuj/F+++t/q2nEXVj7
         ZjY9objenBumtMtmvakmhr8CmThhPC+0qM0m+oCFznei9a2/hdPH3bnUusrkFv4kAjbL
         rAvw==
X-Gm-Message-State: AHPjjUg1q0fT3xV/1YOe2Ca0D02FoM+HoBivjUjhO7Uwo2z3AhWAgake
        fAQaPUuDLpTJgwlrXFw=
X-Google-Smtp-Source: ADKCNb6yH0Eto12D3PjYsrjTXdfC09TkjVDiBdGbKZjPaEDE1rh4DDtJPkcfX+CKkHubwvUYEq0zNQ==
X-Received: by 10.28.62.65 with SMTP id l62mr1531332wma.47.1504565865374;
        Mon, 04 Sep 2017 15:57:45 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id p65sm1950834wmg.44.2017.09.04.15.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Sep 2017 15:57:44 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] read-cache: fix index corruption with index v4
Date:   Mon,  4 Sep 2017 23:58:06 +0100
Message-Id: <20170904225807.22139-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ce012deb98 ("read-cache: avoid allocating every ondisk entry when
writing", 2017-08-21) changed the way cache entries are written to the
index file.  While previously it wrote the name to an struct that was
allocated using xcalloc(), it now uses ce_write() directly.  Previously
ce_namelen - common bytes were written to the cache entry, which would
automatically make it nul terminated, as it was allocated using calloc.

Now we are writing ce_namelen - common + 1 bytes directly from the
ce->name to the index.  As ce->name is however not nul terminated, and
index-v4 needs the nul terminator to split between one index entry and
the next, this would end up in a corrupted index.

Fix that by only writing ce_namelen - common bytes directly from
ce->name to the index, and adding the nul terminator in an extra call to
ce_write.

This bug was turned up by setting TEST_GIT_INDEX_VERSION = 4 in
config.mak and running the test suite (t1700 specifically broke).

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I unfortunately didn't have more time to dig so

> As ce->name is however not nul terminated

just comes from my memory and from the patch below actually fixing the
corruption, so it's really the most likely cause.  Would be great if
someone who can remember more about the index could confirm that this
is indeed the case.

 read-cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 40da87ea71..80830ddcfc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2103,7 +2103,9 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 		if (!result)
 			result = ce_write(c, fd, to_remove_vi, prefix_size);
 		if (!result)
-			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common + 1);
+			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common);
+		if (!result)
+			result = ce_write(c, fd, "\0", 1);
 
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
-- 
2.14.1.480.gb18f417b89

