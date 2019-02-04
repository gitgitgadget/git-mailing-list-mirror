Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161E51F453
	for <e@80x24.org>; Mon,  4 Feb 2019 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfBDAHA (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 19:07:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33706 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727364AbfBDAG7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Feb 2019 19:06:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c489:9935:372d:73bb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9CC226073C;
        Mon,  4 Feb 2019 00:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549238816;
        bh=N4SM4UcNgVF05Q+0wXDKbaq2oogwhCUQZ7HUi2biCL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JNh8Xb3EyX7BRnrnh62L1FV19w4vQ5/SI0cF3qDp+QKVznPxnbC7m6tHnBknplwQp
         ItkttShGbM776b7yk3cpaIoPnqXOojRdZ3Rig7fi1+RPGbM/8CbHTmIAzPlGvJ7vHU
         7Z1eHwEKqhAHFMzrkxSlOqacQ8JyMRBBGcisXnjdK/7J34xUnFAyNLKfvnRBr8kLsE
         82j2InSqfLfdHO2KNlE0kUJqKpC8FzxJw+p5qKQuCDFN7c9FYa2OJ1iCGJ2o2/hBt0
         AqrsR+G8LF7P+6nuZIQpuFGN8lOK2HEgs6dGT9VLsd/flZTuuQVN/mvdqM7fWokzDn
         F8u5u6UexMa8jShiCLcTGbk8h/7sH9eL9uak+VkUgojiY5BLLLcYRaI63gdBgrM8wK
         FeJxdlInoaF2cF19sGdH3b45nKY5YHbxl1Ozx8b271FofDSxJToed2LV0Izz2jC3/4
         GLgFP84hU1InS6cuX9kxzFaLXhBtGj5mFMc+h04Vi63FAYpjx4q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH] fetch-pack: clear alternate shallow when complete
Date:   Mon,  4 Feb 2019 00:06:50 +0000
Message-Id: <20190204000650.686175-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b
In-Reply-To: <20190130085855.GA24387@genre.crustytoothpaste.net>
References: <20190130085855.GA24387@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we write an alternate shallow file in update_shallow, we write it
into the lock file. The string stored in alternate_shallow_file is
copied from the lock file path, but it is freed the moment that the lock
file is closed, since we call strbuf_release to free that path.

This used to work, since we did not invoke git index-pack more than
once, but now that we do, we reuse the freed memory. Ensure we reset the
value to NULL to avoid using freed memory. git index-pack will read the
repository's shallow file, which will have been updated with the correct
information.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 577faa6229..2d76287674 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1489,6 +1489,7 @@ static void update_shallow(struct fetch_pack_args *args,
 			rollback_lock_file(&shallow_lock);
 		} else
 			commit_lock_file(&shallow_lock);
+		alternate_shallow_file = NULL;
 		return;
 	}
 
@@ -1512,6 +1513,7 @@ static void update_shallow(struct fetch_pack_args *args,
 						&alternate_shallow_file,
 						&extra);
 			commit_lock_file(&shallow_lock);
+			alternate_shallow_file = NULL;
 		}
 		oid_array_clear(&extra);
 		return;
@@ -1551,6 +1553,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		commit_lock_file(&shallow_lock);
 		oid_array_clear(&extra);
 		oid_array_clear(&ref);
+		alternate_shallow_file = NULL;
 		return;
 	}
 
