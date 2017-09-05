Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CF9208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdIEMOk (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:57162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:39 -0400
Received: (qmail 31297 invoked by uid 109); 5 Sep 2017 12:14:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12271 invoked by uid 111); 5 Sep 2017 12:15:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:36 -0400
Date:   Tue, 5 Sep 2017 08:14:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/20] tempfile: prefer is_tempfile_active to bare access
Message-ID: <20170905121436.rubh2yu6dgpscpnn@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tempfile code keeps an "active" flag, and we have a
number of assertions to make sure that the objects are being
used in the right order. Most of these directly check
"active" rather than using the is_tempfile_active()
accessor.

Let's prefer using the accessor, in preparation for it
growing more complicated logic (like checking for NULL).

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index c6740e562c..964c66d504 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -95,7 +95,7 @@ static void prepare_tempfile_object(struct tempfile *tempfile)
 		atexit(remove_tempfiles_on_exit);
 	}
 
-	if (tempfile->active)
+	if (is_tempfile_active(tempfile))
 		die("BUG: prepare_tempfile_object called for active object");
 	if (!tempfile->on_list) {
 		/* Initialize *tempfile and add it to tempfile_list: */
@@ -204,7 +204,7 @@ int xmks_tempfile_m(struct tempfile *tempfile, const char *template, int mode)
 
 FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
 {
-	if (!tempfile->active)
+	if (!is_tempfile_active(tempfile))
 		die("BUG: fdopen_tempfile() called for inactive object");
 	if (tempfile->fp)
 		die("BUG: fdopen_tempfile() called for open object");
@@ -215,21 +215,21 @@ FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
 
 const char *get_tempfile_path(struct tempfile *tempfile)
 {
-	if (!tempfile->active)
+	if (!is_tempfile_active(tempfile))
 		die("BUG: get_tempfile_path() called for inactive object");
 	return tempfile->filename.buf;
 }
 
 int get_tempfile_fd(struct tempfile *tempfile)
 {
-	if (!tempfile->active)
+	if (!is_tempfile_active(tempfile))
 		die("BUG: get_tempfile_fd() called for inactive object");
 	return tempfile->fd;
 }
 
 FILE *get_tempfile_fp(struct tempfile *tempfile)
 {
-	if (!tempfile->active)
+	if (!is_tempfile_active(tempfile))
 		die("BUG: get_tempfile_fp() called for inactive object");
 	return tempfile->fp;
 }
@@ -264,7 +264,7 @@ int reopen_tempfile(struct tempfile *tempfile)
 {
 	if (0 <= tempfile->fd)
 		die("BUG: reopen_tempfile called for an open object");
-	if (!tempfile->active)
+	if (!is_tempfile_active(tempfile))
 		die("BUG: reopen_tempfile called for an inactive object");
 	tempfile->fd = open(tempfile->filename.buf, O_WRONLY);
 	return tempfile->fd;
@@ -272,7 +272,7 @@ int reopen_tempfile(struct tempfile *tempfile)
 
 int rename_tempfile(struct tempfile *tempfile, const char *path)
 {
-	if (!tempfile->active)
+	if (!is_tempfile_active(tempfile))
 		die("BUG: rename_tempfile called for inactive object");
 
 	if (close_tempfile_gently(tempfile)) {
@@ -294,7 +294,7 @@ int rename_tempfile(struct tempfile *tempfile, const char *path)
 
 void delete_tempfile(struct tempfile *tempfile)
 {
-	if (!tempfile->active)
+	if (!is_tempfile_active(tempfile))
 		return;
 
 	close_tempfile_gently(tempfile);
-- 
2.14.1.721.gc5bc1565f1

