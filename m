Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A93208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdIEMOo (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:57164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:42 -0400
Received: (qmail 31301 invoked by uid 109); 5 Sep 2017 12:14:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12274 invoked by uid 111); 5 Sep 2017 12:15:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:40 -0400
Date:   Tue, 5 Sep 2017 08:14:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/20] tempfile: handle NULL tempfile pointers gracefully
Message-ID: <20170905121440.hxbyspsruzrwigtq@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tempfile functions all take pointers to tempfile
objects, but do not check whether the argument is NULL.
This isn't a big deal in practice, since the lifetime of any
tempfile object is defined to last for the whole program. So
even if we try to call delete_tempfile() on an
already-deleted tempfile, our "active" check will tell us
that it's a noop.

In preparation for transitioning to a new system that
loosens the "tempfile objects can never be freed" rule,
let's tighten up our active checks:

  1. A NULL pointer is now defined as "inactive" (so it will
     BUG for most functions, but works as a silent noop for
     things like delete_tempfile).

  2. Functions should always do the "active" check before
     looking at any of the struct fields.

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 12 +++++++-----
 tempfile.h |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 964c66d504..861f817133 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -236,13 +236,15 @@ FILE *get_tempfile_fp(struct tempfile *tempfile)
 
 int close_tempfile_gently(struct tempfile *tempfile)
 {
-	int fd = tempfile->fd;
-	FILE *fp = tempfile->fp;
+	int fd;
+	FILE *fp;
 	int err;
 
-	if (fd < 0)
+	if (!is_tempfile_active(tempfile) || tempfile->fd < 0)
 		return 0;
 
+	fd = tempfile->fd;
+	fp = tempfile->fp;
 	tempfile->fd = -1;
 	if (fp) {
 		tempfile->fp = NULL;
@@ -262,10 +264,10 @@ int close_tempfile_gently(struct tempfile *tempfile)
 
 int reopen_tempfile(struct tempfile *tempfile)
 {
-	if (0 <= tempfile->fd)
-		die("BUG: reopen_tempfile called for an open object");
 	if (!is_tempfile_active(tempfile))
 		die("BUG: reopen_tempfile called for an inactive object");
+	if (0 <= tempfile->fd)
+		die("BUG: reopen_tempfile called for an open object");
 	tempfile->fd = open(tempfile->filename.buf, O_WRONLY);
 	return tempfile->fd;
 }
diff --git a/tempfile.h b/tempfile.h
index d854dcdd3e..d30663182d 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -211,7 +211,7 @@ extern FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode);
 
 static inline int is_tempfile_active(struct tempfile *tempfile)
 {
-	return tempfile->active;
+	return tempfile && tempfile->active;
 }
 
 /*
-- 
2.14.1.721.gc5bc1565f1

