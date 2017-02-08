Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D121FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbdBHU7k (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:59:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:51777 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdBHU7j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:59:39 -0500
Received: (qmail 28382 invoked by uid 109); 8 Feb 2017 20:52:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:52:59 +0000
Received: (qmail 6005 invoked by uid 111); 8 Feb 2017 20:53:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:52:57 -0500
Date:   Wed, 8 Feb 2017 15:52:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/11] for_each_alternate_ref: pass name/oid instead of
 ref struct
Message-ID: <20170208205257.5yk4bhwwm6vigpro@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Breaking down the fields in the interface makes it easier to
change the backend of for_each_alternate_ref to something
that doesn't use "struct ref" internally.

The only field that callers actually look at is the oid,
anyway. The refname is kept in the interface as a plausible
thing for future code to want.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c |  6 ++++--
 fetch-pack.c           | 12 ++++++++----
 transport.c            |  2 +-
 transport.h            |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1dbb8a069..d21332d9e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -277,10 +277,12 @@ static int show_one_alternate_sha1(const unsigned char sha1[20], void *unused)
 	return 0;
 }
 
-static void collect_one_alternate_ref(const struct ref *ref, void *data)
+static void collect_one_alternate_ref(const char *refname,
+				      const struct object_id *oid,
+				      void *data)
 {
 	struct sha1_array *sa = data;
-	sha1_array_append(sa, ref->old_oid.hash);
+	sha1_array_append(sa, oid->hash);
 }
 
 static void write_head_info(void)
diff --git a/fetch-pack.c b/fetch-pack.c
index 601f0779a..54f84c573 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -253,9 +253,11 @@ static void send_request(struct fetch_pack_args *args,
 		write_or_die(fd, buf->buf, buf->len);
 }
 
-static void insert_one_alternate_ref(const struct ref *ref, void *unused)
+static void insert_one_alternate_ref(const char *refname,
+				     const struct object_id *oid,
+				     void *unused)
 {
-	rev_list_insert_ref(NULL, ref->old_oid.hash);
+	rev_list_insert_ref(NULL, oid->hash);
 }
 
 #define INITIAL_FLUSH 16
@@ -619,9 +621,11 @@ static void filter_refs(struct fetch_pack_args *args,
 	*refs = newlist;
 }
 
-static void mark_alternate_complete(const struct ref *ref, void *unused)
+static void mark_alternate_complete(const char *refname,
+				    const struct object_id *oid,
+				    void *unused)
 {
-	mark_complete(ref->old_oid.hash);
+	mark_complete(oid->hash);
 }
 
 static int everything_local(struct fetch_pack_args *args,
diff --git a/transport.c b/transport.c
index 6b7847131..c87147046 100644
--- a/transport.c
+++ b/transport.c
@@ -1238,7 +1238,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	for (extra = transport_get_remote_refs(transport);
 	     extra;
 	     extra = extra->next)
-		cb->fn(extra, cb->data);
+		cb->fn(extra->name, &extra->old_oid, cb->data);
 	transport_disconnect(transport);
 out:
 	strbuf_release(&path);
diff --git a/transport.h b/transport.h
index e597b31b3..bc5571574 100644
--- a/transport.h
+++ b/transport.h
@@ -255,6 +255,6 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, unsigned int *reject_reasons);
 
-typedef void alternate_ref_fn(const struct ref *, void *);
+typedef void alternate_ref_fn(const char *refname, const struct object_id *oid, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
 #endif
-- 
2.12.0.rc0.371.ga6cf8653b

