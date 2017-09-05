Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5472F208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbdIEMPJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:15:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:57210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750858AbdIEMPG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:15:06 -0400
Received: (qmail 31397 invoked by uid 109); 5 Sep 2017 12:15:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:15:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12399 invoked by uid 111); 5 Sep 2017 12:15:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:15:04 -0400
Date:   Tue, 5 Sep 2017 08:15:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 16/20] tempfile: remove deactivated list entries
Message-ID: <20170905121504.77xchlnjlvb2j73a@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once a "struct tempfile" is added to the global cleanup
list, it is never removed. This means that its storage must
remain valid for the lifetime of the program. For single-use
tempfiles and locks, this isn't a big deal: we just declare
the struct static. But for library code which may take
multiple simultaneous locks (like the ref code), they're
forced to allocate a struct on the heap and leak it.

This is mostly OK in practice. The size of the leak is
bounded by the number of refs, and most programs exit after
operating on a fixed number of refs (and allocate
simultaneous memory proportional to the number of ref
updates in the first place). But:

  1. It isn't hard to imagine a real leak: a program which
     runs for a long time taking a series of ref update
     instructions and fulfilling them one by one. I don't
     think we have such a program now, but it's certainly
     plausible.

  2. The leaked entries appear as false positives to
     tools like valgrind.

Let's relax this rule by keeping only "active" tempfiles on
the list. We can do this easily by moving the list-add
operation from prepare_tempfile_object to activate_tempfile,
and adding a deletion in deactivate_tempfile.

Existing callers do not need to be updated immediately.
They'll continue to leak any tempfile objects they may have
allocated, but that's no different than the status quo. We
can clean them up individually.

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 46 ++++++++++++++++++++--------------------------
 tempfile.h | 15 +++++----------
 2 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 11bda824cf..f82a5f3676 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -42,8 +42,7 @@
  *     states in which this condition doesn't hold). Client code should
  *     *not* rely on the filename being empty in this state.
  *   - `fd` is -1 and `fp` is `NULL`
- *   - the object is left registered in the `tempfile_list`, and
- *     `on_list` is set.
+ *   - the object is removed from `tempfile_list` (but could be used again)
  *
  * A temporary file is owned by the process that created it. The
  * `tempfile` has an `owner` field that records the owner's PID. This
@@ -92,36 +91,30 @@ static void remove_tempfiles_on_signal(int signo)
 	raise(signo);
 }
 
-/*
- * Initialize *tempfile if necessary and add it to tempfile_list.
- */
 static void prepare_tempfile_object(struct tempfile *tempfile)
 {
-	if (volatile_list_empty(&tempfile_list)) {
-		/* One-time initialization */
-		sigchain_push_common(remove_tempfiles_on_signal);
-		atexit(remove_tempfiles_on_exit);
-	}
-
-	if (is_tempfile_active(tempfile))
-		BUG("prepare_tempfile_object called for active object");
-	if (!tempfile->on_list) {
-		/* Initialize *tempfile and add it to tempfile_list: */
-		tempfile->fd = -1;
-		tempfile->fp = NULL;
-		tempfile->active = 0;
-		tempfile->owner = 0;
-		strbuf_init(&tempfile->filename, 0);
-		volatile_list_add(&tempfile->list, &tempfile_list);
-		tempfile->on_list = 1;
-	} else if (tempfile->filename.len) {
-		/* This shouldn't happen, but better safe than sorry. */
-		BUG("prepare_tempfile_object called for improperly-reset object");
-	}
+	tempfile->fd = -1;
+	tempfile->fp = NULL;
+	tempfile->active = 0;
+	tempfile->owner = 0;
+	INIT_LIST_HEAD(&tempfile->list);
+	strbuf_init(&tempfile->filename, 0);
 }
 
 static void activate_tempfile(struct tempfile *tempfile)
 {
+	static int initialized;
+
+	if (is_tempfile_active(tempfile))
+		BUG("activate_tempfile called for active object");
+
+	if (!initialized) {
+		sigchain_push_common(remove_tempfiles_on_signal);
+		atexit(remove_tempfiles_on_exit);
+		initialized = 1;
+	}
+
+	volatile_list_add(&tempfile->list, &tempfile_list);
 	tempfile->owner = getpid();
 	tempfile->active = 1;
 }
@@ -130,6 +123,7 @@ static void deactivate_tempfile(struct tempfile *tempfile)
 {
 	tempfile->active = 0;
 	strbuf_release(&tempfile->filename);
+	volatile_list_del(&tempfile->list);
 }
 
 /* Make sure errno contains a meaningful value on error */
diff --git a/tempfile.h b/tempfile.h
index 2ee24f4380..e32b4df092 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -17,12 +17,9 @@
  *
  * The caller:
  *
- * * Allocates a `struct tempfile` either as a static variable or on
- *   the heap, initialized to zeros. Once you use the structure to
- *   call `create_tempfile()`, it belongs to the tempfile subsystem
- *   and its storage must remain valid throughout the life of the
- *   program (i.e. you cannot use an on-stack variable to hold this
- *   structure).
+ * * Allocates a `struct tempfile`. Once the structure is passed to
+ *   `create_tempfile()`, its storage must remain valid until
+ *   `delete_tempfile()` or `rename_tempfile()` is called on it.
  *
  * * Attempts to create a temporary file by calling
  *   `create_tempfile()`.
@@ -52,9 +49,8 @@
  *   temporary file by calling `close_tempfile_gently()`, and later call
  *   `delete_tempfile()` or `rename_tempfile()`.
  *
- * Even after the temporary file is renamed or deleted, the `tempfile`
- * object must not be freed or altered by the caller. However, it may
- * be reused; just pass it to another call of `create_tempfile()`.
+ * After the temporary file is renamed or deleted, the `tempfile`
+ * object may be reused or freed.
  *
  * If the program exits before `rename_tempfile()` or
  * `delete_tempfile()` is called, an `atexit(3)` handler will close
@@ -88,7 +84,6 @@ struct tempfile {
 	volatile int fd;
 	FILE *volatile fp;
 	volatile pid_t owner;
-	char on_list;
 	struct strbuf filename;
 };
 
-- 
2.14.1.721.gc5bc1565f1

