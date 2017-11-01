Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10506202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbdKAUfO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 16:35:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:48606 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755206AbdKAUfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 16:35:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id 15so3039435wrb.5
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLF0Gz8zXy6xKmdaEvOaoedQLehcWTOFhfQrDzxhR2s=;
        b=DVlcyarXWvokAIWH4GyeMqHPJ5JWlO+3/0iFukvk6dmP7KoSKRw59zizPqbr45ALp9
         My5a4n9QEGtQLUc5I7L8vBs0xyQsZsDeZ6buycChTPCjFeVW/AaRUDWdvwsH37cSN1ug
         s5XJ5X/s/TVkIde7znst+PGq0VeLnmL7O62hrCaqHOCfFQcUi8BHlMMVDuC87iGL6uad
         rRvfVoV628Ys0AlQjQ2amUYWZGTNU+jtb9JCNJzOQje92uWARbtAlDU0sjrJCbRBPJv2
         bDhFZGO9Qdxrk5LOyjj/y/vKW8k3PR27fZmhDgAKBlekrOB0kAuGjv1nyMVt18L8753J
         ym/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLF0Gz8zXy6xKmdaEvOaoedQLehcWTOFhfQrDzxhR2s=;
        b=PMMlA7gGXXrEC0uKo5V3GDTThaX6oo4oFhlWvCq1IuQb3kvLtcQbBgQVIzYwyM23IT
         mrssY26AsDzMF3w4NbvT5yx7KMse8GiXf51wXZMpRSamExE6LKJOGAKBWbDiYUW7IjlV
         Q4fTxMJWi/c32b2hIDhkmx1e5Qp/Qo15KzcQ/rMbbKDIFe9R/c3BsiVYwJkZYIcMnMg3
         DN2UWUp6JHIl1Rdu3EXB5HpH8zVwxQVp81f5EbpzsPjVCR6rCRbv7GvrjPu2Gw/qS7jW
         +FXqlNr0uqU6doPYoZYcTwcYw8FF8vs4GzBIfMRrw2zwiwVbC0VOnPxdu0QR0zO2dgQk
         GIlg==
X-Gm-Message-State: AMCzsaV1DYsPaYmUKBnw2kQgHSBCOIUpyDisuEOD0geB+b0HLOq6Qllo
        TuhJ2M0rPkCVGn387NMerFWE8dg3OKU=
X-Google-Smtp-Source: ABhQp+QzWnlctFwhmM6Uuu2oTdO/wj4KoSbR2VlRmgoY8lDAoHPoSChs9C60kXk4YYBYohbA8n2b3w==
X-Received: by 10.223.188.13 with SMTP id s13mr902133wrg.39.1509568511814;
        Wed, 01 Nov 2017 13:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m8sm1312235wrg.55.2017.11.01.13.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 13:35:11 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/3] bisect: fix memory leak when returning best element
Date:   Wed,  1 Nov 2017 21:34:39 +0100
Message-Id: <2ef8b41ad021638acc767c59ee65e15109a34fbf.1509557518.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
References: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `find_bisection()` returns a single list entry, it leaks the other
entries. Move the to-be-returned item to the front and free the
remainder.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 bisect.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index fda527b89..c1aaf632a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -400,8 +400,12 @@ struct commit_list *find_bisection(struct commit_list *list,
 	/* Do the real work of finding bisection commit. */
 	best = do_find_bisection(list, nr, weights, find_all);
 	if (best) {
-		if (!find_all)
+		if (!find_all) {
+			list->item = best->item;
+			free_commit_list(list->next);
+			best = list;
 			best->next = NULL;
+		}
 		*reaches = weight(best);
 	}
 	free(weights);
-- 
2.15.0.415.gac1375d7e

