Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A7A1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdFHA5Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:57:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34940 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdFHA5X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:57:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so3185359pfd.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+d40vecwXlobVQV81mTNIY1fsQqrM+uH453wq5nW/Ew=;
        b=iO3Sq4hQuTBHhQ3+cMAximrs8Bv+G8UgC3MaKKWbRPk98XnNmYiySZJJzsW8Kz0Wxb
         N1GdlvZXo9pVzJK+1FCXi5cm53xZg48/6tiEE+24iZOrOuEzKmSS0zeLw/gGwwYscV/z
         qT+wLvE/ZppbLwJkQ55mbuMHN8EjJk2leLPQ/y+1vd/DFk0hJU81EkUlM9p3hET9APaT
         DjsS4UQRJuPLZ9FfrNQtnbdkcIysz/OmzvDBhdFrumZIKORMDOlk1dQZv/jxmOgn9FsI
         4wY0H/Ub/CCl9TOCR9LPPZbzf+ccT8SqhCyYKwbfhXVtWjE7A65p2u8a16J5DUcECGmy
         6gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+d40vecwXlobVQV81mTNIY1fsQqrM+uH453wq5nW/Ew=;
        b=ryRpC+gCOWrASPFqMCZFYbYhzCyawD8c6nzx3uI1TH5GRSS2pLeNViHNzTwX1hM2T5
         q24kpHZBsLSKXKqGPPcmEax0DC0rG6WGkb6u2FALu/Fp2AM/jtf0XkdzSsF+lcC277H/
         CKoyRus+0xMyXw6b/tqbHRwH93klP/mTw98vCWvbBRy9/I+0S/pNjmOfWVKhCm5AfR56
         /09wywDyt48CDmJv5cPVZlps+PZ4OyyofQkXjNV2HNLcdCCKnc2vRxlHeJ4TK9qHw7/o
         ZZAfeEnDKe+hJ8DY8Q1XSX9LljGn1/ik/qX9M/VfCejCEsqDwLo6FjpcmblYcQjyafJi
         9Enw==
X-Gm-Message-State: AODbwcCUgZgg2Nb8lrOC4SmFnS+BX7/GhPIIOFRngxnzEzjIps+w2/0D
        nfdg0DnIzj08SJ3u1tE=
X-Received: by 10.84.238.201 with SMTP id l9mr29564684pln.153.1496883442759;
        Wed, 07 Jun 2017 17:57:22 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id s17sm6418848pfk.112.2017.06.07.17.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 17:57:22 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 4/5] merge: close the index lock when not writing the new index
Date:   Wed,  7 Jun 2017 17:55:34 -0700
Message-Id: <20170608005535.13080-5-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170608005535.13080-1-joel@teichroeb.net>
References: <20170608005535.13080-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the merge does not have anything to do, it does not unlock the index,
causing any further index operations to fail. Thus, always unlock the index
regardless of outcome.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 merge-recursive.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ae5238d82c..16bb5512ef 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2145,9 +2145,12 @@ int merge_recursive_generic(struct merge_options *o,
 	if (clean < 0)
 		return clean;
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, lock, COMMIT_LOCK))
-		return err(o, _("Unable to write index."));
+	if (active_cache_changed) {
+		if (write_locked_index(&the_index, lock, COMMIT_LOCK))
+			return err(o, _("Unable to write index."));
+	} else {
+		rollback_lock_file(lock);
+	}
 
 	return clean ? 0 : 1;
 }
-- 
2.13.0

