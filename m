Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2328D1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeGPBxW (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58984 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbeGPBxV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 757BD6077E;
        Mon, 16 Jul 2018 01:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704505;
        bh=RqMFvrIeMjP19V5mhjMAegBieU9cl0L1Y7R0shJRWPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tchyE6nHCO2jwKTuQxFfuyI19UDMBM8zoGlKWr0rCU0DF98KNH1ibuoR+fOPydttW
         3YAZwvvurP2naP9VhcO6qiXMvGJT0tKEhYT6e8zaudn3PDJp8fkZat1VZY9I4YvJFE
         BQuYTRRE3Q51wHKMWnAzmXCtUvqtEigHeiaPXoMBDuwArUDFq5TSrjPIeto320fXfa
         9JYFqu/d6qxnTxFUvwX1dZM/Bv9UxatgAstzMcHOsAO19Glhl3ASv3qqactXO1Yu7K
         fPON1EScunPHjHUMlUy7z0Yd2K4jivv9uHybuBEJI2Dhz5ANYmzTKV+Gu+5dvBuYH9
         bHP/eYY22VLpNjcwHFM3DIv4i+FxY/UJ06BexULZZO+lp2lDF6wYdDAsaC1uqEC00p
         wDIe0BBfFgOMyy3W0O6/jqAQRdP4EM/QoVkKqtYf8ZoijmlM9H2Vwpr73xhTAdYtBd
         2b4SYlJqjrEthCw8rVfi9LZfMP7ma9naKi8eR9QQ92NTZ3ERXeH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 07/16] refs/files-backend: use the_hash_algo for writing refs
Date:   Mon, 16 Jul 2018 01:27:59 +0000
Message-Id: <20180716012808.961328-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to ensure we write the correct amount, use the_hash_algo to
find the correct number of bytes for the current hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a9a066dcfb..c546ffbf5d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1676,7 +1676,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 		return -1;
 	}
 	fd = get_lock_file_fd(&lock->lk);
-	if (write_in_full(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ) < 0 ||
+	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
 	    close_ref_gently(lock) < 0) {
 		strbuf_addf(err,
@@ -3070,7 +3070,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			rollback_lock_file(&reflog_lock);
 		} else if (update &&
 			   (write_in_full(get_lock_file_fd(&lock->lk),
-				oid_to_hex(&cb.last_kept_oid), GIT_SHA1_HEXSZ) < 0 ||
+				oid_to_hex(&cb.last_kept_oid), the_hash_algo->hexsz) < 0 ||
 			    write_str_in_full(get_lock_file_fd(&lock->lk), "\n") < 0 ||
 			    close_ref_gently(lock) < 0)) {
 			status |= error("couldn't write %s",
