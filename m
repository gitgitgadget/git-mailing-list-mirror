Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC77820281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbdI0GCa (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:02:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:51594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752378AbdI0GC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:02:29 -0400
Received: (qmail 25423 invoked by uid 109); 27 Sep 2017 06:02:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:02:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11489 invoked by uid 111); 27 Sep 2017 06:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:03:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:02:27 -0400
Date:   Wed, 27 Sep 2017 02:02:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] worktree: check the result of read_in_full()
Message-ID: <20170927060226.a7odofrkyueazp34@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We try to read "len" bytes into a buffer and just assume
that it happened correctly. In practice this should usually
be the case, since we just stat'd the file to get the
length.  But we could be fooled by transient errors or by
other processes racily truncating the file.

Let's be more careful. There's a slim chance this could
catch a real error, but it also prevents people and tools
from getting worried while reading the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2f4a4ef9cd..7b9307aa58 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -40,6 +40,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	char *path;
 	int fd;
 	size_t len;
+	ssize_t read_result;
 
 	if (!is_directory(git_path("worktrees/%s", id))) {
 		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
@@ -59,8 +60,24 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	}
 	len = xsize_t(st.st_size);
 	path = xmallocz(len);
-	read_in_full(fd, path, len);
+
+	read_result = read_in_full(fd, path, len);
+	if (read_result < 0) {
+		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
+			    id, strerror(errno));
+		close(fd);
+		free(path);
+		return 1;
+	}
 	close(fd);
+
+	if (read_result != len) {
+		strbuf_addf(reason,
+			    _("Removing worktrees/%s: short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
+			    id, (uintmax_t)len, (uintmax_t)read_result);
+		free(path);
+		return 1;
+	}
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
 	if (!len) {
-- 
2.14.2.988.g01c8b37dde
