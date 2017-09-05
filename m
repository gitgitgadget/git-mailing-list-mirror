Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCD8208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdIEMOx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:57186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:52 -0400
Received: (qmail 31325 invoked by uid 109); 5 Sep 2017 12:14:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12322 invoked by uid 111); 5 Sep 2017 12:15:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:50 -0400
Date:   Tue, 5 Sep 2017 08:14:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/20] tempfile: factor out deactivation
Message-ID: <20170905121449.wnxj5tperwnoevch@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we deactivate a tempfile, we also have to clean up the
"filename" strbuf. Let's pull this out into its own function
to keep the logic in one place (which will become more
important when a future patch makes it more complicated).

Note that we can use the same function when deactivating an
object that _isn't_ actually active yet (like when we hit an
error creating a tempfile). These callsites don't currently
reset the "active" flag to 0, but it's OK to do so (it's
just a noop for these cases).

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 0e6c6b9c18..9d7f0a2f2b 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -119,6 +119,12 @@ static void activate_tempfile(struct tempfile *tempfile)
 	tempfile->active = 1;
 }
 
+static void deactivate_tempfile(struct tempfile *tempfile)
+{
+	tempfile->active = 0;
+	strbuf_reset(&tempfile->filename);
+}
+
 /* Make sure errno contains a meaningful value on error */
 int create_tempfile(struct tempfile *tempfile, const char *path)
 {
@@ -132,7 +138,7 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 		tempfile->fd = open(tempfile->filename.buf,
 				    O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (tempfile->fd < 0) {
-		strbuf_reset(&tempfile->filename);
+		deactivate_tempfile(tempfile);
 		return -1;
 	}
 	activate_tempfile(tempfile);
@@ -161,7 +167,7 @@ int mks_tempfile_sm(struct tempfile *tempfile,
 	strbuf_add_absolute_path(&tempfile->filename, template);
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
-		strbuf_reset(&tempfile->filename);
+		deactivate_tempfile(tempfile);
 		return -1;
 	}
 	activate_tempfile(tempfile);
@@ -182,7 +188,7 @@ int mks_tempfile_tsm(struct tempfile *tempfile,
 	strbuf_addf(&tempfile->filename, "%s/%s", tmpdir, template);
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
-		strbuf_reset(&tempfile->filename);
+		deactivate_tempfile(tempfile);
 		return -1;
 	}
 	activate_tempfile(tempfile);
@@ -291,8 +297,7 @@ int rename_tempfile(struct tempfile *tempfile, const char *path)
 		return -1;
 	}
 
-	tempfile->active = 0;
-	strbuf_reset(&tempfile->filename);
+	deactivate_tempfile(tempfile);
 	return 0;
 }
 
@@ -303,6 +308,5 @@ void delete_tempfile(struct tempfile *tempfile)
 
 	close_tempfile_gently(tempfile);
 	unlink_or_warn(tempfile->filename.buf);
-	tempfile->active = 0;
-	strbuf_reset(&tempfile->filename);
+	deactivate_tempfile(tempfile);
 }
-- 
2.14.1.721.gc5bc1565f1

