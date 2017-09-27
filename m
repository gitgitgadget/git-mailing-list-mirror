Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B9920A26
	for <e@80x24.org>; Wed, 27 Sep 2017 06:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbdI0GCY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:02:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:51586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752263AbdI0GCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:02:23 -0400
Received: (qmail 25413 invoked by uid 109); 27 Sep 2017 06:02:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:02:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11484 invoked by uid 111); 27 Sep 2017 06:03:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:03:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:02:21 -0400
Date:   Wed, 27 Sep 2017 02:02:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] worktree: use xsize_t to access file size
Message-ID: <20170927060221.pv27abu7wmogm5dx@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To read the "gitdir" file into memory, we stat the file and
allocate a buffer. But we store the size in an "int", which
may be truncated. We should use a size_t and xsize_t(),
which will detect truncation.

An overflow is unlikely for a "gitdir" file, but it's a good
practice to model.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/worktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index de26849f55..2f4a4ef9cd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -38,7 +38,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
 	char *path;
-	int fd, len;
+	int fd;
+	size_t len;
 
 	if (!is_directory(git_path("worktrees/%s", id))) {
 		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
@@ -56,7 +57,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 			    id, strerror(errno));
 		return 1;
 	}
-	len = st.st_size;
+	len = xsize_t(st.st_size);
 	path = xmallocz(len);
 	read_in_full(fd, path, len);
 	close(fd);
-- 
2.14.2.988.g01c8b37dde

