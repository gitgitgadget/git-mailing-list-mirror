Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF207208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdIEMPS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:15:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:57214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751552AbdIEMPO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:15:14 -0400
Received: (qmail 31409 invoked by uid 109); 5 Sep 2017 12:15:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12405 invoked by uid 111); 5 Sep 2017 12:15:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:15:12 -0400
Date:   Tue, 5 Sep 2017 08:15:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 18/20] lockfile: update lifetime requirements in documentation
Message-ID: <20170905121511.7s5ukj5jnj2mitnn@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the tempfile system we rely on has loosened the
lifetime requirements for storage, we can adjust our
documentation to match.

Signed-off-by: Jeff King <peff@peff.net>
---
 lockfile.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index 6ed336e2bc..7c1c484d7c 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -37,12 +37,12 @@
  *
  * The caller:
  *
- * * Allocates a `struct lock_file` either as a static variable or on
- *   the heap, initialized to zeros. Once you use the structure to
- *   call the `hold_lock_file_for_*()` family of functions, it belongs
- *   to the lockfile subsystem and its storage must remain valid
- *   throughout the life of the program (i.e. you cannot use an
- *   on-stack variable to hold this structure).
+ * * Allocates a `struct lock_file` with whatever storage duration you
+ *   desire. The struct does not have to be initialized before being
+ *   used, but it is good practice to do so using by setting it to
+ *   all-zeros (or using the LOCK_INIT macro). This puts the object in a
+ *   consistent state that allows you to call rollback_lock_file() even
+ *   if the lock was never taken (in which case it is a noop).
  *
  * * Attempts to create a lockfile by calling `hold_lock_file_for_update()`.
  *
@@ -73,10 +73,8 @@
  *   `commit_lock_file()`, `commit_lock_file_to()`,
  *   `rollback_lock_file()`, or `reopen_lock_file()`.
  *
- * Even after the lockfile is committed or rolled back, the
- * `lock_file` object must not be freed or altered by the caller.
- * However, it may be reused; just pass it to another call of
- * `hold_lock_file_for_update()`.
+ * After the lockfile is committed or rolled back, the `lock_file`
+ * object can be discarded or reused.
  *
  * If the program exits before `commit_lock_file()`,
  * `commit_lock_file_to()`, or `rollback_lock_file()` is called, the
@@ -114,6 +112,8 @@ struct lock_file {
 	struct tempfile *tempfile;
 };
 
+#define LOCK_INIT { NULL }
+
 /* String appended to a filename to derive the lockfile name: */
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
-- 
2.14.1.721.gc5bc1565f1

