Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B3F208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdIEMOr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57166 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:45 -0400
Received: (qmail 31306 invoked by uid 109); 5 Sep 2017 12:14:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12277 invoked by uid 111); 5 Sep 2017 12:15:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:43 -0400
Date:   Tue, 5 Sep 2017 08:14:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/20] tempfile: replace die("BUG") with BUG()
Message-ID: <20170905121443.iwpm427f5j5hhgat@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to die(), using BUG() triggers abort(). That may
give us an actual coredump, which should make it easier to
get a stack trace. And since the programming error for these
assertions is not in the functions themselves but in their
callers, such a stack trace is needed to actually find the
source of the bug.

In addition, abort() raises SIGABRT, which is more likely to
be caught by our test suite.

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 861f817133..813cf6a81c 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -96,7 +96,7 @@ static void prepare_tempfile_object(struct tempfile *tempfile)
 	}
 
 	if (is_tempfile_active(tempfile))
-		die("BUG: prepare_tempfile_object called for active object");
+		BUG("prepare_tempfile_object called for active object");
 	if (!tempfile->on_list) {
 		/* Initialize *tempfile and add it to tempfile_list: */
 		tempfile->fd = -1;
@@ -109,7 +109,7 @@ static void prepare_tempfile_object(struct tempfile *tempfile)
 		tempfile->on_list = 1;
 	} else if (tempfile->filename.len) {
 		/* This shouldn't happen, but better safe than sorry. */
-		die("BUG: prepare_tempfile_object called for improperly-reset object");
+		BUG("prepare_tempfile_object called for improperly-reset object");
 	}
 }
 
@@ -205,9 +205,9 @@ int xmks_tempfile_m(struct tempfile *tempfile, const char *template, int mode)
 FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
 {
 	if (!is_tempfile_active(tempfile))
-		die("BUG: fdopen_tempfile() called for inactive object");
+		BUG("fdopen_tempfile() called for inactive object");
 	if (tempfile->fp)
-		die("BUG: fdopen_tempfile() called for open object");
+		BUG("fdopen_tempfile() called for open object");
 
 	tempfile->fp = fdopen(tempfile->fd, mode);
 	return tempfile->fp;
@@ -216,21 +216,21 @@ FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
 const char *get_tempfile_path(struct tempfile *tempfile)
 {
 	if (!is_tempfile_active(tempfile))
-		die("BUG: get_tempfile_path() called for inactive object");
+		BUG("get_tempfile_path() called for inactive object");
 	return tempfile->filename.buf;
 }
 
 int get_tempfile_fd(struct tempfile *tempfile)
 {
 	if (!is_tempfile_active(tempfile))
-		die("BUG: get_tempfile_fd() called for inactive object");
+		BUG("get_tempfile_fd() called for inactive object");
 	return tempfile->fd;
 }
 
 FILE *get_tempfile_fp(struct tempfile *tempfile)
 {
 	if (!is_tempfile_active(tempfile))
-		die("BUG: get_tempfile_fp() called for inactive object");
+		BUG("get_tempfile_fp() called for inactive object");
 	return tempfile->fp;
 }
 
@@ -265,9 +265,9 @@ int close_tempfile_gently(struct tempfile *tempfile)
 int reopen_tempfile(struct tempfile *tempfile)
 {
 	if (!is_tempfile_active(tempfile))
-		die("BUG: reopen_tempfile called for an inactive object");
+		BUG("reopen_tempfile called for an inactive object");
 	if (0 <= tempfile->fd)
-		die("BUG: reopen_tempfile called for an open object");
+		BUG("reopen_tempfile called for an open object");
 	tempfile->fd = open(tempfile->filename.buf, O_WRONLY);
 	return tempfile->fd;
 }
@@ -275,7 +275,7 @@ int reopen_tempfile(struct tempfile *tempfile)
 int rename_tempfile(struct tempfile *tempfile, const char *path)
 {
 	if (!is_tempfile_active(tempfile))
-		die("BUG: rename_tempfile called for inactive object");
+		BUG("rename_tempfile called for inactive object");
 
 	if (close_tempfile_gently(tempfile)) {
 		delete_tempfile(tempfile);
-- 
2.14.1.721.gc5bc1565f1

