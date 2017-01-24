Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5BE20A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdAXAkl (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:40:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:43555 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbdAXAkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:40:41 -0500
Received: (qmail 9580 invoked by uid 109); 24 Jan 2017 00:40:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:40:41 +0000
Received: (qmail 6991 invoked by uid 111); 24 Jan 2017 00:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:41:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:40:38 -0500
Date:   Mon, 23 Jan 2017 19:40:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/12] for_each_alternate_ref: use strbuf for path allocation
Message-ID: <20170124004038.njjevfku4v7kmnh4@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
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
I had thought I was going to need to generate more paths in the
alternate repo, but I ended up not needing to. So this was originally
done to make that easier, but I think it stands on its own as a cleanup.

 transport.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/transport.c b/transport.c
index 6b4b3ed31..594533d88 100644
--- a/transport.c
+++ b/transport.c
@@ -1207,34 +1207,34 @@ struct alternate_refs_data {
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
2.11.0.765.g454d2182f

