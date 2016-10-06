Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B76207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbcJFQs7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:48:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:53484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754595AbcJFQs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:48:58 -0400
Received: (qmail 22450 invoked by uid 109); 6 Oct 2016 16:48:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 16:48:44 +0000
Received: (qmail 29538 invoked by uid 111); 6 Oct 2016 16:49:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 12:49:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 12:48:42 -0400
Date:   Thu, 6 Oct 2016 12:48:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] files_read_raw_ref: prevent infinite retry loops in
 general
Message-ID: <20161006164842.yzrdigfimzvgkubv@sigill.intra.peff.net>
References: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Limit the number of retries to 3. That should be adequate to
prevent any races, while preventing the possibility of
infinite loops if the logic fails to handle any other
possible error modes correctly.

After the fix in the previous commit, there's no known way
to trigger an infinite loop, but I did manually verify that
this fixes the test in that commit even when the code change
is not applied.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d826557..76e5902 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1353,6 +1353,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	int fd;
 	int ret = -1;
 	int save_errno;
+	int remaining_retries = 3;
 
 	*type = 0;
 	strbuf_reset(&sb_path);
@@ -1373,8 +1374,14 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	 * <-> symlink) between the lstat() and reading, then
 	 * we don't want to report that as an error but rather
 	 * try again starting with the lstat().
+	 *
+	 * We'll keep a count of the retries, though, just to avoid
+	 * any confusing situation sending us into an infinite loop.
 	 */
 
+	if (remaining_retries-- <= 0)
+		goto out;
+
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-- 
2.10.1.506.g904834d
