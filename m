Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E761F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfAXNMx (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:12:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727798AbfAXNMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:12:53 -0500
Received: (qmail 27504 invoked by uid 109); 24 Jan 2019 13:12:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:12:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28345 invoked by uid 111); 24 Jan 2019 13:12:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:12:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:12:51 -0500
Date:   Thu, 24 Jan 2019 08:12:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 8/8] convert: drop path parameter from actual conversion
 functions
Message-ID: <20190124131250.GH22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The caller is responsible for looking up the attributes,
after which point we no longer care about the path at which
the content is found.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index dafd6db643..d8d7df3353 100644
--- a/convert.c
+++ b/convert.c
@@ -591,7 +591,7 @@ static int crlf_to_git(const struct index_state *istate,
 	return 1;
 }
 
-static int crlf_to_worktree(const char *path, const char *src, size_t len,
+static int crlf_to_worktree(const char *src, size_t len,
 			    struct strbuf *buf, enum crlf_action crlf_action)
 {
 	char *to_free = NULL;
@@ -1091,7 +1091,7 @@ static int count_ident(const char *cp, unsigned long size)
 	return cnt;
 }
 
-static int ident_to_git(const char *path, const char *src, size_t len,
+static int ident_to_git(const char *src, size_t len,
 			struct strbuf *buf, int ident)
 {
 	char *dst, *dollar;
@@ -1135,7 +1135,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static int ident_to_worktree(const char *path, const char *src, size_t len,
+static int ident_to_worktree(const char *src, size_t len,
 			     struct strbuf *buf, int ident)
 {
 	struct object_id oid;
@@ -1416,7 +1416,7 @@ int convert_to_git(const struct index_state *istate,
 			len = dst->len;
 		}
 	}
-	return ret | ident_to_git(path, src, len, dst, ca.ident);
+	return ret | ident_to_git(src, len, dst, ca.ident);
 }
 
 void convert_to_git_filter_fd(const struct index_state *istate,
@@ -1434,7 +1434,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 
 	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
-	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
+	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
 
 static int convert_to_working_tree_internal(const struct index_state *istate,
@@ -1447,7 +1447,7 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 
 	convert_attrs(istate, &ca, path);
 
-	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
+	ret |= ident_to_worktree(src, len, dst, ca.ident);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -1458,7 +1458,7 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 	 * support smudge).  The filters might expect CRLFs.
 	 */
 	if ((ca.drv && (ca.drv->smudge || ca.drv->process)) || !normalizing) {
-		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
+		ret |= crlf_to_worktree(src, len, dst, ca.crlf_action);
 		if (ret) {
 			src = dst->buf;
 			len = dst->len;
-- 
2.20.1.842.g8986705066
