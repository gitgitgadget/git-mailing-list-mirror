Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F12208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdIEMOu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:57176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMOt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:49 -0400
Received: (qmail 31316 invoked by uid 109); 5 Sep 2017 12:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12306 invoked by uid 111); 5 Sep 2017 12:15:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:47 -0400
Date:   Tue, 5 Sep 2017 08:14:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/20] tempfile: factor out activation
Message-ID: <20170905121446.wzwfqlpludxurfdg@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few steps required to "activate" a tempfile
struct. Let's pull these out into a function. That saves a
few repeated lines now, but more importantly will make it
easier to change the activation scheme later.

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 813cf6a81c..0e6c6b9c18 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -113,6 +113,12 @@ static void prepare_tempfile_object(struct tempfile *tempfile)
 	}
 }
 
+static void activate_tempfile(struct tempfile *tempfile)
+{
+	tempfile->owner = getpid();
+	tempfile->active = 1;
+}
+
 /* Make sure errno contains a meaningful value on error */
 int create_tempfile(struct tempfile *tempfile, const char *path)
 {
@@ -129,8 +135,7 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 		strbuf_reset(&tempfile->filename);
 		return -1;
 	}
-	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 	if (adjust_shared_perm(tempfile->filename.buf)) {
 		int save_errno = errno;
 		error("cannot fix permission bits on %s", tempfile->filename.buf);
@@ -145,8 +150,7 @@ void register_tempfile(struct tempfile *tempfile, const char *path)
 {
 	prepare_tempfile_object(tempfile);
 	strbuf_add_absolute_path(&tempfile->filename, path);
-	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 }
 
 int mks_tempfile_sm(struct tempfile *tempfile,
@@ -160,8 +164,7 @@ int mks_tempfile_sm(struct tempfile *tempfile,
 		strbuf_reset(&tempfile->filename);
 		return -1;
 	}
-	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 	return tempfile->fd;
 }
 
@@ -182,8 +185,7 @@ int mks_tempfile_tsm(struct tempfile *tempfile,
 		strbuf_reset(&tempfile->filename);
 		return -1;
 	}
-	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 	return tempfile->fd;
 }
 
-- 
2.14.1.721.gc5bc1565f1

