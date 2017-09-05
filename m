Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD603208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdIEMO4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:57188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:55 -0400
Received: (qmail 31329 invoked by uid 109); 5 Sep 2017 12:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12338 invoked by uid 111); 5 Sep 2017 12:15:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:53 -0400
Date:   Tue, 5 Sep 2017 08:14:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/20] tempfile: robustify cleanup handler
Message-ID: <20170905121452.eycytdbsabkbrlvx@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We may call remove_tempfiles() from an atexit handler, or
from a signal handler. In the latter case we must take care
to avoid functions which may deadlock if the process is in
an unknown state, including looking at any stdio handles
(which may be in the middle of doing I/O and locked) or
calling malloc() or free().

The current implementation calls delete_tempfile(). We unset
the tempfile's stdio handle (if any) to avoid deadlocking
there. But delete_tempfile() still calls unlink_or_warn(),
which can deadlock writing to stderr if the unlink fails.

Since delete_tempfile() isn't very long, let's just
open-code our own simple conservative version of the same
thing.  Notably:

  1. The "skip_fclose" flag is now called "in_signal_handler",
     because it should inform more decisions than just the
     fclose handling.

  2. We can replace close_tempfile() with just close(fd).
     That skips the fclose() question altogether. This is
     fine for the atexit() case, too; there's no point
     flushing data to a file which we're about to delete
     anyway.

  3. We can choose between unlink/unlink_or_warn based on
     whether it's safe to use stderr.

  4. We can replace the deactivate_tempfile() call with a
     simple setting of the active flag. There's no need to
     do any further cleanup since we know the program is
     exiting.  And even though the current deactivation code
     is safe in a signal handler, this frees us up in future
     patches to make non-signal deactivation more
     complicated (e.g., by freeing resources).

  5. There's no need to remove items from the tempfile_list.
     The "active" flag is the ultimate answer to whether an
     entry has been handled or not. Manipulating the list
     just introduces more chance of recursive signals
     stomping on each other, and the whole list will go away
     when the program exits anyway. Less is more.

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 9d7f0a2f2b..3348ad59dd 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -57,18 +57,24 @@
 
 static struct tempfile *volatile tempfile_list;
 
-static void remove_tempfiles(int skip_fclose)
+static void remove_tempfiles(int in_signal_handler)
 {
 	pid_t me = getpid();
+	struct tempfile *volatile p;
 
-	while (tempfile_list) {
-		if (tempfile_list->owner == me) {
-			/* fclose() is not safe to call in a signal handler */
-			if (skip_fclose)
-				tempfile_list->fp = NULL;
-			delete_tempfile(tempfile_list);
-		}
-		tempfile_list = tempfile_list->next;
+	for (p = tempfile_list; p; p = p->next) {
+		if (!is_tempfile_active(p) || p->owner != me)
+			continue;
+
+		if (p->fd >= 0)
+			close(p->fd);
+
+		if (in_signal_handler)
+			unlink(p->filename.buf);
+		else
+			unlink_or_warn(p->filename.buf);
+
+		p->active = 0;
 	}
 }
 
-- 
2.14.1.721.gc5bc1565f1

