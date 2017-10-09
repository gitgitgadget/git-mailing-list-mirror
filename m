Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD6020372
	for <e@80x24.org>; Mon,  9 Oct 2017 17:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbdJIRsz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 13:48:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:47276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754018AbdJIRsy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 13:48:54 -0400
Received: (qmail 25532 invoked by uid 109); 9 Oct 2017 17:43:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 17:43:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18774 invoked by uid 111); 9 Oct 2017 17:48:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 13:48:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Oct 2017 13:48:52 -0400
Date:   Mon, 9 Oct 2017 13:48:52 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] write_entry: avoid reading blobs in CE_RETRY case
Message-ID: <20171009174852.32dpy5xh3w3bfn6t@sigill.intra.peff.net>
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When retrying a delayed filter-process request, we don't
need to send the blob to the filter a second time. However,
we read it unconditionally into a buffer, only to later
throw away that buffer. We can make this more efficient by
skipping the read in the first place when it isn't
necessary.

Signed-off-by: Jeff King <peff@peff.net>
---
 entry.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/entry.c b/entry.c
index 637c5958b0..bec51e37a2 100644
--- a/entry.c
+++ b/entry.c
@@ -240,6 +240,7 @@ static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
+	struct delayed_checkout *dco = state->delayed_checkout;
 	int fd, ret, fstat_done = 0;
 	char *new;
 	struct strbuf buf = STRBUF_INIT;
@@ -261,10 +262,19 @@ static int write_entry(struct cache_entry *ce,
 	switch (ce_mode_s_ifmt) {
 	case S_IFREG:
 	case S_IFLNK:
-		new = read_blob_entry(ce, &size);
-		if (!new)
-			return error("unable to read sha1 file of %s (%s)",
-				path, oid_to_hex(&ce->oid));
+		/*
+		 * We do not send the blob in case of a retry, so do not
+		 * bother reading it at all.
+		 */
+		if (ce_mode_s_ifmt == S_IFREG && dco && dco->state == CE_RETRY) {
+			new = NULL;
+			size = 0;
+		} else {
+			new = read_blob_entry(ce, &size);
+			if (!new)
+				return error("unable to read sha1 file of %s (%s)",
+					     path, oid_to_hex(&ce->oid));
+		}
 
 		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
 			ret = symlink(new, path);
@@ -279,14 +289,7 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (ce_mode_s_ifmt == S_IFREG) {
-			struct delayed_checkout *dco = state->delayed_checkout;
 			if (dco && dco->state != CE_NO_DELAY) {
-				/* Do not send the blob in case of a retry. */
-				if (dco->state == CE_RETRY) {
-					free(new);
-					new = NULL;
-					size = 0;
-				}
 				ret = async_convert_to_working_tree(
 					ce->name, new, size, &buf, dco);
 				if (ret && string_list_has_string(&dco->paths, ce->name)) {
-- 
2.15.0.rc0.421.gf5a676fd56

