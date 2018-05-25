Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41861F42D
	for <e@80x24.org>; Fri, 25 May 2018 23:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030682AbeEYXRX (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 19:17:23 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36915 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030538AbeEYXRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 19:17:23 -0400
Received: by mail-ot0-f193.google.com with SMTP id 77-v6so7796231otd.4
        for <git@vger.kernel.org>; Fri, 25 May 2018 16:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r1pDEE/jIK1okPy9ukSLZyDGIN+vuZ47AN7xg6ADig4=;
        b=nu3JZZUS62LEpRvQ4L9hducOMry/3opAPMmmm90CRK3358J3cG9WclNs6pkzjCdbRW
         bLLDAryc1sUQxWuF2QQxfzAPEr2W41teofTGZdXPsTYAaKHPX3Telp0UnkEx2Xs23270
         9+3jheyleX5idaB1Zfuh+jpCKBTLYXlOPrUCYlzqCjPxXT1/pjJiCdMHhJDRdICA5WWS
         WwoCqzsh6tNQAzHepS2pgvXS3PgiHblSJgLl7eSmOOX3C3BHpSo+Wrk0Z2CDA4ZH66XX
         VwTI8U90B4h9wVsm3DsnaBAmXcauzrdepq7g5iIl0w1ryOT+ZhZ/SWelwih40cfFnGl9
         NpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r1pDEE/jIK1okPy9ukSLZyDGIN+vuZ47AN7xg6ADig4=;
        b=jPRvzEhX1JQbiD/Ji6I/xzQXVRwiXWE+80zUIbPgZh9tKx48CTfUsgrkl8Hy4tJ/WS
         AcZjnt0Wg5kSGo75jRW2VxSDMca7aRU+OOf/aghan+gR3WK7K7VtNu3g1/bFKR22slai
         pI8aYsZzQ6QFRKhqKn48PpwjE4DURjN7seTGsL4LSDFQScZX5nGtNAsdSDjxcrhSRsmX
         TTK9g1ZQcF3QTs1bNYbldj8Ahf0/4shdsW7LNWDHiB52UZ1heFAEgkbzqifwrHSEVJt7
         cCMCnrAnlHkmyo4KRidoAO955b6fMfwy+ETKesN65bTyynZD832+gtU+TX0VmoKUYSTO
         JMmA==
X-Gm-Message-State: ALKqPwcvR47APzlC4XJ7SIaTf41Zqi/PLmJJyDrYZMc2Hvf4D7WS0Blu
        TpSskMl1/s+kBDvi2OOF1MLtIg==
X-Google-Smtp-Source: ADUXVKIITtqNa5qINORbZZzs3417acrPn6Nj2lfSPCYR9MysXbJyCaPX1R4nQpqmcA0zbjHh+qfvPQ==
X-Received: by 2002:a9d:12b6:: with SMTP id g51-v6mr3033480otg.115.1527290242367;
        Fri, 25 May 2018 16:17:22 -0700 (PDT)
Received: from dell-suse.jhome.net ([70.123.58.237])
        by smtp.gmail.com with ESMTPSA id y51-v6sm14941116oti.48.2018.05.25.16.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 May 2018 16:17:21 -0700 (PDT)
From:   Jeremy Linton <lintonrjeremy@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com,
        Jeremy Linton <lintonrjeremy@gmail.com>
Subject: [PATCH] packfile: Correct zlib buffer handling
Date:   Fri, 25 May 2018 18:17:13 -0500
Message-Id: <20180525231713.23047-1-lintonrjeremy@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer being passed to zlib includes a null terminator that
git needs to keep in place. unpack_compressed_entry() attempts to
detect the case that the source buffer hasn't been fully consumed
by checking to see if the destination buffer has been over consumed.

This yields two problems, first a single byte overrun won't be detected
properly because the Z_STREAM_END will then be set, but the null
terminator will have been overwritten. The other problem is that
more recent zlib patches have been poisoning the unconsumed portions
of the buffers which also overwrites the null, while correctly
returning length and status.

Lets rely on the fact that the source buffer will only be fully
consumed when the when the destination buffer is inflated to the
correct size. We can do this by passing zlib the correct buffer size
and properly checking the return status. The latter check actually
already exists if the buffer size is correct.

Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
---
 packfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7c1a2519f..245eb3204 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		return NULL;
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size + 1;
+	stream.avail_out = size;
 
 	git_inflate_init(&stream);
 	do {
@@ -1424,7 +1424,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
 		if (!stream.avail_out)
-			break; /* the payload is larger than it should be */
+			break; /* done, st indicates if source fully consumed */
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
-- 
2.13.6

