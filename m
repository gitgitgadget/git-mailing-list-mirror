Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABAB1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdBHU7k (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:59:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:51776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbdBHU7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:59:37 -0500
Received: (qmail 28375 invoked by uid 109); 8 Feb 2017 20:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:52:56 +0000
Received: (qmail 5810 invoked by uid 111); 8 Feb 2017 20:53:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:52:54 -0500
Date:   Wed, 8 Feb 2017 15:52:54 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/11] for_each_alternate_ref: use strbuf for path
 allocation
Message-ID: <20170208205254.d2xzddqmqywxem5s@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a string with ".../objects" pointing to the
alternate object store, and overwrite bits of it to look at
other paths in the (potential) git repository holding it.
This works because the only path we care about is "refs",
which is shorter than "objects".

Using a strbuf to hold the path lets us get rid of some
magic numbers, and makes it more obvious that the memory
operations are safe.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/transport.c b/transport.c
index 6fba9e95b..6b7847131 100644
--- a/transport.c
+++ b/transport.c
@@ -1214,34 +1214,34 @@ struct alternate_refs_data {
 static int refs_from_alternate_cb(struct alternate_object_database *e,
 				  void *data)
 {
-	char *other;
-	size_t len;
+	struct strbuf path = STRBUF_INIT;
+	size_t base_len;
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *extra;
 	struct alternate_refs_data *cb = data;
 
-	other = real_pathdup(e->path);
-	if (!other)
-		return 0;
-	len = strlen(other);
-
-	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
+	if (!strbuf_realpath(&path, e->path, 0))
+		goto out;
+	if (!strbuf_strip_suffix(&path, "/objects"))
 		goto out;
+	base_len = path.len;
+
 	/* Is this a git repository with refs? */
-	memcpy(other + len - 8, "/refs", 6);
-	if (!is_directory(other))
+	strbuf_addstr(&path, "/refs");
+	if (!is_directory(path.buf))
 		goto out;
-	other[len - 8] = '\0';
-	remote = remote_get(other);
-	transport = transport_get(remote, other);
+	strbuf_setlen(&path, base_len);
+
+	remote = remote_get(path.buf);
+	transport = transport_get(remote, path.buf);
 	for (extra = transport_get_remote_refs(transport);
 	     extra;
 	     extra = extra->next)
 		cb->fn(extra, cb->data);
 	transport_disconnect(transport);
 out:
-	free(other);
+	strbuf_release(&path);
 	return 0;
 }
 
-- 
2.12.0.rc0.371.ga6cf8653b

