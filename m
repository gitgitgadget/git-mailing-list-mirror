Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E655B20248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCTIQQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:16:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:57446 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727593AbfCTIQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:16:16 -0400
Received: (qmail 19689 invoked by uid 109); 20 Mar 2019 08:16:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:16:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6381 invoked by uid 111); 20 Mar 2019 08:16:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:16:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:16:14 -0400
Date:   Wed, 20 Mar 2019 04:16:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/13] fetch_pack(): drop unused parameters
Message-ID: <20190320081614.GI10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need the caller of fetch_pack() to pass in "dest", which is the
remote URL. Since ba227857d2 (Reduce the number of connects when
fetching, 2008-02-04), the caller is responsible for calling
git_connect() itself, and our "dest" parameter is unused.

That commit also started passing us the resulting "conn" child_process
from git_connect(). But likewise, we do not need do anything with it.
The descriptors in "fd" are enough for us, and the caller is responsible
for cleaning up "conn".

We can just drop both parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c |  2 +-
 fetch-pack.c         |  3 +--
 fetch-pack.h         |  3 +--
 transport.c          | 10 ++++------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 153a2bd282..dc1485c8aa 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -234,7 +234,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		BUG("unknown protocol version");
 	}
 
-	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
+	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
 			 &shallow, pack_lockfile_ptr, version);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index e69993b2eb..8d67d4e362 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1615,9 +1615,8 @@ static int iterate_ref_map(void *cb_data, struct object_id *oid)
 }
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
-		       int fd[], struct child_process *conn,
+		       int fd[],
 		       const struct ref *ref,
-		       const char *dest,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
 		       char **pack_lockfile,
diff --git a/fetch-pack.h b/fetch-pack.h
index 43ec344d95..67f684229a 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -78,9 +78,8 @@ struct fetch_pack_args {
  * marked as such.
  */
 struct ref *fetch_pack(struct fetch_pack_args *args,
-		       int fd[], struct child_process *conn,
+		       int fd[],
 		       const struct ref *ref,
-		       const char *dest,
 		       struct ref **sought,
 		       int nr_sought,
 		       struct oid_array *shallow,
diff --git a/transport.c b/transport.c
index d0608df5c9..365ea574c7 100644
--- a/transport.c
+++ b/transport.c
@@ -314,7 +314,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
-	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
 
@@ -356,16 +355,16 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	switch (data->version) {
 	case protocol_v2:
-		refs = fetch_pack(&args, data->fd, data->conn,
+		refs = fetch_pack(&args, data->fd,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
-				  dest, to_fetch, nr_heads, &data->shallow,
+				  to_fetch, nr_heads, &data->shallow,
 				  &transport->pack_lockfile, data->version);
 		break;
 	case protocol_v1:
 	case protocol_v0:
-		refs = fetch_pack(&args, data->fd, data->conn,
+		refs = fetch_pack(&args, data->fd,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
-				  dest, to_fetch, nr_heads, &data->shallow,
+				  to_fetch, nr_heads, &data->shallow,
 				  &transport->pack_lockfile, data->version);
 		break;
 	case protocol_unknown_version:
@@ -389,7 +388,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 	free_refs(refs);
-	free(dest);
 	return ret;
 }
 
-- 
2.21.0.701.g4401309e11

