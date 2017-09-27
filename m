Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA63820281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbdI0GAF (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:00:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752426AbdI0GAD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:00:03 -0400
Received: (qmail 25285 invoked by uid 109); 27 Sep 2017 05:59:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 05:59:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11394 invoked by uid 111); 27 Sep 2017 06:00:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:00:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:00:01 -0400
Date:   Wed, 27 Sep 2017 02:00:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] files-backend: prefer "0" for write_in_full() error
 check
Message-ID: <20170927060000.z2bs7lojzh6wprhr@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 06f46f237a (avoid "write_in_full(fd, buf, len) !=
len" pattern, 2017-09-13) converted this callsite from:

  write_in_full(...) != 1

to

  write_in_full(...) < 0

But during the conflict resolution in c50424a6f0 (Merge
branch 'jk/write-in-full-fix', 2017-09-25), this morphed
into

  write_in_full(...) < 1

This behaves as we want, but we prefer to avoid modeling the
"less than length" error-check which can be subtly buggy, as
shown in efacf609c8 (config: avoid "write_in_full(fd, buf,
len) < len" pattern, 2017-09-13).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dac33628b3..e35c64c001 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3007,7 +3007,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		} else if (update &&
 			   (write_in_full(get_lock_file_fd(&lock->lk),
 				oid_to_hex(&cb.last_kept_oid), GIT_SHA1_HEXSZ) < 0 ||
-			    write_str_in_full(get_lock_file_fd(&lock->lk), "\n") < 1 ||
+			    write_str_in_full(get_lock_file_fd(&lock->lk), "\n") < 0 ||
 			    close_ref_gently(lock) < 0)) {
 			status |= error("couldn't write %s",
 					get_lock_file_path(&lock->lk));
-- 
2.14.2.988.g01c8b37dde

