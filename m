Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB7F20A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdAXAlA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:41:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:43558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdAXAk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:40:59 -0500
Received: (qmail 9590 invoked by uid 109); 24 Jan 2017 00:40:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:40:59 +0000
Received: (qmail 8608 invoked by uid 111); 24 Jan 2017 00:41:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:41:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:40:57 -0500
Date:   Mon, 23 Jan 2017 19:40:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/12] for_each_alternate_ref: pass name/oid instead of ref
 struct
Message-ID: <20170124004057.kmsyguf3ryb4aob5@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
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
index 6b97cbdbe..b9f2c0cc5 100644
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
index 594533d88..983d8fec1 100644
--- a/transport.c
+++ b/transport.c
@@ -1231,7 +1231,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	for (extra = transport_get_remote_refs(transport);
 	     extra;
 	     extra = extra->next)
-		cb->fn(extra, cb->data);
+		cb->fn(extra->name, &extra->old_oid, cb->data);
 	transport_disconnect(transport);
 out:
 	strbuf_release(&path);
diff --git a/transport.h b/transport.h
index 9820f10b8..b7bb07d2c 100644
--- a/transport.h
+++ b/transport.h
@@ -254,6 +254,6 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, unsigned int *reject_reasons);
 
-typedef void alternate_ref_fn(const struct ref *, void *);
+typedef void alternate_ref_fn(const char *refname, const struct object_id *oid, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
 #endif
-- 
2.11.0.765.g454d2182f

