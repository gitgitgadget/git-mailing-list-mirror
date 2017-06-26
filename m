Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C5C207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 15:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdFZPQa (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 11:16:30 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33425 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdFZPQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 11:16:28 -0400
Received: by mail-wr0-f171.google.com with SMTP id r103so146387509wrb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kVvkcDjQoqgGMrb6h5ke1EUe/K7jmBRjQkPZkrN77xU=;
        b=mLuHXnKQWJT0sPOZ9G7GZPPZnw9E2/2eNAnnDx90f3XVT2SRfZEff2+/iA/INQv0w/
         TsyUas1D0R21Pz4qPq0es6te/O4bPJdCjrHL5jy29z5M0ht9E+phZ/xycGUABnUyKa5p
         ONetmCzNrR7t8a/9qe0Y4gl5vhsX/KGpXJt8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kVvkcDjQoqgGMrb6h5ke1EUe/K7jmBRjQkPZkrN77xU=;
        b=TZfcIyuM+/TPHf+x0yVt21azaz7jJ8JGX/CITc8u1m6ABjf/o+zOL9g6SVpfmsd6lv
         Zn8OI51oio5G/IOGHcxY5VsnX6u3fl55PHqRDWgPhVp1tlPaC4uLnf8/7RyqAqNOaCSl
         O15MVUabVQ6mKw+FtjIYuGVhS2u9VbuZqyWEKhbmr6BVepi4GM04ACwlwcpmv9nTYeHN
         p1+FbcPq6Zf7qObZgatdq+iLi8dB0A90Vnc9d/W1DeBF2NqreGDmrb6lUpm0Fd6Pe6QT
         iCvcwgZhQFrp0k4cC09OyfLy8u6YOgC/sb8Bs3izKaORofqK0dREn8dee0rXBuCXhKmh
         nmZg==
X-Gm-Message-State: AKS2vOzz42kIIbfTVBhjHs8ztwzUK5FMDCA6FQbvb6CyMtnE1u2rhVeo
        NsHv9Pc2HdLRHEAYE0Xbvg==
X-Received: by 10.223.139.158 with SMTP id o30mr14785326wra.132.1498490186966;
        Mon, 26 Jun 2017 08:16:26 -0700 (PDT)
Received: from Jamess-MacBook.local (global-184-8.nat-1.net.cam.ac.uk. [131.111.184.8])
        by smtp.gmail.com with ESMTPSA id v96sm12073160wrc.53.2017.06.26.08.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 08:16:26 -0700 (PDT)
Received: by Jamess-MacBook.local (Postfix, from userid 501)
        id 3B0B11F5445D; Mon, 26 Jun 2017 16:16:24 +0100 (BST)
From:   James Clarke <jrtc27@jrtc27.com>
To:     gitster@pobox.com
Cc:     James Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
Subject: [PATCH] pack-bitmap: Don't perform unaligned memory access
Date:   Mon, 26 Jun 2017 16:16:12 +0100
Message-Id: <20170626151612.64019-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.13.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preceding bitmap entries have a 1-byte XOR-offset and 1-byte flags,
so their size is not a multiple of 4. Thus the name-hash cache is only
guaranteed to be 2-byte aligned and so we must use get_be32 rather than
indexing the array directly.

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---

This was noticed thanks to the recent tests added to t5310-pack-bitmaps.sh,
which were crashing with SIGBUS on Debian sparc64. All tests (excluding those
marked with known breakage) now pass again.

 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index a3ac3dccd..327634cd7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -627,7 +627,7 @@ static void show_objects_for_type(
 			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);

 			if (bitmap_git.hashes)
-				hash = ntohl(bitmap_git.hashes[entry->nr]);
+				hash = get_be32(bitmap_git.hashes + entry->nr);

 			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
 		}
--
2.13.2

