Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BA61F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933322AbeGHXh0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933079AbeGHXg4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1DF5C6047B;
        Sun,  8 Jul 2018 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093015;
        bh=wW+nS4w7arxUBcEarFI+ZquNbHn2RqAyjHXffzVrF0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YCA2Rtv8jl1yc4rICDrLisK7CmeJDTITACUPyG6tnwff2fQx+sdmahGClCmt4g/Fx
         DRphF0iQNgJ46X3Dy42EdzU31ucheL+qyXILp6hzvIRB6rTNT/wgtr3HiV52WpdIqm
         BFewDRXgURekCttPjePLSoO9cTrfnauxuXgw7Wn/mzFdwqpoeESZmD5kCcf/8QfbaZ
         kOUE7qMohcpO8axVbIyPJdnFruwS5RutmQytgUUOzCoQHUhG+mcFTx8CNVzIhMEN6/
         d7OtoEJeqQqih09rGrqtmsAPhb5PKDYz7pt6RiBUMHQaJqUN3Y4kZJkLrSt+E1Erbr
         fmj+I1l2mGali7hVkkHKDi1gYWF+DeW3Y4HJvY6mJjt1debKLLewN1amykWvDLypXV
         2DhY+7IHwfaCKyWscmfpAIEBzc5/5JH9/U88jAqskWHljD96RYN8pCvpUrF+NwJjnh
         LGSuvm4Eiz+81bCqtpt6WxU+lfgxkg89S9ix0n8nOaQL1QZqHh5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/17] refs/files-backend: use the_hash_algo for writing refs
Date:   Sun,  8 Jul 2018 23:36:29 +0000
Message-Id: <20180708233638.520172-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
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
index 252f835bae..4a724f20a9 100644
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
