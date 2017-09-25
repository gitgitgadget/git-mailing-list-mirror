Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBB7202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966256AbdIYUah (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:30:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:49610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966250AbdIYUag (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:30:36 -0400
Received: (qmail 2484 invoked by uid 109); 25 Sep 2017 20:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:30:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28531 invoked by uid 111); 25 Sep 2017 20:31:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 16:31:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 16:30:34 -0400
Date:   Mon, 25 Sep 2017 16:30:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] worktree: use xsize_t to access file size
Message-ID: <20170925203033.z4czmuhedm3f54b3@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
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
2.14.1.1148.ga2561536a1

